Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94D2160562
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBPSYP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgBPSYO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:14 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEBE24654;
        Sun, 16 Feb 2020 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877453;
        bh=FitEItOTQrwH1ggggQoc/0k67HAttEuAOsQfQnFUFf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/g9RcBDOaMFt2MIGZhAkk+dXnGZRfRWi9a9ILlm68iOxeA+eEqcfoxTMpGhfzEA7
         CorrKmHfG9Yp0lL6wgpM2h4odYwaR/hYx9ftZj07qiR7U4EnpUgPhhEq3ebk/1GA9/
         kATSgj6iGw7JbMGGxMdiACub/n5tKIpcGDyN8Lbo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 16/18] efi: add 'runtime' pointer to struct efi
Date:   Sun, 16 Feb 2020 19:23:32 +0100
Message-Id: <20200216182334.8121-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of going through the EFI system table each time, just copy the
runtime services table pointer into struct efi directly. This is the
last use of the system table pointer in struct efi, allowing us to
drop it in a future patch, along with a fair amount of quirky handling
of the translated address.

Note that usually, the runtime services pointer changes value during
the call to SetVirtualAddressMap(), so grab the updated value as soon
as that call returns. (Mixed mode uses a 1:1 mapping, and kexec boot
enters with the updated address in the system table, so in those cases,
we don't need to do anything here)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h              |  3 ++-
 arch/x86/kernel/asm-offsets_32.c        |  5 +++++
 arch/x86/platform/efi/efi.c             |  9 ++++++---
 arch/x86/platform/efi/efi_32.c          | 13 +++++++-----
 arch/x86/platform/efi/efi_64.c          | 14 +++++++------
 arch/x86/platform/efi/efi_stub_32.S     | 21 +++++++++++++++-----
 drivers/firmware/efi/arm-init.c         |  1 +
 drivers/firmware/efi/runtime-wrappers.c |  4 ++--
 include/linux/efi.h                     |  1 +
 9 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 78fc28da2e29..0de57151c732 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -218,7 +218,8 @@ extern void efi_thunk_runtime_setup(void);
 efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 					 unsigned long descriptor_size,
 					 u32 descriptor_version,
-					 efi_memory_desc_t *virtual_map);
+					 efi_memory_desc_t *virtual_map,
+					 unsigned long systab_phys);
 
 /* arch specific definitions used by the stub code */
 
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 82826f2275cc..2b4256ebe86e 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -3,6 +3,8 @@
 # error "Please do not build this file directly, build asm-offsets.c instead"
 #endif
 
+#include <linux/efi.h>
+
 #include <asm/ucontext.h>
 
 #define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
@@ -64,4 +66,7 @@ void foo(void)
 	BLANK();
 	DEFINE(__NR_syscall_max, sizeof(syscalls) - 1);
 	DEFINE(NR_syscalls, sizeof(syscalls));
+
+	BLANK();
+	DEFINE(EFI_svam, offsetof(efi_runtime_services_t, set_virtual_address_map));
 }
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 57651facb99d..40eb4d2e3321 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -55,8 +55,8 @@
 #include <asm/uv/uv.h>
 
 static efi_system_table_t efi_systab __initdata;
-static u64 efi_systab_phys __initdata;
 
+static unsigned long efi_systab_phys __initdata;
 static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long efi_runtime, efi_nr_tables;
@@ -338,7 +338,7 @@ void __init efi_print_memmap(void)
 	}
 }
 
-static int __init efi_systab_init(u64 phys)
+static int __init efi_systab_init(unsigned long phys)
 {
 	int size = efi_enabled(EFI_64BIT) ? sizeof(efi_system_table_64_t)
 					  : sizeof(efi_system_table_32_t);
@@ -952,7 +952,8 @@ static void __init __efi_enter_virtual_mode(void)
 	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
 					     efi.memmap.desc_size,
 					     efi.memmap.desc_version,
-					     (efi_memory_desc_t *)pa);
+					     (efi_memory_desc_t *)pa,
+					     efi_systab_phys);
 	if (status != EFI_SUCCESS) {
 		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
 		       status);
@@ -986,6 +987,8 @@ void __init efi_enter_virtual_mode(void)
 	if (efi_enabled(EFI_PARAVIRT))
 		return;
 
+	efi.runtime = (efi_runtime_services_t *)efi_runtime;
+
 	if (efi_setup)
 		kexec_enter_virtual_mode();
 	else
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 081d466002c9..c049c432745d 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -66,14 +66,16 @@ void __init efi_map_region(efi_memory_desc_t *md)
 void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
-efi_status_t efi_call_svam(efi_set_virtual_address_map_t *__efiapi *,
-			   u32, u32, u32, void *);
+efi_status_t efi_call_svam(efi_runtime_services_t * const *,
+			   u32, u32, u32, void *, u32);
 
 efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 						unsigned long descriptor_size,
 						u32 descriptor_version,
-						efi_memory_desc_t *virtual_map)
+						efi_memory_desc_t *virtual_map,
+						unsigned long systab_phys)
 {
+	const efi_system_table_t *systab = (efi_system_table_t *)systab_phys;
 	struct desc_ptr gdt_descr;
 	efi_status_t status;
 	unsigned long flags;
@@ -90,9 +92,10 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call_svam(&efi.systab->runtime->set_virtual_address_map,
+	status = efi_call_svam(&systab->runtime,
 			       memory_map_size, descriptor_size,
-			       descriptor_version, virtual_map);
+			       descriptor_version, virtual_map,
+			       __pa(&efi.runtime));
 	local_irq_restore(flags);
 
 	load_fixmap_gdt(0);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index fa8506e76bbe..f78f7da666fb 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -500,12 +500,9 @@ static DEFINE_SPINLOCK(efi_runtime_lock);
  */
 #define __efi_thunk(func, ...)						\
 ({									\
-	efi_runtime_services_32_t *__rt;				\
 	unsigned short __ds, __es;					\
 	efi_status_t ____s;						\
 									\
-	__rt = (void *)(unsigned long)efi.systab->mixed_mode.runtime;	\
-									\
 	savesegment(ds, __ds);						\
 	savesegment(es, __es);						\
 									\
@@ -513,7 +510,7 @@ static DEFINE_SPINLOCK(efi_runtime_lock);
 	loadsegment(ds, __KERNEL_DS);					\
 	loadsegment(es, __KERNEL_DS);					\
 									\
-	____s = efi64_thunk(__rt->func, __VA_ARGS__);			\
+	____s = efi64_thunk(efi.runtime->mixed_mode.func, __VA_ARGS__);	\
 									\
 	loadsegment(ds, __ds);						\
 	loadsegment(es, __es);						\
@@ -886,8 +883,10 @@ efi_status_t __init __no_sanitize_address
 efi_set_virtual_address_map(unsigned long memory_map_size,
 			    unsigned long descriptor_size,
 			    u32 descriptor_version,
-			    efi_memory_desc_t *virtual_map)
+			    efi_memory_desc_t *virtual_map,
+			    unsigned long systab_phys)
 {
+	const efi_system_table_t *systab = (efi_system_table_t *)systab_phys;
 	efi_status_t status;
 	unsigned long flags;
 	pgd_t *save_pgd = NULL;
@@ -910,13 +909,16 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call(efi.systab->runtime->set_virtual_address_map,
+	status = efi_call(efi.runtime->set_virtual_address_map,
 			  memory_map_size, descriptor_size,
 			  descriptor_version, virtual_map);
 	local_irq_restore(flags);
 
 	kernel_fpu_end();
 
+	/* grab the virtually remapped EFI runtime services table pointer */
+	efi.runtime = READ_ONCE(systab->runtime);
+
 	if (save_pgd)
 		efi_uv1_memmap_phys_epilog(save_pgd);
 	else
diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index 75c46e7a809f..09237236fb25 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -8,14 +8,20 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/asm-offsets.h>
 #include <asm/page_types.h>
 
 	__INIT
 SYM_FUNC_START(efi_call_svam)
-	push	8(%esp)
-	push	8(%esp)
+	push	%ebp
+	movl	%esp, %ebp
+	push	%ebx
+
+	push	16(%esp)
+	push	16(%esp)
 	push	%ecx
 	push	%edx
+	movl	%eax, %ebx		// &systab_phys->runtime
 
 	/*
 	 * Switch to the flat mapped alias of this routine, by jumping to the
@@ -35,15 +41,20 @@ SYM_FUNC_START(efi_call_svam)
 	subl	$__PAGE_OFFSET, %esp
 
 	/* call the EFI routine */
-	call	*(%eax)
+	movl	(%eax), %eax
+	call	*EFI_svam(%eax)
 
-	/* convert ESP back to a kernel VA, and pop the outgoing args */
-	addl	$__PAGE_OFFSET + 16, %esp
+	/* grab the virtually remapped EFI runtime services table pointer */
+	movl	(%ebx), %ecx
+	movl	36(%esp), %edx		// &efi.runtime
+	movl	%ecx, (%edx)
 
 	/* re-enable paging */
 	movl	%cr0, %edx
 	orl	$0x80000000, %edx
 	movl	%edx, %cr0
 
+	pop	%ebx
+	leave
 	ret
 SYM_FUNC_END(efi_call_svam)
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 5fc2f6813b84..77048f7a9659 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -104,6 +104,7 @@ static int __init uefi_init(void)
 	if (retval)
 		goto out;
 
+	efi.runtime = efi.systab->runtime;
 	efi.runtime_version = efi.systab->hdr.revision;
 
 	efi_systab_report_header(&efi.systab->hdr,
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 65fffaa22210..1410beaef5c3 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -40,9 +40,9 @@
  * code doesn't get too cluttered:
  */
 #define efi_call_virt(f, args...)   \
-	efi_call_virt_pointer(efi.systab->runtime, f, args)
+	efi_call_virt_pointer(efi.runtime, f, args)
 #define __efi_call_virt(f, args...) \
-	__efi_call_virt_pointer(efi.systab->runtime, f, args)
+	__efi_call_virt_pointer(efi.runtime, f, args)
 
 struct efi_runtime_work efi_rts_work;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a42045568df3..1f69c4c2dd5c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -529,6 +529,7 @@ typedef struct {
  * All runtime access to EFI goes through this structure:
  */
 extern struct efi {
+	const efi_runtime_services_t	*runtime;		/* EFI runtime services table */
 	efi_system_table_t *systab;	/* EFI system table */
 	unsigned int runtime_version;	/* Runtime services version */
 	unsigned long acpi;		/* ACPI table  (IA64 ext 0.71) */
-- 
2.17.1

