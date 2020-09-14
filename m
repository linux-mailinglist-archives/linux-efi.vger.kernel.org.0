Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB92688E1
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgINJ5t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ5s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:48 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A1E20732;
        Mon, 14 Sep 2020 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077468;
        bh=Wkk64XuID7r9R1jYYqwP5aBOfNogdTl+OiAJ/dFmveI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fR20cE2OUxGxtkPOvbgPhceoIQMNNLlPvb+J5wHhlLztBQ15T/8VZcmxvctJcLf84
         tvkegZjd1D2h9+4VPwu1Q+V5+nqFyjeeyxhV8KSLZWvPL2uolHmZTVR0qvyt8+CAJz
         B6CaC88fZgExSVbrSfplllfDP1rmYEKFynUHmcjs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 06/12] ARM: head.S: use PC-relative insn sequence for secondary_data
Date:   Mon, 14 Sep 2020 12:57:00 +0300
Message-Id: <20200914095706.3985-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded PC relative offset calculations with adr_l
and ldr_l invocations. This removes some open coded arithmetic
involving virtual addresses, avoids literal pools on v7+, and slightly
reduces the footprint of the code.

Note that it also removes a stale comment about the contents of r6.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 7d8e2a296216..40407a4727e0 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -383,10 +383,8 @@ ENTRY(secondary_startup)
 	/*
 	 * Use the page tables supplied from  __cpu_up.
 	 */
-	adr	r4, __secondary_data
-	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	lr, r4, r5			@ mmu has been enabled
-	add	r3, r7, lr
+	adr_l	r3, secondary_data
+	mov_l	r12, __secondary_switched
 	ldrd	r4, r5, [r3, #0]		@ get secondary_data.pgdir
 ARM_BE8(eor	r4, r4, r5)			@ Swap r5 and r4 in BE:
 ARM_BE8(eor	r5, r4, r5)			@ it can be done in 3 steps
@@ -401,22 +399,13 @@ ARM_BE8(eor	r4, r4, r5)			@ without using a temp reg.
 ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
 
-	/*
-	 * r6  = &secondary_data
-	 */
 ENTRY(__secondary_switched)
-	ldr	sp, [r7, #12]			@ get secondary_data.stack
+	ldr_l	r7, secondary_data + 12		@ get secondary_data.stack
+	mov	sp, r7
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
-	.align
-
-	.type	__secondary_data, %object
-__secondary_data:
-	.long	.
-	.long	secondary_data
-	.long	__secondary_switched
 #endif /* defined(CONFIG_SMP) */
 
 
-- 
2.17.1

