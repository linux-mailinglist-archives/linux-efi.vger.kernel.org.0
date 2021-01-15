Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7B2F86A8
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbhAOU2N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 15:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbhAOU2M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 15:28:12 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC53C061757;
        Fri, 15 Jan 2021 12:27:31 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p14so12975487qke.6;
        Fri, 15 Jan 2021 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CsV/iFRWRwPOUl0iQrws3dbcpd1hk5l9ouGWD9Hf1Sk=;
        b=EJnALcB5lj6O8EwGaeS3B5wt9S+EdFoBjFkx9rELz9GHY6sXIRSrhOiHcbLYwokcyw
         y10dupeBmljlx4g2BHsp43lVJtwxBjk6BhsDGODhF4xBtZvZ+XQBJB4APy3/PaKTi31N
         udy37S0bJYcXXGhjHa57yYiasOC9Zl6RGj7tleJeMkMDS/p0CLrlS78YWgFknniiId4D
         NiabI9s7iPId2ATopIjjsaWA1EcKXOZPtK0t6ijlcpYDJnYYXnodYN4a663hGmyU2r1j
         xGDX0N3s9GRn9MGEZoI4SRZKQxXV3XQtIltEwdOcoei5co7899j5SGgrwjeJ3fgBdCxj
         lvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CsV/iFRWRwPOUl0iQrws3dbcpd1hk5l9ouGWD9Hf1Sk=;
        b=BhLuhVuidBl3ICB1U/F21AwQ3PpHspUJuWl7rp97y9R5Hr9UvqVUS0xtRHN1RYoN5f
         +SSbSYLv4GLoxzCx/74njq1+24P1n765w2Y4pFy/blq/u6bjQxxfRUDBTDI5J/gRmaUi
         v0UPYS05dsIjVHMDaaVSMBX79PaKb6Pg21GTCPi0W7DMOPL+8EZnf1ruMKw8aOlBGaiI
         s5dXwS9kY7KOr/oLWd6rUHbJ3AF4PQDS1U2Eyb5WILRTTqv41sGdK6iVs9wqxVsrYepK
         VkKgnRYKrgipLXp/HRH6mFTARuJM3m0RZti9V2VM7CEzAD5+L+Z/55hzlXP+CwcZamA1
         VvNA==
X-Gm-Message-State: AOAM530wZ5f0AzhkRVA8hG7kN6JA+y92PeE0jatrual5xT4iCQnshgjg
        0EREqWicECIPz77unDMNBPw=
X-Google-Smtp-Source: ABdhPJzen+uv9TTJ9KKS9JD1CEBlxMUDg02sne8T2aY8ZiuvT53kiMWAxRrq5MhAhsuG03u/Qjelqw==
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr14063530qko.269.1610742450197;
        Fri, 15 Jan 2021 12:27:30 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m8sm5693893qkh.21.2021.01.15.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:27:29 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 15 Jan 2021 15:27:27 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <YAH6r3lak/F2wndp@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 02:07:51PM -0500, Arvind Sankar wrote:
> On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> > 
> > x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> > efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
> > 
> > Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> > and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> > so it only triggers for constant input.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/256
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/x86/platform/efi/efi_64.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > index e1e8d4e3a213..62bb1616b4a5 100644
> > --- a/arch/x86/platform/efi/efi_64.c
> > +++ b/arch/x86/platform/efi/efi_64.c
> > @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
> >  	 * As with PGDs, we share all P4D entries apart from the one entry
> >  	 * that covers the EFI runtime mapping space.
> >  	 */
> > -	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > -	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > +	MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > +	MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> >  
> >  	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
> >  	pgd_k = pgd_offset_k(EFI_VA_END);
> > -- 
> > 2.29.2
> > 
> 
> I think this needs more explanation as to why clang is triggering this.
> The issue mentions clang not inline p4d_index(), and I guess not
> performing inter-procedural analysis either?
> 
> For the second assertion there, everything is always constant AFAICT:
> EFI_VA_START, EFI_VA_END and P4D_MASK are all constants regardless of
> CONFIG_5LEVEL.
> 
> For the first assertion, it isn't technically constant, but if
> p4d_index() gets inlined, the compiler should be able to see that the
> two are always equal, even though ptrs_per_p4d is not constant:
> 	EFI_VA_END >> 39 == MODULES_END >> 39
> so the masking with ptrs_per_p4d-1 doesn't matter for the comparison.
> 
> As a matter of fact, it seems like the four assertions could be combined
> into:
> 	BUILD_BUG_ON((EFI_VA_END & P4D_MASK) != (MODULES_END & P4D_MASK));
> 	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> instead of separately asserting they're the same PGD entry and the same
> P4D entry.
> 
> Thanks.

I actually don't quite get the MODULES_END check -- Ard, do you know
what that's for?

What we really should be checking is that EFI_VA_START is in the top-most
PGD entry and the top-most P4D entry, since we only copy PGD/P4D entries
before EFI_VA_END, but not after EFI_VA_START. So the checks should
really be
	BUILD_BUG_ON(((EFI_VA_START - 1) & P4D_MASK) != (-1ul & P4D_MASK));
	BUILD_BUG_ON(((EFI_VA_START - 1) & P4D_MASK) != (EFI_VA_END & P4D_MASK));
imo. I guess that's what using MODULES_END is effectively checking, but
it would be clearer to check it directly.
