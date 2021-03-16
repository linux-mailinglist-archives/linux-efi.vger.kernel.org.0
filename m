Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50433CFD2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 09:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhCPI11 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhCPI1J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Mar 2021 04:27:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862DC061756
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 01:27:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so20390784eds.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CLf59KGSjWUQb8ryREHzVKvbUGjsmxFO7bkVEZRsGc=;
        b=VTDQBGqkCkUmUjwq0Mnb618wkTUj6+3rVA/WFIqw+sR0+INRhP0urmFGxfIkcF7hjI
         8ra7BPp6vxY0FJoy8DP0VNlqhQ3cBkmwk8TG6yw1vvy9HMJbgV8YdrK3DXlFp/mcfv5p
         jyWLzz0oElNnjut7DcROb/H6bU6lRfjIqlygJI8xoQ3TmopL+ZGriOhSba2GIuMZSvyY
         6UOmk8MjR4dZ4AnaeGcuCrC8i9kl3FB6Qz1ptJ3T/o+/n8ahYNUwmuj7Q63rgln3eHXg
         qhWD+6pP09BI5uMP1xatAqCxLkMrlgrCvITE3jKiQubSHfaXlhPw9Vsz2wwX8EXnJhGs
         xn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CLf59KGSjWUQb8ryREHzVKvbUGjsmxFO7bkVEZRsGc=;
        b=mjGli7EfJWrPStSsWRVxPeA/ssH4KVsJZ9lZWTg1vI6tu3jYoWcwy9U6Ziu0w597lu
         92Ep/kUtM68zUnWykucmlnHhmeZCZxv7xck0Jnjn2JYv68fxu03LjAqWEuZFZWQbTuQa
         lqt+SXpSGwEg8Ij2S+g3z/XiHF06tBoLpB8vVUy/R0quaBwNmGFIPDy2dHwv2k+1gJC/
         RTNUcoCqZ6UsqgYuYR0fq0ylonOqpwx+FthHq1Lqg6PTZbrZ+I2CamkrXXpx+aQOny62
         yGHBd1Jf2m2T4i5tsFSk7B0MLwY63S74xGilnKjuxz4lcRitsANhLokg6jVsJwpa1zH6
         RHOw==
X-Gm-Message-State: AOAM530M6nogoL89Hv6MC7zMLarfZM3WLE1NxkB3wDY8o3PEZk/X6PLu
        lZCv33piYXt8XwGOxDPx6TaRvg==
X-Google-Smtp-Source: ABdhPJyCCzgwkT84nB+lCeOlEEZy0yZaq2CFScXPw+tnsBDYmRqOzLG+O1WMLhU+gNZhnU22QmSZAg==
X-Received: by 2002:a05:6402:1649:: with SMTP id s9mr34635755edx.177.1615883227921;
        Tue, 16 Mar 2021 01:27:07 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id t6sm9836888edq.48.2021.03.16.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:27:07 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:27:04 +0200
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
Message-ID: <YFBr2C36ogM25Jjb@enceladus>
References: <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de>
 <CAMj1kXH=BDYXNT36+8tMOrbngKusHn6iiQV5VcC+KEWcoifGxw@mail.gmail.com>
 <YFBmfC6vNE6fXWwN@enceladus>
 <CAMj1kXEz++tPZO5Bzw9f+_PzzRoN7m6fXUi3kKTXvMANpzaKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEz++tPZO5Bzw9f+_PzzRoN7m6fXUi3kKTXvMANpzaKpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 16, 2021 at 09:14:22AM +0100, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 09:04, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ard,
> >
> > On Tue, Mar 16, 2021 at 08:52:52AM +0100, Ard Biesheuvel wrote:
> > > On Tue, 16 Mar 2021 at 08:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> ...
> > > > looking at this thread it is hard to understand why this patch should be
> > > > needed.
> > > >
> > > > If an UEFI application does not want to consume a service, it can do so
> > > > without having to manipulate the RT properties table.
> > > >
> > > > Which UEFI applications are broken? Why can't they be fixed instead of
> > > > patching the kernel?
> > > >
> > > > Can we have complete descriptions of the deficiencies of the involved
> > > > applications. I saw GRUB and the Debian installer mentioned in the
> > > > thread. Are there others?
> > > >
> > >
> > > The problem is that the proprietary EDK2 / UEFI firmware on Qualcomm
> > > Snapdragon based laptops that were built to run Windows does not
> > > implement get/setvariable after ExitBootServices. Instead, every call
> > > to any of the variable services returns with an EFI_UNSUPPORTED error.
> > >
> > > The correct way to address this is a RT_PROP table that encodes this
> > > behavior, and this is what we added in the special DtbLoader driver
> > > that is used to boot Linux in DT mode (as the firmware only implements
> > > ACPI support). So for systems that can/will run DtbLoader, the problem
> > > is solved.
> > >
> > > What remains is ACPI boot, or boot modes where DtbLoader does not
> > > work. In those cases, it would be useful to have another way to convey
> > > this information to the OS in a way that does not rely on the kernel
> > > command line.
> > >
> > > But thinking about this, perhaps we should be fixing this in
> > > efibootmgr instead. EFI_UNSUPPORTED is a valid and documented return
> > > code that conveys that the operation did not fail with an error, but
> > > that efibootmgr is not supported to begin with on the platform in
> > > question.
> >
> > It all depends on how smart we want to make the efi stub. In essence
> > it's an OS loader, that we have complete control over and we can play tricks
> > on broken/incompatible firmwares, but is that what we want ? And if yes, were
> > do we draw the line of what we fix or not?
> >
> > I think the current problem doesn't make a strong case to add such
> > functionality. U-Boot doesn't expose SetVariable at all, but even if it did
> > and returned EFI_UNSUPPORTED, I'd expect the consuming applications to handle
> > the error gracefully.  I mean why should we treat EFI_UNSUPPORTED differently
> > than EFI_DEVICE_ERROR or EFI_INVALID_PARAMETER (or all the allowed return
> > codes)?
> >
> 
> EFI_DEVICE_ERROR or EFI_INVALID_PARAMETER means that the particular
> call resulted in an error, which may be related to the values of the
> arguments, the state of the the flash, etc etc
> 
> EFI_UNSUPPORTED means that the platform in question does not support
> the routine at all at runtime, and the arguments or the context is
> irrelevant.

By differently I implied 'not handle the error correctly'.
So my point was that an application must handle all errors that are allowed
from the spec. Not select the ones it prefers in a meaningfull way.
Which brings us to your next point.

> 
> Given that GRUB already tolerates the second condition, but only if it
> is communicated explicitly (via --no-nvram) or implicitly when
> efivarfs is absent altogether, I am saying that we should classify a
> EFI_UNSUPPORTED return value in the same way, and tolerate it rather
> than abort the install.

+1 

Thanks
/Ilias
