Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE8E97362
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfHUH3s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 03:29:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40875 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfHUH3s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 03:29:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id c5so823140wmb.5
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKOeCy3Qcia3Pbgp+4T8KWWXoItnNEc3EaF4utxPSx4=;
        b=kK904OuKS3Z8eMv0x8Na8g7IPPgNprXCORczmb6V/kXExPgWnxBAxCQbxF+TAphd8J
         nwjdYXpn0F7I+V4GIiKpnFEVTDThLbQ+OBnq3QrtTlGHq273IzR3HTTp2aO9cNm4qn4E
         Vx6HjcgcZj3/l9DKUp7U69jiCwDJQ5J8Cq2gY/u+HwExBsYQx9jmguM8rg+5fMMRa58C
         SGWtuI44qH0puyTaWmBrYyzulee73OvRhuNGjLxSZ/cxc1NO56LLMhvIPCdhr2Ba3aBT
         J8aytWr9dUsMKirAYbKOBij174iq/ssCpyrAybzZGPiB7Gps00VjkACWNSO2a6jE4iUe
         pfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKOeCy3Qcia3Pbgp+4T8KWWXoItnNEc3EaF4utxPSx4=;
        b=YmrEvwjJVYQd1OTV8vHSEzoifbqoxC30goFvyJTaR9X1w3ng3BbaGjdVHxLwgAldLY
         dw+MRoBnsB6yr1UsWQ5MIJuIcQMn1Oamq6CTUyNppHv0q/QJizEPM35/s14Bvf7SB+ub
         KjTMxo3Yydl/ggG+PG7025qTyTuCTdeE2w8St+btsY+mRqS2CpVfTVJcwXN7ZDExu8wZ
         m8aLD7CLIPR973A4dv2zuXwqrLbHL6f/uT/lmOwh363hYyYE66Zw5TgLLQ0TTKvHWH/s
         GTTQvsquFKIUw2gO32JlpwKE9Lq6Zwef1ezLcyUucAKxGBUXx8MQgzlVlEocJbi9o8OR
         zQRA==
X-Gm-Message-State: APjAAAXwv3JnZuFSRcyDLN58u+wp5uGzDWo90APCCd6qeD/bNa2VtJo9
        9of+uY3UsvLTE8jZj68D4EsdOdU5Kf20uso+eLiW6Q==
X-Google-Smtp-Source: APXvYqwr0nEjmLtPxp9jPzcCElAX7fest218vtFNqRK9Hh8HPkq4tF2BdQkHv6NmMu6fNQdhJczPGiJW0nzPMwhbGtg=
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr4057110wmo.136.1566372585757;
 Wed, 21 Aug 2019 00:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
 <20190821061027.GA2828@linux-8mug> <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
 <20190821071100.GA26713@rapoport-lnx>
In-Reply-To: <20190821071100.GA26713@rapoport-lnx>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Aug 2019 10:29:37 +0300
Message-ID: <CAKv+Gu99z3V1B68CU8qhNwwffqDxNBOM6t3Q8-V7qpbDkf-Cwg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chester Lin <clin@suse.com>, Juergen Gross <JGross@suse.com>,
        Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>, Gary Lin <GLin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Aug 2019 at 10:11, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Aug 21, 2019 at 09:35:16AM +0300, Ard Biesheuvel wrote:
> > On Wed, 21 Aug 2019 at 09:11, Chester Lin <clin@suse.com> wrote:
> > >
> > > On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> > > > On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > > > index f3ce34113f89..909b11ba48d8 100644
> > > > > > --- a/arch/arm/mm/mmu.c
> > > > > > +++ b/arch/arm/mm/mmu.c
> > > > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > > > >               phys_addr_t block_start = reg->base;
> > > > > >               phys_addr_t block_end = reg->base + reg->size;
> > > > > >
> > > > > > +             if (memblock_is_nomap(reg))
> > > > > > +                     continue;
> > > > > > +
> > > > > >               if (reg->base < vmalloc_limit) {
> > > > > >                       if (block_end > lowmem_limit)
> > > > > >                               /*
> > > > >
> > > > > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > > > > available for the kernel's use, so as far as calculating where the
> > > > > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > > > > skipped.
> > > > >
> > > >
> > > > I agree.
> > > >
> > > > Chester, could you explain what you need beyond this change (and my
> > > > EFI stub change involving TEXT_OFFSET) to make things work on the
> > > > RPi2?
> > > >
> > >
> > > Hi Ard,
> > >
> > > In fact I am working with Guillaume to try booting zImage kernel and openSUSE
> > > from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
> > > one of the test machines we have. However we want a better solution for all
> > > cases but not just RPi2 since we don't want to affect other platforms as well.
> > >
> >
> > Thanks Chester, but that doesn't answer my question.
> >
> > Your fix is a single patch that changes various things that are only
> > vaguely related. We have already identified that we need to take
> > TEXT_OFFSET (minus some space used by the swapper page tables) into
> > account into the EFI stub if we want to ensure compatibility with many
> > different platforms, and as it turns out, this applies not only to
> > RPi2 but to other platforms as well, most notably the ones that
> > require a TEXT_OFFSET of 0x208000, since they also have reserved
> > regions at the base of RAM.
> >
> > My question was what else we need beyond:
> > - the EFI stub TEXT_OFFSET fix [0]
> > - the change to disregard NOMAP memblocks in adjust_lowmem_bounds()
> > - what else???
>
> I think the only missing part here is to ensure that non-reserved memory in
> bank 0 starts from a PMD-aligned address. I believe this could be done if
> EFI stub, but I'm not really familiar with it so this just a semi-educated
> guess :)
>

Given that it is the ARM arch code that imposes this requirement, how
about adding something like this to adjust_lowmem_bounds():

if (memblock_start_of_DRAM() % PMD_SIZE)
    memblock_mark_nomap(memblock_start_of_DRAM(),
        PMD_SIZE - (memblock_start_of_DRAM() % PMD_SIZE));

(and introduce the nomap check into the loop)
