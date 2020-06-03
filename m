Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD971ECE34
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFCLXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 07:23:24 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:43038 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgFCLXY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 07:23:24 -0400
X-Greylist: delayed 20948 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 07:23:22 EDT
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 053BN7w1017145;
        Wed, 3 Jun 2020 20:23:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 053BN7w1017145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591183388;
        bh=xjRCifcSCtm0rrzAoDGYByWsSKjvtSoXdERdT8toBEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F2d5LUtktqMzfbhWZOP7Lm2J3Hvl0Ltg7C0RSlrjhnowuIIQoQ5sNAzk4pJdUPt4J
         QX6TiObzeoVq9AiskuvUBVy7/uZGka2XRVtKpU3SGexvBs2s7phSDFQcmihtyPzbqI
         spy1IqvX++M97ARBlmNVZ0DuHWbi0C5iu7jI3BscFawBbSB0r6ZCXotxi7MxdE/nXc
         cu3jmQ1bTXg6cD76j4jb7K0vMhKK6hZROmEM23gRRSPk1Rh59vHs9ixxqI9xHuvy8Q
         PAxsndZLFN3h/kJ2qDXJyeo700LrNAhPJwwHtRLm+KuWDARVup20SKGV+g8xXtmt90
         refORrn4IwAhw==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id w20so714995uaa.2;
        Wed, 03 Jun 2020 04:23:07 -0700 (PDT)
X-Gm-Message-State: AOAM532o86d7dohfR3RxrMwxgmu7MXPwUlHUxyIN51Dq9sjKJ39ugAXd
        zhsM190vXFj09Q8tN/nb9Mv7ENimiD9vSaUdV0E=
X-Google-Smtp-Source: ABdhPJwM2bnRdGpy1EPn6Efl/rptchM35rdOn8jA4NCkq5d1S8uIE7q2Gpun2IB6EFvGLZVxNpl6kJ0r2Fg7nnWTl1U=
X-Received: by 2002:a9f:2204:: with SMTP id 4mr21662596uad.40.1591183386891;
 Wed, 03 Jun 2020 04:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org>
 <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
 <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
 <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
 <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com>
 <CAMj1kXFKuMoYW8Sj=DHeYBSkWyeu+QgP9=fgET83K5D=-DsJ7Q@mail.gmail.com>
 <CAK7LNAR3YqmSWh_GkXdP+2tb83sOpySeXVi-kP=1eehcD5097Q@mail.gmail.com> <CAMj1kXHcRuQXPej9_H_jnno516BnuFrPRqzp1+6xN-odckEMJg@mail.gmail.com>
In-Reply-To: <CAMj1kXHcRuQXPej9_H_jnno516BnuFrPRqzp1+6xN-odckEMJg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Jun 2020 20:22:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_YMfjucip8eFBod1TBMUqGgnYebBeP22dZ4J7ZsFXeg@mail.gmail.com>
Message-ID: <CAK7LNAQ_YMfjucip8eFBod1TBMUqGgnYebBeP22dZ4J7ZsFXeg@mail.gmail.com>
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

On Wed, Jun 3, 2020 at 6:16 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 3 Jun 2020 at 11:15, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Jun 3, 2020 at 6:02 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 3 Jun 2020 at 10:59, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 3, 2020 at 5:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 3 Jun 2020 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Documentation/kbuild/makefiles.rst says:
> > > > > > > >
> > > > > > > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > > > > > > >
> > > > > > > > I want to disallow lib-y outside of them.
> > > > > > > >
> > > > > > >
> > > > > > > Why?
> > > > > >
> > > > > >
> > > > > > Because I plan to remove lib-y entirely at some point.
> > > > > >
> > > > > > lib-y is not so useful to shrink the image size because:
> > > > > >
> > > > > >   - An object in lib.a can be omitted only when no symbol
> > > > > >     in that object is referenced.  This rarely happens.
> > > > > >
> > > > > >   -  lib-y objects are often exported by nature
> > > > > >      because lib-y is a collection of utility functions.
> > > > > >      Even if no in-tree user, we always need to keep them
> > > > > >      because EXPORT_SYMBOL() is the interface to modules.
> > > > > >
> > > > > >
> > > > > > When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> > > > > > I made some research.
> > > > > >
> > > > > > The benefit of lib-y is just 362 byte for x86_64_defconfig.
> > > > > > ( Before: 26578002, After: 26578364)
> > > > > >
> > > > > > My hope is lib-y will be replaced by dead-code elimination or
> > > > > > ultimately by LTO.
> > > > > >
> > > > > > drivers/firmware/efi/libstub/Makefile
> > > > > > is the only Makefile that breaks the rule:
> > > > > > "Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > Add a custom rule to build lib.a, which is linked to the decompressor
> > > > > > > > for ARCH=x86, ARCH=arm.
> > > > > > > >
> > > > > > > > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > > > > > > > way.
> > > > > > > >
> > > > > > >
> > > > > > > The code works perfectly fine as is, and I don't see what is
> > > > > > > fundamentally wrong with using static libraries outside of lib/ and
> > > > > > > arch/*/lib.
> > > > > >
> > > > > > The intended usage of lib-y is to hook lib.a
> > > > > > to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.
> > > > > >
> > > > > > This Makefile is just what you found to work.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Also, I would like this code to still be incorporated as a static
> > > > > > > library into arm64 as well, so that only pieces that are actually
> > > > > > > needed are incorporated into the final image.
> > > > > >
> > > > > > No.
> > > > > > It is not working like that because you set
> > > > > > lib.a to core-y.
> > > > > >
> > > > > > All objects in core-y are always linked to vmlinux.
> > > > > >
> > > > >
> > > > > The lib.a file is passed to the linker as a static library, so it will
> > > > > only grab what it needs.
> > > > >
> > > > > For instance, if you build arm64 from mainline today, the
> > > > > efi_relocate_kernel will not be in the final image, even though it is
> > > > > built as part of libstub
> > > >
> > > >
> > > > I built today's mainline kernel
> > > > (d6f9469a03d832dcd17041ed67774ffb5f3e73b3).
> > > >
> > > >
> > > > I see it in vmlinux.
> > > >
> > > >
> > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  defconfig
> > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  -j24
> > > >     ...
> > > > $ aarch64-linux-gnu-nm  -n  vmlinux | grep  efi_relocate_kernel
> > > > ffff8000114afb90 t __efistub_efi_relocate_kernel
> > > >
> > >
> > > That is strange. I tested this before, and it worked.
> > >
> > > Did anything change recently in the way the linker is invoked?
> >
> >
> > Nothing recently.
> >
> > This is obvious result because
> > drivers/firmware/efi/libstub/lib.a
> > is passed after ----whole-archive flag.
> >
> >
> > I guess the following commit is it,
> > but it is already 3 years ago.
> >
>
> Right.
>
> So that means there is no point at all in using static libraries, no?
> Or does --whole-archive still allow duplicate definitions like static
> libraries do usually?


--whole-archive literally links the whole of the archive.
If there are duplicate definitions, the linking fails
due to multiple definition.
So, --whole-archive is similar to linking .o files
in this regard.


There is a point for arm and x86 because
the decompressor link does not use --whole-archive.

As for arm64, there is no point,
but you can pass lib.a after --no-whole-archive
by the following patch.

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 650e1185c190..48a6afa774fc 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -145,7 +145,7 @@ export      TEXT_OFFSET

 core-y         += arch/arm64/
 libs-y         := arch/arm64/lib/ $(libs-y)
-core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

 # Default target when executing plain make
 boot           := arch/arm64/boot



Then, _efistub_efi_low_alloc_above
and __efistub_efi_relocate_kernel will be dropped.


If you like the static library
do you want me to send v2?


-- 
Best Regards
Masahiro Yamada
