Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20A2FCED6
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhATLIi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388860AbhATLGu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 06:06:50 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D82C0613C1
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 03:06:04 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b10so25558340ljp.6
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1Mh46vTv3FVcofbpZz88mBZexF8yUI1mlf2fsLkouw=;
        b=j0j2tuot0ZyMl0f0aOTmS1p3g69+9BZIF/gAMmgopBTpUJo1be77vcPSKipxp8VuMS
         V2CLqZVAh7hr5LB1u7M2uGGi2E99l8jikfPZR6dCz5Fi54Vb6dfKkUZMFgD40mFeJJ1G
         /2y3WTS6DGwh3kJrNXQLTDUMGDHtOBD0W4nl3G+NhkeMqAuyJw3HxxwFVu/aFX9heV5E
         mXjNez5p3kWGj2yal+Er7BTSyJucs1EcqDUr7HQvwwSwdJ30gJsIonpcF/d21PUlGbM+
         Vj7ndfDZi4bzRIQ8HfmtZZ18AWN/gHwp1Rk8bP1UIBjCMwVDGaqQWmAJ+ESRWHjXnLhZ
         8ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1Mh46vTv3FVcofbpZz88mBZexF8yUI1mlf2fsLkouw=;
        b=mNkbNjU2aStA3YN6Xq1YKv9PguQLWIX5gyuho9jn6m3Thqa5J84+l6OdsL1eVsoigl
         SOXUSga1wm7ofUCdZWY3FfeJ71AW2EkyHn7SpRwor+W9c4VGgbVQ4/vZeC1TGu/ynWs6
         bQoqjKWo4cE3Zkh0Ywg5hJzFu9iyHatJalLzZBo0/DjIhslUDU34etUzwuCxNsT095ZI
         PdM8Acv72yAB/viBW0lpNQgtTTCjQAGv2Wk2pv3hbnEbh5cEcl3RuGqEESDuu9NAsvBy
         GoSs7+zXX0SLw27HcoomCp94R0VjYsW6XdlPgkyNedlUDwGHlwynFPIXXJbzJ5dapHbV
         LJJw==
X-Gm-Message-State: AOAM533MSN0wkRib/GCwC0YsJtNabkwDUtsHlJq/o3XsVim84gt5qICT
        DeHFjsACxL3AN8oZtiYCVHU6VQ==
X-Google-Smtp-Source: ABdhPJzz3stL3qgRP0uFaLHTmDT1cPuT8G/tCqJC+Fwyrc05DxgNHDgvEFOCj/MvYyooHjZq/6gmJQ==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr3310189ljj.7.1611140762858;
        Wed, 20 Jan 2021 03:06:02 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q3sm178375ljp.108.2021.01.20.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 03:06:01 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AA3C5101448; Wed, 20 Jan 2021 14:06:04 +0300 (+03)
Date:   Wed, 20 Jan 2021 14:06:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
Message-ID: <20210120110604.bms6yjoiluojj4x4@box>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Back in the days BUILD_BUG_ON() false-triggered on GCC-4.8 as well. 

-- 
 Kirill A. Shutemov
