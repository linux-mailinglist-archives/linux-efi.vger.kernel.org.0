Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2217F1736FA
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB1MOX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 07:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgB1MOX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 07:14:23 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BA6246B4;
        Fri, 28 Feb 2020 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582892062;
        bh=SJlSXAj88NxcUgayRsmVia+8rhay30lruXWP/iqAjMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7mHf5R/zM6ZpKSsX0WU01oYVn7q8YxP5x5qTMPdG3Khh90RmygLun+z7pHwe6A4B
         TShk8GRDcGQz3Vxf8vK5RHoWg5Xardi6OKwDB+l3Qv2IXYUf2BA9wU2kQaX7DgRLhS
         igjhQmBSuquK6ULax3roenKuV9qFGAijIMpbIVlA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 4/6] efi/arm: clean EFI stub exit code from cache instead of avoiding it
Date:   Fri, 28 Feb 2020 13:14:06 +0100
Message-Id: <20200228121408.9075-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228121408.9075-1-ardb@kernel.org>
References: <20200228121408.9075-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit c7225494b ("efi/arm: Work around missing cache maintenance in
decompressor handover") modified the handover code written in assembler
to work around the missing cache maintenance of the piece of code that
is executed after the MMU and caches are turned off. Due to the fact
that this sequence incorporates a subroutine call, cleaning that code
from the cache is not a matter of simply passing the start and end of
the currently running subroutine into cache_clean_flush(), which is why
instead, the code jumps across into the cleaned copy of the image.

However, this assumes that this copy is executable, and this means we
expect EFI_LOADER_DATA regions to be executable as well, which is not
a reasonable assumption to make, even if this is true for most UEFI
implementations today.

So change this back, and add a cache_clean_flush() call to cover the
remaining code in the subroutine, and any code it may execute in the
context of cache_off().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 36ffbeecd30b..04f77214f050 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1452,13 +1452,11 @@ ENTRY(efi_enter_kernel)
 
 		@ The PE/COFF loader might not have cleaned the code we are
 		@ running beyond the PoU, and so calling cache_off below from
-		@ inside the PE/COFF loader allocated region is unsafe. Let's
-		@ assume our own zImage relocation code did a better job, and
-		@ jump into its version of this routine before proceeding.
-		ldr	r1, .Ljmp
-		sub	r1, r7, r1
-		mov	pc, r1				@ no mode switch
-0:
+		@ inside the PE/COFF loader allocated region is unsafe unless
+		@ we explicitly clean it to the PoC.
+		adr	r0, call_cache_fn		@ region of code we will
+		adr	r1, 0f				@ run with MMU off
+		bl	cache_clean_flush
 		bl	cache_off
 
 		@ Set parameters for booting zImage according to boot protocol
@@ -1467,10 +1465,10 @@ ENTRY(efi_enter_kernel)
 		mov	r0, #0
 		mov	r1, #0xFFFFFFFF
 		mov	r2, r4
-		b	__efi_start
+		add	r7, r7, #(__efi_start - start)
+		mov	pc, r7				@ no mode switch
 ENDPROC(efi_enter_kernel)
-		.align	2
-.Ljmp:		.long	start - 0b
+0:
 #endif
 
 		.align
-- 
2.17.1

