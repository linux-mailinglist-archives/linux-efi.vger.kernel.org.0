Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5867812AD31
	for <lists+linux-efi@lfdr.de>; Thu, 26 Dec 2019 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLZPQt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 10:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZPQs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 10:16:48 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843F9208C4;
        Thu, 26 Dec 2019 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577373407;
        bh=BLvihVh+SW2aGPOELPDWBgD03fzD6pvoO9mKGfJ9bZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qcki2egPfVYCsb35r6+eftZM99iazdmAu7CzItKCIQGht8CmYQjWtFBf2zsT9WxoZ
         dgjCi4lBqJtemlu6xjIRl68C75xQnSLunSNbdiC0GcMTkrS0HNol0icMBuS+y0bUPq
         VQgjDxocs/XxXBmmLwgObgB12Se5tiItyNjHHg84=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 2/3] efi/x86: simplify i386 efi_call_phys() firmware call wrapper
Date:   Thu, 26 Dec 2019 16:14:06 +0100
Message-Id: <20191226151407.29716-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226151407.29716-1-ardb@kernel.org>
References: <20191226151407.29716-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The variadic efi_call_phys() wrapper that exists on i386 was
originally created to call into any EFI firmware runtime service,
but in practice, we only use it once, to call SetVirtualAddressMap()
during early boot.
The flexibility provided by the variadic nature also makes it
type unsafe, and makes the assembler code more complicated than
needed, since it has to deal with an unknown number of arguments
living on the stack.

So let's make the prototype of efi_call_phys() non-variadic, and
clean up the assembler code and make it deal with a fixed number
of arguments.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h          |   3 +-
 arch/x86/platform/efi/efi_stub_32.S | 106 +++-----------------
 2 files changed, 18 insertions(+), 91 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index a873bd06cfdd..fb213ee3870b 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -36,7 +36,8 @@
 
 #ifdef CONFIG_X86_32
 
-extern asmlinkage unsigned long efi_call_phys(void *, ...);
+extern asmlinkage
+unsigned long efi_call_phys(void *, unsigned long, unsigned long, u32, void *);
 
 #define arch_efi_call_virt_setup()					\
 ({									\
diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index eed8b5b441f8..d21292ca93b4 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -7,118 +7,44 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/init.h>
 #include <asm/page_types.h>
 
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
+	__INIT
 SYM_FUNC_START(efi_call_phys)
-	/*
-	 * 0. The function can only be called in Linux kernel. So CS has been
-	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
-	 * the values of these registers are the same. And, the corresponding
-	 * GDT entries are identical. So I will do nothing about segment reg
-	 * and GDT, but change GDT base register in prolog and epilog.
-	 */
+	movl	4(%esp), %eax
+	push	20(%esp)
+	push	20(%esp)
+	push	20(%esp)
+	push	20(%esp)
 
 	/*
-	 * 1. Now I am running with EIP = <physical address> + PAGE_OFFSET.
-	 * But to make it smoothly switch from virtual mode to flat mode.
-	 * The mapping of lower virtual memory has been created in prolog and
-	 * epilog.
+	 * Switch to the flat mapped alias of this routine, by jumping to the
+	 * address of label '1' after subtracting PAGE_OFFSET from it.
 	 */
 	movl	$1f, %edx
 	subl	$__PAGE_OFFSET, %edx
 	jmp	*%edx
 1:
 
-	/*
-	 * 2. Now on the top of stack is the return
-	 * address in the caller of efi_call_phys(), then parameter 1,
-	 * parameter 2, ..., param n. To make things easy, we save the return
-	 * address of efi_call_phys in a global variable.
-	 */
-	popl	%edx
-	movl	%edx, saved_return_addr
-	/* get the function pointer into ECX*/
-	popl	%ecx
-	movl	%ecx, efi_rt_function_ptr
-	movl	$2f, %edx
-	subl	$__PAGE_OFFSET, %edx
-	pushl	%edx
-
-	/*
-	 * 3. Clear PG bit in %CR0.
-	 */
+	/* disable paging */
 	movl	%cr0, %edx
 	andl	$0x7fffffff, %edx
 	movl	%edx, %cr0
-	jmp	1f
-1:
 
-	/*
-	 * 4. Adjust stack pointer.
-	 */
+	/* convert the stack pointer to a flat mapped address */
 	subl	$__PAGE_OFFSET, %esp
 
-	/*
-	 * 5. Call the physical function.
-	 */
-	jmp	*%ecx
+	/* call the EFI routine */
+	call	*%eax
 
-2:
-	/*
-	 * 6. After EFI runtime service returns, control will return to
-	 * following instruction. We'd better readjust stack pointer first.
-	 */
-	addl	$__PAGE_OFFSET, %esp
+	/* convert ESP back to a kernel VA, and pop the outgoing args */
+	addl	$__PAGE_OFFSET + 16, %esp
 
-	/*
-	 * 7. Restore PG bit
-	 */
+	/* re-enable paging */
 	movl	%cr0, %edx
 	orl	$0x80000000, %edx
 	movl	%edx, %cr0
-	jmp	1f
-1:
-	/*
-	 * 8. Now restore the virtual mode from flat mode by
-	 * adding EIP with PAGE_OFFSET.
-	 */
-	movl	$1f, %edx
-	jmp	*%edx
-1:
-
-	/*
-	 * 9. Balance the stack. And because EAX contain the return value,
-	 * we'd better not clobber it.
-	 */
-	leal	efi_rt_function_ptr, %edx
-	movl	(%edx), %ecx
-	pushl	%ecx
 
-	/*
-	 * 10. Push the saved return address onto the stack and return.
-	 */
-	leal	saved_return_addr, %edx
-	movl	(%edx), %ecx
-	pushl	%ecx
 	ret
 SYM_FUNC_END(efi_call_phys)
-.previous
-
-.data
-saved_return_addr:
-	.long 0
-efi_rt_function_ptr:
-	.long 0
-- 
2.17.1

