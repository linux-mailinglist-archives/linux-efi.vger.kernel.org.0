Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67A21EFBE8
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFEOyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 10:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFEOyM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 10:54:12 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F452074B;
        Fri,  5 Jun 2020 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591368851;
        bh=jRPCH/tx4o7fYOkKEAOKTxSmol19jY0MwCvdOWSCKAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=enQnTCIaLOeTZTNG/rmeVyg/RmVp7XKHMw5DwsWCuSVIgIby4E344h6ycmd0AlVk1
         y44cP6JYDhFg07hnNc2elrMY5IzMJitQJykWOu+cwGdKcKStncH5VUqfWusyvn92yA
         rFSDXNW0SORLA8gxNMajY2kmDbL3+y+eb7XwhPHY=
Received: by mail-ot1-f41.google.com with SMTP id o13so7805669otl.5;
        Fri, 05 Jun 2020 07:54:11 -0700 (PDT)
X-Gm-Message-State: AOAM532Rhg3TsWVcAGPo/o4cMmM7XXo9W4n3+KtDJL8F/hlGYgPLaxoO
        Qm4jXk0E2R5BOvS1Ak90pyWZPk/+rMGzqhX8Pus=
X-Google-Smtp-Source: ABdhPJx/a9mwC0PJr0EhFiLa+ncxjCxnQyruNdvyALIvOh6oevrfHoSe8gmM6LrDcE9CmGfDvhVaFPoTsZ1+96IFR6I=
X-Received: by 2002:a9d:476:: with SMTP id 109mr8457492otc.77.1591368850849;
 Fri, 05 Jun 2020 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu> <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
 <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
 <20200605131419.GA560594@rani.riverdale.lan> <20200605133232.GA616374@rani.riverdale.lan>
In-Reply-To: <20200605133232.GA616374@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Jun 2020 16:53:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG936NeN7+Mf42bL-7V5pRVjoNmCKmVT3EcB5EGh2y5fQ@mail.gmail.com>
Message-ID: <CAMj1kXG936NeN7+Mf42bL-7V5pRVjoNmCKmVT3EcB5EGh2y5fQ@mail.gmail.com>
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrey Ignatov <rdna@fb.com>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Jun 2020 at 15:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Jun 05, 2020 at 09:14:19AM -0400, Arvind Sankar wrote:
> > On Fri, Jun 05, 2020 at 08:33:22AM +0200, Ard Biesheuvel wrote:
> > > Hello Andrey,
> > >
> > > On Fri, 5 Jun 2020 at 02:31, Andrey Ignatov <rdna@fb.com> wrote:
> > > >
> > > > Arvind Sankar <nivedita@alum.mit.edu> [Wed, 1969-12-31 23:00 -0800]:
> > > > > Reclaim the bloat from the addition of printf by optimizing the stub for
> > > > > size. With gcc 9, the text size of the stub is:
> > > > >
> > > > > ARCH    before  +printf    -Os
> > > > > arm      35197    37889  34638
> > > > > arm64    34883    38159  34479
> > > > > i386     18571    21657  17025
> > > > > x86_64   25677    29328  22144
> > > > >
> > > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > ---
> > > > >  drivers/firmware/efi/libstub/Makefile | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > > > index fb34c9d14a3c..034d71663b1e 100644
> > > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > > @@ -7,7 +7,7 @@
> > > > >  #
> > > > >  cflags-$(CONFIG_X86_32)              := -march=i386
> > > > >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > > > > -cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> > > > > +cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ \
> > > > >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> > > > >                                  -mno-mmx -mno-sse -fshort-wchar \
> > > > >                                  -Wno-pointer-sign \
> > > > > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > >
> > > > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > > >
> > > > > -KBUILD_CFLAGS                        := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> > > > > +KBUILD_CFLAGS                        := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> > > > >                                  -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> > > > >                                  -D__NO_FORTIFY \
> > > > >                                  $(call cc-option,-ffreestanding) \
> > > >
> > > > Hi Arvind,
> > > >
> > > > This patch breaks build for me:
> > > >
> > > > $>make -j32 -s bzImage
> > > > drivers/firmware/efi/libstub/alignedmem.c: In function \x2018efi_allocate_pages_aligned\x2019:
> > > > drivers/firmware/efi/libstub/alignedmem.c:38:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> > > >   status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
> > > >          ^
> > >
> > > Which version of GCC are you using?
> >
> > gcc-4.8.5 from the config. I got a copy and can reproduce it. Just
> > adding -maccumulate-outgoing-args appears to fix it, checking some more.
> >
>
> On a simple test:
>         extern void __attribute__ (( ms_abi )) ms_abi();
>         void sysv_abi(void) { ms_abi(); }
> it only breaks with -Os -fno-asynchronous-unwind-tables, weirdly enough.

I guess the logic that decides whether -maccumulate-outgoing-args is
enabled is somewhat opaque.

Could we perhaps back out the -Os change for 4.8 and earlier?
