Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109D5EEBED
	for <lists+linux-efi@lfdr.de>; Thu, 29 Sep 2022 04:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiI2Cic (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Sep 2022 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiI2CiM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Sep 2022 22:38:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E72FA125DA9;
        Wed, 28 Sep 2022 19:38:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5022022EE;
        Wed, 28 Sep 2022 19:38:17 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3164C3F73B;
        Wed, 28 Sep 2022 19:38:03 -0700 (PDT)
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
Subject: [PATCH v7 4/8] ghes: Introduce a helper ghes_get_devices()
Date:   Thu, 29 Sep 2022 02:37:22 +0000
Message-Id: <20220929023726.73727-5-justin.he@arm.com>
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

Introduce a helper ghes_get_devices(), which returns the dev list GHES
probed when the platform-check passes on the system.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 37 +++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b0a6445c6da2..cc0588fe20f5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -128,6 +128,9 @@ module_param_named(edac_force_enable, ghes_edac_force_enable, bool, 0);
 static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
+static LIST_HEAD(ghes_devs);
+static DEFINE_MUTEX(ghes_devs_mutex);
+
 /*
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
@@ -1388,6 +1391,10 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
+	mutex_lock(&ghes_devs_mutex);
+	list_add_tail(&ghes->elist, &ghes_devs);
+	mutex_unlock(&ghes_devs_mutex);
+
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
@@ -1452,6 +1459,10 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_edac_unregister(ghes);
 
+	mutex_lock(&ghes_devs_mutex);
+	list_del(&ghes->elist);
+	mutex_unlock(&ghes_devs_mutex);
+
 	kfree(ghes);
 
 	platform_set_drvdata(ghes_dev, NULL);
@@ -1508,6 +1519,32 @@ void __init acpi_ghes_init(void)
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
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 5cbd38b6e4e1..46d9c86199e9 100644
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
@@ -69,6 +71,10 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  * @nb: pointer to the notifier_block structure of the vendor record handler.
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
+
+struct list_head *ghes_get_devices(void);
+#else
+static inline struct list_head *ghes_get_devices(void) { return NULL; }
 #endif
 
 int ghes_estatus_pool_init(int num_ghes);
-- 
2.25.1

