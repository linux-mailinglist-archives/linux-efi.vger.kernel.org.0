Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B938736F
	for <lists+linux-efi@lfdr.de>; Tue, 18 May 2021 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbhERHpm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 May 2021 03:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344924AbhERHpl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 May 2021 03:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDDFC611BF;
        Tue, 18 May 2021 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621323863;
        bh=Uuhf+yoymso8YqIT8WOHRoExsrTtRN7XlpyWr8JDrsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RbHg3KxazT8FsgxfYeHs8Rn3omUg90KroaeMk68xm0WoiYETzv25306HdKWgArLYv
         W7geMPHAMszhR6ITYL6y1LQQAiCabTExNkoMdmt34p/s3nrGYAT8vfsgiszVFRUoN4
         mL8spCM0r/Y0+FsQSEST8xUP3/q2IaHGjd7GvdWe1uQbw2PJuhWRIJfFhB/8Z10pLe
         1wWUofYqWq37AOz1Erabriuw7qDfja+l8PVgTHK6K1fl0+X/Y6ULjlduX2peq8es4C
         plVivOsXerPFakP5+hlWcUuxhL97XJaKPAbKyLxT71eijwKpZT5WqwPZfIR5xWFbQJ
         Xvf516rGyPGXw==
Received: by mail-oi1-f170.google.com with SMTP id z3so8937069oib.5;
        Tue, 18 May 2021 00:44:23 -0700 (PDT)
X-Gm-Message-State: AOAM530mCxBu7fExOY99bJzEk0mZfDJMch3hPfgGAMO6ctGn3I5ho8q0
        CXlQbK9KSZ5CANud7kDEh1o5D48E0enu5vd14LM=
X-Google-Smtp-Source: ABdhPJwvS8+WgM001FNdM1fj5bKDPq745upBFUE3BOJ1Lkz8DUWdNFRN3n1WXJe+3oGEALFBoZBVpKh/2O2+CK8JT/0=
X-Received: by 2002:aca:4343:: with SMTP id q64mr2981525oia.33.1621323863302;
 Tue, 18 May 2021 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210305065120.11355-1-shawn.guo@linaro.org> <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210517005903.GA15021@dragon>
In-Reply-To: <20210517005903.GA15021@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 May 2021 09:44:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFY_0uqGVn7La7v=8Aocz+X5T+zN=ZOzfwHHmjRe-Jhzg@mail.gmail.com>
Message-ID: <CAMj1kXFY_0uqGVn7La7v=8Aocz+X5T+zN=ZOzfwHHmjRe-Jhzg@mail.gmail.com>
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

On Mon, 17 May 2021 at 02:59, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> + Maximilian
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
> > poweroff doesn't work either? Can't we just boot this thing with
> > efi=noruntime?
>
> Ard,
>
> With Maximilian playing ACPI kernel on Microsoft Surface Pro X, this
> ResetSystem service issue triggers more discussion and testing [1].
> Maximilian tested it with uefi-test-runner and reported that ResetSystem
> actually works [2].
>
> Looking at the kernel dump, I'm wondering if it's because that kernel
> calls into the services with assuming they are in virtual addressing
> mode, while actually they are in flat physical mode instead, due to
> that SetVirtualAddressMap() call is skipped (efi_novamap).
>

That looks like a firmware bug. Boot with efi=debug to figure out
whether the faulting address is a physical address that falls inside a
EfiRuntimeServicesData region.
