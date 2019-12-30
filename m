Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0897512D326
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfL3SJh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfL3SJf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:35 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA77620722;
        Mon, 30 Dec 2019 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729375;
        bh=SXBMGJQ0Y/qmDZAt8VSKy7cJlddXMWSwcGdX97jPM/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFLiWZbAdClIjizOTSs9AlslfoOkQ5XuxOFKtuq9mR0Fl18ZO4xMBpMQuvBt94XXH
         6lF9Hd3j7WJ+mxJruQvjwD9uZhAdW8Pld1QeRwVbjDTo74YPBWFZymGyCX4JljY2/m
         EZW0rHiUZO/fCafa+96FmRfAXl4y2eGOvnDqVPHE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 08/14] efi/x86: simplify i386 efi_call_phys() firmware call wrapper
Date:   Mon, 30 Dec 2019 19:08:28 +0100
Message-Id: <20191230180834.75601-9-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

So clean this up, by renaming the helper to efi_call_svam(), and
dropping the unneeded complexity. Let's also drop the reference
to the efi_phys struct and grab the address from the EFI system
table directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h          |   3 -
 arch/x86/platform/efi/efi_32.c      |   5 +-
 arch/x86/platform/efi/efi_stub_32.S | 109 +++-----------------
 3 files changed, 20 insertions(+), 97 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index e29e5dc0b750..cb08035b89a0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -35,9 +35,6 @@
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
 #ifdef CONFIG_X86_32
-
-extern asmlinkage unsigned long efi_call_phys(void *, ...);
-
 #define arch_efi_call_virt_setup()					\
 ({									\
 	kernel_fpu_begin();						\
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 185950ade0e9..71dddd1620f9 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -66,7 +66,8 @@ void __init efi_map_region(efi_memory_desc_t *md)
 void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
-extern struct efi efi_phys;
+efi_status_t efi_call_svam(efi_set_virtual_address_map_t *__efiapi *,
+			   u32, u32, u32, void *);
 
 efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 						unsigned long descriptor_size,
@@ -89,7 +90,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call_phys(efi_phys.set_virtual_address_map,
+	status = efi_call_svam(&efi.systab->runtime->set_virtual_address_map,
 			       memory_map_size, descriptor_size,
 			       descriptor_version, virtual_map);
 	local_irq_restore(flags);
diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index eed8b5b441f8..75c46e7a809f 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -7,118 +7,43 @@
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
+	__INIT
+SYM_FUNC_START(efi_call_svam)
+	push	8(%esp)
+	push	8(%esp)
+	push	%ecx
+	push	%edx
 
-.text
-SYM_FUNC_START(efi_call_phys)
 	/*
-	 * 0. The function can only be called in Linux kernel. So CS has been
-	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
-	 * the values of these registers are the same. And, the corresponding
-	 * GDT entries are identical. So I will do nothing about segment reg
-	 * and GDT, but change GDT base register in prolog and epilog.
-	 */
-
-	/*
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
+	call	*(%eax)
 
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
-SYM_FUNC_END(efi_call_phys)
-.previous
-
-.data
-saved_return_addr:
-	.long 0
-efi_rt_function_ptr:
-	.long 0
+SYM_FUNC_END(efi_call_svam)
-- 
2.20.1

