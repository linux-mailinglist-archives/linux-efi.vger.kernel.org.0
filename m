Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702B7A3072
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjIPNDw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjIPNDl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:41 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79287DD;
        Sat, 16 Sep 2023 06:03:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36wZ_1694869410;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36wZ_1694869410)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:31 +0800
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
Subject: [RFC PATCH 7/9] ACPI: APEI: ESRT: kick ghes_report_chain notifier to report serialized memory errors
Date:   Sat, 16 Sep 2023 21:03:14 +0800
Message-Id: <20230916130316.65815-8-xueshuai@linux.alibaba.com>
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

Introduce a new pstore_record type, PSTORE_TYPE_CPER_MEM, so that
serialized memory errors can be retrieved and saved as a file in pstore
file system. While the serialized errors is retrieved from ERST
backend, kick ghes_report_chain notifier.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 5 +++++
 fs/pstore/platform.c     | 1 +
 include/linux/pstore.h   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index f789e3df73a9..665b8f93dab3 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
 
@@ -1068,6 +1069,10 @@ static ssize_t erst_reader(struct pstore_record *record)
 	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE)) {
 		trace_mce_record((struct mce *)rcd->data);
 		record->type = PSTORE_TYPE_MCE;
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PLATFORM_MEM)) {
+		record->type = PSTORE_TYPE_CPER_MEM;
+		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
+		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e5bca9a004cc..4e63ac8be755 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -51,6 +51,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"cper-mem",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ad44b3baf10e..d18ecaacd1b5 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -40,6 +40,9 @@ enum pstore_type_id {
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
 
+	/* APEI section */
+	PSTORE_TYPE_CPER_MEM		= 9,
+
 	/* End of the list */
 	PSTORE_TYPE_MAX
 };
-- 
2.41.0

