Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAB30F164
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhBDLAC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 06:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235451AbhBDLAB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 06:00:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A304364F78;
        Thu,  4 Feb 2021 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612436360;
        bh=TcXVmu+fm+5dg4n7lQxBdH6RO7TzX9jei0B4wo/LbuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JAA4iEQsYiPxU9pe1NjJZP4Ks2SZh9HQ0pJyFaJCegO6NXbLJqJrVaemxy2FGUnjw
         jsm+06QyRthDyIU2kL4jPmQky5QfBsvDZqjDuM+zubQ7voyOM72AuMXw0gFOUGBmUt
         3TdXLyGd1zdS+U9YrpTEkFRyhINUu8CtcY+6eUAoKYxRoKTEvVVqwoic27LXCiwV/R
         ILPJ0u+/jldIcgqr1OPgpNETE1bW+HIDDoKJDKAR5c0AjHoVbPiPmCQVETDIFX8iAN
         2/SUAxvaqcE9ahiMEpfU+teKtziSeNOCgIv8V20Evqm1fTCpwfGM70QvGH2aFGc5Mg
         TJh7esj9OaDWA==
Received: by mail-oi1-f172.google.com with SMTP id k142so3251037oib.7;
        Thu, 04 Feb 2021 02:59:20 -0800 (PST)
X-Gm-Message-State: AOAM530JUCqP4nr9aPiCzOczMPg9fi0mQu6jcVsFFfvhkPXMrGzoY1jC
        1sLqp3ixqE/3zED8DoYDiL7CUcYoQ9JwalC+rZM=
X-Google-Smtp-Source: ABdhPJxxoDZ9P85GGLeXQpSikdoj66A14Va5HEghinCcn8haB0ubF4ZEW3ly1sI8Xqq8qm1KRLA+a+bG6w67KbW+XJw=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr4797190oif.47.1612436359805;
 Thu, 04 Feb 2021 02:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20210107223424.4135538-1-arnd@kernel.org> <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan> <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic> <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost> <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic>
In-Reply-To: <20210204105155.GA32255@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 11:59:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBUKA-LFsdBh19yqAOF8x=tYPff6Bw2Zxg31Oe9mGOQg@mail.gmail.com>
Message-ID: <CAMj1kXGBUKA-LFsdBh19yqAOF8x=tYPff6Bw2Zxg31Oe9mGOQg@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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

On Thu, 4 Feb 2021 at 11:52, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 03, 2021 at 09:29:18PM +0100, Ard Biesheuvel wrote:
> > I think we have agreement on the approach but it is unclear who is
> > going to write the patch.
>
> How's that below?
>
> And frankly, I'd even vote for removing those assertions altogether. If
> somehow the EFI pgd lands somewhere else, the kernel will crash'n'burn
> spectacularly and quickly so it's not like we won't catch it...
>

+1 for just removing them

> ---
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 91ac10654570..b6be19c09841 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -156,8 +156,8 @@ extern unsigned int ptrs_per_p4d;
>  #define CPU_ENTRY_AREA_PGD     _AC(-4, UL)
>  #define CPU_ENTRY_AREA_BASE    (CPU_ENTRY_AREA_PGD << P4D_SHIFT)
>
> -#define EFI_VA_START           ( -4 * (_AC(1, UL) << 30))
> -#define EFI_VA_END             (-68 * (_AC(1, UL) << 30))
> +#define EFI_VA_START           ( -4UL * (_AC(1, UL) << 30))
> +#define EFI_VA_END             (-68UL * (_AC(1, UL) << 30))
>
>  #define EARLY_DYNAMIC_PAGE_TABLES      64
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..56fdc0bbb554 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -123,9 +123,7 @@ void efi_sync_low_kernel_mappings(void)
>          * only span a single PGD entry and that the entry also maps
>          * other important kernel regions.
>          */
> -       MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
> -       MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
> -                       (EFI_VA_END & PGDIR_MASK));
> +       MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) != PGDIR_MASK);
>
>         pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
>         pgd_k = pgd_offset_k(PAGE_OFFSET);
> @@ -137,8 +135,7 @@ void efi_sync_low_kernel_mappings(void)
>          * As with PGDs, we share all P4D entries apart from the one entry
>          * that covers the EFI runtime mapping space.
>          */
> -       BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> +       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != P4D_MASK);
>
>         pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>         pgd_k = pgd_offset_k(EFI_VA_END);
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
