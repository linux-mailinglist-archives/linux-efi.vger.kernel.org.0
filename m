Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915171E59AD
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgE1HrD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 03:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HrD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 May 2020 03:47:03 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C03D2145D;
        Thu, 28 May 2020 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590652023;
        bh=VJkwPm3qnRlzFdRds5A0deQrmmDvdRLKoqaaK4egYLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gfLwNjhuofZjRW5m8CqEE20xx3xpXmG+bd6cU0vyyR38ciNRRH/tAKKbXx73loEH3
         sxi9o4bGk325Gj5ZkSeeeSyUTON18MAUdjTBTiAQdqWCqxf66YNJnmw7LfKh/QbTui
         yxOYWaWJS11TKKUE0Br8Q4KA8onHEjcQ4bWPWq3U=
Received: by mail-il1-f169.google.com with SMTP id c20so26722062ilk.6;
        Thu, 28 May 2020 00:47:03 -0700 (PDT)
X-Gm-Message-State: AOAM533O7dJEWqLtrw4tFPOHJUQd9kn9VAHnMexqcTAvC8c9qCpnp+Uv
        29BqIsplQP8thoM9rLkIpJOtU14CNUz11UmGGVY=
X-Google-Smtp-Source: ABdhPJzFLFkSpcKi/m5w9usOiYbOSK9Qmui2ozWgFFMNchlEUmDMfdn4q3wWHUp4h+hgdkj+/cYP+jqEQ0S5qu6QnOY=
X-Received: by 2002:a92:3556:: with SMTP id c83mr1578969ila.218.1590652022432;
 Thu, 28 May 2020 00:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-3-ardb@kernel.org>
 <20200527143650.GA3103408@rani.riverdale.lan>
In-Reply-To: <20200527143650.GA3103408@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 28 May 2020 09:46:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHn2r0RwtFtDtk00kG2XzEmzqL+n9ikkZfXvo98Y8dHoQ@mail.gmail.com>
Message-ID: <CAMj1kXHn2r0RwtFtDtk00kG2XzEmzqL+n9ikkZfXvo98Y8dHoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 27 May 2020 at 16:36, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, May 23, 2020 at 02:00:20PM +0200, Ard Biesheuvel wrote:
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
> >
>
> Ard, from the other thread [1] in case you missed it -- the plain
> hidden.h fails to build in-tree. We need something like
>         KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
> instead.
>
> [1] https://lore.kernel.org/lkml/20200526153104.GC2190602@rani.riverdale.lan/

Thanks for the reminder, but I was aware of this.

I'll send out a v2 but given how close we are to the v5.7 release,
this is going to be v5.8 material anyway, so let's revisit this later.
