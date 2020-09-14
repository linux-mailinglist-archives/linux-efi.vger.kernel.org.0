Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F552688E7
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgINJ6O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgINJ6N (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:58:13 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3061D20735;
        Mon, 14 Sep 2020 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077492;
        bh=77RIzJYqzlmKEeo4Ksd7J+ddgYyfqCTidiKyeJAjbLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5+J05zaCKdaonqfYWnG4GkCswxWHBEuzx5BYysTrZ70lqnJ3BUi0EfnVSklZQQm+
         UPGfiLWoRjv2Ssntm0x9ov2aChKYUgdVUX5nBksu7OSNAObD9TFN3ILNvBdFlKpHM2
         TqC1fdWrQqxdjfg/hHOhIVTtC+kQN42qp1xsqmnM=
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
Subject: [PATCH 12/12] ARM: kvm: replace open coded VA->PA calculations with adr_l call
Date:   Mon, 14 Sep 2020 12:57:06 +0300
Message-Id: <20200914095706.3985-13-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded calculations of the actual physical address
of the KVM stub vector table with a single adr_l invocation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 15 ++---------
 arch/arm/kernel/hyp-stub.S      | 27 +++++++++-----------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6a430d1f4d31..ab800f7e0dc1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -472,15 +472,10 @@ dtb_check_done:
 
 		/*
 		 * Compute the address of the hyp vectors after relocation.
-		 * This requires some arithmetic since we cannot directly
-		 * reference __hyp_stub_vectors in a PC-relative way.
 		 * Call __hyp_set_vectors with the new address so that we
 		 * can HVC again after the copy.
 		 */
-0:		adr	r0, 0b
-		movw	r1, #:lower16:__hyp_stub_vectors - 0b
-		movt	r1, #:upper16:__hyp_stub_vectors - 0b
-		add	r0, r0, r1
+		adr_l	r0, __hyp_stub_vectors
 		sub	r0, r0, r5
 		add	r0, r0, r10
 		bl	__hyp_set_vectors
@@ -631,17 +626,11 @@ not_relocated:	mov	r0, #0
 		cmp	r0, #HYP_MODE		@ if not booted in HYP mode...
 		bne	__enter_kernel		@ boot kernel directly
 
-		adr	r12, .L__hyp_reentry_vectors_offset
-		ldr	r0, [r12]
-		add	r0, r0, r12
-
+		adr_l	r0, __hyp_reentry_vectors
 		bl	__hyp_set_vectors
 		__HVC(0)			@ otherwise bounce to hyp mode
 
 		b	.			@ should never be reached
-
-		.align	2
-.L__hyp_reentry_vectors_offset:	.long	__hyp_reentry_vectors - .
 #else
 		b	__enter_kernel
 #endif
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 26d8e03b1dd3..103d0bdb2b7e 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -24,41 +24,38 @@ ENTRY(__boot_cpu_mode)
 .text
 
 	/*
-	 * Save the primary CPU boot mode. Requires 3 scratch registers.
+	 * Save the primary CPU boot mode. Requires 2 scratch registers.
 	 */
-	.macro	store_primary_cpu_mode	reg1, reg2, reg3
+	.macro	store_primary_cpu_mode	reg1, reg2
 	mrs	\reg1, cpsr
 	and	\reg1, \reg1, #MODE_MASK
-	adr	\reg2, .L__boot_cpu_mode_offset
-	ldr	\reg3, [\reg2]
-	str	\reg1, [\reg2, \reg3]
+	str_l	\reg1, __boot_cpu_mode, \reg2
 	.endm
 
 	/*
 	 * Compare the current mode with the one saved on the primary CPU.
 	 * If they don't match, record that fact. The Z bit indicates
 	 * if there's a match or not.
-	 * Requires 3 additionnal scratch registers.
+	 * Requires 2 additional scratch registers.
 	 */
-	.macro	compare_cpu_mode_with_primary mode, reg1, reg2, reg3
-	adr	\reg2, .L__boot_cpu_mode_offset
-	ldr	\reg3, [\reg2]
-	ldr	\reg1, [\reg2, \reg3]
+	.macro	compare_cpu_mode_with_primary mode, reg1, reg2
+	adr_l	\reg2, __boot_cpu_mode
+	ldr	\reg1, [\reg2]
 	cmp	\mode, \reg1		@ matches primary CPU boot mode?
 	orrne	\reg1, \reg1, #BOOT_CPU_MODE_MISMATCH
-	strne	\reg1, [\reg2, \reg3]	@ record what happened and give up
+	strne	\reg1, [\reg2]		@ record what happened and give up
 	.endm
 
 #else	/* ZIMAGE */
 
-	.macro	store_primary_cpu_mode	reg1:req, reg2:req, reg3:req
+	.macro	store_primary_cpu_mode	reg1:req, reg2:req
 	.endm
 
 /*
  * The zImage loader only runs on one CPU, so we don't bother with mult-CPU
  * consistency checking:
  */
-	.macro	compare_cpu_mode_with_primary mode, reg1, reg2, reg3
+	.macro	compare_cpu_mode_with_primary mode, reg1, reg2
 	cmp	\mode, \mode
 	.endm
 
@@ -73,7 +70,7 @@ ENTRY(__boot_cpu_mode)
  */
 @ Call this from the primary CPU
 ENTRY(__hyp_stub_install)
-	store_primary_cpu_mode	r4, r5, r6
+	store_primary_cpu_mode	r4, r5
 ENDPROC(__hyp_stub_install)
 
 	@ fall through...
@@ -87,7 +84,7 @@ ENTRY(__hyp_stub_install_secondary)
 	 * If the secondary has booted with a different mode, give up
 	 * immediately.
 	 */
-	compare_cpu_mode_with_primary	r4, r5, r6, r7
+	compare_cpu_mode_with_primary	r4, r5, r6
 	retne	lr
 
 	/*
-- 
2.17.1

