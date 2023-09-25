Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4D7AD21C
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 09:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjIYHox (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjIYHov (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 03:44:51 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB2DA;
        Mon, 25 Sep 2023 00:44:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt-0_1695627876;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt-0_1695627876)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:37 +0800
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
Subject: [RFC PATCH v2 3/9] ACPI: APEI: ERST: Emit the mce_record tracepoint
Date:   Mon, 25 Sep 2023 15:44:20 +0800
Message-Id: <20230925074426.97856-4-xueshuai@linux.alibaba.com>
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

After /dev/mcelog character device deprecated by commit 5de97c9f6d85
("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
serialized hardware error log, a.k.a MCE record, of previous boot in
persistent storage is not collected via APEI ERST.

Emit the mce_record tracepoint so that it can consumed by the new
generation rasdaemon.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 528ac5eb4871..82f57aaf89ad 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -26,6 +26,10 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
+#ifdef CONFIG_X86_MCE
+/* only define CREATE_TRACE_POINTS once */
+#include <trace/events/mce.h>
+#endif
 
 #include "apei-internal.h"
 
@@ -1063,8 +1067,12 @@ static ssize_t erst_reader(struct pstore_record *record)
 		record->compressed = true;
 	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG))
 		record->type = PSTORE_TYPE_DMESG;
-	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE))
+	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE)) {
+#ifdef CONFIG_X86_MCE
+		trace_mce_record((struct mce *)rcd->data);
+#endif
 		record->type = PSTORE_TYPE_MCE;
+	}
 	else
 		record->type = PSTORE_TYPE_MAX;
 
-- 
2.41.0

