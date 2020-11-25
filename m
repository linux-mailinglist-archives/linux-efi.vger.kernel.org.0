Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED82C3B02
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKYIXM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 03:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYIXM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Nov 2020 03:23:12 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE2B208CA;
        Wed, 25 Nov 2020 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606292591;
        bh=UDJR1BLbf6RMG7AoxVnljKWEU7ulln6VKnFURV8nDN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1qK2mm4BGujkrO3ktSTyLTMkhI9a5paWANmIEOztQdyBRJDiZH5PC6erT3mvdCGy
         jmFY24qddW0nWaRlxs5PLD/EtPtJ3jrkLaD33qEIYzPpqIfH5zWQBllFYeQ/pzcP2H
         4P+gANvsxst5SunwdcTGBuQFXlRoMRjpWshdkp1E=
Received: by mail-oi1-f170.google.com with SMTP id t143so1915734oif.10;
        Wed, 25 Nov 2020 00:23:11 -0800 (PST)
X-Gm-Message-State: AOAM533WGlNr0Mo+qzrFpH+vjZjRph5/R63otntofq08yGMMsIC//s1X
        3C7jd6aDcFPFI9rWZthi3RxsQIMjK3iNdm/IobU=
X-Google-Smtp-Source: ABdhPJxtGbi7ORieJ16EI0Ax/EH2gPZClTdoWhRAo0OaKzifZhhHkSMxBWi4wBoVlScebUmwCLBFBgHMkV441tMCjeU=
X-Received: by 2002:aca:c657:: with SMTP id w84mr1472592oif.47.1606292590851;
 Wed, 25 Nov 2020 00:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20201124191646.3559757-1-geert@linux-m68k.org> <d3ce2d98a7469eda01a67eae7a26585893a1f757.camel@wdc.com>
In-Reply-To: <d3ce2d98a7469eda01a67eae7a26585893a1f757.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Nov 2020 09:23:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGcQKy2yTKHnd+j2+=YKGRUa58oZJuTaWr-PkaCtJyy1A@mail.gmail.com>
Message-ID: <CAMj1kXGcQKy2yTKHnd+j2+=YKGRUa58oZJuTaWr-PkaCtJyy1A@mail.gmail.com>
Subject: Re: [PATCH] efi: EFI_EARLYCON should depend on EFI
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Nov 2020 at 09:21, Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On Tue, 2020-11-24 at 20:16 +0100, Geert Uytterhoeven wrote:
> > CONFIG_EFI_EARLYCON defaults to yes, and thus is enabled on systems that
> > do not support EFI, or do not have EFI support enabled, but do satisfy
> > the symbol's other dependencies.
> >
> > While drivers/firmware/efi/ won't be entered during the build phase if
> > CONFIG_EFI=n, and drivers/firmware/efi/earlycon.c itself thus won't be
> > built, enabling EFI_EARLYCON does force-enable CONFIG_FONT_SUPPORT and
> > CONFIG_ARCH_USE_MEMREMAP_PROT, and CONFIG_FONT_8x16, which is
> > undesirable.
> >
> > Fix this by making CONFIG_EFI_EARLYCON depend on CONFIG_EFI.
> >
> > This reduces kernel size on headless systems by more than 4 KiB.
> >
> > Fixes: 69c1f396f25b805a ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/firmware/efi/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index b452cfa2100b401c..1dd1f7784f0888ff 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -270,7 +270,7 @@ config EFI_DEV_PATH_PARSER
> >
> >
> >  config EFI_EARLYCON
> >       def_bool y
> > -     depends on SERIAL_EARLYCON && !ARM && !IA64
> > +     depends on EFI && SERIAL_EARLYCON && !ARM && !IA64
> >       select FONT_SUPPORT
> >       select ARCH_USE_MEMREMAP_PROT
> >
> >
>
> Looks good to me.
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>

Thanks all

I'll queue this as a fix.
