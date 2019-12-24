Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25B12A2CD
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfLXPLp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfLXPLN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:13 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB5E20731;
        Tue, 24 Dec 2019 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200272;
        bh=GVPoJlxSC11hzoqixxuoDr31eHREpLJzx+3KKItjjns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTKbe8XoM6NJ+M+rexrBhCgSkjFD0sPnSDV7vcNbzghMI9LLZSqBaqUw1LB6A0BVF
         uTkqEx8STdPqbQ/55j8Pbbc3nR1Kc27sYQ0v1+TaYr+L+Un46xa9bFmfM0f4V/P4QS
         JuYE3xTGb8U8w6qyc5bC6EbEyeQTFgj91uPptogY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 17/25] efi/libstub/x86: drop __efi_early() export and efi_config struct
Date:   Tue, 24 Dec 2019 16:10:17 +0100
Message-Id: <20191224151025.32482-18-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The various pointers we stash in the efi_config struct which we
retrieve using __efi_early() are simply copies of the ones in
the EFI system table, which we have started accessing directly
in the previous patch. So drop all the __efi_early() related
plumbing, as well as all the assembly code dealing with efi_config,
which allows us to move the PE/COFF entry point to C code as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c   | 82 +++++++++++-------------------
 arch/x86/boot/compressed/head_32.S | 58 +--------------------
 arch/x86/boot/compressed/head_64.S | 74 +++++----------------------
 arch/x86/include/asm/efi.h         | 38 ++++----------
 4 files changed, 54 insertions(+), 198 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 5fb12827bdc2..2a7c6d58cc56 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -19,32 +19,17 @@
 #include "eboot.h"
 
 static efi_system_table_t *sys_table;
-
-static struct efi_config *efi_early;
-
-__pure const struct efi_config *__efi_early(void)
-{
-	return efi_early;
-}
+static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
 
 __pure efi_system_table_t *efi_system_table(void)
 {
 	return sys_table;
 }
 
-#define BOOT_SERVICES(bits)						\
-static void setup_boot_services##bits(struct efi_config *c)		\
-{									\
-	efi_system_table_##bits##_t *table;				\
-									\
-	table = (typeof(table))sys_table;				\
-									\
-	c->runtime_services	= table->runtime;			\
-	c->boot_services	= table->boottime;			\
-	c->text_output		= table->con_out;			\
+__pure bool efi_is_64bit(void)
+{
+	return efi_is64;
 }
-BOOT_SERVICES(32);
-BOOT_SERVICES(64);
 
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
@@ -367,21 +352,24 @@ void setup_graphics(struct boot_params *boot_params)
 	}
 }
 
+void startup_32(struct boot_params *boot_params);
+
+void __noreturn efi_stub_entry(efi_handle_t handle,
+			       efi_system_table_t *sys_table_arg,
+			       struct boot_params *boot_params);
+
 /*
  * Because the x86 boot code expects to be passed a boot_params we
  * need to create one ourselves (usually the bootloader would create
  * one for us).
- *
- * The caller is responsible for filling out ->code32_start in the
- * returned boot_params.
  */
-struct boot_params *make_boot_params(struct efi_config *c)
+efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
+				   efi_system_table_t *sys_table_arg)
 {
 	struct boot_params *boot_params;
 	struct apm_bios_info *bi;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
-	void *handle;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -389,31 +377,24 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
-	efi_early = c;
-	sys_table = (efi_system_table_t *)(unsigned long)efi_early->table;
-	handle = (void *)(unsigned long)efi_early->image_handle;
+	sys_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-		return NULL;
-
-	if (efi_is_64bit())
-		setup_boot_services64(efi_early);
-	else
-		setup_boot_services32(efi_early);
+		return EFI_INVALID_PARAMETER;
 
 	status = efi_call_early(handle_protocol, handle,
 				&proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
-		return NULL;
+		return status;
 	}
 
 	status = efi_low_alloc(sys_table, 0x4000, 1,
 			       (unsigned long *)&boot_params);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
-		return NULL;
+		return status;
 	}
 
 	memset(boot_params, 0x0, 0x4000);
@@ -474,14 +455,17 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
 	boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
 
-	return boot_params;
+	hdr->code32_start = (u32)(unsigned long)startup_32;
+
+	efi_stub_entry(handle, sys_table, boot_params);
+	/* not reached */
 
 fail2:
 	efi_free(sys_table, options_size, hdr->cmd_line_ptr);
 fail:
 	efi_free(sys_table, 0x4000, (unsigned long)boot_params);
 
-	return NULL;
+	return status;
 }
 
 static void add_e820ext(struct boot_params *params,
@@ -737,33 +721,26 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
  * On success we return a pointer to a boot_params structure, and NULL
  * on failure.
  */
-struct boot_params *
-efi_main(struct efi_config *c, struct boot_params *boot_params)
+struct boot_params *efi_main(efi_handle_t handle,
+			     efi_system_table_t *sys_table_arg,
+			     struct boot_params *boot_params,
+			     bool is64)
 {
 	struct desc_ptr *gdt = NULL;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	struct desc_struct *desc;
-	void *handle;
-	efi_system_table_t *_table;
 	unsigned long cmdline_paddr;
 
-	efi_early = c;
-
-	_table = (efi_system_table_t *)(unsigned long)efi_early->table;
-	handle = (void *)(unsigned long)efi_early->image_handle;
+	sys_table = sys_table_arg;
 
-	sys_table = _table;
+	if (IS_ENABLED(CONFIG_EFI_MIXED))
+		efi_is64 = is64;
 
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	if (efi_is_64bit())
-		setup_boot_services64(efi_early);
-	else
-		setup_boot_services32(efi_early);
-
 	/*
 	 * make_boot_params() may have been called before efi_main(), in which
 	 * case this is the second time we parse the cmdline. This is ok,
@@ -925,5 +902,6 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 fail:
 	efi_printk(sys_table, "efi_main() failed!\n");
 
-	return NULL;
+	for (;;)
+		asm("hlt");
 }
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 0b03dc7bba12..e43ac17cb9fb 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -145,63 +145,16 @@ SYM_FUNC_START(startup_32)
 SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_STUB
-/*
- * We don't need the return address, so set up the stack so efi_main() can find
- * its arguments.
- */
-SYM_FUNC_START(efi_pe_entry)
-	add	$0x4, %esp
-
-	call	1f
-1:	popl	%esi
-	subl	$1b, %esi
-
-	popl	%ecx
-	movl	%ecx, efi32_config(%esi)	/* Handle */
-	popl	%ecx
-	movl	%ecx, efi32_config+8(%esi)	/* EFI System table pointer */
-
-	leal	efi32_config(%esi), %eax
-	pushl	%eax
-
-	call	make_boot_params
-	cmpl	$0, %eax
-	je	fail
-	movl	%esi, BP_code32_start(%eax)
-	popl	%ecx
-	pushl	%eax
-	pushl	%ecx
-	jmp	2f		/* Skip efi_config initialization */
-SYM_FUNC_END(efi_pe_entry)
-
 SYM_FUNC_START(efi32_stub_entry)
+SYM_FUNC_START_ALIAS(efi_stub_entry)
 	add	$0x4, %esp
-	popl	%ecx
-	popl	%edx
-
-	call	1f
-1:	popl	%esi
-	subl	$1b, %esi
-
-	movl	%ecx, efi32_config(%esi)	/* Handle */
-	movl	%edx, efi32_config+8(%esi)	/* EFI System table pointer */
-
-	leal	efi32_config(%esi), %eax
-	pushl	%eax
-2:
 	call	efi_main
-	cmpl	$0, %eax
 	movl	%eax, %esi
-	jne	2f
-fail:
-	/* EFI init failed, so hang. */
-	hlt
-	jmp	fail
-2:
 	movl	BP_code32_start(%esi), %eax
 	leal	startup_32(%eax), %eax
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
+SYM_FUNC_END_ALIAS(efi_stub_entry)
 #endif
 
 	.text
@@ -258,13 +211,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%eax
 SYM_FUNC_END(.Lrelocated)
 
-#ifdef CONFIG_EFI_STUB
-	.data
-efi32_config:
-	.fill 5,8,0
-	.byte 0
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ad57edeaeeb3..a6f3ee9ca61d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -208,10 +208,14 @@ SYM_FUNC_START(startup_32)
 	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	efi32_config(%ebp), %ebx
+	movl	efi32_boot_args(%ebp), %ebx
 	cmp	$0, %ebx
 	jz	1f
 	leal	handover_entry(%ebp), %eax
+	movl	0(%ebx), %edi
+	movl	4(%ebx), %esi
+	movl	8(%ebx), %edx
+	movl	$0x0, %ecx
 1:
 #endif
 	pushl	%eax
@@ -228,22 +232,14 @@ SYM_FUNC_END(startup_32)
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
 
-	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
 1:	pop	%ebp
 	subl	$1b, %ebp
 
-	movl	%ecx, efi32_config(%ebp)
-	movl	%edx, efi32_config+8(%ebp)
+	movl	%esp, efi32_boot_args(%ebp)
 	sgdtl	efi32_boot_gdt(%ebp)
 
-	leal	efi32_config(%ebp), %eax
-	movl	%eax, efi_config(%ebp)
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -450,51 +446,19 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
-
-/* The entry point for the PE/COFF executable is efi_pe_entry. */
-SYM_FUNC_START(efi_pe_entry)
-	movq	%rcx, efi64_config(%rip)	/* Handle */
-	movq	%rdx, efi64_config+8(%rip) /* EFI System table pointer */
-
-	leaq	efi64_config(%rip), %rax
-	movq	%rax, efi_config(%rip)
-
-	movq	%rax, %rdi
-	call	make_boot_params
-	cmpq	$0,%rax
-	je	fail
-	mov	%rax, %rsi
-	leaq	startup_32(%rip), %rax
-	movl	%eax, BP_code32_start(%rsi)
-
-handover_entry:
-	movq	efi_config(%rip), %rdi
+	.org 0x390
+SYM_FUNC_START(efi64_stub_entry)
+SYM_FUNC_START_ALIAS(efi_stub_entry)
+	movq	$1, %rcx
+SYM_INNER_LABEL(handover_entry, SYM_L_LOCAL)
 	and	$~0xf, %rsp			/* realign the stack */
 	call	efi_main
 	movq	%rax,%rsi
-	cmpq	$0,%rax
-	jne	2f
-fail:
-	/* EFI init failed, so hang. */
-	hlt
-	jmp	fail
-2:
 	movl	BP_code32_start(%esi), %eax
 	leaq	startup_64(%rax), %rax
 	jmp	*%rax
-SYM_FUNC_END(efi_pe_entry)
-
-	.org 0x390
-SYM_FUNC_START(efi64_stub_entry)
-	movq	%rdi, efi64_config(%rip)	/* Handle */
-	movq	%rsi, efi64_config+8(%rip) /* EFI System table pointer */
-
-	leaq	efi64_config(%rip), %rax
-	movq	%rax, efi_config(%rip)
-
-	movq	%rdx, %rsi
-	jmp	handover_entry
 SYM_FUNC_END(efi64_stub_entry)
+SYM_FUNC_END_ALIAS(efi_stub_entry)
 #endif
 
 	.text
@@ -663,22 +627,10 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad   0x0000000000000000	/* TS continued */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA_LOCAL(efi_config, .quad 0)
-
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_START(efi32_config)
-	.fill	5,8,0
-	.byte	0
-SYM_DATA_END(efi32_config)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0)
 #endif
 
-SYM_DATA_START(efi64_config)
-	.fill	5,8,0
-	.byte	1
-SYM_DATA_END(efi64_config)
-#endif /* CONFIG_EFI_STUB */
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 001905daa110..1817f350618e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -200,32 +200,14 @@ static inline efi_status_t efi_thunk_set_virtual_address_map(
 
 /* arch specific definitions used by the stub code */
 
-struct efi_config {
-	u64 image_handle;
-	u64 table;
-	u64 runtime_services;
-	u64 boot_services;
-	u64 text_output;
-	bool is64;
-} __packed;
-
-__pure const struct efi_config *__efi_early(void);
-
-static inline bool efi_is_64bit(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_64))
-		return false;
-
-	if (!IS_ENABLED(CONFIG_EFI_MIXED))
-		return true;
-
-	return __efi_early()->is64;
-}
+__pure bool efi_is_64bit(void);
 
 static inline bool efi_is_native(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return true;
+	if (!IS_ENABLED(CONFIG_EFI_MIXED))
+		return true;
 	return efi_is_64bit();
 }
 
@@ -252,18 +234,16 @@ static inline bool efi_is_native(void)
 
 #define efi_call_early(f, ...)						\
 	(efi_is_native()						\
-		? ((efi_boot_services_t *)(unsigned long)		\
-			__efi_early()->boot_services)->f(__VA_ARGS__)	\
-		: efi64_thunk(((efi_boot_services_t *)(unsigned long)	\
-			__efi_early()->boot_services)->mixed_mode.f,	\
+		? efi_system_table()->boottime->f(__VA_ARGS__)		\
+		: efi64_thunk(efi_table_attr(efi_boot_services,		\
+			boottime, efi_system_table())->mixed_mode.f,	\
 			__VA_ARGS__))
 
 #define efi_call_runtime(f, ...)					\
 	(efi_is_native()						\
-		? ((efi_runtime_services_t *)(unsigned long)		\
-			__efi_early()->runtime_services)->f(__VA_ARGS__)\
-		: efi64_thunk(((efi_runtime_services_t *)(unsigned long)\
-			__efi_early()->runtime_services)->mixed_mode.f,	\
+		? efi_system_table()->runtime->f(__VA_ARGS__)		\
+		: efi64_thunk(efi_table_attr(efi_runtime_services,	\
+			runtime, efi_system_table())->mixed_mode.f,	\
 			__VA_ARGS__))
 
 extern bool efi_reboot_required(void);
-- 
2.20.1

