Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36EF1734DC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 11:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1KCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 05:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgB1KCx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 05:02:53 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D05A246AE;
        Fri, 28 Feb 2020 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582884173;
        bh=ZHt5qBqIY9ONXAk9yRqbEabkxPlfdSFC1tszWNA9yCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9x3lO5xp4b1B7I25UDFPakVH4paJw42sYPRwSkVMhqsqU7sExpKcjGT9VWWFKrG/
         pt+iiuYARsC1bRg9/YFGK94oO8kgznQWmVSGbocqVzulFNNwGn33K+dmvwvZapKWT7
         EyhNg9f/vsTFd40tlRUooybGu74Jnchk98hQkQtM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH efi-next 2/3] efi/arm64: clean EFI stub exit code from cache instead of avoiding it
Date:   Fri, 28 Feb 2020 11:02:43 +0100
Message-Id: <20200228100244.10979-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228100244.10979-1-ardb@kernel.org>
References: <20200228100244.10979-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 9f9223778 ("efi/libstub/arm: Make efi_entry() an ordinary PE/COFF
entrypoint") modified the handover code written in assembler, and for
maintainability, aligned the logic with the logic used in the 32-bit ARM
version, which is to avoid cache maintenance on the remaining instructions
in the subroutine that will be executed with the MMU and caches off, and
instead, branch into the relocated copy of the kernel image.

However, this assumes that this copy is executable, and this means we
expect EFI_LOADER_DATA regions to be executable as well, which is not
a reasonable assumption to make, even if this is true for most UEFI
implementations today.

So change this back, and add a __flush_dcache_area() call to cover the
remaining code in the subroutine.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-entry.S  | 18 +++++++++---------
 arch/arm64/kernel/image-vars.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 4cfd03c35c49..d5dee064975f 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -19,7 +19,8 @@ ENTRY(efi_enter_kernel)
 	 * point stored in x0. Save those values in registers which are
 	 * callee preserved.
 	 */
-	mov	x19, x0			// relocated Image address
+	ldr	w2, =stext_offset
+	add	x19, x0, x2		// relocated Image entrypoint
 	mov	x20, x1			// DTB address
 
 	/*
@@ -29,15 +30,14 @@ ENTRY(efi_enter_kernel)
 	ldr	w1, =kernel_size
 	bl	__flush_dcache_area
 	ic	ialluis
-	dsb	sy
 
 	/*
-	 * Jump across, into the copy of the image that we just cleaned
-	 * to the PoC, so that we can safely disable the MMU and caches.
+	 * Flush the remainder of this routine to the PoC
+	 * so that we can safely disable the MMU and caches.
 	 */
-	ldr	w0, .Ljmp
-	sub	x0, x19, w0, sxtw
-	br	x0
+	adr	x0, 0f
+	ldr	w1, 3f
+	bl	__flush_dcache_area
 0:
 	/* Turn off Dcache and MMU */
 	mrs	x0, CurrentEL
@@ -63,6 +63,6 @@ ENTRY(efi_enter_kernel)
 	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-	b	stext
+	br	x19
 ENDPROC(efi_enter_kernel)
-.Ljmp:	.long	_text - 0b
+3:	.long	. - 0b
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 9a7aef0d6f70..28bf98f84adf 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_EFI
 
 __efistub_kernel_size		= _edata - _text;
+__efistub_stext_offset		= stext - _text;
 
 
 /*
@@ -43,7 +44,6 @@ __efistub___memset		= __pi_memset;
 #endif
 
 __efistub__text			= _text;
-__efistub_stext			= stext;
 __efistub__end			= _end;
 __efistub__edata		= _edata;
 __efistub_screen_info		= screen_info;
-- 
2.17.1

