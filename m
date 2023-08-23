Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F6786332
	for <lists+linux-efi@lfdr.de>; Thu, 24 Aug 2023 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjHWWLW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Aug 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjHWWKy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Aug 2023 18:10:54 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 15:10:51 PDT
Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF7E6E;
        Wed, 23 Aug 2023 15:10:51 -0700 (PDT)
Received: from glidewell.ykf.mikelr.com (unknown [IPv6:2607:f2c0:e554:3f00:c018:4aba:e7e5:c2b1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id B9B2868C18;
        Wed, 23 Aug 2023 17:52:50 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Mikel Rychliski <mikel@mikelr.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/efistub: Fix PCI ROM preservation in mixed mode
Date:   Wed, 23 Aug 2023 17:51:58 -0400
Message-Id: <20230823215159.29082-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

preserve_pci_rom_image() was accessing the romsize field in
efi_pci_io_protocol_t directly instead of using the efi_table_attr()
helper. This prevents the ROM image from being saved correctly during a
mixed mode boot.

Fixes: 2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e976288728e9..2fee52ed335d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -72,7 +72,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->data.type	= SETUP_PCI;
 	rom->data.len	= size - sizeof(struct setup_data);
 	rom->data.next	= 0;
-	rom->pcilen	= pci->romsize;
+	rom->pcilen	= romsize;
 	*__rom = rom;
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
-- 
2.35.3

