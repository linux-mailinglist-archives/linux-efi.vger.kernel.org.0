Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6256F20A95D
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgFYXpl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgFYXpf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128733; x=1624664733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HpPgX2DM3YTTnUZPUHGvEF/Cy7COxqR8ZqBTAnCKExs=;
  b=ZNXM3PJiaWFRwuuZWtL+9bNMzjVitLEN8UpYUOoajXVI4ormst3YMwXV
   PHRKX2iSq6MrPzlnaa7oW0PJvGL/B8ip4nc79soWHzOPQ9bonoO5zx1eH
   e0QJv36snW4wiYxFJdwudJWx14tlr8NlA8IiGMsq9SbSqjP6XM0bqZifg
   Gd1/Rl0p1Vqb+cF7tAlBV8sOKAsk9gH6o9YA3v8cG24SZ4vXTZnlOGeU6
   whIplZiwmaIytvENmQtz+SHaXliplNa22nG9Q4Of6M52Ke2PLIaCW5gxh
   V88614lJlG6/7THqKMpG3M7MeOvFG+lCJKIozijI15OS3Moq6vNjN+hzT
   A==;
IronPort-SDR: vOWPF5NibzKMiCsY4iFohV2CZSKZSdkXk3NOXJtUL/H4sXCP+ha1DFXaKiI8tRUgb+1wS0BgUl
 4+CbDaEbtotGei3XWXAv5bWbb+YIfAtuxo33h6zhdYSIg+uYt1pqb+yLKLdJv3chE/CHTaJz5c
 f8UaDrYRQdp4pJzecW0Be4b+Jtip8A6VSfwFh8ASao/URVEuu0MGf1VJY3aORnTMbxK74+CzKd
 tOqgTRKioh46b2PewIGd/wkxzU7/Nh9p4MlygB9Ks/jWwnsMhL/qq0IukoT72y8Myf2ams/4yO
 nJ4=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953472"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:28 +0800
IronPort-SDR: mUmN2VkRJ5kNx6nyZc4/rpUzNiroS258fDJHGVA9Q6M0quM+hJQXgkuLI/nmiH12R2mDu1VvZT
 +/SNWnE4LQWXRwnOEz1g5IcGRpi9bb4uE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:29 -0700
IronPort-SDR: EMxaBTxMID8RWmWtIvauBjeCbtNUkoP69MPXDzGHPdXaRAa8zItOAJOiTRBGzgQ1MjMgfH0ZpI
 EyzrdVT87fqw==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 11/11] RISC-V: Add EFI runtime services
Date:   Thu, 25 Jun 2020 16:45:16 -0700
Message-Id: <20200625234516.31406-12-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds EFI runtime service support for RISC-V.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig                      |   2 +
 arch/riscv/include/asm/efi.h            |  20 ++++
 arch/riscv/include/asm/mmu.h            |   2 +
 arch/riscv/include/asm/pgalloc.h        |  12 ++
 arch/riscv/include/asm/pgtable.h        |   4 +
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/efi.c                 | 106 ++++++++++++++++++
 arch/riscv/kernel/setup.c               |   7 +-
 arch/riscv/mm/init.c                    |   2 +-
 drivers/firmware/efi/Makefile           |   4 +-
 drivers/firmware/efi/libstub/efi-stub.c |  11 +-
 drivers/firmware/efi/riscv-runtime.c    | 141 ++++++++++++++++++++++++
 12 files changed, 307 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/kernel/efi.c
 create mode 100644 drivers/firmware/efi/riscv-runtime.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a902e98048a1..601e8b873628 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -399,7 +399,9 @@ config EFI
 	select EFI_PARAMS_FROM_FDT
 	select EFI_STUB
 	select EFI_GENERIC_STUB
+	select EFI_RUNTIME_WRAPPERS
 	select RISCV_ISA_C
+	depends on MMU
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 86da231909bb..93c305a638f4 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -5,11 +5,28 @@
 #ifndef _ASM_EFI_H
 #define _ASM_EFI_H
 
+#include <asm/csr.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_EFI
+extern void efi_init(void);
+#else
+#define efi_init()
+#endif
+
+int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
+
+#define arch_efi_call_virt_setup()      efi_virtmap_load()
+#define arch_efi_call_virt_teardown()   efi_virtmap_unload()
+
+#define arch_efi_call_virt(p, f, args...) p->f(args)
+
+#define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
+
 /* on RISC-V, the FDT may be located anywhere in system RAM */
 static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 {
@@ -33,4 +50,7 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 {
 }
 
+void efi_virtmap_load(void);
+void efi_virtmap_unload(void);
+
 #endif /* _ASM_EFI_H */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 967eacb01ab5..dabcf2cfb3dc 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -20,6 +20,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
+void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
+			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 3f601ee8233f..ad567bf0fb84 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -40,6 +40,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 #define pmd_pgtable(pmd)	pmd_page(pmd)
 
+static inline pgd_t *pgd_alloc_nomap(struct mm_struct *mm)
+{
+	pgd_t *pgd;
+
+	pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	if (likely(pgd != NULL))
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+
+	return pgd;
+}
+
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index eaea1f717010..d53ef48768ae 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -100,6 +100,10 @@
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+#define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+#define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
+					 | _PAGE_EXEC)
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 6f7a3b3771fd..239c44c451b6 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -36,6 +36,7 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
+obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
new file mode 100644
index 000000000000..d6c0b733f3d1
--- /dev/null
+++ b/arch/riscv/kernel/efi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ * Adapted from arch/arm64/kernel/efi.c
+ */
+
+#include <linux/efi.h>
+#include <linux/init.h>
+
+#include <asm/efi.h>
+#include <asm/pgtable.h>
+#include <asm/pgtable-bits.h>
+
+/*
+ * Only regions of type EFI_RUNTIME_SERVICES_CODE need to be
+ * executable, everything else can be mapped with the XN bits
+ * set. Also take the new (optional) RO/XP bits into account.
+ */
+static __init pgprot_t efimem_to_pgprot_map(efi_memory_desc_t *md)
+{
+	u64 attr = md->attribute;
+	u32 type = md->type;
+
+	if (type == EFI_MEMORY_MAPPED_IO)
+		return PAGE_KERNEL;
+
+	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
+		      "UEFI Runtime regions are not aligned to page size -- buggy firmware?"))
+		/*
+		 * If the region is not aligned to the page size of the OS, we
+		 * can not use strict permissions, since that would also affect
+		 * the mapping attributes of the adjacent regions.
+		 */
+		return PAGE_EXEC;
+
+	/* R-- */
+	if ((attr & (EFI_MEMORY_XP | EFI_MEMORY_RO)) ==
+	    (EFI_MEMORY_XP | EFI_MEMORY_RO))
+		return PAGE_KERNEL_READ;
+
+	/* R-X */
+	if (attr & EFI_MEMORY_RO)
+		return PAGE_KERNEL_READ_EXEC;
+
+	/* RW- */
+	if (((attr & (EFI_MEMORY_RP | EFI_MEMORY_WP | EFI_MEMORY_XP)) ==
+	     EFI_MEMORY_XP) ||
+	    type != EFI_RUNTIME_SERVICES_CODE)
+		return PAGE_KERNEL;
+
+	/* RWX */
+	return PAGE_KERNEL_EXEC;
+}
+
+int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
+{
+	pgprot_t prot = __pgprot(pgprot_val(efimem_to_pgprot_map(md)) &
+				~(_PAGE_GLOBAL));
+	int i;
+
+	/* RISC-V maps one page at a time */
+	for (i = 0; i <= md->num_pages; i++)
+		create_pgd_mapping(mm->pgd, md->virt_addr + i * PAGE_SIZE,
+				   md->phys_addr + i * PAGE_SIZE,
+				   PAGE_SIZE, prot);
+	return 0;
+}
+
+static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
+{
+	efi_memory_desc_t *md = data;
+	pte_t pte = READ_ONCE(*ptep);
+	unsigned long val;
+
+	if (md->attribute & EFI_MEMORY_RO) {
+		val = pte_val(pte) & ~_PAGE_WRITE;
+		val = pte_val(pte) | _PAGE_READ;
+		pte = __pte(val);
+	}
+	if (md->attribute & EFI_MEMORY_XP) {
+		val = pte_val(pte) & ~_PAGE_EXEC;
+		pte = __pte(val);
+	}
+	set_pte(ptep, pte);
+
+	return 0;
+}
+
+int __init efi_set_mapping_permissions(struct mm_struct *mm,
+				       efi_memory_desc_t *md)
+{
+	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
+	       md->type != EFI_RUNTIME_SERVICES_DATA);
+
+	/*
+	 * Calling apply_to_page_range() is only safe on regions that are
+	 * guaranteed to be mapped down to pages. Since we are only called
+	 * for regions that have been mapped using efi_create_mapping() above
+	 * (and this is checked by the generic Memory Attributes table parsing
+	 * routines), there is no need to check that again here.
+	 */
+	return apply_to_page_range(mm, md->virt_addr,
+				   md->num_pages << EFI_PAGE_SHIFT,
+				   set_permissions, md);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 1244b433fe7c..0a725bd8d73e 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/efi.h>
 
 #include <asm/clint.h>
 #include <asm/cpu_ops.h>
@@ -26,11 +27,12 @@
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
+#include <asm/efi.h>
 
 #include "head.h"
 
-#ifdef CONFIG_DUMMY_CONSOLE
-struct screen_info screen_info = {
+#if defined(CONFIG_DUMMY_CONSOLE) || defined(CONFIG_EFI)
+struct screen_info screen_info __section(.data) = {
 	.orig_video_lines	= 30,
 	.orig_video_cols	= 80,
 	.orig_video_mode	= 0,
@@ -75,6 +77,7 @@ void __init setup_arch(char **cmdline_p)
 	early_ioremap_setup();
 	parse_early_param();
 
+	efi_init();
 	setup_bootmem();
 	paging_init();
 	unflatten_and_copy_device_tree();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c5268fe6e6de..eab96ed24065 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -319,7 +319,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define fixmap_pgd_next		fixmap_pte
 #endif
 
-static void __init create_pgd_mapping(pgd_t *pgdp,
+void __init create_pgd_mapping(pgd_t *pgdp,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
 {
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 7a216984552b..4d628081bb2f 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -32,9 +32,11 @@ obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
 
-arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
+arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
+riscv-obj-$(CONFIG_EFI)			:= efi-init.o riscv-runtime.o
+obj-$(CONFIG_RISCV)			+= $(riscv-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index e97370bdfdb0..3f7392da135d 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -17,7 +17,10 @@
 
 /*
  * This is the base address at which to start allocating virtual memory ranges
- * for UEFI Runtime Services. This is in the low TTBR0 range so that we can use
+ * for UEFI Runtime Services.
+ *
+ * For ARM/ARM64:
+ * This is in the low TTBR0 range so that we can use
  * any allocation we choose, and eliminate the risk of a conflict after kexec.
  * The value chosen is the largest non-zero power of 2 suitable for this purpose
  * both on 32-bit and 64-bit ARM CPUs, to maximize the likelihood that it can
@@ -25,6 +28,12 @@
  * Since 32-bit ARM could potentially execute with a 1G/3G user/kernel split,
  * map everything below 1 GB. (512 MB is a reasonable upper bound for the
  * entire footprint of the UEFI runtime services memory regions)
+ *
+ * For RISC-V:
+ * There is no specific reason for which, this address (512MB) can't be used
+ * EFI runtime virtual address for RISC-V. It also helps to use EFI runtime
+ * services on both RV32/RV64. Keep the same runtime virtual address for RISC-V
+ * as well to minimize the code churn.
  */
 #define EFI_RT_VIRTUAL_BASE	SZ_512M
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
new file mode 100644
index 000000000000..3bc48a268f66
--- /dev/null
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extensible Firmware Interface
+ *
+ * Based on Extensible Firmware Interface Specification version 2.4
+ *
+ * Copyright (C) 2013, 2014 Linaro Ltd.
+ */
+
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/mm_types.h>
+#include <linux/preempt.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/pgtable.h>
+
+#include <asm/cacheflush.h>
+#include <asm/efi.h>
+#include <asm/mmu.h>
+#include <asm/pgalloc.h>
+
+static bool __init efi_virtmap_init(void)
+{
+	efi_memory_desc_t *md;
+
+	efi_mm.pgd = pgd_alloc_nomap(&efi_mm);
+	mm_init_cpumask(&efi_mm);
+	init_new_context(NULL, &efi_mm);
+
+	for_each_efi_memory_desc(md) {
+		phys_addr_t phys = md->phys_addr;
+		int ret;
+
+		if (!(md->attribute & EFI_MEMORY_RUNTIME))
+			continue;
+		if (md->virt_addr == 0)
+			return false;
+
+		ret = efi_create_mapping(&efi_mm, md);
+		if (ret) {
+			pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
+				&phys, ret);
+			return false;
+		}
+	}
+
+	if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
+		return false;
+
+	return true;
+}
+
+/*
+ * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
+ * non-early mapping of the UEFI system table and virtual mappings for all
+ * EFI_MEMORY_RUNTIME regions.
+ */
+static int __init riscv_enable_runtime_services(void)
+{
+	u64 mapsize;
+
+	if (!efi_enabled(EFI_BOOT)) {
+		pr_info("EFI services will not be available.\n");
+		return 0;
+	}
+
+	efi_memmap_unmap();
+
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
+	if (efi_soft_reserve_enabled()) {
+		efi_memory_desc_t *md;
+
+		for_each_efi_memory_desc(md) {
+			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			struct resource *res;
+
+			if (!(md->attribute & EFI_MEMORY_SP))
+				continue;
+
+			res = kzalloc(sizeof(*res), GFP_KERNEL);
+			if (WARN_ON(!res))
+				break;
+
+			res->start	= md->phys_addr;
+			res->end	= md->phys_addr + md_size - 1;
+			res->name	= "Soft Reserved";
+			res->flags	= IORESOURCE_MEM;
+			res->desc	= IORES_DESC_SOFT_RESERVED;
+
+			insert_resource(&iomem_resource, res);
+		}
+	}
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return 0;
+	}
+
+	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("EFI runtime services access via paravirt.\n");
+		return 0;
+	}
+
+	pr_info("Remapping and enabling EFI services.\n");
+
+	if (!efi_virtmap_init()) {
+		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
+		return -ENOMEM;
+	}
+
+	/* Set up runtime services function pointers */
+	efi_native_runtime_setup();
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+
+	return 0;
+}
+early_initcall(riscv_enable_runtime_services);
+
+void efi_virtmap_load(void)
+{
+	preempt_disable();
+	switch_mm(&efi_mm, current->active_mm, NULL);
+}
+
+void efi_virtmap_unload(void)
+{
+	switch_mm(current->active_mm, &efi_mm, NULL);
+	preempt_enable();
+}
-- 
2.24.0

