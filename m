Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892231DFFB5
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgEXPLR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 11:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgEXPLQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 24 May 2020 11:11:16 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D18C20826;
        Sun, 24 May 2020 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590333076;
        bh=DxNPBs9W2qmds37BflWLrkbxXBiJz9adX3QQ0BftLtE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bcHNTZPZ8gRUXZdbxgnzJaow9mLWrOupi93xteqM2EdQ2Thqy+nZzraMBBlp7N862
         P9JQppthsBR6Kdl2xVJX9yjhrkGdFkLY62nl/Y1sU4bE2CEyiVqNJ2gb8qaV+Y8hlL
         gr2IB2CvJKokP6/O4fd+HCFmWekXzjCCZFEW2X7Y=
Received: by mail-il1-f181.google.com with SMTP id w18so15264797ilm.13;
        Sun, 24 May 2020 08:11:16 -0700 (PDT)
X-Gm-Message-State: AOAM532MSy+WeEdlgziwpJ304MHIKpa9v4+rNz4pMFcRBcLUDqgqRX7w
        r4+VLvQBeHwszEHikPvmqM1mze5wYYKGCKtMRbQ=
X-Google-Smtp-Source: ABdhPJyb+MO6pVLnvSVLWO9gykKsPt7sfB7BW7pCtiXfLqYvS/cDUv1xDtN7RV16rBcKCBww+AdckiktBNjJyJnTlrQ=
X-Received: by 2002:a92:8555:: with SMTP id f82mr20413491ilh.279.1590333075352;
 Sun, 24 May 2020 08:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-2-ardb@kernel.org>
 <20200524150841.GA11617@gmail.com>
In-Reply-To: <20200524150841.GA11617@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 May 2020 17:11:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFy8XebtAhAnO3fn3UBOsLR65KJ2GOLhC2PJmB8BKEe7g@mail.gmail.com>
Message-ID: <CAMj1kXFy8XebtAhAnO3fn3UBOsLR65KJ2GOLhC2PJmB8BKEe7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/boot/compressed: move .got.plt entries out of
 the .got section
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

On Sun, 24 May 2020 at 17:08, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > The .got.plt section contains the part of the GOT which is used by PLT
> > entries, and which gets updated lazily by the dynamic loader when
> > function calls are dispatched through those PLT entries.
> >
> > On fully linked binaries such as the kernel proper or the decompressor,
> > this never happens, and so in practice, the .got.plt section consists
> > only of the first 3 magic entries that are meant to point at the _DYNAMIC
> > section and at the fixup routine in the loader. However, since we don't
> > use a dynamic loader, those entries are never populated or used.
> >
> > This means that treating those entries like ordinary GOT entries, and
> > updating their values based on the actual placement of the executable in
> > memory is completely pointless, and we can just ignore the .got.plt
> > section entirely, provided that it has no additional entries beyond
> > the first 3 ones.
> >
> > So add an assertion in the linker script to ensure that this assumption
> > holds, and move the contents out of the [_got, _egot) memory range that
> > is modified by the GOT fixup routines.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/vmlinux.lds.S | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 0dc5c2b9614b..ce3fdfb93b57 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -44,10 +44,13 @@ SECTIONS
> >       }
> >       .got : {
> >               _got = .;
> > -             KEEP(*(.got.plt))
> >               KEEP(*(.got))
> >               _egot = .;
> >       }
> > +     .got.plt : {
> > +             KEEP(*(.got.plt))
> > +     }
> > +
> >       .data : {
> >               _data = . ;
> >               *(.data)
> > @@ -75,3 +78,11 @@ SECTIONS
> >       . = ALIGN(PAGE_SIZE);   /* keep ZO size page aligned */
> >       _end = .;
> >  }
> > +
> > +#ifdef CONFIG_X86_64
> > +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> > +     "Unexpected GOT/PLT entries detected!")
> > +#else
> > +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc,
> > +     "Unexpected GOT/PLT entries detected!")
> > +#endif
>
> Cool debugging check!
>
> Minor consistent-style nit:
>
> s/ASSERT (
>  /ASSERT(
>

ok

> Optional: maybe even merge these on a single line, as a special exception to the col80 rule?
>
>  #ifdef CONFIG_X86_64
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
>  #else
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) ==  0xc, "Unexpected GOT/PLT entries detected!")
>  #endif
>
> But fine either way.
>

SIZEOF(.got.plt) <= 0x18

could be used as well, given that the section is either empty, or has
at least the 3 magic entries.
