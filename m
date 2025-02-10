Return-Path: <linux-efi+bounces-2781-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E165EA2F5E0
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50CF3A84CC
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A9256C69;
	Mon, 10 Feb 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5T6/Kny"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C42566E8
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209815; cv=none; b=amhJbMZfb0zbfT7stFeZYCjRvnUTfN5jsnbwShzYTzg0+ETp4URC6Ep6dw61c3ao2VGdC933WU57pXT1aZFijVRePznCAEmiG6B4sU5eCF1RjJi31LBKhleikW1XBvOo1eVm5i9/jWXJqR1UKaQ2eBAxMW2yTcQWMS48R4pHZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209815; c=relaxed/simple;
	bh=RhCgnWZ9ZIivzE3UX2zteqDlKIKGz2XoML7SymksA48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rpo0/sRnaZIG3XAFW1+QG8CNGA0fLYVgwsWH9HP0x7siFTCRQ1Kg5T1nKMllWAjmSfttUVUGlcuudDAOGynS7/R1Tk1DjeBOfmSjJzAzJveetlT3amettVL+fjl57DRAAK1RP+nZivvjmy0Q2uy/hr7AHDqLQk8nIU6nM+a/uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5T6/Kny; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-439385b08d1so14156915e9.1
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209811; x=1739814611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkHSm3nFrWe2qkbNOypQL173sC1ybsFxg1WLBfNOstk=;
        b=T5T6/KnyVh8Jd5idPJ2cNghR9T8WAwoshd3vVTKS1CYH+JvLJuedDXm6M1X3noavz3
         a5PPwyGUdRXFYDu6/SAVbixJuMI+AVRpY54AeetFBrhU0ekXr4gzQ7c7XCMxidSAwbtf
         0JwTqaZh3aXZHsWPq//J/NiX+adj867Q8drV20tx3LK+InUJFsZV7UA/pAwNGJRYxAHI
         AOhy4V3nV5Uh3YdxPZSmIRubiSNFWqEnTGPESBc7tk026pQEqQwgT/bIaSU8cUgP40gf
         JSl4hrFdBU8SoVpR6KVZpZ35sb5/DHw4V1winrBbiBLwUHhYA2EZusoboJULoJ02sidk
         wnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209811; x=1739814611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkHSm3nFrWe2qkbNOypQL173sC1ybsFxg1WLBfNOstk=;
        b=kDdQubnuRvjrNKGHl8dU7wsuvIaCv4VHsRLzT2Qlubz68p773fiRHBAN1jndiBewxI
         vcANIuMyQfm50LWx8/0t9yKROf4lqFVqFGm+fG5xr8qSnWvD/oPuGByRlP9sGTtE67FP
         7dIppFB87IazXmp6mOh3kRanntaR71qXmFdB56Hc2kF+hiXGY+FPBiTEgiOql0SQdYPi
         2eh6CrKk9pF3Nb+iHZ7SadJ7WEP2Q71aAkxrkUP0gVMVGpkFZDycDn1UKS9kcGU0Vixw
         JhSP6nXwuy8uIvqkrwpnw2lc3EIylIvpgo+So4ZWR2qY5JKdNq4t/C8y4mKJ+QC4CU8y
         nviA==
X-Gm-Message-State: AOJu0Yy4j8t8+4hCBc1Yj24yFA8d90O3+Wlsqs1E+3FflJc0QyDYuekL
	OVTrXSaPQSUPt3DxfF6tZAiU6m5BzJ3Sld4OKhYKv/mxgl3fZL38XSWT/Iyt9a/PEXcldUmtKGX
	d4ZuWxtFg6fxWr+N2N6jn7WQ8f/YqMNM6ZWFQH4UZEi8iC9abAl6QQE+7wVi2fYnHdctHLMp3Ep
	pb6dlawJOnFu6V1sDPfJ7ZTAztNQ==
X-Google-Smtp-Source: AGHT+IGb2eO16cVGwjpqCVoPfyo2bJWxNAYQw/3FS7pPE/rc9D7weRiU6tQCRMQN/rg5FKZbm5803Mz5
X-Received: from wmpz12.prod.google.com ([2002:a05:600c:a0c:b0:435:51:727b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c3:b0:42c:c28c:e477
 with SMTP id 5b1f17b1804b1-43925f56263mr108752915e9.23.1739209811073; Mon, 10
 Feb 2025 09:50:11 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:47 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11401; i=ardb@kernel.org;
 h=from:subject; bh=a/4jm8fa7VhuTfEsMN2hOjD+QudmHq3bVwODumrNJtk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjVWrZ4KDwelPW5QmRzSUM17oWHA8j+MK+xuLz1PqL
 z/q92nuKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZbcnwT1laOuWh5WvbkxNN
 ijV4TsjWaX15LPwvqUDr5UaN9BK17YwMN+yPpqWzXny1vynZ4YZm/BXFkP+MF3U3Odq1bXxRmmT OAQA=
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-14-ardb+git@google.com>
Subject: [PATCH v2 5/7] x86/efi/mixed: Remove dependency on legacy startup_32 code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI mixed mode startup code calls into startup_32() in the legacy
decompressor, passing a mocked up boot_params struct, only to get it to
set up the 1:1 mapping of the lower 4 GiB of memory and switch to a GDT
that supports 64-bit mode.

In order to be able to reuse the EFI mixed mode startup code in EFI boot
images that do not incorporate the legacy decompressor code, decouple
it, by populating the GDT directly.

Doing so allows constructing a GDT that is compatible with the one the
firmware uses, with one additional entry for a 64-bit mode code segment
appended. This removes the need entirely to switch between GDTs and IDTs
or data segment selector values on every call into the firmware, and all
of this code can be removed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 227 ++++++--------------
 arch/x86/boot/compressed/head_64.S   |   7 -
 2 files changed, 65 insertions(+), 169 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index dca916c3e6f0..984956931ed7 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -15,70 +15,23 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/asm-offsets.h>
+#include <asm/desc_defs.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
 #include <asm/pgtable_types.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
-#include <asm/setup.h>
 
 	.code64
 	.text
-/*
- * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
- * is the first thing that runs after switching to long mode. Depending on
- * whether the EFI handover protocol or the compat entry point was used to
- * enter the kernel, it will either branch to the common 64-bit EFI stub
- * entrypoint efi_stub_entry() directly, or via the 64-bit EFI PE/COFF
- * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
- * struct bootparams pointer as the third argument, so the presence of such a
- * pointer is used to disambiguate.
- *
- *                                                             +--------------+
- *  +------------------+     +------------+            +------>| efi_pe_entry |
- *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
- *  +------------------+     |            |     +------+----------------+  |
- *                           | startup_32 |---->| startup_64_mixed_mode |  |
- *  +------------------+     |            |     +------+----------------+  |
- *  | efi32_stub_entry |---->|            |            |                   |
- *  +------------------+     +------------+            |                   |
- *                                                     V                   |
- *                           +------------+     +----------------+         |
- *                           | startup_64 |<----| efi_stub_entry |<--------+
- *                           +------------+     +----------------+
- */
-SYM_FUNC_START(startup_64_mixed_mode)
-	lea	efi32_boot_args(%rip), %rdx
-	mov	0(%rdx), %edi
-	mov	4(%rdx), %esi
-
-	leaq	(pte + 5 * PAGE_SIZE)(%rip), %rax
-	movq	%rax, %cr3		// reload after startup_32
-
-	/* Switch to the firmware's stack */
-	movl	efi32_boot_sp(%rip), %esp
-	andl	$~7, %esp
-
-	mov	8(%rdx), %edx		// saved bootparams pointer
-	call	efi_stub_entry
-SYM_FUNC_END(startup_64_mixed_mode)
-
 SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
-	movl	%ds, %eax
-	push	%rax
-	movl	%es, %eax
-	push	%rax
-	movl	%ss, %eax
-	push	%rax
-
 	/* Copy args passed on stack */
-	movq	0x30(%rsp), %rbp
-	movq	0x38(%rsp), %rbx
-	movq	0x40(%rsp), %rax
+	movq	0x18(%rsp), %rbp
+	movq	0x20(%rsp), %rbx
+	movq	0x28(%rsp), %rax
 
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
@@ -93,44 +46,14 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ebx, 0x18(%rsp)
 	movl	%eax, 0x1c(%rsp)
 
-	leaq	0x20(%rsp), %rbx
-	sgdt	(%rbx)
-	sidt	16(%rbx)
-
 	leaq	1f(%rip), %rbp
+	movl	%cs, %ebx
 
-	/*
-	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
-	 * GDT and IDT that were installed when the kernel started executing.
-	 * The pointers were saved by the efi32_entry() routine below.
-	 *
-	 * Pass the saved DS selector to the 32-bit code, and use far return to
-	 * restore the saved CS selector.
-	 */
-	lidt	efi32_boot_idt(%rip)
-	lgdt	efi32_boot_gdt(%rip)
-
-	movzwl	efi32_boot_ds(%rip), %edx
-	movzwq	efi32_boot_cs(%rip), %rax
-	pushq	%rax
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
-	lretq
+	ljmpl	*efi32_call(%rip)
 
 1:	addq	$64, %rsp
 	movq	%rdi, %rax
 
-	pop	%rbx
-	movl	%ebx, %ss
-	pop	%rbx
-	movl	%ebx, %es
-	pop	%rbx
-	movl	%ebx, %ds
-	/* Clear out 32-bit selector from FS and GS */
-	xorl	%ebx, %ebx
-	movl	%ebx, %fs
-	movl	%ebx, %gs
-
 	pop	%rbx
 	pop	%rbp
 	RET
@@ -141,7 +64,6 @@ SYM_FUNC_END(__efi64_thunk)
 SYM_FUNC_START(efi32_stub_entry)
 	call	1f
 1:	popl	%ecx
-	leal	(efi32_boot_args - 1b)(%ecx), %ebx
 
 	/* Clear BSS */
 	xorl	%eax, %eax
@@ -153,11 +75,8 @@ SYM_FUNC_START(efi32_stub_entry)
 	rep	stosl
 
 	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
-	movl	%esi, 8(%ebx)
-	jmp	efi32_entry
+	movl	8(%esp), %ebx		/* struct boot_params pointer */
+	jmp	efi32_startup
 SYM_FUNC_END(efi32_stub_entry)
 #endif
 
@@ -167,13 +86,6 @@ SYM_FUNC_END(efi32_stub_entry)
  * The stack should represent the 32-bit calling convention.
  */
 SYM_FUNC_START_LOCAL(efi_enter32)
-	/* Load firmware selector into data and stack segment registers */
-	movl	%edx, %ds
-	movl	%edx, %es
-	movl	%edx, %fs
-	movl	%edx, %gs
-	movl	%edx, %ss
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -190,21 +102,9 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	/* We must preserve return value */
 	movl	%eax, %edi
 
-	/*
-	 * Some firmware will return with interrupts enabled. Be sure to
-	 * disable them before we switch GDTs and IDTs.
-	 */
-	cli
-
-	lidtl	16(%ebx)
-	lgdtl	(%ebx)
-
-	xorl	%eax, %eax
-	lldt	%ax
-
 	call	efi32_enable_long_mode
 
-	pushl	$__KERNEL_CS
+	pushl	%ebx
 	pushl	%ebp
 	lret
 SYM_FUNC_END(efi_enter32)
@@ -230,50 +130,56 @@ SYM_FUNC_START_LOCAL(efi32_enable_long_mode)
 SYM_FUNC_END(efi32_enable_long_mode)
 
 /*
- * This is the common EFI stub entry point for mixed mode.
+ * This is the common EFI stub entry point for mixed mode. It sets up the GDT
+ * and page tables needed for 64-bit execution, after which it calls the
+ * common 64-bit EFI entrypoint efi_stub_entry().
  *
- * Arguments:	%ecx	image handle
- * 		%edx	EFI system table pointer
+ * Arguments:	0(%esp)	image handle
+ * 		4(%esp)	EFI system table pointer
+ *		%ebx	struct boot_params pointer (or NULL)
  *
  * Since this is the point of no return for ordinary execution, no registers
  * are considered live except for the function parameters. [Note that the EFI
  * stub may still exit and return to the firmware using the Exit() EFI boot
  * service.]
  */
-SYM_FUNC_START_LOCAL(efi32_entry)
-	call	1f
-1:	pop	%ebx
-
-	/* Save firmware GDTR and code/data selectors */
-	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
-	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
-	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
-
-	/* Store firmware IDT descriptor */
-	sidtl	(efi32_boot_idt - 1b)(%ebx)
-
-	/* Store firmware stack pointer */
-	movl	%esp, (efi32_boot_sp - 1b)(%ebx)
-
-	/* Store boot arguments */
-	leal	(efi32_boot_args - 1b)(%ebx), %ebx
-	movl	%ecx, 0(%ebx)
-	movl	%edx, 4(%ebx)
-	movb	$0x0, 12(%ebx)          // efi_is64
-
-	/*
-	 * Allocate some memory for a temporary struct boot_params, which only
-	 * needs the minimal pieces that startup_32() relies on.
-	 */
-	subl	$PARAM_SIZE, %esp
-	movl	%esp, %esi
-	movl	$PAGE_SIZE, BP_kernel_alignment(%esi)
-	movl	$_end - 1b, BP_init_size(%esi)
-	subl	$startup_32 - 1b, BP_init_size(%esi)
+SYM_FUNC_START_LOCAL(efi32_startup)
+	movl	%esp, %ebp
+
+	subl	$8, %esp
+	sgdtl	(%esp)			/* Save GDT descriptor to the stack */
+	movl	2(%esp), %esi		/* Existing GDT pointer */
+	movzwl	(%esp), %ecx		/* Existing GDT limit */
+	inc	%ecx			/* Existing GDT size */
+	andl	$~7, %ecx		/* Ensure size is multiple of 8 */
+
+	subl	%ecx, %esp		/* Allocate new GDT */
+	andl	$~15, %esp		/* Realign the stack */
+	movl	%esp, %edi		/* New GDT address */
+	leal	7(%ecx), %eax		/* New GDT limit */
+	pushw	%cx			/* Push 64-bit CS (for LJMP below) */
+	pushl	%edi			/* Push new GDT address */
+	pushw	%ax			/* Push new GDT limit */
+
+	/* Copy GDT to the stack and add a 64-bit code segment at the end */
+	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) & 0xffffffff, (%edi,%ecx)
+	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) >> 32, 4(%edi,%ecx)
+	shrl	$2, %ecx
+	cld
+	rep	movsl			/* Copy the firmware GDT */
+	lgdtl	(%esp)			/* Switch to the new GDT */
 
 	call	1f
 1:	pop	%edi
 
+	/* Record mixed mode entry */
+	movb	$0x0, (efi_is64 - 1b)(%edi)
+
+	/* Set up indirect far call to re-enter 32-bit mode */
+	leal	(efi32_call - 1b)(%edi), %eax
+	addl	%eax, (%eax)
+	movw	%cs, 4(%eax)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -297,8 +203,17 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	movl	%edx, (%eax)
 	movl	%eax, %cr3
 
-	jmp	startup_32
-SYM_FUNC_END(efi32_entry)
+	call	efi32_enable_long_mode
+
+	/* Set up far jump to 64-bit mode (CS is already on the stack) */
+	leal	(efi_stub_entry - 1b)(%edi), %eax
+	movl	%eax, 2(%esp)
+
+	movl	0(%ebp), %edi
+	movl	4(%ebp), %esi
+	movl	%ebx, %edx
+	ljmpl	*2(%esp)
+SYM_FUNC_END(efi32_startup)
 
 /*
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
@@ -313,10 +228,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	btl	$29, %edx			// check long mode bit
 	jnc	1f
 	leal	8(%esp), %esp			// preserve stack alignment
-	movl	(%esp), %ecx			// image_handle
-	movl	4(%esp), %edx			// sys_table
-	jmp	efi32_entry			// pass %ecx, %edx
-						// no other registers remain live
+	xor	%ebx, %ebx			// no struct boot_params pointer
+	jmp	efi32_startup			// only ESP and EBX remain live
 1:	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	popl	%ebx
 	RET
@@ -332,20 +245,10 @@ SYM_FUNC_END(efi64_stub_entry)
 
 	.data
 	.balign	8
-SYM_DATA_START_LOCAL(efi32_boot_gdt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_gdt)
-
-SYM_DATA_START_LOCAL(efi32_boot_idt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_idt)
-
-SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
-SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
-SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA_START_LOCAL(efi32_call)
+	.long	efi_enter32 - .
+	.word	0x0
+SYM_DATA_END(efi32_call)
 SYM_DATA(efi_is64, .byte 1)
 
 	.bss
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1dcb794c5479..5db6495a3bb9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -263,13 +263,6 @@ SYM_FUNC_START(startup_32)
 	 * used to perform that far jump.
 	 */
 	leal	rva(startup_64)(%ebp), %eax
-#ifdef CONFIG_EFI_MIXED
-	cmpb	$1, rva(efi_is64)(%ebp)
-	je	1f
-	leal	rva(startup_64_mixed_mode)(%ebp), %eax
-1:
-#endif
-
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-- 
2.48.1.362.g079036d154-goog


