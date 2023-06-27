Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386B073F5E3
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjF0Hlq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jun 2023 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjF0Hlp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jun 2023 03:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC061B2
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 00:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46F161048
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 07:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA37C433C8;
        Tue, 27 Jun 2023 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687851699;
        bh=m0hbLmMXErw2pjxKdsddIrOX4/v0RSmwGX1Zj/XNtOY=;
        h=From:To:Cc:Subject:Date:From;
        b=lmhQztFIcfIox/nnkgy/KxCiwSbO+i3nqegk2q4ZpkoUrT+0pCP7OoxeXovaXeyxa
         enToignRtCeJj0fJnOtzM/YIrRpQvbEm4s3UHj/WjGiStV5xisiX/wMSPgKiXNKuk3
         Nuzui+wOXh8Px5h6YnmVZf/Px9XYN4GXCnM07geudzPN3Mtca15iyTH9ycVsJ9Njdv
         OBpeSdBULuO64aTzejVpPZC9t+Iuo74hEC02sYpGKF7A0k+X/lId8YdttDlIj/DLFc
         TkmnwFMemDnokFexPX6viUwsIJ/EKAPeNUy8KDnbL215boQYpJiBbG6+w7WzYzs8ti
         bkj5dFBUVaa4g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <dkiper@net-space.pl>,
        Glenn Washburn <development@efficientek.com>
Subject: [PATCH] efi/libstub: Disable PCI DMA before grabbing the EFI memory map
Date:   Tue, 27 Jun 2023 09:41:32 +0200
Message-Id: <20230627074132.1016795-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=ardb@kernel.org; h=from:subject; bh=m0hbLmMXErw2pjxKdsddIrOX4/v0RSmwGX1Zj/XNtOY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWXWpDWuNdaa9y77CN+z03tS+vL0HGehc3bTPrVYxZ6Nn fIs5n1YRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjITDmGf8rb9EIF5FYdLdmm aRnzRFqpuKy/uOFTlPmB1Se9uLasKmFkuB4WYvavrK3xSXfDjpMqBzbolFVP5tIUWMa0cKlDYUc FKwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the EFI stub will disable PCI DMA as the very last thing it
does before calling ExitBootServices(), to avoid interfering with the
firmware's normal operation as much as possible.

However, the stub will invoke DisconnectController() on all endpoints
downstream of the PCI bridges it disables, and this may affect the
layout of the EFI memory map, making it likely that ExitBootServices()
will fail the first time around, and that the EFI memory map needs to be
reloaded.

This, in turn, increases the likelihood that the slack space we
allocated is insufficient (and we can no longer allocate memory via boot
services after having called ExitBootServices() once), causing the
second call to GetMemoryMap (and therefore the boot) to fail. This makes
the PCI DMA disable feature a bit more fragile than it already is, so
let's make it more robust, by allocating the space for the EFI memory
map after disabling PCI DMA.

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Daniel Kiper <dkiper@net-space.pl>
Reported-by: Glenn Washburn <development@efficientek.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 51779279fbff21b5..bfa30625f5d03167 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -380,6 +380,9 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	struct efi_boot_memmap *map;
 	efi_status_t status;
 
+	if (efi_disable_pci_dma)
+		efi_pci_disable_bridge_busmaster();
+
 	status = efi_get_memory_map(&map, true);
 	if (status != EFI_SUCCESS)
 		return status;
@@ -390,9 +393,6 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 		return status;
 	}
 
-	if (efi_disable_pci_dma)
-		efi_pci_disable_bridge_busmaster();
-
 	status = efi_bs_call(exit_boot_services, handle, map->map_key);
 
 	if (status == EFI_INVALID_PARAMETER) {
-- 
2.39.2

