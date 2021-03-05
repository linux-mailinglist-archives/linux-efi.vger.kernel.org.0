Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834BA32E32D
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 08:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEHqs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 02:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHqs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 02:46:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52F7265016;
        Fri,  5 Mar 2021 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614930407;
        bh=9no37l2mcL4HeM4gRsSnVUZT4eG33tOMvTKyNCpSgnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g56Wg3jLrbNJ6WH5Mn1LP2BxuYqplNvGzES87Wa2ARLm9xpHSHKozdDG/Xc0fjo/t
         15JRD15iDEJuCIfK7Rz2g4iP9QDZ08Gwo7xq4FKnNpdXIGP15gS46EwRTYTKGWTd45
         1UWmL8cQms90SIU0UJCxST4tGIemYTy7AZZkVmUFZqfvZtIQacoRICXGE09xEgqI9v
         NjXCv9ikPQn736UVqYXEDb/NmZ3PUSduVtZuO4wtc2i0t++MfY3QPEya63KjFeBr7E
         PuBMMSPGrA8pSmn01z2JdoVhoLSPmdjHkRWtuOGwx/Nbg1UIS/Gj/AEj8W1Hsjjj/q
         FsbzspILBvcQg==
Received: by mail-oi1-f172.google.com with SMTP id x78so1584965oix.1;
        Thu, 04 Mar 2021 23:46:47 -0800 (PST)
X-Gm-Message-State: AOAM530wfuR+CI4WPdtl0pxt/SWPiclXtQDCSA9zhLAjJbWGrdxplNfU
        F/bBXyc0ioFd9uWoXpNPKlGwAHmiywlgAQ/1tXE=
X-Google-Smtp-Source: ABdhPJx81Wdfa8N1zz1ziP48o0KMo1wlQaGo+4MKi9qkf9M7bIdU7utaz+Q/jgrOlbi+A1Xbd7fRPjc3ehCaVMouetc=
X-Received: by 2002:aca:538c:: with SMTP id h134mr6015115oib.174.1614930406561;
 Thu, 04 Mar 2021 23:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20210305065120.11355-1-shawn.guo@linaro.org> <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210305073151.GI17424@dragon>
In-Reply-To: <20210305073151.GI17424@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Mar 2021 08:46:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEezoDanHsKiN566r0xP1o8pQBk5UZPff0zYxG+Aw7-Og@mail.gmail.com>
Message-ID: <CAMj1kXEezoDanHsKiN566r0xP1o8pQBk5UZPff0zYxG+Aw7-Og@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: add check for broken efi poweroff
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Mar 2021 at 08:32, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Fri, Mar 05, 2021 at 08:01:02AM +0100, Ard Biesheuvel wrote:
> > On Fri, 5 Mar 2021 at 07:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > Poweroff via UEFI Runtime Services doesn't always work on every single
> > > arm64 machine.  For example, on Lenovo Flex 5G laptop, it results in
> > > a system reboot rather than shutdown.  Add a DMI check to keep such
> > > system stay with the original poweroff method (PSCI).
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >
> > What is the point of using EFI runtime services on this machine if
> > poweroff doesn't work either?
>
> Hmm, I'm not sure how many EFI runtime services are being used by
> kernel, but this is the only one broken I have seen.  Not sure we want
> to disable the whole thing completely.  Also, I'm looking at commit log
> of 0c5ed61adbdb ("efi/reboot: Allow powering off machines using EFI")
> below.
>
>     Not only can EfiResetSystem() be used to reboot, it can also be used to
>     power down machines.
>
>     By and large, this functionality doesn't work very well across the range
>     of EFI machines in the wild, so it should definitely only be used as a
>     last resort. In an ideal world, this wouldn't be needed at all.
>
>     Unfortunately, we're starting to see machines where EFI is the *only*
>     reliable way to power down, and nothing else, not PCI, not ACPI, works.
>
> It seems poweroff via EFI runtime services is known not working for
> every machine, and was meant to be the last resort if nothing else can
> power off system.  If we try PSCI first on arm64, you do not see my
> patch at all :)
>
> > Can't we just boot this thing with
> > efi=noruntime?
>
> We are trying to get arm64 laptop support into distros, and patching
> kernel cmdline with 'efi=novamap' is already a pain.  We do not really
> want to have more of it.
>

I suppose we have to rely on DtbLoader for these platforms anyway,
right? That means we should be able to rely on it to publish a RT_PROP
configuration table which tells the kernel which EFI runtime services
are usable and which are not. This way, we could get rid of
efi=novamap as well.

I'd prefer to rely on that than on DMI quirks - we have not used those
at all on arm64/ARM so far, and the DMI tables are parsed relatively
late, so in some cases, DMI quirks may not be reliable.
