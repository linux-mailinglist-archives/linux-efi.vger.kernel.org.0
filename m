Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38B16A5E8
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBXMRr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 07:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgBXMRr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 07:17:47 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B1420880;
        Mon, 24 Feb 2020 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582546666;
        bh=E3ulqfCoOh5BwS+ZZvVQzkCQwPRSb/ckqFlUNh4AMUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sWbDfBs9fCTp/oTRwDUhmH00CqDQWMhHjZG5ty2VSsZuLVRxmYqErm5vHTfBBZFW
         qqTOvKGGPS7XOVgvKXkzAmHR20wiJnXRBDqC/+BkUBNcrn9kfzCu7CN74ka81nvMtE
         QdP6vuUxQn9scW9ZGYtMC/JPrkn5AFQedLuD2fDI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 3/5] ARM: decompressor: factor out routine to obtain the inflated image size
Date:   Mon, 24 Feb 2020 13:17:31 +0100
Message-Id: <20200224121733.2202-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224121733.2202-1-ardb@kernel.org>
References: <20200224121733.2202-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before adding another reference to the inflated image size, factor
out the slightly complicated way of loading the unaligned little-endian
constant from the end of the compressed data.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 43 ++++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 8487221bedb0..674e55400cfd 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -151,6 +151,25 @@
 .L_\@:
 		.endm
 
+		/*
+		 * The kernel build system appends the size of the
+		 * decompressed kernel at the end of the compressed data
+		 * in little-endian form.
+		 */
+		.macro	get_inflated_image_size, res:req, tmp1:req, tmp2:req
+		adr	\res, .Linflated_image_size_offset
+		ldr	\tmp1, [\res]
+		add	\tmp1, \tmp1, \res	@ offset of inflated image size
+
+		ldrb	\res, [\tmp1]		@ get_unaligned_le32
+		ldrb	\tmp2, [\tmp1, #1]
+		orr	\res, \res, \tmp2, lsl #8
+		ldrb	\tmp2, [\tmp1, #2]
+		ldrb	\tmp1, [\tmp1, #3]
+		orr	\res, \res, \tmp2, lsl #16
+		orr	\res, \res, \tmp1, lsl #24
+		.endm
+
 		.section ".start", "ax"
 /*
  * sort out different calling conventions
@@ -268,15 +287,15 @@ not_angel:
 		 */
 		mov	r0, pc
 		cmp	r0, r4
-		ldrcc	r0, LC0+32
+		ldrcc	r0, LC0+28
 		addcc	r0, r0, pc
 		cmpcc	r4, r0
 		orrcc	r4, r4, #1		@ remember we skipped cache_on
 		blcs	cache_on
 
 restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12}
-		ldr	sp, [r0, #28]
+		ldmia	r0, {r1, r2, r3, r6, r11, r12}
+		ldr	sp, [r0, #24]
 
 		/*
 		 * We might be running at a different address.  We need
@@ -284,20 +303,8 @@ restart:	adr	r0, LC0
 		 */
 		sub	r0, r0, r1		@ calculate the delta offset
 		add	r6, r6, r0		@ _edata
-		add	r10, r10, r0		@ inflated kernel size location
 
-		/*
-		 * The kernel build system appends the size of the
-		 * decompressed kernel at the end of the compressed data
-		 * in little-endian form.
-		 */
-		ldrb	r9, [r10, #0]
-		ldrb	lr, [r10, #1]
-		orr	r9, r9, lr, lsl #8
-		ldrb	lr, [r10, #2]
-		ldrb	r10, [r10, #3]
-		orr	r9, r9, lr, lsl #16
-		orr	r9, r9, r10, lsl #24
+		get_inflated_image_size	r9, r10, lr
 
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
@@ -652,13 +659,15 @@ LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
 		.word	_edata			@ r6
-		.word	input_data_end - 4	@ r10 (inflated size location)
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	.L_user_stack_end	@ sp
 		.word	_end - restart + 16384 + 1024*1024
 		.size	LC0, . - LC0
 
+.Linflated_image_size_offset:
+		.long	(input_data_end - 4) - .
+
 #ifdef CONFIG_ARCH_RPC
 		.globl	params
 params:		ldr	r0, =0x10000100		@ params_phys for RPC
-- 
2.17.1

