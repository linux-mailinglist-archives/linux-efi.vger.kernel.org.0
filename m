Return-Path: <linux-efi+bounces-2535-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA6A0644A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C0A3A53C0
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84A183CD9;
	Wed,  8 Jan 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjD/uHLN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DA1FF7BE
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360570; cv=none; b=M+5IZfbrX2fB+cuNJKp12Ip3h73BxyPIpY28K1a4ng6l9dQtDt4d7eyieof+dXfYMSg2dg4TEkaVaIDNQYN5oyqHnOjyVinqDHs/dHxGTUqKmJL96uLmXbCIr74MWrENeAZh/ojdZaYIhftUc6goqZiZbGDOg8FNC+Qyjxyyk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360570; c=relaxed/simple;
	bh=jx4bUGPsr+9JVsCuAZLXge19kkt5W9Q3cPtdscYk5zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPb556yz9L6+LZpoOPUebzqLXUUYrdiLz74+E9T/9q/s9OOy1cMPM3YYdyGYwDRFk/SY53cH2fQ1QjdvU5z+nf3W5g+y15jJ/9BneIGsfFQQ4XEiBM9Nnohf/1yecyIkSPAX6mEj+8VKQdP8lpZ0TzfkBVp5WnvI6QPJQ3qsjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjD/uHLN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385dcadffebso44718f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360567; x=1736965367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNVfr096nJGxcAFzzBLTLfvTxGz5JlZ2yViC6UqrtIk=;
        b=QjD/uHLNO9l37vi0OPVk71Z1+KML/dDL9dRYNVQdGUT+1T6Jp1SgcxSvsmsliqj5Aj
         czerNieW1SXQyd9sYZh7SxrqWh5mpa0AdIWcAZp6xzV277bAbIMBDZ84SEIMoiNwzoga
         Tahw2n0BKwuOTsfYB70roe7IuRISJHD1VMIb5V7VZMjVKheY5pHzedQFG3qAQpGK3TV0
         ncVhDJFKWzwHM+DGKzx4kiDPy5/HHnwurgwv2JpbcI/DenYqiMZKhtPX/eNqQnxEdcMr
         vslc8zV6hhKgV0YYuH8pTFVpyk5uku1mqBjQc1cEXeE7uAcbCdHPtiz8aIWEWD5Qii5g
         MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360567; x=1736965367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNVfr096nJGxcAFzzBLTLfvTxGz5JlZ2yViC6UqrtIk=;
        b=nKhYbJP1982cApkAAOD/3mu7jSLy2M0mvZCAj+TDFV6VUfIm1T2tAZOd42UjYtdJ+E
         Y4C7qU1eb2MUj/1XukBOpAjjhk4m70OXghLBQSVfGewNrukngesxDhgiJJdHVVCRi9O/
         zmWDkYyEtPEhdilMVJfDeDglBKiitcX3Xh8vLEKv3UT2DWB4ZUMkECmZnrwAFeeAK1uC
         lPxkvBLltwXM+sGVYvJ9MLyewq8Ty5Dcx8F6CAWRmnWDlcv1uh95paBb4gxr9H54AFoo
         nmqw6lud4mmcU7bJPvAIIdrFUF1e/wQdnJiyIq2YjfeSnTObC8Ijv64637DVmL4+dRnh
         1N1A==
X-Gm-Message-State: AOJu0Yx9ei4HOLf9XFo5hJ/Yd0Dy5GR6B6Iv2dk/24cF2yr4TBV2Brb2
	TiaKBm8/imt5Nzu7FOlQvzgYEimcfM+yMEgfmVnKIsO0kn2LyCKHBwIVPHutHoJ8/pCap1z2arF
	MZF+eAs0BwrtSSkpyBRHhit2FFNIcu2zYf1oslCJnVqTZE3xgr9ZfhHdvvfWHtlCEoyYrQuUCgl
	rFVYstHSuYjAX+mt+8OmtB9E97sg==
X-Google-Smtp-Source: AGHT+IFYxTSxNQ5yr95KCS/7/y8oRKBY/qpFax6EkY97FYcVer4GH/WLxeA1GI1NOowxPYyBRlp0SOhl
X-Received: from wrd20.prod.google.com ([2002:a05:6000:4a14:b0:386:2ebe:be29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4023:b0:385:f7a3:fed1
 with SMTP id ffacd0b85a97d-38a87336e53mr2913655f8f.44.1736360566688; Wed, 08
 Jan 2025 10:22:46 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:21 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8939; i=ardb@kernel.org;
 h=from:subject; bh=RX1/qLs48jU+AD6m8d23gxWs8NQmh0fm6jguKjbYvHI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUNzeGyU9xV+/9IuIvp24aknAj1+/vKLP/rb+vcPq8
 vtJWk+CO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEoo8wMrzK+tlc5qC+T3jW
 dP5XLlu6Vt5ekLX7sfqJ9Ms/o18fLRdlZDj620Dom0xq5I5HL/o/vc9Yu59h5+HVRlfqWN13Sdq 4O3IBAA==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-10-ardb+git@google.com>
Subject: [PATCH 2/6] x86/efi/mixed: Remove dependency on legacy startup_32 code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI mixed mode startup code calls into startup_32 in the legacy
decompressor with a mocked up boot_params struct, only to get it to set
up the 1:1 mapping of the lower 4 GiB of memory and switch to a GDT that
supports 64-bit mode.

In order to be able to reuse the EFI mixed mode startup code in EFI
zboot images, which do not incorporate the legacy decompressor code,
decouple it, by building the 1:1 map and installing the GDT directly.

This also removes the need to preserve and restore the stack pointer and
the arguments passed to the entrypoint, and instead, the firmware stack
can be retained, and the arguments can be loaded from it at the point
where they are needed, i.e., before calling into the EFI stub C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 143 ++++++++++++--------
 arch/x86/boot/compressed/head_64.S   |   7 -
 2 files changed, 86 insertions(+), 64 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 067e10eb7897..c010aba7a0d0 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -15,15 +15,18 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/asm-offsets.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
+#include <asm/pgtable_types.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
-#include <asm/setup.h>
 
 	.code64
 	.text
+	.balign	8
+SYM_DATA_LOCAL(gdt, .quad 0x0, 0x0, 0xaf9a000000ffff)	/* __KERNEL_CS */
+	.set	gdt_size, . - gdt
+
 /*
  * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
  * is the first thing that runs after switching to long mode. Depending on
@@ -35,30 +38,34 @@
  * pointer is used to disambiguate.
  *
  *                                                             +--------------+
- *  +------------------+     +------------+            +------>| efi_pe_entry |
- *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
- *  +------------------+     |            |     +------+----------------+  |
- *                           | startup_32 |---->| startup_64_mixed_mode |  |
- *  +------------------+     |            |     +------+----------------+  |
- *  | efi32_stub_entry |---->|            |            |                   |
- *  +------------------+     +------------+            |                   |
+ *  +------------------+    +-------------+            +------>| efi_pe_entry |
+ *  | efi32_pe_entry   |--->|             |            |       +-----------+--+
+ *  +------------------+    |             |     +------+----------------+  |
+ *                          | efi32_entry |---->| startup_64_mixed_mode |  |
+ *  +------------------+    |             |     +------+----------------+  |
+ *  | efi32_stub_entry |--->|             |            |                   |
+ *  +------------------+    +-------------+            |                   |
  *                                                     V                   |
- *                           +------------+     +----------------+         |
- *                           | startup_64 |<----| efi_stub_entry |<--------+
- *                           +------------+     +----------------+
+ *                          +-------------+     +----------------+         |
+ *                          |   vmlinux   |<----| efi_stub_entry |<--------+
+ *                          +-------------+     +----------------+
  */
-SYM_FUNC_START(startup_64_mixed_mode)
-	lea	efi32_boot_args(%rip), %rdx
-	mov	0(%rdx), %edi
-	mov	4(%rdx), %esi
+SYM_FUNC_START_LOCAL_NOALIGN(startup_64_mixed_mode)
+	xorl	%eax, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %ss
+	movl	%eax, %fs
+	movl	%eax, %gs
 
-	/* Switch to the firmware's stack */
-	movl	efi32_boot_sp(%rip), %esp
-	andl	$~7, %esp
+	movl	0(%rsp), %ecx		// MS calling convention
+	movl	4(%rsp), %edx
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-	mov	8(%rdx), %edx		// saved bootparams pointer
-	test	%edx, %edx
+	test	%edi, %edi		// struct boot_params provided?
+	movl	%edx, %esi		// SysV calling convention
+	cmovnzl	%edi, %edx
+	movl	%ecx, %edi
 	jnz	efi_stub_entry
 #endif
 	/*
@@ -69,8 +76,6 @@ SYM_FUNC_START(startup_64_mixed_mode)
 	 * the correct stack alignment for entry.
 	 */
 	sub	$40, %rsp
-	mov	%rdi, %rcx		// MS calling convention
-	mov	%rsi, %rdx
 	jmp	efi_pe_entry
 SYM_FUNC_END(startup_64_mixed_mode)
 
@@ -151,7 +156,6 @@ SYM_FUNC_END(__efi64_thunk)
 SYM_FUNC_START(efi32_stub_entry)
 	call	1f
 1:	popl	%ecx
-	leal	(efi32_boot_args - 1b)(%ecx), %ebx
 
 	/* Clear BSS */
 	xorl	%eax, %eax
@@ -163,10 +167,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	rep	stosl
 
 	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
-	movl	%esi, 8(%ebx)
+	movl	8(%esp), %edi		/* struct boot_params pointer */
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
 #endif
@@ -241,8 +242,9 @@ SYM_FUNC_END(efi_enter32)
 /*
  * This is the common EFI stub entry point for mixed mode.
  *
- * Arguments:	%ecx	image handle
- * 		%edx	EFI system table pointer
+ * Arguments:	0(%esp)	image handle
+ * 		4(%esp)	EFI system table pointer
+ *		%edi	struct boot_params pointer (or NULL)
  *
  * Since this is the point of no return for ordinary execution, no registers
  * are considered live except for the function parameters. [Note that the EFI
@@ -261,31 +263,58 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	/* Store firmware IDT descriptor */
 	sidtl	(efi32_boot_idt - 1b)(%ebx)
 
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
+	/* Record mixed mode entry */
+	movb	$0x0, (efi_is64 - 1b)(%ebx)
 
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	jmp	startup_32
+	/* Set up 1:1 mapping */
+	leal	(pte - 1b)(%ebx), %eax
+	movl	$_PAGE_PRESENT | _PAGE_RW | _PAGE_PSE, %ecx
+	leal	(_PAGE_PRESENT | _PAGE_RW)(%eax), %edx
+2:	movl	%ecx, (%eax)
+	addl	$8, %eax
+	addl	$PMD_SIZE, %ecx
+	jnc	2b
+
+	xor	%ecx, %ecx
+	movl	$PAGE_SIZE, %esi
+3:	movl	%edx, (%eax,%ecx,8)
+	addl	%esi, %edx
+	inc	%ecx
+	cmp	$4, %ecx
+	jl	3b
+
+	addl	%esi, %eax
+	movl	%edx, (%eax)
+	movl	%eax, %cr3
+
+	movl	%cr4, %eax
+	orl	$X86_CR4_PAE, %eax
+	movl	%eax, %cr4
+
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	leal	(gdt - 1b)(%ebx), %ecx
+	pushl	%ecx
+	pushw	$gdt_size - 1
+	lgdtl	(%esp)
+	lea	6(%esp), %esp
+
+	/* Enable paging and jump to long mode */
+	leal	(startup_64_mixed_mode - 1b)(%ebx), %ecx
+	pushl	$__KERNEL_CS
+	pushl	%ecx
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+	lret
 SYM_FUNC_END(efi32_entry)
 
 /*
@@ -301,10 +330,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	btl	$29, %edx			// check long mode bit
 	jnc	1f
 	leal	8(%esp), %esp			// preserve stack alignment
-	movl	(%esp), %ecx			// image_handle
-	movl	4(%esp), %edx			// sys_table
-	jmp	efi32_entry			// pass %ecx, %edx
-						// no other registers remain live
+	xor	%edi, %edi			// no struct boot_params in EDI
+	jmp	efi32_entry			// only ESP and EDI remain live
 1:	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	popl	%ebx
 	RET
@@ -318,8 +345,10 @@ SYM_FUNC_START_NOALIGN(efi64_stub_entry)
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
-	.data
-	.balign	8
+	.bss
+	.balign PAGE_SIZE
+SYM_DATA_LOCAL(pte, .fill 6 * PAGE_SIZE, 1, 0)
+
 SYM_DATA_START_LOCAL(efi32_boot_gdt)
 	.word	0
 	.quad	0
@@ -330,8 +359,8 @@ SYM_DATA_START_LOCAL(efi32_boot_idt)
 	.quad	0
 SYM_DATA_END(efi32_boot_idt)
 
+	.data
+	.balign	4
 SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
 SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
-SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
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
2.47.1.613.gc27f4b7a9f-goog


