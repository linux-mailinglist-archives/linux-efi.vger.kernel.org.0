Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5741F9424
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFOKAW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 06:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgFOKAV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 06:00:21 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0AD20714;
        Mon, 15 Jun 2020 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592215221;
        bh=00G+G40iLh/fz0ZoDfre7cPvPu8PXFNDupSAUY86Lvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=15MPTThiFiuBGre6NKmQUmf7lBRfm5NBAyLEIkeijmEMZ2kWvGTAQVLZ4mTdSZ8TK
         OIE7eU4azos03DmxpznByoh4CP/xnbp6jlqp4BKMO1d2d4tUECtI8NEs0arkc0j+G6
         KfMZdv7ggoIWzQvzd+Zt3tiL2pxVQ5SaoXtqrmiw=
Received: by mail-oi1-f169.google.com with SMTP id x202so15328039oix.11;
        Mon, 15 Jun 2020 03:00:21 -0700 (PDT)
X-Gm-Message-State: AOAM532mNQulw32ycf3foHJ3HOFc/80lhUffjPjq94xY6B8KQNDj6j/7
        BejDowYLmTbRy/HgJz1K31c9REoMCKvns1X9ge8=
X-Google-Smtp-Source: ABdhPJw3tdI8zwDBVzm2IE5Fc1IJYBRoBO9Vu7dfS8iQs1S3WvzDCbp3jBUnfOMao1V0VmclY1k4jJKLGRpqrW7v99o=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr1821642oif.33.1592215220452;
 Mon, 15 Jun 2020 03:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200527171425.GA4053@embeddedor> <202005290131.4B104937C@keescook>
 <20200529173722.GB10051@embeddedor>
In-Reply-To: <20200529173722.GB10051@embeddedor>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 12:00:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGargNLdbuy0AhLUJS4j1eANGuMnvBpzWBTeVmr-9=-1g@mail.gmail.com>
Message-ID: <CAMj1kXGargNLdbuy0AhLUJS4j1eANGuMnvBpzWBTeVmr-9=-1g@mail.gmail.com>
Subject: Re: [PATCH] efi: Replace zero-length array and use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 29 May 2020 at 19:32, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 01:31:54AM -0700, Kees Cook wrote:
> > On Wed, May 27, 2020 at 12:14:25PM -0500, Gustavo A. R. Silva wrote:
> > > The current codebase makes use of the zero-length array language
> > > extension to the C90 standard, but the preferred mechanism to declare
> > > variable-length types such as these ones is a flexible array member[1][2],
> > > introduced in C99:
> > >
> > > struct foo {
> > >         int stuff;
> > >         struct boo array[];
> > > };
> > >
> > > By making use of the mechanism above, we will get a compiler warning
> > > in case the flexible array does not occur last in the structure, which
> > > will help us prevent some kind of undefined behavior bugs from being
> > > inadvertently introduced[3] to the codebase from now on.
> > >
> > > Also, notice that, dynamic memory allocations won't be affected by
> > > this change:
> > >
> > > "Flexible array members have incomplete type, and so the sizeof operator
> > > may not be applied. As a quirk of the original implementation of
> > > zero-length arrays, sizeof evaluates to zero."[1]
> > >
> > > sizeof(flexible-array-member) triggers a warning because flexible array
> > > members have incomplete type[1]. There are some instances of code in
> > > which the sizeof operator is being incorrectly/erroneously applied to
> > > zero-length arrays and the result is zero. Such instances may be hiding
> > > some bugs. So, this work (flexible-array member conversions) will also
> > > help to get completely rid of those sorts of issues.
> > >
> > > Lastly, make use of the sizeof_field() helper instead of an open-coded
> > > version.
> > >
> > > This issue was found with the help of Coccinelle and audited _manually_.
> > >
> > > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > > [2] https://github.com/KSPP/linux/issues/21
> > > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > >
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
>
> Thanks :)
>

Queued in efi/urgent, thanks


> Please, see more comments below...
>
> > > ---
> > >  drivers/firmware/efi/efi.c | 3 ++-
> > >  include/linux/efi.h        | 7 ++-----
> > >  2 files changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 7f1657b6c30df..edc5d36caf54e 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
> > >                     rsv = (void *)(p + prsv % PAGE_SIZE);
> > >
> > >                     /* reserve the entry itself */
> > > -                   memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
> > > +                   memblock_reserve(prsv,
> > > +                                    struct_size(rsv, entry, rsv->size));
> > >
> > >                     for (i = 0; i < atomic_read(&rsv->count); i++) {
> > >                             memblock_reserve(rsv->entry[i].base,
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index c45ac969ea4eb..328cc52a5fd45 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1234,14 +1234,11 @@ struct linux_efi_memreserve {
> > >     struct {
> > >             phys_addr_t     base;
> > >             phys_addr_t     size;
> > > -   } entry[0];
> > > +   } entry[];
> > >  };
> > >
> > > -#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
> > > -   (count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> > > -
> > >  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> > > -   / sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> > > +   / sizeof_field(struct linux_efi_memreserve, entry[0]))
> >
> > Whoa. This is kind of a "reverse struct_size()". I wonder if any other
> > places in the kernel do a similar calculation?
> >
>
> So far this is the only intance of this I've run into.
>
> What I've found is that there are many instances of the open-coded
> version of sizeof_field() and offsetof(). I'm addressing them on the
> way.
>
> Thanks
> --
> Gustavo
