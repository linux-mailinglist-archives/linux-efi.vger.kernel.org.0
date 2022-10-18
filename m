Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A926026D1
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJRI16 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 04:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJRI1m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 04:27:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76D4A9B846;
        Tue, 18 Oct 2022 01:27:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B88F113E;
        Tue, 18 Oct 2022 01:27:39 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B09743F7D8;
        Tue, 18 Oct 2022 01:27:26 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Jia He <justin.he@arm.com>
Subject: [PATCH v10 3/7] EDAC/ghes: Prepare to make ghes_edac a proper module
Date:   Tue, 18 Oct 2022 08:22:10 +0000
Message-Id: <20221018082214.569504-4-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018082214.569504-1-justin.he@arm.com>
References: <20221018082214.569504-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To make ghes_edac a proper module, prepare to decouple its dependencies
on ghes.

ghes_edac_register() is too late to set module flag ghes_edac.force_load.
Also, other edac drivers should not be able to control this flag. Move this
flag to the module parameter in ghes and make it static.

Introduce a helper ghes_get_devices(), which returns the dev list GHES
probed when the platform-check passes on the system.

The previous force_load check is not needed in ghes_edac_unregister()
since it will be checked in module_init of ghes_edac later.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 46 ++++++++++++++++++++++++++++++++++++++++
 drivers/edac/ghes_edac.c | 35 ++----------------------------
 include/acpi/ghes.h      |  6 ++++++
 3 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8cb65f757d06..6a0dcb8c0901 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -109,6 +109,13 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 bool ghes_disable;
 module_param_named(disable, ghes_disable, bool, 0);
 
+/*
+ * "ghes.edac_force_enable" forcibly enables ghes_edac and skips the platform
+ * check.
+ */
+static bool ghes_edac_force_enable;
+module_param_named(edac_force_enable, ghes_edac_force_enable, bool, 0);
+
 /*
  * All error sources notified with HED (Hardware Error Device) share a
  * single notifier callback, so they need to be linked and checked one
@@ -120,6 +127,9 @@ module_param_named(disable, ghes_disable, bool, 0);
 static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
+static LIST_HEAD(ghes_devs);
+static DEFINE_MUTEX(ghes_devs_mutex);
+
 /*
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
@@ -1380,6 +1390,12 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
+	ghes->dev = &ghes_dev->dev;
+
+	mutex_lock(&ghes_devs_mutex);
+	list_add_tail(&ghes->elist, &ghes_devs);
+	mutex_unlock(&ghes_devs_mutex);
+
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
@@ -1444,6 +1460,10 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_edac_unregister(ghes);
 
+	mutex_lock(&ghes_devs_mutex);
+	list_del(&ghes->elist);
+	mutex_unlock(&ghes_devs_mutex);
+
 	kfree(ghes);
 
 	platform_set_drvdata(ghes_dev, NULL);
@@ -1500,6 +1520,32 @@ void __init acpi_ghes_init(void)
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
 }
 
+/*
+ * Known x86 systems that prefer GHES error reporting:
+ */
+static struct acpi_platform_list plat_list[] = {
+	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
+	{ } /* End */
+};
+
+struct list_head *ghes_get_devices(void)
+{
+	int idx = -1;
+
+	if (IS_ENABLED(CONFIG_X86)) {
+		idx = acpi_match_platform_list(plat_list);
+		if (idx < 0) {
+			if (!ghes_edac_force_enable)
+				return NULL;
+
+			pr_warn_once("Force-loading ghes_edac on an unsupported platform. You're on your own!\n");
+		}
+	}
+
+	return &ghes_devs;
+}
+EXPORT_SYMBOL_GPL(ghes_get_devices);
+
 void ghes_register_report_chain(struct notifier_block *nb)
 {
 	atomic_notifier_chain_register(&ghes_report_chain, nb);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7b8d56a769f6..b85a545d1cb0 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -54,10 +54,6 @@ static DEFINE_MUTEX(ghes_reg_mutex);
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
-/* "ghes_edac.force_load=1" skips the platform check */
-static bool __read_mostly force_load;
-module_param(force_load, bool, 0);
-
 static bool system_scanned;
 
 /* Memory Device - Type 17 of SMBIOS spec */
@@ -387,14 +383,6 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 	.priority	= 0,
 };
 
-/*
- * Known systems that are safe to enable this module.
- */
-static struct acpi_platform_list plat_list[] = {
-	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
-	{ } /* End */
-};
-
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake = false;
@@ -402,19 +390,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	unsigned long flags;
-	int idx = -1;
 	int rc = 0;
 
-	if (IS_ENABLED(CONFIG_X86)) {
-		/* Check if safe to enable on this system */
-		idx = acpi_match_platform_list(plat_list);
-		if (!force_load && idx < 0)
-			return -ENODEV;
-	} else {
-		force_load = true;
-		idx = 0;
-	}
-
 	/* finish another registration/unregistration instance first */
 	mutex_lock(&ghes_reg_mutex);
 
@@ -458,15 +435,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
 		pr_info("work on such system. Use this driver with caution\n");
-	} else if (idx < 0) {
-		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
-		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
-		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
-		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
-		pr_info("to correct its BIOS.\n");
-		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
 	}
 
+	pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
+
 	if (!fake) {
 		struct dimm_info *src, *dst;
 		int i = 0;
@@ -535,9 +507,6 @@ void ghes_edac_unregister(struct ghes *ghes)
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
-	if (!force_load)
-		return;
-
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 5cbd38b6e4e1..ce693e9f07a0 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -27,6 +27,8 @@ struct ghes {
 		struct timer_list timer;
 		unsigned int irq;
 	};
+	struct device *dev;
+	struct list_head elist;
 };
 
 struct ghes_estatus_node {
@@ -80,6 +82,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev);
 
 void ghes_edac_unregister(struct ghes *ghes);
 
+struct list_head *ghes_get_devices(void);
+
 #else
 static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
@@ -89,6 +93,8 @@ static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
 static inline void ghes_edac_unregister(struct ghes *ghes)
 {
 }
+
+static inline struct list_head *ghes_get_devices(void) { return NULL; }
 #endif
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
-- 
2.25.1

