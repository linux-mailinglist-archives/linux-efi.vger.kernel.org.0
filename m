Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6323D20A964
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFYXpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFYXpa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128728; x=1624664728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2VklyNFbvV+zicAHh/HYpABAIKprIO2C92Fm4jaHGM=;
  b=rznemabLdv8YQkWX9YkpbAvWDQ3JYlJmgkZfiCKq0sGyr8o1MXGJ0xu3
   AUM7+DrFLXUSlVvegm5itG5t+dZ1zeELZXLYnf6v5CO5rb2mF8Eao6BEx
   oFeAOustYTj9psza/B528dVlel+b21Rv3d6eKFb7kh/gRXwxj3wEj+GRg
   gC5+765Sv5a1kED1bQDqJlmOGP4E1kFLondz+jY9NJVdWBBtwUQjmPtrC
   I0GvlIbQXYmW2E6CIFWzBJw+pA9n3pw2tKdxyET4QZl/CILl8OIpYV7l/
   ygGma/nQzehhIPo8fpKUOExXSA9f4QpxDnsWqhVmIE7TannBPe/PG/1sW
   Q==;
IronPort-SDR: szB0LHs2Ud50nfDtcZoMn6toIQ/0oOm5c/8Zkp1x+cOPdUNkFGsziywDqS7F9CmOqTt+Y94lc5
 cMmOo3eBLxavnVG9yegB2vyWLd29K0y+24wGx9DeN1/IIBVpsQbxRfazF1rdaPzQXL4ne4dwkH
 Rkxo2yFhXC7aBqMS9/LTGH9OK+pmZFVDfFLql3OUbWRbIdR+F4tQLdL9Te3bJB0/B8WUjrUW7w
 b2Etq+qwHcRPxellMdlEQF2hCFTRY2mg3Vg1G3WbeArTEibG00oSYc6kijZT78v1pjpYiiaFjm
 WcY=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953468"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:27 +0800
IronPort-SDR: nOfbKaGvxBWrHbDriYrzxVwQnJb3yXr/MPIHsUY70Xv98WRgH1rFnTjEZLZoApcdoji6GrhcQ0
 repjrkE39DO3VgQ7UFY7fgl6qaB0D+K0U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:28 -0700
IronPort-SDR: TIagHyxmc1zCY373Yj+weBPwSvTpU7AnW5dwmOVteo4kSzdFCtmy06FaDSbVuONRtuatEO55xP
 QLtoppEbyDDQ==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:27 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 09/11] RISC-V: Add EFI stub support.
Date:   Thu, 25 Jun 2020 16:45:14 -0700
Message-Id: <20200625234516.31406-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a RISC-V architecture specific stub code that actually copies the
actual kernel image to a valid address and jump to it after boot services
are terminated. Enable UEFI related kernel configs as well for RISC-V.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20200421033336.9663-4-atish.patra@wdc.com
[ardb: - move hartid fetch into check_platform_features()
       - use image_size not reserve_size
       - select ISA_C ]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/Kconfig                        |  22 +++++
 arch/riscv/Makefile                       |   1 +
 arch/riscv/configs/defconfig              |   1 +
 arch/riscv/include/asm/efi.h              |  36 +++++++
 drivers/firmware/efi/Kconfig              |   3 +-
 drivers/firmware/efi/libstub/Makefile     |  10 ++
 drivers/firmware/efi/libstub/riscv-stub.c | 110 ++++++++++++++++++++++
 7 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/efi.h
 create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fda90093e588..a902e98048a1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -388,6 +388,26 @@ config CMDLINE_FORCE
 
 endchoice
 
+config EFI_STUB
+	bool
+
+config EFI
+	bool "UEFI runtime support"
+	depends on OF
+	select LIBFDT
+	select UCS2_STRING
+	select EFI_PARAMS_FROM_FDT
+	select EFI_STUB
+	select EFI_GENERIC_STUB
+	select RISCV_ISA_C
+	default y
+	help
+	  This option provides support for runtime services provided
+	  by UEFI firmware (such as non-volatile variables, realtime
+	  clock, and platform reset). A UEFI stub is also provided to
+	  allow the kernel to be booted as an EFI application. This
+	  is only useful on systems that have UEFI firmware.
+
 endmenu
 
 config BUILTIN_DTB
@@ -400,3 +420,5 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 endmenu
+
+source "drivers/firmware/Kconfig"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index fb6e37db836d..079435804d6d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -80,6 +80,7 @@ head-y := arch/riscv/kernel/head.o
 core-y += arch/riscv/
 
 libs-y += arch/riscv/lib/
+core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886246a4..ae69e12d306a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -129,3 +129,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_EFI=y
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
new file mode 100644
index 000000000000..86da231909bb
--- /dev/null
+++ b/arch/riscv/include/asm/efi.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+#include <asm/io.h>
+#include <asm/mmu_context.h>
+#include <asm/ptrace.h>
+#include <asm/tlbflush.h>
+
+/* on RISC-V, the FDT may be located anywhere in system RAM */
+static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+{
+	return ULONG_MAX;
+}
+
+/* Load initrd at enough distance from DRAM start */
+static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
+						    unsigned long image_addr)
+{
+	return dram_base + SZ_256M;
+}
+
+#define alloc_screen_info(x...)		(&screen_info)
+
+static inline void free_screen_info(struct screen_info *si)
+{
+}
+
+static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
+{
+}
+
+#endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index e6fc022bc87e..22a8df95900e 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -111,7 +111,7 @@ config EFI_GENERIC_STUB
 
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
-	depends on EFI_GENERIC_STUB
+	depends on EFI_GENERIC_STUB && !RISCV
 	default y
 	help
 	  Select this config option to add support for the dtb= command
@@ -128,6 +128,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
 	default y
+	depends on !RISCV
 	help
 	  Select this config option to add support for the initrd= command
 	  line parameter, allowing an initrd that resides on the same volume
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..d1564ffcf82f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,6 +22,8 @@ cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
+cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   -fpic
 
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
@@ -63,6 +65,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_RISCV)		+= riscv-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
@@ -106,6 +109,13 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
+# For RISC-V, we don't need anything special other than arm64. Keep all the
+# symbols in .init section and make sure that no absolute symbols references
+# doesn't exist.
+STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
+				   --prefix-symbols=__efistub_
+STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
new file mode 100644
index 000000000000..77c3fd6f820e
--- /dev/null
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/efi.h>
+#include <linux/libfdt.h>
+
+#include <asm/efi.h>
+#include <asm/sections.h>
+
+#include "efistub.h"
+
+/*
+ * RISC-V requires the kernel image to placed 2 MB aligned base for 64 bit and
+ * 4MB for 32 bit.
+ */
+#ifdef CONFIG_64BIT
+#define MIN_KIMG_ALIGN		SZ_2M
+#else
+#define MIN_KIMG_ALIGN		SZ_4M
+#endif
+
+typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
+
+static u32 hartid;
+
+static u32 get_boot_hartid_from_fdt(void)
+{
+	const void *fdt;
+	int chosen_node, len;
+	const fdt32_t *prop;
+
+	fdt = get_efi_config_table(DEVICE_TREE_GUID);
+	if (!fdt)
+		return U32_MAX;
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node < 0)
+		return U32_MAX;
+
+	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
+	if (!prop || len != sizeof(u32))
+		return U32_MAX;
+
+	return fdt32_to_cpu(*prop);
+}
+
+efi_status_t check_platform_features(void)
+{
+	hartid = get_boot_hartid_from_fdt();
+	if (hartid == U32_MAX) {
+		efi_err("/chosen/boot-hartid missing or invalid!\n");
+		return EFI_UNSUPPORTED;
+	}
+	return EFI_SUCCESS;
+}
+
+void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
+				 unsigned long fdt_size)
+{
+	unsigned long stext_offset = _start_kernel - _start;
+	unsigned long kernel_entry = entrypoint + stext_offset;
+	jump_kernel_func jump_kernel = (jump_kernel_func)kernel_entry;
+
+	/*
+	 * Jump to real kernel here with following constraints.
+	 * 1. MMU should be disabled.
+	 * 2. a0 should contain hartid
+	 * 3. a1 should DT address
+	 */
+	csr_write(CSR_SATP, 0);
+	jump_kernel(hartid, fdt);
+}
+
+efi_status_t handle_kernel_image(unsigned long *image_addr,
+				 unsigned long *image_size,
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 unsigned long dram_base,
+				 efi_loaded_image_t *image)
+{
+	unsigned long kernel_size = 0;
+	unsigned long preferred_addr;
+	efi_status_t status;
+
+	kernel_size = _edata - _start;
+	*image_addr = (unsigned long)_start;
+	*image_size = kernel_size + (_end - _edata);
+
+	/*
+	 * RISC-V kernel maps PAGE_OFFSET virtual address to the same physical
+	 * address where kernel is booted. That's why kernel should boot from
+	 * as low as possible to avoid wastage of memory. Currently, dram_base
+	 * is occupied by the firmware. So the preferred address for kernel to
+	 * boot is next aligned address. If preferred address is not available,
+	 * relocate_kernel will fall back to efi_low_alloc_above to allocate
+	 * lowest possible memory region as long as the address and size meets
+	 * the alignment constraints.
+	 */
+	preferred_addr = round_up(dram_base, MIN_KIMG_ALIGN) + MIN_KIMG_ALIGN;
+	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
+				     preferred_addr, MIN_KIMG_ALIGN, dram_base);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to relocate kernel\n");
+		*image_size = 0;
+	}
+	return status;
+}
-- 
2.24.0

