Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05F15EEBF2
	for <lists+linux-efi@lfdr.de>; Thu, 29 Sep 2022 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiI2Cim (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Sep 2022 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiI2CiT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Sep 2022 22:38:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBD9E11DFEB;
        Wed, 28 Sep 2022 19:38:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4551480;
        Wed, 28 Sep 2022 19:38:24 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 312DD3F73B;
        Wed, 28 Sep 2022 19:38:10 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
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
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v7 5/8] EDAC/ghes: Make ghes_edac a proper module to remove the dependency on ghes
Date:   Thu, 29 Sep 2022 02:37:23 +0000
Message-Id: <20220929023726.73727-6-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023726.73727-1-justin.he@arm.com>
References: <20220929023726.73727-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
apci_init()") introduced a bug that ghes_edac_register() would be invoked
before edac_init(). Because at that time, the bus "edac" hadn't been even
registered, this created sysfs /devices/mc0 instead of
/sys/devices/system/edac/mc/mc0 on an Ampere eMag server.

To remove the dependency of ghes_edac on ghes, make it a proper module. Use
a list to save the probing devices in ghes_probe(), and defer the
ghes_edac_register() to module_init() of the new ghes_edac module by
iterating over the devices list.

The ghes_edac_force_enable check is not needed in ghes_edac_unregister()
since it has been checked in ghes_edac_init().

Co-developed-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/acpi/apei/ghes.c |  4 +--
 drivers/edac/Kconfig     |  4 +--
 drivers/edac/ghes_edac.c | 64 ++++++++++++++++++++++++----------------
 include/acpi/ghes.h      | 18 -----------
 4 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cc0588fe20f5..11a503f2260d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1389,7 +1389,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	platform_set_drvdata(ghes_dev, ghes);
 
-	ghes_edac_register(ghes, &ghes_dev->dev);
+	ghes->dev = &ghes_dev->dev;
 
 	mutex_lock(&ghes_devs_mutex);
 	list_add_tail(&ghes->elist, &ghes_devs);
@@ -1457,8 +1457,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_fini(ghes);
 
-	ghes_edac_unregister(ghes);
-
 	mutex_lock(&ghes_devs_mutex);
 	list_del(&ghes->elist);
 	mutex_unlock(&ghes_devs_mutex);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..df45db81858b 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -53,8 +53,8 @@ config EDAC_DECODE_MCE
 	  has been initialized.
 
 config EDAC_GHES
-	bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
-	depends on ACPI_APEI_GHES && (EDAC=y)
+	tristate "Output ACPI APEI/GHES BIOS detected errors via EDAC"
+	depends on ACPI_APEI_GHES
 	select UEFI_CPER
 	help
 	  Not all machines support hardware-driven error report. Some of those
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 11a1b5e7e484..3d50e624ca07 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -56,6 +56,8 @@ static DEFINE_SPINLOCK(ghes_lock);
 
 static bool system_scanned;
 
+static struct list_head *ghes_devs;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -383,34 +385,15 @@ static struct notifier_block ghes_edac_mem_err_nb = {
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
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static int ghes_edac_register(struct device *dev)
 {
 	bool fake = false;
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	unsigned long flags;
-	int idx = -1;
 	int rc = 0;
 
-	if (IS_ENABLED(CONFIG_X86)) {
-		/* Check if safe to enable on this system */
-		idx = acpi_match_platform_list(plat_list);
-		if (!ghes_edac_force_enable && idx < 0)
-			return -ENODEV;
-	} else {
-		ghes_edac_force_enable = true;
-		idx = 0;
-	}
-
 	/* finish another registration/unregistration instance first */
 	mutex_lock(&ghes_reg_mutex);
 
@@ -454,7 +437,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
 		pr_info("work on such system. Use this driver with caution\n");
-	} else if (idx < 0) {
+	} else if (ghes_edac_force_enable) {
 		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
@@ -526,14 +509,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	return rc;
 }
 
-void ghes_edac_unregister(struct ghes *ghes)
+static void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
-	if (!ghes_edac_force_enable)
-		return;
-
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
@@ -562,3 +542,37 @@ void ghes_edac_unregister(struct ghes *ghes)
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
+
+static int __init ghes_edac_init(void)
+{
+	struct ghes *g, *g_tmp;
+
+	ghes_devs = ghes_get_devices();
+	if (!ghes_devs)
+		return -ENODEV;
+
+	if (list_empty(ghes_devs)) {
+		pr_info("GHES probing device list is empty");
+		return -ENODEV;
+	}
+
+	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
+		ghes_edac_register(g->dev);
+	}
+
+	return 0;
+}
+module_init(ghes_edac_init);
+
+static void __exit ghes_edac_exit(void)
+{
+	struct ghes *g, *g_tmp;
+
+	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
+		ghes_edac_unregister(g);
+	}
+}
+module_exit(ghes_edac_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Output ACPI APEI/GHES BIOS detected errors module via EDAC");
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 46d9c86199e9..2e785d3554d8 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -79,24 +79,6 @@ static inline struct list_head *ghes_get_devices(void) { return NULL; }
 
 int ghes_estatus_pool_init(int num_ghes);
 
-/* From drivers/edac/ghes_edac.c */
-
-#ifdef CONFIG_EDAC_GHES
-int ghes_edac_register(struct ghes *ghes, struct device *dev);
-
-void ghes_edac_unregister(struct ghes *ghes);
-
-#else
-static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline void ghes_edac_unregister(struct ghes *ghes)
-{
-}
-#endif
-
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
 	return gdata->revision >> 8;
-- 
2.25.1

