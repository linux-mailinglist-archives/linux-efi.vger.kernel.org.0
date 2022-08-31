Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61DB5A77C0
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiHaHl6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Aug 2022 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiHaHlV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 Aug 2022 03:41:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A82BA9D5;
        Wed, 31 Aug 2022 00:41:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0C1CED1;
        Wed, 31 Aug 2022 00:41:11 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A2873F766;
        Wed, 31 Aug 2022 00:41:27 -0700 (PDT)
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
Subject: [PATCH v4 2/8] EDAC/ghes: Add a notifier for reporting memory errors
Date:   Wed, 31 Aug 2022 07:40:21 +0000
Message-Id: <20220831074027.13849-3-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831074027.13849-1-justin.he@arm.com>
References: <20220831074027.13849-1-justin.he@arm.com>
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

To make a proper module, add a notifier for reporting memory errors. Use
an atomic notifier because calls sites like ghes_proc_in_irq() run in
interrupt context.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 16 +++++++++++++++-
 drivers/edac/ghes_edac.c | 19 +++++++++++++++++--
 include/acpi/ghes.h      | 10 +++-------
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..8cb65f757d06 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -94,6 +94,8 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -645,7 +647,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
-			ghes_edac_report_mem_error(sev, mem_err);
+			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev);
@@ -1497,3 +1499,15 @@ void __init acpi_ghes_init(void)
 	else
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
 }
+
+void ghes_register_report_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&ghes_report_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_report_chain);
+
+void ghes_unregister_report_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index c8fa7dcfdbd0..7b8d56a769f6 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include "edac_module.h"
 #include <ras/ras_event.h>
+#include <linux/notifier.h>
 
 #define OTHER_DETAIL_LEN	400
 
@@ -267,11 +268,14 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
 	return n;
 }
 
-void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
+static int ghes_edac_report_mem_error(struct notifier_block *nb,
+				      unsigned long val, void *data)
 {
+	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
 	struct cper_mem_err_compact cmem;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
+	unsigned long sev = val;
 	struct ghes_pvt *pvt;
 	unsigned long flags;
 	char *p;
@@ -282,7 +286,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	 * know.
 	 */
 	if (WARN_ON_ONCE(in_nmi()))
-		return;
+		return NOTIFY_OK;
 
 	spin_lock_irqsave(&ghes_lock, flags);
 
@@ -374,8 +378,15 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return NOTIFY_OK;
 }
 
+static struct notifier_block ghes_edac_mem_err_nb = {
+	.notifier_call	= ghes_edac_report_mem_error,
+	.priority	= 0,
+};
+
 /*
  * Known systems that are safe to enable this module.
  */
@@ -503,6 +514,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	ghes_pvt = pvt;
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
+	ghes_register_report_chain(&ghes_edac_mem_err_nb);
+
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
@@ -548,6 +561,8 @@ void ghes_edac_unregister(struct ghes *ghes)
 	if (mci)
 		edac_mc_free(mci);
 
+	ghes_unregister_report_chain(&ghes_edac_mem_err_nb);
+
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..5cbd38b6e4e1 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -76,18 +76,11 @@ int ghes_estatus_pool_init(int num_ghes);
 /* From drivers/edac/ghes_edac.c */
 
 #ifdef CONFIG_EDAC_GHES
-void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
-
 int ghes_edac_register(struct ghes *ghes, struct device *dev);
 
 void ghes_edac_unregister(struct ghes *ghes);
 
 #else
-static inline void ghes_edac_report_mem_error(int sev,
-				       struct cper_sec_mem_err *mem_err)
-{
-}
-
 static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	return -ENODEV;
@@ -145,4 +138,7 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
+struct notifier_block;
+extern void ghes_register_report_chain(struct notifier_block *nb);
+extern void ghes_unregister_report_chain(struct notifier_block *nb);
 #endif /* GHES_H */
-- 
2.25.1

