Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FC7AD214
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjIYHoq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjIYHoo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 03:44:44 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87FFB;
        Mon, 25 Sep 2023 00:44:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvsxu_1695627872;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvsxu_1695627872)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:33 +0800
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
Subject: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type and record struct to common header
Date:   Mon, 25 Sep 2023 15:44:18 +0800
Message-Id: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
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

Move pstore creator id, section type and record struct to the common
header, so that it can be use by MCE and GHES driver.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 19 -------------------
 include/linux/pstore.h   | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..528ac5eb4871 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -997,25 +997,6 @@ static struct pstore_info erst_info = {
 	.erase		= erst_clearer
 };
 
-#define CPER_CREATOR_PSTORE						\
-	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		  0x64, 0x90, 0xb8, 0x9d)
-#define CPER_SECTION_TYPE_DMESG						\
-	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
-		  0x94, 0x19, 0xeb, 0x12)
-#define CPER_SECTION_TYPE_DMESG_Z					\
-	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
-		  0x34, 0xdd, 0xfa, 0xc6)
-#define CPER_SECTION_TYPE_MCE						\
-	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		  0x04, 0x4a, 0x38, 0xfc)
-
-struct cper_pstore_record {
-	struct cper_record_header hdr;
-	struct cper_section_descriptor sec_hdr;
-	char data[];
-} __packed;
-
 static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..ad44b3baf10e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/cper.h>
 
 struct module;
 
@@ -210,6 +211,29 @@ struct pstore_info {
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
 
+#define CPER_CREATOR_PSTORE						\
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
+#define CPER_SECTION_TYPE_DMESG						\
+	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
+		  0x94, 0x19, 0xeb, 0x12)
+#define CPER_SECTION_TYPE_DMESG_Z					\
+	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		  0x34, 0xdd, 0xfa, 0xc6)
+#define CPER_SECTION_TYPE_MCE						\
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
+
+/*
+ * CPER specification (in UEFI specification 2.3 appendix N) requires
+ * byte-packed.
+ */
+struct cper_pstore_record {
+	struct cper_record_header hdr;
+	struct cper_section_descriptor sec_hdr;
+	char data[];
+} __packed;
+
 struct pstore_ftrace_record {
 	unsigned long ip;
 	unsigned long parent_ip;
-- 
2.41.0

