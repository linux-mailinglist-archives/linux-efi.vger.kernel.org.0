Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475AB2F8E1C
	for <lists+linux-efi@lfdr.de>; Sat, 16 Jan 2021 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbhAPRGL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Jan 2021 12:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbhAPQfU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 Jan 2021 11:35:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D19207C5;
        Sat, 16 Jan 2021 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610814879;
        bh=aH136bRk4cKdS8/17ekFrHN1qCL194ImwlzjMMmIfrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UTwCnHtVRR2JZJ0ZlQUPIfJc5KY1gSl7JfDZBhOIuVmd+R19MeujlQPfpAxVlgWOC
         t/CFSvzgi84drlgws6O5TJOFoDlzmKaABr8NS9WqVAOvxOUaDaYMToQnzKjRB3B9d2
         ci9KPIdfDcx9JBhpFL6aWhN40xHjPs/puojIW/hIRqMvejBz+APwzeYGJDhr+POuiO
         eE2pOF8Hnrmokvl9HJ7rND64ltu347yiMove3zY/M/AJRUzX44QAOJM39x8mL0//ng
         vpdyVMSnudrOp3hoA+oER0HnrkQupblsEknW4aOjhEENeyWAxS5oBmZ+7nrAEfTt7w
         8YVtk+85leHUQ==
Received: by mail-ot1-f46.google.com with SMTP id w3so11793524otp.13;
        Sat, 16 Jan 2021 08:34:39 -0800 (PST)
X-Gm-Message-State: AOAM533Y/qQ0BLuAGtRqPz+61h55FD1uwL43pkJ76aJuinIeQjIhlHeb
        sFItDnm49AbbLbWLokNmpyvRXuGIyC97kwc3Ev4=
X-Google-Smtp-Source: ABdhPJy2VyjRGD23Ym1ssVK/6l47tYsfWMPAWGpQwEzb/frJQCEdtDXfTuYLRevKA2MnCgXof1CL9NsQ/Z/SaP/F0v0=
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr12489782oto.90.1610814879037;
 Sat, 16 Jan 2021 08:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20210107223424.4135538-1-arnd@kernel.org> <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
In-Reply-To: <YAH6r3lak/F2wndp@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 16 Jan 2021 17:34:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
Message-ID: <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 15 Jan 2021 at 21:27, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Jan 15, 2021 at 02:07:51PM -0500, Arvind Sankar wrote:
> > On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> > >
> > > x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> > > efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
> > >
> > > Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> > > and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> > > so it only triggers for constant input.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/256
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/x86/platform/efi/efi_64.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > > index e1e8d4e3a213..62bb1616b4a5 100644
> > > --- a/arch/x86/platform/efi/efi_64.c
> > > +++ b/arch/x86/platform/efi/efi_64.c
> > > @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
> > >      * As with PGDs, we share all P4D entries apart from the one entry
> > >      * that covers the EFI runtime mapping space.
> > >      */
> > > -   BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > > -   BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > > +   MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > > +   MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > >
> > >     pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
> > >     pgd_k = pgd_offset_k(EFI_VA_END);
> > > --
> > > 2.29.2
> > >
> >
> > I think this needs more explanation as to why clang is triggering this.
> > The issue mentions clang not inline p4d_index(), and I guess not
> > performing inter-procedural analysis either?
> >
> > For the second assertion there, everything is always constant AFAICT:
> > EFI_VA_START, EFI_VA_END and P4D_MASK are all constants regardless of
> > CONFIG_5LEVEL.
> >
> > For the first assertion, it isn't technically constant, but if
> > p4d_index() gets inlined, the compiler should be able to see that the
> > two are always equal, even though ptrs_per_p4d is not constant:
> >       EFI_VA_END >> 39 == MODULES_END >> 39
> > so the masking with ptrs_per_p4d-1 doesn't matter for the comparison.
> >
> > As a matter of fact, it seems like the four assertions could be combined
> > into:
> >       BUILD_BUG_ON((EFI_VA_END & P4D_MASK) != (MODULES_END & P4D_MASK));
> >       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> > instead of separately asserting they're the same PGD entry and the same
> > P4D entry.
> >
> > Thanks.
>
> I actually don't quite get the MODULES_END check -- Ard, do you know
> what that's for?
>

Maybe Boris remembers? He wrote the original code for the 'new' EFI
page table layout.


> What we really should be checking is that EFI_VA_START is in the top-most
> PGD entry and the top-most P4D entry, since we only copy PGD/P4D entries
> before EFI_VA_END, but not after EFI_VA_START. So the checks should
> really be
>         BUILD_BUG_ON(((EFI_VA_START - 1) & P4D_MASK) != (-1ul & P4D_MASK));
>         BUILD_BUG_ON(((EFI_VA_START - 1) & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> imo. I guess that's what using MODULES_END is effectively checking, but
> it would be clearer to check it directly.

This obviously needs a comment, but checking that everything lives in
the top 512 GB of the kernel VA space seems sufficient to me,
