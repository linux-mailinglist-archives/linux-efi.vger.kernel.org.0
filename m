Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9C1A69BE
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgDMQVv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 12:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbgDMQVu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 12:21:50 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0742073E;
        Mon, 13 Apr 2020 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586794910;
        bh=3sB3AwLn6vuO/EdHCYY8hG3ZEVU8p70qlzwF6Ap3GMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqwmla3XcGaHozont58jUvNbV4azSmR19f5bvCUq5qhrcLylHLQCrlGBHkYmaJN52
         0FDVcSP+XdxVSibCW+py7hSwKf1KSgxgO/puysykYGPq8EZdN9bYyoZnSHeDNrkfIY
         OY7Mv4TjWCITU4KECn6Gs7DfDkF8CUQh+atQ/z7E=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 2/5] ARM: decompressor: split off _edata and stack base into separate object
Date:   Mon, 13 Apr 2020 18:21:32 +0200
Message-Id: <20200413162135.14955-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413162135.14955-1-ardb@kernel.org>
References: <20200413162135.14955-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation of moving the handling of the LC0 object to a later stage
in the decompressor startup code, move out _edata and the initial value
of the stack pointer, which are now used in two places, and are needed
earlier than the remaining contents of LC0.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 35 ++++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index bb674febf640..449457d00c4e 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -259,19 +259,17 @@ not_angel:
 		 * Find the start of physical memory.
 		 * Try the DTB first, if available.
 		 */
-		adr	r0, LC0
-		ldr	r1, [r0]	@ get absolute LC0
-		ldr	sp, [r0, #24]	@ get stack location
-		sub	r1, r0, r1	@ compute relocation offset
-		add	sp, sp, r1	@ apply relocation
+		adr	r0, LC1
+		ldr	sp, [r0]	@ get stack location
+		add	sp, sp, r0	@ apply relocation
 
 #ifdef CONFIG_ARM_APPENDED_DTB
 		/*
 		 * Look for an appended DTB. If found, use it and
 		 * move stack away from it.
 		 */
-		ldr	r6, [r0, #12]	@ get &_edata
-		add	r6, r6, r1	@ relocate it
+		ldr	r6, [r0, #4]	@ get &_edata
+		add	r6, r6, r0	@ relocate it
 		ldmia	r6, {r0, r5}	@ get DTB signature and size
 #ifndef __ARMEB__
 		ldr	r1, =0xedfe0dd0	@ sig is 0xd00dfeed big endian
@@ -345,22 +343,20 @@ not_angel:
 		orrcc	r4, r4, #1		@ remember we skipped cache_on
 		blcs	cache_on
 
-restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r6, r11, r12}
-		ldr	sp, [r0, #24]
+restart:	adr	r0, LC1
+		ldr	sp, [r0]
+		ldr	r6, [r0, #4]
+		add	sp, sp, r0
+		add	r6, r6, r0
 
-		/*
-		 * We might be running at a different address.  We need
-		 * to fix up various pointers.
-		 */
+		adr	r0, LC0
+		ldmia	r0, {r1, r2, r3, r11, r12}
 		sub	r0, r0, r1		@ calculate the delta offset
-		add	r6, r6, r0		@ _edata
 
 		get_inflated_image_size	r9, r10, lr
 
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
-		add	sp, sp, r0
 		add	r10, sp, #0x10000
 #else
 		/*
@@ -712,12 +708,15 @@ not_relocated:	mov	r0, #0
 LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
-		.word	_edata			@ r6
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
-		.word	.L_user_stack_end	@ sp
 		.size	LC0, . - LC0
 
+		.type	LC1, #object
+LC1:		.word	.L_user_stack_end - LC1	@ sp
+		.word	_edata - LC1		@ r6
+		.size	LC1, . - LC1
+
 .Lheadroom:
 		.word	_end - restart + 16384 + 1024*1024
 
-- 
2.17.1

