Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8E2F851F
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbhAOTIf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 14:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbhAOTIf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 14:08:35 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B97C0613C1;
        Fri, 15 Jan 2021 11:07:55 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c1so6806426qtc.1;
        Fri, 15 Jan 2021 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VFAEqW7kc3cIpTfEOGsqZWNF/6PRxbAffbJEVT5A/E=;
        b=h91vSr45JPkDC8BQ98q5pPfz0/KPLGI+bPBFlU40WOKHp6RZOB7rrnOHCAuD6sE9/7
         XNNuqR5GhgkLG2+dO5hozC2WYoarwqjq9I8f+XvzeUufSyxd3J2QLAOrHOUZFUYMULkO
         tQ2YFMwfg391KHMVIoD1TcAncsQoRjgGKIHxbvHpRwAyUboVP/8PF6Il5RraYpuaPGnC
         NVyTg//2WiJsqU7pi3VLDp+pKlexkooQn4o3ZXJFtyZlq4NsY8n26XvUTDPGf3Zk0Bh1
         L2GaZQZZN0cHOmnNhJMBxZhPlf0OlWamlfguKi5UxfKfxOaRhBWymDpmA9VzZ+6ehtn5
         HM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6VFAEqW7kc3cIpTfEOGsqZWNF/6PRxbAffbJEVT5A/E=;
        b=sR0iUy8EJDbutFlM1R0+YSm9TSadb7uH2xOlBuNqxs792JJowYfHSuDvtt9zvI6Hpl
         WpgY9SSGlKNhqStJWGK0DWoFGgDp915Bi3WY3NSHTZTsiaOdr+TkCLq4Onk4aXc0pD14
         rYSH4ep6mhVzOVK/veN6UVWQ9mW6dU+9dCmeqXYoZPTA1FfpkjWe74dmbgSQXuhIhrcd
         Md1nY+JYuGTyAmcoChk84divICEp2srD+wDMmD/k0W2+CyAgS8G1BNqssyrXhC3WCr1G
         9Ti3FKhtM6pTKAV9Tp7XTxqwoRigpuig2rkQRdVKlKbXQKaCs7qw+MQIrWwV5ylTHPbr
         y4qA==
X-Gm-Message-State: AOAM531HlF1D4Xem7Z4+LnRKboqrduM4u4+fL9LmoIJ3KT5k3OIb2n1I
        X4A/fWoAEMjdHrWS9W2qfmuWi2Ovi5k1YA==
X-Google-Smtp-Source: ABdhPJwz2eIlnQsES5pTpIu/GiTH3dBOJ+x2rZKEDPIlF3F2QMEWYphovpJ8fAM1ipJjVvxQWhhc9w==
X-Received: by 2002:ac8:6f41:: with SMTP id n1mr13036465qtv.170.1610737674080;
        Fri, 15 Jan 2021 11:07:54 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k42sm5469974qtk.17.2021.01.15.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:07:53 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 15 Jan 2021 14:07:51 -0500
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107223424.4135538-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> 
> x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
> 
> Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> so it only triggers for constant input.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/256
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/platform/efi/efi_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..62bb1616b4a5 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
>  	 * As with PGDs, we share all P4D entries apart from the one entry
>  	 * that covers the EFI runtime mapping space.
>  	 */
> -	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> +	MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> +	MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
>  
>  	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>  	pgd_k = pgd_offset_k(EFI_VA_END);
> -- 
> 2.29.2
> 

I think this needs more explanation as to why clang is triggering this.
The issue mentions clang not inline p4d_index(), and I guess not
performing inter-procedural analysis either?

For the second assertion there, everything is always constant AFAICT:
EFI_VA_START, EFI_VA_END and P4D_MASK are all constants regardless of
CONFIG_5LEVEL.

For the first assertion, it isn't technically constant, but if
p4d_index() gets inlined, the compiler should be able to see that the
two are always equal, even though ptrs_per_p4d is not constant:
	EFI_VA_END >> 39 == MODULES_END >> 39
so the masking with ptrs_per_p4d-1 doesn't matter for the comparison.

As a matter of fact, it seems like the four assertions could be combined
into:
	BUILD_BUG_ON((EFI_VA_END & P4D_MASK) != (MODULES_END & P4D_MASK));
	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
instead of separately asserting they're the same PGD entry and the same
P4D entry.

Thanks.
