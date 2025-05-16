Return-Path: <linux-efi+bounces-3721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA668AB9961
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E927ACB6A
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B832309B0;
	Fri, 16 May 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwwXpaoy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071222F768;
	Fri, 16 May 2025 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389129; cv=none; b=lcdWAJsd2aI3Gfy5xJgnhq3UwjQ9iszq9tbrXPA4q3OVg6Fq8yC5QBW2BqtfHI2q4mF7AoRrElMAx+mt7zGoYMWNOU0k7Kr69K88JTzwqdBrVsA8P9fvft7LDmuALMfBI8w90yjvq/qEBRgzRjcQYBsq/brA4TdPkR+MGacgZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389129; c=relaxed/simple;
	bh=LPskX+KQ9GPO7GtQP8RFX4zL0CkpIZBhYYAREwIva/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srgjQj4/JUVi7R2Wzp0z+zZF7j2BRFpPYiwmas5L3eRshgMskG09qbio1Ckge/4UZjcXXc2NQVJIVKBZ9vw3rt4PNN5pVwpu01PqvNrwGhNyj2AbDn8rmgz4oUuvQ/VvQm3MQXMVqkwDy7smu6TRuPr6Vc6HrP7Dy5S/tEdpYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwwXpaoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994F5C4CEEB;
	Fri, 16 May 2025 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747389128;
	bh=LPskX+KQ9GPO7GtQP8RFX4zL0CkpIZBhYYAREwIva/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lwwXpaoyD7HUDWI/P92VPgVuAV2PfDga9JR/ywuM2hhejO4zYRrdfh3XtDnAyZiSI
	 y4tNoBGu4pDUm8CTUMqpA56WbRdkHi/uJpzi86ljYYptAGxM5Xg5wfo/93QRH1jkGi
	 5o6potLRx6WX9xSUQCUK1FqTxjQjhmYQ7mNlQp0P68TM0Q8ClyaTl/ypFll2LuSvIM
	 B0agJv7/3JYcfAzJcUxkNViut9Yive6V+KDv+fu8l6pAF8EtC7H6qNBwx3+qoZQJax
	 y2JhnCwWZTLcXMtnI5MKU6ZrCaYxhqH62XHZwP61pBxFoGoGa9K0jlgstCHjraGXp9
	 bu+Ab8CDirYcw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54fcc593466so2149305e87.0;
        Fri, 16 May 2025 02:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzYOq4PR+xhEwIkV+TGVfFLMnHT7O47btoN6S0MEmFiYKcCeaxLDnG+ChtL5XjxpgNoHOokNyCS/Mwxg9x@vger.kernel.org, AJvYcCX5DgpsSMJID/m8IK+oKFrQOtWmywiScGlWEF+0x0CxBhWt0BKfi7NcGewKY4C0EykIg0hJrfOdK4fW@vger.kernel.org, AJvYcCXfL9eNVIEjzESMrBxzNnIGV4Npg6ECaYlK/4NM/J4c+xx2i3+3o0RfYVsQN7B1C9C5flEld1Mo9Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWedqb0y4J5k50wifrUrK3bFt5Ky4ckQVPTZYdeRExCAIgKE5W
	CciANua4hKpuU3tHHhmlrw382L21c9vJ4SZsAAS39G8CNxZw30AIg6/LH7+po1BYku5Lw+Yxh4x
	wpKmmCm5rxCpJxg3AnTkRXhDH0sXi2GQ=
X-Google-Smtp-Source: AGHT+IHahFUEPmwbg86aUtdIPUwGuxneUVxJgAjBKxN4poCYamgz1Nsh24E33Vy1oV+OEmftpq0+1+l5gtclDi2iex4=
X-Received: by 2002:a05:6512:3e01:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-550e97b4b52mr551735e87.21.1747389127009; Fri, 16 May 2025
 02:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com> <20250516091534.3414310-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250516091534.3414310-3-kirill.shutemov@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 May 2025 10:51:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGe6jx=dZ3Xe8Cz-xD0pHUaDCyKB4Shb4B=U5vAWXcdRw@mail.gmail.com>
X-Gm-Features: AX0GCFuipmN9JlqI_7OlvvLMi5ltnYPmHTTuJWEdyO20yOdRQp9HX7CWVyTtVAs
Message-ID: <CAMj1kXGe6jx=dZ3Xe8Cz-xD0pHUaDCyKB4Shb4B=U5vAWXcdRw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
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
> 5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
> being phased out, making 5-level paging support mandatory.
>
> Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
> any associated conditional statements.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/Kconfig      | 2 +-
>  arch/x86/mm/init_64.c | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d3c2da3b2f0b..45b36a019b5e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1467,7 +1467,6 @@ config X86_PAE
>  config X86_5LEVEL
>         bool "Enable 5-level page tables support"
>         default y
> -       select SPARSEMEM_VMEMMAP
>         depends on X86_64
>         help
>           5-level paging enables access to larger address space:
> @@ -1579,6 +1578,7 @@ config ARCH_SPARSEMEM_ENABLE
>         def_bool y
>         select SPARSEMEM_STATIC if X86_32
>         select SPARSEMEM_VMEMMAP_ENABLE if X86_64
> +       select SPARSEMEM_VMEMMAP if X86_64
>
>  config ARCH_SPARSEMEM_DEFAULT
>         def_bool X86_64 || (NUMA && X86_32)
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index bf45c7aed336..66330fe4e18c 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -833,7 +833,6 @@ void __init paging_init(void)
>         zone_sizes_init();
>  }
>
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  #define PAGE_UNUSED 0xFD
>
>  /*
> @@ -932,7 +931,6 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
>         if (!IS_ALIGNED(end, PMD_SIZE))
>                 unused_pmd_start = end;
>  }
> -#endif
>
>  /*
>   * Memory hotplug specific functions
> @@ -1152,16 +1150,13 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>                                 pmd_clear(pmd);
>                                 spin_unlock(&init_mm.page_table_lock);
>                                 pages++;
> -                       }
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
> -                       else if (vmemmap_pmd_is_unused(addr, next)) {
> +                       } else if (vmemmap_pmd_is_unused(addr, next)) {
>                                         free_hugepage_table(pmd_page(*pmd),
>                                                             altmap);
>                                         spin_lock(&init_mm.page_table_lock);
>                                         pmd_clear(pmd);
>                                         spin_unlock(&init_mm.page_table_lock);
>                         }
> -#endif
>                         continue;
>                 }
>
> @@ -1500,7 +1495,6 @@ unsigned long memory_block_size_bytes(void)
>         return memory_block_size_probed;
>  }
>
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  /*
>   * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
>   */
> @@ -1647,4 +1641,3 @@ void __meminit vmemmap_populate_print_last(void)
>                 node_start = 0;
>         }
>  }
> -#endif
> --
> 2.47.2
>

