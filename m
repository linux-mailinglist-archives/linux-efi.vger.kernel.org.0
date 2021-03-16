Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01133CEE0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 08:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhCPHxN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 03:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232893AbhCPHxF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 03:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 544B164FED;
        Tue, 16 Mar 2021 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615881185;
        bh=I/XClaeZ5Y5YESvaMnHBrUyvUtBcoM/0Vsx2gaCpdn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KAFl365jRyF7aHDagBBUg0jdYf5J35LsyQyncjY/sVKjNURT+ERa/f7sTyYcIat+P
         jC2+JVN4xMgLuiIhAqxIl0f07AdOz4U+0D4Gr5od/Ac8U57iVDrJjjDWf9F2SOsYWR
         rIwk90i99jvCv4tY1T5TT+MegJaWmowQJu0RktEqlr/Ik+j/aqEfZtCfvnAMGtfJcL
         +2VTO1DEaC7vz5nQCC9K7aVj9NoajuzFEFnk6K149mQkQmi9c4mQUt9wg7467LI3eC
         K7aFW8s/J2wqZxID2JzoxU6CQgnhbCWMMshYZoq/XX4z27KYIsfp8pxzHqo2oHLPpB
         ojP4cceVAqsYw==
Received: by mail-oo1-f53.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so885396ook.2;
        Tue, 16 Mar 2021 00:53:05 -0700 (PDT)
X-Gm-Message-State: AOAM530ZXTjdOtTorj7wH1sR3UHKXp3znceASTwrqhQoDa0XOl1m0MAk
        TE3sf/fB8EoZMNlVvZCHugiIx+cN+OIvLyXH7lQ=
X-Google-Smtp-Source: ABdhPJwrU9gFZ9zoEUvLIk4JX99VDdZoDxhP+GpjxSF2lYV121sNUe2xaguIoJOVkMT+x8vPrNFNzSOANwKyUYDYQp4=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr2663613oop.45.1615881184377;
 Tue, 16 Mar 2021 00:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de>
In-Reply-To: <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 08:52:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
Message-ID: <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Tue, 16 Mar 2021 at 08:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/15/21 2:07 PM, Ard Biesheuvel wrote:
> > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> >>
> >> On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> >>> On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> >>>>
> > ...
> >>>> fwiw, the valid use-case for ACPI boot on these things is for distro
> >>>> installer.. it might not be the shiny accelerated experience, but you
> >>>> want to be able to get thru the installer and then install updates to
> >>>> get latest kernel/dtb/etc
> >>>>
> >>>> it is a small use-case, but kinda an important step ;-)
> >>>>
> >>>
> >>> That is a fair point. However, as I understand it, we need this to work around
> >>> - the need to pass efi=novamap
> >>> - broken poweroff on Flex5g
> >>
> >> One more: broken EFI variable runtime services on all Snapdragon laptops
> >>
> >> It's been another pain of running debian-installer (d-i) on these
> >> laptops, where EFI NV variables are just stored on UFS disk.  So after
> >> Linux takes over the control of UFS, EFI NV variable runtime services
> >> then become out of service.  Currently, we have to apply a hack [1] on
> >> d-i grub-installer to get around the issue,  and it's been the only
> >> remaining out-of-tree patch we have to carry for d-i.  With this nice
> >> `OverrideSupported` support, we will be able to drop that hack
> >> completely.
> >>
> >>>
> >>> So an installer either needs to set the EFI variable, or pass
> >>> efi=novamap on the first boot. Note that there are no arm64 EFI
> >>> systems known where efi=novamap causes problems. In fact, I would
> >>> prefer to stop using SetVirtualAddressMap() altogether, as it does not
> >>> provide any benefit whatsoever. So perhaps we should make efi=novamap
> >>> the default and be done with it.
> >>>
> >>> Broken poweroff is hardly a showstopper for an installer, given that
> >>> we cannot even install GRUB correctly.
> >>>
> >>> In summary, I am more than happy to collaborate constructively on this
> >>> (which is why I wrote the patch), but I don't think we're at a point
> >>> yet where this is the only thing standing in our way when it comes to
> >>> a smooth out-of-the-box Linux installation experience.
> >>
> >> There might be more to be done for getting a smooth Linux installation
> >> experience.  But IMHO, this `OverrideSupported` thing is definitely
> >> a big step to that.
> >>
> >
> > So the problem here seems to be that grub-install (or efibootmgr)
> > tolerates efivarfs being absent entirely, but bails out if it exists
> > but gives an error when trying to access it, right?
> >
> > This is not only a problem on Snapdragon systems afaik - most Uboot
> > based arm64 systems booting via EFI are affected by this as well.
> >
> > So it would be good if we could align with those folks, and maybe the
> > ones working on RISC-V as well, to see if we can get some consensus
> > around taking this approach.
> >
> > For the folks newly cc'ed on this thread: full version here
> > https://lore.kernel.org/linux-arm-msm/20210306113519.294287-1-ardb@kernel.org/
> >
> > Note that I am both the author of the patch, and the maintainer
> > pushing back on it. Please chime in if you think there are reasons why
> > we want this, something like this or nothing like this.
> >
> Hello Ard,
>
> looking at this thread it is hard to understand why this patch should be
> needed.
>
> If an UEFI application does not want to consume a service, it can do so
> without having to manipulate the RT properties table.
>
> Which UEFI applications are broken? Why can't they be fixed instead of
> patching the kernel?
>
> Can we have complete descriptions of the deficiencies of the involved
> applications. I saw GRUB and the Debian installer mentioned in the
> thread. Are there others?
>

The problem is that the proprietary EDK2 / UEFI firmware on Qualcomm
Snapdragon based laptops that were built to run Windows does not
implement get/setvariable after ExitBootServices. Instead, every call
to any of the variable services returns with an EFI_UNSUPPORTED error.

The correct way to address this is a RT_PROP table that encodes this
behavior, and this is what we added in the special DtbLoader driver
that is used to boot Linux in DT mode (as the firmware only implements
ACPI support). So for systems that can/will run DtbLoader, the problem
is solved.

What remains is ACPI boot, or boot modes where DtbLoader does not
work. In those cases, it would be useful to have another way to convey
this information to the OS in a way that does not rely on the kernel
command line.

But thinking about this, perhaps we should be fixing this in
efibootmgr instead. EFI_UNSUPPORTED is a valid and documented return
code that conveys that the operation did not fail with an error, but
that efibootmgr is not supported to begin with on the platform in
question.
