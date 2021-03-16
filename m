Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4404233D0E1
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCPJdi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 05:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhCPJda (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 05:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0205965018;
        Tue, 16 Mar 2021 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615887210;
        bh=4HrhOKCg5Py92p0bw8neHvMgb9liN1tOBwXB2YZYcNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rc4YX/Wi66Vpog07CCLFnB3PwLKcUctX+HBTl6lSBTiV2Rz9FYdbuDrKc8wFiOIxM
         56eXAIvSRISrZnirnGNovtORrGwk3dvwIfpx7A8ikbU0qvZDTNKjjRANBoKdyjxrKx
         9lWdBWBk/CVeZhv5jtu3P1d+YdoZuhR8VOrxNJd49wPxcj2kFMoycFau+obPFe24wa
         CsWFlXTJWWTSgYctcUBo7pBrxQ8n1BpJGV8O6qNZ0QpBk0Dfc4GNejkPfBL8BrSCx9
         b9FWvswlzU3j5ISfFcPuOPhhzZqhM3DLu0lWaepmTA+pRGIaU8L0s8SloVs8YzxhWW
         txNWqDHCWfLFA==
Received: by mail-oi1-f171.google.com with SMTP id v192so29883547oia.5;
        Tue, 16 Mar 2021 02:33:29 -0700 (PDT)
X-Gm-Message-State: AOAM532YwODy1iOGx2jd6gxbcYY8Sg1alcM7nsD98Zqe2e21Pr22ruVi
        4p4Shr1kPEewR475MeqIJkAdJMWwJvbbmpgpj2o=
X-Google-Smtp-Source: ABdhPJz4aVCLTwoZfrDr6cQz1iXamXodmGHqrFONTTFHNRsIMdKxN0zAnJvWff8hjMskeiUe8ZCRcEOv/NrXwdlf5dc=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr2819195oia.33.1615887209193;
 Tue, 16 Mar 2021 02:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon> <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon>
In-Reply-To: <20210316090609.GB32651@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 10:33:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEqbjy1x=sN=X6bwnO4Y47MsKxL9dX6VPfpE0-KGovA6Q@mail.gmail.com>
Message-ID: <CAMj1kXEqbjy1x=sN=X6bwnO4Y47MsKxL9dX6VPfpE0-KGovA6Q@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

On Tue, 16 Mar 2021 at 10:06, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Tue, Mar 16, 2021 at 08:57:19AM +0100, Ard Biesheuvel wrote:
> > On Tue, 16 Mar 2021 at 08:52, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Mon, Mar 15, 2021 at 02:07:01PM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > >
> > > > > On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > > > > > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > > > > > >
> > > > ...
> > > > > > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > > > > > installer.. it might not be the shiny accelerated experience, but you
> > > > > > > want to be able to get thru the installer and then install updates to
> > > > > > > get latest kernel/dtb/etc
> > > > > > >
> > > > > > > it is a small use-case, but kinda an important step ;-)
> > > > > > >
> > > > > >
> > > > > > That is a fair point. However, as I understand it, we need this to work around
> > > > > > - the need to pass efi=novamap
> > > > > > - broken poweroff on Flex5g
> > > > >
> > > > > One more: broken EFI variable runtime services on all Snapdragon laptops
> > > > >
> > > > > It's been another pain of running debian-installer (d-i) on these
> > > > > laptops, where EFI NV variables are just stored on UFS disk.  So after
> > > > > Linux takes over the control of UFS, EFI NV variable runtime services
> > > > > then become out of service.  Currently, we have to apply a hack [1] on
> > > > > d-i grub-installer to get around the issue,  and it's been the only
> > > > > remaining out-of-tree patch we have to carry for d-i.  With this nice
> > > > > `OverrideSupported` support, we will be able to drop that hack
> > > > > completely.
> > > > >
> > > > > >
> > > > > > So an installer either needs to set the EFI variable, or pass
> > > > > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > > > > systems known where efi=novamap causes problems. In fact, I would
> > > > > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > > > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > > > > the default and be done with it.
> > > > > >
> > > > > > Broken poweroff is hardly a showstopper for an installer, given that
> > > > > > we cannot even install GRUB correctly.
> > > > > >
> > > > > > In summary, I am more than happy to collaborate constructively on this
> > > > > > (which is why I wrote the patch), but I don't think we're at a point
> > > > > > yet where this is the only thing standing in our way when it comes to
> > > > > > a smooth out-of-the-box Linux installation experience.
> > > > >
> > > > > There might be more to be done for getting a smooth Linux installation
> > > > > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > > > > a big step to that.
> > > > >
> > > >
> > > > So the problem here seems to be that grub-install (or efibootmgr)
> > > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > > but gives an error when trying to access it, right?
> > >
> > > Yes, with EFI variables runtime service marked as unsupported,
> > > efibootmgr will just exit on efi_variables_supported() check [1] in
> > > a way that its parent process, i.e. grub-install, doesn't take as an
> > > error.  But otherwise, efibootmgr will go much further and exit with
> > > a real error when trying to access efivars.
> > >
> >
> > OK, so I suggest we fix efibootmgr, by extending the
> > efi_variables_supported() check to perform a GetVariable() call on an
> > arbitrary variable (e.g., BootOrder),
>
> Hmm, I'm not sure we should ask more from user space, as it's already
> been doing the right thing, and efi_variables_supported() is proved to
> work properly with any sane low-level software (kernel + firmware),
> either EFI variables service is supported or not.  That said, IMHO,
> right now the low-level software on Snapdragon laptops is insane, i.e.
> the unsupported/broken EFI runtime services are not communicated to
> user space properly in established way.
>

I disagree.

My Yoga returns

efivars: get_next_variable: status=8000000000000003

which is documented in the UEFI spec 2.8B section 8.2 as

"""
EFI_UNSUPPORTED
After ExitBootServices() has been called, this return code may be
returned if no variable storage is supported. The platform should
describe this runtime service as unsupported at runtime via an
EFI_RT_PROPERTIES_TABLE configuration table.
"""

No other condition is documented under which GetNextVariable() can
return EFI_UNSUPPORTED, so it is perfectly suitable to decide whether
the platform in question supports variable services at runtime at all.

Ideally, the platform should describe this in the RT_PROP table, but
the spec is very clear that the runtime services themselves should
still be callable, but return EFI_UNSUPPORTED in that case.
