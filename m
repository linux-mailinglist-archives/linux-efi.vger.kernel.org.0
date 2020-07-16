Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B2222F34
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 01:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGPXlP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jul 2020 19:41:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7103 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgGPXlO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jul 2020 19:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594942874; x=1626478874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFx2JqfvMOY/IHbTQKdtomONFLTPkyP2EXq8Af4C8fw=;
  b=os0MZM1i5sbIXfWw8YnqS82aTfLjorGp9WPpXEEAMAkwECa1SkMZEO7L
   YPBeNPWviER7iyPZFfb8A6gzFcYEBCTqjSsk7GyefZiBLPol6Qw+NliST
   7FaHLA0wFdICB3xw7yN+u2vS51qGjgwz1ghZL4aO5lY8kW3vNrDi1CtZy
   TPsOTyXYso+TE+XeV9eHUOywqu7oZ9G5caC/VFTFtFe0nOd1hBzsBpCSd
   DLMyFE/zwuNcmIOlwR/BuQfDNam+DLARWQM+Pa+c2NU+JMeSJTQ9QZR11
   wOjCtkb3NPCiKQekGmV5NepgMSyDdMnjcMenDXk5XeZqQKZBgSdeOiyRn
   w==;
IronPort-SDR: uJa9sErzHpnusTYP7Qy1LMc4uewV99IkIo/BkokKk5EyGNMdf0/stl3amICO3yaLKpf4r2QFce
 ToUe0tgdjmjYWnTzeNfHG3o5RQiyPwfKleVfh3RQx8pGqyWf+xDQnoVYsbMeegoTfLpv+IkWnQ
 UWxPygnsoMXWHT0fEqGhWT5jkPuz3IuEUMGI4kywPXafGoXxnjeyBx/facoLYr//46tcDifoSo
 O/oC/hG8N08TLiS5c2l5D9zrQ8/IfrcnZmOtYtEex5wD12Y160pqLITwZpPHsjMOn6E1kGyA9P
 fEE=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="251923191"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 07:41:13 +0800
IronPort-SDR: XQZOhEyN3PBb+uqYipxDxOWro5GkTw97N0IZyVbP3a2+q2YlcUChhgRjDQT9C6/fYENt11uhFp
 TdxZ9bbilDkxerDhyEDWlCfh+RYp2E9DA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 16:29:37 -0700
IronPort-SDR: 9nBNoZottheyGh3stUab55/HDMSVctHoPy95bm5zWCgKpo630x8GRqleRfPMslH6NbdktemjIZ
 amAWebLGPUSg==
WDCIronportException: Internal
Received: from phd004806.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.54])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 16:41:13 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
Date:   Thu, 16 Jul 2020 16:40:56 -0700
Message-Id: <20200716234104.29049-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200716234104.29049-1-atish.patra@wdc.com>
References: <20200716234104.29049-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
it maps only single PMD (2MB) space for fixmap which leaves only < 1MB space
left for other kernel features such as early ioremap which requires fixmap
as well. The fixmap size can be increased by another 2MB but it brings
additional complexity and changes the virtual memory layout as well.
If we require some additional feature requiring fixmap again, it has to be
moved again.

Technically, DT doesn't need a fixmap as the memory occupied by the DT is
only used during boot. Thus, init memory section can be used for the same
purpose as well. This simplifies fixmap implementation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/fixmap.h |  3 ---
 arch/riscv/kernel/head.S        |  1 -
 arch/riscv/kernel/head.h        |  2 --
 arch/riscv/kernel/setup.c       |  8 +++-----
 arch/riscv/mm/init.c            | 36 ++++++++++++++-------------------
 5 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 1ff075a8dfc7..11613f38228a 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -22,9 +22,6 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
-#define FIX_FDT_SIZE	SZ_1M
-	FIX_FDT_END,
-	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
 	FIX_PTE,
 	FIX_PMD,
 	FIX_TEXT_POKE1,
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index d0c5c316e9bb..eb123eda3663 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -250,7 +250,6 @@ clear_bss_done:
 #endif
 	/* Start the kernel */
 	call soc_early_init
-	call parse_dtb
 	tail start_kernel
 
 .Lsecondary_start:
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index 105fb0496b24..b48dda3d04f6 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -16,6 +16,4 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
 extern void *__cpu_up_stack_pointer[];
 extern void *__cpu_up_task_pointer[];
 
-void __init parse_dtb(void);
-
 #endif /* __ASM_HEAD_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f04373be54a6..8519a6d29857 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -49,8 +49,9 @@ atomic_t hart_lottery __section(.sdata);
 unsigned long boot_cpu_hartid;
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-void __init parse_dtb(void)
+static void __init parse_dtb(void)
 {
+	/* Early scan of device tree from init memory */
 	if (early_init_dt_scan(dtb_early_va))
 		return;
 
@@ -63,6 +64,7 @@ void __init parse_dtb(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	parse_dtb();
 	init_mm.start_code = (unsigned long) _stext;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
@@ -74,11 +76,7 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_bootmem();
 	paging_init();
-#if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
-#else
-	unflatten_device_tree();
-#endif
 	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 79e9d55bdf1a..5e9328fa635b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,7 +28,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-void *dtb_early_va;
 
 static void __init zone_sizes_init(void)
 {
@@ -141,8 +140,6 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-static phys_addr_t dtb_early_pa __initdata;
-
 void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
@@ -182,13 +179,9 @@ void __init setup_bootmem(void)
 	setup_initrd();
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	/*
-	 * Avoid using early_init_fdt_reserve_self() since __pa() does
-	 * not work for DTB pointers that are fixmap addresses
-	 */
-	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-
+	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
+
 	memblock_allow_resize();
 	memblock_dump_all();
 
@@ -208,6 +201,10 @@ EXPORT_SYMBOL(va_pa_offset);
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
+#define DTB_EARLY_SIZE		SZ_1M
+static char early_dtb[DTB_EARLY_SIZE] __initdata;
+void *dtb_early_va __initdata = early_dtb;
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
@@ -399,7 +396,8 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t va, end_va;
+	int dtb_size;
+	uintptr_t va, pa, end_va;
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
@@ -448,17 +446,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 				   load_pa + (va - PAGE_OFFSET),
 				   map_size, PAGE_KERNEL_EXEC);
 
-	/* Create fixed mapping for early FDT parsing */
-	end_va = __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
-	for (va = __fix_to_virt(FIX_FDT); va < end_va; va += PAGE_SIZE)
-		create_pte_mapping(fixmap_pte, va,
-				   dtb_pa + (va - __fix_to_virt(FIX_FDT)),
-				   PAGE_SIZE, PAGE_KERNEL);
-
-	/* Save pointer to DTB for early FDT parsing */
-	dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
-	/* Save physical address for memblock reservation */
-	dtb_early_pa = dtb_pa;
+	/* Copy FDT to init memory for early scan */
+	pa = load_pa + ((unsigned long)dtb_early_va - PAGE_OFFSET);
+	dtb_size = fdt_totalsize((void *)dtb_pa);
+	dtb_size = (dtb_size > DTB_EARLY_SIZE) ? DTB_EARLY_SIZE : dtb_size;
+	memcpy((void *)pa, (void *)dtb_pa, dtb_size);
 }
 
 static void __init setup_vm_final(void)
@@ -505,6 +497,8 @@ static void __init setup_vm_final(void)
 	local_flush_tlb_all();
 }
 #else
+void *dtb_early_va __initdata;
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.24.0

