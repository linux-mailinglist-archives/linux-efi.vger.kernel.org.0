Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F874EA1B
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGKJRk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGKJQx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47139E6F;
        Tue, 11 Jul 2023 02:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0893613FB;
        Tue, 11 Jul 2023 09:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D8C433CA;
        Tue, 11 Jul 2023 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066963;
        bh=HWndNvxda5pRDTgZFlgItv6N53eQtneuBm/hlDiHRpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpeBOUz3IRUlzFErUefytVpwqlvpVtqACZnBKoY9dQuHNHjkBNBaEdrHFkKaBrmw2
         4vsHWPFvH5Dsdcbcy2+k8ac4ulzMGr6z0fIv7xfYe/WIeYE7vm8mBbBXyzg7v0Z7vU
         QO9KfM2KAAxeWFaKATbh5nZidHn7LSsd6JmoM+2Skc77wQItobVxmayFZ5j6kPJBxK
         cukqmENnNDr0PBU2AlQVfBhDY5vr+1GJsfmg0LNQutObP3iw4Jj7aTn6DQpTglwHEt
         0q6tbnKk0AExU13oDO6gcAQvjwL8NAJcuGJgq0N1RI5Wt5cLeGL2uBJMgEjmfqshUp
         AMXiXlNJYY6YA==
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
Subject: [PATCH v6 14/21] x86/efistub: Perform 4/5 level paging switch from the stub
Date:   Tue, 11 Jul 2023 11:14:46 +0200
Message-Id: <20230711091453.2543622-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10111; i=ardb@kernel.org; h=from:subject; bh=HWndNvxda5pRDTgZFlgItv6N53eQtneuBm/hlDiHRpo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbKv37Xda62bEf+/4lVLXrtBUudksgzU9tbD2dceKt RwpK8U7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETYHzH801v+1T1XWFs4zUpm 4owZK4uLt0x+fvD4/KU/amxVzTKWbGNkWPdE1XDj2++HP9WoXX91Wm7Vn5ezz2Qasd99fuMa07q aRDYA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for updating the EFI stub boot flow to avoid the bare
metal decompressor code altogether, implement the support code for
switching between 4 and 5 levels of paging before jumping to the kernel
proper.

This reuses the newly refactored trampoline that the bare metal
decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
memory and remap it with the appropriate permissions. Given that the
bare metal decompressor will no longer call into the trampoline if the
number of paging levels is already set correctly, it is no longer needed
to remove NX restrictions from the memory range where this trampoline
may end up.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/x86-5lvl.c        | 95 ++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 40 +++------
 drivers/firmware/efi/libstub/x86-stub.h        | 17 ++++
 6 files changed, 130 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 16d64a34d1e19465..ae8874401a9f1490 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -88,6 +88,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 732984295295fb6d..bfa30625f5d03167 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -73,6 +73,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6aa38a1bf1265d83..06b7abc92ced9e18 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,6 +33,7 @@
 #define EFI_ALLOC_LIMIT		ULONG_MAX
 #endif
 
+extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
new file mode 100644
index 0000000000000000..2428578a3ae08be7
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/efi.h>
+
+#include <asm/boot.h>
+#include <asm/desc.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+#include "x86-stub.h"
+
+bool efi_no5lvl;
+
+static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
+
+static const struct desc_struct gdt[] = {
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+};
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as programming
+ * a 64-bit value into CR3 when running in 32-bit mode is not supported.
+ */
+efi_status_t efi_setup_5level_paging(void)
+{
+	u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
+	efi_status_t status;
+	u8 *la57_code;
+
+	if (!efi_is_64bit())
+		return EFI_SUCCESS;
+
+	/* check for 5 level paging support */
+	if (native_cpuid_eax(0) < 7 ||
+	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return EFI_SUCCESS;
+
+	/* allocate some 32-bit addressable memory for code and a page table */
+	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
+				    U32_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
+	memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
+
+	/*
+	 * To avoid the need to allocate a 32-bit addressable stack, the
+	 * trampoline uses a LJMP instruction to switch back to long mode.
+	 * LJMP takes an absolute destination address, which needs to be
+	 * fixed up at runtime.
+	 */
+	*(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
+
+	efi_adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+void efi_5level_switch(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	bool need_toggle = want_la57 ^ have_la57;
+	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
+	u64 *cr3 = (u64 *)__native_read_cr3();
+	u64 *new_cr3;
+
+	if (!la57_toggle || !need_toggle)
+		return;
+
+	if (!have_la57) {
+		/*
+		 * 5 level paging will be enabled, so a root level page needs
+		 * to be allocated from the 32-bit addressable physical region,
+		 * with its first entry referring to the existing hierarchy.
+		 */
+		new_cr3 = memset(pgt, 0, PAGE_SIZE);
+		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
+	} else {
+		/* take the new root table pointer from the current entry #0 */
+		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+
+		/* copy the new root table if it is not 32-bit addressable */
+		if ((u64)new_cr3 > U32_MAX)
+			new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
+	}
+
+	native_load_gdt(&(struct desc_ptr){ sizeof(gdt) - 1, (u64)gdt });
+
+	la57_toggle(new_cr3, want_la57);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9e1994c6afc672ca..961ae3bd87058a45 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 
 #include "efistub.h"
+#include "x86-stub.h"
 
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
@@ -223,8 +224,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-static void
-adjust_memory_range_protection(unsigned long start, unsigned long size)
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
@@ -278,35 +279,14 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
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
 extern const char startup_32[], startup_64[];
 
 static void
 setup_memory_protection(unsigned long image_base, unsigned long image_size)
 {
-	/*
-	 * Allow execution of possible trampoline used
-	 * for switching between 4- and 5-level page tables
-	 * and relocated kernel image.
-	 */
-
-	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-				       TRAMPOLINE_PLACEMENT_SIZE);
-
 #ifdef CONFIG_64BIT
 	if (image_base != (unsigned long)startup_32)
-		adjust_memory_range_protection(image_base, image_size);
+		efi_adjust_memory_range_protection(image_base, image_size);
 #else
 	/*
 	 * Clear protection flags on a whole range of possible
@@ -316,8 +296,8 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 	 * need to remove possible protection on relocated image
 	 * itself disregarding further relocations.
 	 */
-	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
+					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
 #endif
 }
 
@@ -839,6 +819,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+	status = efi_setup_5level_paging();
+	if (status != EFI_SUCCESS) {
+		efi_err("efi_setup_5level_paging() failed!\n");
+		goto fail;
+	}
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -959,6 +945,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	efi_5level_switch();
+
 	if (IS_ENABLED(CONFIG_X86_64))
 		bzimage_addr += startup_64 - startup_32;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
new file mode 100644
index 0000000000000000..37c5a36b9d8cf9b2
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/efi.h>
+
+extern void trampoline_32bit_src(void *, bool);
+extern const u16 trampoline_ljmp_imm_offset;
+
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size);
+
+#ifdef CONFIG_X86_64
+efi_status_t efi_setup_5level_paging(void);
+void efi_5level_switch(void);
+#else
+static inline efi_status_t efi_setup_5level_paging(void) { return EFI_SUCCESS; }
+static inline void efi_5level_switch(void) {}
+#endif
-- 
2.39.2

