Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29A7A306A
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjIPNDu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjIPNDj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:39 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DC1B2;
        Sat, 16 Sep 2023 06:03:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36ut_1694869405;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36ut_1694869405)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:26 +0800
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
Subject: [RFC PATCH 4/9] ACPI: tables: change section_type of generic error data as guid_t
Date:   Sat, 16 Sep 2023 21:03:11 +0800
Message-Id: <20230916130316.65815-5-xueshuai@linux.alibaba.com>
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

The section_type of generic error data is now an array of u8. It is a
burden to perform explicit type casting from u8[] to guid_t, and to copy
the guid_t values to u8[] using memcpy.

To alleviate this issue, change the section_type from an array to the
type guid_t, which is also consistent with the cper_section_descriptor.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/acpi_extlog.c  | 2 +-
 drivers/acpi/apei/ghes.c    | 2 +-
 drivers/firmware/efi/cper.c | 2 +-
 include/acpi/actbl1.h       | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eae..d46435792d64 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -170,7 +170,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			fru_text = gdata->fru_text;
 		else
 			fru_text = "";
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da..d14e00751161 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -648,7 +648,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..a2ba70aa928f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -527,7 +527,7 @@ static void
 cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
 			   int sec_no)
 {
-	guid_t *sec_type = (guid_t *)gdata->section_type;
+	guid_t *sec_type = &gdata->section_type;
 	__u16 severity;
 	char newpfx[64];
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..ab25a8495a43 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -19,6 +19,7 @@
  *
  ******************************************************************************/
 
+#include <linux/uuid.h>
 /*
  * Values for description table header signatures for tables defined in this
  * file. Useful because they make it more difficult to inadvertently type in
@@ -1637,7 +1638,7 @@ struct acpi_hest_generic_status {
 /* Generic Error Data entry */
 
 struct acpi_hest_generic_data {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
@@ -1650,7 +1651,7 @@ struct acpi_hest_generic_data {
 /* Extension for revision 0x0300 */
 
 struct acpi_hest_generic_data_v300 {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
-- 
2.41.0

