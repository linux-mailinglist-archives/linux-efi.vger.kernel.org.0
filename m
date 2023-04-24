Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D136ED2FF
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDXQ6a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjDXQ6R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93249001;
        Mon, 24 Apr 2023 09:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33726615A0;
        Mon, 24 Apr 2023 16:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4EC433D2;
        Mon, 24 Apr 2023 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355480;
        bh=6MdVknqRTZnvXIoF+NO/nO50YczB4j7aGopG7v5Dbbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDR1h8UDSjErj4CCERVbn5VxtQZlrJSZaKADAMrqV1aCcLCIvdtvw56XFGptUEgzl
         ul496K7G2Nit80C039vw3QcSvfr3z/cHi2sAQhlFYC0xi4z6kCzEbQ54++AR1m0waQ
         aCoHXwDVAApXix2/8CChK9WX2R3GA4WRDApRewT8GhFjf5XAi4m4A9vnNHdhK7BYly
         ZM4G0QryTpG0+WWO3545IGJLp1+nnNdXXErOmQ8JXSRZ0DukCGMRq77P3cBG8Su0vf
         YT6hoVcg78Vc9nNfH/HwzeMqqbvAr8CzMq8kB0D1EUb7mwnYBFxgHECln5WmGzoBrn
         OF4MLrmWTTSCw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] x86: efistub: Avoid legacy decompressor when doing EFI boot
Date:   Mon, 24 Apr 2023 18:57:26 +0200
Message-Id: <20230424165726.2245548-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17551; i=ardb@kernel.org; h=from:subject; bh=6MdVknqRTZnvXIoF+NO/nO50YczB4j7aGopG7v5Dbbk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVty9fGgwd5z/LPXaN44djq8wrK26YfaXz2+zFX6ReFH fFlt6YbdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJ7A5h+B8w1zDzk4PiytPv Zkx637R0RtBZ9htbG9gXnpyuNFlwzXwzRob7Z0tbz1VZv769SWz/zwvKWxN0XHymvk3l2bep2LZ WIZ8LAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The bare metal decompressor code was never really intended to run in a
hosted environment such as the EFI boot services, and does a few things
that are problematic in the context of EFI boot now that the logo
requirements are getting tighter.

In particular, the decompressor moves itself around in memory, and
assumes that arbitrary chunks of low memory can be temporarily emptied,
populated with trampoline code and restored again afterwards, and this
is difficult to support in a context where memory is not permitted to be
mapped writable and executable at the same time or, at the very least,
is mapped non-executable by default, and needs special treatment for
this restriction to be lifted.

Since EFI already maps all of memory 1:1, we don't need to create new
page tables or handle page faults when decompressing the kernel. That
means there is also no need to set up special exception handlers for
SEV. Generally, there is little need to do anything that the
decompressor does beyond
- perform the 4/5 level paging switch, if needed,
- decompress the kernel
- relocate the kernel

So let's do all of this from the EFI stub code, and avoid the bare metal
decompressor altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S    |  55 ------
 arch/x86/boot/compressed/head_32.S      |  16 --
 arch/x86/boot/compressed/head_64.S      |  31 ----
 arch/x86/include/asm/efi.h              |   2 +
 drivers/firmware/efi/libstub/x86-stub.c | 188 ++++++++------------
 5 files changed, 75 insertions(+), 217 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 4ca70bf93dc0bdcd..075dd6410f9a4d60 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -245,10 +245,6 @@ SYM_FUNC_START(efi32_entry)
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
 /*
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
  *			       efi_system_table_32_t *sys_table)
@@ -256,8 +252,6 @@ SYM_FUNC_END(efi32_entry)
 SYM_FUNC_START(efi32_pe_entry)
 	pushl	%ebp
 	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
 	pushl	%ebx				// save callee-save registers
 	pushl	%edi
 
@@ -266,48 +260,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	jnz	2f
 
-	call	1f
-1:	pop	%ebx
-
-	/* Get the loaded image protocol pointer from the image handle */
-	leal	-4(%ebp), %eax
-	pushl	%eax				// &loaded_image
-	leal	(loaded_image_proto - 1b)(%ebx), %eax
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
 	movl	8(%ebp), %ecx			// image_handle
 	movl	12(%ebp), %edx			// sys_table
-	movl	-4(%ebp), %esi			// loaded_image
-	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
-	/*
-	 * We need to set the image_offset variable here since startup_32() will
-	 * use it before we get to the 64-bit efi_pe_entry() in C code.
-	 */
-	subl	%esi, %ebp			// calculate image_offset
-	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
 	xorl	%esi, %esi
 	jmp	efi32_entry			// pass %ecx, %edx, %esi
 						// no other registers remain live
@@ -318,15 +272,6 @@ SYM_FUNC_START(efi32_pe_entry)
 	RET
 SYM_FUNC_END(efi32_pe_entry)
 
-	.section ".rodata"
-	/* EFI loaded image protocol GUID */
-	.balign 4
-SYM_DATA_START_LOCAL(loaded_image_proto)
-	.long	0x5b1b31a1
-	.word	0x9562, 0x11d2
-	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
-SYM_DATA_END(loaded_image_proto)
-
 	.data
 	.balign	8
 SYM_DATA_START_LOCAL(efi32_boot_gdt)
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3ecc1bbe971e1d43..a578fe178f1cfee7 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -84,19 +84,6 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	leal	startup_32@GOTOFF(%edx), %ebx
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32() will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry() will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	subl    image_offset@GOTOFF(%edx), %ebx
-#endif
-
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl    %eax, %ebx
@@ -153,10 +140,7 @@ SYM_FUNC_END(startup_32)
 #ifdef CONFIG_EFI_STUB
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp
-	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
-	/* efi_main returns the possibly relocated address of startup_32 */
-	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
 #endif
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 5ab014be179c1103..eb8ead7bce9fc577 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -146,19 +146,6 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	movl	%ebp, %ebx
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32 will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	subl    rva(image_offset)(%ebp), %ebx
-#endif
-
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl	%eax, %ebx
@@ -346,20 +333,6 @@ SYM_CODE_START(startup_64)
 	/* Start with the delta to where the kernel will run at. */
 #ifdef CONFIG_RELOCATABLE
 	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32 will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	movl    image_offset(%rip), %eax
-	subq	%rax, %rbp
-#endif
-
 	movl	BP_kernel_alignment(%rsi), %eax
 	decl	%eax
 	addq	%rax, %rbp
@@ -529,11 +502,7 @@ SYM_CODE_END(startup_64)
 #endif
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
-	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
-	movq	%rbx,%rsi
-	leaq	rva(startup_64)(%rax), %rax
-	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
 #endif
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 419280d263d2e3f2..36b848e7d088a59b 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -216,6 +216,8 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 #ifdef CONFIG_EFI_MIXED
 
+#define EFI_ALLOC_LIMIT		(efi_is_64bit() ? ULONG_MAX : U32_MAX)
+
 #define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index ea4024a6a04e507f..dc45bcb74d1552c2 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -18,12 +18,8 @@
 
 #include "efistub.h"
 
-/* Maximum physical address for 64-bit kernel with 4-level paging */
-#define MAXMEM_X86_64_4LEVEL (1ull << 46)
-
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 static efi_memory_attribute_protocol_t *memattr;
 
@@ -274,54 +270,9 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 	}
 }
 
-/*
- * Trampoline takes 2 pages and can be loaded in first megabyte of memory
- * with its end placed between 128k and 640k where BIOS might start.
- * (see arch/x86/boot/compressed/pgtable_64.c)
- *
- * We cannot find exact trampoline placement since memory map
- * can be modified by UEFI, and it can alter the computed address.
- */
-
-#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
-#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
-
-void startup_32(struct boot_params *boot_params);
-
-static void
-setup_memory_protection(unsigned long image_base, unsigned long image_size)
-{
-	/*
-	 * Allow execution of possible trampoline used
-	 * for switching between 4- and 5-level page tables
-	 * and relocated kernel image.
-	 */
-
-	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-				       TRAMPOLINE_PLACEMENT_SIZE);
-
-#ifdef CONFIG_64BIT
-	if (image_base != (unsigned long)startup_32)
-		adjust_memory_range_protection(image_base, image_size);
-#else
-	/*
-	 * Clear protection flags on a whole range of possible
-	 * addresses used for KASLR. We don't need to do that
-	 * on x86_64, since KASLR/extraction is performed after
-	 * dedicated identity page tables are built and we only
-	 * need to remove possible protection on relocated image
-	 * itself disregarding further relocations.
-	 */
-	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
-#endif
-}
-
 static const efi_char16_t apple[] = L"Apple";
 
-static void setup_quirks(struct boot_params *boot_params,
-			 unsigned long image_base,
-			 unsigned long image_size)
+static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor);
@@ -330,9 +281,6 @@ static void setup_quirks(struct boot_params *boot_params,
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
-
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
-		setup_memory_protection(image_base, image_size);
 }
 
 /*
@@ -485,7 +433,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	}
 
 	image_base = efi_table_attr(image, image_base);
-	image_offset = (void *)startup_32 - image_base;
 
 	status = efi_allocate_pages(sizeof(struct boot_params),
 				    (unsigned long *)&boot_params, ULONG_MAX);
@@ -900,19 +847,78 @@ static void efi_5level_switch(void)
 }
 #endif
 
+static void efi_get_seed(void *seed, int size)
+{
+	efi_get_random_bytes(size, seed);
+
+	// TODO mix in RDRAND/TSC
+}
+
+static void error(char *str)
+{
+	efi_warn("Decompression failed: %s\n", str);
+}
+
+int decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+		      void (*error)(char *x));
+
+static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
+{
+	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	extern const unsigned long kernel_total_size;
+	extern unsigned int input_len, output_len;
+	extern void *input_data;
+	unsigned long addr, alloc_size, entry;
+	unsigned long seed[2] = {};
+	efi_status_t status;
+
+	/* determine the required size of the allocation */
+	alloc_size = ALIGN(max((unsigned long)output_len, kernel_total_size),
+			   MIN_KERNEL_ALIGN);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
+		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+
+		efi_get_seed(seed, sizeof(seed));
+
+		virt_addr += (range * (u32)seed[1]) >> 32;
+		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+	}
+
+	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
+				  seed[0], EFI_LOADER_CODE);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	entry = decompress_kernel((void *)addr, virt_addr, error);
+	*kernel_entry = addr + entry;
+
+	adjust_memory_range_protection(addr, kernel_total_size);
+
+	return EFI_SUCCESS;
+}
+
+static void __noreturn enter_kernel(unsigned long kernel_addr,
+				    struct boot_params *boot_params)
+{
+	/* enter decompressed kernel with boot_params pointer in RSI/ESI */
+	asm("jmp *%0"::"r"(kernel_addr), "S"(boot_params));
+
+	unreachable();
+}
+
 /*
- * On success, we return the address of startup_32, which has potentially been
- * relocated by efi_relocate_kernel.
- * On failure, we exit to the firmware via efi_exit instead of returning.
+ * On success, we jump to the relocated kernel directly and never return;
+ * on failure, we exit to the firmware via efi_exit instead of returning.
  */
 asmlinkage unsigned long efi_main(efi_handle_t handle,
 				  efi_system_table_t *sys_table_arg,
 				  struct boot_params *boot_params)
 {
-	unsigned long bzimage_addr = (unsigned long)startup_32;
-	unsigned long buffer_start, buffer_end;
+	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
+	unsigned long kernel_entry;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -945,60 +951,6 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 	}
 #endif
 
-	/*
-	 * If the kernel isn't already loaded at a suitable address,
-	 * relocate it.
-	 *
-	 * It must be loaded above LOAD_PHYSICAL_ADDR.
-	 *
-	 * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
-	 * is defined as the macro MAXMEM, but unfortunately that is not a
-	 * compile-time constant if 5-level paging is configured, so we instead
-	 * define our own macro for use here.
-	 *
-	 * For 32-bit, the maximum address is complicated to figure out, for
-	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
-	 * KASLR uses.
-	 *
-	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
-	 * loaded by LoadImage, but rather by a bootloader that called the
-	 * handover entry. The reason we must always relocate in this case is
-	 * to handle the case of systemd-boot booting a unified kernel image,
-	 * which is a PE executable that contains the bzImage and an initrd as
-	 * COFF sections. The initrd section is placed after the bzImage
-	 * without ensuring that there are at least init_size bytes available
-	 * for the bzImage, and thus the compressed kernel's startup code may
-	 * overwrite the initrd unless it is moved out of the way.
-	 */
-
-	buffer_start = ALIGN(bzimage_addr - image_offset,
-			     hdr->kernel_alignment);
-	buffer_end = buffer_start + hdr->init_size;
-
-	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
-	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
-	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0)) {
-		extern char _bss[];
-
-		status = efi_relocate_kernel(&bzimage_addr,
-					     (unsigned long)_bss - bzimage_addr,
-					     hdr->init_size,
-					     hdr->pref_address,
-					     hdr->kernel_alignment,
-					     LOAD_PHYSICAL_ADDR);
-		if (status != EFI_SUCCESS) {
-			efi_err("efi_relocate_kernel() failed!\n");
-			goto fail;
-		}
-		/*
-		 * Now that we've copied the kernel elsewhere, we no longer
-		 * have a set up block before startup_32(), so reset image_offset
-		 * to zero in case it was set earlier.
-		 */
-		image_offset = 0;
-	}
-
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
@@ -1016,6 +968,12 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		}
 	}
 
+	status = efi_decompress_kernel(&kernel_entry);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to decompress kernel\n");
+		goto fail;
+	}
+
 	/*
 	 * At this point, an initrd may already have been loaded by the
 	 * bootloader and passed via bootparams. We permit an initrd loaded
@@ -1055,7 +1013,7 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
+	setup_quirks(boot_params);
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
@@ -1067,7 +1025,7 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 	efi_5level_switch();
 #endif
 
-	return bzimage_addr;
+	enter_kernel(kernel_entry, boot_params);
 fail:
 	efi_err("efi_main() failed!\n");
 
-- 
2.39.2

