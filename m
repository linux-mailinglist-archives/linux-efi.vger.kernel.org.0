Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3794312AD32
	for <lists+linux-efi@lfdr.de>; Thu, 26 Dec 2019 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZPQv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 10:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZPQu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 10:16:50 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317AF20838;
        Thu, 26 Dec 2019 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577373409;
        bh=i8XEMEHCgDyLT/2GG5iWA46A9ZpXWVRInzhr5iTnXDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dceh2tbbvK28m9+IwUaOnDWllfvtahsgxWBjl/sC5D2RD90g/Zz0unz6whOqde+i2
         AavrShFq8VjM8ALdsVCpayeFzzX952o8W89ri1ZNTYCv0YO7AJ4XQF+D3/H8r5c4RB
         HQvfw7CmIiY9lYDQiSePbVsIq5mGyMsEyzIKh1HA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
Date:   Thu, 26 Dec 2019 16:14:07 +0100
Message-Id: <20191226151407.29716-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226151407.29716-1-ardb@kernel.org>
References: <20191226151407.29716-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Calling 32-bit EFI runtime services from a 64-bit OS involves
switching back to the flat mapping with a stack carved out of
memory that is 32-bit addressable.

There is no need to actually execute the 64-bit part of this
routine from the flat mapping as well, as long as the entry
and return address fit in 32 bits. There is also no need to
preserve part of the calling context in global variables: we
can simply preserve the old stack pointer in %r11 across the
call into 32-bit firmware, and use either stack to preserve
other values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_thunk_64.S | 106 ++++++--------------
 1 file changed, 29 insertions(+), 77 deletions(-)

diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 3189f1394701..7357808d3ae8 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -28,11 +28,17 @@
 SYM_FUNC_START(efi64_thunk)
 	push	%rbp
 	push	%rbx
+	movl	%ds, %ebx
+	push	%rbx
+	movl	%es, %ebx
+	push	%rbx
+	movl	%ss, %ebx
+	push	%rbx
 
 	/*
 	 * Switch to 1:1 mapped 32-bit stack pointer.
 	 */
-	movq	%rsp, efi_saved_sp(%rip)
+	movq	%rsp, %r11
 	movq	efi_scratch(%rip), %rsp
 
 	/*
@@ -41,87 +47,41 @@ SYM_FUNC_START(efi64_thunk)
 	movq	$__START_KERNEL_map, %rax
 	subq	phys_base(%rip), %rax
 
-	/*
-	 * Push some physical addresses onto the stack. This is easier
-	 * to do now in a code64 section while the assembler can address
-	 * 64-bit values. Note that all the addresses on the stack are
-	 * 32-bit.
-	 */
-	subq	$16, %rsp
-	leaq	efi_exit32(%rip), %rbx
-	subq	%rax, %rbx
-	movl	%ebx, 8(%rsp)
-
-	leaq	__efi64_thunk(%rip), %rbx
-	subq	%rax, %rbx
-	call	*%rbx
-
-	movq	efi_saved_sp(%rip), %rsp
-	pop	%rbx
-	pop	%rbp
-	retq
-SYM_FUNC_END(efi64_thunk)
-
-/*
- * We run this function from the 1:1 mapping.
- *
- * This function must be invoked with a 1:1 mapped stack.
- */
-SYM_FUNC_START_LOCAL(__efi64_thunk)
-	movl	%ds, %eax
-	push	%rax
-	movl	%es, %eax
-	push	%rax
-	movl	%ss, %eax
-	push	%rax
-
-	subq	$32, %rsp
+	subq	$24, %rsp
 	movl	%esi, 0x0(%rsp)
 	movl	%edx, 0x4(%rsp)
 	movl	%ecx, 0x8(%rsp)
-	movq	%r8, %rsi
-	movl	%esi, 0xc(%rsp)
-	movq	%r9, %rsi
-	movl	%esi,  0x10(%rsp)
-
+	movl	%r8d, 0xc(%rsp)
+	movl	%r9d, 0x10(%rsp)
 	leaq	1f(%rip), %rbx
-	movq	%rbx, func_rt_ptr(%rip)
+	subq	%rax, %rbx
+	movl	%ebx, 0x14(%rsp)
 
 	/* Switch to 32-bit descriptor */
 	pushq	$__KERNEL32_CS
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
+	leaq	efi_enter32(%rip), %rbx
+	subq	%rax, %rbx
+	pushq	%rbx
 	lretq
 
-1:	addq	$32, %rsp
-
+	/*
+	 * Convert 32-bit status code into 64-bit.
+	 */
+1:	btrl	$31, %eax
+	jb	3f
+2:	mov	%r11, %rsp
 	pop	%rbx
 	movl	%ebx, %ss
 	pop	%rbx
 	movl	%ebx, %es
 	pop	%rbx
 	movl	%ebx, %ds
-
-	/*
-	 * Convert 32-bit status code into 64-bit.
-	 */
-	test	%rax, %rax
-	jz	1f
-	movl	%eax, %ecx
-	andl	$0x0fffffff, %ecx
-	andl	$0xf0000000, %eax
-	shl	$32, %rax
-	or	%rcx, %rax
-1:
-	ret
-SYM_FUNC_END(__efi64_thunk)
-
-SYM_FUNC_START_LOCAL(efi_exit32)
-	movq	func_rt_ptr(%rip), %rax
-	push	%rax
-	mov	%rdi, %rax
-	ret
-SYM_FUNC_END(efi_exit32)
+	pop	%rbx
+	pop	%rbp
+	retq
+3:	btsq	$63, %rax
+	jmp	2b
+SYM_FUNC_END(efi64_thunk)
 
 	.code32
 /*
@@ -137,17 +97,9 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 
 	call	*%edi
 
-	/* We must preserve return value */
-	movl	%eax, %edi
-
-	movl	72(%esp), %eax
+	movl	20(%esp), %edi
 	pushl	$__KERNEL_CS
-	pushl	%eax
+	pushl	%edi
 
 	lret
 SYM_FUNC_END(efi_enter32)
-
-	.data
-	.balign	8
-func_rt_ptr:		.quad 0
-efi_saved_sp:		.quad 0
-- 
2.17.1

