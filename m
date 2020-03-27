Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEC1955D1
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgC0K71 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 06:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0K70 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 06:59:26 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C79F20717;
        Fri, 27 Mar 2020 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585306766;
        bh=GXlaIHulvMaCbD3Jl+Klq6LgV3qJqzTBno2wfve4r7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6hsaGV7vAScTk0nP/lauGQpnscgywLAVJ53qCWUHqwxYQ9brF3Va15HffcRjUJOo
         wSFn4QnKtPKMagTBePAOIkjgkWYIKEmQRJ0FABnov/C+wR6aBLhUdc5rjQmL7kN+hj
         13LLe4oyAKsYbqNFczUpZeQ0xaUmCsIrripULcVQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/5] ARM: decompressor: split off _edata and stack base into separate object
Date:   Fri, 27 Mar 2020 11:59:03 +0100
Message-Id: <20200327105906.2665-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327105906.2665-1-ardb@kernel.org>
References: <20200327105906.2665-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation of moving the handling of the LC0 object to a later stage
in the decompressor startup code, move out _edata and the initial value
of the stack pointer, which are now used in two places, and are needed
earlier than the remaining contents of LC0.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 33 +++++++++-----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index bb674febf640..a6cf2f8115e5 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -259,19 +259,16 @@ not_angel:
 		 * Find the start of physical memory.
 		 * Try the DTB first, if available.
 		 */
-		adr	r0, LC0
-		ldr	r1, [r0]	@ get absolute LC0
-		ldr	sp, [r0, #24]	@ get stack location
-		sub	r1, r0, r1	@ compute relocation offset
-		add	sp, sp, r1	@ apply relocation
+		adr	r0, LC1
+		ldmia	r0, {r1, r6}
+		add	sp, r1, r0	@ get stack location
+		add	r6, r6, r0	@ get &_edata
 
 #ifdef CONFIG_ARM_APPENDED_DTB
 		/*
 		 * Look for an appended DTB. If found, use it and
 		 * move stack away from it.
 		 */
-		ldr	r6, [r0, #12]	@ get &_edata
-		add	r6, r6, r1	@ relocate it
 		ldmia	r6, {r0, r5}	@ get DTB signature and size
 #ifndef __ARMEB__
 		ldr	r1, =0xedfe0dd0	@ sig is 0xd00dfeed big endian
@@ -345,22 +342,19 @@ not_angel:
 		orrcc	r4, r4, #1		@ remember we skipped cache_on
 		blcs	cache_on
 
-restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r6, r11, r12}
-		ldr	sp, [r0, #24]
+restart:	adr	r0, LC1
+		ldmia	r0, {r1, r6}
+		add	sp, r1, r0
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
@@ -712,12 +706,15 @@ not_relocated:	mov	r0, #0
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

