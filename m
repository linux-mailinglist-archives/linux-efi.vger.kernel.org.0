Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9567A306E
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbjIPNDu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjIPNDe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3251B2;
        Sat, 16 Sep 2023 06:03:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36uP_1694869403;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36uP_1694869403)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:24 +0800
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
Subject: [RFC PATCH 3/9] ACPI: APEI: ERST: Emit the mce_record tracepoint
Date:   Sat, 16 Sep 2023 21:03:10 +0800
Message-Id: <20230916130316.65815-4-xueshuai@linux.alibaba.com>
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

After /dev/mcelog character device deprecated by commit 5de97c9f6d85
("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
serialized hardware error log, a.k.a MCE record, of previous boot in
persistent storage is not collected via APEI ERST.

Emit the mce_record tracepoint so that it can consumed by the new
generation rasdaemon.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 528ac5eb4871..f789e3df73a9 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -26,6 +26,8 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
+/* only define CREATE_TRACE_POINTS once */
+#include <trace/events/mce.h>
 
 #include "apei-internal.h"
 
@@ -1063,8 +1065,10 @@ static ssize_t erst_reader(struct pstore_record *record)
 		record->compressed = true;
 	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG))
 		record->type = PSTORE_TYPE_DMESG;
-	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE))
+	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE)) {
+		trace_mce_record((struct mce *)rcd->data);
 		record->type = PSTORE_TYPE_MCE;
+	}
 	else
 		record->type = PSTORE_TYPE_MAX;
 
-- 
2.41.0

