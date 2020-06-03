Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D581ECC13
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCJAC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 05:00:02 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19820 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJAB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 05:00:01 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0538xbsc016465;
        Wed, 3 Jun 2020 17:59:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0538xbsc016465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591174778;
        bh=BToKRSuqkTAHEhOluVCemoRUXQFRflh7iXAOaCDFqDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FLfVGAkSFvmX4f0H0OwIZ01V6Rghgg5hAYS5O3ZtE3TnrUpC0YX2+IYBzH9CuHnPI
         NZMOmHjbAkHQQ4MV72eIXGiHUKegQFoBCVF00hJsllpGx+fFmIvTnKVmVqkYSgb8h4
         T4pGfc5xJKajBV6DfyKpRueTbF3H3hz5BKHREKQJtOM0owrnBDg1ZbbOvfkEqOl8NT
         wWIYEiOZyI8FvVjlCCLdnZhdpoKJOE1yNPB3MPxWk+veJbe4/28UNbhJ2Z1dAp+Hqx
         renDemBu6xtoQnq4GROmljfqBE23Z/WiMo+TVNrnad1aIZ6tYCT+nlw2yQqe5gx5qI
         FcVBJ0V+NyAxw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id e1so294955vkd.1;
        Wed, 03 Jun 2020 01:59:37 -0700 (PDT)
X-Gm-Message-State: AOAM531S89qIGmHxgSvNchPZNo64WgzpndMgR5ZJ6oAP/y2l0dWACuZm
        ORVHv4FL8fFOj+dimMi2YYCe8UJDMkBQ3OFZaE8=
X-Google-Smtp-Source: ABdhPJycaZq2XSioO8P5Rjgff4124TzlUNyq/IolCVGqFaH8nhVP9patSbf2c9j51QnlTWR7VLCU710cJW3wUTKf/gE=
X-Received: by 2002:ac5:cc7a:: with SMTP id w26mr10349581vkm.12.1591174776419;
 Wed, 03 Jun 2020 01:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org>
 <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
 <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com> <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
In-Reply-To: <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Jun 2020 17:59:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com>
Message-ID: <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com>
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

On Wed, Jun 3, 2020 at 5:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 3 Jun 2020 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > Documentation/kbuild/makefiles.rst says:
> > > >
> > > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > > >
> > > > I want to disallow lib-y outside of them.
> > > >
> > >
> > > Why?
> >
> >
> > Because I plan to remove lib-y entirely at some point.
> >
> > lib-y is not so useful to shrink the image size because:
> >
> >   - An object in lib.a can be omitted only when no symbol
> >     in that object is referenced.  This rarely happens.
> >
> >   -  lib-y objects are often exported by nature
> >      because lib-y is a collection of utility functions.
> >      Even if no in-tree user, we always need to keep them
> >      because EXPORT_SYMBOL() is the interface to modules.
> >
> >
> > When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> > I made some research.
> >
> > The benefit of lib-y is just 362 byte for x86_64_defconfig.
> > ( Before: 26578002, After: 26578364)
> >
> > My hope is lib-y will be replaced by dead-code elimination or
> > ultimately by LTO.
> >
> > drivers/firmware/efi/libstub/Makefile
> > is the only Makefile that breaks the rule:
> > "Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"
> >
> >
> >
> >
> > >
> > > > Add a custom rule to build lib.a, which is linked to the decompressor
> > > > for ARCH=x86, ARCH=arm.
> > > >
> > > > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > > > way.
> > > >
> > >
> > > The code works perfectly fine as is, and I don't see what is
> > > fundamentally wrong with using static libraries outside of lib/ and
> > > arch/*/lib.
> >
> > The intended usage of lib-y is to hook lib.a
> > to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.
> >
> > This Makefile is just what you found to work.
> >
> >
> > >
> > > Also, I would like this code to still be incorporated as a static
> > > library into arm64 as well, so that only pieces that are actually
> > > needed are incorporated into the final image.
> >
> > No.
> > It is not working like that because you set
> > lib.a to core-y.
> >
> > All objects in core-y are always linked to vmlinux.
> >
>
> The lib.a file is passed to the linker as a static library, so it will
> only grab what it needs.
>
> For instance, if you build arm64 from mainline today, the
> efi_relocate_kernel will not be in the final image, even though it is
> built as part of libstub


I built today's mainline kernel
(d6f9469a03d832dcd17041ed67774ffb5f3e73b3).


I see it in vmlinux.


$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  defconfig
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  -j24
    ...
$ aarch64-linux-gnu-nm  -n  vmlinux | grep  efi_relocate_kernel
ffff8000114afb90 t __efistub_efi_relocate_kernel



-- 
Best Regards
Masahiro Yamada
