Return-Path: <linux-efi+bounces-1035-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DF8C4ED6
	for <lists+linux-efi@lfdr.de>; Tue, 14 May 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7141F222CE
	for <lists+linux-efi@lfdr.de>; Tue, 14 May 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824A85956;
	Tue, 14 May 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHGUl3gv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B1DDC0;
	Tue, 14 May 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679050; cv=none; b=NrTpg4BKlwYFeXC42tqaJLnXIB8YdgQTURhUtqc7O2wdmAuv/e5ODOY8TlQHMjnmfSJHy/xqhjByw+0lrNOcLCZjdbLuMGzBGgVg/EhYcpWyb+QYKSa/nyQIJDbQbI0a4Ilt0br7l+PWqS3iEWjbIYH1n6GKvm2hHRNFfe4W5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679050; c=relaxed/simple;
	bh=wxxfMb6xLPNc0GtCv2kZ8br7AECDWg9X2HA0DsXGjOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVGvb99XNgm37iB6WXPID+3uY3U/CzZg+pKxgJ2ZFpVaTKT5/K6N5ykKbyPw4pWKPR3stf0WCxg/kv34DOMf2/e3Xq48Ypp98He84GULpQmgXjgNLU64tFMu/NzNoq/auMfvYWr7Ng9PSsLkxORTuBZQL/slqGR0T+oOYl/QAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHGUl3gv; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7ebe09eb289so1976435241.2;
        Tue, 14 May 2024 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715679048; x=1716283848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdHFnHTcKzscSCgje4pLV0ENAixI1q19eindkQ9bbmI=;
        b=MHGUl3gvMvcG3gy0mgpGyRR6g0ljSbR8Te9cd28W0xHEjuca5Icfyy6BmMQiQPZr7g
         zCm9v7QcdpoOnwdjIIKAKinUa56Metzwd0ciAXDVglYYr+ZZUJvVvYKZutEyKb+AhAXL
         X5l8l0aifpgfw3t1X/WFMJQL1kHYfnIT4DR+Io5CcyJ1zRDqsRoguSbQSm8+tE5HX563
         EsuchCncrobQfvhSVtNg6MWxqXJ4pA273k3xqGlZIShbRvnoGP9fwRS6f23nA+aaAPpY
         SYQt0N8YFSeahN4oO7ReskUIUoWBBgAzH0Mtw768+53qb7numd0e0U8za43r+6dIYUov
         q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679048; x=1716283848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdHFnHTcKzscSCgje4pLV0ENAixI1q19eindkQ9bbmI=;
        b=wQ40FTiXPTnEnEw9BZFvZQHK3i9PVkvdJ2dcmvSXmjDQA/8A0J0kCWuK/2u9p6xKag
         2dm3agpQgrK+5G/+5xhu+5jWlM/S1KJbV4pl5XVYjY4V4sRfHcnpO+n8ZH8uVivND0CB
         b6YpoiLzuBDO995CNBZfhLfpinnSA871Ipx2Reacl5Fk3LufUrg30NlIqF8z2A+pVOSb
         iefBc4KQ4atSG6SwNXBV90lTvUMqP+MbbVP0Tys1Cq+6PkTUOauy+W2aKiGPw74rjGgq
         fAoA+ZH0ec42ssCZzPnBkctcjlP2yyG0DuU1QjEAB2m8pj6MnZOE4CJF3S3m+m6KR8sH
         inNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpoR/RpfcQFtvSgk39BohBTIev/UU218FOin7Cdl4QNwRxJ0LbZhsqQZBG2bN2pBSAvNyPe1gDRpLQ2lwYO3qHQbu2hU7GnSoA2wxD7HvyPTfdNpCY6sjtLYB5w7tGcmZ7tO+nP7RUzuBWVj3WKoXhFOuSRaOIuXldK95Z
X-Gm-Message-State: AOJu0YyN5LPXxtMTnMAbDF6o41u+dNhdM3wAIY7CnBslT6/oc0D0GmKm
	0Hpd0JFx7/rLaBJ2SBErWtVh4GuOJzadJ6vvVl7i4gHPxUXy8coYH1/AJr7JvULD4jqo+mzncpu
	liKkFFdjWqDMiTxxQ+OAn0Vw/Yf0=
X-Google-Smtp-Source: AGHT+IFsXlUYAyC/dVyPAc91tSYUW8lcOIZYX7vhSynTmD9ch/K7amSJeNqyvopCZMfgCDfYyurmNf0h2XrY9tF0I4Y=
X-Received: by 2002:a05:6102:2acc:b0:47e:f686:ccf with SMTP id
 ada2fe7eead31-48077e83663mr12661860137.23.1715679047234; Tue, 14 May 2024
 02:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
 <20240508191931.46060-2-alexghiti@rivosinc.com> <CAGsJ_4xayC4D4y0d7SPXxCvuW4-rJQUCa_-OUDSsOGm_HyPm1w@mail.gmail.com>
 <CAHVXubiOo3oe0=-qU2kBaFXebPJvmnc+-1UOPEHS2spcCeMzsw@mail.gmail.com>
In-Reply-To: <CAHVXubiOo3oe0=-qU2kBaFXebPJvmnc+-1UOPEHS2spcCeMzsw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 May 2024 21:30:36 +1200
Message-ID: <CAGsJ_4w_mOL5egHV9a3+0vcZV6ODvr=3KFXevedH19voSCHXwQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] mm, arm64: Rename ARM64_CONTPTE to THP_CONTPTE
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ard Biesheuvel <ardb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:09=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Barry,
>
> On Thu, May 9, 2024 at 2:46=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Thu, May 9, 2024 at 7:20=E2=80=AFAM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > The ARM64_CONTPTE config represents the capability to transparently u=
se
> > > contpte mappings for THP userspace mappings, which will be implemente=
d
> > > in the next commits for riscv, so make this config more generic and m=
ove
> > > it to mm.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/arm64/Kconfig               | 9 ---------
> > >  arch/arm64/include/asm/pgtable.h | 6 +++---
> > >  arch/arm64/mm/Makefile           | 2 +-
> > >  mm/Kconfig                       | 9 +++++++++
> > >  4 files changed, 13 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index ac2f6d906cc3..9d823015b4e5 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -2227,15 +2227,6 @@ config UNWIND_PATCH_PAC_INTO_SCS
> > >         select UNWIND_TABLES
> > >         select DYNAMIC_SCS
> > >
> > > -config ARM64_CONTPTE
> > > -       bool "Contiguous PTE mappings for user memory" if EXPERT
> > > -       depends on TRANSPARENT_HUGEPAGE
> > > -       default y
> > > -       help
> > > -         When enabled, user mappings are configured using the PTE co=
ntiguous
> > > -         bit, for any mappings that meet the size and alignment requ=
irements.
> > > -         This reduces TLB pressure and improves performance.
> > > -
> > >  endmenu # "Kernel Features"
> > >
> > >  menu "Boot options"
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/as=
m/pgtable.h
> > > index 7c2938cb70b9..1758ce71fae9 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -1369,7 +1369,7 @@ extern void ptep_modify_prot_commit(struct vm_a=
rea_struct *vma,
> > >                                     unsigned long addr, pte_t *ptep,
> > >                                     pte_t old_pte, pte_t new_pte);
> > >
> > > -#ifdef CONFIG_ARM64_CONTPTE
> > > +#ifdef CONFIG_THP_CONTPTE
> >
> > Is it necessarily THP? can't be hugetlb or others? I feel THP_CONTPTE
> > isn't a good name.
>
> This does not target hugetlbfs (see my other patchset for that here
> https://lore.kernel.org/linux-riscv/7504a525-8211-48b3-becb-a6e838c1b42e@=
arm.com/T/#m57d273d680fc531b3aa1074e6f8558a52ba5badc).
>
> What could be "others" here?


I acknowledge that the current focus is on Transparent Huge Pages. However,
many aspects of CONT-PTE appear to be applicable to the mm-core in general.
For example,

/*
 * The below functions constitute the public API that arm64 presents to the
 * core-mm to manipulate PTE entries within their page tables (or at least =
this
 * is the subset of the API that arm64 needs to implement). These public
 * versions will automatically and transparently apply the contiguous bit w=
here
 * it makes sense to do so. Therefore any users that are contig-aware (e.g.
 * hugetlb, kernel mapper) should NOT use these APIs, but instead use the
 * private versions, which are prefixed with double underscore. All of thes=
e
 * APIs except for ptep_get_lockless() are expected to be called with the P=
TL
 * held. Although the contiguous bit is considered private to the
 * implementation, it is deliberately allowed to leak through the getters (=
e.g.
 * ptep_get()), back to core code. This is required so that pte_leaf_size()=
 can
 * provide an accurate size for perf_get_pgtable_size(). But this leakage m=
eans
 * its possible a pte will be passed to a setter with the contiguous bit se=
t, so
 * we explicitly clear the contiguous bit in those cases to prevent acciden=
tally
 * setting it in the pgtable.
 */

#define ptep_get ptep_get
static inline pte_t ptep_get(pte_t *ptep)
{
        pte_t pte =3D __ptep_get(ptep);

        if (likely(!pte_valid_cont(pte)))
                return pte;

        return contpte_ptep_get(ptep, pte);
}

Could it possibly be given a more generic name such as "PGTABLE_CONTPTE"?

>
> Thanks for your comment,
>
> Alex
>
> >
> > >
> > >  /*
> > >   * The contpte APIs are used to transparently manage the contiguous =
bit in ptes
> > > @@ -1622,7 +1622,7 @@ static inline int ptep_set_access_flags(struct =
vm_area_struct *vma,
> > >         return contpte_ptep_set_access_flags(vma, addr, ptep, entry, =
dirty);
> > >  }
> > >
> > > -#else /* CONFIG_ARM64_CONTPTE */
> > > +#else /* CONFIG_THP_CONTPTE */
> > >
> > >  #define ptep_get                               __ptep_get
> > >  #define set_pte                                        __set_pte
> > > @@ -1642,7 +1642,7 @@ static inline int ptep_set_access_flags(struct =
vm_area_struct *vma,
> > >  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> > >  #define ptep_set_access_flags                  __ptep_set_access_fla=
gs
> > >
> > > -#endif /* CONFIG_ARM64_CONTPTE */
> > > +#endif /* CONFIG_THP_CONTPTE */
> > >
> > >  int find_num_contig(struct mm_struct *mm, unsigned long addr,
> > >                     pte_t *ptep, size_t *pgsize);
> > > diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> > > index 60454256945b..52a1b2082627 100644
> > > --- a/arch/arm64/mm/Makefile
> > > +++ b/arch/arm64/mm/Makefile
> > > @@ -3,7 +3,7 @@ obj-y                           :=3D dma-mapping.o ex=
table.o fault.o init.o \
> > >                                    cache.o copypage.o flush.o \
> > >                                    ioremap.o mmap.o pgd.o mmu.o \
> > >                                    context.o proc.o pageattr.o fixmap=
.o
> > > -obj-$(CONFIG_ARM64_CONTPTE)    +=3D contpte.o
> > > +obj-$(CONFIG_THP_CONTPTE)      +=3D contpte.o
> > >  obj-$(CONFIG_HUGETLB_PAGE)     +=3D hugetlbpage.o
> > >  obj-$(CONFIG_PTDUMP_CORE)      +=3D ptdump.o
> > >  obj-$(CONFIG_PTDUMP_DEBUGFS)   +=3D ptdump_debugfs.o
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index c325003d6552..fd4de221a1c6 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -984,6 +984,15 @@ config ARCH_HAS_CACHE_LINE_SIZE
> > >  config ARCH_HAS_CONTPTE
> > >         bool
> > >
> > > +config THP_CONTPTE
> > > +       bool "Contiguous PTE mappings for user memory" if EXPERT
> > > +       depends on ARCH_HAS_CONTPTE && TRANSPARENT_HUGEPAGE
> > > +       default y
> > > +       help
> > > +         When enabled, user mappings are configured using the PTE co=
ntiguous
> > > +         bit, for any mappings that meet the size and alignment requ=
irements.
> > > +         This reduces TLB pressure and improves performance.
> > > +
> > >  config ARCH_HAS_CURRENT_STACK_POINTER
> > >         bool
> > >         help
> > > --
> > > 2.39.2
> >
Thanks
Barry

