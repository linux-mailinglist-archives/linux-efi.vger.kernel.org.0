Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB36D3CEE
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJKKBh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 06:01:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45291 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKBh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 06:01:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so7481155oib.12;
        Fri, 11 Oct 2019 03:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmWoLaFLM5Nm2z3NOAq6yl+CBUxQRErLfBnt6nPINlk=;
        b=MZVbbdj3MqbE+H/sv+nHpvVqMnra2LFnE2SGp52bUoHoKY3vuvHZz90jEssCUE/L8g
         hDvQ7iq9YFXHgQLqHovlKp1anlYV7MJU8drhY1ijJx8bsxTP0cF8vbew9Bm+mdWgn+Nl
         CGJWX4quO+i5lYDLVK0bKaRhJUUdJgwifjHnQjQ6du3flwJ0vEZmdYmvPqjKHhpoS3Pt
         GDr1kZAXk0uZ/WLk9a4bKbM+fkX9THNlI57+gqU/qLa4Wg18Kh8Sp4Rgp7XSXe5Joitj
         0bKwNsfys2rWnnlaVRHmh1cAl1bYoOUI+rS2eK1fxRNACjfZdd7wxA27KadxP3tEWhj9
         pvpA==
X-Gm-Message-State: APjAAAWtPw5z/QMih2t1ociLUywUvqDlmOfCW2iiMXJqYlQN9DuwmUzy
        u9UrqubpnVjvn9vO+NStf3TeseL9Z/2RxjvMdcA=
X-Google-Smtp-Source: APXvYqzbnNnLkhuI7imEuzHA7CQbXtjXT+AB10bROH1mQbBpZeFJJdWl6Bc30QfjDKu2Pfzs19d8lMhrFPzCKKhamJA=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr10839645oiy.148.1570788096407;
 Fri, 11 Oct 2019 03:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191002194346.GA3792@localhost.localdomain> <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain> <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
 <20191011094322.GA3065@localhost.localdomain>
In-Reply-To: <20191011094322.GA3065@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Oct 2019 12:01:25 +0200
Message-ID: <CAMuHMdUMkyyCZACyJ7dvd4SaicpN77g5pFd0aGEzQW_q7m3Q0g@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 11:43 AM <Narendra.K@dell.com> wrote:
> On Thu, Oct 10, 2019 at 08:50:45PM +0200, Geert Uytterhoeven wrote:
> [...]
> > > > >  drivers/firmware/efi/Kconfig | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > > > index 178ee8106828..6e4c46e8a954 100644
> > > > > --- a/drivers/firmware/efi/Kconfig
> > > > > +++ b/drivers/firmware/efi/Kconfig
> > > > > @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
> > > > >           reboots.
> > > > >
> > > > >  config EFI_RCI2_TABLE
> > > > > -       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > > > +       bool
> > > > > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST
> >
> > Why the split of bool and prompt?
> > Why not simply add a single line "depends on X86 || COMPILE_TEST"?
>
> It is because of the findings shared in [1]. Please let me know your
> thoughts on the findings.

So you want to prevent the user from seeing a prompt for an option he may
or may not need to enable, when running "make oldconfig"?

One common approach is to let the Kconfig symbol for the platform (not for
all of X86!) select EFI_RCI2_TABLE.
That way it will be enabled automatically when needed.

Another approach is to not force the option on, but guide the user towards
enabling it, by adding "default y if <platform_symbol>".

> > > > You can drop the || COMPILE_TEST as well.
> > >
> > > I will drop this part of the change in the next version of the patch.
> >
> > Why drop that part? Isn't it good to have more compile test coverage?
>
> It is per the suggestion in the previous review comment.
>
> Ard, please share your thought here. I could add the || COMPILE_TEST.

Without the "|| COMPILE_TEST", you cannot enable compile-testing of
the driver on non-x86 platforms with EFI.

> [1]  Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
> https://lore.kernel.org/linux-efi/20190812150452.27983-1-ard.biesheuvel@linaro.org/T/#mebff9ba48499808f59b33b2daef2d94e006296d8

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
