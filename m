Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6365AE592
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiIFKmC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbiIFKl5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 06:41:57 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979660683;
        Tue,  6 Sep 2022 03:41:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8D727407625F;
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
Subject: [PATCH 12/16] x86/boot: Add EFI kernel extraction interface
Date:   Tue,  6 Sep 2022 13:41:16 +0300
Message-Id: <8e9f2d7b0645e17efaa9eec0423f6d2c4a55fc16.1662459668.git.baskov@ispras.ru>
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

To enable extraction of kernel image from EFI stub code directly
extraction code needs to have separate interface that avoid part
of low level initialization logic, i.e. serial port setup.

Add kernel extraction function callable from libstub as a part
of preparation for extracting the kernel directly from EFI environment.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_32.S |  3 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 85 +++++++++++++++++++++---------
 arch/x86/boot/compressed/misc.h    |  2 +
 arch/x86/boot/compressed/putstr.c  |  9 ++++
 5 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb9516d..b46a1c4109cf 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -217,8 +217,7 @@ SYM_DATA(image_offset, .long 0)
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
index 889ca7176aa7..37ce094571b5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -1007,7 +1007,7 @@ SYM_FUNC_END(startup32_check_sev_cbit)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
+SYM_DATA(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e2c0d05ac293..8016cc5c300e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -293,11 +293,11 @@ static void parse_elf(void *output, unsigned long output_len,
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
@@ -311,18 +311,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	sanitize_boot_params(boot_params);
 
-	init_default_io_ops();
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
@@ -330,11 +318,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
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
@@ -387,12 +370,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
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
@@ -406,12 +389,64 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
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
+			 struct efi_iofunc *iofunc,
+			 unsigned char *input_data,
+			 unsigned long input_len,
+			 unsigned char *output,
+			 unsigned long output_len)
+{
+	extern char boot_heap[BOOT_HEAP_SIZE];
+
+	free_mem_ptr     = (unsigned long)boot_heap;	/* Heap */
+	free_mem_end_ptr = (unsigned long)boot_heap + BOOT_HEAP_SIZE;
+
+	init_efi_console(iofunc);
+
+	return do_extract_kernel(rmode, input_data,
+				 input_len, output, output_len);
+}
+
+
+
+
 void fortify_panic(const char *name)
 {
 	error("detected buffer overflow");
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 39dc3de50268..b5aa0af6c59e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -26,6 +26,7 @@
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/shared/extract.h>
 
 #include "tdx.h"
 
@@ -126,6 +127,7 @@ static inline void console_init(void)
 
 /* putstr.c */
 void init_bare_console(void);
+void init_efi_console(struct efi_iofunc *iofunc);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_enable(struct boot_params *bp);
diff --git a/arch/x86/boot/compressed/putstr.c b/arch/x86/boot/compressed/putstr.c
index accba0de8be9..238d9677df61 100644
--- a/arch/x86/boot/compressed/putstr.c
+++ b/arch/x86/boot/compressed/putstr.c
@@ -32,6 +32,15 @@ void init_bare_console(void)
 	console_init();
 }
 
+void init_efi_console(struct efi_iofunc *iofunc)
+{
+	__putstr = iofunc->putstr;
+	__puthex = iofunc->puthex;
+#ifdef CONFIG_X86_64
+	kernel_add_identity_map = iofunc->map_range;
+#endif
+}
+
 static void scroll(void)
 {
 	int i;
-- 
2.35.1

