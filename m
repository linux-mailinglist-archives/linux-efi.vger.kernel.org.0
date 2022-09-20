Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D875BECDD
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiITSgQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiITSgP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45E6CD18
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38D5FB82C36
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63450C4347C;
        Tue, 20 Sep 2022 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698971;
        bh=BetZz9CDmYdPoJsV3KhJK53rxp2DGnFMZGlaAWVqhzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uj0pXq/tkr6a3LRTeiDIGy8euJAnt2FZ3G0UxjhhsWCXA7no307AgNjJcnrMWPNEL
         h9N3wmVlyrxp7Ik3txrUJ88OqgModXjjYhvpai78eIfut2p6BPNTL71PbmpM1kQ5Hu
         0VRinaXqPTbGlTRHe/TvoVbkARV1sXocuUvh0VvycaC9a2diXTbMLWcaAQxx6jCEK5
         rCnJerMaYo6/DusBAn2cqHHBNEakQsjZeT7oZkGM5kqJqVXHbqf9ObAxyx6C+w4g7Y
         0hsnOWfKP6t2C6BAWvWO35mwS2p+OUJYMZY4JdQqYaFPvtYb0TkXVaxBOmVEsT6YZL
         xVmlG+euWITNg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 4/8] efi: libstub: remove pointless goto kludge
Date:   Tue, 20 Sep 2022 20:35:50 +0200
Message-Id: <20220920183554.3870247-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920183554.3870247-1-ardb@kernel.org>
References: <20220920183554.3870247-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=ardb@kernel.org; h=from:subject; bh=BetZz9CDmYdPoJsV3KhJK53rxp2DGnFMZGlaAWVqhzk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKggCesa+CTDjqr732yIZOYDEXK44DTtGZzuzFhlL Y4NrYPaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoIAgAKCRDDTyI5ktmPJAlUC/ 0VJ1htDiabFdzcb5K1BpOczf/Pa8Xj6RbuV4YrGkrnmU2uxYmDxBlAmaWz536Wex+H0nGsHpdvMAgG 3Vwk3sJbYo3dxv+rcki0t7Atq5h5L68TZDOCv09Ape6mMaHeFLjZUrbi3wlGQTIE4D/DYJckQR2KiU Wc8mw+F0BcWrU1lH4VUWwhtk+30soe+eL7hjsY5lmlcYavBg5uDJZ8nLsTGIavX62Nj/Cd0PvIMjFX SSuRCuFrVrKCECTsAlcfUdeEkhgjbiWPFtQizrJ86m7qW8v6QwaVIoBAcKIbudnCBQT2P1tEiNmWnd HCcNFOHbVJnMRgq35sCLJnNaWMRZ+1yclo0j+OVkTcYKM+tBvxduM4OAcw9pMMfJL10Yd0xg+gImEp uueDCIh77mF/IlNRQ+RdOwWmkHMVt2syNAYcH9FmO2xnpffD9btTvuP7S1a8DFoItxugaxJPYmgqYY q37mauSG62wM4AUWEVI9OwjDbfdYXaoyWYeqoqvYPnGjE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove some goto cruft that serves no purpose and obfuscates the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 22 +++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 85c68aa83673..63f3c2cd7058 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -438,13 +438,14 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	efi_status_t status;
 
 	status = efi_get_memory_map(&map);
-
 	if (status != EFI_SUCCESS)
-		goto fail;
+		return status;
 
 	status = priv_func(map, priv);
-	if (status != EFI_SUCCESS)
-		goto free_map;
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, map);
+		return status;
+	}
 
 	if (efi_disable_pci_dma)
 		efi_pci_disable_bridge_busmaster();
@@ -475,25 +476,16 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
-			goto fail;
+			return status;
 
 		status = priv_func(map, priv);
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
-			goto fail;
+			return status;
 
 		status = efi_bs_call(exit_boot_services, handle, map->map_key);
 	}
 
-	/* exit_boot_services() was called, thus cannot free */
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	return EFI_SUCCESS;
-
-free_map:
-	efi_bs_call(free_pool, map);
-fail:
 	return status;
 }
 
-- 
2.35.1

