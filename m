Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF977282B1F
	for <lists+linux-efi@lfdr.de>; Sun,  4 Oct 2020 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJDOOX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 4 Oct 2020 10:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJDOOX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 4 Oct 2020 10:14:23 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D48120797;
        Sun,  4 Oct 2020 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601820862;
        bh=BeZ+t1FaWcSp8llMlNWxjq6hsTDD7cM2+51ZXd0TNe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P945UFAVftkGTq4bL2DRzNel4cJkVWsAcj0U6NZ/p0ct7Npzsu/lJrlCsRbtGZZhT
         p/c9XcxxgyHRfDskTczq+rfvQJEjR2I4PsHSQ9DRC1kQo5l7lQsPNkY2MgXBIylxhN
         TDCC/zKtxb6P+8zVVBCkUFWTMAKUc1zu4tL0tO0M=
Received: by mail-oi1-f174.google.com with SMTP id n2so6184039oij.1;
        Sun, 04 Oct 2020 07:14:22 -0700 (PDT)
X-Gm-Message-State: AOAM530u08PqQ27SmzIAqhzRoh6l50M08TBWlj9CtMj/eYWEjK9umB7L
        HxOKXsYaLeZpeB7Xnjamy357piwmivmIEHr9/gw=
X-Google-Smtp-Source: ABdhPJw8WWdLN5gs0gIeuLxP+YWDwTgvEXQwnRC29EAFxroOLg6jS4rJpnnfdyW8i5qoW0MPoQIm6n2csYGbkDcN6Mg=
X-Received: by 2002:aca:d845:: with SMTP id p66mr5718315oig.47.1601820861944;
 Sun, 04 Oct 2020 07:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201003060356.4913-1-xypron.glpk@gmx.de> <CAMzpN2hZ6833u4P=Vr1hueoYCfYryHoTW1dpa-9FTL3nvehJ0A@mail.gmail.com>
 <20201003194429.GA768061@rani.riverdale.lan>
In-Reply-To: <20201003194429.GA768061@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 4 Oct 2020 16:14:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHW-WSYM+dDJObsG6EL4WXHqmqpRfwLqG3hs4NO2wC=-w@mail.gmail.com>
Message-ID: <CAMj1kXHW-WSYM+dDJObsG6EL4WXHqmqpRfwLqG3hs4NO2wC=-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub/x86: simplify efi_is_native()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 3 Oct 2020 at 21:44, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Oct 03, 2020 at 01:28:18PM -0400, Brian Gerst wrote:
> > On Sat, Oct 3, 2020 at 2:05 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > CONFIG_EFI_MIXED depends on CONFIG_X86_64=y.
> > > There is no need to check CONFIG_X86_64 again.
> > >
> > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > ---
> > >  arch/x86/include/asm/efi.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index b9c2667ac46c..ab28bf1c74cf 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -223,8 +223,6 @@ static inline bool efi_is_64bit(void)
> > >
> > >  static inline bool efi_is_native(void)
> > >  {
> > > -       if (!IS_ENABLED(CONFIG_X86_64))
> > > -               return true;
> > >         return efi_is_64bit();
> > >  }
> >
> > This would then return false for native 32-bit.
> >
> > --
> > Brian Gerst
>
> 32-bit doesn't use this implementation: it's #define'd to true in
> drivers/firmware/efi/libstub/efistub.h.
>

Yes, and the reason this [now redundant] test exists is because this
did not use to be the case before

de8c55208c386 efi/libstub: Fix mixed mode boot issue after macro refactor

So for this patch

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I'll queue this up
