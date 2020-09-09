Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD1262DA0
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIILFR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIILFI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 07:05:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C5C061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 04:05:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o16so1159719pjr.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBdxHBpQYBlcln/luPmGk2tk/V+IRObILMuIsjRXaXA=;
        b=DwAeLUlXbTdAcwD3GrjB6qQ5AJzGCskIANit1lHSjy0R+5B4VV2Ia4kHQRo/8pwN7c
         m8XrbicRrznsmulq4xXwngUBImlAvOmNmW0is2ZeMc0i7+NexNWMubDqkDs7TLr7Yl41
         RRO6ep8t0nr8dCzKbt9zxlg6q4VuLZSYnzxLpSVL+uf35zbuiS67zlBIXT/x81+4Gv8P
         46UqxvA8qFTzUCMs6nEKlSCXdw2OnRWX1szFOSAnmkPmF/yCzzGNbtH4eFvvcUC0zY5Y
         o00IpvePNkJzoutgDzLCFkeaOJhLkSfXhyggzz0q6eJkHratbGqcZd9LloRYt8At/8C3
         j4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBdxHBpQYBlcln/luPmGk2tk/V+IRObILMuIsjRXaXA=;
        b=qj34xKYUf1ZB+6VARC1lZc1OCqarD5CGX5+Icku0h4vcSkS5akSW5L8J4GNJy1/VGw
         D3x/dYrKuzIVeTfsr+4yWbiyOakPqg0wSArjv+4M0dluI48f3XYdudxhf7pOLz4PBVmx
         h5vy+9gVWBre7mRG2pjy4LlwJ+AnE9TW+kcm0JaM0Nc3mYoAvUjs3lc1p6iV1XeLQRQN
         hXBCoYCAZRhKra3W1Xf/HjM3CFFXh1s/k8TbKY7JZmtFLQKHRMhF4tA4yX3DpeK9D4bc
         Cg/f69O+ymD7e1Vuv4SyGtdv1SAU80wGX0BBoyp+/6m+bv9OMmu02HHo7wqcADOAIQcJ
         +pPQ==
X-Gm-Message-State: AOAM5327Z1CjyMZEH+UWYJz77ktbxMqWX/8kDkVkNnHw0rWDCFT0JT8r
        PUQgxBIobxpp63KzM42kWi7oBHdZwdr4DQqJAJRl6Q==
X-Google-Smtp-Source: ABdhPJzEl/T/AzvOrFhWMrBReLyMImlGHIhdZRKV5IXq+qsCeOgq8D7J/ftIhsEX56H6nfGz2yJVJ97AMQZTbkWJfvw=
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr390019pju.146.1599649508121;
 Wed, 09 Sep 2020 04:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
 <CAD8XO3YGUUz6B4NDBC-f4Rfhhyya6GPwjW2oxP=GANRoNyydsQ@mail.gmail.com> <CAMj1kXGkhJqMFggO7reedKkuQh2vmNeac5pXirEcN+XvMX==gA@mail.gmail.com>
In-Reply-To: <CAMj1kXGkhJqMFggO7reedKkuQh2vmNeac5pXirEcN+XvMX==gA@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 9 Sep 2020 14:04:57 +0300
Message-ID: <CAD8XO3ZuxBLsYbyDvfdMicb-91Xb_vB1-atox+12g5qnrCFmzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Wed, 9 Sep 2020 at 13:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 9 Sep 2020 at 13:44, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > On Wed, 9 Sep 2020 at 11:17, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > (+ Atish, Palmer)
> > >
> > > On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > In the memory map the regions with the lowest addresses may be of type
> > > > EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> > > > rest of the memory. So for calculating the maximum loading address for the
> > > > device tree and the initial ramdisk image these reserved areas should not
> > > > be taken into account.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > ---
> > > >  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > > > index c2484bf75c5d..13058ac75765 100644
> > > > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > > > @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> > > >         map.map_end = map.map + map_size;
> > > >
> > > >         for_each_efi_memory_desc_in_map(&map, md) {
> > > > -               if (md->attribute & EFI_MEMORY_WB) {
> > > > +               if (md->attribute & EFI_MEMORY_WB &&
> > > > +                   md->type != EFI_RESERVED_TYPE) {
> > > >                         if (membase > md->phys_addr)
> > > >                                 membase = md->phys_addr;
> > > >                 }
> > > > --
> > > > 2.28.0
> > > >
> > >
> > > This is not the right fix - on RPi2, for instance, which has some
> > > reserved memory at the base of DRAM, this change will result in the
> > > first 16 MB of memory to be wasted.
> > >
> > In the EFI memmap provided to the kernel efi stub it will be 2
> > regions. First is EFI_RESERVED and second is EFI_CONVENTIONAL_MEMORY.
> > Even if they follow each other.
> > And for_each_efi_memory_desc_in_map will just return the second one.
> > Do not see where the problem is here.
> >
>
> The base of DRAM will no longer start at a 16 MB aligned address on
> RPi, and so it will round up to the next 16 MB, wasting the space in
> between.
>

Ok.

> > > What I would prefer to do is get rid of get_dram_base() entirely -
> > > arm64 does not use its return value in the first place, and for ARM,
> > > the only reason we need it is so that we can place the uncompressed
> > > kernel image as low in memory as possible, and there are probably
> > > better ways to do that. RISC-V just started using it too, but only
> > > passes it from handle_kernel_image() to efi_relocate_kernel(), and
> > > afaict, passing 0x0 there instead would not cause any problems.
> >
> > For prior 5.8 kernels there was limitation for maximum address to
> > unpack the kernel. As I understand that was copy-pasted from x86 code,
> > and now is missing in 5.9.
>
> What code are you referring to here?
>
to this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4&id=d0f9ca9be11f25ef4151195eab7ea36d136084f6

> > That is why the suggestion was to point
> > dram_base to the region where it's possible to allocate. I.e. I assume
> > that
> > patch was created not to the latest kernel. Removing the upper
> > allocation limit should work here.
> >
>
> As I pointed out, this will regress other platforms.
