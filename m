Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF712F793
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgACLlY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:41:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgACLki (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:38 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC90A24653;
        Fri,  3 Jan 2020 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051636;
        bh=3K6dO/sEJEK5FibfhK0EZWHnQBMiGy78e/Q4Thae6/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=136Ql92mqP9wFtW99AITzi6jjPr/kXmnbY+pKBP5H0sLS24JvdsRw0BIvg0J7n4do
         vKyXZDQ/ttFpRrWODchnSFOxZRcZIOj6/cqq3IiJIUmhJRpjxDcHsxE5Iu224hxndt
         4KccHxP5Pv2DJHT6T++ZHH5emOOTaHCbcwlCaNV8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 10/20] efi/x86: simplify mixed mode call wrapper
Date:   Fri,  3 Jan 2020 12:39:43 +0100
Message-Id: <20200103113953.9571-11-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
can simply push the old stack pointer value to the new stack,
and keep the return address from the code32 section in EBX.

While at it, move the conditional check whether to invoke
the mixed mode version of SetVirtualAddressMap() into the
64-bit implementation of the wrapper routine.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h           |   6 --
 arch/x86/platform/efi/efi.c          |  19 +----
 arch/x86/platform/efi/efi_64.c       |  73 ++++++++++------
 arch/x86/platform/efi/efi_thunk_64.S | 121 +++++----------------------
 4 files changed, 71 insertions(+), 148 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cb08035b89a0..e7e9c6e057f9 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -164,12 +164,6 @@ extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 
 extern void efi_thunk_runtime_setup(void);
-extern efi_status_t efi_thunk_set_virtual_address_map(
-	void *phys_set_virtual_address_map,
-	unsigned long memory_map_size,
-	unsigned long descriptor_size,
-	u32 descriptor_version,
-	efi_memory_desc_t *virtual_map);
 efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 					 unsigned long descriptor_size,
 					 u32 descriptor_version,
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 50f8123e658a..e4d3afac7be3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -1015,21 +1015,10 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
-	if (!efi_is_mixed()) {
-		status = efi_set_virtual_address_map(
-				efi.memmap.desc_size * count,
-				efi.memmap.desc_size,
-				efi.memmap.desc_version,
-				(efi_memory_desc_t *)pa);
-	} else {
-		status = efi_thunk_set_virtual_address_map(
-				efi_phys.set_virtual_address_map,
-				efi.memmap.desc_size * count,
-				efi.memmap.desc_size,
-				efi.memmap.desc_version,
-				(efi_memory_desc_t *)pa);
-	}
-
+	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
+					     efi.memmap.desc_size,
+					     efi.memmap.desc_version,
+					     (efi_memory_desc_t *)pa);
 	if (status != EFI_SUCCESS) {
 		pr_alert("Unable to switch EFI into virtual mode (status=%lx)!\n",
 			 status);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 03565dad0c4b..910e9ec03b09 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -626,61 +626,74 @@ void efi_switch_mm(struct mm_struct *mm)
 	switch_mm(efi_scratch.prev_mm, mm, NULL);
 }
 
-#ifdef CONFIG_EFI_MIXED
 static DEFINE_SPINLOCK(efi_runtime_lock);
 
-#define runtime_service32(func)						 \
-({									 \
-	u32 table = (u32)(unsigned long)efi.systab;			 \
-	u32 *rt, *___f;							 \
-									 \
-	rt = (u32 *)(table + offsetof(efi_system_table_32_t, runtime));	 \
-	___f = (u32 *)(*rt + offsetof(efi_runtime_services_32_t, func)); \
-	*___f;								 \
+/*
+ * DS and ES contain user values.  We need to save them.
+ * The 32-bit EFI code needs a valid DS, ES, and SS.  There's no
+ * need to save the old SS: __KERNEL_DS is always acceptable.
+ */
+#define __efi_thunk(func, ...)						\
+({									\
+	efi_runtime_services_32_t *__rt;				\
+	unsigned short __ds, __es;					\
+	efi_status_t ____s;						\
+									\
+	__rt = (void *)(unsigned long)efi.systab->mixed_mode.runtime;	\
+									\
+	savesegment(ds, __ds);						\
+	savesegment(es, __es);						\
+									\
+	loadsegment(ss, __KERNEL_DS);					\
+	loadsegment(ds, __KERNEL_DS);					\
+	loadsegment(es, __KERNEL_DS);					\
+									\
+	____s = efi64_thunk(__rt->func, __VA_ARGS__);			\
+									\
+	loadsegment(ds, __ds);						\
+	loadsegment(es, __es);						\
+									\
+	____s ^= (____s & BIT(31)) | (____s & BIT_ULL(31)) << 32;	\
+	____s;								\
 })
 
 /*
  * Switch to the EFI page tables early so that we can access the 1:1
  * runtime services mappings which are not mapped in any other page
- * tables. This function must be called before runtime_service32().
+ * tables.
  *
  * Also, disable interrupts because the IDT points to 64-bit handlers,
  * which aren't going to function correctly when we switch to 32-bit.
  */
-#define efi_thunk(f, ...)						\
+#define efi_thunk(func...)						\
 ({									\
 	efi_status_t __s;						\
-	u32 __func;							\
 									\
 	arch_efi_call_virt_setup();					\
 									\
-	__func = runtime_service32(f);					\
-	__s = efi64_thunk(__func, __VA_ARGS__);				\
+	__s = __efi_thunk(func);					\
 									\
 	arch_efi_call_virt_teardown();					\
 									\
 	__s;								\
 })
 
-efi_status_t efi_thunk_set_virtual_address_map(
-	void *phys_set_virtual_address_map,
-	unsigned long memory_map_size,
-	unsigned long descriptor_size,
-	u32 descriptor_version,
-	efi_memory_desc_t *virtual_map)
+static efi_status_t __init
+efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
+				  unsigned long descriptor_size,
+				  u32 descriptor_version,
+				  efi_memory_desc_t *virtual_map)
 {
 	efi_status_t status;
 	unsigned long flags;
-	u32 func;
 
 	efi_sync_low_kernel_mappings();
 	local_irq_save(flags);
 
 	efi_switch_mm(&efi_mm);
 
-	func = (u32)(unsigned long)phys_set_virtual_address_map;
-	status = efi64_thunk(func, memory_map_size, descriptor_size,
-			     descriptor_version, virtual_map);
+	status = __efi_thunk(set_virtual_address_map, memory_map_size,
+			     descriptor_size, descriptor_version, virtual_map);
 
 	efi_switch_mm(efi_scratch.prev_mm);
 	local_irq_restore(flags);
@@ -983,8 +996,11 @@ efi_thunk_query_capsule_caps(efi_capsule_header_t **capsules,
 	return EFI_UNSUPPORTED;
 }
 
-void efi_thunk_runtime_setup(void)
+void __init efi_thunk_runtime_setup(void)
 {
+	if (!IS_ENABLED(CONFIG_EFI_MIXED))
+		return;
+
 	efi.get_time = efi_thunk_get_time;
 	efi.set_time = efi_thunk_set_time;
 	efi.get_wakeup_time = efi_thunk_get_wakeup_time;
@@ -1000,7 +1016,6 @@ void efi_thunk_runtime_setup(void)
 	efi.update_capsule = efi_thunk_update_capsule;
 	efi.query_capsule_caps = efi_thunk_query_capsule_caps;
 }
-#endif /* CONFIG_EFI_MIXED */
 
 efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 						unsigned long descriptor_size,
@@ -1011,6 +1026,12 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 	unsigned long flags;
 	pgd_t *save_pgd = NULL;
 
+	if (efi_is_mixed())
+		return efi_thunk_set_virtual_address_map(memory_map_size,
+							 descriptor_size,
+							 descriptor_version,
+							 virtual_map);
+
 	if (efi_enabled(EFI_OLD_MEMMAP)) {
 		save_pgd = efi_old_memmap_phys_prolog();
 		if (!save_pgd)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 3189f1394701..162b35729633 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -25,15 +25,16 @@
 
 	.text
 	.code64
-SYM_FUNC_START(efi64_thunk)
+SYM_CODE_START(efi64_thunk)
 	push	%rbp
 	push	%rbx
 
 	/*
 	 * Switch to 1:1 mapped 32-bit stack pointer.
 	 */
-	movq	%rsp, efi_saved_sp(%rip)
+	movq	%rsp, %rax
 	movq	efi_scratch(%rip), %rsp
+	push	%rax
 
 	/*
 	 * Calculate the physical address of the kernel text.
@@ -41,113 +42,31 @@ SYM_FUNC_START(efi64_thunk)
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
+	leaq	1f(%rip), %rbp
+	leaq	2f(%rip), %rbx
+	subq	%rax, %rbp
 	subq	%rax, %rbx
-	call	*%rbx
-
-	movq	efi_saved_sp(%rip), %rsp
-	pop	%rbx
-	pop	%rbp
-	retq
-SYM_FUNC_END(efi64_thunk)
 
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
-	movl	%esi, 0x0(%rsp)
-	movl	%edx, 0x4(%rsp)
-	movl	%ecx, 0x8(%rsp)
-	movq	%r8, %rsi
-	movl	%esi, 0xc(%rsp)
-	movq	%r9, %rsi
-	movl	%esi,  0x10(%rsp)
-
-	leaq	1f(%rip), %rbx
-	movq	%rbx, func_rt_ptr(%rip)
+	subq	$28, %rsp
+	movl	%ebx, 0x0(%rsp)		/* return address */
+	movl	%esi, 0x4(%rsp)
+	movl	%edx, 0x8(%rsp)
+	movl	%ecx, 0xc(%rsp)
+	movl	%r8d, 0x10(%rsp)
+	movl	%r9d, 0x14(%rsp)
 
 	/* Switch to 32-bit descriptor */
 	pushq	$__KERNEL32_CS
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
+	pushq	%rdi			/* EFI runtime service address */
 	lretq
 
-1:	addq	$32, %rsp
-
+1:	movq	24(%rsp), %rsp
 	pop	%rbx
-	movl	%ebx, %ss
-	pop	%rbx
-	movl	%ebx, %es
-	pop	%rbx
-	movl	%ebx, %ds
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
+	pop	%rbp
+	retq
 
 	.code32
-/*
- * EFI service pointer must be in %edi.
- *
- * The stack should represent the 32-bit calling convention.
- */
-SYM_FUNC_START_LOCAL(efi_enter32)
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-
-	call	*%edi
-
-	/* We must preserve return value */
-	movl	%eax, %edi
-
-	movl	72(%esp), %eax
-	pushl	$__KERNEL_CS
-	pushl	%eax
-
+2:	pushl	$__KERNEL_CS
+	pushl	%ebp
 	lret
-SYM_FUNC_END(efi_enter32)
-
-	.data
-	.balign	8
-func_rt_ptr:		.quad 0
-efi_saved_sp:		.quad 0
+SYM_CODE_END(efi64_thunk)
-- 
2.20.1

