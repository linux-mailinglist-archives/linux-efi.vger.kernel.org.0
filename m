Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089823282C
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgG2Xgz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:36:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22294 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG2Xgy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065814; x=1627601814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26oXiLmEk//X+up29RI/EZbGFDEHEWmiWMJCIV9Ghqs=;
  b=N0FEpTXpw3b/sDCTXkKiMqH3kjuemGNCsyq9ops+jBRpiCTmuqmLEzJV
   UuH8GuXimWBq93Bt5leNDrUmrH4+GWM4Jf8zlPn+Z7g7s1lvuBBaeE+pz
   cfRTXiaZltsrIMdLHxZD92CvquRL6tFH2o+m7oT6BJDtVQJuwg+Akh2za
   MQiWKJQju8jWnwreP3Bjcyfk/7OZCTgOUnc28lUfhnISOqBIMhNmyUH4O
   FQ/e04mi7GIUgxT835iNZMZhLl1SdUAsj+wV2UsSTrCIphY4FJhgDwkrf
   UtVCfOVkFKyE9vD70Ldfq3JL+V0tCdumAQf4h22G70LKfdzq7nqMXKxhN
   Q==;
IronPort-SDR: dT3uTie+I0jrFFSB9FZv8fBqqzcv7eZlPTS4ltOSI0BC0g7sR4SkQsySRY+6O6TM5WfiRU6uF9
 +o8qrvtLqxQfjJN3d2JiOkcgqD+EwS0DaBcNL3DgsFks08mNQ6au/F5Y/IO3DbKkbALIsNbGsF
 4QoOHW1TW3hCfmrdx3pjhgAaeRN0C36QMPNO26x3iez1/bzZZ3bdkf81rKSjEjAsl4DAGftcx+
 4hjsgSSZ6Y57+m7bLOeePxX6nJdj6Xy4AGZbfvzs+QxiR5epGmQsDJLRt3ggfyVGhSOnAkrc+M
 cKU=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:53 +0800
IronPort-SDR: 9eTEuYeDyD+2NRF4sOveqLyuVllVpSKqadxReWCrOTIOi+hHZccqUPGIjBJewE1+oRQN1jWjSW
 lAhfi5Nu93FJxt5vUXPi0f3kwoHtjGihw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:25:00 -0700
IronPort-SDR: wGLdob+fziPPG6+IBCU1U2mEoOFmnY9rGsdTPoGHWFxZRMuLzlxIHDeR3rAo7j3h+0NIm9M90G
 GlY4I3Sx9kNQ==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:52 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 1/9] RISC-V: Move DT mapping outof fixmap
Date:   Wed, 29 Jul 2020 16:36:27 -0700
Message-Id: <20200729233635.14406-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
References: <20200729233635.14406-1-atish.patra@wdc.com>
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
only used during boot. That's why, We map device tree in early page table
using two consecutive PGD mappings at lower addresses (< PAGE_OFFSET).
This frees lot of space in fixmap and also makes maximum supported
device tree size supported as PGDIR_SIZE. Thus, init memory section can be used
for the same purpose as well. This simplifies fixmap implementation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/fixmap.h  |  3 ---
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/head.S         |  1 -
 arch/riscv/kernel/head.h         |  2 --
 arch/riscv/kernel/setup.c        |  9 +++++++--
 arch/riscv/mm/init.c             | 26 ++++++++++++--------------
 6 files changed, 20 insertions(+), 22 deletions(-)

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
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index eaea1f717010..815f8c959dd4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -464,6 +464,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
 #define kern_addr_valid(addr)   (1) /* FIXME */
 
 extern void *dtb_early_va;
+extern uintptr_t dtb_early_pa;
 void setup_bootmem(void);
 void paging_init(void);
 
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
index f04373be54a6..6a0ee2405813 100644
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
@@ -77,7 +79,10 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	unflatten_device_tree();
+	if (early_init_dt_verify(__va(dtb_early_pa)))
+		unflatten_device_tree();
+	else
+		pr_err("No DTB found in kernel mappings\n");
 #endif
 	clint_init_boot_cpu();
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 79e9d55bdf1a..9c5f3e35adc2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,7 +28,9 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-void *dtb_early_va;
+#define DTB_EARLY_BASE_VA      PGDIR_SIZE
+void *dtb_early_va __initdata;
+uintptr_t dtb_early_pa __initdata;
 
 static void __init zone_sizes_init(void)
 {
@@ -141,8 +143,6 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-static phys_addr_t dtb_early_pa __initdata;
-
 void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
@@ -399,7 +399,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t va, end_va;
+	uintptr_t va, pa, end_va;
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
@@ -448,16 +448,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
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
+	/* Create two consecutive PGD mappings for FDT early scan */
+	pa = dtb_pa & ~(PGDIR_SIZE - 1);
+	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
+			   pa, PGDIR_SIZE, PAGE_KERNEL);
+	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
+			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
+	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
 	dtb_early_pa = dtb_pa;
 }
 
@@ -516,6 +513,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #else
 	dtb_early_va = (void *)dtb_pa;
 #endif
+	dtb_early_pa = dtb_pa;
 }
 
 static inline void setup_vm_final(void)
-- 
2.24.0

