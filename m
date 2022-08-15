Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1632259301E
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiHONmk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiHONmh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358582654;
        Mon, 15 Aug 2022 06:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C7BAB80EC0;
        Mon, 15 Aug 2022 13:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C3C433B5;
        Mon, 15 Aug 2022 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570952;
        bh=6TIOpW/bujrZdCqkgLNTz2GkGR/7C29Y2vJhi5gLK6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzyLRHfpuByX0NDfDVCCiYdn5hCfLWgNEGIMqja0ycO9c10AAUo9Sg1zUBeMDb6bo
         7IV6l7g/vJaXrgLhKFBzQY9JhzMjR99dnc0QrmTSybFfZtUuOqb4+hn7b/9hpWwjZn
         LyAGdsPdo6rHB+4ohQaFC89xN1N3dnNZpdxLly37wE4gSIro466DvomOhpRNiL1mij
         Tc0sFhk5oBV8K8BspCRJqyIqWIIH4lbXYk/s4wCbVJkrN4tAtMS4JS54QVK6fyNk5N
         nFRhvgzDczVkS1eerOcdOtqdmne4C7msNXUMefjNpIzWFUqamb49P17KQMxHL6fmSO
         QMomRLNwVtIfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 1/6] x86/head_64: clean up mixed mode 32-bit entry code
Date:   Mon, 15 Aug 2022 15:42:18 +0200
Message-Id: <20220815134223.740112-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22310; i=ardb@kernel.org; h=from:subject; bh=6TIOpW/bujrZdCqkgLNTz2GkGR/7C29Y2vJhi5gLK6Y=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k0ykrA47C3bOrYjwyQNijmBnh0mYJ8+BMxqcB+l TdsOjemJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNMgAKCRDDTyI5ktmPJDZGDA DGe4TtaEv1+oq0/I3l/dHBdAeBDf21Gi6sFTJg+NnUi/zc+uneNOrWgEPGzp0kuIZPQ4j+d3OrT4JZ v4KDuO71qB99SzzGsMaPuXrRrj1byOa4+RhiAUXEXEAakjuG2mfup28DoHk7p2f/zZtTKl2VIYicZP zmw5bDbFRonUt9ft9alJMOvp7/toT+NYjUI7bhONokfJqbTqafZWEXWuiJYg75uIVm0YgIJ3PFZxyU wlaWYXBbTObd6pOdigf7TEQHH+dESM13gXBOwaKV8nstvqgFLefno3Zm1SiV9cNVyUoEeI0vzoMNaM DaTGk+ja5qmE4XEXoYVO1tyYwNaeq0SMf8/9TZIYe/1itD7+fOBoQHkxdMkOPIRFj6B/vzCrDrqYYY E0kRarGo78GKIXdazStPIgoF98MGp9Hs4U2EXD16aCAashJVz7JM2p7I911UB/eqox7O6J4y6wvAdB qVcG8GpO9XOpn9rq4AQ5//AIE+nGGvF4OAO5RVIdu4yrc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The x86_64 32-bit entry code is a jumble of EFI and SEV routines, which
is not good for maintainability. Let's isolate the EFI mixed mode code
and combine it with the boot service thunk that lives in another .S
file, so that we can remove it from head_64.S

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       |   6 +-
 arch/x86/boot/compressed/efi_mixed.S    | 358 ++++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
 arch/x86/boot/compressed/head_32.S      |   4 -
 arch/x86/boot/compressed/head_64.S      | 149 +-------
 drivers/firmware/efi/libstub/x86-stub.c |   3 +-
 6 files changed, 370 insertions(+), 345 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..d6dbb46696a2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,11 +107,11 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
-vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
-efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
+vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
new file mode 100644
index 000000000000..6fd7ac517c53
--- /dev/null
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -0,0 +1,358 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
+ *
+ * Early support for invoking 32-bit EFI services from a 64-bit kernel.
+ *
+ * Because this thunking occurs before ExitBootServices() we have to
+ * restore the firmware's 32-bit GDT and IDT before we make EFI service
+ * calls.
+ *
+ * On the plus side, we don't have to worry about mangling 64-bit
+ * addresses into 32-bits because we're executing with an identity
+ * mapped pagetable and haven't transitioned to 64-bit virtual addresses
+ * yet.
+ */
+
+#include <linux/linkage.h>
+#include <asm/msr.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+#include <asm/segment.h>
+
+	.text
+	.code64
+/*
+ * This is the first thing that runs after switching to long mode. Depending on
+ * whether we are using the EFI handover protocol or the compat entry point, we
+ * will either branch to the 64-bit EFI handover entrypoint at offset 0x390 in
+ * the image, or to the 64-bit EFI PE/COFF entrypoint efi_pe_entry(). In the
+ * former case, the bootloader must provide a struct bootparams pointer as the
+ * third argument, so we use that to disambiguate.
+ *
+ *                                                           +--------------+
+ *  +----------------+     +------------+              +---->| efi_pe_entry |
+ *  | efi32_pe_entry |---->|            |              |     +-----------+--+
+ *  +----------------+     |            |     +--------+-------------+   |
+ *                         | startup_32 |---->| startup_64_mixedmode |   |
+ *  +----------------+     |            |     +--------+-------------+   V
+ *  | efi32_handover |---->|            |              |     +-----------+------+
+ *  +----------------+     +------------+              +---->| efi64_stub_entry |
+ *                                                           +-----------+------+
+ *                         +------------+     +----------+               |
+ *                         | startup_64 |<----| efi_main |<--------------+
+ *                         +------------+     +----------+
+ */
+SYM_FUNC_START(startup_64_mixedmode)
+	lea	efi32_boot_args(%rip), %rdx
+	mov	0(%rdx), %edi
+	mov	4(%rdx), %esi
+	mov	8(%rdx), %edx		// saved bootparams pointer
+	test	%edx, %edx
+	jnz	efi64_stub_entry
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	sub	$40, %rsp
+	mov	%rdi, %rcx		// MS calling convention
+	mov	%rsi, %rdx
+	jmp	efi_pe_entry
+SYM_FUNC_END(startup_64_mixedmode)
+
+SYM_FUNC_START(__efi64_thunk)
+	push	%rbp
+	push	%rbx
+
+	movl	%ds, %eax
+	push	%rax
+	movl	%es, %eax
+	push	%rax
+	movl	%ss, %eax
+	push	%rax
+
+	/* Copy args passed on stack */
+	movq	0x30(%rsp), %rbp
+	movq	0x38(%rsp), %rbx
+	movq	0x40(%rsp), %rax
+
+	/*
+	 * Convert x86-64 ABI params to i386 ABI
+	 */
+	subq	$64, %rsp
+	movl	%esi, 0x0(%rsp)
+	movl	%edx, 0x4(%rsp)
+	movl	%ecx, 0x8(%rsp)
+	movl	%r8d, 0xc(%rsp)
+	movl	%r9d, 0x10(%rsp)
+	movl	%ebp, 0x14(%rsp)
+	movl	%ebx, 0x18(%rsp)
+	movl	%eax, 0x1c(%rsp)
+
+	leaq	0x20(%rsp), %rbx
+	sgdt	(%rbx)
+
+	addq	$16, %rbx
+	sidt	(%rbx)
+
+	leaq	1f(%rip), %rbp
+
+	/*
+	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
+	 * and IDT that was installed when the kernel started executing. The
+	 * pointers were saved at the efi32_stub_handover entry point below.
+	 *
+	 * Pass the saved DS selector to the 32-bit code, and use far return to
+	 * restore the saved CS selector.
+	 */
+	leaq	efi32_boot_idt(%rip), %rax
+	lidt	(%rax)
+	leaq	efi32_boot_gdt(%rip), %rax
+	lgdt	(%rax)
+
+	movzwl	efi32_boot_ds(%rip), %edx
+	movzwq	efi32_boot_cs(%rip), %rax
+	pushq	%rax
+	leaq	efi_enter32(%rip), %rax
+	pushq	%rax
+	lretq
+
+1:	addq	$64, %rsp
+	movq	%rdi, %rax
+
+	pop	%rbx
+	movl	%ebx, %ss
+	pop	%rbx
+	movl	%ebx, %es
+	pop	%rbx
+	movl	%ebx, %ds
+	/* Clear out 32-bit selector from FS and GS */
+	xorl	%ebx, %ebx
+	movl	%ebx, %fs
+	movl	%ebx, %gs
+
+	/*
+	 * Convert 32-bit status code into 64-bit.
+	 */
+	roll	$1, %eax
+	rorq	$1, %rax
+
+	pop	%rbx
+	pop	%rbp
+	RET
+SYM_FUNC_END(__efi64_thunk)
+
+	.code32
+/*
+ * EFI service pointer must be in %edi.
+ *
+ * The stack should represent the 32-bit calling convention.
+ */
+SYM_FUNC_START_LOCAL(efi_enter32)
+	/* Load firmware selector into data and stack segment registers */
+	movl	%edx, %ds
+	movl	%edx, %es
+	movl	%edx, %fs
+	movl	%edx, %gs
+	movl	%edx, %ss
+
+	/* Reload pgtables */
+	movl	%cr3, %eax
+	movl	%eax, %cr3
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Disable long mode via EFER */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btrl	$_EFER_LME, %eax
+	wrmsr
+
+	call	*%edi
+
+	/* We must preserve return value */
+	movl	%eax, %edi
+
+	/*
+	 * Some firmware will return with interrupts enabled. Be sure to
+	 * disable them before we switch GDTs and IDTs.
+	 */
+	cli
+
+	lidtl	(%ebx)
+	subl	$16, %ebx
+
+	lgdtl	(%ebx)
+
+	movl	%cr4, %eax
+	btsl	$(X86_CR4_PAE_BIT), %eax
+	movl	%eax, %cr4
+
+	movl	%cr3, %eax
+	movl	%eax, %cr3
+
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	xorl	%eax, %eax
+	lldt	%ax
+
+	pushl	$__KERNEL_CS
+	pushl	%ebp
+
+	/* Enable paging */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+	lret
+SYM_FUNC_END(efi_enter32)
+
+#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
+#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
+#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
+
+/*
+ * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
+ *			       efi_system_table_32_t *sys_table)
+ *
+ * This is the EFI compat entrypoint that will be invoked by the 32-bit EFI
+ * firmware directly (provided that it implements support for compat
+ * entrypoints).
+ */
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%eax				// dummy push to allocate loaded_image
+
+	pushl	%ebx				// save callee-save registers
+	pushl	%edi
+
+	call	verify_cpu			// check for long mode support
+	testl	%eax, %eax
+	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
+	jnz	2f
+
+	call	1f
+1:	pop	%ebx
+
+	/* Get the loaded image protocol pointer from the image handle */
+	leal	-4(%ebp), %eax
+	pushl	%eax				// &loaded_image
+	leal	(loaded_image_proto - 1b)(%ebx), %eax
+	pushl	%eax				// pass the GUID address
+	pushl	8(%ebp)				// pass the image handle
+
+	/*
+	 * Note the alignment of the stack frame.
+	 *   sys_table
+	 *   handle             <-- 16-byte aligned on entry by ABI
+	 *   return address
+	 *   frame pointer
+	 *   loaded_image       <-- local variable
+	 *   saved %ebx		<-- 16-byte aligned here
+	 *   saved %edi
+	 *   &loaded_image
+	 *   &loaded_image_proto
+	 *   handle             <-- 16-byte aligned for call to handle_protocol
+	 */
+
+	movl	12(%ebp), %eax			// sys_table
+	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
+	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
+	addl	$12, %esp			// restore argument space
+	testl	%eax, %eax
+	jnz	2f
+
+	movl	8(%ebp), %ecx			// image_handle
+	movl	12(%ebp), %edx			// sys_table
+	movl	-4(%ebp), %esi			// loaded_image
+	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
+	/*
+	 * We need to set the image_offset variable here since startup_32() will
+	 * use it before we get to the 64-bit efi_pe_entry() in C code.
+	 */
+	subl	%esi, %ebp
+	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
+	xorl	%esi, %esi
+	jmp	efi32_entry
+
+2:	popl	%edi				// restore callee-save registers
+	popl	%ebx
+	leave
+	RET
+SYM_FUNC_END(efi32_pe_entry)
+
+/*
+ * This is the EFI handover protocol entrypoint, which is invoked by jumping to
+ * an offset of 0x190 bytes into the kernel image after it has been loaded into
+ * memory by the EFI firmware or the bootloader.
+ */
+SYM_FUNC_START(efi32_handover)
+	add	$0x4, %esp			// Discard return address
+	popl	%ecx
+	popl	%edx
+	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_handover)
+
+SYM_FUNC_START_LOCAL(efi32_entry)
+	call	3f
+3:	pop	%ebx
+
+	/* Save firmware GDTR and code/data selectors */
+	sgdtl	(efi32_boot_gdt - 3b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 3b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 3b)(%ebx)
+
+	/* Store firmware IDT descriptor */
+	sidtl	(efi32_boot_idt - 3b)(%ebx)
+
+	leal	(efi32_boot_args - 3b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)		// efi_is64
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	jmp	startup_32
+SYM_FUNC_END(efi32_entry)
+
+	.section ".rodata"
+	/* EFI loaded image protocol GUID */
+	.balign 4
+SYM_DATA_START_LOCAL(loaded_image_proto)
+	.long	0x5b1b31a1
+	.word	0x9562, 0x11d2
+	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
+SYM_DATA_END(loaded_image_proto)
+
+	.data
+	.balign	8
+SYM_DATA_START_LOCAL(efi32_boot_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_gdt)
+
+SYM_DATA_START_LOCAL(efi32_boot_idt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_idt)
+
+SYM_DATA_LOCAL(efi32_boot_cs,	.word	0)
+SYM_DATA_LOCAL(efi32_boot_ds,	.word	0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi_is64, .byte 1)
+
diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
deleted file mode 100644
index 67e7edcdfea8..000000000000
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
- *
- * Early support for invoking 32-bit EFI services from a 64-bit kernel.
- *
- * Because this thunking occurs before ExitBootServices() we have to
- * restore the firmware's 32-bit GDT and IDT before we make EFI service
- * calls.
- *
- * On the plus side, we don't have to worry about mangling 64-bit
- * addresses into 32-bits because we're executing with an identity
- * mapped pagetable and haven't transitioned to 64-bit virtual addresses
- * yet.
- */
-
-#include <linux/linkage.h>
-#include <asm/msr.h>
-#include <asm/page_types.h>
-#include <asm/processor-flags.h>
-#include <asm/segment.h>
-
-	.code64
-	.text
-SYM_FUNC_START(__efi64_thunk)
-	push	%rbp
-	push	%rbx
-
-	movl	%ds, %eax
-	push	%rax
-	movl	%es, %eax
-	push	%rax
-	movl	%ss, %eax
-	push	%rax
-
-	/* Copy args passed on stack */
-	movq	0x30(%rsp), %rbp
-	movq	0x38(%rsp), %rbx
-	movq	0x40(%rsp), %rax
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
-
-	addq	$16, %rbx
-	sidt	(%rbx)
-
-	leaq	1f(%rip), %rbp
-
-	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved at the EFI stub entry point in head_64.S.
-	 *
-	 * Pass the saved DS selector to the 32-bit code, and use far return to
-	 * restore the saved CS selector.
-	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
-
-	movzwl	efi32_boot_ds(%rip), %edx
-	movzwq	efi32_boot_cs(%rip), %rax
-	pushq	%rax
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
-	lretq
-
-1:	addq	$64, %rsp
-	movq	%rdi, %rax
-
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
-	/*
-	 * Convert 32-bit status code into 64-bit.
-	 */
-	roll	$1, %eax
-	rorq	$1, %rax
-
-	pop	%rbx
-	pop	%rbp
-	RET
-SYM_FUNC_END(__efi64_thunk)
-
-	.code32
-/*
- * EFI service pointer must be in %edi.
- *
- * The stack should represent the 32-bit calling convention.
- */
-SYM_FUNC_START_LOCAL(efi_enter32)
-	/* Load firmware selector into data and stack segment registers */
-	movl	%edx, %ds
-	movl	%edx, %es
-	movl	%edx, %fs
-	movl	%edx, %gs
-	movl	%edx, %ss
-
-	/* Reload pgtables */
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Disable long mode via EFER */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btrl	$_EFER_LME, %eax
-	wrmsr
-
-	call	*%edi
-
-	/* We must preserve return value */
-	movl	%eax, %edi
-
-	/*
-	 * Some firmware will return with interrupts enabled. Be sure to
-	 * disable them before we switch GDTs and IDTs.
-	 */
-	cli
-
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
-	lgdtl	(%ebx)
-
-	movl	%cr4, %eax
-	btsl	$(X86_CR4_PAE_BIT), %eax
-	movl	%eax, %cr4
-
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btsl	$_EFER_LME, %eax
-	wrmsr
-
-	xorl	%eax, %eax
-	lldt	%ax
-
-	pushl	$__KERNEL_CS
-	pushl	%ebp
-
-	/* Enable paging */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-	lret
-SYM_FUNC_END(efi_enter32)
-
-	.data
-	.balign	8
-SYM_DATA_START(efi32_boot_gdt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_gdt)
-
-SYM_DATA_START(efi32_boot_idt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_idt)
-
-SYM_DATA_START(efi32_boot_cs)
-	.word	0
-SYM_DATA_END(efi32_boot_cs)
-
-SYM_DATA_START(efi32_boot_ds)
-	.word	0
-SYM_DATA_END(efi32_boot_ds)
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb9516d..6589ddd4cfaf 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -208,10 +208,6 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..c2cdbd8a3375 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -259,32 +259,16 @@ SYM_FUNC_START(startup_32)
 	 * We place all of the values on our mini stack so lret can
 	 * used to perform that far jump.
 	 */
-	leal	rva(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	rva(efi32_boot_args)(%ebp), %edi
-	testl	%edi, %edi
-	jz	1f
-	leal	rva(efi64_stub_entry)(%ebp), %eax
-	movl	rva(efi32_boot_args+4)(%ebp), %esi
-	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	testl	%edx, %edx
-	jnz	1f
-	/*
-	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
-	 * shadow space on the stack even if all arguments are passed in
-	 * registers. We also need an additional 8 bytes for the space that
-	 * would be occupied by the return address, and this also results in
-	 * the correct stack alignment for entry.
-	 */
-	subl	$40, %esp
-	leal	rva(efi_pe_entry)(%ebp), %eax
-	movl	%edi, %ecx			// MS calling convention
-	movl	%esi, %edx
-1:
+	cmpb	$1, rva(efi_is64)(%ebp)
+	leal	rva(startup_64_mixedmode)(%ebp), %eax
+	jne	1f
 #endif
 	/* Check if the C-bit position is correct when SEV is active */
 	call	startup32_check_sev_cbit
 
+	leal	rva(startup_64)(%ebp), %eax
+1:
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
@@ -299,35 +283,7 @@ SYM_FUNC_END(startup_32)
 #ifdef CONFIG_EFI_MIXED
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
-	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
-
-	call	1f
-1:	pop	%ebp
-	subl	$ rva(1b), %ebp
-
-	movl	%esi, rva(efi32_boot_args+8)(%ebp)
-SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
-	movl	%ecx, rva(efi32_boot_args)(%ebp)
-	movl	%edx, rva(efi32_boot_args+4)(%ebp)
-	movb	$0, rva(efi_is64)(%ebp)
-
-	/* Save firmware GDTR and code/data selectors */
-	sgdtl	rva(efi32_boot_gdt)(%ebp)
-	movw	%cs, rva(efi32_boot_cs)(%ebp)
-	movw	%ds, rva(efi32_boot_ds)(%ebp)
-
-	/* Store firmware IDT descriptor */
-	sidtl	rva(efi32_boot_idt)(%ebp)
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	jmp	startup_32
+	jmp	efi32_handover
 SYM_FUNC_END(efi32_stub_entry)
 #endif
 
@@ -713,6 +669,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	jmp     1b
 SYM_FUNC_END(.Lno_longmode)
 
+	.globl	verify_cpu
 #include "../../kernel/verify_cpu.S"
 
 	.data
@@ -757,98 +714,6 @@ SYM_DATA_START(boot32_idt)
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #endif
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-#ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
-SYM_DATA(efi_is64, .byte 1)
-
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
-	__HEAD
-	.code32
-SYM_FUNC_START(efi32_pe_entry)
-/*
- * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
- *			       efi_system_table_32_t *sys_table)
- */
-
-	pushl	%ebp
-	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
-	pushl	%ebx				// save callee-save registers
-	pushl	%edi
-
-	call	verify_cpu			// check for long mode support
-	testl	%eax, %eax
-	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	jnz	2f
-
-	call	1f
-1:	pop	%ebx
-	subl	$ rva(1b), %ebx
-
-	/* Get the loaded image protocol pointer from the image handle */
-	leal	-4(%ebp), %eax
-	pushl	%eax				// &loaded_image
-	leal	rva(loaded_image_proto)(%ebx), %eax
-	pushl	%eax				// pass the GUID address
-	pushl	8(%ebp)				// pass the image handle
-
-	/*
-	 * Note the alignment of the stack frame.
-	 *   sys_table
-	 *   handle             <-- 16-byte aligned on entry by ABI
-	 *   return address
-	 *   frame pointer
-	 *   loaded_image       <-- local variable
-	 *   saved %ebx		<-- 16-byte aligned here
-	 *   saved %edi
-	 *   &loaded_image
-	 *   &loaded_image_proto
-	 *   handle             <-- 16-byte aligned for call to handle_protocol
-	 */
-
-	movl	12(%ebp), %eax			// sys_table
-	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
-	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
-	addl	$12, %esp			// restore argument space
-	testl	%eax, %eax
-	jnz	2f
-
-	movl	8(%ebp), %ecx			// image_handle
-	movl	12(%ebp), %edx			// sys_table
-	movl	-4(%ebp), %esi			// loaded_image
-	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
-	/*
-	 * We need to set the image_offset variable here since startup_32() will
-	 * use it before we get to the 64-bit efi_pe_entry() in C code.
-	 */
-	subl	%esi, %ebx
-	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
-	jmp	efi32_pe_stub_entry
-
-2:	popl	%edi				// restore callee-save registers
-	popl	%ebx
-	leave
-	RET
-SYM_FUNC_END(efi32_pe_entry)
-
-	.section ".rodata"
-	/* EFI loaded image protocol GUID */
-	.balign 4
-SYM_DATA_START_LOCAL(loaded_image_proto)
-	.long	0x5b1b31a1
-	.word	0x9562, 0x11d2
-	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
-SYM_DATA_END(loaded_image_proto)
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
 	.code32
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ae8bcc9d67..d7b53dec01be 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,8 @@
 
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-extern u32 image_offset;
+
+u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
 static efi_status_t
-- 
2.35.1

