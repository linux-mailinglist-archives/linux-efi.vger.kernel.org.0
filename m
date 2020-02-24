Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329D416A5E9
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 13:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXMRt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 07:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgBXMRs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 07:17:48 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C61820732;
        Mon, 24 Feb 2020 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582546668;
        bh=mztqZtSqiSBQKD7LlQORhwESyj6VWRq2ScqN29qp6k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TYTzMfjGaCDZKZcz0C6j6rLcKWqm4oEZMkn+agbSrnV3AEghJGBM3+UZaHMIiNgI
         s2Uyk7b7tGsB6uIsSM0EPIe8vWB80itfUvZHfbUGXO25498IlWSgEYJ+wGNRS4Mayf
         WsIhLyS08ppNfDcJNPh8uyG9P+Rw+nc2SjvGu72M=
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
Subject: [PATCH v3 4/5] ARM: decompressor: prepare cache_clean_flush for doing by-VA maintenance
Date:   Mon, 24 Feb 2020 13:17:32 +0100
Message-Id: <20200224121733.2202-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224121733.2202-1-ardb@kernel.org>
References: <20200224121733.2202-1-ardb@kernel.org>
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
 arch/arm/boot/compressed/head.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 674e55400cfd..12d631503bfa 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -533,12 +533,19 @@ dtb_check_done:
 		add	sp, sp, r6
 #endif
 
+		adr	r0, restart
+		ldr	r1, .Lclean_size
+		add	r0, r0, r6
+		add	r1, r1, r0
 		bl	cache_clean_flush
 
 		badr	r0, restart
 		add	r0, r0, r6
 		mov	pc, r0
 
+		.align	2
+.Lclean_size:	.long	_edata - restart
+
 wont_overwrite:
 /*
  * If delta is zero, we are running at the address we were linked at.
@@ -629,6 +636,11 @@ not_relocated:	mov	r0, #0
 		add	r2, sp, #0x10000	@ 64k max
 		mov	r3, r7
 		bl	decompress_kernel
+
+		get_inflated_image_size r1, r2, r3
+
+		mov	r0, r4			@ start of inflated image
+		add	r1, r1, r0		@ end of inflated image
 		bl	cache_clean_flush
 		bl	cache_off
 
@@ -1182,6 +1194,9 @@ __armv7_mmu_cache_off:
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

