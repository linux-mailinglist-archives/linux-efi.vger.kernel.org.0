Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86D33D576
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 15:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhCPOGj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 10:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhCPOGW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 10:06:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CDC065070;
        Tue, 16 Mar 2021 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615903582;
        bh=QpGJG3enhPaO+YBVpn/vdOF7EseWR3eGbIQRUN4aCiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=daNB/JBdRFY9JwVKd46PcmSQixlA1PbsJt/jtO0DxLtU+XxmPFhK5ItKVBcDb1utg
         rbF/PWovsvLc+/h/PmPmUJZjECsyrOrRIotwV0yo0+VixP+auj27AqUyAn+9f9EOQr
         6DKYuJ3l6mei1c3T4Vw4h2rFdRH6xyI84opxTkJoPrr/IlfOPd6cdhTEOGrT7cXMeF
         PW9JxW87EiHT2fkhKudo9e9gLAh/YmwhOoEicg2LdAYLx40b1FWEFKb0DBH3w+7MRB
         pGDc6mTkwQDoh9wYx5pr/KCMCXL+UYg/eKMyU+l+TZ3T6hk1PBrTOE/8SluYezFYuX
         gP8yfWZOcizHA==
Received: by mail-oi1-f176.google.com with SMTP id w195so31584638oif.11;
        Tue, 16 Mar 2021 07:06:22 -0700 (PDT)
X-Gm-Message-State: AOAM533QIFFn5zcEmxvxLkUUVwLy3hhBu4UHPiNsuYGuPP2Tgw+jBeo+
        QN4w4xJdFZsa18gAGBDYU+4Ib+Ja+TAorrrgah8=
X-Google-Smtp-Source: ABdhPJw/UeWddWZMbovfWkYJKXZhvB+aXz8Dvl/JKvxdRKH1Pnn6P9a19IOWO2VVwforB9xrnODqsd7umpH/S+G2CwA=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr3575073oia.33.1615903581795;
 Tue, 16 Mar 2021 07:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210307110228.GP17424@dragon> <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon> <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon> <YFB7Y0FSSXmPEByF@enceladus> <d3d25724-6777-3c9e-5dbe-0e1570544376@gmx.de>
In-Reply-To: <d3d25724-6777-3c9e-5dbe-0e1570544376@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 15:06:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGGdVYVxaz6+P=Ao_ZnzAOQ15eq3USzq3td-hYpbGe+vQ@mail.gmail.com>
Message-ID: <CAMj1kXGGdVYVxaz6+P=Ao_ZnzAOQ15eq3USzq3td-hYpbGe+vQ@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Tue, 16 Mar 2021 at 14:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 16.03.21 10:33, Ilias Apalodimas wrote:
> > Hi Shawn,
> >
> >>>>>>> So an installer either needs to set the EFI variable, or pass
> >>>>>>> efi=novamap on the first boot. Note that there are no arm64 EFI
> >>>>>>> systems known where efi=novamap causes problems. In fact, I would
> >>>>>>> prefer to stop using SetVirtualAddressMap() altogether, as it does not
> >>>>>>> provide any benefit whatsoever. So perhaps we should make efi=novamap
> >>>>>>> the default and be done with it.
> >>>>>>>
> >>>>>>> Broken poweroff is hardly a showstopper for an installer, given that
> >>>>>>> we cannot even install GRUB correctly.
> >>>>>>>
> >>>>>>> In summary, I am more than happy to collaborate constructively on this
> >>>>>>> (which is why I wrote the patch), but I don't think we're at a point
> >>>>>>> yet where this is the only thing standing in our way when it comes to
> >>>>>>> a smooth out-of-the-box Linux installation experience.
> >>>>>>
> >>>>>> There might be more to be done for getting a smooth Linux installation
> >>>>>> experience.  But IMHO, this `OverrideSupported` thing is definitely
> >>>>>> a big step to that.
> >>>>>>
> >>>>>
> >>>>> So the problem here seems to be that grub-install (or efibootmgr)
> >>>>> tolerates efivarfs being absent entirely, but bails out if it exists
> >>>>> but gives an error when trying to access it, right?
> >>>>
> >>>> Yes, with EFI variables runtime service marked as unsupported,
> >>>> efibootmgr will just exit on efi_variables_supported() check [1] in
> >>>> a way that its parent process, i.e. grub-install, doesn't take as an
> >>>> error.  But otherwise, efibootmgr will go much further and exit with
> >>>> a real error when trying to access efivars.
> >>>>
> >>>
> >>> OK, so I suggest we fix efibootmgr, by extending the
> >>> efi_variables_supported() check to perform a GetVariable() call on an
> >>> arbitrary variable (e.g., BootOrder),
> >>
> >> Hmm, I'm not sure we should ask more from user space, as it's already
> >> been doing the right thing, and efi_variables_supported() is proved to
> >> work properly with any sane low-level software (kernel + firmware),
> >> either EFI variables service is supported or not.  That said, IMHO,
>
> No, there is not one but there are three EFI variable services.
>
> GetVariable() available after ExitBootServices() and SetVariable() not
> available() is completely legal according to the current UEFI specification.
>

This is a valid point. efibootmgr may be able to read the Boot####
variables, but may be unable to change them.

> >> right now the low-level software on Snapdragon laptops is insane, i.e.
> >> the unsupported/broken EFI runtime services are not communicated to
> >> user space properly in established way.
>
> Please, describe:
>
> * Which UEFI version is reported by your Snapdragon laptop?
> * What is the observed behavior?
>

These laptops have the EFI varstore in a eMMC partition. This is
basically the same problem that many uboot based platforms have as
well, i.e., that it is not possible for the OS and the firmware to
share the MMC because the ownership of the MMC controller cannot be
shared.

> >
> > But the EFI_UNSUPPORTED is an error that's allowed from the spec.
> > Yes the sane thing to do is not expose it at all, but it's not violating
> > any spec by doing so.
> > So why shouldn't a userspace application be able to handle all return codes
> > explicitly and instead treat them as a single error? And when that happens why
> > shouldut  the kernel mask that error out for it?
>
> The runtime services must always be callable even they can only report
> EFI_UNSUPPORTED.
>
> Only since UEFI specification 2.8 errata B do we have the
> EFI_RT_PROPERTIES_TABLE which tells us which runtime services are
> implemented.
>
> UEFI 2.8 B makes it clear that any runtime service may be reported as
> unsupported. EFI applications are expected to cope with a service being
> unavailable.
>

Indeed. The firmware on these machines predates the UEFI 2.8B
specification, but given the fact that EFI_UNSUPPORTED is a valid
return code now for these services, we should deal with them
gracefully anyway. And apparently, doing so would also remove the need
for special hacks to support installing GRUB on these platforms.
