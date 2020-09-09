Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AE262D62
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIKrN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 06:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIKrM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 06:47:12 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB6621D7E;
        Wed,  9 Sep 2020 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599648431;
        bh=emLvqtcXwI/FQKrrePSjfuOAtAPtdcDmo8afGVbB6ro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hNmRQCeEcYxGhMv2gn4pigC3Yy87hMLyawGznCEhRgmeELxf8H6ldxzQUrw1Q+D3M
         soJWLpSokDrv1LLORbRJiFwigjwFP+etzgMJ0ctHNmqcMmSHNSusM/ZNzzgRZRg51x
         jQ/5Nxxp1iK0H3mUJDXHRkaL5e3kjQueJFDHJei4=
Received: by mail-ot1-f46.google.com with SMTP id 37so1888411oto.4;
        Wed, 09 Sep 2020 03:47:11 -0700 (PDT)
X-Gm-Message-State: AOAM530vBLunRrxF/uYKyMhEIQ+kvs8g4XCnqEEEE6TSvLWvVbz//rFp
        /Wn+/XSPJOgAEnecldhc+mwuPxn5qdOfWXqVWlY=
X-Google-Smtp-Source: ABdhPJy5QcWx5USEGXFJf61fBWJyCQG4wsqOawuz3eGWm2s0CuJuqoJN77RdelWHXKbtIP3MLQSYFZsmLTG5vZodSAk=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr274599otk.77.1599648430374;
 Wed, 09 Sep 2020 03:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
 <CAD8XO3YGUUz6B4NDBC-f4Rfhhyya6GPwjW2oxP=GANRoNyydsQ@mail.gmail.com>
In-Reply-To: <CAD8XO3YGUUz6B4NDBC-f4Rfhhyya6GPwjW2oxP=GANRoNyydsQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Sep 2020 13:46:59 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGkhJqMFggO7reedKkuQh2vmNeac5pXirEcN+XvMX==gA@mail.gmail.com>
Message-ID: <CAMj1kXGkhJqMFggO7reedKkuQh2vmNeac5pXirEcN+XvMX==gA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 13:44, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Wed, 9 Sep 2020 at 11:17, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (+ Atish, Palmer)
> >
> > On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > In the memory map the regions with the lowest addresses may be of type
> > > EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> > > rest of the memory. So for calculating the maximum loading address for the
> > > device tree and the initial ramdisk image these reserved areas should not
> > > be taken into account.
> > >
> > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > ---
> > >  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > > index c2484bf75c5d..13058ac75765 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > > @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> > >         map.map_end = map.map + map_size;
> > >
> > >         for_each_efi_memory_desc_in_map(&map, md) {
> > > -               if (md->attribute & EFI_MEMORY_WB) {
> > > +               if (md->attribute & EFI_MEMORY_WB &&
> > > +                   md->type != EFI_RESERVED_TYPE) {
> > >                         if (membase > md->phys_addr)
> > >                                 membase = md->phys_addr;
> > >                 }
> > > --
> > > 2.28.0
> > >
> >
> > This is not the right fix - on RPi2, for instance, which has some
> > reserved memory at the base of DRAM, this change will result in the
> > first 16 MB of memory to be wasted.
> >
> In the EFI memmap provided to the kernel efi stub it will be 2
> regions. First is EFI_RESERVED and second is EFI_CONVENTIONAL_MEMORY.
> Even if they follow each other.
> And for_each_efi_memory_desc_in_map will just return the second one.
> Do not see where the problem is here.
>

The base of DRAM will no longer start at a 16 MB aligned address on
RPi, and so it will round up to the next 16 MB, wasting the space in
between.

> > What I would prefer to do is get rid of get_dram_base() entirely -
> > arm64 does not use its return value in the first place, and for ARM,
> > the only reason we need it is so that we can place the uncompressed
> > kernel image as low in memory as possible, and there are probably
> > better ways to do that. RISC-V just started using it too, but only
> > passes it from handle_kernel_image() to efi_relocate_kernel(), and
> > afaict, passing 0x0 there instead would not cause any problems.
>
> For prior 5.8 kernels there was limitation for maximum address to
> unpack the kernel. As I understand that was copy-pasted from x86 code,
> and now is missing in 5.9.

What code are you referring to here?

> That is why the suggestion was to point
> dram_base to the region where it's possible to allocate. I.e. I assume
> that
> patch was created not to the latest kernel. Removing the upper
> allocation limit should work here.
>

As I pointed out, this will regress other platforms.
