Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2D1ECC47
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFCJPS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 05:15:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:56023 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJPR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 05:15:17 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0539Esbh002122;
        Wed, 3 Jun 2020 18:14:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0539Esbh002122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591175695;
        bh=WkoRi0qcjL+OLowdteLADl1qLtuJ/HWKEwgYQ6avQCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dYypLwI5VjQUrI5LksJCjHXku7K8+GfBch/gpzjz8Bc1ZMIJ2A88Pu/iPLwGSCTC2
         nwRqUpQypKZh01nqso6TX1Jv1fZ8AMvyr6JOSDVB2Hch82w3M6gRHh50183kBDjprR
         RdLXcvOW8hdDnzK6cqIN1WU0UnczU6yiMzixRAhMvEnhSaz/IjT21SN6tECnUK1ePW
         dIgKI/YoN6s58Z7ewLX5mdZ7GAa3EVrf5HM+vhtpD+ektPrIT8KqUXl/rAOnhXAXz6
         0yjV5aGTDXCOvN8LqOqVyjXS5oSGxeQs+GBtgpbfcUTAWjr2LHNluSZtzgugtOycIl
         JiakT9Wi2zDpA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id g44so267083uae.12;
        Wed, 03 Jun 2020 02:14:54 -0700 (PDT)
X-Gm-Message-State: AOAM530q7+vWyRGbG55k1s51fffcsNT/YsW3iHYuwrFmQKQQmGPHZ3aP
        270P2MJ8EIUktstArK18ZPOkNZmBeK+F5tyM7Zc=
X-Google-Smtp-Source: ABdhPJxqjJvbzrt0CAQOlW8LZFKbwA7XaE4Gc9qWM6Yt1XDz6danBHRdw4t3FweVQDQxJj8eB0foP/gnapLgrxtEAX4=
X-Received: by 2002:a9f:3791:: with SMTP id q17mr82429uaq.95.1591175693496;
 Wed, 03 Jun 2020 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org>
 <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
 <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
 <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
 <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com> <CAMj1kXFKuMoYW8Sj=DHeYBSkWyeu+QgP9=fgET83K5D=-DsJ7Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFKuMoYW8Sj=DHeYBSkWyeu+QgP9=fgET83K5D=-DsJ7Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Jun 2020 18:14:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3YqmSWh_GkXdP+2tb83sOpySeXVi-kP=1eehcD5097Q@mail.gmail.com>
Message-ID: <CAK7LNAR3YqmSWh_GkXdP+2tb83sOpySeXVi-kP=1eehcD5097Q@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 3, 2020 at 6:02 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 3 Jun 2020 at 10:59, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Jun 3, 2020 at 5:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 3 Jun 2020 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > >
> > > > > > Documentation/kbuild/makefiles.rst says:
> > > > > >
> > > > > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > > > > >
> > > > > > I want to disallow lib-y outside of them.
> > > > > >
> > > > >
> > > > > Why?
> > > >
> > > >
> > > > Because I plan to remove lib-y entirely at some point.
> > > >
> > > > lib-y is not so useful to shrink the image size because:
> > > >
> > > >   - An object in lib.a can be omitted only when no symbol
> > > >     in that object is referenced.  This rarely happens.
> > > >
> > > >   -  lib-y objects are often exported by nature
> > > >      because lib-y is a collection of utility functions.
> > > >      Even if no in-tree user, we always need to keep them
> > > >      because EXPORT_SYMBOL() is the interface to modules.
> > > >
> > > >
> > > > When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> > > > I made some research.
> > > >
> > > > The benefit of lib-y is just 362 byte for x86_64_defconfig.
> > > > ( Before: 26578002, After: 26578364)
> > > >
> > > > My hope is lib-y will be replaced by dead-code elimination or
> > > > ultimately by LTO.
> > > >
> > > > drivers/firmware/efi/libstub/Makefile
> > > > is the only Makefile that breaks the rule:
> > > > "Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > > Add a custom rule to build lib.a, which is linked to the decompressor
> > > > > > for ARCH=x86, ARCH=arm.
> > > > > >
> > > > > > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > > > > > way.
> > > > > >
> > > > >
> > > > > The code works perfectly fine as is, and I don't see what is
> > > > > fundamentally wrong with using static libraries outside of lib/ and
> > > > > arch/*/lib.
> > > >
> > > > The intended usage of lib-y is to hook lib.a
> > > > to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.
> > > >
> > > > This Makefile is just what you found to work.
> > > >
> > > >
> > > > >
> > > > > Also, I would like this code to still be incorporated as a static
> > > > > library into arm64 as well, so that only pieces that are actually
> > > > > needed are incorporated into the final image.
> > > >
> > > > No.
> > > > It is not working like that because you set
> > > > lib.a to core-y.
> > > >
> > > > All objects in core-y are always linked to vmlinux.
> > > >
> > >
> > > The lib.a file is passed to the linker as a static library, so it will
> > > only grab what it needs.
> > >
> > > For instance, if you build arm64 from mainline today, the
> > > efi_relocate_kernel will not be in the final image, even though it is
> > > built as part of libstub
> >
> >
> > I built today's mainline kernel
> > (d6f9469a03d832dcd17041ed67774ffb5f3e73b3).
> >
> >
> > I see it in vmlinux.
> >
> >
> > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  defconfig
> > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  -j24
> >     ...
> > $ aarch64-linux-gnu-nm  -n  vmlinux | grep  efi_relocate_kernel
> > ffff8000114afb90 t __efistub_efi_relocate_kernel
> >
>
> That is strange. I tested this before, and it worked.
>
> Did anything change recently in the way the linker is invoked?


Nothing recently.

This is obvious result because
drivers/firmware/efi/libstub/lib.a
is passed after ----whole-archive flag.


I guess the following commit is it,
but it is already 3 years ago.



commit 799c43415442414b1032580c47684cb709dfed6d (HEAD)
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Fri Jun 9 15:24:17 2017 +1000

    kbuild: thin archives make default for all archs

    Make thin archives build the default, but keep the config option
    to allow exemptions if any breakage can't be quickly solved.

    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>









-- 
Best Regards
Masahiro Yamada
