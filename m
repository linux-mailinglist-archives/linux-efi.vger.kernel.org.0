Return-Path: <linux-efi+bounces-3720-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F84DAB995B
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FD91BC304A
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B642309B0;
	Fri, 16 May 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGqf0+Mo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269322F768;
	Fri, 16 May 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389067; cv=none; b=B/xGHQ+1lXf9muuX8Q3/ru9H1iBOttAiy15PF2/Al9PdKF7uuRHHTZ/2wCGvVzwUXOF//d4sOOSwMh7wTUKJgbDupnE1aofwPnQ0pKfd6KQrFE9xlieNpqotxB6Ky/NotShmWzzPnP9m6dYchqP6r/mFatOgcMIypwZKkW9Xe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389067; c=relaxed/simple;
	bh=/jAWXR6VKTKQSEmI6JrJ5jlZYyO2DKHCGM36Numsajs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3ThPjVyJdQho3JspO4vGpgxFE7J5PbA9FJpww1wEczaGJKzRGjziK4cNUKYJz01UhM5v6XhU3jfTLEBgo8IENVpOfNhDKFfT6bv24TW/tsdCrE8CTT4jfGdUzp3VM+j4a/ezHnTQoemU87KZL/8val6vMbXiuIzkq55VrsD5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGqf0+Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C0EC4AF0B;
	Fri, 16 May 2025 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747389066;
	bh=/jAWXR6VKTKQSEmI6JrJ5jlZYyO2DKHCGM36Numsajs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fGqf0+MoRS1/UIGOVH5m2r+dFKA2BY1/DIU7tDFv6ZQFWXUuKsXdRbpcRoh2ej20T
	 0cWQmfmxnVSrPVFcYSSPYEmdJ0fhi7yKZZ5ofvOx6Gt7lmXwfaw64IJ0ZUYJjuSlK9
	 dZNdjganGReYFAJSbmYJipc6x017Z11dfLUETOg/20JaKiSNX+NHIAX+h6scQFjjCC
	 OFxq1qamsfMYxOLmM/1VMq+3IiMojdAm4YhR4FeihgRaBxRNV1Y3wLEkQhnHisxMZn
	 QfzLBch2+kln10ExkAi2sy7qIVNKttrbtb0IxxA2pAL7PijmK9MplNrqIwMj02gGsO
	 ySphWh88fCvLA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so2118715e87.0;
        Fri, 16 May 2025 02:51:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1ATFUciAABIRfaXsct4CfiBCvg6A4vKtxqxHAlAF7ME8abmc5NYsYiLjTdc1au4cI0dzPyXlbkn8=@vger.kernel.org, AJvYcCV5cxkt0WZTW1ADmoxvuDHLRqk7Op5vniTvjYrThJA0FNhwj/a+gPzfJr3vDoUvn5XzHzUjFfQjbpEz/OnO@vger.kernel.org, AJvYcCWXLQUT+WFFYabkelyByd4tAGjmo6CHqH1ret3Rqd3F7Y7QFEs0lh0OTUKy2AvxNRnHWXsSe4b3bRJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVTGLEBILrgrseUTfvtVI486SPEKsvB7MJfDmYXdK2rWstcyq
	F0z2evsYdQ6htmBVdLrYtz+XFO9fBLdAiJglMOmSxrkVfpzuLngWgxF9qP7pGihU3oz59jPUPfZ
	2rVEEvWEtcwz2QFYb3JrxkdSsafzeBtY=
X-Google-Smtp-Source: AGHT+IGbo5ZSAqFfCoTDfiNzELg0CQUhk3Gl4Jge7Pzr0r/eMYBkHyuRoMUh2uZmfKdJ32lXEy1yzfZJj1dCdPbXlvE=
X-Received: by 2002:a05:6512:2616:b0:545:2871:7cd5 with SMTP id
 2adb3069b0e04-550e97bfc09mr421925e87.15.1747389065018; Fri, 16 May 2025
 02:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com> <20250516091534.3414310-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250516091534.3414310-2-kirill.shutemov@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 May 2025 10:50:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHg-T7Aehe1q8k7HixrwmiAm3tdXNkXGCiW+guctEoShA@mail.gmail.com>
X-Gm-Features: AX0GCFtwvkgkQcSJHaBvXi0OGJh1BP9q2wUBN4cXzu3cTwzMsUmdgboTcKKTlmU
Message-ID: <CAMj1kXHg-T7Aehe1q8k7HixrwmiAm3tdXNkXGCiW+guctEoShA@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] x86/64/mm: Always use dynamic memory layout
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Juergen Gross <jgross@suse.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 10:15, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Dynamic memory layout is used by KASLR and 5-level paging.
>
> CONFIG_X86_5LEVEL is going to be removed, making 5-level paging support
> unconditional which requires unconditional support of dynamic memory
> layout.
>
> Remove CONFIG_DYNAMIC_MEMORY_LAYOUT.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/Kconfig                        | 8 --------
>  arch/x86/include/asm/page_64_types.h    | 4 ----
>  arch/x86/include/asm/pgtable_64_types.h | 6 ------
>  arch/x86/kernel/head64.c                | 2 --
>  scripts/gdb/linux/pgtable.py            | 4 +---
>  5 files changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 891a69b308cb..d3c2da3b2f0b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1467,7 +1467,6 @@ config X86_PAE
>  config X86_5LEVEL
>         bool "Enable 5-level page tables support"
>         default y
> -       select DYNAMIC_MEMORY_LAYOUT
>         select SPARSEMEM_VMEMMAP
>         depends on X86_64
>         help
> @@ -2167,17 +2166,10 @@ config PHYSICAL_ALIGN
>
>           Don't change this unless you know what you are doing.
>
> -config DYNAMIC_MEMORY_LAYOUT
> -       bool
> -       help
> -         This option makes base addresses of vmalloc and vmemmap as well as
> -         __PAGE_OFFSET movable during boot.
> -
>  config RANDOMIZE_MEMORY
>         bool "Randomize the kernel memory sections"
>         depends on X86_64
>         depends on RANDOMIZE_BASE
> -       select DYNAMIC_MEMORY_LAYOUT
>         default RANDOMIZE_BASE
>         help
>           Randomizes the base virtual address of kernel memory sections
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 1faa8f88850a..6b8c8169c71d 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -41,11 +41,7 @@
>  #define __PAGE_OFFSET_BASE_L5  _AC(0xff11000000000000, UL)
>  #define __PAGE_OFFSET_BASE_L4  _AC(0xffff888000000000, UL)
>
> -#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
>  #define __PAGE_OFFSET           page_offset_base
> -#else
> -#define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
> -#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>
>  #define __START_KERNEL_map     _AC(0xffffffff80000000, UL)
>
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index e83721db18c9..eee06f77b245 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -128,15 +128,9 @@ extern unsigned int ptrs_per_p4d;
>  #define __VMEMMAP_BASE_L4      0xffffea0000000000UL
>  #define __VMEMMAP_BASE_L5      0xffd4000000000000UL
>
> -#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
>  # define VMALLOC_START         vmalloc_base
>  # define VMALLOC_SIZE_TB       (pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
>  # define VMEMMAP_START         vmemmap_base
> -#else
> -# define VMALLOC_START         __VMALLOC_BASE_L4
> -# define VMALLOC_SIZE_TB       VMALLOC_SIZE_TB_L4
> -# define VMEMMAP_START         __VMEMMAP_BASE_L4
> -#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>
>  #ifdef CONFIG_RANDOMIZE_MEMORY
>  # define DIRECT_MAP_PHYSMEM_END        direct_map_physmem_end
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 14f7dda20954..9f617be64fa9 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -59,14 +59,12 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
>  EXPORT_SYMBOL(ptrs_per_p4d);
>  #endif
>
> -#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
>  unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
>  EXPORT_SYMBOL(page_offset_base);
>  unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
>  EXPORT_SYMBOL(vmalloc_base);
>  unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
>  EXPORT_SYMBOL(vmemmap_base);
> -#endif
>
>  /* Wipe all early page tables except for the kernel symbol map */
>  static void __init reset_early_page_tables(void)
> diff --git a/scripts/gdb/linux/pgtable.py b/scripts/gdb/linux/pgtable.py
> index 30d837f3dfae..09aac2421fb8 100644
> --- a/scripts/gdb/linux/pgtable.py
> +++ b/scripts/gdb/linux/pgtable.py
> @@ -29,11 +29,9 @@ def page_mask(level=1):
>          raise Exception(f'Unknown page level: {level}')
>
>
> -#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
> -POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
>  def _page_offset_base():
>      pob_symbol = gdb.lookup_global_symbol('page_offset_base')
> -    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
> +    pob = pob_symbol.name
>      return gdb.parse_and_eval(pob)
>
>
> --
> 2.47.2
>
>

