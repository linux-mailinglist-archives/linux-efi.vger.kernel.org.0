Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31433EA51
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCQG6g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 02:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCQG6O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 02:58:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCCC764FAB;
        Wed, 17 Mar 2021 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615964293;
        bh=pZur2g18+g/k3AgoQgzSEjl72nnW18xv3ZaC60WZwnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h4evmUtxYgvxRHZvxXQw+DZtutB+TLnLlVl/tzXIR6gPQOSVJHnhBtMrOzFFoLWf2
         Anji1QQdZuZUoCkIHx/RRmF1JeQzA1q297gBenJJDTIl2b0iEbzEw0x1xf5TKQ9fdF
         5AHBDbIYSHr+pPQfxd5WVyvz7P2+vQnYiPtA06QOjY8OuWFxHOS6dgT7pvBXn+78/+
         mH3q0GE1RUGYvfnAUwuI/brRhxV9k0ynH0OuTBLlyjfRXD3DGyY1k5hoX+FLyc7Ay8
         zTDZl/yiNbTl+outIhP3oV8IanH33maN+520jgPpd8+T+bYek0qHsPXDSJHGoxFmFt
         416BV8W7F83sg==
Received: by mail-oi1-f180.google.com with SMTP id d16so31492990oic.0;
        Tue, 16 Mar 2021 23:58:13 -0700 (PDT)
X-Gm-Message-State: AOAM530eXVvV1LBdrWmZi9Gt8qMdeeWHRL5O36QYd8GxiqTIgR6+RlLa
        QIJ5wmUDmE1YpgNPAcmhwql4y1PKqS8AluxTzdU=
X-Google-Smtp-Source: ABdhPJyTdhu45EZ/oT1/xgXJS9r1w30xFh1yO5KzqQN4ccuts9Zl251vdiRw+jorxntCIoGtUeiUnii+y4wygCIVvEA=
X-Received: by 2002:aca:538c:: with SMTP id h134mr1731364oib.174.1615964292942;
 Tue, 16 Mar 2021 23:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon> <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon> <CAMj1kXEqbjy1x=sN=X6bwnO4Y47MsKxL9dX6VPfpE0-KGovA6Q@mail.gmail.com>
 <20210317063602.GC32651@dragon>
In-Reply-To: <20210317063602.GC32651@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Mar 2021 07:58:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHC9cOHoBKYdi353SzMui8BSkA7Cp4wiDs3mTVLFAMk-g@mail.gmail.com>
Message-ID: <CAMj1kXHC9cOHoBKYdi353SzMui8BSkA7Cp4wiDs3mTVLFAMk-g@mail.gmail.com>
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

On Wed, 17 Mar 2021 at 07:36, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Tue, Mar 16, 2021 at 10:33:17AM +0100, Ard Biesheuvel wrote:
> > On Tue, 16 Mar 2021 at 10:06, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 08:57:19AM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 16 Mar 2021 at 08:52, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > >
> > > > > On Mon, Mar 15, 2021 at 02:07:01PM +0100, Ard Biesheuvel wrote:
> > > > > > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > > > > > > > >
> > > > > > ...
> > > > > > > > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > > > > > > > installer.. it might not be the shiny accelerated experience, but you
> > > > > > > > > want to be able to get thru the installer and then install updates to
> > > > > > > > > get latest kernel/dtb/etc
> > > > > > > > >
> > > > > > > > > it is a small use-case, but kinda an important step ;-)
> > > > > > > > >
> > > > > > > >
> > > > > > > > That is a fair point. However, as I understand it, we need this to work around
> > > > > > > > - the need to pass efi=novamap
> > > > > > > > - broken poweroff on Flex5g
> > > > > > >
> > > > > > > One more: broken EFI variable runtime services on all Snapdragon laptops
> > > > > > >
> > > > > > > It's been another pain of running debian-installer (d-i) on these
> > > > > > > laptops, where EFI NV variables are just stored on UFS disk.  So after
> > > > > > > Linux takes over the control of UFS, EFI NV variable runtime services
> > > > > > > then become out of service.  Currently, we have to apply a hack [1] on
> > > > > > > d-i grub-installer to get around the issue,  and it's been the only
> > > > > > > remaining out-of-tree patch we have to carry for d-i.  With this nice
> > > > > > > `OverrideSupported` support, we will be able to drop that hack
> > > > > > > completely.
> > > > > > >
> > > > > > > >
> > > > > > > > So an installer either needs to set the EFI variable, or pass
> > > > > > > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > > > > > > systems known where efi=novamap causes problems. In fact, I would
> > > > > > > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > > > > > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > > > > > > the default and be done with it.
> > > > > > > >
> > > > > > > > Broken poweroff is hardly a showstopper for an installer, given that
> > > > > > > > we cannot even install GRUB correctly.
> > > > > > > >
> > > > > > > > In summary, I am more than happy to collaborate constructively on this
> > > > > > > > (which is why I wrote the patch), but I don't think we're at a point
> > > > > > > > yet where this is the only thing standing in our way when it comes to
> > > > > > > > a smooth out-of-the-box Linux installation experience.
> > > > > > >
> > > > > > > There might be more to be done for getting a smooth Linux installation
> > > > > > > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > > > > > > a big step to that.
> > > > > > >
> > > > > >
> > > > > > So the problem here seems to be that grub-install (or efibootmgr)
> > > > > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > > > > but gives an error when trying to access it, right?
> > > > >
> > > > > Yes, with EFI variables runtime service marked as unsupported,
> > > > > efibootmgr will just exit on efi_variables_supported() check [1] in
> > > > > a way that its parent process, i.e. grub-install, doesn't take as an
> > > > > error.  But otherwise, efibootmgr will go much further and exit with
> > > > > a real error when trying to access efivars.
> > > > >
> > > >
> > > > OK, so I suggest we fix efibootmgr, by extending the
> > > > efi_variables_supported() check to perform a GetVariable() call on an
> > > > arbitrary variable (e.g., BootOrder),
> > >
> > > Hmm, I'm not sure we should ask more from user space, as it's already
> > > been doing the right thing, and efi_variables_supported() is proved to
> > > work properly with any sane low-level software (kernel + firmware),
> > > either EFI variables service is supported or not.  That said, IMHO,
> > > right now the low-level software on Snapdragon laptops is insane, i.e.
> > > the unsupported/broken EFI runtime services are not communicated to
> > > user space properly in established way.
> > >
> >
> > I disagree.
> >
> > My Yoga returns
> >
> > efivars: get_next_variable: status=8000000000000003
> >
> > which is documented in the UEFI spec 2.8B section 8.2 as
> >
> > """
> > EFI_UNSUPPORTED
> > After ExitBootServices() has been called, this return code may be
> > returned if no variable storage is supported. The platform should
> > describe this runtime service as unsupported at runtime via an
> > EFI_RT_PROPERTIES_TABLE configuration table.
> > """
> >
> > No other condition is documented under which GetNextVariable() can
> > return EFI_UNSUPPORTED, so it is perfectly suitable to decide whether
> > the platform in question supports variable services at runtime at all.
>
> I'm not arguing against ideal of checking EFI_UNSUPPORTED.  Instead, I
> agree with that.  What I'm arguing is that this should be done by kernel
> rather than efibootmgr.  The efi_variables_supported() of efibootmgr
> checks EFIVARFS_MAGIC on /sys/firmware/efi/efivars.  So if we have kernel
> function efivar_init() check and respect EFI_UNSUPPORTED return and stop
> right there, we are all good then.  Could you take a look at the patch
> attached and see if it's acceptable?
>
> Shawn
>
> ------8<---------------
>
> From a30a9a03ed254e0f893b831618b30eaffe7f2da7 Mon Sep 17 00:00:00 2001
> From: Shawn Guo <shawn.guo@linaro.org>
> Date: Wed, 17 Mar 2021 11:57:58 +0800
> Subject: [PATCH] efivars: respect EFI_UNSUPPORTED return from firmware
>
> As per UEFI spec 2.8B section 8.2, EFI_UNSUPPORTED may be returned by
> EFI variable runtime services if no variable storage is supported by
> firmware.  In this case, there is no point for kernel to continue
> efivars initialization.  That said, efivar_init() should fail by
> returning an error code, so that efivarfs will not be mounted on
> /sys/firmware/efi/efivars at all.  Otherwise, user space like efibootmgr
> will be confused by the EFIVARFS_MAGIC seen there, while EFI variable
> calls cannot be made successfully.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Yes, this makes sense.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I'll queue this up


> ---
>  drivers/firmware/efi/vars.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 41c1d00bf933..abdc8a6a3963 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -484,6 +484,10 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
>                                 }
>                         }
>
> +                       break;
> +               case EFI_UNSUPPORTED:
> +                       err = -EOPNOTSUPP;
> +                       status = EFI_NOT_FOUND;
>                         break;
>                 case EFI_NOT_FOUND:
>                         break;
> --
> 2.17.1
>
