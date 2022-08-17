Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C4597145
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiHQOgU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiHQOgC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 10:36:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE8C9BB40;
        Wed, 17 Aug 2022 07:35:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0C015BF;
        Wed, 17 Aug 2022 07:35:53 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 412553F70D;
        Wed, 17 Aug 2022 07:35:46 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        toshi.kani@hpe.com, nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from loading after ghes_edac is registered
Date:   Wed, 17 Aug 2022 14:34:56 +0000
Message-Id: <20220817143458.335938-6-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817143458.335938-1-justin.he@arm.com>
References: <20220817143458.335938-1-justin.he@arm.com>
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

Previous, there is only one edac can be registering in the EDAC core. After
ghes_edac is modularized, the registering of ghes devices may be deferred
when ghes_edac is loaded. Prevent the chipset-specific edac drivers from
loading after ghes_edac is registered, which allow the edac drivers to
get selected in e.g. HPE platform.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
 drivers/edac/amd64_edac.c |  2 +-
 drivers/edac/ghes_edac.c  |  2 ++
 drivers/edac/pnd2_edac.c  |  2 +-
 drivers/edac/sb_edac.c    |  2 +-
 drivers/edac/skx_base.c   |  2 +-
 include/acpi/ghes.h       |  4 ++++
 7 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9c52183e3ad9..9272d963b57d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -95,6 +95,7 @@
 #endif
 
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+static bool devs_registered;
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -1266,6 +1267,18 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+void set_ghes_devs_registered(bool flag)
+{
+	devs_registered = flag;
+}
+EXPORT_SYMBOL_GPL(set_ghes_devs_registered);
+
+bool ghes_devs_registered(void)
+{
+	return devs_registered;
+}
+EXPORT_SYMBOL_GPL(ghes_devs_registered);
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1382,6 +1395,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	platform_set_drvdata(ghes_dev, ghes);
 
 	ghes->dev = &ghes_dev->dev;
+	set_ghes_devs_registered(false);
 
 	mutex_lock(&ghes_devs_mutex);
 	list_add_tail(&ghes->elist, &ghes_devs);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e4eaf6668feb..f48507fa7b94 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4329,7 +4329,7 @@ static int __init amd64_edac_init(void)
 	int err = -ENODEV;
 	int i;
 
-	if (ghes_get_devices(0))
+	if (ghes_get_devices(0) && ghes_devs_registered())
 		return -EBUSY;
 
 	owner = edac_get_owner();
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 3bdf8469882d..d26644b3bc47 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -564,6 +564,7 @@ static int __init ghes_edac_init(void)
 	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
 		ghes_edac_register(g->dev);
 	}
+	set_ghes_devs_registered(true);
 
 	return 0;
 }
@@ -576,6 +577,7 @@ static void __exit ghes_edac_exit(void)
 	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
 		ghes_edac_unregister(g);
 	}
+	set_ghes_devs_registered(false);
 }
 module_exit(ghes_edac_exit);
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 73f2ba0e64e3..66d89d00c4b3 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1528,7 +1528,7 @@ static int __init pnd2_init(void)
 
 	edac_dbg(2, "\n");
 
-	if (ghes_get_devices(0))
+	if (ghes_get_devices(0) && ghes_devs_registered())
 		return -EBUSY;
 
 	owner = edac_get_owner();
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 1d0520a16840..a3a89e366a74 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3506,7 +3506,7 @@ static int __init sbridge_init(void)
 
 	edac_dbg(2, "\n");
 
-	if (ghes_get_devices(0))
+	if (ghes_get_devices(0) && ghes_devs_registered())
 		return -EBUSY;
 
 	owner = edac_get_owner();
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index fe267f8543f5..efa1ae79c35a 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -653,7 +653,7 @@ static int __init skx_init(void)
 
 	edac_dbg(2, "\n");
 
-	if (ghes_get_devices(0))
+	if (ghes_get_devices(0) && ghes_devs_registered())
 		return -EBUSY;
 
 	owner = edac_get_owner();
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 150c0b9500d6..21b9d4d4c3e9 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -72,8 +72,12 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 struct list_head *ghes_get_devices(bool force);
+bool ghes_devs_registered(void);
+void set_ghes_devs_registered(bool flag);
 #else
 static inline struct list_head *ghes_get_devices(bool force) { return NULL; }
+static inline bool ghes_devs_registered(void) { return false; }
+static inline void set_ghes_devs_registered(bool flag) { return; }
 #endif
 
 int ghes_estatus_pool_init(int num_ghes);
-- 
2.25.1

