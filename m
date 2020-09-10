Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81FD26432C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Sep 2020 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJKDm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Sep 2020 06:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbgIJKDd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Sep 2020 06:03:33 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9FC20882;
        Thu, 10 Sep 2020 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599732211;
        bh=tE0vK+lGJxMKuPHT7CyqR99KxgsVoHl0G44/ulvB++M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zefGfOxBbwaSpki54+vicMmqXgta+12bh5+L7P042Jk3UT1kOyugF1j48BCQT5K1f
         admq6xZ9rrOd39q+l+mDaIE43fhDRuYF6WDbSKPQiTn29AfTmxpB1vR+Uzo7ljeMU+
         19Ssj3SMgMUG2d7sSAMTm+yTLyqr3sINLSa2YF54=
Received: by mail-ot1-f49.google.com with SMTP id c10so4827134otm.13;
        Thu, 10 Sep 2020 03:03:31 -0700 (PDT)
X-Gm-Message-State: AOAM531IfcQvbUYgVhRZx4xldab69NMoQbrjywsIY9NssDNSz9KWxrDv
        MmqpxX6yct1WXYIBRCxG9/mLWfnbFcEzJTO5Gnw=
X-Google-Smtp-Source: ABdhPJzM2MRG8rMTJKJfOP0RduKJh1ex1F4fmkrYko4U7RrgeomKqV16KFW80Wu4mw/3mRmN6RhDx+WrrWyMEKFvB5Q=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr3635338otk.77.1599732210910;
 Thu, 10 Sep 2020 03:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
 <CAOnJCU+DrXt=Fvq08dMJX=Nn0bEJr_V_1nPJvh6sRA-GqgV3OQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+DrXt=Fvq08dMJX=Nn0bEJr_V_1nPJvh6sRA-GqgV3OQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Sep 2020 13:03:19 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFKrD172-AU_45fd4UHXdxOKfjyy9R=teXxEAr9nFKP6w@mail.gmail.com>
Message-ID: <CAMj1kXFKrD172-AU_45fd4UHXdxOKfjyy9R=teXxEAr9nFKP6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 23:37, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Sep 9, 2020 at 1:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
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
> > What I would prefer to do is get rid of get_dram_base() entirely -
> > arm64 does not use its return value in the first place, and for ARM,
> > the only reason we need it is so that we can place the uncompressed
> > kernel image as low in memory as possible, and there are probably
> > better ways to do that. RISC-V just started using it too, but only
> > passes it from handle_kernel_image() to efi_relocate_kernel(), and
> > afaict, passing 0x0 there instead would not cause any problems.
>
> Yes. Passing 0x0 to efi_relocate_kernel will result in a failure in
> efi_bs_call and it will fallback to
> efi_low_alloc_above which will try to assign the lowest possible
> available memory with 2MB alignment restriction.
> The only disadvantage is an extra unnecessary call to UEFI firmware
> which should be okay as it is not in the hotpath.
>

The point is really that get_dram_base() does a similar call to
GetMemoryMap() under the hood, so once we remove it, the worst case
still does that once (in efi_low_alloc_above() invoked from
efi_relocate_kernel) whereas the optimal case will no longer call it
at all.
