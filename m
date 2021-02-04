Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B415E30FF79
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBDVoo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 16:44:44 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:41058 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBDVom (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Feb 2021 16:44:42 -0500
Received: by mail-qv1-f54.google.com with SMTP id h21so2497571qvb.8;
        Thu, 04 Feb 2021 13:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pKT1129goorIBDoVw07+oNDIAL0ruSPyAoYmTeYA4JM=;
        b=Bn4a9GTTajo10p4tP/SXrggABMPkJiStl+9Rl154EHydZPM0sccgLHJBGlGUeXzuWR
         n9ylZkthg6+C7NMtJrc5HylZAK3vlgmlZQMxAeyBATSzWDAGhdD3fzk7CZL8Sb7Oj8jM
         njs8NZ2udBguOEgzT8/psSTweXcv+UbFQXmxWCK1/KP5APvKiuSt9EM0ZKIWuV59nJex
         psAGevQyiZ1KpYlZYVOtSP4U8dW/8yU2D9ffU7GwQAWsyrfLfSfTvZCf/Ee1BB8Gqj9z
         nfvwW7yx2SaUHds+sfC+l9+Q4dEjWvfOBTRJOLXNbzX3n4VHJiL3JuIqgOWVwBsMMK+5
         ZjGg==
X-Gm-Message-State: AOAM533a0v1fk95TsoUMhENJjzfLrGtuR+Jx5ur+4B/UQrOOsem+FaRk
        2VoB0yhR2b18N0xauOHu+Kg=
X-Google-Smtp-Source: ABdhPJz2GAyRB5K1dve72PPvUvmzJgXl6kFeOkPJ4uljCE4HZUquh+9dhzFcCpdxEuS+c3JQWtBHqg==
X-Received: by 2002:a05:6214:a4f:: with SMTP id ee15mr1429073qvb.10.1612475041219;
        Thu, 04 Feb 2021 13:44:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p22sm6267413qkk.128.2021.02.04.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:00 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:43:58 -0500
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YBxqnosGDroAnpio@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204105155.GA32255@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 04, 2021 at 11:51:55AM +0100, Borislav Petkov wrote:
> On Wed, Feb 03, 2021 at 09:29:18PM +0100, Ard Biesheuvel wrote:
> > I think we have agreement on the approach but it is unclear who is
> > going to write the patch.
> 
> How's that below?
> 
> And frankly, I'd even vote for removing those assertions altogether. If
> somehow the EFI pgd lands somewhere else, the kernel will crash'n'burn
> spectacularly and quickly so it's not like we won't catch it...

Removing altogether should be fine, but see below if we don't.

> 
> ---
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 91ac10654570..b6be19c09841 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -156,8 +156,8 @@ extern unsigned int ptrs_per_p4d;
>  #define CPU_ENTRY_AREA_PGD	_AC(-4, UL)
>  #define CPU_ENTRY_AREA_BASE	(CPU_ENTRY_AREA_PGD << P4D_SHIFT)
>  
> -#define EFI_VA_START		( -4 * (_AC(1, UL) << 30))
> -#define EFI_VA_END		(-68 * (_AC(1, UL) << 30))
> +#define EFI_VA_START		( -4UL * (_AC(1, UL) << 30))
> +#define EFI_VA_END		(-68UL * (_AC(1, UL) << 30))

This doesn't have any effect right? And the reason for the _AC() stuff
in there is to allow the #define to be used in assembler -- this
particular one isn't, but it makes no sense to use the UL suffix as well
as _AC() in the same macro.

>  
>  #define EARLY_DYNAMIC_PAGE_TABLES	64
>  
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..56fdc0bbb554 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -123,9 +123,7 @@ void efi_sync_low_kernel_mappings(void)
>  	 * only span a single PGD entry and that the entry also maps
>  	 * other important kernel regions.
>  	 */
> -	MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
> -	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
> -			(EFI_VA_END & PGDIR_MASK));
> +	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) != PGDIR_MASK);

This check is superfluous. Just do the P4D one.

>  
>  	pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
>  	pgd_k = pgd_offset_k(PAGE_OFFSET);
> @@ -137,8 +135,7 @@ void efi_sync_low_kernel_mappings(void)
>  	 * As with PGDs, we share all P4D entries apart from the one entry
>  	 * that covers the EFI runtime mapping space.
>  	 */
> -	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> +	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != P4D_MASK);

This should check EFI_VA_END instead of EFI_VA_START, and maybe throw in
a BUG_ON if EFI_VA_END >= EFI_VA_START.

>  
>  	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>  	pgd_k = pgd_offset_k(EFI_VA_END);
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
