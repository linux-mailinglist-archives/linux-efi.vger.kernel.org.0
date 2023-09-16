Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9A7A3066
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjIPNDt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIPNDc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:32 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B111B2;
        Sat, 16 Sep 2023 06:03:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36tz_1694869402;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36tz_1694869402)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:23 +0800
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
Subject: [RFC PATCH 2/9] ACPI: APEI: Use common ERST struct to read/write serialized MCE record
Date:   Sat, 16 Sep 2023 21:03:09 +0800
Message-Id: <20230916130316.65815-3-xueshuai@linux.alibaba.com>
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

It is confusing to define two creator IDs with the same GUID number, and
unnecessary to define the same data structure twice.

Use common ERST struct to read/write MCE record.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 82 +++++++++++++++-------------------
 1 file changed, 35 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed341714686..f5739f13e583 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/cper.h>
+#include <linux/pstore.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <asm/mce.h>
@@ -124,58 +125,45 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	return 0;
 }
 
-#define CPER_CREATOR_MCE						\
-	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		  0x64, 0x90, 0xb8, 0x9d)
-#define CPER_SECTION_TYPE_MCE						\
-	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		  0x04, 0x4a, 0x38, 0xfc)
-
-/*
- * CPER specification (in UEFI specification 2.3 appendix N) requires
- * byte-packed.
- */
-struct cper_mce_record {
-	struct cper_record_header hdr;
-	struct cper_section_descriptor sec_hdr;
-	struct mce mce;
-} __packed;
-
 int apei_write_mce(struct mce *m)
 {
-	struct cper_mce_record rcd;
-
-	memset(&rcd, 0, sizeof(rcd));
-	memcpy(rcd.hdr.signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
-	rcd.hdr.revision = CPER_RECORD_REV;
-	rcd.hdr.signature_end = CPER_SIG_END;
-	rcd.hdr.section_count = 1;
-	rcd.hdr.error_severity = CPER_SEV_FATAL;
+	struct cper_pstore_record *rcd;
+	int record_len = sizeof(*m) + sizeof(*rcd);
+	int data_len = sizeof(*m);
+
+	rcd = kmalloc(record_len, GFP_KERNEL);
+	memset(rcd, 0, sizeof(rcd));
+
+	memcpy(rcd->hdr.signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
+	rcd->hdr.revision = CPER_RECORD_REV;
+	rcd->hdr.signature_end = CPER_SIG_END;
+	rcd->hdr.section_count = 1;
+	rcd->hdr.error_severity = CPER_SEV_FATAL;
 	/* timestamp, platform_id, partition_id are all invalid */
-	rcd.hdr.validation_bits = 0;
-	rcd.hdr.record_length = sizeof(rcd);
-	rcd.hdr.creator_id = CPER_CREATOR_MCE;
-	rcd.hdr.notification_type = CPER_NOTIFY_MCE;
-	rcd.hdr.record_id = cper_next_record_id();
-	rcd.hdr.flags = CPER_HW_ERROR_FLAGS_PREVERR;
-
-	rcd.sec_hdr.section_offset = (void *)&rcd.mce - (void *)&rcd;
-	rcd.sec_hdr.section_length = sizeof(rcd.mce);
-	rcd.sec_hdr.revision = CPER_SEC_REV;
-	/* fru_id and fru_text is invalid */
-	rcd.sec_hdr.validation_bits = 0;
-	rcd.sec_hdr.flags = CPER_SEC_PRIMARY;
-	rcd.sec_hdr.section_type = CPER_SECTION_TYPE_MCE;
-	rcd.sec_hdr.section_severity = CPER_SEV_FATAL;
-
-	memcpy(&rcd.mce, m, sizeof(*m));
-
-	return erst_write(&rcd.hdr);
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
+	rcd->sec_hdr.section_type = CPER_SECTION_TYPE_MCE;
+	rcd->sec_hdr.section_severity = CPER_SEV_FATAL;
+
+	memcpy(rcd->data, m, data_len);
+
+	return erst_write(&rcd->hdr);
 }
 
 ssize_t apei_read_mce(struct mce *m, u64 *record_id)
 {
-	struct cper_mce_record rcd;
+	struct cper_pstore_record rcd;
 	int rc, pos;
 
 	rc = erst_get_record_id_begin(&pos);
@@ -189,14 +177,14 @@ ssize_t apei_read_mce(struct mce *m, u64 *record_id)
 	if (*record_id == APEI_ERST_INVALID_RECORD_ID)
 		goto out;
 	rc = erst_read_record(*record_id, &rcd.hdr, sizeof(rcd), sizeof(rcd),
-			&CPER_CREATOR_MCE);
+			&CPER_CREATOR_PSTORE);
 	/* someone else has cleared the record, try next one */
 	if (rc == -ENOENT)
 		goto retry;
 	else if (rc < 0)
 		goto out;
 
-	memcpy(m, &rcd.mce, sizeof(*m));
+	memcpy(m, &rcd.data, sizeof(*m));
 	rc = sizeof(*m);
 out:
 	erst_get_record_id_end();
-- 
2.41.0

