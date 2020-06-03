Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4B1ECBB9
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCIpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 04:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCIpY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Jun 2020 04:45:24 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AB92074B;
        Wed,  3 Jun 2020 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591173923;
        bh=cblJEWAd3DPBh04Tlvi8BcWOqhwYMzDqk94d+BenPsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JMMp8Ma1HO/w/A4xLIz/t4cDUfnR9e6+1nfkhAszV/2t7s5h2fFOHOWb5WhGNIVww
         HlDhJJr2T/2K1hDog0MaSCnEnalnWwGta927B0xxNxUBzO38h+iAKd2gjX8L/qSCg6
         T77Fw9B1pB9+weIlI0CutbQ8W7oT1wSKDmnpUmIk=
Received: by mail-ot1-f43.google.com with SMTP id b18so1281469oti.1;
        Wed, 03 Jun 2020 01:45:23 -0700 (PDT)
X-Gm-Message-State: AOAM531oZN/gcuD3wfWmocPmxYLOYYIXle7IE2FwRUMFYasDNB31kidR
        zuneZdDlmnToPYnMv3EFk7kxaD7TNsx53A7EjMg=
X-Google-Smtp-Source: ABdhPJzoqH82vfddBcZ2ilJNSYyw2hykyw6p+iOltpxefWYgGi1NHuWQjSjLS+b1Ow7vhgSqC6IYHofRPCZ/ijqKzNE=
X-Received: by 2002:a9d:7684:: with SMTP id j4mr1249171otl.108.1591173922903;
 Wed, 03 Jun 2020 01:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org>
 <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com> <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
In-Reply-To: <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Jun 2020 10:45:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
Message-ID: <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Masahiro Yamada <masahiroy@kernel.org>
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

On Wed, 3 Jun 2020 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Documentation/kbuild/makefiles.rst says:
> > >
> > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > >
> > > I want to disallow lib-y outside of them.
> > >
> >
> > Why?
>
>
> Because I plan to remove lib-y entirely at some point.
>
> lib-y is not so useful to shrink the image size because:
>
>   - An object in lib.a can be omitted only when no symbol
>     in that object is referenced.  This rarely happens.
>
>   -  lib-y objects are often exported by nature
>      because lib-y is a collection of utility functions.
>      Even if no in-tree user, we always need to keep them
>      because EXPORT_SYMBOL() is the interface to modules.
>
>
> When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> I made some research.
>
> The benefit of lib-y is just 362 byte for x86_64_defconfig.
> ( Before: 26578002, After: 26578364)
>
> My hope is lib-y will be replaced by dead-code elimination or
> ultimately by LTO.
>
> drivers/firmware/efi/libstub/Makefile
> is the only Makefile that breaks the rule:
> "Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"
>
>
>
>
> >
> > > Add a custom rule to build lib.a, which is linked to the decompressor
> > > for ARCH=x86, ARCH=arm.
> > >
> > > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > > way.
> > >
> >
> > The code works perfectly fine as is, and I don't see what is
> > fundamentally wrong with using static libraries outside of lib/ and
> > arch/*/lib.
>
> The intended usage of lib-y is to hook lib.a
> to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.
>
> This Makefile is just what you found to work.
>
>
> >
> > Also, I would like this code to still be incorporated as a static
> > library into arm64 as well, so that only pieces that are actually
> > needed are incorporated into the final image.
>
> No.
> It is not working like that because you set
> lib.a to core-y.
>
> All objects in core-y are always linked to vmlinux.
>

The lib.a file is passed to the linker as a static library, so it will
only grab what it needs.

For instance, if you build arm64 from mainline today, the
efi_relocate_kernel will not be in the final image, even though it is
built as part of libstub
