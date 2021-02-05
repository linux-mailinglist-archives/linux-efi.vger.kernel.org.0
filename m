Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDDC3110BE
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhBER1D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Feb 2021 12:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233529AbhBEROn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Feb 2021 12:14:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C40E64DDD;
        Fri,  5 Feb 2021 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612551385;
        bh=OkkSvVZU2knJ4p+uUP/pF7UlAvILdapZPwTt6d0nZJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2VckE1ZDvWkIdIrvbOurhCnBuCidDOT4RIjd/B0eLV8lyPiyDbvneMsAXhrzPasR
         78UfPWR7ac7eyLIJe9WQzjEsZyaMx3ZzeNV/Wdlf5jW4LaZkv0zOvqydcDrG1hkEry
         Yu6pfbjMKab6rwlZRziI9FUaprMrLKFEavyXwlIiQTTAlqZAt8nGB2WIuKOgOAWbDv
         HqUf2ArcgxA2+WPpkT7vj5g+340q/VrxbQ4tLqdZinaCk/3N5ut3LrW9X6e5RAUtx1
         AB+X0HeUgeSVTYFi6ufpDVMGpPWZZfIteVilCbeH+BEZPbb9jEo3Z+9JnzNVlOpnfh
         ExfAZnGHY91SA==
Date:   Fri, 5 Feb 2021 11:56:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH] x86/efi: Remove EFI PGD build time checks
Message-ID: <20210205185622.GA461042@localhost>
References: <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic>
 <YBxqnosGDroAnpio@rani.riverdale.lan>
 <20210204221318.GI32255@zn.tnic>
 <YByMdh/qDEwreq6S@rani.riverdale.lan>
 <20210205113930.GD17488@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205113930.GD17488@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 05, 2021 at 12:39:30PM +0100, Borislav Petkov wrote:
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/platform/efi/efi_64.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..8efd003540ca 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -115,31 +115,12 @@ void efi_sync_low_kernel_mappings(void)
>  	pud_t *pud_k, *pud_efi;
>  	pgd_t *efi_pgd = efi_mm.pgd;
>  
> -	/*
> -	 * We can share all PGD entries apart from the one entry that
> -	 * covers the EFI runtime mapping space.
> -	 *
> -	 * Make sure the EFI runtime region mappings are guaranteed to
> -	 * only span a single PGD entry and that the entry also maps
> -	 * other important kernel regions.
> -	 */
> -	MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
> -	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
> -			(EFI_VA_END & PGDIR_MASK));
> -
>  	pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
>  	pgd_k = pgd_offset_k(PAGE_OFFSET);
>  
>  	num_entries = pgd_index(EFI_VA_END) - pgd_index(PAGE_OFFSET);
>  	memcpy(pgd_efi, pgd_k, sizeof(pgd_t) * num_entries);
>  
> -	/*
> -	 * As with PGDs, we share all P4D entries apart from the one entry
> -	 * that covers the EFI runtime mapping space.
> -	 */
> -	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> -
>  	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>  	pgd_k = pgd_offset_k(EFI_VA_END);
>  	p4d_efi = p4d_offset(pgd_efi, 0);
> -- 
> 2.29.2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
