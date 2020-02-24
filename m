Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEB16B5BE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 00:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBXXhA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 18:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBXXhA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 18:37:00 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863F721556
        for <linux-efi@vger.kernel.org>; Mon, 24 Feb 2020 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582587418;
        bh=U+C01gpfph6ZPINhoShrAsfsumPsY2cdU2HX5aGn0Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hTGo+EKvwjslJrrG36fYa+RQXI72oMF2wJ41dA2iYXzQtnkv95aGDPs388G+/PFo5
         91lOFDHFHvRqaPcXItgjFjrjUUnhKQDvUx5nwu//zb3QrBW98dp04aLtb0l6msmUtm
         yIPvZ7HFh3xp6rYfG/OfyvJ4fKkSBhN/6+UiNJMo=
Received: by mail-wm1-f54.google.com with SMTP id s144so960731wme.1
        for <linux-efi@vger.kernel.org>; Mon, 24 Feb 2020 15:36:58 -0800 (PST)
X-Gm-Message-State: APjAAAWZ8utsrWtWFoAyFrzniVH02LjCGbY340FvyzNRAYPY44SqUnMy
        EaXUPf8o/yczGxrD+JMimBu8ZXuadfDwrtl7soA9CQ==
X-Google-Smtp-Source: APXvYqyYevqNGK2IFE3HzmOa/V/u4wqkglDMTSogkltLAkBHZotLEGxCZNCh/kYKEP+C1LuXd9JpyCXpSuBin0gw4JE=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr1419151wmf.133.1582587416968;
 Mon, 24 Feb 2020 15:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210160248.4889-1-ardb@kernel.org> <20200210160248.4889-4-ardb@kernel.org>
 <d3402c42836aca94d1a2ff385c088af605578068.camel@wdc.com>
In-Reply-To: <d3402c42836aca94d1a2ff385c088af605578068.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 00:36:45 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9bPsiJLQqsfXwDMNe-VCsVCqDNvZAiCnon18kYG4M9qA@mail.gmail.com>
Message-ID: <CAKv+Gu9bPsiJLQqsfXwDMNe-VCsVCqDNvZAiCnon18kYG4M9qA@mail.gmail.com>
Subject: Re: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source files
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Feb 2020 at 00:15, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Mon, 2020-02-10 at 17:02 +0100, Ard Biesheuvel wrote:
> > Instead of setting the visibility pragma for a small set of symbol
> > declarations that could result in absolute references that we cannot
> > support in the stub, declare hidden visibility for all code in the
> > EFI stub, which is more robust and future proof.
> >
> > To ensure that the #pragma is taken into account before any other
> > includes are processed, put it in a header file of its own and
> > include it via the compiler command line using the -include option.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/efi.h              | 3 ---
> >  drivers/firmware/efi/libstub/Makefile     | 2 +-
> >  drivers/firmware/efi/libstub/arm64-stub.c | 8 +-------
> >  drivers/firmware/efi/libstub/hidden.h     | 6 ++++++
> >  4 files changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/efi.h
> > b/arch/arm64/include/asm/efi.h
> > index 44531a69d32b..56ae87401a26 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -107,9 +107,6 @@ static inline void free_screen_info(struct
> > screen_info *si)
> >  {
> >  }
> >
> > -/* redeclare as 'hidden' so the compiler will generate relative
> > references */
> > -extern struct screen_info screen_info
> > __attribute__((__visibility__("hidden")));
> > -
> >  static inline void efifb_setup_from_dmi(struct screen_info *si,
> > const char *opt)
> >  {
> >  }
> > diff --git a/drivers/firmware/efi/libstub/Makefile
> > b/drivers/firmware/efi/libstub/Makefile
> > index f14b7636323a..4efdbd711e8e 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst
> > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >  cflags-$(CONFIG_EFI_ARMSTUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> >  KBUILD_CFLAGS                        := $(cflags-y)
> > -DDISABLE_BRANCH_PROFILING \
> > -                                -D__NO_FORTIFY \
> > +                                -include hidden.h -D__NO_FORTIFY \
> >                                  $(call cc-option,-ffreestanding) \
> >                                  $(call cc-option,-fno-stack-
> > protector) \
> >                                  -D__DISABLE_EXPORTS
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c
> > b/drivers/firmware/efi/libstub/arm64-stub.c
> > index 2915b44132e6..719d03a64329 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > @@ -6,17 +6,11 @@
> >   * Adapted from ARM version by Mark Salter <msalter@redhat.com>
> >   */
> >
> > -/*
> > - * To prevent the compiler from emitting GOT-indirected (and thus
> > absolute)
> > - * references to the section markers, override their visibility as
> > 'hidden'
> > - */
> > -#pragma GCC visibility push(hidden)
> > -#include <asm/sections.h>
> > -#pragma GCC visibility pop
> >
> >  #include <linux/efi.h>
> >  #include <asm/efi.h>
> >  #include <asm/memory.h>
> > +#include <asm/sections.h>
> >  #include <asm/sysreg.h>
> >
> >  #include "efistub.h"
> > diff --git a/drivers/firmware/efi/libstub/hidden.h
> > b/drivers/firmware/efi/libstub/hidden.h
> > new file mode 100644
> > index 000000000000..3493b041f419
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/hidden.h
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * To prevent the compiler from emitting GOT-indirected (and thus
> > absolute)
> > + * references to any global symbols, override their visibility as
> > 'hidden'
> > + */
> > +#pragma GCC visibility push(hidden)
>
> I am getting following compiler errors because of this patch while
> cross compiling for ARM, ARM64 and RISC-V.
>
> cc1: fatal error: hidden.h: No such file or directory
>
> Adding the following line to cflags solves the issue which indicates
> that gcc is not looking at the source file directory for this
> particularly include file.
>
> -I$(srctree)/drivers/firmware/efi/libstub
>
> I might have some trick in my build setup. Just posting here to see if
> anybody else also seeing the same problem.
>

Thanks Atish. Heinrich reported the same issue. It didn't affect me or
any of the bots because it only hits if you build in-tree (i.e.,
$srctree == $objtree)

My latest efi/next branch carries a fix for this (similar to your
suggestion, but using -include)
