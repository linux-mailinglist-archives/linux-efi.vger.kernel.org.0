Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4C1640A1
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 10:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgBSJnv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 04:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJnv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 04:43:51 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA20D24671;
        Wed, 19 Feb 2020 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582105430;
        bh=IFeKqUgeJV2n7+UfgpcbERriRaaDjRKasrOnKGYW4KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2MTQBZizJ4UrgefK5SkbPxOEESDJrHLVICZbwMsWK7jr1wha9aA37dROV0bjUsKX
         SVTyYC3YVlQYlwSV/GcPiMbRg4+LVDquCGj/r8DlVTcv3HXP5AUYtxk17/YEsqaSRa
         N2IWtLzo9GMmVN8yDtdNa7sROdhZcH5SzHSHcPd4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 1/4] efi/arm: work around missing cache maintenance in decompressor handover
Date:   Wed, 19 Feb 2020 10:43:37 +0100
Message-Id: <20200219094340.16597-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219094340.16597-1-ardb@kernel.org>
References: <20200219094340.16597-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub executes within the context of the zImage as it was
loaded by the firmware, which means it is treated as an ordinary
PE/COFF executable, which is loaded into memory, and cleaned to
the PoU to ensure that it can be executed safely while the MMU
and caches are on.

When the EFI stub hands over to the decompressor, we clean the caches
by set/way and disable the MMU and D-cache, to comply with the Linux
boot protocol for ARM. However, cache maintenance by set/way is not
sufficient to ensure that subsequent instruction fetches and data
accesses done with the MMU off see the correct data. This means that
proceeding as we do currently is not safe, especially since we also
perform data accesses with the MMU off, from a literal pool as well as
the stack.

So let's kick this can down the road a bit, and jump into the relocated
zImage before disabling the caches. This removes the requirement to
perform any by-VA cache maintenance on the original PE/COFF executable,
but it does require that the relocated zImage is cleaned to the PoC,
which is currently not the case. This will be addressed in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 088b0a060876..6c98d3d2de2f 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1461,6 +1461,19 @@ ENTRY(efi_stub_entry)
 		@ Preserve return value of efi_entry() in r4
 		mov	r4, r0
 		bl	cache_clean_flush
+
+		@ The PE/COFF loader might not have cleaned the code we are
+		@ running beyond the PoU, and so calling cache_off below from
+		@ inside the PE/COFF loader allocated region is unsafe. Let's
+		@ assume our own zImage relocation code did a better job, and
+		@ jump into its version of this routine before proceeding.
+		ldr	r0, [sp]			@ relocated zImage
+		ldr	r1, 0f
+		sub	r1, r0, r1
+		mov	pc, r1				@ no mode switch
+		.align	2
+0:		.long	start - (. + 4)
+
 		bl	cache_off
 
 		@ Set parameters for booting zImage according to boot protocol
@@ -1469,12 +1482,7 @@ ENTRY(efi_stub_entry)
 		mov	r0, #0
 		mov	r1, #0xFFFFFFFF
 		mov	r2, r4
-
-		@ Branch to (possibly) relocated zImage that is in [sp]
-		ldr	lr, [sp]
-		ldr	ip, =start_offset
-		add	lr, lr, ip
-		mov	pc, lr				@ no mode switch
+		b	__efi_start
 
 efi_load_fail:
 		@ Return EFI_LOAD_ERROR to EFI firmware on error.
-- 
2.17.1

