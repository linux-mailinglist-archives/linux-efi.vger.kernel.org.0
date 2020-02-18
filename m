Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC34162AEC
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBRQpW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 11:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgBRQpW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 11:45:22 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63CD22B48;
        Tue, 18 Feb 2020 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582044322;
        bh=hm+90oUf47SPlQ5U0GH9SzXcGf83AzvmE+6vDU7VQQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFJ8So8YFCpjuTqC6XE7Acup/qcg1SPKdPJj78HPvjVRUgD8LZRFI+AFPjJuhlfma
         ZnOHOKKA9dFUlQ+lY8uDfTr5L7CiEPdpiCjVR8zYPV/PDCzMOkhDMe9vhY+gRsWdqQ
         04AD36HBBEW99KviUT+Cr/r3e7oIky3qHFTIEVls=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/2] ARM: decompressor: prepare cache_clean_flush for doing by-VA maintenance
Date:   Tue, 18 Feb 2020 17:44:29 +0100
Message-Id: <20200218164430.32671-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218164430.32671-1-ardb@kernel.org>
References: <20200218164430.32671-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation of turning the decompressor's cache clean/flush
operations into proper by-VA maintenance for v7 cores, pass the
start and end addresses of the regions that need cache maintenance
into cache_clean_flush in registers r0 and r1.

Currently, all implementations of cache_clean_flush ignore these
values, so no functional change is expected as a result of this
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 28 +++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7b86a2e1acce..935799b92198 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -525,12 +525,15 @@ dtb_check_done:
 		/* cache_clean_flush may use the stack, so relocate it */
 		add	sp, sp, r6
 #endif
-
+		mov	r0, r9
+		ldr	r1, 0f
+		add	r1, r1, r0
 		bl	cache_clean_flush
 
 		badr	r0, restart
 		add	r0, r0, r6
 		mov	pc, r0
+0:		.long	_edata - restart
 
 wont_overwrite:
 /*
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
 
@@ -1439,6 +1457,7 @@ reloc_code_end:
 #ifdef CONFIG_EFI_STUB
 		.align	2
 _start:		.long	start - .
+__edata:	.long	_edata - .
 
 ENTRY(efi_stub_entry)
 		@ allocate space on stack for passing current zImage address
@@ -1470,8 +1489,11 @@ ENTRY(efi_stub_entry)
 		.align	2
 0:		.long	start - (. + 4)
 
-		@ Preserve return value of efi_entry() in r4
-		mov	r4, r0
+		mov	r4, r0				@ preserve DTB pointer
+		mov	r0, r1				@ start of image
+		adr	r2, __edata
+		ldr	r1, [r2]
+		add	r1, r1, r2			@ end of image
 		bl	cache_clean_flush
 		bl	cache_off
 
-- 
2.17.1

