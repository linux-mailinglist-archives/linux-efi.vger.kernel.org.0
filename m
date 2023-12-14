Return-Path: <linux-efi+bounces-216-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94A8126F7
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5960281865
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9E63DF;
	Thu, 14 Dec 2023 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ImycSiFz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438A107
	for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 21:35:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so7085517b3a.3
        for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 21:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702532102; x=1703136902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh20kotH6U9RvpT2z7NAawg/dMhTYSwJgB2POD6vzRk=;
        b=ImycSiFzRF3N5nQRQXIMYNdgvSXw8xT847fsikTdNnqGAPU9LXIYl4COL8lZK8K6GL
         6ie+cgxRklyv/ZaXHlKmxA47wt97k2Mzee2wWrfMRE7rFxP6l8InTMtsgz3zIbxgQsj8
         3s54IhFr7KkeXTFkcYw6ubY61GGyi+YuKahSwBAmf7bXiacaTua2NC1VO7ojeRILNIb5
         eIYvF6VJbN9znz1zjdCWROdj1GVRLiy4JkgxB9MXjv3YQCvydcDK73yZOgRLB3g/V/8S
         Ixhc3x91c700DkWWiNClZIjX8Mm+Ko9mBFJ5+H4/6CgNbF+mFUDMtj+fMnlCNwH+GgN5
         nKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702532102; x=1703136902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh20kotH6U9RvpT2z7NAawg/dMhTYSwJgB2POD6vzRk=;
        b=RIjdz3uZIz3ziSsiwZmyuJfUs+mqiqCRThxNfrG+xz3SG/x6zCNrXuhpiB1JgqUqII
         YtIvY44NVB7qg3uOxdjQmnX5RjLgkukvZO2JQC022alfuCXXXk+jRuPwtYa3itNvcECG
         yynAPEFKONuJadaZfD4Tc2XJIFaH1/4vmlu0yOXFO3iiLV1ZFtXaP2kdHiUWEehYmBL3
         SSRKn0tkM+EN+ElA+5GQvwC0jtn2LwixZd6lxotb8XuMYT8Jtz9MvQeKu5CN7/A0AAXg
         YBO9DHuoJbXA8k69imfX6Gcy0yCOreqzriUUFazl9rVSFG5l2MCg1d1/EV+RrjKgdT7z
         VRXA==
X-Gm-Message-State: AOJu0Yym3c/EdIwxcWxY9S6fFTUYvH+ZXZuKMsQPRsyWuMt0hw21OMlu
	7MGO+Twd5UnGsLiMPXuXcwI2Was5VoLQWDkqa8qGDw==
X-Google-Smtp-Source: AGHT+IEBY1L7yDp3Cd6IrCmKJN9YcgBbxGegTCQenBOjpVYqMS/Ic28DMqWA6cM6abhLSwSmL0XeMkuZuSEkAVy9Kvs=
X-Received: by 2002:a05:6a21:609:b0:190:16bb:4f6b with SMTP id
 ll9-20020a056a21060900b0019016bb4f6bmr9829149pzb.39.1702532101745; Wed, 13
 Dec 2023 21:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213203001.179237-1-alexghiti@rivosinc.com> <20231213203001.179237-5-alexghiti@rivosinc.com>
In-Reply-To: <20231213203001.179237-5-alexghiti@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 Dec 2023 11:04:50 +0530
Message-ID: <CAAhSdy0iPD4+2efHqV1Bt6hstFiHGRrB8aTgQw6L3niDE2A00g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: Use accessors to page table entries instead
 of direct dereference
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Russell King <linux@armlinux.org.uk>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:04=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> As very well explained in commit 20a004e7b017 ("arm64: mm: Use
> READ_ONCE/WRITE_ONCE when accessing page tables"), an architecture whose
> page table walker can modify the PTE in parallel must use
> READ_ONCE()/WRITE_ONCE() macro to avoid any compiler transformation.
>
> So apply that to riscv which is such architecture.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kfence.h     |  4 +--
>  arch/riscv/include/asm/pgtable-64.h | 16 ++-------
>  arch/riscv/include/asm/pgtable.h    | 29 ++++------------
>  arch/riscv/kernel/efi.c             |  2 +-
>  arch/riscv/kvm/mmu.c                | 22 ++++++-------
>  arch/riscv/mm/fault.c               | 16 ++++-----
>  arch/riscv/mm/hugetlbpage.c         | 12 +++----
>  arch/riscv/mm/kasan_init.c          | 45 +++++++++++++------------
>  arch/riscv/mm/pageattr.c            | 44 ++++++++++++-------------
>  arch/riscv/mm/pgtable.c             | 51 ++++++++++++++++++++++++++---
>  10 files changed, 128 insertions(+), 113 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfe=
nce.h
> index 0bbffd528096..7388edd88986 100644
> --- a/arch/riscv/include/asm/kfence.h
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -18,9 +18,9 @@ static inline bool kfence_protect_page(unsigned long ad=
dr, bool protect)
>         pte_t *pte =3D virt_to_kpte(addr);
>
>         if (protect)
> -               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +               set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESEN=
T));
>         else
> -               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> +               set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT=
));
>
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 5d8431a390dd..b42017d76924 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -340,13 +340,7 @@ static inline struct page *p4d_page(p4d_t p4d)
>  #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>
>  #define pud_offset pud_offset
> -static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> -{
> -       if (pgtable_l4_enabled)
> -               return p4d_pgtable(*p4d) + pud_index(address);
> -
> -       return (pud_t *)p4d;
> -}
> +pud_t *pud_offset(p4d_t *p4d, unsigned long address);
>
>  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -404,12 +398,6 @@ static inline struct page *pgd_page(pgd_t pgd)
>  #define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
>
>  #define p4d_offset p4d_offset
> -static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
> -{
> -       if (pgtable_l5_enabled)
> -               return pgd_pgtable(*pgd) + p4d_index(address);
> -
> -       return (p4d_t *)pgd;
> -}
> +p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>
>  #endif /* _ASM_RISCV_PGTABLE_64_H */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index c9f4b250b4ee..3773f454f0fa 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -544,19 +544,12 @@ static inline void pte_clear(struct mm_struct *mm,
>         __set_pte_at(ptep, __pte(0));
>  }
>
> -#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> -static inline int ptep_set_access_flags(struct vm_area_struct *vma,
> -                                       unsigned long address, pte_t *pte=
p,
> -                                       pte_t entry, int dirty)
> -{
> -       if (!pte_same(*ptep, entry))
> -               __set_pte_at(ptep, entry);
> -       /*
> -        * update_mmu_cache will unconditionally execute, handling both
> -        * the case that the PTE changed and the spurious fault case.
> -        */
> -       return true;
> -}
> +#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS      /* defined in mm/pgtable.=
c */
> +extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned lo=
ng address,
> +                                pte_t *ptep, pte_t entry, int dirty);
> +#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG  /* defined in mm/pgtable.=
c */
> +extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigne=
d long address,
> +                                    pte_t *ptep);
>
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> @@ -569,16 +562,6 @@ static inline pte_t ptep_get_and_clear(struct mm_str=
uct *mm,
>         return pte;
>  }
>
> -#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> -static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
> -                                           unsigned long address,
> -                                           pte_t *ptep)
> -{
> -       if (!pte_young(*ptep))
> -               return 0;
> -       return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep))=
;
> -}
> -
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long address, pte_t *ptep)
> diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
> index aa6209a74c83..b64bf1624a05 100644
> --- a/arch/riscv/kernel/efi.c
> +++ b/arch/riscv/kernel/efi.c
> @@ -60,7 +60,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi=
_memory_desc_t *md)
>  static int __init set_permissions(pte_t *ptep, unsigned long addr, void =
*data)
>  {
>         efi_memory_desc_t *md =3D data;
> -       pte_t pte =3D READ_ONCE(*ptep);
> +       pte_t pte =3D ptep_get(ptep);
>         unsigned long val;
>
>         if (md->attribute & EFI_MEMORY_RO) {
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 068c74593871..a9e2fd7245e1 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -103,7 +103,7 @@ static bool gstage_get_leaf_entry(struct kvm *kvm, gp=
a_t addr,
>         *ptep_level =3D current_level;
>         ptep =3D (pte_t *)kvm->arch.pgd;
>         ptep =3D &ptep[gstage_pte_index(addr, current_level)];
> -       while (ptep && pte_val(*ptep)) {
> +       while (ptep && pte_val(ptep_get(ptep))) {
>                 if (gstage_pte_leaf(ptep)) {
>                         *ptep_level =3D current_level;
>                         *ptepp =3D ptep;
> @@ -113,7 +113,7 @@ static bool gstage_get_leaf_entry(struct kvm *kvm, gp=
a_t addr,
>                 if (current_level) {
>                         current_level--;
>                         *ptep_level =3D current_level;
> -                       ptep =3D (pte_t *)gstage_pte_page_vaddr(*ptep);
> +                       ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(=
ptep));
>                         ptep =3D &ptep[gstage_pte_index(addr, current_lev=
el)];
>                 } else {
>                         ptep =3D NULL;
> @@ -149,25 +149,25 @@ static int gstage_set_pte(struct kvm *kvm, u32 leve=
l,
>                 if (gstage_pte_leaf(ptep))
>                         return -EEXIST;
>
> -               if (!pte_val(*ptep)) {
> +               if (!pte_val(ptep_get(ptep))) {
>                         if (!pcache)
>                                 return -ENOMEM;
>                         next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
>                         if (!next_ptep)
>                                 return -ENOMEM;
> -                       *ptep =3D pfn_pte(PFN_DOWN(__pa(next_ptep)),
> -                                       __pgprot(_PAGE_TABLE));
> +                       set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
> +                                             __pgprot(_PAGE_TABLE)));
>                 } else {
>                         if (gstage_pte_leaf(ptep))
>                                 return -EEXIST;
> -                       next_ptep =3D (pte_t *)gstage_pte_page_vaddr(*pte=
p);
> +                       next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep=
_get(ptep));
>                 }
>
>                 current_level--;
>                 ptep =3D &next_ptep[gstage_pte_index(addr, current_level)=
];
>         }
>
> -       *ptep =3D *new_pte;
> +       set_pte(ptep, *new_pte);
>         if (gstage_pte_leaf(ptep))
>                 gstage_remote_tlb_flush(kvm, current_level, addr);
>
> @@ -239,11 +239,11 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t ad=
dr,
>
>         BUG_ON(addr & (page_size - 1));
>
> -       if (!pte_val(*ptep))
> +       if (!pte_val(ptep_get(ptep)))
>                 return;
>
>         if (ptep_level && !gstage_pte_leaf(ptep)) {
> -               next_ptep =3D (pte_t *)gstage_pte_page_vaddr(*ptep);
> +               next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(pte=
p));
>                 next_ptep_level =3D ptep_level - 1;
>                 ret =3D gstage_level_to_page_size(next_ptep_level,
>                                                 &next_page_size);
> @@ -261,7 +261,7 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t addr=
,
>                 if (op =3D=3D GSTAGE_OP_CLEAR)
>                         set_pte(ptep, __pte(0));
>                 else if (op =3D=3D GSTAGE_OP_WP)
> -                       set_pte(ptep, __pte(pte_val(*ptep) & ~_PAGE_WRITE=
));
> +                       set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_P=
AGE_WRITE));
>                 gstage_remote_tlb_flush(kvm, ptep_level, addr);
>         }
>  }
> @@ -603,7 +603,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn=
_range *range)
>                                    &ptep, &ptep_level))
>                 return false;
>
> -       return pte_young(*ptep);
> +       return pte_young(ptep_get(ptep));
>  }
>
>  int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 90d4ba36d1d0..76f1df709a21 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -136,24 +136,24 @@ static inline void vmalloc_fault(struct pt_regs *re=
gs, int code, unsigned long a
>         pgd =3D (pgd_t *)pfn_to_virt(pfn) + index;
>         pgd_k =3D init_mm.pgd + index;
>
> -       if (!pgd_present(*pgd_k)) {
> +       if (!pgd_present(pgdp_get(pgd_k))) {
>                 no_context(regs, addr);
>                 return;
>         }
> -       set_pgd(pgd, *pgd_k);
> +       set_pgd(pgd, pgdp_get(pgd_k));
>
>         p4d_k =3D p4d_offset(pgd_k, addr);
> -       if (!p4d_present(*p4d_k)) {
> +       if (!p4d_present(p4dp_get(p4d_k))) {
>                 no_context(regs, addr);
>                 return;
>         }
>
>         pud_k =3D pud_offset(p4d_k, addr);
> -       if (!pud_present(*pud_k)) {
> +       if (!pud_present(pudp_get(pud_k))) {
>                 no_context(regs, addr);
>                 return;
>         }
> -       if (pud_leaf(*pud_k))
> +       if (pud_leaf(pudp_get(pud_k)))
>                 goto flush_tlb;
>
>         /*
> @@ -161,11 +161,11 @@ static inline void vmalloc_fault(struct pt_regs *re=
gs, int code, unsigned long a
>          * to copy individual PTEs
>          */
>         pmd_k =3D pmd_offset(pud_k, addr);
> -       if (!pmd_present(*pmd_k)) {
> +       if (!pmd_present(pmdp_get(pmd_k))) {
>                 no_context(regs, addr);
>                 return;
>         }
> -       if (pmd_leaf(*pmd_k))
> +       if (pmd_leaf(pmdp_get(pmd_k)))
>                 goto flush_tlb;
>
>         /*
> @@ -175,7 +175,7 @@ static inline void vmalloc_fault(struct pt_regs *regs=
, int code, unsigned long a
>          * silently loop forever.
>          */
>         pte_k =3D pte_offset_kernel(pmd_k, addr);
> -       if (!pte_present(*pte_k)) {
> +       if (!pte_present(ptep_get(pte_k))) {
>                 no_context(regs, addr);
>                 return;
>         }
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index b52f0210481f..431596c0e20e 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -54,7 +54,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>         }
>
>         if (sz =3D=3D PMD_SIZE) {
> -               if (want_pmd_share(vma, addr) && pud_none(*pud))
> +               if (want_pmd_share(vma, addr) && pud_none(pudp_get(pud)))
>                         pte =3D huge_pmd_share(mm, vma, addr, pud);
>                 else
>                         pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
> @@ -93,11 +93,11 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>         pmd_t *pmd;
>
>         pgd =3D pgd_offset(mm, addr);
> -       if (!pgd_present(*pgd))
> +       if (!pgd_present(pgdp_get(pgd)))
>                 return NULL;
>
>         p4d =3D p4d_offset(pgd, addr);
> -       if (!p4d_present(*p4d))
> +       if (!p4d_present(p4dp_get(p4d)))
>                 return NULL;
>
>         pud =3D pud_offset(p4d, addr);
> @@ -105,7 +105,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>                 /* must be pud huge, non-present or none */
>                 return (pte_t *)pud;
>
> -       if (!pud_present(*pud))
> +       if (!pud_present(pudp_get(pud)))
>                 return NULL;
>
>         pmd =3D pmd_offset(pud, addr);
> @@ -113,7 +113,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>                 /* must be pmd huge, non-present or none */
>                 return (pte_t *)pmd;
>
> -       if (!pmd_present(*pmd))
> +       if (!pmd_present(pmdp_get(pmd)))
>                 return NULL;
>
>         for_each_napot_order(order) {
> @@ -293,7 +293,7 @@ void huge_pte_clear(struct mm_struct *mm,
>                     pte_t *ptep,
>                     unsigned long sz)
>  {
> -       pte_t pte =3D READ_ONCE(*ptep);
> +       pte_t pte =3D ptep_get(ptep);
>         int i, pte_num;
>
>         if (!pte_napot(pte)) {
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 5e39dcf23fdb..e96251853037 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -31,7 +31,7 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsig=
ned long vaddr, unsigned
>         phys_addr_t phys_addr;
>         pte_t *ptep, *p;
>
> -       if (pmd_none(*pmd)) {
> +       if (pmd_none(pmdp_get(pmd))) {
>                 p =3D memblock_alloc(PTRS_PER_PTE * sizeof(pte_t), PAGE_S=
IZE);
>                 set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>         }
> @@ -39,7 +39,7 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsig=
ned long vaddr, unsigned
>         ptep =3D pte_offset_kernel(pmd, vaddr);
>
>         do {
> -               if (pte_none(*ptep)) {
> +               if (pte_none(ptep_get(ptep))) {
>                         phys_addr =3D memblock_phys_alloc(PAGE_SIZE, PAGE=
_SIZE);
>                         set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_K=
ERNEL));
>                         memset(__va(phys_addr), KASAN_SHADOW_INIT, PAGE_S=
IZE);
> @@ -53,7 +53,7 @@ static void __init kasan_populate_pmd(pud_t *pud, unsig=
ned long vaddr, unsigned
>         pmd_t *pmdp, *p;
>         unsigned long next;
>
> -       if (pud_none(*pud)) {
> +       if (pud_none(pudp_get(pud))) {
>                 p =3D memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_S=
IZE);
>                 set_pud(pud, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
>         }
> @@ -63,7 +63,8 @@ static void __init kasan_populate_pmd(pud_t *pud, unsig=
ned long vaddr, unsigned
>         do {
>                 next =3D pmd_addr_end(vaddr, end);
>
> -               if (pmd_none(*pmdp) && IS_ALIGNED(vaddr, PMD_SIZE) && (ne=
xt - vaddr) >=3D PMD_SIZE) {
> +               if (pmd_none(pmdp_get(pmdp)) && IS_ALIGNED(vaddr, PMD_SIZ=
E) &&
> +                   (next - vaddr) >=3D PMD_SIZE) {
>                         phys_addr =3D memblock_phys_alloc(PMD_SIZE, PMD_S=
IZE);
>                         if (phys_addr) {
>                                 set_pmd(pmdp, pfn_pmd(PFN_DOWN(phys_addr)=
, PAGE_KERNEL));
> @@ -83,7 +84,7 @@ static void __init kasan_populate_pud(p4d_t *p4d,
>         pud_t *pudp, *p;
>         unsigned long next;
>
> -       if (p4d_none(*p4d)) {
> +       if (p4d_none(p4dp_get(p4d))) {
>                 p =3D memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_S=
IZE);
>                 set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
>         }
> @@ -93,7 +94,8 @@ static void __init kasan_populate_pud(p4d_t *p4d,
>         do {
>                 next =3D pud_addr_end(vaddr, end);
>
> -               if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) && (ne=
xt - vaddr) >=3D PUD_SIZE) {
> +               if (pud_none(pudp_get(pudp)) && IS_ALIGNED(vaddr, PUD_SIZ=
E) &&
> +                   (next - vaddr) >=3D PUD_SIZE) {
>                         phys_addr =3D memblock_phys_alloc(PUD_SIZE, PUD_S=
IZE);
>                         if (phys_addr) {
>                                 set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr)=
, PAGE_KERNEL));
> @@ -113,7 +115,7 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
>         p4d_t *p4dp, *p;
>         unsigned long next;
>
> -       if (pgd_none(*pgd)) {
> +       if (pgd_none(pgdp_get(pgd))) {
>                 p =3D memblock_alloc(PTRS_PER_P4D * sizeof(p4d_t), PAGE_S=
IZE);
>                 set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>         }
> @@ -123,7 +125,8 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
>         do {
>                 next =3D p4d_addr_end(vaddr, end);
>
> -               if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) && (ne=
xt - vaddr) >=3D P4D_SIZE) {
> +               if (p4d_none(p4dp_get(p4dp)) && IS_ALIGNED(vaddr, P4D_SIZ=
E) &&
> +                   (next - vaddr) >=3D P4D_SIZE) {
>                         phys_addr =3D memblock_phys_alloc(P4D_SIZE, P4D_S=
IZE);
>                         if (phys_addr) {
>                                 set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr)=
, PAGE_KERNEL));
> @@ -145,7 +148,7 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
>         do {
>                 next =3D pgd_addr_end(vaddr, end);
>
> -               if (pgd_none(*pgdp) && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
> +               if (pgd_none(pgdp_get(pgdp)) && IS_ALIGNED(vaddr, PGDIR_S=
IZE) &&
>                     (next - vaddr) >=3D PGDIR_SIZE) {
>                         phys_addr =3D memblock_phys_alloc(PGDIR_SIZE, PGD=
IR_SIZE);
>                         if (phys_addr) {
> @@ -168,7 +171,7 @@ static void __init kasan_early_clear_pud(p4d_t *p4dp,
>         if (!pgtable_l4_enabled) {
>                 pudp =3D (pud_t *)p4dp;
>         } else {
> -               base_pud =3D pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4=
dp)));
> +               base_pud =3D pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(p4d=
p_get(p4dp))));
>                 pudp =3D base_pud + pud_index(vaddr);
>         }
>
> @@ -193,7 +196,7 @@ static void __init kasan_early_clear_p4d(pgd_t *pgdp,
>         if (!pgtable_l5_enabled) {
>                 p4dp =3D (p4d_t *)pgdp;
>         } else {
> -               base_p4d =3D pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pg=
dp)));
> +               base_p4d =3D pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(pgd=
p_get(pgdp))));
>                 p4dp =3D base_p4d + p4d_index(vaddr);
>         }
>
> @@ -239,14 +242,14 @@ static void __init kasan_early_populate_pud(p4d_t *=
p4dp,
>         if (!pgtable_l4_enabled) {
>                 pudp =3D (pud_t *)p4dp;
>         } else {
> -               base_pud =3D pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4=
dp)));
> +               base_pud =3D pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(p4d=
p_get(p4dp))));
>                 pudp =3D base_pud + pud_index(vaddr);
>         }
>
>         do {
>                 next =3D pud_addr_end(vaddr, end);
>
> -               if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) &&
> +               if (pud_none(pudp_get(pudp)) && IS_ALIGNED(vaddr, PUD_SIZ=
E) &&
>                     (next - vaddr) >=3D PUD_SIZE) {
>                         phys_addr =3D __pa((uintptr_t)kasan_early_shadow_=
pmd);
>                         set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_T=
ABLE));
> @@ -277,14 +280,14 @@ static void __init kasan_early_populate_p4d(pgd_t *=
pgdp,
>         if (!pgtable_l5_enabled) {
>                 p4dp =3D (p4d_t *)pgdp;
>         } else {
> -               base_p4d =3D pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pg=
dp)));
> +               base_p4d =3D pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(pgd=
p_get(pgdp))));
>                 p4dp =3D base_p4d + p4d_index(vaddr);
>         }
>
>         do {
>                 next =3D p4d_addr_end(vaddr, end);
>
> -               if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) &&
> +               if (p4d_none(p4dp_get(p4dp)) && IS_ALIGNED(vaddr, P4D_SIZ=
E) &&
>                     (next - vaddr) >=3D P4D_SIZE) {
>                         phys_addr =3D __pa((uintptr_t)kasan_early_shadow_=
pud);
>                         set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_T=
ABLE));
> @@ -305,7 +308,7 @@ static void __init kasan_early_populate_pgd(pgd_t *pg=
dp,
>         do {
>                 next =3D pgd_addr_end(vaddr, end);
>
> -               if (pgd_none(*pgdp) && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
> +               if (pgd_none(pgdp_get(pgdp)) && IS_ALIGNED(vaddr, PGDIR_S=
IZE) &&
>                     (next - vaddr) >=3D PGDIR_SIZE) {
>                         phys_addr =3D __pa((uintptr_t)kasan_early_shadow_=
p4d);
>                         set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_T=
ABLE));
> @@ -381,7 +384,7 @@ static void __init kasan_shallow_populate_pud(p4d_t *=
p4d,
>         do {
>                 next =3D pud_addr_end(vaddr, end);
>
> -               if (pud_none(*pud_k)) {
> +               if (pud_none(pudp_get(pud_k))) {
>                         p =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>                         set_pud(pud_k, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TA=
BLE));
>                         continue;
> @@ -401,7 +404,7 @@ static void __init kasan_shallow_populate_p4d(pgd_t *=
pgd,
>         do {
>                 next =3D p4d_addr_end(vaddr, end);
>
> -               if (p4d_none(*p4d_k)) {
> +               if (p4d_none(p4dp_get(p4d_k))) {
>                         p =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>                         set_p4d(p4d_k, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TA=
BLE));
>                         continue;
> @@ -420,7 +423,7 @@ static void __init kasan_shallow_populate_pgd(unsigne=
d long vaddr, unsigned long
>         do {
>                 next =3D pgd_addr_end(vaddr, end);
>
> -               if (pgd_none(*pgd_k)) {
> +               if (pgd_none(pgdp_get(pgd_k))) {
>                         p =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>                         set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TA=
BLE));
>                         continue;
> @@ -451,7 +454,7 @@ static void __init create_tmp_mapping(void)
>
>         /* Copy the last p4d since it is shared with the kernel mapping. =
*/
>         if (pgtable_l5_enabled) {
> -               ptr =3D (p4d_t *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADO=
W_END));
> +               ptr =3D (p4d_t *)pgd_page_vaddr(pgdp_get(pgd_offset_k(KAS=
AN_SHADOW_END)));
>                 memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
>                 set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
>                         pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
> @@ -462,7 +465,7 @@ static void __init create_tmp_mapping(void)
>
>         /* Copy the last pud since it is shared with the kernel mapping. =
*/
>         if (pgtable_l4_enabled) {
> -               ptr =3D (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KA=
SAN_SHADOW_END)));
> +               ptr =3D (pud_t *)p4d_page_vaddr(p4dp_get(base_p4d + p4d_i=
ndex(KASAN_SHADOW_END)));
>                 memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
>                 set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
>                         pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index fc5fc4f785c4..0b5e38e018c8 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -29,7 +29,7 @@ static unsigned long set_pageattr_masks(unsigned long v=
al, struct mm_walk *walk)
>  static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
>                               unsigned long next, struct mm_walk *walk)
>  {
> -       p4d_t val =3D READ_ONCE(*p4d);
> +       p4d_t val =3D p4dp_get(p4d);
>
>         if (p4d_leaf(val)) {
>                 val =3D __p4d(set_pageattr_masks(p4d_val(val), walk));
> @@ -42,7 +42,7 @@ static int pageattr_p4d_entry(p4d_t *p4d, unsigned long=
 addr,
>  static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>                               unsigned long next, struct mm_walk *walk)
>  {
> -       pud_t val =3D READ_ONCE(*pud);
> +       pud_t val =3D pudp_get(pud);
>
>         if (pud_leaf(val)) {
>                 val =3D __pud(set_pageattr_masks(pud_val(val), walk));
> @@ -55,7 +55,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long=
 addr,
>  static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>                               unsigned long next, struct mm_walk *walk)
>  {
> -       pmd_t val =3D READ_ONCE(*pmd);
> +       pmd_t val =3D pmdp_get(pmd);
>
>         if (pmd_leaf(val)) {
>                 val =3D __pmd(set_pageattr_masks(pmd_val(val), walk));
> @@ -68,7 +68,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long=
 addr,
>  static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
>                               unsigned long next, struct mm_walk *walk)
>  {
> -       pte_t val =3D READ_ONCE(*pte);
> +       pte_t val =3D ptep_get(pte);
>
>         val =3D __pte(set_pageattr_masks(pte_val(val), walk));
>         set_pte(pte, val);
> @@ -108,10 +108,10 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
>                     vaddr <=3D (vaddr & PMD_MASK) && end >=3D next)
>                         continue;
>
> -               if (pmd_leaf(*pmdp)) {
> +               if (pmd_leaf(pmdp_get(pmdp))) {
>                         struct page *pte_page;
> -                       unsigned long pfn =3D _pmd_pfn(*pmdp);
> -                       pgprot_t prot =3D __pgprot(pmd_val(*pmdp) & ~_PAG=
E_PFN_MASK);
> +                       unsigned long pfn =3D _pmd_pfn(pmdp_get(pmdp));
> +                       pgprot_t prot =3D __pgprot(pmd_val(pmdp_get(pmdp)=
) & ~_PAGE_PFN_MASK);
>                         pte_t *ptep_new;
>                         int i;
>
> @@ -148,10 +148,10 @@ static int __split_linear_mapping_pud(p4d_t *p4dp,
>                     vaddr <=3D (vaddr & PUD_MASK) && end >=3D next)
>                         continue;
>
> -               if (pud_leaf(*pudp)) {
> +               if (pud_leaf(pudp_get(pudp))) {
>                         struct page *pmd_page;
> -                       unsigned long pfn =3D _pud_pfn(*pudp);
> -                       pgprot_t prot =3D __pgprot(pud_val(*pudp) & ~_PAG=
E_PFN_MASK);
> +                       unsigned long pfn =3D _pud_pfn(pudp_get(pudp));
> +                       pgprot_t prot =3D __pgprot(pud_val(pudp_get(pudp)=
) & ~_PAGE_PFN_MASK);
>                         pmd_t *pmdp_new;
>                         int i;
>
> @@ -197,10 +197,10 @@ static int __split_linear_mapping_p4d(pgd_t *pgdp,
>                     vaddr <=3D (vaddr & P4D_MASK) && end >=3D next)
>                         continue;
>
> -               if (p4d_leaf(*p4dp)) {
> +               if (p4d_leaf(p4dp_get(p4dp))) {
>                         struct page *pud_page;
> -                       unsigned long pfn =3D _p4d_pfn(*p4dp);
> -                       pgprot_t prot =3D __pgprot(p4d_val(*p4dp) & ~_PAG=
E_PFN_MASK);
> +                       unsigned long pfn =3D _p4d_pfn(p4dp_get(p4dp));
> +                       pgprot_t prot =3D __pgprot(p4d_val(p4dp_get(p4dp)=
) & ~_PAGE_PFN_MASK);
>                         pud_t *pudp_new;
>                         int i;
>
> @@ -406,29 +406,29 @@ bool kernel_page_present(struct page *page)
>         pte_t *pte;
>
>         pgd =3D pgd_offset_k(addr);
> -       if (!pgd_present(*pgd))
> +       if (!pgd_present(pgdp_get(pgd)))
>                 return false;
> -       if (pgd_leaf(*pgd))
> +       if (pgd_leaf(pgdp_get(pgd)))
>                 return true;
>
>         p4d =3D p4d_offset(pgd, addr);
> -       if (!p4d_present(*p4d))
> +       if (!p4d_present(p4dp_get(p4d)))
>                 return false;
> -       if (p4d_leaf(*p4d))
> +       if (p4d_leaf(p4dp_get(p4d)))
>                 return true;
>
>         pud =3D pud_offset(p4d, addr);
> -       if (!pud_present(*pud))
> +       if (!pud_present(pudp_get(pud)))
>                 return false;
> -       if (pud_leaf(*pud))
> +       if (pud_leaf(pudp_get(pud)))
>                 return true;
>
>         pmd =3D pmd_offset(pud, addr);
> -       if (!pmd_present(*pmd))
> +       if (!pmd_present(pmdp_get(pmd)))
>                 return false;
> -       if (pmd_leaf(*pmd))
> +       if (pmd_leaf(pmdp_get(pmd)))
>                 return true;
>
>         pte =3D pte_offset_kernel(pmd, addr);
> -       return pte_present(*pte);
> +       return pte_present(ptep_get(pte));
>  }
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index fef4e7328e49..ef887efcb679 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -5,6 +5,47 @@
>  #include <linux/kernel.h>
>  #include <linux/pgtable.h>
>
> +int ptep_set_access_flags(struct vm_area_struct *vma,
> +                         unsigned long address, pte_t *ptep,
> +                         pte_t entry, int dirty)
> +{
> +       if (!pte_same(ptep_get(ptep), entry))
> +               __set_pte_at(ptep, entry);
> +       /*
> +        * update_mmu_cache will unconditionally execute, handling both
> +        * the case that the PTE changed and the spurious fault case.
> +        */
> +       return true;
> +}
> +
> +int ptep_test_and_clear_young(struct vm_area_struct *vma,
> +                             unsigned long address,
> +                             pte_t *ptep)
> +{
> +       if (!pte_young(ptep_get(ptep)))
> +               return 0;
> +       return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep))=
;
> +}
> +EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
> +
> +#ifdef CONFIG_64BIT
> +pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> +{
> +       if (pgtable_l4_enabled)
> +               return p4d_pgtable(p4dp_get(p4d)) + pud_index(address);
> +
> +       return (pud_t *)p4d;
> +}
> +
> +p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
> +{
> +       if (pgtable_l5_enabled)
> +               return pgd_pgtable(pgdp_get(pgd)) + p4d_index(address);
> +
> +       return (p4d_t *)pgd;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
>  {
> @@ -25,7 +66,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t=
 prot)
>
>  int pud_clear_huge(pud_t *pud)
>  {
> -       if (!pud_leaf(READ_ONCE(*pud)))
> +       if (!pud_leaf(pudp_get(pud)))
>                 return 0;
>         pud_clear(pud);
>         return 1;
> @@ -33,7 +74,7 @@ int pud_clear_huge(pud_t *pud)
>
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -       pmd_t *pmd =3D pud_pgtable(*pud);
> +       pmd_t *pmd =3D pud_pgtable(pudp_get(pud));
>         int i;
>
>         pud_clear(pud);
> @@ -63,7 +104,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_=
t prot)
>
>  int pmd_clear_huge(pmd_t *pmd)
>  {
> -       if (!pmd_leaf(READ_ONCE(*pmd)))
> +       if (!pmd_leaf(pmdp_get(pmd)))
>                 return 0;
>         pmd_clear(pmd);
>         return 1;
> @@ -71,7 +112,7 @@ int pmd_clear_huge(pmd_t *pmd)
>
>  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  {
> -       pte_t *pte =3D (pte_t *)pmd_page_vaddr(*pmd);
> +       pte_t *pte =3D (pte_t *)pmd_page_vaddr(pmdp_get(pmd));
>
>         pmd_clear(pmd);
>
> @@ -88,7 +129,7 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>         pmd_t pmd =3D pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
>
>         VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> -       VM_BUG_ON(pmd_trans_huge(*pmdp));
> +       VM_BUG_ON(pmd_trans_huge(pmdp_get(pmdp)));
>         /*
>          * When leaf PTE entries (regular pages) are collapsed into a lea=
f
>          * PMD entry (huge page), a valid non-leaf PTE is converted into =
a
> --
> 2.39.2
>

