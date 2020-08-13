Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ACF2436FE
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMI6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMI6R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 04:58:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C6C061383
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 01:58:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so4349235wmi.3
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ejOXH1LQTXrGTOxhVaMU2TYELrccVatdEWcGAK3Sjw=;
        b=P0vxc039Nc76V/6Rh0lKYHO+QHOD59pM77+iDKGJHEdV1gXadGYcNlamm6GJok7Lcx
         erNEgkh194Mu2P90joK7JlyIHPQxnUZW8mDcF2HS6T+L45gkx1fqoPO/GvKZ3D2yFBSc
         kBnDZh31uDw6IJCEf9aP89Ee6TwK0F7xVcrUWFWeHGmk7BibunPOcqRp7ddlTdcbsEPp
         uWeYrjGmuC3umaZYRvPVjAmViw67Fs8d1CUOuZnpGVyCZD8Po+bcK9HV7xqyAEATcXFy
         HOTJ7a+qFjtIE3/Ldo5+Z1Yox4Y5EFnDve9qnTUVQ54+7jO7PfJHuhI4cb0dQn/Y7Aic
         3qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ejOXH1LQTXrGTOxhVaMU2TYELrccVatdEWcGAK3Sjw=;
        b=E76ZXuKaepzGsnPck90Q1k5OGSXA3e+gr8mKRoZ3DRp0mkmN6EWr1pcwL2q6q2NBFN
         C39qmQ1B4cdS1TB+Ts0UFmDGcuHLXLR7xUxn2f93cXz9xZDxdmXEyH3ndw9V2fFTIbut
         f8SW5GIrZKeH5AsGyv6mbyrkrVP8jt++BnRYUIzAUJbGHvOK72ZDxd/gph/31VRhFNUU
         uyfEX4774BsZA3m+5cjKt1AyzlvCdd1KGMG1PPP/JVWc70pvPb/If0cYSt2GuCTGbImA
         XeaJuHK1Cz2XKLqBSyUP9/AG7Ffow4+dr1M1QdYN1Sit5wJtLa0Ps39jx/C0oVyhtJ2o
         hyuA==
X-Gm-Message-State: AOAM533zlgk6nCiEfA2USnEALiXTRkZoHgw9YTW9ywfFHffOPViCy+m/
        YlvmdZJbY+89m9UNrH2sNz3TATqXe5ELIiu+X38IUQ==
X-Google-Smtp-Source: ABdhPJydHDppTz/E+mk7vmLwdcwMEGXhikXzJOI8CfN3YTccGMRBhG08jWr2bhSuzMpdsnC0rgQs2DRZ3VOpfnSt+N0=
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr3596831wmk.185.1597309095228;
 Thu, 13 Aug 2020 01:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200812234758.3563-1-atish.patra@wdc.com> <20200812234758.3563-4-atish.patra@wdc.com>
In-Reply-To: <20200812234758.3563-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Aug 2020 14:28:03 +0530
Message-ID: <CAAhSdy3AuDi=JZN9beo5rhNnUD+bng+7t9qVTNNLZY8Yr2+Qhg@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] RISC-V: Implement late mapping page table
 allocation functions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        fwts-devel@lists.ubuntu.com, Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 13, 2020 at 5:19 AM Atish Patra <atish.patra@wdc.com> wrote:
>
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
> +       pte_t *(*get_pte_virt)(phys_addr_t pa);
> +       phys_addr_t (*alloc_pte)(uintptr_t va);
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pmd_t *(*get_pmd_virt)(phys_addr_t pa);
> +       phys_addr_t (*alloc_pmd)(uintptr_t va);
> +#endif
> +};
> +
> +struct pt_alloc_ops pt_ops;
> +
>  static void __init zone_sizes_init(void)
>  {
>         unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -211,7 +222,6 @@ EXPORT_SYMBOL(pfn_base);
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> -static bool mmu_enabled;
>
>  #define MAX_EARLY_MAPPING_SIZE SZ_128M
>
> @@ -234,27 +244,46 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>         }
>  }
>
> -static pte_t *__init get_pte_virt(phys_addr_t pa)
> +static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
>  {
> -       if (mmu_enabled) {
> -               clear_fixmap(FIX_PTE);
> -               return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> -       } else {
> -               return (pte_t *)((uintptr_t)pa);
> -       }
> +       return (pte_t *)((uintptr_t)pa);
>  }
>
> -static phys_addr_t __init alloc_pte(uintptr_t va)
> +static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
> +{
> +       clear_fixmap(FIX_PTE);
> +       return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> +}
> +
> +static inline pte_t *get_pte_virt_late(phys_addr_t pa)
> +{
> +       return (pte_t *) __va(pa);
> +}
> +
> +static inline phys_addr_t __init alloc_pte_early(uintptr_t va)
>  {
>         /*
>          * We only create PMD or PGD early mappings so we
>          * should never reach here with MMU disabled.
>          */
> -       BUG_ON(!mmu_enabled);
> +       BUG();
> +}
>
> +static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
> +{
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> +static phys_addr_t alloc_pte_late(uintptr_t va)
> +{
> +       unsigned long vaddr;
> +
> +       vaddr = __get_free_page(GFP_KERNEL);
> +       if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
> +               BUG();
> +       return __pa(vaddr);
> +}
> +
>  static void __init create_pte_mapping(pte_t *ptep,
>                                       uintptr_t va, phys_addr_t pa,
>                                       phys_addr_t sz, pgprot_t prot)
> @@ -279,28 +308,46 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  #endif
>  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
>
> -static pmd_t *__init get_pmd_virt(phys_addr_t pa)
> +static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
> -       if (mmu_enabled) {
> -               clear_fixmap(FIX_PMD);
> -               return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> -       } else {
> -               return (pmd_t *)((uintptr_t)pa);
> -       }
> +       /* Before MMU is enabled */
> +       return (pmd_t *)((uintptr_t)pa);
>  }
>
> -static phys_addr_t __init alloc_pmd(uintptr_t va)
> +static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
>  {
> -       uintptr_t pmd_num;
> +       clear_fixmap(FIX_PMD);
> +       return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> +}
> +
> +static pmd_t *get_pmd_virt_late(phys_addr_t pa)
> +{
> +       return (pmd_t *) __va(pa);
> +}
>
> -       if (mmu_enabled)
> -               return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +static phys_addr_t __init alloc_pmd_early(uintptr_t va)
> +{
> +       uintptr_t pmd_num;
>
>         pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
>         BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>         return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>  }
>
> +static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
> +{
> +       return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static phys_addr_t alloc_pmd_late(uintptr_t va)
> +{
> +       unsigned long vaddr;
> +
> +       vaddr = __get_free_page(GFP_KERNEL);
> +       BUG_ON(!vaddr);
> +       return __pa(vaddr);
> +}
> +
>  static void __init create_pmd_mapping(pmd_t *pmdp,
>                                       uintptr_t va, phys_addr_t pa,
>                                       phys_addr_t sz, pgprot_t prot)
> @@ -316,28 +363,28 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>         }
>
>         if (pmd_none(pmdp[pmd_idx])) {
> -               pte_phys = alloc_pte(va);
> +               pte_phys = pt_ops.alloc_pte(va);
>                 pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
> -               ptep = get_pte_virt(pte_phys);
> +               ptep = pt_ops.get_pte_virt(pte_phys);
>                 memset(ptep, 0, PAGE_SIZE);
>         } else {
>                 pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
> -               ptep = get_pte_virt(pte_phys);
> +               ptep = pt_ops.get_pte_virt(pte_phys);
>         }
>
>         create_pte_mapping(ptep, va, pa, sz, prot);
>  }
>
>  #define pgd_next_t             pmd_t
> -#define alloc_pgd_next(__va)   alloc_pmd(__va)
> -#define get_pgd_next_virt(__pa)        get_pmd_virt(__pa)
> +#define alloc_pgd_next(__va)   pt_ops.alloc_pmd(__va)
> +#define get_pgd_next_virt(__pa)        pt_ops.get_pmd_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)     \
>         create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
>  #define fixmap_pgd_next                fixmap_pmd
>  #else
>  #define pgd_next_t             pte_t
> -#define alloc_pgd_next(__va)   alloc_pte(__va)
> -#define get_pgd_next_virt(__pa)        get_pte_virt(__pa)
> +#define alloc_pgd_next(__va)   pt_ops.alloc_pte(__va)
> +#define get_pgd_next_virt(__pa)        pt_ops.get_pte_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)     \
>         create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
>  #define fixmap_pgd_next                fixmap_pte
> @@ -421,6 +468,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         BUG_ON((load_pa % map_size) != 0);
>         BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>
> +       pt_ops.alloc_pte = alloc_pte_early;
> +       pt_ops.get_pte_virt = get_pte_virt_early;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pt_ops.alloc_pmd = alloc_pmd_early;
> +       pt_ops.get_pmd_virt = get_pmd_virt_early;
> +#endif
>         /* Setup early PGD for fixmap */
>         create_pgd_mapping(early_pg_dir, FIXADDR_START,
>                            (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
> @@ -497,9 +550,16 @@ static void __init setup_vm_final(void)
>         phys_addr_t pa, start, end;
>         struct memblock_region *reg;
>
> -       /* Set mmu_enabled flag */
> -       mmu_enabled = true;
> -
> +       /**
> +        * MMU is enabled at this point. But page table setup is not complete yet.
> +        * fixmap page table alloc functions should be used at this point
> +        */
> +       pt_ops.alloc_pte = alloc_pte_fixmap;
> +       pt_ops.get_pte_virt = get_pte_virt_fixmap;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pt_ops.alloc_pmd = alloc_pmd_fixmap;
> +       pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
> +#endif
>         /* Setup swapper PGD for fixmap */
>         create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
>                            __pa_symbol(fixmap_pgd_next),
> @@ -533,6 +593,14 @@ static void __init setup_vm_final(void)
>         /* Move to swapper page table */
>         csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>         local_flush_tlb_all();
> +
> +       /* generic page allocation functions must be used to setup page table */
> +       pt_ops.alloc_pte = alloc_pte_late;
> +       pt_ops.get_pte_virt = get_pte_virt_late;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pt_ops.alloc_pmd = alloc_pmd_late;
> +       pt_ops.get_pmd_virt = get_pmd_virt_late;
> +#endif
>  }
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> --
> 2.24.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
