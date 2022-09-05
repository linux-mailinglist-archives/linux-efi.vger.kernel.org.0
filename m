Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD15AD672
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiIEP0i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiIEPZr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 11:25:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0E3163DC;
        Mon,  5 Sep 2022 08:25:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20A5ED1;
        Mon,  5 Sep 2022 08:25:51 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 296E53F534;
        Mon,  5 Sep 2022 08:25:38 -0700 (PDT)
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
Subject: [PATCH v5 6/8] EDAC: Add the ghes_edac_preferred check for chipset-specific edac drivers
Date:   Mon,  5 Sep 2022 15:24:37 +0000
Message-Id: <20220905152439.77770-7-justin.he@arm.com>
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

Add ghes_edac_preferred() check to chipset-specific edac drivers to ensure
that ghes_edac is used on the platform where ghes_edac is preferred over
chipset-specific edac driver.

Unlike the existing edac_get_owner() check, the ghes_edac_preferred()
check works independent to the module_init ordering.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/edac/amd64_edac.c      | 3 +++
 drivers/edac/armada_xp_edac.c  | 3 +++
 drivers/edac/edac_module.h     | 1 +
 drivers/edac/i10nm_base.c      | 3 +++
 drivers/edac/igen6_edac.c      | 3 +++
 drivers/edac/layerscape_edac.c | 3 +++
 drivers/edac/pnd2_edac.c       | 3 +++
 drivers/edac/sb_edac.c         | 3 +++
 drivers/edac/skx_base.c        | 3 +++
 drivers/edac/thunderx_edac.c   | 3 +++
 drivers/edac/xgene_edac.c      | 3 +++
 11 files changed, 31 insertions(+)

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
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 038abbb83f4b..486532b92ce0 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -599,6 +599,9 @@ static int __init armada_xp_edac_init(void)
 {
 	int res;
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	/* only polling is supported */
 	edac_op_state = EDAC_OPSTATE_POLL;
 
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
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 94cac7686a56..60ff4c6674cd 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -38,6 +38,9 @@ static int __init fsl_ddr_mc_init(void)
 {
 	int res;
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	/* make sure error reporting method is sane */
 	switch (edac_op_state) {
 	case EDAC_OPSTATE_POLL:
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
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index f13674081cb6..2c4baa6817a9 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -2114,6 +2114,9 @@ static int __init thunderx_edac_init(void)
 {
 	int rc = 0;
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	rc = pci_register_driver(&thunderx_lmc_driver);
 	if (rc)
 		return rc;
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 54081403db4f..9aa68220b625 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -2004,6 +2004,9 @@ static int __init xgene_edac_init(void)
 {
 	int rc;
 
+	if (ghes_edac_preferred())
+		return -EBUSY;
+
 	/* Make sure error reporting method is sane */
 	switch (edac_op_state) {
 	case EDAC_OPSTATE_POLL:
-- 
2.25.1

