Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5312688E4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgINJ6C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgINJ6A (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:58:00 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E5C20735;
        Mon, 14 Sep 2020 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077480;
        bh=/zG/B+OqMvKbdy1EmPObIWMcMF3D5hnFDJTN3qdBLOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRLgaYoVYARKsxIcvj9cUw0GvKATscmVNGsXLaDp7Coif+zIMk3VSkdVyYhLFu4Jj
         gZXgnvHUaifv7RHYfMNgNxp7KRaDnAePM1nIp8oo16DVa0O1pziIyEswAnfuYSd1eF
         WqdpYqYfVv2AZYkiFZGBqlM3sqFn34MmYIEDNT4Y=
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
Subject: [PATCH 09/12] ARM: sleep.S: use PC-relative insn sequence for sleep_save_sp/mpidr_hash
Date:   Mon, 14 Sep 2020 12:57:03 +0300
Message-Id: <20200914095706.3985-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded PC relative offset calculations with adr_l and
ldr_l invocations. This removes some open coded PC relative arithmetic,
avoids literal pools on v7+, and slightly reduces the footprint of the
code. Note that ALT_SMP() expects a single instruction so move the macro
invocation after it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/sleep.S | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 5dc8b80bb693..43077e11dafd 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -72,8 +72,9 @@ ENTRY(__cpu_suspend)
 	ldr	r3, =sleep_save_sp
 	stmfd	sp!, {r0, r1}		@ save suspend func arg and pointer
 	ldr	r3, [r3, #SLEEP_SAVE_SP_VIRT]
-	ALT_SMP(ldr r0, =mpidr_hash)
+	ALT_SMP(W(nop))			@ don't use adr_l inside ALT_SMP()
 	ALT_UP_B(1f)
+	adr_l	r0, mpidr_hash
 	/* This ldmia relies on the memory layout of the mpidr_hash struct */
 	ldmia	r0, {r1, r6-r8}	@ r1 = mpidr mask (r6,r7,r8) = l[0,1,2] shifts
 	compute_mpidr_hash	r0, r6, r7, r8, r2, r1
@@ -147,9 +148,8 @@ no_hyp:
 	mov	r1, #0
 	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
 	ALT_UP_B(1f)
-	adr	r2, mpidr_hash_ptr
-	ldr	r3, [r2]
-	add	r2, r2, r3		@ r2 = struct mpidr_hash phys address
+	adr_l	r2, mpidr_hash		@ r2 = struct mpidr_hash phys address
+
 	/*
 	 * This ldmia relies on the memory layout of the mpidr_hash
 	 * struct mpidr_hash.
@@ -157,10 +157,7 @@ no_hyp:
 	ldmia	r2, { r3-r6 }	@ r3 = mpidr mask (r4,r5,r6) = l[0,1,2] shifts
 	compute_mpidr_hash	r1, r4, r5, r6, r0, r3
 1:
-	adr	r0, _sleep_save_sp
-	ldr	r2, [r0]
-	add	r0, r0, r2
-	ldr	r0, [r0, #SLEEP_SAVE_SP_PHYS]
+	ldr_l	r0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
 	ldr	r0, [r0, r1, lsl #2]
 
 	@ load phys pgd, stack, resume fn
@@ -177,12 +174,6 @@ ENDPROC(cpu_resume_arm)
 ENDPROC(cpu_resume_no_hyp)
 #endif
 
-	.align 2
-_sleep_save_sp:
-	.long	sleep_save_sp - .
-mpidr_hash_ptr:
-	.long	mpidr_hash - .			@ mpidr_hash struct offset
-
 	.data
 	.align	2
 	.type	sleep_save_sp, #object
-- 
2.17.1

