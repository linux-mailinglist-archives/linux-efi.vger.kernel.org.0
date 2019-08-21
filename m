Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47897658
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfHUJnK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 05:43:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfHUJnK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 05:43:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so1402069wrr.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhh05Lx1Wiyqwc4CFdoUHwTxVsPR0zakJwfwav/HC18=;
        b=PVj+qa4NJnbMWOZAIx9AAkNEG1Iyewb7tu5yt41xycqGFxGRF/KX2EdJ/JIMt2leC0
         1p3aNbchhOtqTj/x+g6Cl2hRsTJUOHVLXriQ4dwCM/RUs/qHip/w6b+E77BnytnFDc0Z
         19J9nubVPao7e85KC72Y+R3kBJOfQq6DVgrlhoNwpjerPNZh1HiRZx4AxRoYN2Kh2vHU
         VQK2F3nYhu5dCJ8vRwOiQ8AnmUzk+qwJZBdjJsWrIepI8jzIUOhULXD8wiSQOKERyK8D
         IJKJSQoIOvU/a/iP5cLohN82Uc+pfTj05bz5ma/MyknX60t3Lkp8+8LuG1uw24UbfDTl
         cSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhh05Lx1Wiyqwc4CFdoUHwTxVsPR0zakJwfwav/HC18=;
        b=Dwt9ZO/S8CKIdbrpel9jQbC63gppu4FbK/Orm84QKsBQTU39Sfr1vG1ZKzs9I+74Uy
         z5/hB4o8zasPfXf7vComiS7rJORMxFXtvpW6AoF+2iWnUr9pfOSuEuzA1Xd4qJFZmAm/
         9Axk3SosRKt6LYtE/sSNM7TRdBPZFNVQpzThhhY9+5hmBwjHO/G6TgKJAEt4C0Cb9ccj
         DcQzxs7qSVa50QhXM9FKIqr+zDQDWlix+6kiDuclcIshx0jaLOx3fO4hNNyMHw7FRtsn
         7pT9KjJ6i+MChOHmY8U1/lEGv57ffWgeswhCxB0Pbz3WDAu9MuuLxX8HFSeLHKzmz7LN
         ZiUQ==
X-Gm-Message-State: APjAAAVpuQkvtINq+fSrolWUgk1N4nOHMu+m5ZvPAz0SAmF2NfuApKAH
        uDgMXjZ4bfBZI8wSUKJFrR285bSKrF8Ino8E8Xs3ww==
X-Google-Smtp-Source: APXvYqzgLiqDBoUMfrN5PU/uJb8XTsDfE3cVqCi/aYLhYzZuK+GnS16Vxrx3MfmlOp214llXnxta9V24a17Yg3La7Gw=
X-Received: by 2002:adf:9e09:: with SMTP id u9mr7516435wre.169.1566380588039;
 Wed, 21 Aug 2019 02:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
 <20190821061027.GA2828@linux-8mug> <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
 <20190821071100.GA26713@rapoport-lnx> <CAKv+Gu99z3V1B68CU8qhNwwffqDxNBOM6t3Q8-V7qpbDkf-Cwg@mail.gmail.com>
 <20190821082927.GC26713@rapoport-lnx>
In-Reply-To: <20190821082927.GC26713@rapoport-lnx>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Aug 2019 12:42:56 +0300
Message-ID: <CAKv+Gu91d3NrcEGsz6yapVnf3NV=F-cGeftdPo=H-cNTXCC2EA@mail.gmail.com>
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

On Wed, 21 Aug 2019 at 11:29, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Aug 21, 2019 at 10:29:37AM +0300, Ard Biesheuvel wrote:
> > On Wed, 21 Aug 2019 at 10:11, Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
...
> > > I think the only missing part here is to ensure that non-reserved memory in
> > > bank 0 starts from a PMD-aligned address. I believe this could be done if
> > > EFI stub, but I'm not really familiar with it so this just a semi-educated
> > > guess :)
> > >
> >
> > Given that it is the ARM arch code that imposes this requirement, how
> > about adding something like this to adjust_lowmem_bounds():
> >
> > if (memblock_start_of_DRAM() % PMD_SIZE)
> >     memblock_mark_nomap(memblock_start_of_DRAM(),
> >         PMD_SIZE - (memblock_start_of_DRAM() % PMD_SIZE));
>
> memblock_start_of_DRAM() won't work here, as it returns the actual start of
> the DRAM including NOMAP regions. Moreover, as we cannot mark a region
> NOMAP inside for_each_memblock() this should be done beforehand.
>
> I think something like this could work:
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 2f0f07e..f2b635b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1178,6 +1178,19 @@ void __init adjust_lowmem_bounds(void)
>          */
>         vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
>
> +       /*
> +        * The first usable region must be PMD aligned. Mark its start
> +        * as MEMBLOCK_NOMAP if it isn't
> +        */
> +       for_each_memblock(memory, reg) {
> +               if (!memblock_is_nomap(reg) && (reg->base % PMD_SIZE)) {
> +                       phys_addr_t size = PMD_SIZE - (reg->base % PMD_SIZE);
> +
> +                       memblock_mark_nomap(reg->base, size);
> +                       break;

We should break on the first !NOMAP memblock, even if it is already
PMD aligned, but beyond that, this looks ok to me.
