Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6E11F349
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLNR6J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfLNR6J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:58:09 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B9E24676;
        Sat, 14 Dec 2019 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346287;
        bh=4qtCh/XJUt1OlO+1cIRYXDCg+lKu1LYnQkCd0IAD8Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPXgWM7nstyGcJdt90CvkCbpWHSKi8CtT/8p9S1jMB/YDUno4eX4bl1I0ztq3c1cB
         iiKaB3EByoAlBi379mSjXBpljc1irlHo7BZ9b1ZujcZaicIp9HF+JbSotdaXZIxTK9
         2hBvTiC50qMpSKsS2O9pEPpO9NHa9xSlWtvVk2hs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 10/10] efi/libstub/x86: avoid thunking for native firmware calls
Date:   Sat, 14 Dec 2019 18:57:35 +0100
Message-Id: <20191214175735.22518-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
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
 arch/x86/boot/compressed/efi_stub_32.S | 87 --------------------
 arch/x86/boot/compressed/efi_stub_64.S |  5 --
 arch/x86/boot/compressed/head_32.S     |  6 --
 arch/x86/boot/compressed/head_64.S     | 12 ---
 arch/x86/include/asm/efi.h             | 22 +++--
 arch/x86/platform/efi/efi_64.c         |  2 -
 7 files changed, 15 insertions(+), 121 deletions(-)

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
index 40468ab49b9b..7da4dfc53df6 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -161,9 +161,7 @@ SYM_FUNC_START(efi_pe_entry)
 	popl	%ecx
 	movl	%ecx, efi32_config+8(%esi)	/* EFI System table pointer */
 
-	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 28(%eax)
 	pushl	%eax
 
 	call	make_boot_params
@@ -188,9 +186,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	movl	%ecx, efi32_config(%esi)	/* Handle */
 	movl	%edx, efi32_config+8(%esi)	/* EFI System table pointer */
 
-	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 28(%eax)
 	pushl	%eax
 2:
 	call	efi_main
@@ -266,8 +262,6 @@ SYM_FUNC_END(.Lrelocated)
 	.data
 efi32_config:
 	.fill 7,4,0
-	.long efi_call_phys
-	.long 0
 	.byte 0
 #endif
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58a512e33d8d..6dc6a7ebb9e1 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -458,11 +458,6 @@ SYM_FUNC_START(efi_pe_entry)
 1:	popq	%rbp
 	subq	$1b, %rbp
 
-	/*
-	 * Relocate efi_config->call().
-	 */
-	addq	%rbp, efi64_config+40(%rip)
-
 	movq	%rax, %rdi
 	call	make_boot_params
 	cmpq	$0,%rax
@@ -477,11 +472,6 @@ handover_entry:
 1:	popq	%rbp
 	subq	$1b, %rbp
 
-	/*
-	 * Relocate efi_config->call().
-	 */
-	movq	efi_config(%rip), %rax
-	addq	%rbp, 40(%rax)
 2:
 	movq	efi_config(%rip), %rdi
 	call	efi_main
@@ -683,14 +673,12 @@ SYM_DATA_LOCAL(efi_config, .quad 0)
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
index 2244232108a0..14a24bb01776 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -152,6 +152,7 @@ struct efi_setup_data {
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
+extern efi_status_t efi64_thunk(u32, ...);
 
 static inline bool efi_is_mixed(void)
 {
@@ -205,7 +206,6 @@ struct efi_config {
 	efi_runtime_services_t *runtime_services;
 	efi_boot_services_t *boot_services;
 	efi_simple_text_output_protocol_t *text_output;
-	efi_status_t (*call)(unsigned long, ...);
 	bool is64;
 } __packed;
 
@@ -232,7 +232,7 @@ static inline bool efi_is_native(void)
 #define efi_table_attr(table, attr, instance) ({			\
 	__typeof__(((table##_t *)0)->attr) __ret;			\
 	if (efi_is_native()) {						\
-		__ret = ((table##_t *)instance)->attr;			\
+		__ret = instance->attr;					\
 	} else {							\
 		__typeof__(((table##_32_t *)0)->attr) at;		\
 		at = (((table##_32_t *)(unsigned long)instance)->attr);	\
@@ -242,19 +242,25 @@ static inline bool efi_is_native(void)
 })
 
 #define efi_call_proto(protocol, f, instance, ...)			\
-	__efi_early()->call((unsigned long)				\
+	efi_is_native()							\
+		? instance->f(instance, ##__VA_ARGS__)			\
+		: efi64_thunk((unsigned long)				\
 				efi_table_attr(protocol, f, instance),	\
-		instance, ##__VA_ARGS__)
+			instance, ##__VA_ARGS__)
 
 #define efi_call_early(f, ...)						\
-	__efi_early()->call((unsigned long)				\
+	efi_is_native()							\
+		? __efi_early()->boot_services->f(__VA_ARGS__)		\
+		: efi64_thunk((unsigned long)				\
 				efi_table_attr(efi_boot_services, f,	\
-		__efi_early()->boot_services), __VA_ARGS__)
+			__efi_early()->boot_services), __VA_ARGS__)
 
 #define efi_call_runtime(f, ...)					\
-	__efi_early()->call((unsigned long)				\
+	efi_is_native()							\
+		? __efi_early()->runtime_services->f(__VA_ARGS__)	\
+		: efi64_thunk((unsigned long)				\
 				efi_table_attr(efi_runtime_services, f,	\
-		__efi_early()->runtime_services), __VA_ARGS__)
+			__efi_early()->runtime_services), __VA_ARGS__)
 
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
2.17.1

