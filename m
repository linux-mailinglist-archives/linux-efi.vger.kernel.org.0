Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1881955D3
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgC0K7b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 06:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0K7b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 06:59:31 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE692073B;
        Fri, 27 Mar 2020 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585306770;
        bh=6oNWheLakWrFr/1PDp8ZzyS/LoXFLuI0dbimeVrZQLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5p5aPlFPAeu6r57DZONexiXxPmh+dZOPd13m859D0/52ghhQfFdKKSnWXLl+xmnO
         +tp28j7BOl8BOjAAR7qxWp0yxKO3bsLWn12lByZFjIpHRp8h5e8M1e/B2VIFv/LtnT
         M8XjMydtHPBRazTrAkepr2IzKrFxwBii7cdNrAEI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 4/5] ARM: decompressor: move GOT into .data for EFI enabled builds
Date:   Fri, 27 Mar 2020 11:59:05 +0100
Message-Id: <20200327105906.2665-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327105906.2665-1-ardb@kernel.org>
References: <20200327105906.2665-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will be running the decompressor in place after a future patch,
instead of copying it around first. This means we no longer have to
disable and re-enable the MMU and caches either. However, this means
we will be loaded with the restricted permissions set by the UEFI
firmware, which means that we have to move the GOT table into the
data section in order for the contents to be writable by the code
itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index b247f399de71..d0619ec05705 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -63,9 +63,11 @@ SECTIONS
   _etext = .;
 
   .got.plt		: { *(.got.plt) }
+#ifndef CONFIG_EFI_STUB
   _got_start = .;
   .got			: { *(.got) }
   _got_end = .;
+#endif
 
   /* ensure the zImage file size is always a multiple of 64 bits */
   /* (without a dummy byte, ld just ignores the empty section) */
@@ -74,6 +76,9 @@ SECTIONS
 #ifdef CONFIG_EFI_STUB
   .data : ALIGN(4096) {
     __pecoff_data_start = .;
+    _got_start = .;
+    *(.got)
+    _got_end = .;
     /*
      * The EFI stub always executes from RAM, and runs strictly before the
      * decompressor, so we can make an exception for its r/w data, and keep it
-- 
2.17.1

