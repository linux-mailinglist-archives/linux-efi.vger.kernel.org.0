Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE47A3073
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbjIPNDv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjIPNDj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:39 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC1CC2;
        Sat, 16 Sep 2023 06:03:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36vM_1694869406;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36vM_1694869406)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:28 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, robert.moore@intel.com
Cc:     linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com
Subject: [RFC PATCH 5/9] ACPI: APEI: GHES: Use ERST to serialize APEI generic error before panic
Date:   Sat, 16 Sep 2023 21:03:12 +0800
Message-Id: <20230916130316.65815-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
References: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In certain scenarios (ie. hosts/guests with root filesystems on
NFS/iSCSI where networking software and/or hardware fails, and thus
kdump fails), it is necessary to serialize hardware error information
available for post-mortem debugging.

Save the hardware error log into flash via ERST before go panic, the
hardware error log can be gotten from the flash after system boot
successful again, which is very useful in production.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d14e00751161..16701f889b73 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/pstore.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -636,6 +637,43 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+static int ghes_serialize_estatus(struct acpi_hest_generic_data *gdata, u8 notify_type)
+{
+	void *err = acpi_hest_get_payload(gdata);
+	int data_len = gdata->error_data_length;
+	struct cper_pstore_record *rcd;
+	int record_len = data_len + sizeof(*rcd);
+
+	rcd = kmalloc(record_len, GFP_KERNEL);
+	memset(rcd, 0, sizeof(rcd));
+
+	memcpy(rcd->hdr.signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
+	rcd->hdr.revision = CPER_RECORD_REV;
+	rcd->hdr.signature_end = CPER_SIG_END;
+	rcd->hdr.section_count = 1;
+	rcd->hdr.error_severity = CPER_SEV_FATAL;
+	/* timestamp, platform_id, partition_id are all invalid */
+	rcd->hdr.validation_bits = 0;
+	rcd->hdr.record_length = record_len;
+	rcd->hdr.creator_id = CPER_CREATOR_PSTORE;
+	rcd->hdr.notification_type = CPER_NOTIFY_MCE;
+	rcd->hdr.record_id = cper_next_record_id();
+	rcd->hdr.flags = CPER_HW_ERROR_FLAGS_PREVERR;
+
+	rcd->sec_hdr.section_offset = (void *)&rcd->data - (void *)&rcd;
+	rcd->sec_hdr.section_length = data_len;
+	rcd->sec_hdr.revision = CPER_SEC_REV;
+	/* ->ru_id and fru_text is invalid */
+	rcd->sec_hdr.validation_bits = 0;
+	rcd->sec_hdr.flags = CPER_SEC_PRIMARY;
+	rcd->sec_hdr.section_type = gdata->section_type;
+	rcd->sec_hdr.section_severity = gdata->error_severity;
+
+	memcpy(&rcd->data, err, data_len);
+
+	return erst_write(&rcd->hdr);
+}
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -861,10 +899,16 @@ static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	struct acpi_hest_generic_data *gdata;
+	u8 notify_type = ghes->generic->notify.type;
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
+	apei_estatus_for_each_section(estatus, gdata)
+		ghes_serialize_estatus(gdata, notify_type);
+
 	/* reboot to log the error! */
 	if (!panic_timeout)
 		panic_timeout = ghes_panic_timeout;
-- 
2.41.0

