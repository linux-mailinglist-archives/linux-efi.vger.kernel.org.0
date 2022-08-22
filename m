Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549A359C32F
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiHVPmv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiHVPl7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 11:41:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6903F1F2EF;
        Mon, 22 Aug 2022 08:41:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C6FED1;
        Mon, 22 Aug 2022 08:41:57 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C8AF3F70D;
        Mon, 22 Aug 2022 08:41:45 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac drivers when ghes_edac is preferred
Date:   Mon, 22 Aug 2022 15:40:44 +0000
Message-Id: <20220822154048.188253-6-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822154048.188253-1-justin.he@arm.com>
References: <20220822154048.188253-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

edac_mc_add_mc* is too late in the init path and that check should happen
as the very first thing in the driver init function.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c   | 13 +++++++++++--
 drivers/edac/amd64_edac.c  |  3 +++
 drivers/edac/edac_module.h |  1 +
 drivers/edac/i10nm_base.c  |  3 +++
 drivers/edac/igen6_edac.c  |  3 +++
 drivers/edac/pnd2_edac.c   |  3 +++
 drivers/edac/sb_edac.c     |  3 +++
 drivers/edac/skx_base.c    |  3 +++
 include/acpi/ghes.h        |  2 ++
 9 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e17e0ee8f842..327386f3cf33 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1537,16 +1537,25 @@ static struct acpi_platform_list plat_list[] = {
 	{ } /* End */
 };
 
-struct list_head *ghes_get_devices(void)
+bool ghes_edac_preferred(void)
 {
 	int idx = -1;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		idx = acpi_match_platform_list(plat_list);
 		if (idx < 0 && !ghes_edac_force)
-			return NULL;
+			return false;
 	}
 
+	return true;
+}
+EXPORT_SYMBOL_GPL(ghes_edac_preferred);
+
+struct list_head *ghes_get_devices(void)
+{
+	if (!ghes_edac_preferred())
+		return NULL;
+
 	return &ghes_devs;
 }
 EXPORT_SYMBOL_GPL(ghes_get_devices);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..5314a934c2bf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4329,6 +4329,9 @@ static int __init amd64_edac_init(void)
 	int err = -ENODEV;
 	int i;
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 96f6de0c8ff6..3826f82de487 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -11,6 +11,7 @@
 #ifndef	__EDAC_MODULE_H__
 #define	__EDAC_MODULE_H__
 
+#include <acpi/ghes.h>
 #include "edac_mc.h"
 #include "edac_pci.h"
 #include "edac_device.h"
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 6cf50ee0b77c..691df9b51622 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -548,6 +548,9 @@ static int __init i10nm_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index a07bbfd075d0..4ac6d0c533ec 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1271,6 +1271,9 @@ static int __init igen6_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -ENODEV;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index a20b299f1202..4ddc43e6c420 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1528,6 +1528,9 @@ static int __init pnd2_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 9678ab97c7ac..3ff604a5e95a 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3506,6 +3506,9 @@ static int __init sbridge_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 1abc020d49ab..286370728552 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -653,6 +653,9 @@ static int __init skx_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index e29327ee0b83..1c47018a1e43 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -73,9 +73,11 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
 struct list_head *ghes_get_devices(void);
+bool ghes_edac_preferred(void);
 extern bool ghes_edac_force;
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
+static bool ghes_edac_preferred(void) { return false; }
 static bool ghes_edac_force;
 #endif
 
-- 
2.25.1

