Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAADE3890B6
	for <lists+linux-efi@lfdr.de>; Wed, 19 May 2021 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347314AbhESOWI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 May 2021 10:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241696AbhESOWH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 May 2021 10:22:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D31261184;
        Wed, 19 May 2021 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621434048;
        bh=IlyTRVg9iaS4GdcP04fzS3iku0yy9r7l2Sc5IKQw2h8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u8iYiTHz6WKwkXK8DUk4bdAtDMhyHECQPmnvfLzihs6zlxU9ErUc42OZE8Rslt/jv
         MpZyIg0qJQZIKVJ5mh1jM4Nl8TNaBs6n1yoZ646aoHbi/BfWVaE1FilOgNrqX6Up9Q
         Ya1uwW6V4Wm7TREfhHcJAPRQZFOzxtfNEAwLGgiEblDoZ+qtXQqrDSOYowxipUNzl9
         g2dQuxh7J/qSW3kF7fiGgUtSviAJrRrywg9mf72PHC2Vx87kb8nxWi/h+MO+7G0QeO
         o0b9+AnPe4hSGCMF87KSiDx8vH237V63ilCfqV5n0Hc+Ygo9h/QfmrNau5wWHKYgnI
         3iNpvxUsOIQTg==
Received: by mail-ot1-f43.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso11896730otn.3;
        Wed, 19 May 2021 07:20:48 -0700 (PDT)
X-Gm-Message-State: AOAM530/MOmwbwV3oqWBLC4fC+yd038AFVRFdJaAh5Pggto3tYUu0VSi
        wxF7dd1E4/kD5yQoy4l53xZS1y5LbtdffzxYbQY=
X-Google-Smtp-Source: ABdhPJyETvAxsYWYp5Kss584s/HTffElw/LUlVLMMgr4T3fAvWLIEbcuepRyTzFvawA1+nqXqGvyh2+ZMFPklNLeRlk=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr9082205otd.77.1621434047501;
 Wed, 19 May 2021 07:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210305065120.11355-1-shawn.guo@linaro.org> <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210517005903.GA15021@dragon> <CAMj1kXFY_0uqGVn7La7v=8Aocz+X5T+zN=ZOzfwHHmjRe-Jhzg@mail.gmail.com>
 <20210519140545.GA26772@dragon>
In-Reply-To: <20210519140545.GA26772@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 May 2021 16:20:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGPG8+z_XBA7grvfJXuQ_TF2Xv+kZxtQdfTvwR+VK47Tw@mail.gmail.com>
Message-ID: <CAMj1kXGPG8+z_XBA7grvfJXuQ_TF2Xv+kZxtQdfTvwR+VK47Tw@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: add check for broken efi poweroff
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 May 2021 at 16:05, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Tue, May 18, 2021 at 09:44:12AM +0200, Ard Biesheuvel wrote:
> > On Mon, 17 May 2021 at 02:59, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > + Maximilian
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
> > > > poweroff doesn't work either? Can't we just boot this thing with
> > > > efi=noruntime?
> > >
> > > Ard,
> > >
> > > With Maximilian playing ACPI kernel on Microsoft Surface Pro X, this
> > > ResetSystem service issue triggers more discussion and testing [1].
> > > Maximilian tested it with uefi-test-runner and reported that ResetSystem
> > > actually works [2].
> > >
> > > Looking at the kernel dump, I'm wondering if it's because that kernel
> > > calls into the services with assuming they are in virtual addressing
> > > mode, while actually they are in flat physical mode instead, due to
> > > that SetVirtualAddressMap() call is skipped (efi_novamap).
> > >
> >
> > That looks like a firmware bug. Boot with efi=debug to figure out
> > whether the faulting address is a physical address that falls inside a
> > EfiRuntimeServicesData region.
>
> Last time when I was seeing reboot/poweroff broken on Flex 5G, I did not
> capture any kernel dumps.  I will retry with efi=debug and see if I can
> get more information.
>
> In the meantime, could you help me understand if EFI must be running in
> virtual address mode when kernel is calling into the services, or it
> should work no matter EFI is running in virtual or physical address
> mode?  Thanks!
>

There are really three scenarios to consider here:
- SetVirtualAddressMap() is never called
- SetVirtualAddressMap() is called with a 1:1 mapping for all
EFI_MEMORY_RUNTIME regions
- SetVirtualAddressMap() is called with an virtual remapping for all
EFI_MEMORY_RUNTIME regions.

Firmware that is working correctly should not care about which
scenario it is running under. All runtime services should simply work
as expected.

However, there are numerous examples of UEFI in the field (both x86
and ARM), where only the third scenario works, or where the second one
is needed to work around problems that occur when using the first one.
