Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53E59C329
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiHVPnM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiHVPmf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 11:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A942F1CB2D;
        Mon, 22 Aug 2022 08:42:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A072C1424;
        Mon, 22 Aug 2022 08:42:33 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1ECB3F70D;
        Mon, 22 Aug 2022 08:42:21 -0700 (PDT)
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
Subject: [RESEND PATCH v3 9/9] edac: Don't load Arm specific edac drivers when ghes_edac is preferred
Date:   Mon, 22 Aug 2022 15:40:48 +0000
Message-Id: <20220822154048.188253-10-justin.he@arm.com>
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

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/edac/armada_xp_edac.c  | 3 +++
 drivers/edac/layerscape_edac.c | 3 +++
 drivers/edac/thunderx_edac.c   | 3 +++
 drivers/edac/xgene_edac.c      | 3 +++
 4 files changed, 12 insertions(+)

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

