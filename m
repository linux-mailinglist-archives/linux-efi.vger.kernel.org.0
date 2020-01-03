Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8548C12F535
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgACIO1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 03:14:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52298 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgACIO1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jan 2020 03:14:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so7661150wmc.2
        for <linux-efi@vger.kernel.org>; Fri, 03 Jan 2020 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtYTjq9x+N051Fkpy/e0vGbzPe3+HDhA240O17jwqeI=;
        b=CZheVjobvmLRj43eW1hfEsGIpDIlLuYUHMjbzG9HH5wpolJoQlOQo2OWzN+9NMSTRS
         FfwqWWrM5neVpTdbkXji1YiTd1RQbIs1XgljNccdwNZTDm9lkExzNZeZ46XzLxI861Sb
         TI83XkxHoQBiKvYl/yXZy7vhuF3UahvqzPIBSc1HnBcJ6im+Q+XB/824Vuons7/7kpDD
         XucNkcKjGh+NH4F7c6q3BoYS7voKQUPqyoVRNATAES2577ajvD3GqNIVtosEYgJDMN2b
         2lS/dy40e30bsLR4x5gnJBGEwhpedJxlI+cejlBE3sOw4XVOLSCMHSLv7+NlsMHyhT7A
         Kuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtYTjq9x+N051Fkpy/e0vGbzPe3+HDhA240O17jwqeI=;
        b=mX8cPy1qjJEDa1QOOjV9/3iqJlNGVqIPrtSdgbVUpliyEEoWmBrtzL7MWbvurhbzPQ
         am4lBM7RYWzuqQ35M3Iw1KNiHzYiSswqgLHYbGYwQFCxppdxGlkGaltjpCstPcML2bjb
         OjCOM8uqNBs9DzFSOqhmu/Ptz+cR7AYf1w18U7QOSpzWZkeRdq+BBrrxUvcRp20yewcv
         ThOgYTsrIN5ZdA8/FAhIc0Iwg4lsamAoKyPilkEz1cFQTW0Z38o1ajUeMd6wROAubOzy
         z8rfQOXmRvtnWcpi1rvDqrIJ5/dNRMuS68Wk18PJvJfi2iKLpHabulnfFm8Z98KS/ZOS
         w4Nw==
X-Gm-Message-State: APjAAAWm9mFTQbI2TiCQ5Y69FUMFIM6+nUnzzIxvMRLiCTDG4E+RLwtY
        oSej6PI5cB6BJlxOdbr4CNhT117wT3yGyPKP9FcJqg==
X-Google-Smtp-Source: APXvYqyypJCFSMhWrIHQOBlxXofft8kUryYKhk7iuKkNzX5Cisb3FItf3y1TKyYiqqATt+26s96EWt6QepIRdu0Py5U=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr18468630wme.148.1578039265144;
 Fri, 03 Jan 2020 00:14:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic> <20200102143757.tqhvff32ksc2rpvh@hpe.com>
 <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
 <20200102164536.ks5dmtrbtl4i7rnt@hpe.com> <CAKv+Gu86SaU+D8x2ScRXbTvR8aK23CfhAL=mkUNcn=9vrbgznw@mail.gmail.com>
 <20200102231317.yoj2xdplqp42lmcq@hpe.com>
In-Reply-To: <20200102231317.yoj2xdplqp42lmcq@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Jan 2020 09:14:14 +0100
Message-ID: <CAKv+Gu9VDxWZXKr3nZ1igP-u5q=jo_Z5UPROh+NhkTHdes8CLA@mail.gmail.com>
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
To:     Russ Anderson <rja@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Jan 2020 at 00:13, Russ Anderson <rja@hpe.com> wrote:
>
> On Thu, Jan 02, 2020 at 05:52:39PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 17:45, Russ Anderson <rja@hpe.com> wrote:
> > >
> > > I want to make sure my undestanding of what you are proposing
> > > is the same as what you are proposing.
> > >
> >
> > What I am proposing is to document efi=old_map as only being available
> > on kernels built with CONFIG_X86_UV=y, and moving the code that
> > implements it into the UV support code.
> >
> > > I will have some additional background information shortly.
> > >
> >
> > Thanks, that is very helpful.
>
> After talking with some engineers, here is a brief history.
>
> When EFI new mapping was implemented, it did not work with
> the SGI UV1 bios, which worked with the old EFI mapping.
> Boris added the efi=old_map quirk as a workaround to keep
> UV1 working.
>
> SGI UV2 bios (and later) have a fix for that issue, so the
> quirk was modified for just UV1 by this commit.  That allowed
> new EFI mapping to be used on newer UV platforms.
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/platform/efi/quirks.c?id=d394f2d9d8e1e7b4959819344baf67b5995da9b0
>
> There have been at least two other times efi=old_map has
> been used to work around issues.
>
> One was when KASLR was added (as part of the Spectre/Meldown
> mitigation).  The initial implementation broke with new
> map so efi=old_map was used as a workaround.  I don't know
> if this was a distro specific breakage or upstream, but the
> workaround limited the impact and the breakage was quickly
> fixed.
>
> Another time was the EFI locking issue mentioned earlier
> in this thread.
>

So are you saying the distros updated their kernels which subsequently
broke your platforms, and you needed to use efi=old_map in production
to work around this? This sounds like something that should have been
caught in testing before the release was made.

Is there any way you could make one of these systems
available/accessible for testing new kernels? Also, was the breakage
related specifically to the use of the UV runtime services?

> Those are a couple of examples of efi=old_map being used
> after the UV1 platform.  They were cases of issues that
> impacted the new EFI mapping, not platform or bios issues,
> and having the ability to fall back to the old EFI mapping
> helped minimize the impact.  Neither were problems in the
> new EFI mapping code itself, with the new mapping an
> innocent victim of other issues.
>
> Having the efi=old_map quirk available with CONFIG_X86_UV=y
> makes it available on the platform I care about, and as it
> is enabled in the distros we support (SLES, RHEL, Oracle Linux)
> and Fedora.  Not sure if anyone else has used efi=old_map to
> work around other issues, but this change would remove
> old_map as a possible workaround for others.
>

Indeed.

> Is there a compelling reason to put efi=old_map quirk
> under CONFIG_X86_UV=y?  The original patch description assumed
> only old SGI UV1 used efi=old_map, that it had not been
> used on newer hardware, but that isn't the case.  It has been
> used on newer currently shipping hardware.  Given that
> new information is there a compelling reason for the change?
>

Every feature like this doubles the size of the validation matrix, and
so restricting efi=old_map to a single target helps to keep the
maintenance effort manageable.
