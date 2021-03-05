Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38EA32E386
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEIVp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 03:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhCEIVo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 03:21:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B0F65015;
        Fri,  5 Mar 2021 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932504;
        bh=z5/8nOwLVwysP7HryeF9PRB1jXQFPR2i5TnYr3KfMaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H/DVvuXDuTfC06aiIEii67Nhw/2OAFT5riRlHSlZv5TXEMaxqFiV1EjSFluUprhPS
         aEijHaQnKRb0bKLUaOOGWRz3N8sieBLhqmKzGXZBu4vys1EAuzID/0nTWdMWH4EEKT
         Nmuv883/Zk22JbYKrTfM3FM9XAoGjmomgBw7zn5H4vigMJVz6Opb1wxgHs1b9jthdS
         Vl2BRvAXO6/K0jtIDboS3OQSBHVkEd8a2h+99otTZ/5dgwBW33CXo8wFw5vUgq52GK
         95hVsAqpiOHYCYEmHXtgA0YrdoZXhHdWUULe1xHJL09wUTfqFHJpG9gJabqDgNwTyt
         gBTamdav5su4g==
Received: by mail-oi1-f178.google.com with SMTP id a13so1677964oid.0;
        Fri, 05 Mar 2021 00:21:44 -0800 (PST)
X-Gm-Message-State: AOAM531uuHIXlPzSDaOk5ibNUSnGM1XfsrD0JIMoz6KAC+7ZTQlezmB4
        9vQpOa1XP6WZ7pCpDm+AVCA9TOjkqocBOFz3e64=
X-Google-Smtp-Source: ABdhPJwj8BB6dNFHnOuGctyF8kVr+rDGVNQf+qosBKdWt4Ja7C2SJ3mlXiBTPqvx/GEx+2+VQ8EEYmRka4/ntFbW7LI=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr6193604oif.47.1614932503446;
 Fri, 05 Mar 2021 00:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20210305065120.11355-1-shawn.guo@linaro.org> <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210305073151.GI17424@dragon> <CAMj1kXEezoDanHsKiN566r0xP1o8pQBk5UZPff0zYxG+Aw7-Og@mail.gmail.com>
 <20210305080245.GJ17424@dragon>
In-Reply-To: <20210305080245.GJ17424@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Mar 2021 09:21:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGMqLMsNfT76Zd3jMfTmEz5f9FtFJfYT8-mtDSooG+Ohw@mail.gmail.com>
Message-ID: <CAMj1kXGMqLMsNfT76Zd3jMfTmEz5f9FtFJfYT8-mtDSooG+Ohw@mail.gmail.com>
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

On Fri, 5 Mar 2021 at 09:02, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Fri, Mar 05, 2021 at 08:46:35AM +0100, Ard Biesheuvel wrote:
> > On Fri, 5 Mar 2021 at 08:32, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Fri, Mar 05, 2021 at 08:01:02AM +0100, Ard Biesheuvel wrote:
> > > > On Fri, 5 Mar 2021 at 07:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > >
> > > > > Poweroff via UEFI Runtime Services doesn't always work on every single
> > > > > arm64 machine.  For example, on Lenovo Flex 5G laptop, it results in
> > > > > a system reboot rather than shutdown.  Add a DMI check to keep such
> > > > > system stay with the original poweroff method (PSCI).
> > > > >
> > > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > >
> > > > What is the point of using EFI runtime services on this machine if
> > > > poweroff doesn't work either?
> > >
> > > Hmm, I'm not sure how many EFI runtime services are being used by
> > > kernel, but this is the only one broken I have seen.  Not sure we want
> > > to disable the whole thing completely.  Also, I'm looking at commit log
> > > of 0c5ed61adbdb ("efi/reboot: Allow powering off machines using EFI")
> > > below.
> > >
> > >     Not only can EfiResetSystem() be used to reboot, it can also be used to
> > >     power down machines.
> > >
> > >     By and large, this functionality doesn't work very well across the range
> > >     of EFI machines in the wild, so it should definitely only be used as a
> > >     last resort. In an ideal world, this wouldn't be needed at all.
> > >
> > >     Unfortunately, we're starting to see machines where EFI is the *only*
> > >     reliable way to power down, and nothing else, not PCI, not ACPI, works.
> > >
> > > It seems poweroff via EFI runtime services is known not working for
> > > every machine, and was meant to be the last resort if nothing else can
> > > power off system.  If we try PSCI first on arm64, you do not see my
> > > patch at all :)
> > >
> > > > Can't we just boot this thing with
> > > > efi=noruntime?
> > >
> > > We are trying to get arm64 laptop support into distros, and patching
> > > kernel cmdline with 'efi=novamap' is already a pain.  We do not really
> > > want to have more of it.
> > >
> >
> > I suppose we have to rely on DtbLoader for these platforms anyway,
> > right? That means we should be able to rely on it to publish a RT_PROP
> > configuration table which tells the kernel which EFI runtime services
> > are usable and which are not. This way, we could get rid of
> > efi=novamap as well.
>
> Two things:
>
> - DtbLoader is loaded as an EFI driver.  It works fine on Yoga C630, but
>   it's not loaded by Flex 5G UEFI for some reason.  So DtbLoader is not
>   really working on Flex 5G at this point.
>
> - We are running not only DT kernel on these laptops but also ACPI
>   kernel in which case DtbLoader shouldn't needed.
>
> > I'd prefer to rely on that than on DMI quirks - we have not used those
> > at all on arm64/ARM so far, and the DMI tables are parsed relatively
> > late, so in some cases, DMI quirks may not be reliable.
>
> I'm all ears in case there are other runtime mechanisms to get around
> it.
>

What we could do is:
- implement missing support for dealing with RT_PROP before calling
SetVirtualAddressMap() - this would remove the need for passing
efi=novamap if RT_PROP exists and marks SetVirtualAddressMap as
supported
- implement support to the EFI stub for a Linux specific EFI variable
RtPropOverride that is either masked with the existing RT_PROP value,
or installed if no RT_PROP table exists.

This way, you would only have to set a EFI variable a single time
before boot, and the Linux kernel would take it into account every
subsequent boot. The EFI stub is guaranteed to run before anything
else, so it is guaranteed to be timely (as opposed to DMI quirks on
arm64)
