Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3806633CF3D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 09:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhCPIE2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhCPIER (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Mar 2021 04:04:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4BC06174A
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 01:04:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jt13so70630703ejb.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m20vnMsteDcZTL9mSydxdGTXif40ciCoW38OSU5bDzE=;
        b=QIwn1Xgh73Lg2dJktB9ziPq/3IYzBLl3YF3Z45ZwwC9PJp1oo6KHKkYwj1nYFTqelA
         BjnmlS07oKonIRHWedECBG9esnH9rmQRk+zRUhuwc/WYwOPsQOMSsX7kXIQufcWKhUjW
         Ip6+FbMk6T8FhrmNJhzL/0Jq8IPwT/UzC7npHiqBKG7P88sx0rB2hvRW5uKWoAhNo/XV
         gKuEql0wMoh+5u/SOjFsaErhZtlPpr575D2X7ehvph7bRzNHrs/FO/jqpfz/ygAE7Ci3
         gPZ7tb2lE9vw1t4jqPzVvVPv9N3dL1nbLaToX9Pa8ILzm0gGEBSpvfuYdK1Viep66iv+
         GrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m20vnMsteDcZTL9mSydxdGTXif40ciCoW38OSU5bDzE=;
        b=Y8HcwmF50jm6PR4ll5mwx8V/5YqHYn3iewD1MllEcMWkWekXOs2H2HaSlRDD3mzrdQ
         eGnbNz5CbvwgU+bL5Kc+2UY804uJ5cBjd771tQQJqRN+txut5yBBxsAfoAQsIjtO1QGa
         NXbyqsPIhdkAbahvemeoh2zn1q7Qmb7BaR/2RY9vY2llxLW+0HNV5V9gMmmqcSJkz1B8
         gUlzvREHDxPLDbF47qS4MY4t8qSPyoiQRBkyGjwBWYrlHyPgXd2H7JSCI7izOsCkaJcY
         NF/+xil2hgy3h2nCVfj+ow7uCE9c6LJrL3tjoCEMUeOihv4FiDbILvB7CHGaSLqU8Lja
         2ZYg==
X-Gm-Message-State: AOAM531hiRPvN5KES33G0boGGfAuFWEoPaPygqMwR+rmPIDzIwKdiQz3
        cgDclVq0Whe0ePt5Y+Fj2TObMA==
X-Google-Smtp-Source: ABdhPJwDEHRjEWEqwbNnEDF/IoZhRywKs9H4zNseXWgBV6tlDyn6/XHaiI3OgHqxbUfYzPup43NzDg==
X-Received: by 2002:a17:906:5e55:: with SMTP id b21mr12198712eju.289.1615881855429;
        Tue, 16 Mar 2021 01:04:15 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id jx22sm8891492ejc.105.2021.03.16.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:04:15 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:04:12 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based
 on EFI variable
Message-ID: <YFBmfC6vNE6fXWwN@enceladus>
References: <20210306113519.294287-1-ardb@kernel.org>
 <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de>
 <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, 

On Tue, Mar 16, 2021 at 08:52:52AM +0100, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 08:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 3/15/21 2:07 PM, Ard Biesheuvel wrote:
> > > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >>
> > >> On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > >>> On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > >>>>
> > > ...
> > >>>> fwiw, the valid use-case for ACPI boot on these things is for distro
> > >>>> installer.. it might not be the shiny accelerated experience, but you
> > >>>> want to be able to get thru the installer and then install updates to
> > >>>> get latest kernel/dtb/etc
> > >>>>
> > >>>> it is a small use-case, but kinda an important step ;-)
> > >>>>
> > >>>
> > >>> That is a fair point. However, as I understand it, we need this to work around
> > >>> - the need to pass efi=novamap
> > >>> - broken poweroff on Flex5g
> > >>
> > >> One more: broken EFI variable runtime services on all Snapdragon laptops
> > >>
> > >> It's been another pain of running debian-installer (d-i) on these
> > >> laptops, where EFI NV variables are just stored on UFS disk.  So after
> > >> Linux takes over the control of UFS, EFI NV variable runtime services
> > >> then become out of service.  Currently, we have to apply a hack [1] on
> > >> d-i grub-installer to get around the issue,  and it's been the only
> > >> remaining out-of-tree patch we have to carry for d-i.  With this nice
> > >> `OverrideSupported` support, we will be able to drop that hack
> > >> completely.
> > >>
> > >>>
> > >>> So an installer either needs to set the EFI variable, or pass
> > >>> efi=novamap on the first boot. Note that there are no arm64 EFI
> > >>> systems known where efi=novamap causes problems. In fact, I would
> > >>> prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > >>> provide any benefit whatsoever. So perhaps we should make efi=novamap
> > >>> the default and be done with it.
> > >>>
> > >>> Broken poweroff is hardly a showstopper for an installer, given that
> > >>> we cannot even install GRUB correctly.
> > >>>
> > >>> In summary, I am more than happy to collaborate constructively on this
> > >>> (which is why I wrote the patch), but I don't think we're at a point
> > >>> yet where this is the only thing standing in our way when it comes to
> > >>> a smooth out-of-the-box Linux installation experience.
> > >>
> > >> There might be more to be done for getting a smooth Linux installation
> > >> experience.  But IMHO, this `OverrideSupported` thing is definitely
> > >> a big step to that.
> > >>
> > >
> > > So the problem here seems to be that grub-install (or efibootmgr)
> > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > but gives an error when trying to access it, right?
> > >
> > > This is not only a problem on Snapdragon systems afaik - most Uboot
> > > based arm64 systems booting via EFI are affected by this as well.
> > >
> > > So it would be good if we could align with those folks, and maybe the
> > > ones working on RISC-V as well, to see if we can get some consensus
> > > around taking this approach.
> > >
> > > For the folks newly cc'ed on this thread: full version here
> > > https://lore.kernel.org/linux-arm-msm/20210306113519.294287-1-ardb@kernel.org/
> > >
> > > Note that I am both the author of the patch, and the maintainer
> > > pushing back on it. Please chime in if you think there are reasons why
> > > we want this, something like this or nothing like this.
> > >
> > Hello Ard,
> >
> > looking at this thread it is hard to understand why this patch should be
> > needed.
> >
> > If an UEFI application does not want to consume a service, it can do so
> > without having to manipulate the RT properties table.
> >
> > Which UEFI applications are broken? Why can't they be fixed instead of
> > patching the kernel?
> >
> > Can we have complete descriptions of the deficiencies of the involved
> > applications. I saw GRUB and the Debian installer mentioned in the
> > thread. Are there others?
> >
> 
> The problem is that the proprietary EDK2 / UEFI firmware on Qualcomm
> Snapdragon based laptops that were built to run Windows does not
> implement get/setvariable after ExitBootServices. Instead, every call
> to any of the variable services returns with an EFI_UNSUPPORTED error.
> 
> The correct way to address this is a RT_PROP table that encodes this
> behavior, and this is what we added in the special DtbLoader driver
> that is used to boot Linux in DT mode (as the firmware only implements
> ACPI support). So for systems that can/will run DtbLoader, the problem
> is solved.
> 
> What remains is ACPI boot, or boot modes where DtbLoader does not
> work. In those cases, it would be useful to have another way to convey
> this information to the OS in a way that does not rely on the kernel
> command line.
> 
> But thinking about this, perhaps we should be fixing this in
> efibootmgr instead. EFI_UNSUPPORTED is a valid and documented return
> code that conveys that the operation did not fail with an error, but
> that efibootmgr is not supported to begin with on the platform in
> question.

It all depends on how smart we want to make the efi stub. In essence
it's an OS loader, that we have complete control over and we can play tricks
on broken/incompatible firmwares, but is that what we want ? And if yes, were
do we draw the line of what we fix or not?

I think the current problem doesn't make a strong case to add such
functionality. U-Boot doesn't expose SetVariable at all, but even if it did
and returned EFI_UNSUPPORTED, I'd expect the consuming applications to handle
the error gracefully.  I mean why should we treat EFI_UNSUPPORTED differently
than EFI_DEVICE_ERROR or EFI_INVALID_PARAMETER (or all the allowed return
codes)?

Cheers
/Ilias
