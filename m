Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C385BC021
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIRVg1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIRVg0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987E113FA8
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D83B81333
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1720BC433C1;
        Sun, 18 Sep 2022 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536982;
        bh=xWzCcuDcIbk2EunYOTQ7Gfzh2AHn/lco5BFilNl5klA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsUy66T9eCUfVe+Mf4TXMebKHd24+ecwi4qRagCAqOMj9jyNBBj5+3Pkw8slLGFBc
         5+x6QFouAKkSxLPIT++B8u/1sUIkoCCIw5y6jwdurwlOR+FUi+MF8fbHFQDO9K5iCa
         6s2t3nLNqY8YqZdIkHWHaETlicJ2XsHkAu/z0arlxs0r6mpeaMCe93AYYmmQdbkvDM
         JAU9mLwlgFRZ0YVseNBkKWeiGs6R/5BSmsO07eeXHA4NcmMTdLWHFeUWfdS2zh9JUF
         YscIhU2h40hQhukM5MYBzLOXH3ioK64Org10NKuJBP8tlDtDbjcHKpoGZDo3xhRRCK
         15kUoXhIbqrnw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 11/12] efi/loongarch: libstub: remove dependency on flattened DT
Date:   Sun, 18 Sep 2022 23:35:43 +0200
Message-Id: <20220918213544.2176249-12-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12172; i=ardb@kernel.org; h=from:subject; bh=xWzCcuDcIbk2EunYOTQ7Gfzh2AHn/lco5BFilNl5klA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48tGincx1LSqGgCdOY4VCJFW6PB8dzHcyzcBeKJ a7+4gXaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePLQAKCRDDTyI5ktmPJGPODA CA9NBQXALfzWxyxzXnnOlLNlLvIltm9oxAX3NWfOjfKM9M27B60rKjNyKZmNSfRr/ezKNQDIve5DUw /ZlwZ0mHLkOpXSe05MCMDHUXSaDoudlX4V85esr+VuCcfbxTanIeCnqqXKunQJIiKXy1Yb0G2V3FmJ 1QnSHsnFA0A5YAOa+4P5eKuf2mDo7QI4NKdXKRuS/FLobGYquVPMq1fZQGvOygvUZNGkAbVwF4XurL nPzV7UyvnZwvBtZEyE09X+La0P4lr469fF4E3QN25+9V2cFm+6sEQNk0cnhDktBpkwPptqKhemsQ2J cT+2PxaU1j0LaKGVRBYkOIabCKl+aqFE3jk/jIJ0a/E7IUefl1G8uoJ55KA3yTurPrlXbKom+OJh7X dgYukkCqWkKHHibn9s8zE+aU0ACwvte1wKOmEgDm2IYV1B/v6DF8ASTrRh334pJ/+QzpDV0iZUwpYm 5hPiydtjVlPnJg1r8Vi/aSxX5pa7dILXqcD7ToEdDCTI0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

LoongArch does not use FDT or DT natively [yet], and the only reason it
currently uses it is so that it can reuse the existing EFI stub code.

Overloading the DT with data passed between the EFI stub and the core
kernel has been a source of problems: there is the overlap between
information provided by EFI which DT can also provide (initrd base/size,
command line, memory descriptions), requiring us to reason about which
is which and what to prioritize. It has also resulted in ABI leaks,
i.e., internal ABI being promoted to external ABI inadvertently because
the bootloader can set the EFI stub's DT properties as well (e.g.,
"kaslr-seed"). This has become especially problematic with boot
environments that want to pretend that EFI boot is being done (to access
ACPI and SMBIOS tables, for instance) but have no ability to execute the
EFI stub, and so the environment that the EFI stub creates is emulated
[poorly, in some cases].

Another downside of treating DT like this is that the DT binary that the
kernel receives is different from the one created by the firmware, which
is undesirable in the context of secure and measured boot.

Given that LoongArch support in Linux is brand new, we can avoid these
pitfalls, and treat the DT strictly as a hardware description, and use a
separate handover method between the EFI stub and the kernel. Now that
initrd loading and passing the EFI memory map have been refactored into
pure EFI routines that use EFI configuration tables, the only thing we
need to pass directly is the kernel command line (even if we could pass
this via a config table as well, it is used extremely early, so passing
it directly is preferred in this case.)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/Kconfig                        |  3 --
 arch/loongarch/include/asm/bootinfo.h         |  2 +-
 arch/loongarch/kernel/efi.c                   | 30 ++++++++++-
 arch/loongarch/kernel/env.c                   | 22 ++++----
 arch/loongarch/kernel/head.S                  |  2 +
 arch/loongarch/kernel/setup.c                 |  4 +-
 drivers/firmware/efi/libstub/Makefile         | 13 +++--
 drivers/firmware/efi/libstub/loongarch-stub.c | 56 +++++++++++++++++---
 8 files changed, 100 insertions(+), 32 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fca106a8b8af..14a2a1ec8561 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -104,8 +104,6 @@ config LOONGARCH
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
-	select OF
-	select OF_EARLY_FLATTREE
 	select PCI
 	select PCI_DOMAINS_GENERIC
 	select PCI_ECAM if ACPI
@@ -311,7 +309,6 @@ config DMI
 config EFI
 	bool "EFI runtime service support"
 	select UCS2_STRING
-	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
 	help
 	  This enables the kernel to use EFI runtime services that are
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index e02ac4af7f6e..8e5881bc5ad1 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -36,7 +36,7 @@ struct loongson_system_configuration {
 };
 
 extern u64 efi_system_table;
-extern unsigned long fw_arg0, fw_arg1;
+extern unsigned long fw_arg0, fw_arg1, fw_arg2;
 extern struct loongson_board_info b_info;
 extern struct loongson_system_configuration loongson_sysconf;
 
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 1f1f755fb425..3b80675726ec 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -27,8 +27,13 @@
 static unsigned long efi_nr_tables;
 static unsigned long efi_config_table;
 
+static unsigned long __initdata boot_memmap = EFI_INVALID_TABLE_ADDR;
+
 static efi_system_table_t *efi_systab;
-static efi_config_table_type_t arch_tables[] __initdata = {{},};
+static efi_config_table_type_t arch_tables[] __initdata = {
+	{LINUX_EFI_BOOT_MEMMAP_GUID,	&boot_memmap,	"MEMMAP" },
+	{},
+};
 
 void __init efi_runtime_init(void)
 {
@@ -61,6 +66,8 @@ void __init efi_init(void)
 		return;
 	}
 
+	efi_systab_report_header(&efi_systab->hdr, efi_systab->fw_vendor);
+
 	set_bit(EFI_64BIT, &efi.flags);
 	efi_nr_tables	 = efi_systab->nr_tables;
 	efi_config_table = (unsigned long)efi_systab->tables;
@@ -72,4 +79,25 @@ void __init efi_init(void)
 
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
 		memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+
+	if (boot_memmap != EFI_INVALID_TABLE_ADDR) {
+		struct efi_memory_map_data data;
+		struct efi_boot_memmap *tbl;
+
+		tbl = early_memremap_ro(boot_memmap, sizeof(*tbl));
+		if (tbl) {
+			data.phys_map		= boot_memmap + sizeof(*tbl);
+			data.size		= tbl->map_size;
+			data.desc_size		= tbl->desc_size;
+			data.desc_version	= tbl->desc_ver;
+
+			if (efi_memmap_init_early(&data) < 0)
+				panic("Unable to map EFI memory map.\n");
+
+			memblock_reserve(data.phys_map & PAGE_MASK,
+					 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
+
+			early_memunmap(tbl, sizeof(*tbl));
+		}
+	}
 }
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 82b478a5c665..05c38d28476e 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -8,7 +8,6 @@
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
-#include <linux/of_fdt.h>
 #include <asm/early_ioremap.h>
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
@@ -20,21 +19,18 @@ EXPORT_SYMBOL(loongson_sysconf);
 void __init init_environ(void)
 {
 	int efi_boot = fw_arg0;
-	struct efi_memory_map_data data;
-	void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
 
-	if (efi_boot)
-		set_bit(EFI_BOOT, &efi.flags);
-	else
-		clear_bit(EFI_BOOT, &efi.flags);
+	if (efi_boot) {
+		char *cmdline = early_memremap_ro(fw_arg2, COMMAND_LINE_SIZE);
 
-	early_init_dt_scan(fdt_ptr);
-	early_init_fdt_reserve_self();
-	efi_system_table = efi_get_fdt_params(&data);
+		strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
+		early_memunmap(cmdline, COMMAND_LINE_SIZE);
 
-	efi_memmap_init_early(&data);
-	memblock_reserve(data.phys_map & PAGE_MASK,
-			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
+		efi_system_table = fw_arg1;
+		set_bit(EFI_BOOT, &efi.flags);
+	} else {
+		clear_bit(EFI_BOOT, &efi.flags);
+	}
 }
 
 static int __init init_cpu_fullname(void)
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 01bac62a6442..8f89f39fd31b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -67,6 +67,8 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	st.d		a0, t0, 0		# firmware arguments
 	la		t0, fw_arg1
 	st.d		a1, t0, 0
+	la		t0, fw_arg2
+	st.d		a2, t0, 0
 
 	/* KSave3 used for percpu base, initialized as 0 */
 	csrwr		zero, PERCPU_BASE_KS
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index e8714b1d94c8..7fabf2306e80 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -51,7 +51,7 @@
 
 struct screen_info screen_info __section(".data");
 
-unsigned long fw_arg0, fw_arg1;
+unsigned long fw_arg0, fw_arg1, fw_arg2;
 DEFINE_PER_CPU(unsigned long, kernelsp);
 struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
 
@@ -187,7 +187,6 @@ early_param("mem", early_parse_mem);
 
 void __init platform_init(void)
 {
-	efi_init();
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
 	acpi_table_upgrade();
 #endif
@@ -347,6 +346,7 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 
 	init_environ();
+	efi_init();
 	memblock_init();
 	parse_early_param();
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0dbc6d93f2e6..d8d6657e6277 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -29,7 +29,7 @@ cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpie
 
-cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/include/linux/hidden.h \
@@ -60,14 +60,17 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   alignedmem.o relocate.o vsprintf.o \
 				   systable.o
 
-# include the stub's generic dependencies from lib/ when building for ARM/arm64
-efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
+# include the stub's libfdt dependencies from lib/ when needed
+libfdt-deps			:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c \
+				   fdt_empty_tree.c fdt_sw.c
+
+lib-$(CONFIG_EFI_PARAMS_FROM_FDT) += fdt.o \
+				     $(patsubst %.c,lib-%.o,$(libfdt-deps))
 
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o intrinsics.o \
-				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
+lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index b7ef8d2df59e..7c684d10f936 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -9,7 +9,8 @@
 #include <asm/addrspace.h>
 #include "efistub.h"
 
-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
+typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long systab,
+					  unsigned long cmdline);
 
 extern int kernel_asize;
 extern int kernel_fsize;
@@ -42,19 +43,60 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
+struct exit_boot_struct {
+	efi_memory_desc_t	*runtime_map;
+	int			runtime_entry_count;
+};
+
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
+{
+	struct exit_boot_struct *p = priv;
+
+	/*
+	 * Update the memory map with virtual addresses. The function will also
+	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
+	 * entries so that we can pass it straight to SetVirtualAddressMap()
+	 */
+	efi_get_virtmap(map->map, map->map_size, map->desc_size,
+			p->runtime_map, &p->runtime_entry_count);
+
+	return EFI_SUCCESS;
+}
+
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long image_addr, char *cmdline_ptr)
 {
 	kernel_entry_t real_kernel_entry;
+	struct exit_boot_struct priv;
+	unsigned long desc_size;
+	efi_status_t status;
+	u32 desc_ver;
+
+	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
+	if (status != EFI_SUCCESS) {
+		efi_err("Unable to retrieve UEFI memory map.\n");
+		return status;
+	}
+
+	efi_info("Exiting boot services\n");
+
+	efi_novamap = false;
+	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	/* Install the new virtual address map */
+	efi_rt_call(set_virtual_address_map,
+		    priv.runtime_entry_count * desc_size, desc_size,
+		    desc_ver, priv.runtime_map);
 
 	/* Config Direct Mapping */
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
 	real_kernel_entry = (kernel_entry_t)
-		((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
+		((unsigned long)&kernel_entry - image_addr + VMLINUX_LOAD_ADDRESS);
 
-	if (!efi_novamap)
-		real_kernel_entry(true, fdt);
-	else
-		real_kernel_entry(false, fdt);
+	real_kernel_entry(true, (unsigned long)efi_system_table,
+			  (unsigned long)cmdline_ptr);
 }
-- 
2.35.1

