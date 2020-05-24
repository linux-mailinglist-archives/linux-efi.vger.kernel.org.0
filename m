Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44F1DFFBE
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgEXPQL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 11:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXPQL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 24 May 2020 11:16:11 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DF8207DA;
        Sun, 24 May 2020 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590333370;
        bh=DBO+AFU7BO2kvgodVLA6Qc5bUZGuYFw9r9JFfhIfeU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xIKVqbd1VPT1lyu6MHeu/IaJ25qd81plAkM9TZI4evvy2Z1d4EAQDy2Y/tT873jbJ
         edQrBYw4udJ3ja7ldj8v901ASP1ffybdsThVanQ7cR9dPobHryVfp9NTgkjtl+W0y4
         KZsg4ae/4Vc35Viskt+ksFlP0Og9EFSVwZF869Nk=
Received: by mail-io1-f48.google.com with SMTP id r2so6111714ioo.4;
        Sun, 24 May 2020 08:16:10 -0700 (PDT)
X-Gm-Message-State: AOAM533ZpmAcdFsjWN81qqYyUlsZOjWaDDRkwOTOTY1KEV3p9vTo+nqf
        /JBAMtsqYUWsgtU0QhLRXAkUbxmuOrHKiECtFOc=
X-Google-Smtp-Source: ABdhPJxoQfaZcCn0bMIT8xXH69q3xcs6tH7GHGoLmmLn8ZsNHfkfDb+qo20agexgaqFT5NnQwSZwSRkjpfWhVRxTzVY=
X-Received: by 2002:a02:956f:: with SMTP id y102mr3390953jah.68.1590333370077;
 Sun, 24 May 2020 08:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-3-ardb@kernel.org>
 <20200524151214.GB11617@gmail.com>
In-Reply-To: <20200524151214.GB11617@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 May 2020 17:15:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUBWO=F0tDcOqUkNDSSB69z8uVR1xFexZ9dWqNuDQycQ@mail.gmail.com>
Message-ID: <CAMj1kXFUBWO=F0tDcOqUkNDSSB69z8uVR1xFexZ9dWqNuDQycQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 24 May 2020 at 17:12, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > To ensure that no GOT entries will creep back in, add an assertion to
> > the decompressor linker script that will fire if the .got section has
> > a non-zero size.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile      |  1 +
> >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 5f7c262bcc99..aa9ed814e5fa 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -40,6 +40,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > +KBUILD_CFLAGS += -include hidden.h
>
> > + * When building position independent code with GCC using the -fPIC option,
> > + * (or even the -fPIE one on older versions), it will assume that we are
> > + * building a dynamic object (either a shared library or an executable) that
> > + * may have symbol references that can only be resolved at load time. For a
> > + * variety of reasons (ELF symbol preemption, the CoW footprint of the section
> > + * that is modified by the loader), this results in all references to symbols
> > + * with external linkage to go via entries in the Global Offset Table (GOT),
> > + * which carries absolute addresses which need to be fixed up when the
> > + * executable image is loaded at an offset which is different from its link
> > + * time offset.
> > + *
> > + * Fortunately, there is a way to inform the compiler that such symbol
> > + * references will be satisfied at link time rather than at load time, by
> > + * giving them 'hidden' visibility.
> > + */
> > +
> > +#pragma GCC visibility push(hidden)
>
> BTW., how many such GOT entries did we have before this change, on a typical kernel?
>

None if you are using a recent GCC/binutils that use a relocation type
that can be relaxed into an ordinary relative reference by the linker.
Older GCC/binutils may emit a couple for the decompressor.


> > +ASSERT (SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>
> s/ASSERT (
>  /ASSERT(
>

OK

> Thanks,
>
>         Ingo
