Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839207668A5
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjG1JQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjG1JPu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53BF55A6;
        Fri, 28 Jul 2023 02:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C3162062;
        Fri, 28 Jul 2023 09:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869B1C433CD;
        Fri, 28 Jul 2023 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535535;
        bh=kseV7Rj3Bkb9LH1tRW8Kw8Nhpfw+29rcJtmAMcCIsdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQHvkcL3FeWSNEJ4c/GoeXMkv+y0BkbRd4BVP4sd0CvWlNbCXcPqeluFV7OpdkHOA
         bCdPrJ5ekQSagwLujJ8SJy90BMfXeL4AbS/RDGo9rqRkCa53jfuFnHPBAXjl9JWmrd
         oToAH3Qox44XvQpzAqeT5JDx3VX/612uLk4YvY3WHOZrzG7aVLg1v6NRwY8V9OsWWp
         MGOmzG+qYVrOOIhzaFfalPHi2wYwLIip/DWfa4ZDDxwcjCM00NGaFyiUvlXHU5Eq3Z
         Y6KbjjXuQtKgVVBQcLLQEZTsU83jYS+lrsXVd2mWTnrc+VwPe8Pi7ix8QevF7TrZRx
         Ih87ZjNZ65CCg==
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v7 22/22] x86/efistub: Avoid legacy decompressor when doing EFI boot
Date:   Fri, 28 Jul 2023 11:09:16 +0200
Message-Id: <20230728090916.1538550-23-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18507; i=ardb@kernel.org; h=from:subject; bh=kseV7Rj3Bkb9LH1tRW8Kw8Nhpfw+29rcJtmAMcCIsdU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6+7e3X9vcM6tOLbl6KWJe9ZLPcwSlwvZ8qLLLur7q mDrYp3UjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARbVFGht8n65I0nVd5HK3w OPvuj3Pjmp4pKRVsT6Xy6j43yFZP4mRk2JQ+T57Dx/ntz1utfiGvvpYna/pZrHL3yOCKbyz6evA YOwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

In particular, the decompressor moves its own executable image around in
memory, and relies on demand paging to populate the identity mappings,
and these things are difficult to support in a context where memory is
not permitted to be mapped writable and executable at the same time or,
at the very least, is mapped non-executable by default, and needs
special treatment for this restriction to be lifted.

Since EFI already maps all of memory 1:1, it is unnecessary to create
new page tables or handle page faults when decompressing the kernel.
That means there is also no need to replace the special exception
handlers for SEV. Generally, there is little need to do anything that
the decompressor does beyond

- initialize SEV encryption, if needed,
- perform the 4/5 level paging switch, if needed,
- decompress the kernel
- relocate the kernel

So do all of this from the EFI stub code, and avoid the bare metal
decompressor altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       |   5 +
 arch/x86/boot/compressed/efi_mixed.S    |  55 -------
 arch/x86/boot/compressed/head_32.S      |  13 --
 arch/x86/boot/compressed/head_64.S      |  27 ----
 arch/x86/include/asm/efi.h              |   7 +-
 arch/x86/include/asm/sev.h              |   2 +
 drivers/firmware/efi/libstub/x86-stub.c | 166 +++++++++-----------
 7 files changed, 84 insertions(+), 191 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 40d2ff503079e594..71fc531b95b4eede 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -74,6 +74,11 @@ LDFLAGS_vmlinux += -z noexecstack
 ifeq ($(CONFIG_LD_IS_BFD),y)
 LDFLAGS_vmlinux += $(call ld-option,--no-warn-rwx-segments)
 endif
+ifeq ($(CONFIG_EFI_STUB),y)
+# ensure that the static EFI stub library will be pulled in, even if it is
+# never referenced explicitly from the startup code
+LDFLAGS_vmlinux += -u efi_pe_entry
+endif
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 8a02a151806df14c..f4e22ef774ab6b4a 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -269,10 +269,6 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
 /*
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
  *			       efi_system_table_32_t *sys_table)
@@ -280,8 +276,6 @@ SYM_FUNC_END(efi32_entry)
 SYM_FUNC_START(efi32_pe_entry)
 	pushl	%ebp
 	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
 	pushl	%ebx				// save callee-save registers
 	pushl	%edi
 
@@ -290,48 +284,8 @@ SYM_FUNC_START(efi32_pe_entry)
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
@@ -350,15 +304,6 @@ SYM_FUNC_START_NOALIGN(efi64_stub_entry)
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
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
index beee858058df4403..cd9587fcd5084f22 100644
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
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a9237e48f2f7cfd5..f8630588042e38d3 100644
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
@@ -335,20 +322,6 @@ SYM_CODE_START(startup_64)
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
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8b4be7cecdb8eb73..b0994ae3bc23f84d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -90,6 +90,8 @@ static inline void efi_fpu_end(void)
 }
 
 #ifdef CONFIG_X86_32
+#define EFI_X86_KERNEL_ALLOC_LIMIT		(SZ_512M - 1)
+
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_fpu_begin();						\
@@ -103,8 +105,7 @@ static inline void efi_fpu_end(void)
 })
 
 #else /* !CONFIG_X86_32 */
-
-#define EFI_LOADER_SIGNATURE	"EL64"
+#define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
 extern asmlinkage u64 __efi_call(void *fp, ...);
 
@@ -218,6 +219,8 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 #ifdef CONFIG_EFI_MIXED
 
+#define EFI_ALLOC_LIMIT		(efi_is_64bit() ? ULONG_MAX : U32_MAX)
+
 #define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index b97d239e18ea25fc..5b4a1ce3d36808b4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -164,6 +164,7 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern void sev_enable(struct boot_params *bp);
 
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
@@ -218,6 +219,7 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3681700702126615..e976288728e975f1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,17 +15,14 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/kaslr.h>
 #include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
 
-/* Maximum physical address for 64-bit kernel with 4-level paging */
-#define MAXMEM_X86_64_4LEVEL (1ull << 46)
-
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 static efi_memory_attribute_protocol_t *memattr;
 
@@ -287,28 +284,6 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	}
 }
 
-extern const char startup_32[], startup_64[];
-
-static void
-setup_memory_protection(unsigned long image_base, unsigned long image_size)
-{
-#ifdef CONFIG_64BIT
-	if (image_base != (unsigned long)startup_32)
-		efi_adjust_memory_range_protection(image_base, image_size);
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
-					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
-#endif
-}
-
 static void setup_unaccepted_memory(void)
 {
 	efi_guid_t mem_acceptance_proto = OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
@@ -334,9 +309,7 @@ static void setup_unaccepted_memory(void)
 
 static const efi_char16_t apple[] = L"Apple";
 
-static void setup_quirks(struct boot_params *boot_params,
-			 unsigned long image_base,
-			 unsigned long image_size)
+static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor);
@@ -345,9 +318,6 @@ static void setup_quirks(struct boot_params *boot_params,
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
-
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
-		setup_memory_protection(image_base, image_size);
 }
 
 /*
@@ -500,7 +470,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	}
 
 	image_base = efi_table_attr(image, image_base);
-	image_offset = (void *)startup_32 - image_base;
 
 	status = efi_allocate_pages(sizeof(struct boot_params),
 				    (unsigned long *)&boot_params, ULONG_MAX);
@@ -804,6 +773,61 @@ static bool have_unsupported_snp_features(void)
 	return false;
 }
 
+static void efi_get_seed(void *seed, int size)
+{
+	efi_get_random_bytes(size, seed);
+
+	/*
+	 * This only updates seed[0] when running on 32-bit, but in that case,
+	 * seed[1] is not used anyway, as there is no virtual KASLR on 32-bit.
+	 */
+	*(unsigned long *)seed ^= kaslr_get_random_long("EFI");
+}
+
+static void error(char *str)
+{
+	efi_warn("Decompression failed: %s\n", str);
+}
+
+static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
+{
+	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	unsigned long addr, alloc_size, entry;
+	efi_status_t status;
+	u32 seed[2] = {};
+
+	/* determine the required size of the allocation */
+	alloc_size = ALIGN(max_t(unsigned long, output_len, kernel_total_size),
+			   MIN_KERNEL_ALIGN);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
+		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+
+		efi_get_seed(seed, sizeof(seed));
+
+		virt_addr += (range * seed[1]) >> 32;
+		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+	}
+
+	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
+				  seed[0], EFI_LOADER_CODE,
+				  EFI_X86_KERNEL_ALLOC_LIMIT);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	entry = decompress_kernel((void *)addr, virt_addr, error);
+	if (entry == ULONG_MAX) {
+		efi_free(alloc_size, addr);
+		return EFI_LOAD_ERROR;
+	}
+
+	*kernel_entry = addr + entry;
+
+	efi_adjust_memory_range_protection(addr, kernel_total_size);
+
+	return EFI_SUCCESS;
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -823,10 +847,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       struct boot_params *boot_params)
 {
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
-	unsigned long bzimage_addr = (unsigned long)startup_32;
-	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
+	unsigned long kernel_entry;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -855,60 +878,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
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
@@ -926,6 +895,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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
@@ -965,7 +940,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
+	setup_quirks(boot_params);
 
 	setup_unaccepted_memory();
 
@@ -975,12 +950,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/*
+	 * Call the SEV init code while still running with the firmware's
+	 * GDT/IDT, so #VC exceptions will be handled by EFI.
+	 */
+	sev_enable(boot_params);
+
 	efi_5level_switch();
 
-	if (IS_ENABLED(CONFIG_X86_64))
-		bzimage_addr += startup_64 - startup_32;
-
-	enter_kernel(bzimage_addr, boot_params);
+	enter_kernel(kernel_entry, boot_params);
 fail:
 	efi_err("efi_stub_entry() failed!\n");
 
-- 
2.39.2

