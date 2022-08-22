Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8391359C322
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiHVPme (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiHVPls (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 11:41:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA971EEF3;
        Mon, 22 Aug 2022 08:41:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E823ED1;
        Mon, 22 Aug 2022 08:41:48 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6049E3F70D;
        Mon, 22 Aug 2022 08:41:36 -0700 (PDT)
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
Subject: [RESEND PATCH v3 4/9] EDAC/ghes: Move ghes_edac.force_load to setup parameter
Date:   Mon, 22 Aug 2022 15:40:43 +0000
Message-Id: <20220822154048.188253-5-justin.he@arm.com>
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

ghes_edac_init() is too late to set this module flag ghes_edac.force_load.
Also, other edac drivers should not be able to control this flag.

Move this flag to setup parameter in ghes.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/acpi/apei/ghes.c                      | 24 +++++++++++-
 drivers/edac/ghes_edac.c                      | 38 +++++++------------
 include/acpi/ghes.h                           |  7 +++-
 4 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7f30902fda0..a5f0ee0d7727 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1593,6 +1593,11 @@
 			When zero, profiling data is discarded and associated
 			debugfs files are removed at module unload time.
 
+	ghes_edac_force= [X86] Skip the platform check and forcibly load the
+			ghes_edac modules.
+			Format: <bool>
+			default: false (0)
+
 	goldfish	[X86] Enable the goldfish android emulator platform.
 			Don't use this when you are not running on the
 			android emulator
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9c52183e3ad9..e17e0ee8f842 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -94,6 +94,26 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+/*
+ * "ghes_edac_force=1" forcibly loads ghes_edac and skips the platform
+ * check.
+ */
+bool __read_mostly ghes_edac_force;
+EXPORT_SYMBOL(ghes_edac_force);
+
+static int __init setup_ghes_edac_load(char *str)
+{
+	if (str)
+		if (!strcmp("true", str) || !strcmp("1", str))
+			ghes_edac_force = true;
+
+	if (!IS_ENABLED(CONFIG_X86))
+		ghes_edac_force = true;
+
+	return 1;
+}
+__setup("ghes_edac_force=", setup_ghes_edac_load);
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1517,13 +1537,13 @@ static struct acpi_platform_list plat_list[] = {
 	{ } /* End */
 };
 
-struct list_head *ghes_get_devices(bool force)
+struct list_head *ghes_get_devices(void)
 {
 	int idx = -1;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		idx = acpi_match_platform_list(plat_list);
-		if (idx < 0 && !force)
+		if (idx < 0 && !ghes_edac_force)
 			return NULL;
 	}
 
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index bb3ea42ba70b..6a2b54cc7240 100644
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
 
 static struct list_head *ghes_devs;
@@ -437,23 +433,12 @@ static int ghes_edac_register(struct device *dev)
 	mci->ctl_name = "ghes_edac";
 	mci->dev_name = "ghes";
 
-	if (fake) {
-		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
-		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
-		pr_info("work on such system. Use this driver with caution\n");
-	} else if (force_load) {
-		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
-		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
-		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
-		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
-		pr_info("to correct its BIOS.\n");
-		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
-	}
-
 	if (!fake) {
 		struct dimm_info *src, *dst;
 		int i = 0;
 
+		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
+
 		mci_for_each_dimm(mci, dst) {
 			src = &ghes_hw.dimms[i];
 
@@ -478,6 +463,17 @@ static int ghes_edac_register(struct device *dev)
 	} else {
 		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
 
+		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
+		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
+		pr_info("work on such system. Use this driver with caution\n");
+
+		if (ghes_edac_force) {
+			pr_info("This EDAC driver relies on BIOS to enumerate memory and get\n");
+			pr_info("error reports. Unfortunately, not all BIOSes reflect the\n");
+			pr_info("memory layout correctly. If you find incorrect reports, please\n");
+			pr_info("contact your hardware vendor for its in correct BIOS.\n");
+		}
+
 		dimm->nr_pages = 1;
 		dimm->grain = 128;
 		dimm->mtype = MEM_UNKNOWN;
@@ -518,9 +514,6 @@ static void ghes_edac_unregister(struct ghes *ghes)
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
-	if (!force_load)
-		return;
-
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
@@ -554,10 +547,7 @@ static int __init ghes_edac_init(void)
 {
 	struct ghes *g, *g_tmp;
 
-	if (!IS_ENABLED(CONFIG_X86))
-		force_load = true;
-
-	ghes_devs = ghes_get_devices(force_load);
+	ghes_devs = ghes_get_devices();
 	if (!ghes_devs)
 		return -ENODEV;
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 150c0b9500d6..e29327ee0b83 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,9 +71,12 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  * @nb: pointer to the notifier_block structure of the vendor record handler.
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
-struct list_head *ghes_get_devices(bool force);
+
+struct list_head *ghes_get_devices(void);
+extern bool ghes_edac_force;
 #else
-static inline struct list_head *ghes_get_devices(bool force) { return NULL; }
+static inline struct list_head *ghes_get_devices(void) { return NULL; }
+static bool ghes_edac_force;
 #endif
 
 int ghes_estatus_pool_init(int num_ghes);
-- 
2.25.1

