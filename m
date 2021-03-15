Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C833B34C
	for <lists+linux-efi@lfdr.de>; Mon, 15 Mar 2021 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCONHT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Mar 2021 09:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhCONHO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Mar 2021 09:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F352F64E38;
        Mon, 15 Mar 2021 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615813634;
        bh=dwMzqEqbRyEHy6ZDlPHQrmjir9Jj/iPjzm9RYMZPdHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wy5T/Q+S/oEVPVnjTbZXcvOGdAuudjJf9cw/dYi3JsRk0ka3ExmCQWPHho7gDaDid
         PCqMAZaUg2oh6+nO1o9gDta1Tj7qZ8XyIeSD534pJI52y4pCFL6GIF5IQUdhkR/7LY
         /JgbD/e5UYSG/F340aAxwRDnwAtZGKix7RUyIxfZ3lZzI88oa3lRaov22XNyZAAXSR
         aXpJtbbGoKA3gizEu6fhO2yl+AkeOokKe1iX1pmmCcMCqNi5yAVtiFlSgH3S1aPXWM
         kNw+IPEQe5wuzZTMWEpyQjcZoHiuH+ET3aSkedivX2xlqcfPSQtaE9LuciEYLBWmXE
         14d2YigGdpQhA==
Received: by mail-oi1-f176.google.com with SMTP id x78so34433088oix.1;
        Mon, 15 Mar 2021 06:07:13 -0700 (PDT)
X-Gm-Message-State: AOAM5328/lVVYHHpi1vPBFZkO34KpJAajnsjXT6yvnlJ70z5i2HaGaq9
        9R8mKXAcucgyH6+9U3M42kvpjKR/qUCY0JqcPkk=
X-Google-Smtp-Source: ABdhPJzkNkbcB9AUdaIHc9ICvRyb0I9rUWRbpYAU4cH/h8XoZLj9S7/PhmILG9e2oM4Jn6Bf+61bLdS2m0gVngoE5AI=
X-Received: by 2002:aca:538c:: with SMTP id h134mr18452821oib.174.1615813633251;
 Mon, 15 Mar 2021 06:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com> <20210315031119.GY17424@dragon>
In-Reply-To: <20210315031119.GY17424@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Mar 2021 14:07:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
Message-ID: <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Shawn Guo <shawn.guo@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Steve McIntyre <steve@einval.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > >
...
> > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > installer.. it might not be the shiny accelerated experience, but you
> > > want to be able to get thru the installer and then install updates to
> > > get latest kernel/dtb/etc
> > >
> > > it is a small use-case, but kinda an important step ;-)
> > >
> >
> > That is a fair point. However, as I understand it, we need this to work around
> > - the need to pass efi=novamap
> > - broken poweroff on Flex5g
>
> One more: broken EFI variable runtime services on all Snapdragon laptops
>
> It's been another pain of running debian-installer (d-i) on these
> laptops, where EFI NV variables are just stored on UFS disk.  So after
> Linux takes over the control of UFS, EFI NV variable runtime services
> then become out of service.  Currently, we have to apply a hack [1] on
> d-i grub-installer to get around the issue,  and it's been the only
> remaining out-of-tree patch we have to carry for d-i.  With this nice
> `OverrideSupported` support, we will be able to drop that hack
> completely.
>
> >
> > So an installer either needs to set the EFI variable, or pass
> > efi=novamap on the first boot. Note that there are no arm64 EFI
> > systems known where efi=novamap causes problems. In fact, I would
> > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > the default and be done with it.
> >
> > Broken poweroff is hardly a showstopper for an installer, given that
> > we cannot even install GRUB correctly.
> >
> > In summary, I am more than happy to collaborate constructively on this
> > (which is why I wrote the patch), but I don't think we're at a point
> > yet where this is the only thing standing in our way when it comes to
> > a smooth out-of-the-box Linux installation experience.
>
> There might be more to be done for getting a smooth Linux installation
> experience.  But IMHO, this `OverrideSupported` thing is definitely
> a big step to that.
>

So the problem here seems to be that grub-install (or efibootmgr)
tolerates efivarfs being absent entirely, but bails out if it exists
but gives an error when trying to access it, right?

This is not only a problem on Snapdragon systems afaik - most Uboot
based arm64 systems booting via EFI are affected by this as well.

So it would be good if we could align with those folks, and maybe the
ones working on RISC-V as well, to see if we can get some consensus
around taking this approach.

For the folks newly cc'ed on this thread: full version here
https://lore.kernel.org/linux-arm-msm/20210306113519.294287-1-ardb@kernel.org/

Note that I am both the author of the patch, and the maintainer
pushing back on it. Please chime in if you think there are reasons why
we want this, something like this or nothing like this.

-- 
Ard.
