Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C15BEBC9
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiITRWe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiITRWd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 13:22:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA45FAF2;
        Tue, 20 Sep 2022 10:22:31 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e791329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e791:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77AE11EC01CE;
        Tue, 20 Sep 2022 19:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663694545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aTo5BCIIhVWElTta5Q80oaSGkccBfpExJYkW8aRkMUg=;
        b=h6SpxGoxqOkReeKy9bJ79HGdmTMk2Yjva6RO25WmrAtjZo1AoB+MJidyJBwXp/BeOOnC7Z
        Ixn68JdCuXF8cTzPfcEVrxzf/XN9QJFRtqa4e8lYxoDsmMqpVi7mtnBgWZnftDBOK9jcBW
        MmjOAyDN/hmQHkLfZXdgpoIDBezPT+g=
Date:   Tue, 20 Sep 2022 19:22:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Message-ID: <Yyn2zYLP9So0heBW@zn.tnic>
References: <20220912144005.212624-1-justin.he@arm.com>
 <20220912144005.212624-6-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220912144005.212624-6-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 12, 2022 at 02:40:02PM +0000, Jia He wrote:
> Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
> apci_init()") introduced a bug that ghes_edac_register() would be invoked
> before edac_init(). Because at that time, the bus "edac" hadn't been even
> registered, this created sysfs /devices/mc0 instead of
> /sys/devices/system/edac/mc/mc0 on an Ampere eMag server.
> 
> To remove the dependency of ghes_edac on ghes, make it a proper module. Use
> a list to save the probing devices in ghes_probe(), and defer the
> ghes_edac_register() to module_init() of the new ghes_edac module by
> iterating over the devices list.
> 
> The ghes_edac_force_enable check is not needed in ghes_edac_unregister()
> since it has been checked in ghes_edac_init().
> 
> Co-developed-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jia He <justin.he@arm.com>
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Toshi Kani <toshi.kani@hpe.com>
> ---
>  drivers/acpi/apei/ghes.c | 22 +++++++++++++--
>  drivers/edac/Kconfig     |  4 +--
>  drivers/edac/ghes_edac.c | 59 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      | 24 ++++------------
>  4 files changed, 62 insertions(+), 47 deletions(-)

So those last three patches look unnecessarily complex. You don't
need to export ghes_edac_force_enable and you don't need that
ghes_edac_preferred() thing.

IOW, I'd like to see the below split into two patches:

1. Add ghes_get_devices() to ghes.c along with moving the
ghes_edac_force_enable param to ghes.c

2. Add init() and exit() module functions and fixup Kconfig

There's no need for ghes_present - ghes.c has either registered devices
or not.

And ghes_edac is preferred if ghes_get_devices() gives you a list of
devices or not.

IOW, it all boils down to whether the list returned is NULL or not.

HTH.

---
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8cb65f757d06..27c72b175e4b 100644
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
@@ -1378,7 +1388,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	platform_set_drvdata(ghes_dev, ghes);
 
-	ghes_edac_register(ghes, &ghes_dev->dev);
+	ghes->dev = &ghes_dev->dev;
+
+	mutex_lock(&ghes_devs_mutex);
+	list_add_tail(&ghes->elist, &ghes_devs);
+	mutex_unlock(&ghes_devs_mutex);
 
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
@@ -1442,7 +1456,9 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_fini(ghes);
 
-	ghes_edac_unregister(ghes);
+	mutex_lock(&ghes_devs_mutex);
+	list_del(&ghes->elist);
+	mutex_unlock(&ghes_devs_mutex);
 
 	kfree(ghes);
 
@@ -1500,6 +1516,32 @@ void __init acpi_ghes_init(void)
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
index 7b8d56a769f6..8460108e8623 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -54,12 +54,10 @@ static DEFINE_MUTEX(ghes_reg_mutex);
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
-/* "ghes_edac.force_load=1" skips the platform check */
-static bool __read_mostly force_load;
-module_param(force_load, bool, 0);
-
 static bool system_scanned;
 
+static struct list_head *ghes_devs;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -387,34 +385,15 @@ static struct notifier_block ghes_edac_mem_err_nb = {
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
-		if (!force_load && idx < 0)
-			return -ENODEV;
-	} else {
-		force_load = true;
-		idx = 0;
-	}
-
 	/* finish another registration/unregistration instance first */
 	mutex_lock(&ghes_reg_mutex);
 
@@ -458,15 +437,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
@@ -530,14 +504,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	return rc;
 }
 
-void ghes_edac_unregister(struct ghes *ghes)
+static void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
-	if (!force_load)
-		return;
-
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
@@ -566,3 +537,32 @@ void ghes_edac_unregister(struct ghes *ghes)
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
index 5cbd38b6e4e1..2e785d3554d8 100644
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
@@ -69,28 +71,14 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  * @nb: pointer to the notifier_block structure of the vendor record handler.
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
-#endif
-
-int ghes_estatus_pool_init(int num_ghes);
-
-/* From drivers/edac/ghes_edac.c */
-
-#ifdef CONFIG_EDAC_GHES
-int ghes_edac_register(struct ghes *ghes, struct device *dev);
-
-void ghes_edac_unregister(struct ghes *ghes);
 
+struct list_head *ghes_get_devices(void);
 #else
-static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline void ghes_edac_unregister(struct ghes *ghes)
-{
-}
+static inline struct list_head *ghes_get_devices(void) { return NULL; }
 #endif
 
+int ghes_estatus_pool_init(int num_ghes);
+
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
 	return gdata->revision >> 8;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
