Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F91F93C4
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgFOJnp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 05:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgFOJno (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 05:43:44 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581C3206D7;
        Mon, 15 Jun 2020 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214224;
        bh=h9iDtTC155H8y8ijbYh/I4bXZWq8mQ2WmNzz0ZDQZ/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XST84rnMgFvKZeDuWzqxgqrBdT2hLemvqhFHD63KT7/4jDDa7+2xFZUOPOQwFxlAp
         vvHTPt0XPsIBsD/wsZX5Ll+JPd2YcvTKvkeOHY6I2cuACJJ28Iw66CdHBdA3fqAPxW
         EA/oYiIq9D80OxshpJcqBihTylNwbqGPepX2zE3s=
Received: by mail-oi1-f182.google.com with SMTP id a21so15302319oic.8;
        Mon, 15 Jun 2020 02:43:44 -0700 (PDT)
X-Gm-Message-State: AOAM531Sh9/hKo2x8nHY6b9Fij+eW48/UwLaTNRw6r7dcW2Fe6kKOAhR
        AM0CtWAW+JiqAcqG/AswsGp/5hOnkfZWwVntpl8=
X-Google-Smtp-Source: ABdhPJwVOJVLzMhqyBugezrvFZeW6chSrziL0zpZxXsmNV5WBIk26t41KZmkOaXcDOZqsToD7/Dh55WNfXoel+o6EDM=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr1478325oin.174.1592214223750;
 Mon, 15 Jun 2020 02:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200605133232.GA616374@rani.riverdale.lan> <20200605150638.1011637-1-nivedita@alum.mit.edu>
 <20200605160946.GA46739@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200605160946.GA46739@rdna-mbp.dhcp.thefacebook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 11:43:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+5MX5-Bn6tLBvFTKW4oh6L5D4DTxvEqcmrxQK8Yi8HA@mail.gmail.com>
Message-ID: <CAMj1kXH+5MX5-Bn6tLBvFTKW4oh6L5D4DTxvEqcmrxQK8Yi8HA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Fix build with gcc 4
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Jun 2020 at 18:09, Andrey Ignatov <rdna@fb.com> wrote:
>
> Arvind Sankar <nivedita@alum.mit.edu> [Fri, 2020-06-05 08:06 -0700]:
> > Commit
> >   bbf8e8b0fe04 ("efi/libstub: Optimize for size instead of speed")
> >
> > changed the optimization level for the EFI stub to -Os from -O2.
> >
> > Andrey Ignatov reports that this breaks the build with gcc 4.8.5.
> >
> > Testing on godbolt.org, the combination of -Os,
> > -fno-asynchronous-unwind-tables, and ms_abi functions doesn't work,
> > failing with the error:
> >   sorry, unimplemented: ms_abi attribute requires
> >   -maccumulate-outgoing-args or subtarget optimization implying it
> >
> > This does appear to work with gcc 4.9 onwards.
> >
> > Add -maccumulate-outgoing-args explicitly to unbreak the build with
> > pre-4.9 versions of gcc.
> >
> > Reported-by: Andrey Ignatov <rdna@fb.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>
> Thanks. I confirmed it fixes the problem on my setup with gcc 4.8.5 and
> also works as before with clang 9.0.20190721.
>

Queued in efi/urgent, thanks.

> > ---
> >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index cce4a7436052..d67418de768c 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -6,7 +6,8 @@
> >  # enabled, even if doing so doesn't break the build.
> >  #
> >  cflags-$(CONFIG_X86_32)              := -march=i386
> > -cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > +cflags-$(CONFIG_X86_64)              := -mcmodel=small \
> > +                                $(call cc-option,-maccumulate-outgoing-args)
> >  cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ \
> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> >                                  -mno-mmx -mno-sse -fshort-wchar \
> > --
> > 2.26.2
> >
>
> --
> Andrey Ignatov
