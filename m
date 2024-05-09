Return-Path: <linux-efi+bounces-1032-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C738C08A6
	for <lists+linux-efi@lfdr.de>; Thu,  9 May 2024 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370281F2167C
	for <lists+linux-efi@lfdr.de>; Thu,  9 May 2024 00:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFE38DD4;
	Thu,  9 May 2024 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtdHoghz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB98364A5;
	Thu,  9 May 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215610; cv=none; b=gjUgzsdSer31mbx5ygAvJAil2PxXgnQWc2Ix1W94nucTBBxYOcqpf3KZuJpNKI2UGNnE1Iglivzj2gl9jZj7LgBeLJyrq6Xn4vrdCiWDT8IJPSKLMh/LYVQ0uvXhnNKBk1WxgJFQoxnn0ciSGwr0YjyzcMNQC6X4uO1qs+p4KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215610; c=relaxed/simple;
	bh=+KT3BBq/J8pC0HgggVgvXiiYxlzHKGxivVXeeAlfYiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAb4wbuRKJKAd4Z6fw8LiS8EPBAafUl3QGCocg1nMNNl69kJIY+e9lMfQ6VX0CLcxFd+dfP8zwatLJnL4cuxZUYIldhvx/lTARhiIKgF+2X0scGCFwnqIUe5aAKJ2uA+5ufjSFg7r+pg6hP1BKCwAdSg21wO5csVDeao64ucA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtdHoghz; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4dcceac3ae1so149588e0c.2;
        Wed, 08 May 2024 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715215607; x=1715820407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HutaMr4YNAQdV0piVG8U9fxjw32ZuJHu11VAl/8knE=;
        b=ZtdHoghzdszVnl5jcHEMHzzeP0m/gx2/mOnsDBZeQcAlbakwYAzQqY9Kq1clGbISLG
         1pu8advSFe9kke+kcuVEeMZwRc4nPRG9LDM6iEBbb9ial9BykNscNScULiUnPmxTiWOn
         535R3AYoduJ34nm02e45km8N73W9TD3ki1RFSuBZU6kMKqhWXsT6TquMjD66PXZ6trlW
         9Xpvy9T7tDYTK3mRU6SeGFRiP5B1ppiQBE1Oxm1YlRlSZkS0PIll61oO7lgbN0BB8LRu
         aAgLe8zz+GvLp4+ob6KKbPjt6fXgaJxLOmwpU91RX2//5djO6TMfRV9n9C+cOe2+qGGK
         JCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215607; x=1715820407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HutaMr4YNAQdV0piVG8U9fxjw32ZuJHu11VAl/8knE=;
        b=Qq4+V21JI3eXZFvIwFj0+f2VM9cSzlFl+tpMKQfowVyqzQb1AWKIv7C6pnOUcmSGEP
         3iUERbPVwjQ3QpqaR/gabQalTVoDYhkIGM1w2OigX9YgZz/hp8WYifmHYbWmLSzeK1J9
         lM7JOuQpTJTzEJmsLlzI/wI5CoboFlq4maLaVd8DW+c+bfwlhzzpiyt27Gg7WSOk8UVA
         bWZGzqFWWDs0KRTf+iPI9gj45eSX4ZGkr6vg7hVpP4InlqPy6k7aPPOHYyVN9OS/cxNy
         ACIpRpwKPYcapNr8N9wLcKqbJW0qlMPkVPmrgvi3qeSAAG/qveGyyy62csaBhjy6cyNf
         DKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4DKcQsuHdbJtJ3QqUt1gIJuTCtocCOrAOgfcrC8Q19HZY8K5X0ivCITZ6wZlCS+sWVDC58coplpEV6HjJ2m2llnmy/BrrEBPqx3eb/ag7BdykjXnOaHlYbY+pJYXp8WNqWpoNH+fy1CLCNWwHVv1H6+RyGJpcrR1gzTX
X-Gm-Message-State: AOJu0YzwJDQqea8qcIAVH3k81m/2hPdZTp6k0Tu/WhQ5ElG6MRlZF9wz
	oOvuvM5gVAU9PEBKIBb6SBDOPGHvVFch5cDOiuHF1KbGw2CJ7x2/pwfaN/S7+eDnzZfMs+9HOcg
	lf34NAINT8DZ8ojbNSOU2cOQrNDA=
X-Google-Smtp-Source: AGHT+IF79LXSq4NewTC5DFVGeNH4TGRK7B023rxeM+UTTC9bpQ7D2OYFXWiN0Dal3DjFVZkbQyCweJ7ZkvtSI8S33PY=
X-Received: by 2002:a05:6122:7cb:b0:4d8:797b:94df with SMTP id
 71dfb90a1353d-4df6929c091mr4383063e0c.2.1715215607538; Wed, 08 May 2024
 17:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508191931.46060-1-alexghiti@rivosinc.com> <20240508191931.46060-2-alexghiti@rivosinc.com>
In-Reply-To: <20240508191931.46060-2-alexghiti@rivosinc.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 12:46:35 +1200
Message-ID: <CAGsJ_4xayC4D4y0d7SPXxCvuW4-rJQUCa_-OUDSsOGm_HyPm1w@mail.gmail.com>
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

On Thu, May 9, 2024 at 7:20=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> The ARM64_CONTPTE config represents the capability to transparently use
> contpte mappings for THP userspace mappings, which will be implemented
> in the next commits for riscv, so make this config more generic and move
> it to mm.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/arm64/Kconfig               | 9 ---------
>  arch/arm64/include/asm/pgtable.h | 6 +++---
>  arch/arm64/mm/Makefile           | 2 +-
>  mm/Kconfig                       | 9 +++++++++
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ac2f6d906cc3..9d823015b4e5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2227,15 +2227,6 @@ config UNWIND_PATCH_PAC_INTO_SCS
>         select UNWIND_TABLES
>         select DYNAMIC_SCS
>
> -config ARM64_CONTPTE
> -       bool "Contiguous PTE mappings for user memory" if EXPERT
> -       depends on TRANSPARENT_HUGEPAGE
> -       default y
> -       help
> -         When enabled, user mappings are configured using the PTE contig=
uous
> -         bit, for any mappings that meet the size and alignment requirem=
ents.
> -         This reduces TLB pressure and improves performance.
> -
>  endmenu # "Kernel Features"
>
>  menu "Boot options"
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 7c2938cb70b9..1758ce71fae9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1369,7 +1369,7 @@ extern void ptep_modify_prot_commit(struct vm_area_=
struct *vma,
>                                     unsigned long addr, pte_t *ptep,
>                                     pte_t old_pte, pte_t new_pte);
>
> -#ifdef CONFIG_ARM64_CONTPTE
> +#ifdef CONFIG_THP_CONTPTE

Is it necessarily THP? can't be hugetlb or others? I feel THP_CONTPTE
isn't a good name.

>
>  /*
>   * The contpte APIs are used to transparently manage the contiguous bit =
in ptes
> @@ -1622,7 +1622,7 @@ static inline int ptep_set_access_flags(struct vm_a=
rea_struct *vma,
>         return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirt=
y);
>  }
>
> -#else /* CONFIG_ARM64_CONTPTE */
> +#else /* CONFIG_THP_CONTPTE */
>
>  #define ptep_get                               __ptep_get
>  #define set_pte                                        __set_pte
> @@ -1642,7 +1642,7 @@ static inline int ptep_set_access_flags(struct vm_a=
rea_struct *vma,
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  #define ptep_set_access_flags                  __ptep_set_access_flags
>
> -#endif /* CONFIG_ARM64_CONTPTE */
> +#endif /* CONFIG_THP_CONTPTE */
>
>  int find_num_contig(struct mm_struct *mm, unsigned long addr,
>                     pte_t *ptep, size_t *pgsize);
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 60454256945b..52a1b2082627 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -3,7 +3,7 @@ obj-y                           :=3D dma-mapping.o extabl=
e.o fault.o init.o \
>                                    cache.o copypage.o flush.o \
>                                    ioremap.o mmap.o pgd.o mmu.o \
>                                    context.o proc.o pageattr.o fixmap.o
> -obj-$(CONFIG_ARM64_CONTPTE)    +=3D contpte.o
> +obj-$(CONFIG_THP_CONTPTE)      +=3D contpte.o
>  obj-$(CONFIG_HUGETLB_PAGE)     +=3D hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE)      +=3D ptdump.o
>  obj-$(CONFIG_PTDUMP_DEBUGFS)   +=3D ptdump_debugfs.o
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c325003d6552..fd4de221a1c6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -984,6 +984,15 @@ config ARCH_HAS_CACHE_LINE_SIZE
>  config ARCH_HAS_CONTPTE
>         bool
>
> +config THP_CONTPTE
> +       bool "Contiguous PTE mappings for user memory" if EXPERT
> +       depends on ARCH_HAS_CONTPTE && TRANSPARENT_HUGEPAGE
> +       default y
> +       help
> +         When enabled, user mappings are configured using the PTE contig=
uous
> +         bit, for any mappings that meet the size and alignment requirem=
ents.
> +         This reduces TLB pressure and improves performance.
> +
>  config ARCH_HAS_CURRENT_STACK_POINTER
>         bool
>         help
> --
> 2.39.2

Thanks
Barry

