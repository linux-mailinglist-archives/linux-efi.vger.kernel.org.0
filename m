Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB61640A3
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBSJnz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 04:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJnz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 04:43:55 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D066124670;
        Wed, 19 Feb 2020 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582105434;
        bh=nzX78Zffh24BLjHSXoPPyq8OpfUkaTb/SZZiYridmWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEF4LkMbiUGVWI7t1nvMdu6IMDQU5N/TdAIEqU1oMxxadfawTeMYuJEXiYo2zRX5F
         DeOnZnbgHX1wuJp+oeL2LM5bM0mM+ihlRYmXoUv/gHUsxRngPUvKzJdZzhj7agUpnY
         Ks0gCtl13HxFTRl1bsYJPlj5/mOtTd/g/CYhtKww=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 3/4] ARM: decompressor: prepare cache_clean_flush for doing by-VA maintenance
Date:   Wed, 19 Feb 2020 10:43:39 +0100
Message-Id: <20200219094340.16597-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219094340.16597-1-ardb@kernel.org>
References: <20200219094340.16597-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for turning the decompressor's cache clean/flush
operations into proper by-VA maintenance for v7 cores, pass the
start and end addresses of the regions that need cache maintenance
into cache_clean_flush in registers r0 and r1.

Currently, all implementations of cache_clean_flush ignore these
values, so no functional change is expected as a result of this
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c11b1b0a3ac6..5060a623e0d7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -498,6 +498,7 @@ dtb_check_done:
 		bic	r9, r9, #31		@ ... of 32 bytes
 		add	r6, r9, r5
 		add	r9, r9, r10
+		stmdb	sp!, {r9 - r10}		@ preserve target region address
 
 #ifdef DEBUG
 		sub     r10, r6, r5
@@ -521,6 +522,8 @@ dtb_check_done:
 		/* Preserve offset to relocated code. */
 		sub	r6, r9, r6
 
+		ldr	r1, [sp], #4		@ end of target region
+		ldr	r0, [sp], #4		@ start of target region
 #ifndef CONFIG_ZBOOT_ROM
 		/* cache_clean_flush may use the stack, so relocate it */
 		add	sp, sp, r6
@@ -622,6 +625,21 @@ not_relocated:	mov	r0, #0
 		add	r2, sp, #0x10000	@ 64k max
 		mov	r3, r7
 		bl	decompress_kernel
+
+		mov	r0, r4			@ base of inflated image
+		adr	r1, LC0			@ actual LC0
+		ldr	r2, [r1]		@ linktime LC0
+		sub	r2, r1, r2		@ LC0 delta
+		ldr	r1, [r1, #16]		@ link time inflated size offset
+		ldr	r1, [r1, r2]		@ actual inflated size (LE)
+#ifdef __ARMEB__
+		/* convert to big endian */
+		eor	r2, r1, r1, ror #16
+		bic	r2, r2, #0x00ff0000
+		mov	r1, r1, ror #8
+		eor	r1, r1, r2, lsr #8
+#endif
+		add	r1, r1, r0		@ end of inflated image
 		bl	cache_clean_flush
 		bl	cache_off
 
@@ -1173,6 +1191,9 @@ __armv7_mmu_cache_off:
 /*
  * Clean and flush the cache to maintain consistency.
  *
+ * On entry,
+ *  r0 = start address
+ *  r1 = end address (exclusive)
  * On exit,
  *  r1, r2, r3, r9, r10, r11, r12 corrupted
  * This routine must preserve:
-- 
2.17.1

