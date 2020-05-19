Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF501D9C8B
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgESQ1F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 12:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQ1E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 12:27:04 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D06A20826;
        Tue, 19 May 2020 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905624;
        bh=Rnr1nZVVeFJ8Ie+KrJMA9hzs3cpYXGVP9cLvCfNZ5RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaIcUPJO0UwNNr+BifsMlE6U9axBV/4+5mSQRLZxitMW5BasAfLi6BMOcFvXiyeZE
         lU5+XmKS1kf/lUqb98vJFj17XHoTZi+oxWeqeu6Pwy5vgCQefBJxsIJxCaMCYqdHjx
         RcwN7Atuv317jS60pgcG16sHDFKsmKEN3Aw/uejU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 2/5] ARM: decompressor: split off _edata and stack base into separate object
Date:   Tue, 19 May 2020 18:26:42 +0200
Message-Id: <20200519162645.31065-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519162645.31065-1-ardb@kernel.org>
References: <20200519162645.31065-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation of moving the handling of the LC0 object to a later stage
in the decompressor startup code, move out _edata and the initial value
of the stack pointer, which are needed earlier than the remaining
contents of LC0.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/boot/compressed/head.S | 23 ++++++++++----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 42b8d67beab6..5d712e2c0001 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -293,22 +293,20 @@ not_angel:
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
@@ -660,12 +658,15 @@ not_relocated:	mov	r0, #0
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

