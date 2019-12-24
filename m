Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0F12A2BB
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLXPLI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfLXPLH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:07 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F169A206D3;
        Tue, 24 Dec 2019 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200266;
        bh=Fd8DTgE0OxArHcVWRJCDHAkcmB5mK4a18uzWO/MtnAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvvwoJplubvo/n8N2yXnnEBtDvjFk8ZGhYB020crSKL3IAThWPlDe9GIOj1b/gkJM
         neQ8RP8WoBX3jXa8qPGPlcNi0e9vmXk1H/1+3xhl1rEj098ICNsyscEaO7KmZi6WrH
         SzSAgL8sMPm2Usi3ZsgqeBVO2xOjeRvwpDuPYxl8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 13/25] efi/libstub/x86: avoid thunking for native firmware calls
Date:   Tue, 24 Dec 2019 16:10:13 +0100
Message-Id: <20191224151025.32482-14-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We use special wrapper routines to invoke firmware services in the
native case as well as the mixed mode case. For mixed mode, the need
is obvious, but for the native cases, we can simply rely on the
compiler to generate the indirect call, given that GCC now has
support for the MS calling convention (and has had it for quite some
time now). Note that on i386, the decompressor and the EFI stub are not
built with -mregparm=3 like the rest of the i386 kernel, so we can
safely allow the compiler to emit the indirect calls here as well.

So drop all the wrappers and indirection, and switch to either native
calls, or direct calls into the thunk routine for mixed mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile      |  2 +-
 arch/x86/boot/compressed/eboot.c       |  3 +-
 arch/x86/boot/compressed/efi_stub_32.S | 87 --------------------------
 arch/x86/boot/compressed/efi_stub_64.S |  5 --
 arch/x86/boot/compressed/head_32.S     |  6 --
 arch/x86/boot/compressed/head_64.S     | 23 +------
 arch/x86/include/asm/efi.h             | 34 +++++-----
 arch/x86/platform/efi/efi_64.c         |  2 -
 8 files changed, 24 insertions(+), 138 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
 delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index aa976adb7094..a20f55c59753 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -89,7 +89,7 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
 
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
+vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o \
 	$(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 2733bc263c04..36a26d6e2af0 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -44,7 +44,8 @@ BOOT_SERVICES(64);
 void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
 {
 	efi_call_proto(efi_simple_text_output_protocol, output_string,
-		       efi_early->text_output, str);
+		       ((efi_simple_text_output_protocol_t *)(unsigned long)
+				efi_early->text_output), str);
 }
 
 static efi_status_t
diff --git a/arch/x86/boot/compressed/efi_stub_32.S b/arch/x86/boot/compressed/efi_stub_32.S
deleted file mode 100644
index ed6c351d34ed..000000000000
--- a/arch/x86/boot/compressed/efi_stub_32.S
+++ /dev/null
@@ -1,87 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * EFI call stub for IA32.
- *
- * This stub allows us to make EFI calls in physical mode with interrupts
- * turned off. Note that this implementation is different from the one in
- * arch/x86/platform/efi/efi_stub_32.S because we're _already_ in physical
- * mode at this point.
- */
-
-#include <linux/linkage.h>
-#include <asm/page_types.h>
-
-/*
- * efi_call_phys(void *, ...) is a function with variable parameters.
- * All the callers of this function assure that all the parameters are 4-bytes.
- */
-
-/*
- * In gcc calling convention, EBX, ESP, EBP, ESI and EDI are all callee save.
- * So we'd better save all of them at the beginning of this function and restore
- * at the end no matter how many we use, because we can not assure EFI runtime
- * service functions will comply with gcc calling convention, too.
- */
-
-.text
-SYM_FUNC_START(efi_call_phys)
-	/*
-	 * 0. The function can only be called in Linux kernel. So CS has been
-	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
-	 * the values of these registers are the same. And, the corresponding
-	 * GDT entries are identical. So I will do nothing about segment reg
-	 * and GDT, but change GDT base register in prelog and epilog.
-	 */
-
-	/*
-	 * 1. Because we haven't been relocated by this point we need to
-	 * use relative addressing.
-	 */
-	call	1f
-1:	popl	%edx
-	subl	$1b, %edx
-
-	/*
-	 * 2. Now on the top of stack is the return
-	 * address in the caller of efi_call_phys(), then parameter 1,
-	 * parameter 2, ..., param n. To make things easy, we save the return
-	 * address of efi_call_phys in a global variable.
-	 */
-	popl	%ecx
-	movl	%ecx, saved_return_addr(%edx)
-	/* get the function pointer into ECX*/
-	popl	%ecx
-	movl	%ecx, efi_rt_function_ptr(%edx)
-
-	/*
-	 * 3. Call the physical function.
-	 */
-	call	*%ecx
-
-	/*
-	 * 4. Balance the stack. And because EAX contain the return value,
-	 * we'd better not clobber it. We need to calculate our address
-	 * again because %ecx and %edx are not preserved across EFI function
-	 * calls.
-	 */
-	call	1f
-1:	popl	%edx
-	subl	$1b, %edx
-
-	movl	efi_rt_function_ptr(%edx), %ecx
-	pushl	%ecx
-
-	/*
-	 * 10. Push the saved return address onto the stack and return.
-	 */
-	movl	saved_return_addr(%edx), %ecx
-	pushl	%ecx
-	ret
-SYM_FUNC_END(efi_call_phys)
-.previous
-
-.data
-saved_return_addr:
-	.long 0
-efi_rt_function_ptr:
-	.long 0
diff --git a/arch/x86/boot/compressed/efi_stub_64.S b/arch/x86/boot/compressed/efi_stub_64.S
deleted file mode 100644
index 99494dff2113..000000000000
--- a/arch/x86/boot/compressed/efi_stub_64.S
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <asm/segment.h>
-#include <asm/msr.h>
-#include <asm/processor-flags.h>
-
-#include "../../platform/efi/efi_stub_64.S"
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d083ef..0b03dc7bba12 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -161,9 +161,7 @@ SYM_FUNC_START(efi_pe_entry)
 	popl	%ecx
 	movl	%ecx, efi32_config+8(%esi)	/* EFI System table pointer */
 
-	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 40(%eax)
 	pushl	%eax
 
 	call	make_boot_params
@@ -188,9 +186,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	movl	%ecx, efi32_config(%esi)	/* Handle */
 	movl	%edx, efi32_config+8(%esi)	/* EFI System table pointer */
 
-	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 40(%eax)
 	pushl	%eax
 2:
 	call	efi_main
@@ -266,8 +262,6 @@ SYM_FUNC_END(.Lrelocated)
 	.data
 efi32_config:
 	.fill 5,8,0
-	.long efi_call_phys
-	.long 0
 	.byte 0
 #endif
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ee60b81944a7..ad57edeaeeb3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -459,15 +459,6 @@ SYM_FUNC_START(efi_pe_entry)
 	leaq	efi64_config(%rip), %rax
 	movq	%rax, efi_config(%rip)
 
-	call	1f
-1:	popq	%rbp
-	subq	$1b, %rbp
-
-	/*
-	 * Relocate efi_config->call().
-	 */
-	addq	%rbp, efi64_config+40(%rip)
-
 	movq	%rax, %rdi
 	call	make_boot_params
 	cmpq	$0,%rax
@@ -475,20 +466,10 @@ SYM_FUNC_START(efi_pe_entry)
 	mov	%rax, %rsi
 	leaq	startup_32(%rip), %rax
 	movl	%eax, BP_code32_start(%rsi)
-	jmp	2f		/* Skip the relocation */
 
 handover_entry:
-	call	1f
-1:	popq	%rbp
-	subq	$1b, %rbp
-
-	/*
-	 * Relocate efi_config->call().
-	 */
-	movq	efi_config(%rip), %rax
-	addq	%rbp, 40(%rax)
-2:
 	movq	efi_config(%rip), %rdi
+	and	$~0xf, %rsp			/* realign the stack */
 	call	efi_main
 	movq	%rax,%rsi
 	cmpq	$0,%rax
@@ -688,14 +669,12 @@ SYM_DATA_LOCAL(efi_config, .quad 0)
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_START(efi32_config)
 	.fill	5,8,0
-	.quad	efi64_thunk
 	.byte	0
 SYM_DATA_END(efi32_config)
 #endif
 
 SYM_DATA_START(efi64_config)
 	.fill	5,8,0
-	.quad	efi_call
 	.byte	1
 SYM_DATA_END(efi64_config)
 #endif /* CONFIG_EFI_STUB */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c27323cb49e5..001905daa110 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -152,6 +152,7 @@ struct efi_setup_data {
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
+extern efi_status_t efi64_thunk(u32, ...);
 
 static inline bool efi_is_mixed(void)
 {
@@ -205,7 +206,6 @@ struct efi_config {
 	u64 runtime_services;
 	u64 boot_services;
 	u64 text_output;
-	efi_status_t (*call)(unsigned long, ...);
 	bool is64;
 } __packed;
 
@@ -235,30 +235,36 @@ static inline bool efi_is_native(void)
 			(unsigned long)(attr), (attr))
 
 #define efi_table_attr(table, attr, instance) ({			\
-	__typeof__(((table##_t *)0)->attr) __ret;			\
+	__typeof__(instance->attr) __ret;				\
 	if (efi_is_native()) {						\
-		__ret = ((table##_t *)(unsigned long)instance)->attr;	\
+		__ret = instance->attr;					\
 	} else {							\
-		__ret = (__typeof__(__ret))efi_mixed_mode_cast(		\
-		((table##_t *)(unsigned long)instance)->mixed_mode.attr);\
+		__ret = (__typeof__(__ret))				\
+			efi_mixed_mode_cast(instance->mixed_mode.attr);	\
 	}								\
 	__ret;								\
 })
 
 #define efi_call_proto(protocol, f, instance, ...)			\
-	__efi_early()->call((unsigned long)				\
-				efi_table_attr(protocol, f, instance),	\
-		instance, ##__VA_ARGS__)
+	(efi_is_native()						\
+		? instance->f(instance, ##__VA_ARGS__)			\
+		: efi64_thunk(instance->mixed_mode.f, instance,	##__VA_ARGS__))
 
 #define efi_call_early(f, ...)						\
-	__efi_early()->call((unsigned long)				\
-				efi_table_attr(efi_boot_services, f,	\
-		__efi_early()->boot_services), __VA_ARGS__)
+	(efi_is_native()						\
+		? ((efi_boot_services_t *)(unsigned long)		\
+			__efi_early()->boot_services)->f(__VA_ARGS__)	\
+		: efi64_thunk(((efi_boot_services_t *)(unsigned long)	\
+			__efi_early()->boot_services)->mixed_mode.f,	\
+			__VA_ARGS__))
 
 #define efi_call_runtime(f, ...)					\
-	__efi_early()->call((unsigned long)				\
-				efi_table_attr(efi_runtime_services, f,	\
-		__efi_early()->runtime_services), __VA_ARGS__)
+	(efi_is_native()						\
+		? ((efi_runtime_services_t *)(unsigned long)		\
+			__efi_early()->runtime_services)->f(__VA_ARGS__)\
+		: efi64_thunk(((efi_runtime_services_t *)(unsigned long)\
+			__efi_early()->runtime_services)->mixed_mode.f,	\
+			__VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 885e50a707a6..03c2ed3c645c 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -635,8 +635,6 @@ void efi_switch_mm(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_EFI_MIXED
-extern efi_status_t efi64_thunk(u32, ...);
-
 static DEFINE_SPINLOCK(efi_runtime_lock);
 
 #define runtime_service32(func)						 \
-- 
2.20.1

