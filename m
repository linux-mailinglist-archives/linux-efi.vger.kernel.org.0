Return-Path: <linux-efi+bounces-2537-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE0A0644B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A9D3A6410
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73A200BBE;
	Wed,  8 Jan 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meUEjksK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86813201026
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360574; cv=none; b=l166L5OTB60Xha/FT/ZnmZ6y+QDRuagDJ4ZSmdSvBSNXEa7ehrUOdx2xxhNgTIdE/S3HnV4aNKyAC8TaQsEpU/0q8Wp+INFCF1Mz8pSYTwXpKQkr0qH8A8kp1WZjFinHgmxbAq004tN5C5NEv+J0jvC0wqfOP2PPc4iZpESv5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360574; c=relaxed/simple;
	bh=JqScNhNP0EUKwyQdwToGmexv4nL2LEtECSplL/i5GW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+Fx+UyKMMnCdOif0bursrInBaUTHnTu2Z9ZUBNQTMU2dLkyNavuUtwkoUv7PvxVo6ng0+cB9mFHEOQ/5CXiTBhfMc/uPc4RBrr+BHgqihXF6+6Atta4Mse7Bf/9CKcMxcBIQdEBSu76aduqucKo/talpYzUSYcPVraD85Uw8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meUEjksK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e1339790so47623f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360571; x=1736965371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MULeU0q87nEZRKiBNEJIYAO905XkZ1RQoCMPLQGBYs=;
        b=meUEjksKIF3Jtke62TZltar4nG/hecTx8rMnxc6PPwV9BhMWjT1IjY2xpptSkDIMOU
         oKOpff8WXJawZozigBlwDsfZRCnFvT4NKztpiqx7t5FJW2fAC8qcAIQYo38GQfFIr6Hf
         SmvFCWfnsUb745I2CUqVFYX0n38dBAmG2J4nYMRn5coxwJB2w1wfbxyDdJ4V/AEnFx0z
         JFg4bFnWD4CxD958MPOaeNBa9vxuVnRJU/Dkss6mvVKpnqsD/xr1waGg9jcrfrhFA9Q4
         yM8I3lG1eq2/opK/tP9I5Bwh1WG4EtZI3/iY058K5mC0Rfo86XNwjdnb7woWGbZjFbuX
         OlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360571; x=1736965371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MULeU0q87nEZRKiBNEJIYAO905XkZ1RQoCMPLQGBYs=;
        b=Zxeg8LfDCEcPL7udpGG4eM2NEeYuczQwsPwccnsI2IpJk/8NJr02LkAmrdSt3Sv8nU
         ZNzu7XLWS342+0nnDHWIWi0wf80AJNmkPxSQ2ZWMdj3/BDASUoCsAJZHqKsEmvhv7hS0
         qiT25zT53lKmAR3nISQnBUQzXMxwTYYrtCTelDe7bvKKyC9JMBY9sq3yfUHzUFmVR7mU
         ZtwuiP2jtxY5QG3LavZ4Je4iAXoCD14bAOSIy84vAO8XsWkzUxJ+6HNLYLXLNHb976am
         Rqrr8C1LqAKx++x8Eo/V/8qTr3c2oCRl44OAmb8cMShWkNvX1vsYALvxTIwsKG8LzN9K
         aaSQ==
X-Gm-Message-State: AOJu0Yyqufl4qXo5CUpQjxZVCtuJcwdjnzaoe5lp9T6ZUZx9TkR+Drf5
	MSqlqd+Y1S2y7EeslYziihMhcvqd67VptCyUs7S4ryLR8UdPZ2/XYDM1AX5cQVljpGjlVNgyaWW
	jTEIBEKI3wBb6ZnOtrjfT3vdwMq5yd2PrQ5ku7FmQ9Z1/TnEdg+WAl3qUZDa5Q3v05J1MATWR+O
	eCfODASw86ack6kygBo0YAyNoBAQ==
X-Google-Smtp-Source: AGHT+IEYNlwtXpUorAnTQlC3S22npDjNWQv+6V7VBok5jHS/n9p8/gNP2Qrygdmzc4UDo3ad0Z6GInlD
X-Received: from wmbg19.prod.google.com ([2002:a05:600c:a413:b0:436:1abf:b8fe])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4802:b0:385:e877:c037
 with SMTP id ffacd0b85a97d-38a87338d79mr2764515f8f.42.1736360571107; Wed, 08
 Jan 2025 10:22:51 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:23 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=ardb@kernel.org;
 h=from:subject; bh=06SD9I9ktyMI33HZ8zlJt/DZZorIDT/UL8orpVh2Jq8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUOJ2HT7XF++8P1j8ZQwIqdbYls+ZzuW3qfSvwiJVw
 dmFa906SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERKNRgZ+uwEL+yqOSC6Waro
 V17zxQXh1TePFAnIyEc0XjzZv87EjuGv+MS/nsKsi9ieZZplpvsYaosYKbleLeComS/x6cDzT7c ZAA==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-12-ardb+git@google.com>
Subject: [PATCH 4/6] x86/efi/mixed: Simplify and document thunking logic
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The current boot-time version of the thunk into 32-bit mode, to invoke
EFI services and protocols using the 32-bit calling convention, is a
jumble of argument marshalling code and GDT/IDT and segment register
handling, with an undocumented de facto calling convention that passes
the data segment descriptor, the return address and the GDT/IDT base
pointer for the return in registers EDX, EBP and EBX respectively.

Let's clean this up, and replace this with documented logic that
separates the handling of the segment registers into the 64-bit caller,
and the marshalling of the arguments into the 32-bit callee. Also,
replace the open coded far call with an actual one, removing the need to
pass the return address via a register.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 92 ++++++++++----------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 066f4365af4f..a44e522bbbed 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -80,52 +80,36 @@ SYM_FUNC_START_LOCAL_NOALIGN(startup_64_mixed_mode)
 SYM_FUNC_END(startup_64_mixed_mode)
 
 SYM_FUNC_START(__efi64_thunk)
-	push	%rbp
 	push	%rbx
 
-	/* Copy args passed on stack */
-	movq	0x18(%rsp), %rbp
-	movq	0x20(%rsp), %rbx
-	movq	0x28(%rsp), %rax
-
-	/*
-	 * Convert x86-64 ABI params to i386 ABI
-	 */
-	subq	$64, %rsp
-	movl	%esi, 0x0(%rsp)
-	movl	%edx, 0x4(%rsp)
-	movl	%ecx, 0x8(%rsp)
-	movl	%r8d, 0xc(%rsp)
-	movl	%r9d, 0x10(%rsp)
-	movl	%ebp, 0x14(%rsp)
-	movl	%ebx, 0x18(%rsp)
-	movl	%eax, 0x1c(%rsp)
-
-	leaq	0x20(%rsp), %rbx
-	sgdt	(%rbx)
-	sidt	16(%rbx)
-
-	leaq	1f(%rip), %rbp
+	/* Store live GDT and IDT descriptors */
+	subq	$16, %rsp
+	sgdt	(%rsp)
+	sidt	6(%rsp)
 
 	/*
 	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
 	 * GDT and IDT that were installed when the kernel started executing.
 	 * The pointers were saved by the efi32_entry() routine below.
-	 *
-	 * Pass the saved DS selector to the 32-bit code, and use far return to
-	 * restore the saved CS selector.
 	 */
 	lidt	efi32_boot_idt(%rip)
 	lgdt	efi32_boot_gdt(%rip)
 
-	movzwl	efi32_boot_ds(%rip), %edx
-	movzwq	efi32_boot_cs(%rip), %rax
-	pushq	%rax
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
-	lretq
+	/* Reload firmware's data segment selectors */
+	movw	efi32_boot_ds(%rip), %bx
+	movl	%ebx, %ds
+	movl	%ebx, %es
+	movl	%ebx, %ss
+	movl	%ebx, %fs
+	movl	%ebx, %gs
+
+	/* Move args #5 and #6 into 32-bit accessible registers */
+	movl	%r8d, %eax
+	movl	%r9d, %ebx
 
-1:	addq	$64, %rsp
+	lcalll	*efi32_thunk(%rip)
+
+	addq	$16, %rsp
 	movq	%rdi, %rax
 
 	/* Clear out 32-bit segment selectors */
@@ -137,7 +121,6 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ebx, %gs
 
 	pop	%rbx
-	pop	%rbp
 	RET
 SYM_FUNC_END(__efi64_thunk)
 
@@ -163,17 +146,27 @@ SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 /*
- * EFI service pointer must be in %edi.
+ * Called using a far call from 64-bit code, using the x86_64 SysV ABI (except
+ * for R8/R9 which are inaccessible to 32-bit code - EAX/EBX are used instead).
+ *
+ * The first argument (EDI) is a pointer to the boot service or protocol, to
+ * which the remaining arguments are passed, each truncated to 32 bits.
  *
- * The stack should represent the 32-bit calling convention.
+ * Entered with ESP+40 pointing to the arguments passed via the stack, and with
+ * the 64-bit mode GDT and IDT descriptors at ESP+8 and ESP+14, respectively.
  */
 SYM_FUNC_START_LOCAL(efi_enter32)
-	/* Load firmware selector into data and stack segment registers */
-	movl	%edx, %ds
-	movl	%edx, %es
-	movl	%edx, %fs
-	movl	%edx, %gs
-	movl	%edx, %ss
+	/*
+	 * Convert x86-64 SysV ABI params to i386 ABI
+	 */
+	pushl	56(%esp)	/* Up to 3 args passed via the caller's stack */
+	pushl	52(%esp)
+	pushl	48(%esp)
+	pushl	%ebx		/* R9 */
+	pushl	%eax		/* R8 */
+	pushl	%ecx
+	pushl	%edx
+	pushl	%esi
 
 	/* Reload pgtables */
 	movl	%cr3, %eax
@@ -201,8 +194,9 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	lidtl	16(%ebx)
-	lgdtl	(%ebx)
+	addl	$32, %esp
+	lidtl	14(%esp)
+	lgdtl	8(%esp)
 
 	movl	%cr4, %eax
 	btsl	$(X86_CR4_PAE_BIT), %eax
@@ -219,9 +213,6 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	xorl	%eax, %eax
 	lldt	%ax
 
-	pushl	$__KERNEL_CS
-	pushl	%ebp
-
 	/* Enable paging */
 	movl	%cr0, %eax
 	btsl	$X86_CR0_PG_BIT, %eax
@@ -250,6 +241,10 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
 	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
 
+	/* Fix up absolute reference */
+	leal	(efi32_thunk - 1b)(%ebx), %eax
+	addl	%eax, (%eax)
+
 	/* Store firmware IDT descriptor */
 	sidtl	(efi32_boot_idt - 1b)(%ebx)
 
@@ -351,6 +346,7 @@ SYM_DATA_END(efi32_boot_idt)
 
 	.data
 	.balign	4
+SYM_DATA_LOCAL(efi32_thunk, .long efi_enter32 - .)
 SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
 SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
 SYM_DATA(efi_is64, .byte 1)
-- 
2.47.1.613.gc27f4b7a9f-goog


