Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8881C2AE1FA
	for <lists+linux-efi@lfdr.de>; Tue, 10 Nov 2020 22:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgKJVo1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Nov 2020 16:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJVoE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Nov 2020 16:44:04 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2179B20731;
        Tue, 10 Nov 2020 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044643;
        bh=46dE3uxlicE3osaLmLW8QlqUGPvGAKXg+kLAh3iwlLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJoaJTVB+FKeY6LZTu3f/y88KKbLsb1w6WL/39zyi8SSy/3Rup5L/jbMWz2lnGdW8
         03LAV1WCPbHSJ0YVsXkiH/uDWuFbgxrZEwO8ckY22f0r2UONdHa67gBR7/Pj48WIH0
         Gt73rUkX7uaGdstBrmh0QEvoRLjTmDhUb1nARh9o=
Received: by mail-ot1-f41.google.com with SMTP id a15so183170otf.5;
        Tue, 10 Nov 2020 13:44:03 -0800 (PST)
X-Gm-Message-State: AOAM532MO+EK2LKef054NpwEB/gUSlsEcevbGn8g3JGm5uoQVqXEonX4
        gA+j7dSOIrbOCFVVrWE716pbTAQGgtbeNXIWN34=
X-Google-Smtp-Source: ABdhPJyrTPvtp8t6wnOxXl5egrbWqYa12xf2alJX2eBHLIyV03BkLyc1ALzUSV5UDT6m1Lw07UCsMYzsusYoBGDIahY=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr6107152otd.90.1605044642464;
 Tue, 10 Nov 2020 13:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20201110163919.1134431-1-nivedita@alum.mit.edu>
In-Reply-To: <20201110163919.1134431-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Nov 2020 22:43:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEZAOh6A1xcURNN48=f-LL6tFv4FEaTLyMLBTLwgTt4wA@mail.gmail.com>
Message-ID: <CAMj1kXEZAOh6A1xcURNN48=f-LL6tFv4FEaTLyMLBTLwgTt4wA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Free efi_pgd with free_pages()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 10 Nov 2020 at 17:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
> changed the PGD allocation to allocate PGD_ALLOCATION_ORDER pages, so in
> the error path it should be freed using free_pages() rather than
> free_page().
>
> Commit
>   06ace26f4e6f ("x86/efi: Free efi_pgd with free_pages()")
> fixed one instance of this, but missed another.
>
> Move the freeing out-of-line to avoid code duplication and fix this bug.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Fixes: d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")

Thanks Arvind. I'll queue this as a fix.

> ---
>  arch/x86/platform/efi/efi_64.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 8f5759df7776..e1e8d4e3a213 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -78,28 +78,30 @@ int __init efi_alloc_page_tables(void)
>         gfp_mask = GFP_KERNEL | __GFP_ZERO;
>         efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
>         if (!efi_pgd)
> -               return -ENOMEM;
> +               goto fail;
>
>         pgd = efi_pgd + pgd_index(EFI_VA_END);
>         p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
> -       if (!p4d) {
> -               free_page((unsigned long)efi_pgd);
> -               return -ENOMEM;
> -       }
> +       if (!p4d)
> +               goto free_pgd;
>
>         pud = pud_alloc(&init_mm, p4d, EFI_VA_END);
> -       if (!pud) {
> -               if (pgtable_l5_enabled())
> -                       free_page((unsigned long) pgd_page_vaddr(*pgd));
> -               free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
> -               return -ENOMEM;
> -       }
> +       if (!pud)
> +               goto free_p4d;
>
>         efi_mm.pgd = efi_pgd;
>         mm_init_cpumask(&efi_mm);
>         init_new_context(NULL, &efi_mm);
>
>         return 0;
> +
> +free_p4d:
> +       if (pgtable_l5_enabled())
> +               free_page((unsigned long)pgd_page_vaddr(*pgd));
> +free_pgd:
> +       free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
> +fail:
> +       return -ENOMEM;
>  }
>
>  /*
> --
> 2.26.2
>
