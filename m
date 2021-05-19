Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677A1388FD0
	for <lists+linux-efi@lfdr.de>; Wed, 19 May 2021 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbhESOHO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 May 2021 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhESOHN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 May 2021 10:07:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC293C06175F
        for <linux-efi@vger.kernel.org>; Wed, 19 May 2021 07:05:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 22so9578955pfv.11
        for <linux-efi@vger.kernel.org>; Wed, 19 May 2021 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8hfnOpsFHFKiDi3a3FsFNqLWg3Cj9oeQDowWGPevqg=;
        b=rHtXU7gHoN/C99voQdngvK7w0l1IuA+mMvx6YOEWYcDtedfJz4PB3d7xTWfzivp+OG
         dJ9W1UCw0X/5gFiWWtCs696TGDzTtr79Vt79a0GXYMLVs3AmLZjGeh9w1fQK90Ls0GVJ
         M8M0wekDuQI1kcYjJV5/Fq6s91qWe9eRrgmWV6eQ64Wgb0eegylfTJ2FU51pbLVu7Go4
         7Zx53EYdQ6GuMK7sdFOH5EE3uUNwG0NIQ8+6MCychZxpEuIwgH8kQzF4xpPdbDIHqk+K
         QHQhPB6taAnUkSeGijZgaOvrDprlLgV35fYfEmKFxEGWCXR9VIRwJxVA4NWNp5pl4W10
         PDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8hfnOpsFHFKiDi3a3FsFNqLWg3Cj9oeQDowWGPevqg=;
        b=U1gzIW1br2mLu4U1X7jj0KmeHEDznYTVBog0xpke3yhH61t+5pkpkX7CyZBgrhAyx+
         CSATkREkaCA669GEyiSNFr+dld8PfYoi5N0lXnx9dht4ThVc88YbVWdzHbnXjAUm7gyR
         8b/XR6YT44dTSEI4M30TY4C9InMwrgCy7kp47CB4ikMGnA2TrCMCCMMlrHPpLilsPPWn
         W/nWjzmPkRicqhZwMDFuP9WnfoZ7aQWbP1bwbwBHURKoiR80Y49I4/QAvQRsYelIZRpv
         s3EDOtWRWFEOvMzHKTFHsEc07Gccvm0oWMLsa3/2hZo54S47vRzUwsljt9eb1I4Z4t52
         vkDQ==
X-Gm-Message-State: AOAM5332GCOHjwR044ehZLzsmv9q3MA3BQoU5dfcDShzTFolNzuy9FmN
        tIq0VMvGTUemYhi4RMIdFkctCg==
X-Google-Smtp-Source: ABdhPJxzui/5fJJoxj2JLmIP48hL6wiLreukfO/zU8YhItORMzxDi+GmqSRBkQ8gE3Sh3tEafFVlKA==
X-Received: by 2002:a05:6a00:1384:b029:2c7:fcda:8d83 with SMTP id t4-20020a056a001384b02902c7fcda8d83mr11247623pfg.0.1621433153365;
        Wed, 19 May 2021 07:05:53 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u22sm15318844pfl.118.2021.05.19.07.05.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 May 2021 07:05:52 -0700 (PDT)
Date:   Wed, 19 May 2021 22:05:45 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] arm64: efi: add check for broken efi poweroff
Message-ID: <20210519140545.GA26772@dragon>
References: <20210305065120.11355-1-shawn.guo@linaro.org>
 <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210517005903.GA15021@dragon>
 <CAMj1kXFY_0uqGVn7La7v=8Aocz+X5T+zN=ZOzfwHHmjRe-Jhzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFY_0uqGVn7La7v=8Aocz+X5T+zN=ZOzfwHHmjRe-Jhzg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 18, 2021 at 09:44:12AM +0200, Ard Biesheuvel wrote:
> On Mon, 17 May 2021 at 02:59, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > + Maximilian
> >
> > On Fri, Mar 05, 2021 at 08:01:02AM +0100, Ard Biesheuvel wrote:
> > > On Fri, 5 Mar 2021 at 07:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > Poweroff via UEFI Runtime Services doesn't always work on every single
> > > > arm64 machine.  For example, on Lenovo Flex 5G laptop, it results in
> > > > a system reboot rather than shutdown.  Add a DMI check to keep such
> > > > system stay with the original poweroff method (PSCI).
> > > >
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > >
> > > What is the point of using EFI runtime services on this machine if
> > > poweroff doesn't work either? Can't we just boot this thing with
> > > efi=noruntime?
> >
> > Ard,
> >
> > With Maximilian playing ACPI kernel on Microsoft Surface Pro X, this
> > ResetSystem service issue triggers more discussion and testing [1].
> > Maximilian tested it with uefi-test-runner and reported that ResetSystem
> > actually works [2].
> >
> > Looking at the kernel dump, I'm wondering if it's because that kernel
> > calls into the services with assuming they are in virtual addressing
> > mode, while actually they are in flat physical mode instead, due to
> > that SetVirtualAddressMap() call is skipped (efi_novamap).
> >
> 
> That looks like a firmware bug. Boot with efi=debug to figure out
> whether the faulting address is a physical address that falls inside a
> EfiRuntimeServicesData region.

Last time when I was seeing reboot/poweroff broken on Flex 5G, I did not
capture any kernel dumps.  I will retry with efi=debug and see if I can
get more information.

In the meantime, could you help me understand if EFI must be running in
virtual address mode when kernel is calling into the services, or it
should work no matter EFI is running in virtual or physical address
mode?  Thanks!

Shawn
