Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA49C24472C
	for <lists+linux-efi@lfdr.de>; Fri, 14 Aug 2020 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgHNJjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Aug 2020 05:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgHNJjR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Aug 2020 05:39:17 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D50206B2;
        Fri, 14 Aug 2020 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597397956;
        bh=XJJuPV0uhvNCwwx+/a8ifOEnr2h0U9Va70hu9ZEaCSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9XhSRm33UvmsHM6ED7LgG/mG693QwfvVUf3msJZ8Rx3ugTNsvqwzRFM0cf+2AIem
         pdCwPRRMnjL3O4jY6erM1dIS7FEXJmzWn9bZpC2m+cwdaL7AZeCEBGa1LNn9E+SUBY
         l6DYGabUP+WMCILZLb13mFlxTd4QettQUCBtLbWE=
Date:   Fri, 14 Aug 2020 12:39:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, fwts-devel@lists.ubuntu.com,
        Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: Re: [PATCH v5 3/9] RISC-V: Implement late mapping page table
 allocation functions
Message-ID: <20200814093906.GG752365@kernel.org>
References: <20200812234758.3563-1-atish.patra@wdc.com>
 <20200812234758.3563-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812234758.3563-4-atish.patra@wdc.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 12, 2020 at 04:47:52PM -0700, Atish Patra wrote:
> Currently, page table setup is done during setup_va_final where fixmap can
> be used to create the temporary mappings. The physical frame is allocated
> from memblock_alloc_* functions. However, this won't work if page table
> mapping needs to be created for a different mm context (i.e. efi mm) at
> a later point of time.
> 
> Use generic kernel page allocation function & macros for any mapping
> after setup_vm_final.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

A nit below, otherwise


Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/riscv/mm/init.c | 130 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 99 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b75ebe8e7a92..d238cdc501ee 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -32,6 +32,17 @@ extern char _start[];
>  void *dtb_early_va __initdata;
>  uintptr_t dtb_early_pa __initdata;
>  
> +struct pt_alloc_ops {
> +	pte_t *(*get_pte_virt)(phys_addr_t pa);
> +	phys_addr_t (*alloc_pte)(uintptr_t va);
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
> +	phys_addr_t (*alloc_pmd)(uintptr_t va);
> +#endif
> +};
> +
> +struct pt_alloc_ops pt_ops;

static?

> +
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -211,7 +222,6 @@ EXPORT_SYMBOL(pfn_base);
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> -static bool mmu_enabled;
>  
>  #define MAX_EARLY_MAPPING_SIZE	SZ_128M
>  
> @@ -234,27 +244,46 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  	}
>  }
>  
> -static pte_t *__init get_pte_virt(phys_addr_t pa)
> +static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
>  {
> -	if (mmu_enabled) {
> -		clear_fixmap(FIX_PTE);
> -		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> -	} else {
> -		return (pte_t *)((uintptr_t)pa);
> -	}
> +	return (pte_t *)((uintptr_t)pa);
>  }
>  
> -static phys_addr_t __init alloc_pte(uintptr_t va)
> +static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
> +{
> +	clear_fixmap(FIX_PTE);
> +	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> +}
> +
> +static inline pte_t *get_pte_virt_late(phys_addr_t pa)
> +{
> +	return (pte_t *) __va(pa);
> +}
> +
> +static inline phys_addr_t __init alloc_pte_early(uintptr_t va)
>  {
>  	/*
>  	 * We only create PMD or PGD early mappings so we
>  	 * should never reach here with MMU disabled.
>  	 */
> -	BUG_ON(!mmu_enabled);
> +	BUG();
> +}
>  
> +static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
> +{
>  	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>  
> +static phys_addr_t alloc_pte_late(uintptr_t va)
> +{
> +	unsigned long vaddr;
> +
> +	vaddr = __get_free_page(GFP_KERNEL);
> +	if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
> +		BUG();
> +	return __pa(vaddr);
> +}
> +
>  static void __init create_pte_mapping(pte_t *ptep,
>  				      uintptr_t va, phys_addr_t pa,
>  				      phys_addr_t sz, pgprot_t prot)
> @@ -279,28 +308,46 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  #endif
>  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
>  
> -static pmd_t *__init get_pmd_virt(phys_addr_t pa)
> +static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
> -	if (mmu_enabled) {
> -		clear_fixmap(FIX_PMD);
> -		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> -	} else {
> -		return (pmd_t *)((uintptr_t)pa);
> -	}
> +	/* Before MMU is enabled */
> +	return (pmd_t *)((uintptr_t)pa);
>  }
>  
> -static phys_addr_t __init alloc_pmd(uintptr_t va)
> +static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
>  {
> -	uintptr_t pmd_num;
> +	clear_fixmap(FIX_PMD);
> +	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> +}
> +
> +static pmd_t *get_pmd_virt_late(phys_addr_t pa)
> +{
> +	return (pmd_t *) __va(pa);
> +}
>  
> -	if (mmu_enabled)
> -		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +static phys_addr_t __init alloc_pmd_early(uintptr_t va)
> +{
> +	uintptr_t pmd_num;
>  
>  	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
>  	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>  	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>  }
>  
> +static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
> +{
> +	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static phys_addr_t alloc_pmd_late(uintptr_t va)
> +{
> +	unsigned long vaddr;
> +
> +	vaddr = __get_free_page(GFP_KERNEL);
> +	BUG_ON(!vaddr);
> +	return __pa(vaddr);
> +}
> +
>  static void __init create_pmd_mapping(pmd_t *pmdp,
>  				      uintptr_t va, phys_addr_t pa,
>  				      phys_addr_t sz, pgprot_t prot)
> @@ -316,28 +363,28 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>  	}
>  
>  	if (pmd_none(pmdp[pmd_idx])) {
> -		pte_phys = alloc_pte(va);
> +		pte_phys = pt_ops.alloc_pte(va);
>  		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
> -		ptep = get_pte_virt(pte_phys);
> +		ptep = pt_ops.get_pte_virt(pte_phys);
>  		memset(ptep, 0, PAGE_SIZE);
>  	} else {
>  		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
> -		ptep = get_pte_virt(pte_phys);
> +		ptep = pt_ops.get_pte_virt(pte_phys);
>  	}
>  
>  	create_pte_mapping(ptep, va, pa, sz, prot);
>  }
>  
>  #define pgd_next_t		pmd_t
> -#define alloc_pgd_next(__va)	alloc_pmd(__va)
> -#define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
> +#define alloc_pgd_next(__va)	pt_ops.alloc_pmd(__va)
> +#define get_pgd_next_virt(__pa)	pt_ops.get_pmd_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
>  	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
>  #define fixmap_pgd_next		fixmap_pmd
>  #else
>  #define pgd_next_t		pte_t
> -#define alloc_pgd_next(__va)	alloc_pte(__va)
> -#define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
> +#define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
> +#define get_pgd_next_virt(__pa)	pt_ops.get_pte_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
>  	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
>  #define fixmap_pgd_next		fixmap_pte
> @@ -421,6 +468,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	BUG_ON((load_pa % map_size) != 0);
>  	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>  
> +	pt_ops.alloc_pte = alloc_pte_early;
> +	pt_ops.get_pte_virt = get_pte_virt_early;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pt_ops.alloc_pmd = alloc_pmd_early;
> +	pt_ops.get_pmd_virt = get_pmd_virt_early;
> +#endif
>  	/* Setup early PGD for fixmap */
>  	create_pgd_mapping(early_pg_dir, FIXADDR_START,
>  			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
> @@ -497,9 +550,16 @@ static void __init setup_vm_final(void)
>  	phys_addr_t pa, start, end;
>  	struct memblock_region *reg;
>  
> -	/* Set mmu_enabled flag */
> -	mmu_enabled = true;
> -
> +	/**
> +	 * MMU is enabled at this point. But page table setup is not complete yet.
> +	 * fixmap page table alloc functions should be used at this point
> +	 */
> +	pt_ops.alloc_pte = alloc_pte_fixmap;
> +	pt_ops.get_pte_virt = get_pte_virt_fixmap;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pt_ops.alloc_pmd = alloc_pmd_fixmap;
> +	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
> +#endif
>  	/* Setup swapper PGD for fixmap */
>  	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
>  			   __pa_symbol(fixmap_pgd_next),
> @@ -533,6 +593,14 @@ static void __init setup_vm_final(void)
>  	/* Move to swapper page table */
>  	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>  	local_flush_tlb_all();
> +
> +	/* generic page allocation functions must be used to setup page table */
> +	pt_ops.alloc_pte = alloc_pte_late;
> +	pt_ops.get_pte_virt = get_pte_virt_late;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pt_ops.alloc_pmd = alloc_pmd_late;
> +	pt_ops.get_pmd_virt = get_pmd_virt_late;
> +#endif
>  }
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
