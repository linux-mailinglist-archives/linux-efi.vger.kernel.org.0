Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC961E4D62
	for <lists+linux-efi@lfdr.de>; Wed, 27 May 2020 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgE0SuP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 14:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgE0SuP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 May 2020 14:50:15 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC412073B;
        Wed, 27 May 2020 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590604235;
        bh=yrp8btb31P5JNGINiPGR979o67FKKAt2YeeDUI67h0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2UmN9xCpWx7rx2hJ6s4dj97SpOjwhvz/TXReiFd5aUbkZkhb2uhL78c+w1kKKUZoB
         y5n/EV1O85qUsKgmnZEcoehf0tBGve3E61XfllQYkiIfhjyV0WV57veyexffD8WeY2
         7usizsxWw2pgm9D5gqLZgL9eozpSMPHjyYRuA/vE=
Received: by mail-il1-f173.google.com with SMTP id l20so25047079ilj.10;
        Wed, 27 May 2020 11:30:35 -0700 (PDT)
X-Gm-Message-State: AOAM530tP1y+8fmTodHKB92bOFSqLLHHFmY6+6m/7wLvHEl7/kMsh8BJ
        v4E2BJjShFNmSKfwkUfLbkiN3xk6ZJQvhnUg0wU=
X-Google-Smtp-Source: ABdhPJxaBgJdts/3rMVrWZXg7f3NCsaI5epY+iw+MqESNkB/2tqDRrOiEl5BHdcHm1cm9EFCAljU4lRJfdBVIlCCm04=
X-Received: by 2002:a92:290c:: with SMTP id l12mr6720934ilg.279.1590604234737;
 Wed, 27 May 2020 11:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-3-ardb@kernel.org>
 <20200527143650.GA3103408@rani.riverdale.lan> <CAMzpN2ikgiXdaJ8t2ivB90JhOQsa=ziV738wVsXo3JU4HjAbOw@mail.gmail.com>
In-Reply-To: <CAMzpN2ikgiXdaJ8t2ivB90JhOQsa=ziV738wVsXo3JU4HjAbOw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 May 2020 20:30:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGzLRiioU=sqA0hhE1oJC5uxDg4GFcSr7eA1+HoqupGw@mail.gmail.com>
Message-ID: <CAMj1kXFGzLRiioU=sqA0hhE1oJC5uxDg4GFcSr7eA1+HoqupGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 27 May 2020 at 20:29, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 2:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, May 23, 2020 at 02:00:20PM +0200, Ard Biesheuvel wrote:
> > > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > > visibility for all symbol references, which informs the compiler that
> > > such references will be resolved at link time without the need for
> > > allocating GOT entries.
> > >
> > > To ensure that no GOT entries will creep back in, add an assertion to
> > > the decompressor linker script that will fire if the .got section has
> > > a non-zero size.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/Makefile      |  1 +
> > >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> > >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> > >  3 files changed, 21 insertions(+)
> > >
> > > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > > index 5f7c262bcc99..aa9ed814e5fa 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -40,6 +40,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> > >  KBUILD_CFLAGS += -Wno-pointer-sign
> > >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> > >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > > +KBUILD_CFLAGS += -include hidden.h
> > >
> >
> > Ard, from the other thread [1] in case you missed it -- the plain
> > hidden.h fails to build in-tree. We need something like
> >         KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
> > instead.
> >
> > [1] https://lore.kernel.org/lkml/20200526153104.GC2190602@rani.riverdale.lan/
>
> How about using -fvisibility=hidden instead of including this header?
>

That only works for definitions, not for extern declarations.
