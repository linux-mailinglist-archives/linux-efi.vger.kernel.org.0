Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD175AD665
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiIEP0T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiIEPZd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 11:25:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2F28248CB;
        Mon,  5 Sep 2022 08:25:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DABF4ED1;
        Mon,  5 Sep 2022 08:25:37 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30A1C3F534;
        Mon,  5 Sep 2022 08:25:24 -0700 (PDT)
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
Subject: [PATCH v5 4/8] ghes: Introduce a helper ghes_edac_preferred()
Date:   Mon,  5 Sep 2022 15:24:35 +0000
Message-Id: <20220905152439.77770-5-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905152439.77770-1-justin.he@arm.com>
References: <20220905152439.77770-1-justin.he@arm.com>
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

Introduce a helper ghes_edac_preferred(), which returns true when ACPI GHES
table is present and the platform-check passes on the system. ghes_present
is set once in ghes_probe() since ACPI GHES table is static.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++++++++
 include/acpi/ghes.h      |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b0a6445c6da2..0c2dbfffe22a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -117,6 +117,8 @@ bool ghes_edac_force_enable;
 EXPORT_SYMBOL(ghes_edac_force_enable);
 module_param_named(edac_force_enable, ghes_edac_force_enable, bool, 0);
 
+static bool ghes_present;
+
 /*
  * All error sources notified with HED (Hardware Error Device) share a
  * single notifier callback, so they need to be linked and checked one
@@ -1388,6 +1390,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
+	ghes_present = true;
+
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
@@ -1508,6 +1512,31 @@ void __init acpi_ghes_init(void)
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
+bool ghes_edac_preferred(void)
+{
+	int idx = -1;
+
+	if (!ghes_present)
+		return false;
+
+	if (IS_ENABLED(CONFIG_X86)) {
+		idx = acpi_match_platform_list(plat_list);
+		if (idx < 0 && !ghes_edac_force_enable)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ghes_edac_preferred);
+
 void ghes_register_report_chain(struct notifier_block *nb)
 {
 	atomic_notifier_chain_register(&ghes_report_chain, nb);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 5cbd38b6e4e1..7ce91c0ff3eb 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -80,6 +80,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev);
 
 void ghes_edac_unregister(struct ghes *ghes);
 
+bool ghes_edac_preferred(void);
 #else
 static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
@@ -89,6 +90,7 @@ static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
 static inline void ghes_edac_unregister(struct ghes *ghes)
 {
 }
+static bool ghes_edac_preferred(void) { return false; }
 #endif
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
-- 
2.25.1

