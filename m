Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59AE32E34B
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEIDQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 03:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCEICy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Mar 2021 03:02:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AFEC061574
        for <linux-efi@vger.kernel.org>; Fri,  5 Mar 2021 00:02:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fu20so1378252pjb.2
        for <linux-efi@vger.kernel.org>; Fri, 05 Mar 2021 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5242qZe1dQx2v+ceV/UsYai2bG9UNF18xwfWliabRhQ=;
        b=EwaCGlqzU61K0/wCtlOm/oXYh3kV1Aw/G38iUzbbMcjw+BkDb8+vPEuityxR80nd3W
         5ZKwyTC7JurGYq2VEZAgrjnMcGrB7HgvbidKH77C5mqRhG88gTmgDXOwEEMtZXS8NdBD
         DUJFNHHbcndzSxF4kJ/ODhsCshvMc98BfRRQmlf5kCvwKWd2LZlSGDQwQ8daN2OZAxsp
         fcKKta1Pytn3SgtFMkehUf2HInU1C9O+I76tlu3iKRPb7WT6lM/fd2aRgTijWuzTUmJW
         EesNmXPu6YRy4iDYfK6UWTG4HrzP0G3Nr21nJ3aMvPs/6G50nOb9qpzdEd5cLSWIm0zC
         lcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5242qZe1dQx2v+ceV/UsYai2bG9UNF18xwfWliabRhQ=;
        b=RQAdGgoZ/LyeI0cCAeIZ4DOhXcnAK9Uf4Aw/DnWi0Hj4lpfQQa0UQPTQdeOwZHpkGC
         /tYjRM7tx1vbLA4ezWvStP40FDpKowOS0TndxEgLC3osI6WRdrYaXov7W1jj+Kj4P3je
         6RqtyCN7DCcvS68Pw5cgx+QxbHDKuApSgkC8dktMXrhy5dFQcDYNCgBcvkIcWxYvx+Ma
         uugj8FnhqLBo1tIvCn6r2dyJ4tE6rzWqgLPf/boLyIOwa63/dqHIjajOO7D80Eo+Ths/
         06jQqOSgYBD0CnkdK+gMI3qhYZFeO01SmXnNe/m1xKqz3C2sOShdgHiMDp5viTv4rk+q
         uh+g==
X-Gm-Message-State: AOAM530k/sv/3smH2LJu+ubl4pY610Sd/oxrremPvZoLEz+LeITK3f2O
        2sIQmTJj2CyDpFojX9Y5ma/uBA==
X-Google-Smtp-Source: ABdhPJy2CcxiT93477ZVvqAVyrPoTSaJ7CcR8UiWJZJ949CY9DZvO2SMjBZ2tUJjz6u/eaD5cWL4QQ==
X-Received: by 2002:a17:902:10a:b029:e2:e8f7:2988 with SMTP id 10-20020a170902010ab02900e2e8f72988mr7709667plb.4.1614931373873;
        Fri, 05 Mar 2021 00:02:53 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p190sm1508042pga.78.2021.03.05.00.02.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Mar 2021 00:02:53 -0800 (PST)
Date:   Fri, 5 Mar 2021 16:02:47 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: efi: add check for broken efi poweroff
Message-ID: <20210305080245.GJ17424@dragon>
References: <20210305065120.11355-1-shawn.guo@linaro.org>
 <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
 <20210305073151.GI17424@dragon>
 <CAMj1kXEezoDanHsKiN566r0xP1o8pQBk5UZPff0zYxG+Aw7-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEezoDanHsKiN566r0xP1o8pQBk5UZPff0zYxG+Aw7-Og@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 05, 2021 at 08:46:35AM +0100, Ard Biesheuvel wrote:
> On Fri, 5 Mar 2021 at 08:32, Shawn Guo <shawn.guo@linaro.org> wrote:
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
> > > poweroff doesn't work either?
> >
> > Hmm, I'm not sure how many EFI runtime services are being used by
> > kernel, but this is the only one broken I have seen.  Not sure we want
> > to disable the whole thing completely.  Also, I'm looking at commit log
> > of 0c5ed61adbdb ("efi/reboot: Allow powering off machines using EFI")
> > below.
> >
> >     Not only can EfiResetSystem() be used to reboot, it can also be used to
> >     power down machines.
> >
> >     By and large, this functionality doesn't work very well across the range
> >     of EFI machines in the wild, so it should definitely only be used as a
> >     last resort. In an ideal world, this wouldn't be needed at all.
> >
> >     Unfortunately, we're starting to see machines where EFI is the *only*
> >     reliable way to power down, and nothing else, not PCI, not ACPI, works.
> >
> > It seems poweroff via EFI runtime services is known not working for
> > every machine, and was meant to be the last resort if nothing else can
> > power off system.  If we try PSCI first on arm64, you do not see my
> > patch at all :)
> >
> > > Can't we just boot this thing with
> > > efi=noruntime?
> >
> > We are trying to get arm64 laptop support into distros, and patching
> > kernel cmdline with 'efi=novamap' is already a pain.  We do not really
> > want to have more of it.
> >
> 
> I suppose we have to rely on DtbLoader for these platforms anyway,
> right? That means we should be able to rely on it to publish a RT_PROP
> configuration table which tells the kernel which EFI runtime services
> are usable and which are not. This way, we could get rid of
> efi=novamap as well.

Two things:

- DtbLoader is loaded as an EFI driver.  It works fine on Yoga C630, but
  it's not loaded by Flex 5G UEFI for some reason.  So DtbLoader is not
  really working on Flex 5G at this point.

- We are running not only DT kernel on these laptops but also ACPI
  kernel in which case DtbLoader shouldn't needed.

> I'd prefer to rely on that than on DMI quirks - we have not used those
> at all on arm64/ARM so far, and the DMI tables are parsed relatively
> late, so in some cases, DMI quirks may not be reliable.

I'm all ears in case there are other runtime mechanisms to get around
it. 

Shawn
