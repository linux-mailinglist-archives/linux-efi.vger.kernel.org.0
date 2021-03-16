Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA13D33CF71
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 09:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhCPIOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 04:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234200AbhCPIOe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 04:14:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 348E964FF5;
        Tue, 16 Mar 2021 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615882474;
        bh=ahLGAVE7zPR1GGo6LH2xC3nHK47x45Fy/HZhjstR2U0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oGJAoMFR9WNpkEvgvjb04bIVZTdAfmT8MW0uq+dcKnwk1HIBx2w0aNjAytwMj+HsJ
         w229QxfXz3ouS+NHZZzqA7YF4hxKZMZQdct889YEf122ZtAMmqOt3/jgEfC1n5XQqS
         jCa88BsdWPlrwGp0hmDrcOJeZqBFHWtg4kdVC3aTUKWYDKizXUSOWkSMTJR63+MKDl
         VHvsjxcHDQUp1R2QEIkS8DOsQWy68OCjg503ca3T7i1twhmW4kWLNYgI9AgAAfIaqO
         K22u97FUI05F9zKPM1iqOwUYvmB1UAuD95w1NKkiD/LoBxUtWEbOZO1nTsc9qXe99Q
         9Nq1wGP1WohgA==
Received: by mail-ot1-f44.google.com with SMTP id m1so8085414ote.10;
        Tue, 16 Mar 2021 01:14:34 -0700 (PDT)
X-Gm-Message-State: AOAM531EUvUI4dRh+80ebD7OmyS2F7SDRJXeH+2PhL8Q15ho8KScGls1
        ZzHxcLTabRjJRCHSOLUMWk8ExOpJmHxkeSnqjyM=
X-Google-Smtp-Source: ABdhPJyqhfBgouU8ECJNbkVW4mSOVfeFVz4PjhIMbxLbOzB9ewTgcb+yzOtymRyPcEWWqBYGWzUh24Yuu230tum0T98=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr2647710otr.77.1615882473425;
 Tue, 16 Mar 2021 01:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de> <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
 <YFBmfC6vNE6fXWwN@enceladus>
In-Reply-To: <YFBmfC6vNE6fXWwN@enceladus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 09:14:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEz++tPZO5Bzw9f+_PzzRoN7m6fXUi3kKTXvMANpzaKpg@mail.gmail.com>
Message-ID: <CAMj1kXEz++tPZO5Bzw9f+_PzzRoN7m6fXUi3kKTXvMANpzaKpg@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Shawn Guo <shawn.guo@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Mar 2021 at 09:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ard,
>
> On Tue, Mar 16, 2021 at 08:52:52AM +0100, Ard Biesheuvel wrote:
> > On Tue, 16 Mar 2021 at 08:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
...
> > > looking at this thread it is hard to understand why this patch should be
> > > needed.
> > >
> > > If an UEFI application does not want to consume a service, it can do so
> > > without having to manipulate the RT properties table.
> > >
> > > Which UEFI applications are broken? Why can't they be fixed instead of
> > > patching the kernel?
> > >
> > > Can we have complete descriptions of the deficiencies of the involved
> > > applications. I saw GRUB and the Debian installer mentioned in the
> > > thread. Are there others?
> > >
> >
> > The problem is that the proprietary EDK2 / UEFI firmware on Qualcomm
> > Snapdragon based laptops that were built to run Windows does not
> > implement get/setvariable after ExitBootServices. Instead, every call
> > to any of the variable services returns with an EFI_UNSUPPORTED error.
> >
> > The correct way to address this is a RT_PROP table that encodes this
> > behavior, and this is what we added in the special DtbLoader driver
> > that is used to boot Linux in DT mode (as the firmware only implements
> > ACPI support). So for systems that can/will run DtbLoader, the problem
> > is solved.
> >
> > What remains is ACPI boot, or boot modes where DtbLoader does not
> > work. In those cases, it would be useful to have another way to convey
> > this information to the OS in a way that does not rely on the kernel
> > command line.
> >
> > But thinking about this, perhaps we should be fixing this in
> > efibootmgr instead. EFI_UNSUPPORTED is a valid and documented return
> > code that conveys that the operation did not fail with an error, but
> > that efibootmgr is not supported to begin with on the platform in
> > question.
>
> It all depends on how smart we want to make the efi stub. In essence
> it's an OS loader, that we have complete control over and we can play tricks
> on broken/incompatible firmwares, but is that what we want ? And if yes, were
> do we draw the line of what we fix or not?
>
> I think the current problem doesn't make a strong case to add such
> functionality. U-Boot doesn't expose SetVariable at all, but even if it did
> and returned EFI_UNSUPPORTED, I'd expect the consuming applications to handle
> the error gracefully.  I mean why should we treat EFI_UNSUPPORTED differently
> than EFI_DEVICE_ERROR or EFI_INVALID_PARAMETER (or all the allowed return
> codes)?
>

EFI_DEVICE_ERROR or EFI_INVALID_PARAMETER means that the particular
call resulted in an error, which may be related to the values of the
arguments, the state of the the flash, etc etc

EFI_UNSUPPORTED means that the platform in question does not support
the routine at all at runtime, and the arguments or the context is
irrelevant.

Given that GRUB already tolerates the second condition, but only if it
is communicated explicitly (via --no-nvram) or implicitly when
efivarfs is absent altogether, I am saying that we should classify a
EFI_UNSUPPORTED return value in the same way, and tolerate it rather
than abort the install.
