Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B01273F87
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIVKXg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 06:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIVKXg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 06:23:36 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09317239D4
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600770215;
        bh=NeXvFecT8aTgw0zCdF9cp4inWyvJZOnMwHOhGJP6iDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+SL+DXggSP/6soXg7zk2CDEEvqiGP/lAe04i+Q25eGqSdPSDFhD8pPS4xV6Rwjbf
         /TE9bX8chsZba4HPjgMCgMUF3JYhgD0XQzMAxSciUoxqAlOKmhYizkukSiJXjU8Ez0
         avRyHQLjY+qmLS3Cfz6oUSXvqJ2Y+ISpi3e8muEg=
Received: by mail-oo1-f44.google.com with SMTP id h8so4001473ooc.12
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 03:23:35 -0700 (PDT)
X-Gm-Message-State: AOAM531NFMpvQCEOEK9yct5OM0kTG9zQLfkWOGKhVCMXuJ2A6K7vDkPJ
        WoB21nxrx3UI3lBDWfHt3j+6RhorJgGwC0MLUtM=
X-Google-Smtp-Source: ABdhPJzvWk8bQPIcG5qAI1/Kp+gerV/zdiJuc5LOXIslLEVyYJHWKvr+Kzk8kWOrdzpJmw4afIQc4F89EOXnCzJbcgU=
X-Received: by 2002:a4a:4910:: with SMTP id z16mr2443658ooa.41.1600770214224;
 Tue, 22 Sep 2020 03:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-11-ardb@kernel.org>
 <CACRpkda=P-Kc=-ZhZo8vtW9CrFfCiBvfkqwfdipz4WO2Gb2L_g@mail.gmail.com>
In-Reply-To: <CACRpkda=P-Kc=-ZhZo8vtW9CrFfCiBvfkqwfdipz4WO2Gb2L_g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 12:23:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+XuauH93OuQzx_2huWrUca+S6SKwqogXiaR2sQB727w@mail.gmail.com>
Message-ID: <CAMj1kXG+XuauH93OuQzx_2huWrUca+S6SKwqogXiaR2sQB727w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: p2v: reduce p2v alignment requirement to 2 MiB
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Sep 2020 at 11:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Update the p2v patching code so we can deal with displacements that are
> > not a multiple of 16 MiB but of 2 MiB, to prevent wasting of up to 14 MiB
> > of physical RAM when running on a platform where the start of memory is
> > not correctly aligned.
> >
> > For the ARM code path, this simply comes down to using two add/sub
> > instructions instead of one for the carryless version, and patching
> > each of them with the correct immediate depending on the rotation
> > field. For the LPAE calculation, it patches the MOVW instruction with
> > up to 12 bits of offset.
> >
> > For the Thumb2 code path, patching more than 11 bits off displacement
> > is somewhat cumbersome, and given that 11 bits produce a minimum
> > alignment of 2 MiB, which is also the granularity for LPAE block
> > mappings, it makes sense to stick to 2 MiB for the new p2v requirement.
> >
> > Suggested-by: Zhen Lei <thunder.leizhen@huawei.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> My understanding of what is going on is limited to the high
> level of things, and being able to do this is just a great thing
> so FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> If you or Russell need more thorough review I can sit down
> and try to understand at the bit granularity what is going on
> but it requires a bunch of time. Just tell me if you need this.
>

Just to summarize the intent of this code: the ARM kernel's linear map
starts at PAGE_OFFSET, which maps to a physical address (PHYS_OFFSET)
that is platform specific, and is discovered at boot. Since we don't
want to slow down translations between physical and virtual addresses
by keeping the offset in a variable in memory, we implement this by
patching the code performing the translation, and putting the offset
between PAGE_OFFSET and the start of physical RAM directly into the
instruction opcodes.

Currently, we only patch up to 8 bits of offset, which gives us 4 GiB
>> 8 == 16 MiB of granularity, and so if the start of physical RAM is
not a multiple of 16 MiB, we have to round it up to the next multiple.
This wastes some physical RAM, since the memory you skipped will now
live below PAGE_OFFSET, making it inaccessible to the kernel.

By changing the patchable sequences and the patching logic to carry
more bits of offset, we can improve this: 11 bits gives us 4 GiB >> 11
== 2 MiB granularity, and so you never waste more than that amount by
rounding up the physical start of DRAM to the next multiple of 2 MiB.
(Note that 2 MiB granularity guarantees that the linear mapping can be
created efficiently, whereas less than 2 MiB may result in the linear
mapping needing another level of page tables)

This helps Zhen Lei's scenario, where the start of DRAM is known to be
occupied. It also helps EFI boot, which relies on the firmware's page
allocator to allocate space for the decompressed kernel as low as
possible. And if the KASLR patches ever land for 32-bit, it will give
us 3 more bits of randomization of the placement of the kernel inside
the linear region.
