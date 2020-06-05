Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC6D1EFBF9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFEO6D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 10:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFEO6D (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 10:58:03 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7598020663
        for <linux-efi@vger.kernel.org>; Fri,  5 Jun 2020 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591369082;
        bh=BCWTfQV4JdBW4bkG3lr7ph6JOJqRNj6pW2HlPpWDAB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTF6/fELjSY84u0ZMIabGSfODHAfYyojvMkK8qxl4qOsm26ZrISny4RqKh0ggAILB
         6T/a+xpNO9skqKeOcvSlsGISjCI7XWusmHPKrdJCNrnMiKPpd6zpLgByZzaLfBMal3
         iAQnvYFmX6ypQ6fM9/hIVZRHcTL+OStcHXq2SZfA=
Received: by mail-oi1-f180.google.com with SMTP id k4so6899441oik.2
        for <linux-efi@vger.kernel.org>; Fri, 05 Jun 2020 07:58:02 -0700 (PDT)
X-Gm-Message-State: AOAM533CIERvuUKeZTs6sFJEjqKDVZpkrg6dIMn6Qs8/60ehTOUIk8f7
        /g1rFUgmFkrKTIBg0C+GktIIQVA+xbdEYUpG0kI=
X-Google-Smtp-Source: ABdhPJzomCtbyOhmah+HSf63UvF0LLzbbDyUOQdb+pwvayrITHupIya4KEybziGapxmUQCAeVoczkWRokqJ4fnc3vTE=
X-Received: by 2002:aca:6144:: with SMTP id v65mr2138797oib.33.1591369081750;
 Fri, 05 Jun 2020 07:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200605115200.413921-1-ardb@kernel.org> <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
 <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com> <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
In-Reply-To: <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Jun 2020 16:57:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwWwGyX1ijk-qjuV10p0Zr6sAYeAntx+iDVHp-tVaNwg@mail.gmail.com>
Message-ID: <CAMj1kXHwWwGyX1ijk-qjuV10p0Zr6sAYeAntx+iDVHp-tVaNwg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Jun 2020 at 16:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 05.06.20 14:39, Ard Biesheuvel wrote:
> > On Fri, 5 Jun 2020 at 14:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 05.06.20 13:52, Ard Biesheuvel wrote:
> >>> EFI on ARM only supports short descriptors, and given that it mandates
> >>> that the MMU and caches are on, it is implied that booting in HYP mode
> >>> is not supported.
> >>>
> >>> However, implementations of EFI exist (i.e., U-Boot) that ignore this
> >>> requirement, which is not entirely unreasonable, given that it does
> >>> not make a lot of sense to begin with.
> >>
> >> Hello Ard,
> >>
> >> thanks for investigating the differences between EDK2 and U-Boot.
> >>
> >> What I still do not understand is if there is a bug in U-Boot where
> >> U-Boot does not conform to the UEFI specification? In this case I would
> >> expect a fix in U-Boot.
> >>
> >
> > U-Boot violates the EFI spec, yes. The spec is very clear on how the
> > MMU is configured, and this rules out booting with the caches off, or
> > booting in HYP mode.
> >
> > However, given that this is the situation today, we still need to deal
> > with it on the Linux side.
> > In parallel, fixing it in U-boot may be appropriate. However, I think
> > the EFI spec is too detailed here - instead of 'booting at the highest
> > non-secure privilege mode', it tells you which exact bits to set in
> > SCTLR, which seems overzealous to me. In other words, even though it
> > violates the letter of the spec, I don't mind dealing with this
> > exception in the Linux side, since the requirement is somewhat
> > unreasonable to begin with.
> >
> >> Or is it simply a deficiency of Linux that it does not properly support
> >> HYP/EL2 mode on 32-bit ARM?
> >>
> >
> > No, this is definitely not the fault of Linux.
> >
> >> Up to now I never experience a problem booting a 32bit board via U-Boot
> >> -> GRUB-EFI -> Linux. Where did you have a problem when booting via
> >> U-Boot's UEFI implementation and the current Linux kernel?
> >>
> >
> > I haven't managed to make it fail, but my only 32-bit HYP capable
> > platform is QEMU. I am not 100% convinced that the EFI+HYP+U-Boot case
> > is rock solid, and I may have gotten lucky with QEMU (which uses
> > emulation not virtualization when running at HYP)
> >
> > Do you have any A7/A15 based boards that don't print 'WARNING: Caches
> > not enabled' at boot?
>
> Hello Ard,
>
> I have no board that prints this. Where did you actually see this output?
>

In U-boot

arch/arm/lib/cache.c: * Default implementation of enable_caches()
arch/arm/lib/cache.c- * Real implementation should be in platform code
arch/arm/lib/cache.c- */
arch/arm/lib/cache.c:__weak void enable_caches(void)
arch/arm/lib/cache.c-{
arch/arm/lib/cache.c-   puts("WARNING: Caches not enabled\n");
arch/arm/lib/cache.c-}
arch/arm/lib/cache.c-

The QEMU port does not override that routine. This may be the reason
it doesn't work for me under KVM, but only under emulation.

> The string "Caches not enabled" does not exist in Linux next-20200505
> according to "git grep -n 'ache not enabled'".
>
> Here is some sample output for an Orange Pi PC with a quad core
> Allwinner H3 Soc. "ARMv7 Processor rev 5 (v7l)" according to
> /proc/cpuinfo, compatible to "arm,cortex-a7" according to the device tree.
>
> $ uname -m
> Linux orangepi-pc 5.6.0-2-armmp-lpae #1 SMP Debian 5.6.14-1 (2020-05-23)
> armv7l GNU/Linux
>

Could you check whether it boots in HYP mode?

[    0.381460] CPU: All CPU(s) started in SVC mode.

vs

[    0.135626] CPU: All CPU(s) started in HYP mode.


?
