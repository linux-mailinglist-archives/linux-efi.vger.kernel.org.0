Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE18133C69
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 08:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAHHpM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 02:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAHHpM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jan 2020 02:45:12 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B70F20848;
        Wed,  8 Jan 2020 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578469511;
        bh=1ojnhk2gxkn8EqZNcy6WFPVlkiRM+cxQwg33Way/meY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIpZr3bUQXhE2i7WmtZLEPa8JXuN2jJVTvq650t6tlgMFbJ0xfO+MhuZqOAn3QG1K
         MmoffTYbbW3v6BhhwgS/V17/stsjB7N+5Ab9GpREa1qrRjq1rscGiTJdhfI7RPAXha
         9oIgOc4yb+H1pqBsTZalDWSpWWc4YXTFkxqUoB/Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     luto@kernel.org, x86@kernel.org, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi/libstub/x86: use mandatory 16-byte stack alignment in mixed mode
Date:   Wed,  8 Jan 2020 08:45:02 +0100
Message-Id: <20200108074502.10960-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108074502.10960-1-ardb@kernel.org>
References: <20200108074502.10960-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reduce the stack frame of the EFI stub's mixed mode thunk routine by
8 bytes, by moving the GDT and return addresses to EBP and EBX, which
we need to preserve anyway, since their top halves will be cleared by
the call into 32-bit firmware code. Doing so results in the UEFI code
being entered with a 16 byte aligned stack, as mandated by the UEFI
spec, fixing the last occurrence in the 64-bit kernel where we violate
this requirement.

Also, move the saved GDT from a global variable to an unused part of the
stack frame, and touch up some other parts of the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 46 ++++++--------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index d040ff5458e5..8fb7f6799c52 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -27,12 +27,9 @@ SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
-	subq	$8, %rsp
-	leaq	1f(%rip), %rax
-	movl	%eax, 4(%rsp)
-	leaq	efi_gdt64(%rip), %rax
-	movl	%eax, (%rsp)
-	movl	%eax, 2(%rax)		/* Fixup the gdt base address */
+	leaq	1f(%rip), %rbp
+	leaq	efi_gdt64(%rip), %rbx
+	movl	%ebx, 2(%rbx)		/* Fixup the gdt base address */
 
 	movl	%ds, %eax
 	push	%rax
@@ -48,12 +45,10 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%esi, 0x0(%rsp)
 	movl	%edx, 0x4(%rsp)
 	movl	%ecx, 0x8(%rsp)
-	movq	%r8, %rsi
-	movl	%esi, 0xc(%rsp)
-	movq	%r9, %rsi
-	movl	%esi,  0x10(%rsp)
+	movl	%r8d, 0xc(%rsp)
+	movl	%r9d, 0x10(%rsp)
 
-	sgdt	save_gdt(%rip)
+	sgdt	0x14(%rsp)
 
 	/*
 	 * Switch to gdt with 32-bit segments. This is the firmware GDT
@@ -68,11 +63,10 @@ SYM_FUNC_START(__efi64_thunk)
 	pushq	%rax
 	lretq
 
-1:	addq	$32, %rsp
+1:	lgdt	0x14(%rsp)
+	addq	$32, %rsp
 	movq	%rdi, %rax
 
-	lgdt	save_gdt(%rip)
-
 	pop	%rbx
 	movl	%ebx, %ss
 	pop	%rbx
@@ -83,15 +77,9 @@ SYM_FUNC_START(__efi64_thunk)
 	/*
 	 * Convert 32-bit status code into 64-bit.
 	 */
-	test	%rax, %rax
-	jz	1f
-	movl	%eax, %ecx
-	andl	$0x0fffffff, %ecx
-	andl	$0xf0000000, %eax
-	shl	$32, %rax
-	or	%rcx, %rax
-1:
-	addq	$8, %rsp
+	roll	$1, %eax
+	rorq	$1, %rax
+
 	pop	%rbx
 	pop	%rbp
 	ret
@@ -135,9 +123,7 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	movl	56(%esp), %eax
-	movl	%eax, 2(%eax)
-	lgdtl	(%eax)
+	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
 	btsl	$(X86_CR4_PAE_BIT), %eax
@@ -154,9 +140,8 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	xorl	%eax, %eax
 	lldt	%ax
 
-	movl	60(%esp), %eax
 	pushl	$__KERNEL_CS
-	pushl	%eax
+	pushl	%ebp
 
 	/* Enable paging */
 	movl	%cr0, %eax
@@ -172,11 +157,6 @@ SYM_DATA_START(efi32_boot_gdt)
 	.quad	0
 SYM_DATA_END(efi32_boot_gdt)
 
-SYM_DATA_START_LOCAL(save_gdt)
-	.word	0
-	.quad	0
-SYM_DATA_END(save_gdt)
-
 SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
-- 
2.20.1

