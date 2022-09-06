Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2965AE59B
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiIFKmH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiIFKl6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 06:41:58 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC961103;
        Tue,  6 Sep 2022 03:41:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id B0B314076260;
        Tue,  6 Sep 2022 10:41:39 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 13/16] efi/x86: Support extracting kernel from libstub
Date:   Tue,  6 Sep 2022 13:41:17 +0300
Message-Id: <502bf9da77574d6b2edeee0abec3df6b1510aaa0.1662459668.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1662459668.git.baskov@ispras.ru>
References: <cover.1662459668.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Doing it that way allows setting up stricter memory attributes,
simplifies boot code path and removes potential relocation
of kernel image.

Wire up required interfaces and minimally initialize zero page
fields needed for it to function correctly.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

 create mode 100644 arch/x86/include/asm/shared/extract.h
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
---
 arch/x86/boot/compressed/head_32.S            |   6 +-
 arch/x86/boot/compressed/head_64.S            |  45 ++++
 arch/x86/include/asm/shared/extract.h         |  25 ++
 drivers/firmware/efi/Kconfig                  |  14 ++
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/efistub.h        |   5 +
 .../firmware/efi/libstub/x86-extract-direct.c | 220 ++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       |  45 ++--
 8 files changed, 343 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/extract.h
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index b46a1c4109cf..d2866f06bc9f 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -155,7 +155,11 @@ SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp
 	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
-	/* efi_main returns the possibly relocated address of startup_32 */
+
+	/*
+	 * efi_main returns the possibly
+	 * relocated address of exteracted kernel entry point.
+	 */
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 37ce094571b5..b6bae8e7ee71 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -555,9 +555,54 @@ SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
+
+#ifdef CONFIG_EFI_STUB_EXTRACT_DIRECT
+	cld
+	cli
+
+	movq	%rbx, %rdi /* boot_params */
+	movq	%rax, %rsi /* decompressed kernel address */
+
+	/* Make sure we have GDT with 32-bit code segment */
+	leaq	gdt64(%rip), %rax
+	addq	%rax, 2(%rax)
+	lgdt	(%rax)
+
+	/* Setup data segments. */
+	xorl	%eax, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %ss
+	movl	%eax, %fs
+	movl	%eax, %gs
+
+	pushq	%rsi
+	pushq	%rdi
+
+	call startup32_enable_nx_if_supported
+
+	call	trampoline_pgtable_init
+	movq	%rax, %rdx
+
+
+	/* Swap %rsi and %rsi */
+	popq	%rsi
+	popq	%rdi
+
+	/* Save the trampoline address in RCX */
+	movq	trampoline_32bit(%rip), %rcx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rcx), %rax
+	pushq	%rax
+	lretq
+#else
 	movq	%rbx,%rsi
 	leaq	rva(startup_64)(%rax), %rax
 	jmp	*%rax
+#endif
+
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
 #endif
diff --git a/arch/x86/include/asm/shared/extract.h b/arch/x86/include/asm/shared/extract.h
new file mode 100644
index 000000000000..163678145884
--- /dev/null
+++ b/arch/x86/include/asm/shared/extract.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_SHARED_EXTRACT_H
+#define ASM_SHARED_EXTRACT_H
+
+#define MAP_WRITE	0x02 /* Writable memory */
+#define MAP_EXEC	0x04 /* Executable memory */
+#define MAP_ALLOC	0x10 /* Range needs to be allocated */
+#define MAP_PROTECT	0x20 /* Set exact memory attributes for memory range */
+
+struct efi_iofunc {
+	void (*putstr)(const char *msg);
+	void (*puthex)(unsigned long x);
+	unsigned long (*map_range)(unsigned long start,
+				   unsigned long end,
+				   unsigned int flags);
+};
+
+void *efi_extract_kernel(struct boot_params *rmode,
+			 struct efi_iofunc *iofunc,
+			 unsigned char *input_data,
+			 unsigned long input_len,
+			 unsigned char *output,
+			 unsigned long output_len);
+
+#endif /* ASM_SHARED_EXTRACT_H */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6cb7384ad2ac..2418402a0bda 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -91,6 +91,20 @@ config EFI_DXE_MEM_ATTRIBUTES
 	  Use DXE services to check and alter memory protection
 	  attributes during boot via EFISTUB to ensure that memory
 	  ranges used by the kernel are writable and executable.
+	  This option also enables stricter memory attributes
+	  on compressed kernel PE image.
+
+config EFI_STUB_EXTRACT_DIRECT
+	bool "Extract kernel directly from UEFI environment"
+	depends on EFI && EFI_STUB && X86_64
+	default y
+	help
+	  Extract kernel before exiting EFI boot services
+	  This allows maintaining W^X for kernel image for
+	  the whole execution of compressed kernel code.
+	  This also slightly improves efficiency of extraction
+	  code by removing the need to copy the kernel around
+	  and rebuild page tables.
 
 config EFI_PARAMS_FROM_FDT
 	bool
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..1cea7d913356 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -69,6 +69,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_EFI_STUB_EXTRACT_DIRECT)	+= x86-extract-direct.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 22fe28385db7..cdd1bb50c786 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -968,6 +968,11 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
+#ifdef CONFIG_X86
+unsigned long extract_kernel_direct(struct boot_params *boot_params);
+void startup_32(struct boot_params *boot_params);
+#endif
+
 void efi_retrieve_tpm2_eventlog(void);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-extract-direct.c b/drivers/firmware/efi/libstub/x86-extract-direct.c
new file mode 100644
index 000000000000..6076bd75cfd6
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-extract-direct.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/elf.h>
+#include <linux/stddef.h>
+
+#include <asm/efi.h>
+#include <asm/e820/types.h>
+#include <asm/desc.h>
+#include <asm/boot.h>
+#include <asm/bootparam_utils.h>
+#include <asm/shared/extract.h>
+#include <asm/shared/pgtable.h>
+
+#include "efistub.h"
+
+static void do_puthex(unsigned long value);
+static void do_putstr(const char *msg);
+
+static unsigned long do_map_range(unsigned long start,
+				  unsigned long end,
+				  unsigned int flags)
+{
+	efi_status_t status;
+
+	unsigned long size = end - start;
+
+	if (flags & MAP_ALLOC) {
+		if (start == (unsigned long)startup_32)
+			start = LOAD_PHYSICAL_ADDR;
+
+		unsigned long addr;
+
+		status = efi_low_alloc_above(size, CONFIG_PHYSICAL_ALIGN,
+					     &addr, start);
+		if (status != EFI_SUCCESS)
+			efi_err("Unable to allocate memory for uncompressed kernel");
+
+		if (start != addr) {
+			efi_debug("Unable to allocate at given address"
+				  " (desired=0x%lx, actual=0x%lx)",
+				  (unsigned long)start, addr);
+			start = addr;
+		}
+	}
+
+	if (flags & (MAP_PROTECT | MAP_ALLOC)) {
+		unsigned long attr = 0;
+
+		if (!(flags & MAP_EXEC))
+			attr |= EFI_MEMORY_XP;
+
+		if (!(flags & MAP_WRITE))
+			attr |= EFI_MEMORY_RO;
+
+		status = efi_adjust_memory_range_protection(start,
+							    end - start,
+							    attr);
+		if (status != EFI_SUCCESS)
+			efi_err("Unable to protect memory range");
+	}
+
+	return start;
+}
+
+/*
+ * Trampoline takes 3 pages and can be loaded in first megabyte of memory
+ * with its end placed between 0 and 640k where BIOS might start.
+ * (see arch/x86/boot/compressed/pgtable_64.c)
+ */
+
+#ifdef CONFIG_64BIT
+static efi_status_t prepare_trampoline(void)
+{
+	efi_status_t status;
+
+	status = efi_allocate_pages(TRAMPOLINE_32BIT_SIZE,
+				    (unsigned long *)&trampoline_32bit,
+				    TRAMPOLINE_32BIT_PLACEMENT_MAX);
+
+	if (status != EFI_SUCCESS)
+		return status;
+
+	unsigned long trampoline_start = (unsigned long)trampoline_32bit;
+
+	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
+
+	/* First page of trampoline is a top level page table */
+	efi_adjust_memory_range_protection(trampoline_start,
+					   PAGE_SIZE,
+					   EFI_MEMORY_XP);
+
+	/* Second page of trampoline is the code (with a padding) */
+
+	void *caddr = (void *)trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET;
+
+	memcpy(caddr, trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+
+	efi_adjust_memory_range_protection((unsigned long)caddr,
+					   PAGE_SIZE,
+					   EFI_MEMORY_RO);
+
+	/* And the last page of trampoline is the stack */
+
+	efi_adjust_memory_range_protection(trampoline_start + 2 * PAGE_SIZE,
+					   PAGE_SIZE,
+					   EFI_MEMORY_XP);
+
+	return EFI_SUCCESS;
+}
+#else
+static inline efi_status_t prepare_trampoline(void)
+{
+	return EFI_SUCCESS;
+}
+#endif
+
+static efi_status_t init_loader_data(struct boot_params *params)
+{
+	struct efi_info *efi = (void *)&params->efi_info;
+	efi_status_t status;
+
+	unsigned long map_size, desc_size, buff_size;
+	u32 desc_ver;
+	efi_memory_desc_t *mmap;
+
+	struct efi_boot_memmap map = {
+		.map		= &mmap,
+		.map_size	= &map_size,
+		.desc_size	= &desc_size,
+		.desc_ver	= &desc_ver,
+		.key_ptr	= NULL,
+		.buff_size	= &buff_size,
+	};
+
+	status = efi_get_memory_map(&map);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Unable to get EFI memory map...\n");
+		return status;
+	}
+
+	const char *signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
+					       : EFI32_LOADER_SIGNATURE;
+
+	memcpy(&efi->efi_loader_signature, signature, sizeof(__u32));
+
+	efi->efi_memdesc_size = desc_size;
+	efi->efi_memdesc_version = desc_ver;
+	efi->efi_memmap_size = map_size;
+
+	efi_set_u64_split((unsigned long)mmap,
+			  &efi->efi_memmap, &efi->efi_memmap_hi);
+
+	efi_set_u64_split((unsigned long)efi_system_table,
+			  &efi->efi_systab, &efi->efi_systab_hi);
+
+	return EFI_SUCCESS;
+}
+
+static void free_loader_data(struct boot_params *params)
+{
+	struct efi_info *efi = (void *)&params->efi_info;
+	unsigned long mmap = efi->efi_memmap;
+
+#ifdef CONFIG_64BIT
+	mmap |= ((unsigned long)efi->efi_memmap_hi << 32);
+#endif
+
+	efi_bs_call(free_pool, (void *)mmap);
+
+	efi->efi_memdesc_size = 0;
+	efi->efi_memdesc_version = 0;
+	efi->efi_memmap_size = 0;
+	efi_set_u64_split(0, &efi->efi_memmap, &efi->efi_memmap_hi);
+}
+
+unsigned long extract_kernel_direct(struct boot_params *params)
+{
+
+	extern unsigned char input_data[];
+	extern unsigned int output_len, input_len;
+
+	void *res;
+	efi_status_t status;
+	struct efi_iofunc iof = { 0 };
+
+	status = prepare_trampoline();
+
+	if (status != EFI_SUCCESS)
+		return 0;
+
+	/* Prepare environment for do_extract_kernel() call */
+	status = init_loader_data(params);
+
+	if (status != EFI_SUCCESS)
+		return 0;
+
+	iof.puthex = do_puthex;
+	iof.putstr = do_putstr;
+	iof.map_range = do_map_range;
+
+	res = efi_extract_kernel(params, &iof, input_data, input_len,
+				 (unsigned char *)startup_32, output_len);
+
+	free_loader_data(params);
+
+	return (unsigned long)res;
+}
+
+static void do_puthex(unsigned long value)
+{
+	efi_printk("%08lx", value);
+}
+
+static void do_putstr(const char *msg)
+{
+	efi_printk("%s", msg);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 678f9c2ccafc..680184034cb7 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -230,26 +230,25 @@ static void
 setup_memory_protection(unsigned long image_base, unsigned long image_size)
 {
 	/*
-	 * Allow execution of possible trampoline used
-	 * for switching between 4- and 5-level page tables
-	 * and relocated kernel image.
-	 */
+	* Allow execution of possible trampoline used
+	* for switching between 4- and 5-level page tables
+	* and relocated kernel image.
+	*/
 
 	efi_adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
 					   TRAMPOLINE_PLACEMENT_SIZE, 0);
 
 #ifdef CONFIG_64BIT
-	if (image_base != (unsigned long)startup_32)
-		efi_adjust_memory_range_protection(image_base, image_size, 0);
+	efi_adjust_memory_range_protection(image_base, image_size, 0);
 #else
 	/*
-	 * Clear protection flags on a whole range of possible
-	 * addresses used for KASLR. We don't need to do that
-	 * on x86_64, since KASLR/extraction is performed after
-	 * dedicated identity page tables are built and we only
-	 * need to remove possible protection on relocated image
-	 * itself disregarding further relocations.
-	 */
+	* Clear protection flags on a whole range of possible
+	* addresses used for KASLR. We don't need to do that
+	* on x86_64, since KASLR/extraction is performed after
+	* dedicated identity page tables are built and we only
+	* need to remove possible protection on relocated image
+	* itself disregarding further relocations.
+	*/
 	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
 					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR,
 					   0);
@@ -270,8 +269,10 @@ static void setup_quirks(struct boot_params *boot_params,
 			retrieve_apple_device_properties(boot_params);
 	}
 
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES) &&
+	    !IS_ENABLED(CONFIG_EFI_STUB_EXTRACT_DIRECT)) {
 		setup_memory_protection(image_base, image_size);
+	}
 }
 
 /*
@@ -710,8 +711,10 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 }
 
 /*
- * On success, we return the address of startup_32, which has potentially been
- * relocated by efi_relocate_kernel.
+ * On success, we return:
+ *   - the address of startup_32, which has potentially been
+ *     relocated by efi_relocate_kernel, if libstub direct extraction is disabled.
+ *   - extracted kernel entry point if libstub direct extraction is enabled.
  * On failure, we exit to the firmware via efi_exit instead of returning.
  */
 unsigned long efi_main(efi_handle_t handle,
@@ -736,6 +739,7 @@ unsigned long efi_main(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+#ifndef CONFIG_EFI_STUB_EXTRACT_DIRECT
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -789,6 +793,7 @@ unsigned long efi_main(efi_handle_t handle,
 		 */
 		image_offset = 0;
 	}
+#endif
 
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
@@ -845,7 +850,13 @@ unsigned long efi_main(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
+	setup_quirks(boot_params, buffer_start, buffer_end - buffer_start);
+
+#ifdef CONFIG_EFI_STUB_EXTRACT_DIRECT
+	bzimage_addr = extract_kernel_direct(boot_params);
+	if (!bzimage_addr)
+		goto fail;
+#endif
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-- 
2.35.1

