Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1013160CE9B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiJYOOS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiJYOOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:07 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECA33A22;
        Tue, 25 Oct 2022 07:14:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id EBE3740737B2;
        Tue, 25 Oct 2022 14:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EBE3740737B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707244;
        bh=YjWMHdyF9iQP1fE3wJIPZ8IpoU6mPAb1Y95B6bL5ALU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kA1xXtkUtIZshwrFhGhJhGDFpj5d5eChSTRd+HYgh362syR6XP/bF99WdSxu11dPx
         fL1wEOQZMMmWTe2/EgLu6luj1LwHBDXB1ZpHjFgtEA9J2eFc+doLgT4CGj7BGfcicp
         XNXb9VzQcr5caX7MYXY3zFxU1Sy0KH2TiY9hgDbw=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 15/23] efi/x86: Support extracting kernel from libstub
Date:   Tue, 25 Oct 2022 17:12:53 +0300
Message-Id: <9e9e8d7dafd389b7b12bada56e3af29e5559659b.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/boot/compressed/head_32.S            |  41 +++-
 arch/x86/boot/compressed/head_64.S            |  45 +++-
 drivers/firmware/efi/Kconfig                  |   2 +
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 .../firmware/efi/libstub/x86-extract-direct.c | 204 ++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       | 115 +---------
 drivers/firmware/efi/libstub/x86-stub.h       |  11 +
 7 files changed, 307 insertions(+), 113 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index b46a1c4109cf..9871cc8466fb 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -155,8 +155,45 @@ SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp
 	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
-	/* efi_main returns the possibly relocated address of startup_32 */
-	jmp	*%eax
+	movl	%eax, %ecx
+
+	/*
+	 * efi_main returns the possibly
+	 * relocated address of extracted kernel entry point.
+	 */
+
+	cli
+
+/*
+ * Calculate the delta between where we were compiled to run
+ * at and where we were actually loaded at.  This can only be done
+ * with a short local call on x86.  Nothing  else will tell us what
+ * address we are running at.  The reserved chunk of the real-mode
+ * data at 0x1e4 (defined as a scratch field) are used as the stack
+ * for this calculation. Only 4 bytes are needed.
+ */
+	call	1f
+1:	popl	%edx
+	addl	$_GLOBAL_OFFSET_TABLE_+(.-1b), %edx
+
+	/* Load new GDT */
+	leal	gdt@GOTOFF(%edx), %eax
+	movl	%eax, 2(%eax)
+	lgdt	(%eax)
+
+	/* Load segment registers with our descriptors */
+	movl	$__BOOT_DS, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	movl	%eax, %ss
+
+	/* Zero EFLAGS */
+	pushl	$0
+	popfl
+
+	jmp	*%ecx
 SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
 #endif
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6cfcdeb4531b..476c9b665181 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -556,9 +556,48 @@ SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
-	movq	%rbx,%rsi
-	leaq	rva(startup_64)(%rax), %rax
-	jmp	*%rax
+
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
+	call	enable_nx_if_supported
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
+
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
 #endif
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6787ed8dfacf..388b2a0b4781 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -91,6 +91,8 @@ config EFI_DXE_MEM_ATTRIBUTES
 	  Use DXE services to check and alter memory protection
 	  attributes during boot via EFISTUB to ensure that memory
 	  ranges used by the kernel are writable and executable.
+	  This option also enables stricter memory attributes
+	  on compressed kernel PE image.
 
 config EFI_PARAMS_FROM_FDT
 	bool
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b1601aad7e1a..ba1e400960f5 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -83,7 +83,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
-lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86)		+= x86-stub.o x86-extract-direct.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/x86-extract-direct.c b/drivers/firmware/efi/libstub/x86-extract-direct.c
new file mode 100644
index 000000000000..2d3107fd4623
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-extract-direct.c
@@ -0,0 +1,204 @@
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
+#include "x86-stub.h"
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
+	if ((flags & (MAP_PROTECT | MAP_ALLOC)) &&
+	    IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
+		unsigned long attr = 0;
+
+		if (!(flags & MAP_EXEC))
+			attr |= EFI_MEMORY_XP;
+
+		if (!(flags & MAP_WRITE))
+			attr |= EFI_MEMORY_RO;
+
+		status = efi_adjust_memory_range_protection(start, size, attr);
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
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
+		/* First page of trampoline is a top level page table */
+		efi_adjust_memory_range_protection(trampoline_start,
+						   PAGE_SIZE,
+						   EFI_MEMORY_XP);
+	}
+
+	/* Second page of trampoline is the code (with a padding) */
+
+	void *caddr = (void *)trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET;
+
+	memcpy(caddr, trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
+		efi_adjust_memory_range_protection((unsigned long)caddr,
+						   PAGE_SIZE,
+						   EFI_MEMORY_RO);
+
+		/* And the last page of trampoline is the stack */
+
+		efi_adjust_memory_range_protection(trampoline_start + 2 * PAGE_SIZE,
+						   PAGE_SIZE,
+						   EFI_MEMORY_XP);
+	}
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
+static efi_status_t init_loader_data(struct boot_params *params, struct efi_boot_memmap **map)
+{
+	struct efi_info *efi = (void *)&params->efi_info;
+	efi_status_t status;
+
+	status = efi_get_memory_map(map, false);
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
+	efi->efi_memdesc_size = (*map)->desc_size;
+	efi->efi_memdesc_version = (*map)->desc_ver;
+	efi->efi_memmap_size = (*map)->map_size;
+
+	efi_set_u64_split((unsigned long)(*map)->map,
+			  &efi->efi_memmap, &efi->efi_memmap_hi);
+
+	efi_set_u64_split((unsigned long)efi_system_table,
+			  &efi->efi_systab, &efi->efi_systab_hi);
+
+	return EFI_SUCCESS;
+}
+
+static void free_loader_data(struct boot_params *params, struct efi_boot_memmap *map)
+{
+	struct efi_info *efi = (void *)&params->efi_info;
+
+	efi_bs_call(free_pool, map);
+
+	efi->efi_memdesc_size = 0;
+	efi->efi_memdesc_version = 0;
+	efi->efi_memmap_size = 0;
+	efi_set_u64_split(0, &efi->efi_memmap, &efi->efi_memmap_hi);
+}
+
+extern unsigned char input_data[];
+extern unsigned int output_len, input_len;
+
+unsigned long extract_kernel_direct(struct boot_params *params)
+{
+
+	void *res;
+	efi_status_t status;
+	struct efi_extract_callbacks cb = { 0 };
+
+	status = prepare_trampoline();
+
+	if (status != EFI_SUCCESS)
+		return 0;
+
+	/* Prepare environment for do_extract_kernel() call */
+	struct efi_boot_memmap *map = NULL;
+	status = init_loader_data(params, &map);
+
+	if (status != EFI_SUCCESS)
+		return 0;
+
+	cb.puthex = do_puthex;
+	cb.putstr = do_putstr;
+	cb.map_range = do_map_range;
+
+	res = efi_extract_kernel(params, &cb, input_data, input_len,
+				 (unsigned char *)startup_32, output_len);
+
+	free_loader_data(params, map);
+
+	return (unsigned long)res;
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2fddb88613cd..8f172b688b0c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 
 #include "efistub.h"
+#include "x86-stub.h"
 
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
@@ -212,55 +213,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
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
-	efi_adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-					   TRAMPOLINE_PLACEMENT_SIZE, 0);
-
-#ifdef CONFIG_64BIT
-	if (image_base != (unsigned long)startup_32)
-		efi_adjust_memory_range_protection(image_base, image_size, 0);
-#else
-	/*
-	 * Clear protection flags on a whole range of possible
-	 * addresses used for KASLR. We don't need to do that
-	 * on x86_64, since KASLR/extraction is performed after
-	 * dedicated identity page tables are built and we only
-	 * need to remove possible protection on relocated image
-	 * itself disregarding further relocations.
-	 */
-	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR,
-					   0);
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
@@ -269,9 +224,6 @@ static void setup_quirks(struct boot_params *boot_params,
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
-
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
-		setup_memory_protection(image_base, image_size);
 }
 
 /*
@@ -707,8 +659,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 }
 
 /*
- * On success, we return the address of startup_32, which has potentially been
- * relocated by efi_relocate_kernel.
+ * On success, we return extracted kernel entry point.
  * On failure, we exit to the firmware via efi_exit instead of returning.
  */
 asmlinkage unsigned long efi_main(efi_handle_t handle,
@@ -733,60 +684,6 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
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
@@ -843,7 +740,11 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
+	setup_quirks(boot_params);
+
+	bzimage_addr = extract_kernel_direct(boot_params);
+	if (!bzimage_addr)
+		goto fail;
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
new file mode 100644
index 000000000000..5fbc743eb367
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DRIVERS_FIRMWARE_EFI_X86STUB_H
+#define _DRIVERS_FIRMWARE_EFI_X86STUB_H
+
+#include <asm/bootparam.h>
+
+unsigned long extract_kernel_direct(struct boot_params *boot_params);
+void startup_32(struct boot_params *boot_params);
+
+#endif
-- 
2.37.4

