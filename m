Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62D239D22
	for <lists+linux-efi@lfdr.de>; Mon,  3 Aug 2020 02:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgHCA4I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Aug 2020 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHCA4I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Aug 2020 20:56:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC21C061756
        for <linux-efi@vger.kernel.org>; Sun,  2 Aug 2020 17:56:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so10074465wmc.0
        for <linux-efi@vger.kernel.org>; Sun, 02 Aug 2020 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA9bDintsX+Q8EZBsWXG8WyNthgYr4MQz6oX72nqeb4=;
        b=bUhTRe00vl7YOj8vqszaVuYsqcGVtq4DWER9dXy7rlC3kFF0pxTrJv0z7uKhlLx1n/
         2QNetlweCDeGLxidh+Da/Qus8uH1mT7dG0lFKz8upAfveGSn3heQjtetDloOW0O4m3uM
         oIU7PriaJA2KZpeYqThrrU/9Ijd0NI2SCmKy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA9bDintsX+Q8EZBsWXG8WyNthgYr4MQz6oX72nqeb4=;
        b=sBhDdDSqIn1ohEZwurjlqxK8eYdtdBZa2dJkaNRiCHNSKbZWmGM6757ya/eQxzFK6y
         gBevkeDY4ibUJM3DG3/ItuxLwNuhouVEZE+Jw/JUtlUVvpOzgBSpA34RDsUFndj6W9xz
         i4YGHq4daErJ8gGszCEhy5zbNtWsBQ4SbG3bgi4hIUtJAYffibBHKKqeXJ+RaqTsRuLQ
         BEj1ac0bp6hgSV5LBZKCnyq0X0DQTpYSVi1N3GH4rNl9Ih5CF1LenI/r0Z93FcAdkZSf
         K0YwpWsDplSLASEvDWlHItT/E0uj/ZKAUXbdXGgt3DJMXI7PHxZDbEj+QXHyM1+oZPLU
         Y88g==
X-Gm-Message-State: AOAM531ObgMMTp2RoQCbs6Cnm16AF7J/NnIdqUq4NkBS6QNik5dlIanR
        5qh+gxE6fUsMd/aehQXDN+2RI8nt+izUtcSCfgYK
X-Google-Smtp-Source: ABdhPJyZ9W0Sd5f+gz87BrUQixHmSIdajqs0OlOU63PvYe+Ij4HULq8odDDUpG4V4tjANgSr5cQ98FxcLG7BYnqOw38=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr236689wmh.55.1596416166182;
 Sun, 02 Aug 2020 17:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200729233635.14406-1-atish.patra@wdc.com> <20200729233635.14406-4-atish.patra@wdc.com>
 <20200730091440.GA534153@kernel.org>
In-Reply-To: <20200730091440.GA534153@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 2 Aug 2020 17:55:55 -0700
Message-ID: <CAOnJCUKS=QvQG5dBae96RD1CdevrXV+Jsfna2rfMWpw4Z=nDcw@mail.gmail.com>
Subject: Re: [RFT PATCH v4 3/9] RISC-V: Implement late mapping page table
 allocation functions
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 30, 2020 at 2:14 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi,
>
> On Wed, Jul 29, 2020 at 04:36:29PM -0700, Atish Patra wrote:
> > Currently, page table setup is done during setup_va_final where fixmap can
> > be used to create the temporary mappings. The physical frame is allocated
> > from memblock_alloc_* functions. However, this won't work if page table
> > mapping needs to be created for a different mm context (i.e. efi mm) at
> > a later point of time.
>
> TBH, I'm not very happy to see pte/pmd allocations, but I don't see a
> way to reuse the existing routines in this case.
>
> As a general wild idea, maybe it's worth using something like
>
> struct pt_alloc_ops {
>         pte_t *(*get_pte_virt)(phys_addr_t pa);
>         phys_addr_t (*alloc_pte)(uintptr_t va);
>         ...
> };
>
> and add there implementations: nommu, MMU early and MMU late.
>

Yeah. That will be much cleaner. Thanks. I will change it to have
function pointers
instead of if else blocks.

> Some more comments below.
>
> > Use generic kernel page allocation function & macros for any mapping
> > after setup_vm_final.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 68c608a0e91f..cba03fec08c1 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -212,6 +212,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> >  static bool mmu_enabled;
> > +static bool late_mapping;
> >
> >  #define MAX_EARLY_MAPPING_SIZE       SZ_128M
> >
> > @@ -236,7 +237,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> >
> >  static pte_t *__init get_pte_virt(phys_addr_t pa)
> >  {
> > -     if (mmu_enabled) {
> > +     if (late_mapping)
> > +             return (pte_t *) __va(pa);
> > +     else if (mmu_enabled) {
> >               clear_fixmap(FIX_PTE);
> >               return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> >       } else {
> > @@ -246,13 +249,19 @@ static pte_t *__init get_pte_virt(phys_addr_t pa)
> >
> >  static phys_addr_t __init alloc_pte(uintptr_t va)
> >  {
> > +     unsigned long vaddr;
> >       /*
> >        * We only create PMD or PGD early mappings so we
> >        * should never reach here with MMU disabled.
> >        */
> >       BUG_ON(!mmu_enabled);
> > -
> > -     return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> > +     if (late_mapping) {
> > +             vaddr = __get_free_page(GFP_KERNEL);
> > +             if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
> > +                     BUG();
>
> Is BUG() here really necessary? If I understand correctly, this would be
> used to enable mappings for EFI runtime services, so we probably want to
> propagete the error to to caller and, if really necessary, BUG() there,
> don't we?
>

If __get_free_page is failing here, something is seriously wrong and
the system should panic.
But I agree with you that this should happen in the caller rather than
the callee.
We need to change the signature of each create_*_mapping function
in order to propagate the error to the caller. Do you see any issues with that ?
As it will affect page table allocation for all three cases, should we
consolidate all the BUG()
cases in caller only ?

> > +             return __pa(vaddr);
> > +     } else
> > +             return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> >  }
> >
> >  static void __init create_pte_mapping(pte_t *ptep,
> > @@ -281,7 +290,9 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> >
> >  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
> >  {
> > -     if (mmu_enabled) {
> > +     if (late_mapping)
> > +             return (pmd_t *) __va(pa);
> > +     else if (mmu_enabled) {
> >               clear_fixmap(FIX_PMD);
> >               return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> >       } else {
> > @@ -292,8 +303,13 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
> >  static phys_addr_t __init alloc_pmd(uintptr_t va)
> >  {
> >       uintptr_t pmd_num;
> > +     unsigned long vaddr;
> >
> > -     if (mmu_enabled)
> > +     if (late_mapping) {
> > +             vaddr = __get_free_page(GFP_KERNEL);
> > +             BUG_ON(!vaddr);
> > +             return __pa(vaddr);
>
> Does nommu also need to allocate a page for pmd?
>

Not sure if I understand the question correctly. Before MMU is enabled,
we are using statically allocated early_pmd.

> > +     } else if (mmu_enabled)
> >               return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> >
> >       pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> > @@ -533,6 +549,9 @@ static void __init setup_vm_final(void)
> >       /* Move to swapper page table */
> >       csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
> >       local_flush_tlb_all();
> > +
> > +     /* generic page allocation function must be used to setup page table */
> > +     late_mapping = true;
> >  }
> >  #else
> >  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > --
> > 2.24.0
> >
>
> --
> Sincerely yours,
> Mike.



-- 
Regards,
Atish
