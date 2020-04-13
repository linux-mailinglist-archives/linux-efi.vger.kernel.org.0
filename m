Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B421A6E42
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbgDMV3i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:29:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20797 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389054AbgDMV3e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586813373; x=1618349373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0f2ExrBOHSi6JWzrG2+CPU/JStpL/wqXhkbpv3XY90M=;
  b=Ij4v4WHeqvW2suKXPduWBGQYdiUXkCs7DsyuKwbeFumiG205O1KXdJG/
   mV2wu03+puf+ncCkGNDqg2GmCdiOEsDkZOvhlx7QgcuU5Tn25P+vhHIDw
   Me/q7XtfKudDCkCV7Vli7PNlU8He+XvwJav9ppWwLVGzLt2fnguQFCCAK
   skINP/plFtLAPUJ4LgYj/mx7ak3LDNvCbzmkzJoRbz44yoR86kkGpkf0U
   +yOpEuiVK3CZvBEP4XkXgQJ9155QdIOZfEleWubyJcK3NDF0IAjoAX6dG
   7zaXWCqtGDOBbAFcgIxUH531MML08V74sIaqcnIVxDdDnqZ3gVu/bmROY
   g==;
IronPort-SDR: M9BYkxXjCDPDohL7840FHeKMvqoJI3QNgwFWqmGOwBfvzSdBb6re9LYiJFnEn9l9dDWZHwAQGU
 PSacioVTFUm6bsfYy5T/Ogii7gif6pQ2JL5BAqTvURFtESoMaK63ijOdSUlfHCQCmU1mCyROkp
 qLTAPGZI1r3tuxMhqfSaWMcbWm1F3q3Xpa7xxKC7lDgtM55A3J1JQq2EHj8+g3s33GSKlpnifA
 ncD8fBhJgbs9BdaPhAvg6roCYa/KwRu2Te/VomVv7hCRJP2HElONoT3TTG9mn17Mi9Oxn00go9
 8dQ=
X-IronPort-AV: E=Sophos;i="5.72,380,1580745600"; 
   d="scan'208";a="139583363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 05:29:32 +0800
IronPort-SDR: GtrlBhDo066NlneVzMqDYIvmbOcDbWjvOAOOpwX+8VrUBnQkGd0r0xwowxLIwI/D2nC7EkjO9k
 b2ybDmF32iDyqegqwpX08UpJlPSiTlO8nA3zbtaGFakcCvHw+3WFpRr+x41DyaILFLOrUG7LbI
 ff7o1hTeVYP4wuzg0wyvRNk9/esVux2OSwk9RZtnrB0N0e0qAfpOVQJx7D6VaqIb0THH3k2p29
 KdH3WGkyF0kVLWk9XnZpjpqhuX15gvG4S72sZ7Vo/xkZ2T3XRKZGaq0TkZrlb5rGORqGgfIYqi
 bFVPt1AYhxpJrtmAdDGCVVB8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 14:20:36 -0700
IronPort-SDR: HUSqYi5vSgglAB48tTHXiwXFEgGzTWu3xQT+gNZyviZvsIWsIl1ManBsmjK4ODlmAAKSnUSQBX
 hPDdajhF35I1QInTkpa3Ac8Wq0rhLhW8seTLPNql7GQ146e8b2vx0z2Jui44bhns3BMTAuDjki
 Q/fp9GfGLieHsPCPGOTmdoTr3eVMtsrp3a8vYA2V9BPATnUKUKnn3r7/W6PjpzuSalyEopt+W4
 0ofmyQIRC5f/xIiPTuAaa5zHT5qFtFbLNH7gppKhYlhweK9b7tSopYGN6YikYTiu0/eGi9xkGp
 Noo=
WDCIronportException: Internal
Received: from 9dg4l72.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.26])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2020 14:29:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v2 PATCH 5/5] RISC-V: Add EFI stub support.
Date:   Mon, 13 Apr 2020 14:29:07 -0700
Message-Id: <20200413212907.29244-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200413212907.29244-1-atish.patra@wdc.com>
References: <20200413212907.29244-1-atish.patra@wdc.com>
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
---
 arch/riscv/Kconfig                        |  20 ++++
 arch/riscv/Makefile                       |   1 +
 arch/riscv/configs/defconfig              |   1 +
 arch/riscv/include/asm/efi.h              |  45 ++++++++
 drivers/firmware/efi/Kconfig              |   2 +-
 drivers/firmware/efi/libstub/Makefile     |   8 ++
 drivers/firmware/efi/libstub/riscv-stub.c | 131 ++++++++++++++++++++++
 7 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/efi.h
 create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f39e326a7a42..eb4f41c8f3ce 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -379,10 +379,30 @@ config CMDLINE_FORCE
 
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
+	default y
+	help
+	  This option provides support for runtime services provided
+	  by UEFI firmware (such as non-volatile variables, realtime
+          clock, and platform reset). A UEFI stub is also provided to
+	  allow the kernel to be booted as an EFI application. This
+	  is only useful on systems that have UEFI firmware.
+
 endmenu
 
 menu "Power management options"
 
 source "kernel/power/Kconfig"
+source "drivers/firmware/Kconfig"
 
 endmenu
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
index 000000000000..ba0a6d35cc15
--- /dev/null
+++ b/arch/riscv/include/asm/efi.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ * Based on arch/arm64/include/asm/efi.h
+ */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+#include <asm/io.h>
+#include <asm/mmu_context.h>
+#include <asm/ptrace.h>
+#include <asm/tlbflush.h>
+
+#define VA_BITS_MIN 39
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
+#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_is_native()		(true)
+
+#define efi_table_attr(inst, attr)	(inst->attr)
+
+#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
+#define alloc_screen_info(x...)		(&screen_info)
+extern char stext_offset[];
+
+static inline void free_screen_info(struct screen_info *si)
+{
+}
+#define EFI_ALLOC_ALIGN		SZ_64K
+
+#endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2a2b2b96a1dc..fcdc789d3f87 100644
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
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d590504541f6..b1db3a793c43 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,6 +22,8 @@ cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
+cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   -fpic
 
 cflags-$(CONFIG_EFI_GENERIC_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
@@ -56,6 +58,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)		+= efi-stub.o fdt.o string.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_RISCV)		+= riscv-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
@@ -80,6 +83,11 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
+STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
+				   --prefix-symbols=__efistub_
+STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
+
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
new file mode 100644
index 000000000000..acb69eae187a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013, 2014 Linaro Ltd;  <roy.franz@linaro.org>
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This file implements the EFI boot stub for the RISC-V kernel.
+ * Adapted from ARM64 version at drivers/firmware/efi/libstub/arm64-stub.c.
+ */
+
+#include <linux/efi.h>
+#include <linux/libfdt.h>
+#include <linux/libfdt_env.h>
+#include <asm/efi.h>
+#include <asm/sections.h>
+
+#include "efistub.h"
+/*
+ * RISCV requires the kernel image to placed TEXT_OFFSET bytes beyond a 2 MB
+ * aligned base for 64 bit and 4MB for 32 bit.
+ */
+#ifdef CONFIG_64BIT
+#define MIN_KIMG_ALIGN	SZ_2M
+#else
+#define MIN_KIMG_ALIGN	SZ_4M
+#endif
+/*
+ * TEXT_OFFSET ensures that we don't overwrite the firmware that probably sits
+ * at the beginning of the DRAM.
+ */
+#define TEXT_OFFSET MIN_KIMG_ALIGN
+
+typedef __attribute__((noreturn)) void (*jump_kernel_func)(unsigned int,
+							   unsigned long);
+efi_status_t check_platform_features(void)
+{
+	return EFI_SUCCESS;
+}
+
+static u32 get_boot_hartid_from_fdt(unsigned long fdt)
+{
+	int chosen_node, len;
+	const fdt32_t *prop;
+
+	chosen_node = fdt_path_offset((void *)fdt, "/chosen");
+	if (chosen_node < 0)
+		return U32_MAX;
+	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
+	if (!prop || len != sizeof(u32))
+		return U32_MAX;
+
+	return fdt32_to_cpu(*prop);
+}
+
+/*
+ * Jump to real kernel here with following constraints.
+ * 1. MMU should be disabled.
+ * 2. a0 should contain hartid
+ * 3. a1 should DT address
+ */
+void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
+				 unsigned long fdt_size)
+{
+	unsigned long kernel_entry = entrypoint + (unsigned long)stext_offset;
+	jump_kernel_func jump_kernel = (void (*)(unsigned int, unsigned long))kernel_entry;
+	u32 hartid = get_boot_hartid_from_fdt(fdt);
+
+	if (hartid == U32_MAX)
+		/* We can not use panic or BUG at this point */
+		__asm__ __volatile__ ("ebreak");
+	/* Disable MMU */
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
+	efi_status_t status;
+	unsigned long kernel_size, kernel_memsize = 0;
+	unsigned long preferred_offset;
+
+	/*
+	 * The preferred offset of the kernel Image is TEXT_OFFSET bytes beyond
+	 * a KIMG_ALIGN aligned base.
+	 */
+	preferred_offset = round_up(dram_base, MIN_KIMG_ALIGN) + TEXT_OFFSET;
+
+	kernel_size = _edata - _start;
+	kernel_memsize = kernel_size + (_end - _edata);
+
+	/*
+	 * Try a straight allocation at the preferred offset. It will also
+	 * ensure that, on platforms where the [dram_base, dram_base + TEXT_OFFSET)
+	 * interval is partially occupied by the firmware we can still place
+	 * the kernel at the address 'dram_base + TEXT_OFFSET'. If the straight
+	 * allocation fails, efi_low_alloc tries allocate memory from the lowest
+	 * available LOADER_DATA mapped memory as long as address and size meet
+	 * the alignment constraints.
+	 */
+	if (*image_addr == preferred_offset)
+		return EFI_SUCCESS;
+
+	*image_addr = *reserve_addr = preferred_offset;
+	*reserve_size = round_up(kernel_memsize, EFI_ALLOC_ALIGN);
+
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				EFI_LOADER_DATA,
+				*reserve_size / EFI_PAGE_SIZE,
+				(efi_physical_addr_t *)reserve_addr);
+
+	if (status != EFI_SUCCESS) {
+		pr_efi("straight allocation failed do a low alloc\n");
+		*reserve_size = kernel_memsize + TEXT_OFFSET;
+		status = efi_low_alloc(*reserve_size, MIN_KIMG_ALIGN,
+				       reserve_addr);
+
+		if (status != EFI_SUCCESS) {
+			pr_efi_err("Failed to relocate kernel\n");
+			*reserve_size = 0;
+			return status;
+		}
+		*image_addr = *reserve_addr + TEXT_OFFSET;
+	}
+	memcpy((void *)*image_addr, image->image_base, kernel_size);
+
+	return EFI_SUCCESS;
+}
-- 
2.24.0

