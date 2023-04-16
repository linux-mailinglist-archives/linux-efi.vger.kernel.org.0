Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F86E37E2
	for <lists+linux-efi@lfdr.de>; Sun, 16 Apr 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDPMIK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Apr 2023 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDPMIJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Apr 2023 08:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D54496;
        Sun, 16 Apr 2023 05:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FFA760C35;
        Sun, 16 Apr 2023 12:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3734CC4339E;
        Sun, 16 Apr 2023 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681646884;
        bh=RSLo45meUQV4Fx9mmwipFKFKmHuaB+q2lMVYoJK+JQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUdLmVKdjogFq8Io6nTSZSJzUCIHeEAEoVuxHi7kSNmLe2EhxonlJKmLTP5b5+ULO
         BQx1OfPnyfaVr/KZY+CC7eISnF2/1OtTIRa4j+xTPmjV/Dsc9X8A5RcDycpBWfYzQt
         DXlJU1+dKZ8ZZm5V2WiWrEV2Pb+gBxfbkomyE3r9Jj7sisG3L0gJNFJq8OQoBRZ5/T
         Gl58o74Sew3KbR9izCnaYSRyWGWBhgk0rAMiA3AQhRF7JRPAKNeO12PfNlymt7Rei3
         B/r5pt1fAeKEDYSSttlNuXIB1sFDA00b/8IJLsEMRcrt9cTDvSHPR4okWn6MhGXS7M
         2xMba6TBHEs6g==
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
Subject: [RFC PATCH 2/3] efi/zboot: x86: Implement EFI zboot support
Date:   Sun, 16 Apr 2023 14:07:28 +0200
Message-Id: <20230416120729.2470762-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21155; i=ardb@kernel.org; h=from:subject; bh=RSLo45meUQV4Fx9mmwipFKFKmHuaB+q2lMVYoJK+JQw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcX6yf83Sb8Za+xdHgtzbxHcazuxvbqjYN2a25vz5JZuu JCYJBjdUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayt53hf77U9erJus3mf63j sp5zXxAUumAjttvMrip3txqrfHD5N4bfLDsWPDfeuD19ifSshcbR2Rfmnp45rXmfo8lEiZC2fY6 8bAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Wire up the Kbuild rules and implement the missing pieces that permit
the 64-bit x86 kernel to be built as a EFI zboot image, i.e., the
generic self-decompressing format that is already supported for arm64,
RISC-V, LoongArch and [shortly] ARM.

Both physical and virtual KASLR are supported, as well as 5 level
paging, which are the primary reasons we rely on the bare metal
decompressor today.

EFI mixed mode (i.e., running the 64-bit kernel on a 64-bit CPU that
booted using 32-bit firmware) is not supported - 32-bit EFI may not
enable paging at all, or run with PAE disabled, in which case the long
mode switch requires setting up new page tables etc. Implementing mixed
mode in a way that only supports 32-bit firmware that enters with paging
and PAE enabled should be rather straight-forward, and could be
considered as a future enhancement.

Another thing that is not supported is the EFI handover protocol, which
has no basis in the EFI spec, and is only implemented by downstream GRUB
builds packaged by the distros.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                              |  18 +-
 arch/x86/include/asm/efi.h                     |   5 +
 arch/x86/kernel/head_64.S                      |  11 +
 arch/x86/zboot/Makefile                        |  29 ++
 drivers/firmware/efi/Kconfig                   |   2 +-
 drivers/firmware/efi/libstub/Makefile          |  13 +-
 drivers/firmware/efi/libstub/Makefile.zboot    |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +
 drivers/firmware/efi/libstub/x86-stub.c        |   1 -
 drivers/firmware/efi/libstub/x86-zboot.c       | 295 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c           |   3 +-
 drivers/firmware/efi/libstub/zboot.lds         |   5 +
 12 files changed, 375 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c037c03..a9ef9f6679c8a3ef 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -268,25 +268,33 @@ boot := arch/x86/boot
 
 BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 hdimage isoimage
 
-PHONY += bzImage $(BOOT_TARGETS)
-
-# Default kernel to build
-all: bzImage
+PHONY += bzImage vmlinuz.efi $(BOOT_TARGETS)
 
 # KBUILD_IMAGE specify target image being built
+ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE := $(boot)/bzImage
+else
+KBUILD_IMAGE := arch/x86/zboot/vmlinuz.efi
+endif
+
+# Default kernel to build
+all:	$(notdir $(KBUILD_IMAGE))
 
 bzImage: vmlinux
 ifeq ($(CONFIG_X86_DECODER_SELFTEST),y)
 	$(Q)$(MAKE) $(build)=arch/x86/tools posttest
 endif
-	$(Q)$(MAKE) $(build)=$(boot) $(KBUILD_IMAGE)
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$(@)
 	$(Q)mkdir -p $(objtree)/arch/$(UTS_MACHINE)/boot
 	$(Q)ln -fsn ../../x86/boot/bzImage $(objtree)/arch/$(UTS_MACHINE)/boot/$@
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
+vmlinuz.efi: zboot := arch/x86/zboot
+vmlinuz.efi: vmlinux
+	$(Q)$(MAKE) $(build)=$(zboot) $(zboot)/$@
+
 PHONY += install
 install:
 	$(call cmd,install)
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index dd49cb9b6e3a1f1f..35d49f45260d3c72 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -471,4 +471,9 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
 
 #endif
 
+static inline unsigned long efi_get_kimg_min_align(void)
+{
+	return SZ_2M;
+}
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 222efd4a09bc8861..4ae067852fb28663 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -64,6 +64,17 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu(), similar to initial_stack below */
 	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
+#ifdef CONFIG_EFI_ZBOOT
+	/*
+	 * The generic EFI zboot code expects a __le32 at offset 0x10 of the
+	 * decompressed image describing the size in memory of the kernel
+	 * image. This is typically part of the image header, but we don't have
+	 * such a header on x86 so just put the bare number here, encoded in a
+	 * NOP instruction.
+	 */
+	.org	startup_64 + 0x10 - 3, BYTES_NOP1
+	nopl	(_end - startup_64)(%rax)
+#endif
 	leaq	_text(%rip), %rdi
 
 	/*
diff --git a/arch/x86/zboot/Makefile b/arch/x86/zboot/Makefile
new file mode 100644
index 0000000000000000..dce47a01ff482550
--- /dev/null
+++ b/arch/x86/zboot/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023 Google LLC. <ardb@google.com>
+#
+
+$(obj)/Image: OBJCOPYFLAGS := -O binary -S \
+			      -R .note -R .note.gnu.build-id -R .comment
+$(obj)/Image: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+CMD_RELOCS := arch/x86/tools/relocs
+
+quiet_cmd_relocs = RELOCS  $@
+      cmd_relocs = $(CMD_RELOCS) $< > $@
+
+$(obj)/vmlinux.relocs: vmlinux FORCE
+	$(call if_changed,relocs)
+
+efi-zboot-relocs-$(CONFIG_X86_NEED_RELOCS)	:= $(obj)/vmlinux.relocs
+EFI_ZBOOT_PAYLOAD_TRAILER			:= $(efi-zboot-relocs-y)
+
+EFI_ZBOOT_PAYLOAD				:= Image
+EFI_ZBOOT_BFD_TARGET				:= elf64-x86-64
+EFI_ZBOOT_MACH_TYPE				:= AMD64
+EFI_ZBOOT_FORWARD_CFI				:= $(CONFIG_X86_KERNEL_IBT)
+
+targets := Image vmlinux.relocs
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 043ca31c114ebf2a..b959bf41a49a97e1 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -74,7 +74,7 @@ config EFI_GENERIC_STUB
 
 config EFI_ZBOOT
 	bool "Enable the generic EFI decompressor"
-	depends on EFI_GENERIC_STUB && !ARM
+	depends on (EFI_GENERIC_STUB && !ARM) || X86_64
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
 	select HAVE_KERNEL_LZMA
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4dfbfac254614f18..2d733208e1b1efbe 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -9,6 +9,9 @@
 # non-x86 reuses KBUILD_CFLAGS, x86 does not
 cflags-y			:= $(KBUILD_CFLAGS)
 
+cflags-x86-$(CONFIG_X86_KERNEL_IBT) := \
+		$(call cc-option,-fcf-protection=branch -fno-jump-tables)
+
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
@@ -18,7 +21,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
 				   -fno-asynchronous-unwind-tables \
-				   $(CLANG_FLAGS)
+				   $(CLANG_FLAGS) $(cflags-x86-y)
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
@@ -82,8 +85,8 @@ lib-$(CONFIG_EFI_PARAMS_FROM_FDT) += fdt.o \
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
-				   screen_info.o efi-stub-entry.o
+lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o efi-stub-entry.o screen_info.o
+lib-y				+= string.o intrinsics.o systable.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o smbios.o
@@ -91,8 +94,12 @@ lib-$(CONFIG_X86)		+= x86.o x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
+cflags-zboot-$(CONFIG_X86)	:= -Defi_zboot_entry=__efistub_efi_zboot_entry
+CFLAGS_zboot.o			:= $(cflags-zboot-y)
+
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+zboot-obj-$(CONFIG_X86_64)	:= x86-zboot.o
 zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index d34d4f0ed33349d5..dbf2588ccaa625bd 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -29,7 +29,7 @@ zboot-size-len-y                       := 4
 zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
 zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
 
-$(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
+$(obj)/vmlinuz: $(obj)/vmlinux.bin $(EFI_ZBOOT_PAYLOAD_TRAILER) FORCE
 	$(call if_changed,$(zboot-method-y))
 
 OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..276d94ed31884308 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -16,6 +16,7 @@
 
 #include "efistub.h"
 
+bool efi_no5lvl;
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
@@ -73,6 +74,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d2b75025295822c7..d60c3cb8e6cbd0a4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -19,7 +19,6 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
diff --git a/drivers/firmware/efi/libstub/x86-zboot.c b/drivers/firmware/efi/libstub/x86-zboot.c
new file mode 100644
index 0000000000000000..16e8b315892dedda
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-zboot.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Google LLC. <ardb@google.com>
+ */
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+#include <linux/stddef.h>
+
+#include <asm/efi.h>
+#include <asm/e820/types.h>
+#include <asm/setup.h>
+#include <asm/desc.h>
+#include <asm/boot.h>
+
+#include "efistub.h"
+
+extern char _gzdata_end[];
+extern bool efi_no5lvl;
+
+static const struct desc_struct gdt[] = {
+	[GDT_ENTRY_KERNEL32_CS]	= GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]	= GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]	= GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+};
+
+static void (*la57_toggle)(void *cr3, void *gdt);
+
+#ifdef CONFIG_EFI_MIXED
+const bool efi_is64 = true;
+
+u64 __efi64_thunk(u32 func, ...)
+{
+	return EFI_UNSUPPORTED;
+}
+#endif
+
+efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
+{
+	int options_size = 0;
+	efi_status_t status;
+
+	/* Convert unicode cmdline to ascii */
+	*cmdline_ptr = efi_convert_cmdline(image, &options_size);
+	if (!*cmdline_ptr)
+		return EFI_OUT_OF_RESOURCES;
+
+#ifdef CONFIG_CMDLINE_BOOL
+	status = efi_parse_options(CONFIG_CMDLINE);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to parse options\n");
+		return status;
+	}
+#endif
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		status = efi_parse_options(*cmdline_ptr);
+		if (status != EFI_SUCCESS)
+			efi_err("Failed to parse options\n");
+	}
+	return status;
+}
+
+void efi_cache_sync_image(unsigned long image_base, unsigned long alloc_size)
+{
+	const u32 payload_size = *(u32 *)(_gzdata_end - 4);
+	const u32 image_size = *(u32 *)(image_base + 0x10);
+	const s32 *reloc = (s32 *)(image_base + payload_size);
+	u64 va_offset = __START_KERNEL - image_base;
+	u64 range, delta;
+	u32 seed;
+
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE) ||
+	    image_size == payload_size ||
+	    efi_get_random_bytes(sizeof(seed), (u8 *)&seed) != EFI_SUCCESS)
+		return;
+
+	range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - image_size;
+	delta = LOAD_PHYSICAL_ADDR + ((seed * range) >> 32UL);
+	delta &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+
+	/*
+	 * Process relocations: 32 bit relocations first then 64 bit after.
+	 * Three sets of binary relocations are added to the end of the kernel
+	 * before compression. Each relocation table entry is the kernel
+	 * address of the location which needs to be updated stored as a
+	 * 32-bit value which is sign extended to 64 bits.
+	 *
+	 * Format is:
+	 *
+	 * kernel bits...
+	 * 0 - zero terminator for 64 bit relocations
+	 * 64 bit relocation repeated
+	 * 0 - zero terminator for inverse 32 bit relocations
+	 * 32 bit inverse relocation repeated
+	 * 0 - zero terminator for 32 bit relocations
+	 * 32 bit relocation repeated
+	 *
+	 * So we work backwards from the end of the decompressed image.
+	 */
+	while (*--reloc)
+		*(u32 *)((s64)*reloc - va_offset) += delta;
+
+	while (*--reloc)
+		*(u32 *)((s64)*reloc - va_offset) -= delta;
+
+	while (*--reloc)
+		*(u64 *)((s64)*reloc - va_offset) += delta;
+
+	efi_free(alloc_size - image_size, image_base + image_size);
+}
+
+static void __naked tmpl_toggle(void *cr3, void *gdt)
+{
+	/*
+	 * This is template code that will be copied into a 32-bit addressable
+	 * buffer, allowing us to drop to 32-bit mode with paging disabled,
+	 * which is required to be able to toggle the CR4.LA57 bit.
+	 *
+	 * The first MOVB instruction is only there to capture the size of the
+	 * sequence, and implicitly, the offset to the LJMP's immediate, which
+	 * will be populated with the correct absolute address after copying.
+	 */
+	asm("0:	movb	$(3f - .), %%al		\n\t"
+	    "	lgdt	(%%rsi)			\n\t"
+	    "	movw	%[ds], %%ax		\n\t"
+	    "	movw	%%ax, %%ds		\n\t"
+	    "	movw	%%ax, %%ss		\n\t"
+	    "	leaq	2f(%%rip), %%rax	\n\t"
+	    "	pushq	%[cs32]			\n\t"
+	    "	pushq	%%rax			\n\t"
+	    "	lretq				\n\t"
+	    "1:	retq				\n\t"
+	    "	.code32				\n\t"
+	    "2:	movl	%%cr0, %%eax		\n\t"
+	    "	btrl	%[pg], %%eax		\n\t"
+	    "	movl	%%eax, %%cr0		\n\t"
+	    "	movl	%%cr4, %%ecx		\n\t"
+	    "	btcl	%[la57], %%ecx		\n\t"
+	    "	movl	%%ecx, %%cr4		\n\t"
+	    "	movl	%%edi, %%cr3		\n\t"
+	    "	btsl	%[pg], %%eax		\n\t"
+	    "	movl	%%eax, %%cr0		\n\t"
+	    "	ljmpl	%[cs], $(1b - 0b) 	\n\t"
+	    "3:	.code64"
+	    :
+	    : [cs32]	"i"(__KERNEL32_CS),
+	      [cs]	"i"(__KERNEL_CS),
+	      [ds]	"i"(__KERNEL_DS),
+	      [pg]	"i"(X86_CR0_PG_BIT),
+	      [la57]	"i"(X86_CR4_LA57_BIT));
+}
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as we cannot
+ * program a 64-bit value into CR3 when running in 32-bit mode.
+ */
+static efi_status_t efi_setup_5level_paging(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	const u8 tmpl_size = ((u8 *)tmpl_toggle)[1];
+	efi_status_t status;
+	u8 *la57_code;
+
+	/* check for 5 level paging support */
+	if (native_cpuid_eax(0) < 7 ||
+	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return EFI_SUCCESS;
+
+	/*
+	 * If LA57 is supported but disabled, and we have no interest in
+	 * enabling it, we can bail here. In all other cases, we need to
+	 * prepare the toggle support routine, even for the case where LA57 is
+	 * currently on and we want to keep it on, as the firmware might return
+	 * from ExitBootServices() with LA57 disabled.
+	 */
+	if (!want_la57 && !have_la57)
+		return EFI_SUCCESS;
+
+	/* allocate some 32-bit addressable memory for code and a page table */
+	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
+				    U32_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	la57_toggle = memcpy(la57_code, tmpl_toggle, tmpl_size);
+	memset(la57_code + tmpl_size, 0x0, 2 * PAGE_SIZE - tmpl_size);
+
+	/*
+	 * To avoid having to allocate a 32-bit addressable stack, we use a
+	 * ljmp to switch back to long mode. However, this takes an absolute
+	 * address, so we have to poke it in at runtime. The dummy MOVB
+	 * instruction at the beginning can be used to locate the immediate.
+	 */
+	*(u32 *)&la57_code[tmpl_size - 6] += (u64)la57_code;
+
+	return EFI_SUCCESS;
+}
+
+static void efi_5level_switch(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
+	u64 *cr3 = (u64 *)__native_read_cr3();
+	struct desc_ptr desc;
+	u64 *new_cr3;
+
+	if (!la57_toggle || (want_la57 && have_la57))
+		return;
+
+	if (!have_la57) {
+		/*
+		 * We are going to enable 5 level paging, so we need to
+		 * allocate a root level page from the 32-bit addressable
+		 * physical region, and plug the existing hierarchy into it.
+		 */
+		new_cr3 = pgt;
+		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
+	} else {
+		// take the new root table pointer from the current entry #0
+		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+
+		// copy the new root level table if it is not 32-bit addressable
+		if ((u64)new_cr3 > U32_MAX) {
+			for (int i = 0; i < PTRS_PER_PGD; i++)
+				pgt[i] = new_cr3[i];
+			new_cr3 = pgt;
+		}
+	}
+
+	desc.size	= sizeof(gdt) - 1;
+	desc.address 	= (u64)gdt;
+
+	la57_toggle(new_cr3, &desc);
+}
+
+efi_status_t efi_stub_common(efi_handle_t handle,
+			     efi_loaded_image_t *image,
+			     unsigned long image_addr,
+			     char *cmdline_ptr)
+{
+	void __noreturn (*startup_64)(void *, struct boot_params *);
+	const struct linux_efi_initrd *initrd = NULL;
+	struct boot_params *boot_params;
+	struct setup_header *hdr;
+	efi_status_t status;
+
+	status = efi_setup_5level_paging();
+	if (status != EFI_SUCCESS) {
+		efi_err("efi_setup_5level_paging() failed!\n");
+		return status;
+	}
+
+	boot_params = efi_alloc_boot_params();
+	if (!boot_params)
+		return EFI_OUT_OF_RESOURCES;
+
+	hdr = &boot_params->hdr;
+	hdr->type_of_loader = 0x21;
+
+	efi_set_u64_split((unsigned long)cmdline_ptr,
+			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
+
+	status = efi_load_initrd(image, hdr->initrd_addr_max, ULONG_MAX,
+				 &initrd);
+	if (status != EFI_SUCCESS)
+		goto fail;
+	if (initrd && initrd->size > 0) {
+		efi_set_u64_split(initrd->base, &hdr->ramdisk_image,
+				  &boot_params->ext_ramdisk_image);
+		efi_set_u64_split(initrd->size, &hdr->ramdisk_size,
+				  &boot_params->ext_ramdisk_size);
+	}
+
+	status = efi_x86_stub_common(boot_params, handle);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	efi_5level_switch();
+
+	startup_64 = (void *)image_addr;
+	startup_64(NULL, boot_params);
+fail:
+	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
+	return status;
+}
+
+struct screen_info *__alloc_screen_info(void)
+{
+	return NULL;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index e5d7fa1f1d8fd160..7cc78bb1253af675 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -65,6 +65,7 @@ asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
 	unsigned long compressed_size = _gzdata_end - _gzdata_start;
+	efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
 	unsigned long image_base, alloc_size;
 	efi_loaded_image_t *image;
 	efi_status_t status;
@@ -77,7 +78,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
 
 	status = efi_bs_call(handle_protocol, handle,
-			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&image);
+			     &loaded_image, (void **)&image);
 	if (status != EFI_SUCCESS) {
 		error("Failed to locate parent's loaded image protocol");
 		return status;
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 93d33f68333b2b68..13a4d3e6b3117910 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -14,8 +14,10 @@ SECTIONS
 
 	.rodata : ALIGN(8) {
 		__efistub__gzdata_start = .;
+		_gzdata_start = .;
 		*(.gzdata)
 		__efistub__gzdata_end = .;
+		_gzdata_end = .;
 		*(.rodata* .init.rodata* .srodata*)
 		_etext = ALIGN(4096);
 		. = _etext;
@@ -35,11 +37,14 @@ SECTIONS
 
 	/DISCARD/ : {
 		*(.modinfo .init.modinfo)
+		*(.discard*)
 	}
 }
 
 PROVIDE(__efistub__gzdata_size =
 		ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
 
+PROVIDE(_gzdata_size = __efistub__gzdata_size);
+
 PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
 PROVIDE(__data_size = ABSOLUTE(_end - _etext));
-- 
2.39.2

