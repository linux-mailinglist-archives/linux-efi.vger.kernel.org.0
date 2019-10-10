Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D105D30E1
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfJJSu6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 14:50:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44285 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJJSu6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 14:50:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so5808654oie.11;
        Thu, 10 Oct 2019 11:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pe9UtS2nB3IVlBbTVZ3hO/YsOnzfUIPDBvq3veYk6Pg=;
        b=kx1OW3fFfVDe/l3mHLjQOWgaEBP+jrlLuvk24StYiZMhfPIOGBXlbC5Z0Lu5I2ZOen
         GXfRad53Wa+dEclrWfWtGsvokTsmw/mg0GuVBnf0osci4swUorj3I2+s6MNQ6zdDSaVt
         1eyrkcx/KAdrZbuv0MYdw6EvZx6d0T0UvJr/WVRhOEZqK8lVYh0dxRrkfzjICsP3p6gM
         gxGvVLqszAof4lxhVG5uRDyPXi7nFbHmvi/Qc6Qpnp2VxTW8YVMCElVg/hWxc/56cxfY
         abac6XJN3HT2BHfuwyKFYJff3fnfSFezS7VQR1h8E+0P422t/iIF3YSUIcydkmHClMhT
         iqnQ==
X-Gm-Message-State: APjAAAWiRsCFPlj9hoU9jOUnZCUcsC9hhcY71aattfbRiCDY+DBWaWUn
        fb0Pr2ZVJ+swT/lHdCslDSM2z6SUFHZBPjffVN8FXWnZ
X-Google-Smtp-Source: APXvYqxHBnRYVznAMgmZqD4x3EvzZXk8DCBb1p7eqY2OJrA8SaFoMCgRJz6m1m2/1M3jlyYoLP5l6HXOT/RSdtNr0f4=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr8518987oiy.148.1570733457084;
 Thu, 10 Oct 2019 11:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191002194346.GA3792@localhost.localdomain> <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain>
In-Reply-To: <20191010174710.GA2405@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Oct 2019 20:50:45 +0200
Message-ID: <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
Subject: Re: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Narendra K <Narendra.K@dell.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Narendra,

On Thu, Oct 10, 2019 at 7:47 PM <Narendra.K@dell.com> wrote:
> On Wed, Oct 09, 2019 at 04:11:04PM +0200, Ard Biesheuvel wrote:
> > On Wed, 2 Oct 2019 at 21:44, <Narendra.K@dell.com> wrote:
> > >
> > > From: Narendra K <Narendra.K@dell.com>
> > >
> > > For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> > > for input as it is a new kconfig option in kernel version 5.4. This patch
> > > modifies the kconfig option to ask the user for input only when CONFIG_X86
> > > or CONFIG_COMPILE_TEST is set to y.
> > >
> > > The patch also makes EFI_RCI2_TABLE kconfig option depend on CONFIG_EFI.
> > >
> > > Signed-off-by: Narendra K <Narendra.K@dell.com>

> > >  drivers/firmware/efi/Kconfig | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > index 178ee8106828..6e4c46e8a954 100644
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
> > >           reboots.
> > >
> > >  config EFI_RCI2_TABLE
> > > -       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > +       bool
> > > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST

Why the split of bool and prompt?
Why not simply add a single line "depends on X86 || COMPILE_TEST"?

> >
> > You can drop the || COMPILE_TEST as well.
>
> I will drop this part of the change in the next version of the patch.

Why drop that part? Isn't it good to have more compile test coverage?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
