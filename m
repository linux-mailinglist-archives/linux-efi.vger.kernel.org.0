Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1C310ACF
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhBEMA5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Feb 2021 07:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232047AbhBEL6c (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Feb 2021 06:58:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C1B964FD0;
        Fri,  5 Feb 2021 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612526271;
        bh=U9so/rHyR0hVc2xX6oY2l2vg5J61lAZH93MEbQPViNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eglJi6jjeEmj9f+pc/aEPV2ah17Yn/ZUE8jr61fZIMavlMHKFbw/701G3R9gnxqus
         sdPX49nlbeCYFlHHRkWzB9+Plfqnaxon83sb6WgDWX0npsQRaDn1Bkl/DZYK0wHtnL
         ckluspV5lBz6/SkyYDfeBroj4vYEpgjNJTQlDvpkcP4S7vQ2zmXLSmP/ZqZb6t/4YX
         fGwdCxwTCoWe7lEOC7V/EogPqeENVKIutiaUZoOPwwQZoE05BUELOCQHVs5LfN73Nd
         inI/TVzxAuLiKR3nJEi7MthQhZOqzVUoxspFm596bXlH/zE2lTFQuXXYegbYqCk6c3
         pCWuDyBexhV1g==
Received: by mail-oi1-f179.google.com with SMTP id j25so7181111oii.0;
        Fri, 05 Feb 2021 03:57:50 -0800 (PST)
X-Gm-Message-State: AOAM530ENH4y0fD9UFNh3n8fAxguAqwg3JjMNGMyV3jSJD6MpfIv6I9S
        T0kyiXAjbsHp2UNbsk9XCcCCbvBIUpffsCkbB/A=
X-Google-Smtp-Source: ABdhPJyV4g662YXr7ocDc4gykAJEjrn19g2q8oK2R4Y25T0vh1HA/SyiXDBxxAruYDekqRHeoVIb3cd7YxKxDb08/N0=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr2772699oih.33.1612526270014;
 Fri, 05 Feb 2021 03:57:50 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic> <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost> <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic> <YBxqnosGDroAnpio@rani.riverdale.lan>
 <20210204221318.GI32255@zn.tnic> <YByMdh/qDEwreq6S@rani.riverdale.lan> <20210205113930.GD17488@zn.tnic>
In-Reply-To: <20210205113930.GD17488@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Feb 2021 12:57:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEpNuMyotUN5ojoFUjvAdx--OxqDqN030S2RmdONn3a6g@mail.gmail.com>
Message-ID: <CAMj1kXEpNuMyotUN5ojoFUjvAdx--OxqDqN030S2RmdONn3a6g@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Remove EFI PGD build time checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Feb 2021 at 12:39, Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> With CONFIG_X86_5LEVEL, CONFIG_UBSAN and CONFIG_UBSAN_UNSIGNED_OVERFLOW
> enabled, clang fails the build with
>
>   x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
>   efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
>
> which happens due to -fsanitize=unsigned-integer-overflow being enabled:
>
>   -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
>   the result of an unsigned integer computation cannot be represented
>   in its type. Unlike signed integer overflow, this is not undefined
>   behavior, but it is often unintentional. This sanitizer does not check
>   for lossy implicit conversions performed before such a computation
>   (see -fsanitize=implicit-conversion).
>
> and that fires when the (intentional) EFI_VA_START/END defines overflow
> an unsigned long, leading to the assertion expressions not getting
> optimized away (on GCC they do)...
>
> However, those checks are superfluous: the runtime services mapping
> code already makes sure the ranges don't overshoot EFI_VA_END as the
> EFI mapping range is hardcoded. On each runtime services call, it is
> switched to the EFI-specific PGD and even if mappings manage to escape
> that last PGD, this won't remain unnoticed for long.
>
> So rip them out.
>
> See https://github.com/ClangBuiltLinux/linux/issues/256 for more info.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: http://lkml.kernel.org/r/20210107223424.4135538-1-arnd@kernel.org
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/platform/efi/efi_64.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..8efd003540ca 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -115,31 +115,12 @@ void efi_sync_low_kernel_mappings(void)
>         pud_t *pud_k, *pud_efi;
>         pgd_t *efi_pgd = efi_mm.pgd;
>
> -       /*
> -        * We can share all PGD entries apart from the one entry that
> -        * covers the EFI runtime mapping space.
> -        *
> -        * Make sure the EFI runtime region mappings are guaranteed to
> -        * only span a single PGD entry and that the entry also maps
> -        * other important kernel regions.
> -        */
> -       MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
> -       MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
> -                       (EFI_VA_END & PGDIR_MASK));
> -
>         pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
>         pgd_k = pgd_offset_k(PAGE_OFFSET);
>
>         num_entries = pgd_index(EFI_VA_END) - pgd_index(PAGE_OFFSET);
>         memcpy(pgd_efi, pgd_k, sizeof(pgd_t) * num_entries);
>
> -       /*
> -        * As with PGDs, we share all P4D entries apart from the one entry
> -        * that covers the EFI runtime mapping space.
> -        */
> -       BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> -
>         pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>         pgd_k = pgd_offset_k(EFI_VA_END);
>         p4d_efi = p4d_offset(pgd_efi, 0);
> --
> 2.29.2
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
