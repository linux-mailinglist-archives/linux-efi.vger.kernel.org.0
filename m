Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB65359713C
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbiHQOgB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiHQOf6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 10:35:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 432339AFD0;
        Wed, 17 Aug 2022 07:35:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5201595;
        Wed, 17 Aug 2022 07:35:46 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1D5D3F70D;
        Wed, 17 Aug 2022 07:35:39 -0700 (PDT)
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
Subject: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selected only when ghes_edac is not enabled
Date:   Wed, 17 Aug 2022 14:34:55 +0000
Message-Id: <20220817143458.335938-5-justin.he@arm.com>
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

When ghes_edac is loaded, a regular edac driver for the CPU type / platform
still attempts to register itself and fails in its module_init call.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/edac/amd64_edac.c | 3 +++
 drivers/edac/pnd2_edac.c  | 3 +++
 drivers/edac/sb_edac.c    | 3 +++
 drivers/edac/skx_base.c   | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..e4eaf6668feb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4329,6 +4329,9 @@ static int __init amd64_edac_init(void)
 	int err = -ENODEV;
 	int i;
 
+	if (ghes_get_devices(0))
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index a20b299f1202..73f2ba0e64e3 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1528,6 +1528,9 @@ static int __init pnd2_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_get_devices(0))
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 9678ab97c7ac..1d0520a16840 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3506,6 +3506,9 @@ static int __init sbridge_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_get_devices(0))
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 1abc020d49ab..fe267f8543f5 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -653,6 +653,9 @@ static int __init skx_init(void)
 
 	edac_dbg(2, "\n");
 
+	if (ghes_get_devices(0))
+		return -EBUSY;
+
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
-- 
2.25.1

