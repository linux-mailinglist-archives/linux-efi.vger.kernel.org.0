Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6041727134F
	for <lists+linux-efi@lfdr.de>; Sun, 20 Sep 2020 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgITKGc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Sep 2020 06:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgITKGc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 20 Sep 2020 06:06:32 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00AD20874
        for <linux-efi@vger.kernel.org>; Sun, 20 Sep 2020 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600596392;
        bh=et7XKs/vyDytV1OmwbkPGCd1zk75AYQpKZ35bcrSMwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6egpCazLv48xizbf1qbkQwiyZVLGzbTCD34bJHfvIgADSmJh0t6XBk+yaIyxWFLH
         KZ51CZAY1c6L15OVfcOOinCpQEwo7pqI70llD6h8wudPySR1s3FNUeXeIcY1qXrhAH
         uU8YE3vzPsGp3WNclwMgR/t23YDHE0szENPClE2E=
Received: by mail-oo1-f51.google.com with SMTP id r4so2553460ooq.7
        for <linux-efi@vger.kernel.org>; Sun, 20 Sep 2020 03:06:31 -0700 (PDT)
X-Gm-Message-State: AOAM533mCXBT7Ig6dybzlj2yWYzgLXxRipa/RvkKPboLNDBBTM3i9+cp
        dEexotSPp4JYwi/H/QsKK7zeaBkHhO6oZLbNclo=
X-Google-Smtp-Source: ABdhPJxgEC6a/JQ3aGXJc5FA50M3pLhTsZaAHPr6Q+oEkpLHXXTlH6jBEit0GxMFfpxmkCXhn7Uo8BAT6cYDqT+DQ88=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr29701033ooo.45.1600596391241;
 Sun, 20 Sep 2020 03:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200918103102.18107-1-ardb@kernel.org> <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr>
 <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com> <20200920085752.GX1551@shell.armlinux.org.uk>
In-Reply-To: <20200920085752.GX1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 20 Sep 2020 12:06:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8TTAfer0opzrtQOM8USQS4t0bfwvs7wfZnNCM=1KEMg@mail.gmail.com>
Message-ID: <CAMj1kXG8TTAfer0opzrtQOM8USQS4t0bfwvs7wfZnNCM=1KEMg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 20 Sep 2020 at 10:57, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sun, Sep 20, 2020 at 09:50:30AM +0200, Ard Biesheuvel wrote:
> > On Sun, 20 Sep 2020 at 01:49, Nicolas Pitre <nico@fluxnic.net> wrote:
> > >
> > > On Fri, 18 Sep 2020, Ard Biesheuvel wrote:
> > >
> > > > This series is inspired by Zhei Len's series [0], which updates the
> > > > ARM p2v patching code to optionally support p2v relative alignments
> > > > of as little as 64 KiB.
> > > >
> > > > Reducing this alignment is necessary for some specific Huawei boards,
> > > > but given that reducing this minimum alignment will make the boot
> > > > sequence more robust for all platforms, especially EFI boot, which
> > > > no longer relies on the 128 MB masking of the decompressor load address,
> > > > but uses firmware memory allocation routines to find a suitable spot
> > > > for the decompressed kernel.
> > > >
> > > > This series is not based on Zhei Len's code, but addresses the same
> > > > problem, and takes some feedback given in the review into account:
> > > > - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
> > > >   with the carry on LPAE
> > > > - add support for Thumb2 kernels as well
> > > > - make the change unconditional - it will bit rot otherwise, and has value
> > > >   for other platforms as well.
> > > >
> > > > The first four patches are general cleanup and preparatory changes.
> > > > Patch #5 implements the switch to a MOVW instruction without changing
> > > > the minimum alignment.
> > > > Patch #6 reduces the minimum alignment to 2 MiB.
> > > >
> > > > Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.
> > >
> > > At this point I think this really ought to be split into a file of its
> > > own... and maybe even rewritten in C. Even though I wrote the original
> > > code, I no longer understand it without re-investing time into it. But
> > > in either cases the whole of head.S would need to have its registers
> > > shuffled first to move long lived values away from r0-r3,ip,lr to allow
> > > for standard function calls.
> > >
> >
> > I agree with that in principle, however, running C code with a stack
> > with the MMU off is slightly risky.
>
> It's more than "slightly".  C code has literal addresses, which are raw
> virtual addresses.  These are meaningless with the MMU off.
>
> I guess one could correct the various pointers the code would read, but
> you could not directly access any variable (as that involves
> dereferencing a virtual address stored in the function's literal pool.)
>

We might be able to work around that by compiling with -fPIC, and/or
by ensuring that all inputs to the routine are passed via function
parameters. But I agree that using C for this code is probably not the
right choice.

If there is no disagreement about the 2 MiB alignment, or the choice
of opcodes for the patchable sequences, I can prepare a v2 that fixes
the issues I mentioned, and has some more explanatory comments in the
patching routine.
