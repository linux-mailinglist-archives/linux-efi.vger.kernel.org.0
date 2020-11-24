Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB592C30A2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 20:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbgKXTQx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 14:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390959AbgKXTQx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Nov 2020 14:16:53 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3FC0613D6
        for <linux-efi@vger.kernel.org>; Tue, 24 Nov 2020 11:16:53 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id wKGo2300Y4C55Sk01KGpEU; Tue, 24 Nov 2020 20:16:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khdo0-005XKS-NH; Tue, 24 Nov 2020 20:16:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khdnz-00Ew4C-S7; Tue, 24 Nov 2020 20:16:47 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] efi: EFI_EARLYCON should depend on EFI
Date:   Tue, 24 Nov 2020 20:16:46 +0100
Message-Id: <20201124191646.3559757-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONFIG_EFI_EARLYCON defaults to yes, and thus is enabled on systems that
do not support EFI, or do not have EFI support enabled, but do satisfy
the symbol's other dependencies.

While drivers/firmware/efi/ won't be entered during the build phase if
CONFIG_EFI=n, and drivers/firmware/efi/earlycon.c itself thus won't be
built, enabling EFI_EARLYCON does force-enable CONFIG_FONT_SUPPORT and
CONFIG_ARCH_USE_MEMREMAP_PROT, and CONFIG_FONT_8x16, which is
undesirable.

Fix this by making CONFIG_EFI_EARLYCON depend on CONFIG_EFI.

This reduces kernel size on headless systems by more than 4 KiB.

Fixes: 69c1f396f25b805a ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/firmware/efi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b452cfa2100b401c..1dd1f7784f0888ff 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -270,7 +270,7 @@ config EFI_DEV_PATH_PARSER
 
 config EFI_EARLYCON
 	def_bool y
-	depends on SERIAL_EARLYCON && !ARM && !IA64
+	depends on EFI && SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
 
-- 
2.25.1

