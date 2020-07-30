Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5894A232F4D
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 11:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgG3JOv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jul 2020 05:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgG3JOu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:50 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C15820809;
        Thu, 30 Jul 2020 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596100489;
        bh=l4NjSWF1HZWx/Xih8Ycmt7FVp9NzizelD5w+ezXB0Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjhsmzIR4gyOzE6k4cUaxOv7b3yXeZhUjHCgaMSbpMORCrhxlHXPA6sn2Z9x6yXYg
         bZ8ePyTHxQnYyT4KrMKZErHOPOeTCznQMU31gArycY+pKUSlT/2NRLzUV8VOHzTDqJ
         dYnv4+pPpOJMQZo7w3oqdgMb6bpD6kXrK52WSEmg=
Date:   Thu, 30 Jul 2020 12:14:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [RFT PATCH v4 3/9] RISC-V: Implement late mapping page table
 allocation functions
Message-ID: <20200730091440.GA534153@kernel.org>
References: <20200729233635.14406-1-atish.patra@wdc.com>
 <20200729233635.14406-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729233635.14406-4-atish.patra@wdc.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, Jul 29, 2020 at 04:36:29PM -0700, Atish Patra wrote:
> Currently, page table setup is done during setup_va_final where fixmap can
> be used to create the temporary mappings. The physical frame is allocated
> from memblock_alloc_* functions. However, this won't work if page table
> mapping needs to be created for a different mm context (i.e. efi mm) at
> a later point of time.

TBH, I'm not very happy to see pte/pmd allocations, but I don't see a
way to reuse the existing routines in this case.

As a general wild idea, maybe it's worth using something like

struct pt_alloc_ops {
	pte_t *(*get_pte_virt)(phys_addr_t pa);
	phys_addr_t (*alloc_pte)(uintptr_t va);
	...
};

and add there implementations: nommu, MMU early and MMU late.

Some more comments below.
 
> Use generic kernel page allocation function & macros for any mapping
> after setup_vm_final.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 68c608a0e91f..cba03fec08c1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -212,6 +212,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>  static bool mmu_enabled;
> +static bool late_mapping;
>  
>  #define MAX_EARLY_MAPPING_SIZE	SZ_128M
>  
> @@ -236,7 +237,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  
>  static pte_t *__init get_pte_virt(phys_addr_t pa)
>  {
> -	if (mmu_enabled) {
> +	if (late_mapping)
> +		return (pte_t *) __va(pa);
> +	else if (mmu_enabled) {
>  		clear_fixmap(FIX_PTE);
>  		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
>  	} else {
> @@ -246,13 +249,19 @@ static pte_t *__init get_pte_virt(phys_addr_t pa)
>  
>  static phys_addr_t __init alloc_pte(uintptr_t va)
>  {
> +	unsigned long vaddr;
>  	/*
>  	 * We only create PMD or PGD early mappings so we
>  	 * should never reach here with MMU disabled.
>  	 */
>  	BUG_ON(!mmu_enabled);
> -
> -	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +	if (late_mapping) {
> +		vaddr = __get_free_page(GFP_KERNEL);
> +		if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
> +			BUG();

Is BUG() here really necessary? If I understand correctly, this would be
used to enable mappings for EFI runtime services, so we probably want to
propagete the error to to caller and, if really necessary, BUG() there,
don't we?

> +		return __pa(vaddr);
> +	} else
> +		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>  
>  static void __init create_pte_mapping(pte_t *ptep,
> @@ -281,7 +290,9 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
>  
>  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>  {
> -	if (mmu_enabled) {
> +	if (late_mapping)
> +		return (pmd_t *) __va(pa);
> +	else if (mmu_enabled) {
>  		clear_fixmap(FIX_PMD);
>  		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
>  	} else {
> @@ -292,8 +303,13 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>  static phys_addr_t __init alloc_pmd(uintptr_t va)
>  {
>  	uintptr_t pmd_num;
> +	unsigned long vaddr;
>  
> -	if (mmu_enabled)
> +	if (late_mapping) {
> +		vaddr = __get_free_page(GFP_KERNEL);
> +		BUG_ON(!vaddr);
> +		return __pa(vaddr);

Does nommu also need to allocate a page for pmd?

> +	} else if (mmu_enabled)
>  		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  
>  	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> @@ -533,6 +549,9 @@ static void __init setup_vm_final(void)
>  	/* Move to swapper page table */
>  	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>  	local_flush_tlb_all();
> +
> +	/* generic page allocation function must be used to setup page table */
> +	late_mapping = true;
>  }
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
