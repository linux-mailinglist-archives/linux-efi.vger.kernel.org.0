Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36C1170503
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 17:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBZQ54 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 11:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbgBZQ54 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 11:57:56 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80DC2467F;
        Wed, 26 Feb 2020 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582736275;
        bh=89tEKgcq3StZjhEAnbU++RDMy8AFndP8uxFqNWHt5X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgmh0qMnA51Zzm+zpT9nCz+yBbR9wbPuwTLxUMGnRnKqNh9q/vWw1G5gyNknwMrSB
         j9vjnl5Ex9sog639i5zpC1JCHxGJyKywRaIM1wLrRMrZvLHyzGzbBRJ9X7hNmn9ock
         JIMRHxcaE2f2dqMPDSl1bir07RYrW963Sx7QlV6Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 4/5] ARM: decompressor: prepare cache_clean_flush for doing by-VA maintenance
Date:   Wed, 26 Feb 2020 17:57:37 +0100
Message-Id: <20200226165738.11201-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226165738.11201-1-ardb@kernel.org>
References: <20200226165738.11201-1-ardb@kernel.org>
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
 arch/arm/boot/compressed/head.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d45952aae2b5..f90034151aef 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -528,6 +528,8 @@ dtb_check_done:
 		/* Preserve offset to relocated code. */
 		sub	r6, r9, r6
 
+		mov	r0, r9			@ start of relocated zImage
+		add	r1, sp, r6		@ end of relocated zImage
 #ifndef CONFIG_ZBOOT_ROM
 		/* cache_clean_flush may use the stack, so relocate it */
 		add	sp, sp, r6
@@ -629,6 +631,11 @@ not_relocated:	mov	r0, #0
 		add	r2, sp, #0x10000	@ 64k max
 		mov	r3, r7
 		bl	decompress_kernel
+
+		get_inflated_image_size	r1, r2, r3
+
+		mov	r0, r4			@ start of inflated image
+		add	r1, r1, r0		@ end of inflated image
 		bl	cache_clean_flush
 		bl	cache_off
 
@@ -1182,6 +1189,9 @@ __armv7_mmu_cache_off:
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

