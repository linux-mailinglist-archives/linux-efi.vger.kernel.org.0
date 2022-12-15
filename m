Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE964DB6D
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLOMm0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLOMl1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:41:27 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944A2F02A;
        Thu, 15 Dec 2022 04:40:27 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 73829419E9F5;
        Thu, 15 Dec 2022 12:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 73829419E9F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671108024;
        bh=CcUz+15edmZsS1ZVHpfrJ2bqia1S5svpxaNUuBl0QvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXZHg1NWC1+qE18HYOL8GMhm19X9E0NMkfVI8gL7kq5hHY7/7ahFrn7V8iKBkIAk1
         Zed6nPNZmQSOZ8wYBNaZVYiAjpAuukBMAdnJFVN5pW2KtzEFabaJfOQ3iipadAEYt7
         ZIfHz2f8ERFXeDEBAqJUJi9csJuD1X2IvhZ9HPSE=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 14/26] x86/boot: Add EFI kernel extraction interface
Date:   Thu, 15 Dec 2022 15:38:05 +0300
Message-Id: <4692c9f47a151f78467f310dc8b49ec0dad878a3.1671098103.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
References: <cover.1671098103.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To enable extraction of kernel image from EFI stub code directly
extraction code needs to have separate interface that avoid part
of low level initialization logic, i.e. serial port setup.

Add kernel extraction function callable from libstub as a part
of preparation for extracting the kernel directly from EFI environment.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_32.S    |   3 +-
 arch/x86/boot/compressed/head_64.S    |   2 +-
 arch/x86/boot/compressed/misc.c       | 100 +++++++++++++++++---------
 arch/x86/boot/compressed/misc.h       |   1 +
 arch/x86/include/asm/shared/extract.h |  26 +++++++
 5 files changed, 96 insertions(+), 36 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/extract.h

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 6589ddd4cfaf..ead6007df1e5 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -213,8 +213,7 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
+SYM_DATA(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 boot_stack:
 	.fill BOOT_STACK_SIZE, 1, 0
 boot_stack_end:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8b9c4fe17126..2dd8be0583d2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -747,7 +747,7 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
+SYM_DATA(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c9c235d65d16..ebf229c38b3b 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -308,11 +308,11 @@ static inline unsigned long kernel_add_identity_map_dummy(unsigned long start,
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
-				  unsigned char *input_data,
-				  unsigned long input_len,
-				  unsigned char *output,
-				  unsigned long output_len)
+static void *do_extract_kernel(void *rmode,
+			       unsigned char *input_data,
+			       unsigned long input_len,
+			       unsigned char *output,
+			       unsigned long output_len)
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
@@ -326,26 +326,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	sanitize_boot_params(boot_params);
 
-	init_default_io_ops();
-
-	/*
-	 * On 64-bit this pointer is set during page table uninitialization,
-	 * but on 32-bit it remains uninitialized, since paging is disabled.
-	 */
-	if (IS_ENABLED(CONFIG_X86_32))
-		kernel_add_identity_map = kernel_add_identity_map_dummy;
-
-
-	/*
-	 * Detect TDX guest environment.
-	 *
-	 * It has to be done before console_init() in order to use
-	 * paravirtualized port I/O operations if needed.
-	 */
-	early_tdx_detect();
-
-	init_bare_console();
-
 	/*
 	 * Save RSDP address for later use. Have this after console_init()
 	 * so that early debugging output from the RSDP parsing code can be
@@ -353,11 +333,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 */
 	boot_params->acpi_rsdp_addr = get_rsdp_addr();
 
-	debug_putstr("early console in extract_kernel\n");
-
-	free_mem_ptr     = heap;	/* Heap */
-	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
-
 	/*
 	 * The memory hole needed for the kernel is the larger of either
 	 * the entire decompressed kernel plus relocation table, or the
@@ -411,12 +386,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	if (virt_addr & (MIN_KERNEL_ALIGN - 1))
 		error("Destination virtual address inappropriately aligned");
 #ifdef CONFIG_X86_64
-	if (heap > 0x3fffffffffffUL)
+	if (phys_addr > 0x3fffffffffffUL)
 		error("Destination address too large");
 	if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
 		error("Destination virtual address is beyond the kernel mapping area");
 #else
-	if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
+	if (phys_addr > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
 		error("Destination address too large");
 #endif
 #ifndef CONFIG_RELOCATABLE
@@ -430,12 +405,71 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	parse_elf(output, output_len, virt_addr);
 	debug_putstr("done.\nBooting the kernel.\n");
 
+	return output;
+}
+
+asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
+				  unsigned char *input_data,
+				  unsigned long input_len,
+				  unsigned char *output,
+				  unsigned long output_len)
+{
+	void *entry;
+
+	init_default_io_ops();
+
+	/*
+	 * On 64-bit this pointer is set during page table uninitialization,
+	 * but on 32-bit it remains uninitialized, since paging is disabled.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32))
+		kernel_add_identity_map = kernel_add_identity_map_dummy;
+
+	/*
+	 * Detect TDX guest environment.
+	 *
+	 * It has to be done before console_init() in order to use
+	 * paravirtualized port I/O operations if needed.
+	 */
+	early_tdx_detect();
+
+	init_bare_console();
+
+	debug_putstr("early console in extract_kernel\n");
+
+	free_mem_ptr     = heap;	/* Heap */
+	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
+
+	entry = do_extract_kernel(rmode, input_data,
+				  input_len, output, output_len);
+
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
 
-	return output;
+	return entry;
 }
 
+void *efi_extract_kernel(struct boot_params *rmode,
+			 struct efi_extract_callbacks *cb,
+			 unsigned char *input_data,
+			 unsigned long input_len,
+			 unsigned long output_len)
+{
+	extern char boot_heap[BOOT_HEAP_SIZE];
+
+	free_mem_ptr     = (unsigned long)boot_heap;	/* Heap */
+	free_mem_end_ptr = (unsigned long)boot_heap + BOOT_HEAP_SIZE;
+
+	init_console_func(cb->putstr, cb->puthex);
+	kernel_add_identity_map = cb->map_range;
+
+	return do_extract_kernel(rmode, input_data,
+				 input_len, (void *)LOAD_PHYSICAL_ADDR, output_len);
+}
+
+
+
+
 void fortify_panic(const char *name)
 {
 	error("detected buffer overflow");
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 0076b2845b4b..379c4a3ca7dd 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -26,6 +26,7 @@
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/shared/extract.h>
 
 #include "tdx.h"
 
diff --git a/arch/x86/include/asm/shared/extract.h b/arch/x86/include/asm/shared/extract.h
new file mode 100644
index 000000000000..46bf56348a86
--- /dev/null
+++ b/arch/x86/include/asm/shared/extract.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_SHARED_EXTRACT_H
+#define ASM_SHARED_EXTRACT_H
+
+#include <asm/bootparam.h>
+
+#define MAP_WRITE	0x02 /* Writable memory */
+#define MAP_EXEC	0x04 /* Executable memory */
+#define MAP_ALLOC	0x10 /* Range needs to be allocated */
+#define MAP_PROTECT	0x20 /* Set exact memory attributes for memory range */
+
+struct efi_extract_callbacks {
+	void (*putstr)(const char *msg);
+	void (*puthex)(unsigned long x);
+	unsigned long (*map_range)(unsigned long start,
+				   unsigned long end,
+				   unsigned int flags);
+};
+
+void *efi_extract_kernel(struct boot_params *rmode,
+			 struct efi_extract_callbacks *cb,
+			 unsigned char *input_data,
+			 unsigned long input_len,
+			 unsigned long output_len);
+
+#endif /* ASM_SHARED_EXTRACT_H */
-- 
2.37.4

