Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A53271566
	for <lists+linux-efi@lfdr.de>; Sun, 20 Sep 2020 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITPer (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Sep 2020 11:34:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64254 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPer (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Sep 2020 11:34:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01586F0E7C;
        Sun, 20 Sep 2020 11:34:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Pu+Nl06mU4BQsTP8A4qVneKlwYk=; b=LFbQvr
        y1zgIdh5TbFJI2sFlGRTuIR21EBcJdRshTZKC88KOvn5t2NrtPrIM3gSJGNz154R
        baEMUNnR1BcN0Y5v+1W4G31AnCa6ERcxBuDXHWqVeW2ThdyVM3+ijwrZT+DAAjHq
        FJ7E707T9A8BwXANF/p2gUnVrLE7Rqp1cvgH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDA63F0E7B;
        Sun, 20 Sep 2020 11:34:46 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=T/kxNf1Ij4YYPiKxHiJkJdspJlEaXbAYiyn4rlaI9tI=; b=dVwpau7LeoJWTwThNRLjQWMc7UPTiMCr7RmCaBtXQlGZar/9Ji0hUuM8FI/iHSL9CPRWwN5Zq0uEQzOFpvxcwyTVpRznmEbs5KwKdVYPGkonefR6ehafLWLtUtfbNs/WHPRgB/w25pBOJNhlXJPvwXoLjr+ZCHow7/IRn/i1WHw=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D883CF0E79;
        Sun, 20 Sep 2020 11:34:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 0C2E92DA0208;
        Sun, 20 Sep 2020 11:34:42 -0400 (EDT)
Date:   Sun, 20 Sep 2020 11:34:41 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
In-Reply-To: <CAMj1kXG8TTAfer0opzrtQOM8USQS4t0bfwvs7wfZnNCM=1KEMg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009201127420.1560@knanqh.ubzr>
References: <20200918103102.18107-1-ardb@kernel.org> <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr> <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com> <20200920085752.GX1551@shell.armlinux.org.uk>
 <CAMj1kXG8TTAfer0opzrtQOM8USQS4t0bfwvs7wfZnNCM=1KEMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CE885EB6-FB56-11EA-854C-843F439F7C89-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 20 Sep 2020, Ard Biesheuvel wrote:

> On Sun, 20 Sep 2020 at 10:57, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, Sep 20, 2020 at 09:50:30AM +0200, Ard Biesheuvel wrote:
> > > On Sun, 20 Sep 2020 at 01:49, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > >
> > > > On Fri, 18 Sep 2020, Ard Biesheuvel wrote:
> > > >
> > > > > This series is inspired by Zhei Len's series [0], which updates the
> > > > > ARM p2v patching code to optionally support p2v relative alignments
> > > > > of as little as 64 KiB.
> > > > >
> > > > > Reducing this alignment is necessary for some specific Huawei boards,
> > > > > but given that reducing this minimum alignment will make the boot
> > > > > sequence more robust for all platforms, especially EFI boot, which
> > > > > no longer relies on the 128 MB masking of the decompressor load address,
> > > > > but uses firmware memory allocation routines to find a suitable spot
> > > > > for the decompressed kernel.
> > > > >
> > > > > This series is not based on Zhei Len's code, but addresses the same
> > > > > problem, and takes some feedback given in the review into account:
> > > > > - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
> > > > >   with the carry on LPAE
> > > > > - add support for Thumb2 kernels as well
> > > > > - make the change unconditional - it will bit rot otherwise, and has value
> > > > >   for other platforms as well.
> > > > >
> > > > > The first four patches are general cleanup and preparatory changes.
> > > > > Patch #5 implements the switch to a MOVW instruction without changing
> > > > > the minimum alignment.
> > > > > Patch #6 reduces the minimum alignment to 2 MiB.
> > > > >
> > > > > Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.
> > > >
> > > > At this point I think this really ought to be split into a file of its
> > > > own... and maybe even rewritten in C. Even though I wrote the original
> > > > code, I no longer understand it without re-investing time into it. But
> > > > in either cases the whole of head.S would need to have its registers
> > > > shuffled first to move long lived values away from r0-r3,ip,lr to allow
> > > > for standard function calls.
> > > >
> > >
> > > I agree with that in principle, however, running C code with a stack
> > > with the MMU off is slightly risky.
> >
> > It's more than "slightly".  C code has literal addresses, which are raw
> > virtual addresses.  These are meaningless with the MMU off.
> >
> > I guess one could correct the various pointers the code would read, but
> > you could not directly access any variable (as that involves
> > dereferencing a virtual address stored in the function's literal pool.)
> >
> 
> We might be able to work around that by compiling with -fPIC, and/or
> by ensuring that all inputs to the routine are passed via function
> parameters. But I agree that using C for this code is probably not the
> right choice.

Yeah... It is doable, like we do in the decompressor case, but the level 
of caution needed here would probably negate the gain from writing this 
in C.

The argument for moving it out to a file of its own still stands though.

> If there is no disagreement about the 2 MiB alignment, or the choice
> of opcodes for the patchable sequences, I can prepare a v2 that fixes
> the issues I mentioned, and has some more explanatory comments in the
> patching routine.

Yes please. Given you do have it all in your head now, it would be very 
valuable to be way more expensive with comments. Adding a comment block 
with the opcode bit definition before the code that transforms them 
would also be nice.


Nicolas
