Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCC26E917
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIQWro (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 18:47:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54146 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIQWrm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Sep 2020 18:47:42 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 18:47:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600382913; x=1631918913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SHxP3cRZQa8gFN8WQXBGWYwQyW8SLYLuGAVjQGH2SA=;
  b=oyqqyF4OG2sLOCOIg30/v7ll7ndw9R6WKiNWSZWSTD6xmnG8Ymd/G8Ev
   cSfh/VzyvR+jSB8E1vgFAShElluCN2Kkv2WnH3csXyLnCUP96D9heF5Fl
   5vr6aHgHLA3GW8z6Re0GuU4RB+gCrq0RrViIQpUAaxhJvGJBoeAC5Tgbk
   0Fz1k9YdsjLHfQQVbZsqi7GZVKcO4LnCnmu41dTesuprm/d1jNU3XM2Ck
   4xLwNcy/8qDBhCkmzXtwp0lZyF0svdt9SJcKNBA3SF3voyIAS+/n6+AS+
   OjqyOoOx9W0CbmQsPsa2XUivJSS7Z5mb9avjRrf95sZ3Zi6eXilMIwr7/
   g==;
IronPort-SDR: F0evJ075LmbihY2SvM33P8YTmlASkXY7XHOUb/TmkSvSngsTYr+KMptmlkCNTu/Ga+C2h/+Hci
 h8uD8U9HmLMfNxyg0/VOYWbyNmWe+1zwhxoD8zAU36pE1slk9WNVKGczKK/QJ0zC2DMQt9AcHr
 YD6vwrshOFUNZjq9srf8rBL6oizbiaCwXMn6yQhJp6t72/yQ8ol0lyeaSAQQd2PpJFcMTuSWEf
 BD4rAmeEbQYZP44wZqwg03pzCTJXP15mKPDCoRhUkDZ7Tdg+mYvTW3ILFkS1bXkxbQtnx6a2M2
 3D4=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; 
   d="scan'208";a="251021084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 06:37:57 +0800
IronPort-SDR: Ma3kJjKpyFzT0U+hPnscuudorbtqnXWOiD/E3vdKiszPGWeUpRSQHWJKAGEQeDBmUx6vn15J2P
 CqdLs+16Xfjw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 15:23:53 -0700
IronPort-SDR: XHSfKP5Xzat0/6fCWcdjbtWjNennorxEVEIAiMPBeH3C7coIU9CooIy69HUCQx/VZpDNRHj3pv
 5G2HXFVW0l5A==
WDCIronportException: Internal
Received: from use204338.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2020 15:37:39 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v8 3/7] RISC-V: Implement late mapping page table allocation functions
Date:   Thu, 17 Sep 2020 15:37:12 -0700
Message-Id: <20200917223716.2300238-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917223716.2300238-1-atish.patra@wdc.com>
References: <20200917223716.2300238-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, page table setup is done during setup_va_final where fixmap can
be used to create the temporary mappings. The physical frame is allocated
from memblock_alloc_* functions. However, this won't work if page table
mapping needs to be created for a different mm context (i.e. efi mm) at
a later point of time.

Use generic kernel page allocation function & macros for any mapping
after setup_vm_final.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/mm/init.c | 130 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b75ebe8e7a92..63acc8185bfa 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -32,6 +32,15 @@ extern char _start[];
 void *dtb_early_va __initdata;
 uintptr_t dtb_early_pa __initdata;
 
+struct pt_alloc_ops {
+	pte_t *(*get_pte_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pte)(uintptr_t va);
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pmd)(uintptr_t va);
+#endif
+};
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
@@ -203,6 +212,8 @@ void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
+static struct pt_alloc_ops pt_ops;
+
 unsigned long va_pa_offset;
 EXPORT_SYMBOL(va_pa_offset);
 unsigned long pfn_base;
@@ -211,7 +222,6 @@ EXPORT_SYMBOL(pfn_base);
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
-static bool mmu_enabled;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
 
@@ -234,27 +244,46 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	}
 }
 
-static pte_t *__init get_pte_virt(phys_addr_t pa)
+static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
 {
-	if (mmu_enabled) {
-		clear_fixmap(FIX_PTE);
-		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
-	} else {
-		return (pte_t *)((uintptr_t)pa);
-	}
+	return (pte_t *)((uintptr_t)pa);
 }
 
-static phys_addr_t __init alloc_pte(uintptr_t va)
+static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PTE);
+	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
+}
+
+static inline pte_t *get_pte_virt_late(phys_addr_t pa)
+{
+	return (pte_t *) __va(pa);
+}
+
+static inline phys_addr_t __init alloc_pte_early(uintptr_t va)
 {
 	/*
 	 * We only create PMD or PGD early mappings so we
 	 * should never reach here with MMU disabled.
 	 */
-	BUG_ON(!mmu_enabled);
+	BUG();
+}
 
+static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
+{
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
+static phys_addr_t alloc_pte_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
+		BUG();
+	return __pa(vaddr);
+}
+
 static void __init create_pte_mapping(pte_t *ptep,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
@@ -279,28 +308,46 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
 
-static pmd_t *__init get_pmd_virt(phys_addr_t pa)
+static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
 {
-	if (mmu_enabled) {
-		clear_fixmap(FIX_PMD);
-		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
-	} else {
-		return (pmd_t *)((uintptr_t)pa);
-	}
+	/* Before MMU is enabled */
+	return (pmd_t *)((uintptr_t)pa);
 }
 
-static phys_addr_t __init alloc_pmd(uintptr_t va)
+static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 {
-	uintptr_t pmd_num;
+	clear_fixmap(FIX_PMD);
+	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
+}
+
+static pmd_t *get_pmd_virt_late(phys_addr_t pa)
+{
+	return (pmd_t *) __va(pa);
+}
 
-	if (mmu_enabled)
-		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+static phys_addr_t __init alloc_pmd_early(uintptr_t va)
+{
+	uintptr_t pmd_num;
 
 	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
 	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
 	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
 }
 
+static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
+{
+	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+static phys_addr_t alloc_pmd_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	BUG_ON(!vaddr);
+	return __pa(vaddr);
+}
+
 static void __init create_pmd_mapping(pmd_t *pmdp,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
@@ -316,28 +363,28 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 	}
 
 	if (pmd_none(pmdp[pmd_idx])) {
-		pte_phys = alloc_pte(va);
+		pte_phys = pt_ops.alloc_pte(va);
 		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
-		ptep = get_pte_virt(pte_phys);
+		ptep = pt_ops.get_pte_virt(pte_phys);
 		memset(ptep, 0, PAGE_SIZE);
 	} else {
 		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
-		ptep = get_pte_virt(pte_phys);
+		ptep = pt_ops.get_pte_virt(pte_phys);
 	}
 
 	create_pte_mapping(ptep, va, pa, sz, prot);
 }
 
 #define pgd_next_t		pmd_t
-#define alloc_pgd_next(__va)	alloc_pmd(__va)
-#define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
+#define alloc_pgd_next(__va)	pt_ops.alloc_pmd(__va)
+#define get_pgd_next_virt(__pa)	pt_ops.get_pmd_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		fixmap_pmd
 #else
 #define pgd_next_t		pte_t
-#define alloc_pgd_next(__va)	alloc_pte(__va)
-#define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
+#define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
+#define get_pgd_next_virt(__pa)	pt_ops.get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		fixmap_pte
@@ -421,6 +468,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((load_pa % map_size) != 0);
 	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
 
+	pt_ops.alloc_pte = alloc_pte_early;
+	pt_ops.get_pte_virt = get_pte_virt_early;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_early;
+	pt_ops.get_pmd_virt = get_pmd_virt_early;
+#endif
 	/* Setup early PGD for fixmap */
 	create_pgd_mapping(early_pg_dir, FIXADDR_START,
 			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
@@ -497,9 +550,16 @@ static void __init setup_vm_final(void)
 	phys_addr_t pa, start, end;
 	struct memblock_region *reg;
 
-	/* Set mmu_enabled flag */
-	mmu_enabled = true;
-
+	/**
+	 * MMU is enabled at this point. But page table setup is not complete yet.
+	 * fixmap page table alloc functions should be used at this point
+	 */
+	pt_ops.alloc_pte = alloc_pte_fixmap;
+	pt_ops.get_pte_virt = get_pte_virt_fixmap;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_fixmap;
+	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
+#endif
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
 			   __pa_symbol(fixmap_pgd_next),
@@ -533,6 +593,14 @@ static void __init setup_vm_final(void)
 	/* Move to swapper page table */
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
+
+	/* generic page allocation functions must be used to setup page table */
+	pt_ops.alloc_pte = alloc_pte_late;
+	pt_ops.get_pte_virt = get_pte_virt_late;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_late;
+	pt_ops.get_pmd_virt = get_pmd_virt_late;
+#endif
 }
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
-- 
2.25.1

