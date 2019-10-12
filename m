Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C88D513F
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2019 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJLRGN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Oct 2019 13:06:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35669 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbfJLRE1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Oct 2019 13:04:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so10608242oig.2;
        Sat, 12 Oct 2019 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rP2t/LBVNBNs923tLQ/euikPJ6CdXKk3Hw0OLg9mnNc=;
        b=OKmnsEQinsQaVlvcpJfxqprZkrDpAcxp7rWc5H2rgGI2Yqex6zznrW3UVJbnXo0XB+
         vAQfCXbK+Zt6CGRaTy1ncqq1ZQY6vf/x6kB+MTAm38Z8KKbBEmnGaajLwmPOzjvADSAD
         wejjJxxm/6Dv2dEc7JUrrYJUy280j3GaXEL3lMzlu6enYVE2PR+u66cT3ufTKG7zgReZ
         iViEYeJLLdcMTJ/P+AItb5xLn4BC9wHsUT4cSYwiUAgqVXgXNk5peldRDR/bf85cGI3B
         nu6tVMC/FZNgrN3CUHha0aA6//18Nh3i6K/BrkVClOBpQgeP9Gob6LPAg3c8+d5rK4Jk
         Gf1Q==
X-Gm-Message-State: APjAAAVzY66cwzHxlvD1DSJsqCt9L6cyOjC95RGcCh7TA/mtZIceGxPo
        88HLZTXf6I8AGl5anTTgrqUNWkUmCB521VGKQi4=
X-Google-Smtp-Source: APXvYqzHxrDb8yjxMxNoPRgVaBbW6eg+ZQ/JE5DaEurrjKygIWAkXQpZZxoKr2Wk2F9zyrQqyZV0rN3uLbvCLDKmPqM=
X-Received: by 2002:aca:882:: with SMTP id 124mr17492705oii.54.1570899866442;
 Sat, 12 Oct 2019 10:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191002194346.GA3792@localhost.localdomain> <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain> <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
 <20191011094322.GA3065@localhost.localdomain> <CAMuHMdUMkyyCZACyJ7dvd4SaicpN77g5pFd0aGEzQW_q7m3Q0g@mail.gmail.com>
 <20191011125446.GA2170@localhost.localdomain>
In-Reply-To: <20191011125446.GA2170@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 12 Oct 2019 19:04:15 +0200
Message-ID: <CAMuHMdWALc_hneRaiwQbMWUXe=LnVqU7dkkWibV0cqb8Gc5e0g@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 2:55 PM <Narendra.K@dell.com> wrote:
> On Fri, Oct 11, 2019 at 12:01:25PM +0200, Geert Uytterhoeven wrote:
> > > > > > > -       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > > > > > +       bool
> > > > > > > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST
> > > >
> > > > Why the split of bool and prompt?
> > > > Why not simply add a single line "depends on X86 || COMPILE_TEST"?
> > >
> > > It is because of the findings shared in [1]. Please let me know your
> > > thoughts on the findings.
> >
> > So you want to prevent the user from seeing a prompt for an option he may
> > or may not need to enable, when running "make oldconfig"?
>
> Geert,
>
> > The code in question is entirely architecture agnostic, and defaults
> > to 'n', so I am not convinced this is needed. (It came up in the
> > review as well)
>
> >> "make oldconfig" still asks me the question on e.g. arm64, where it is
> >> irrelevant, until arm64 variants of the hardware show up.
>
> >> So IMHO it should have "depends on X86 || COMPILE_TEST".
>
> From the discussion in [1] and [2](pasted a part of it above), my understanding
> of the issue you reported is that 'make oldconfig' asks the user a question for arm64
> though the EFI_RCI2_TABLE is not relevant for arm64. From the tests,
> it seemed like adding "depends on X86 || COMPILE_TEST" does not fix the
> issue, splitting bool into bool + prompt fixes it.
>
> Please let me know if I am missing any detail in the issue you reported.

Adding a "depends on X86 || COMPILE_TEST" should fix the issue, as
X86 is never set on arm64, nor on any other architecture than X86.
If COMPILE_TEST=y, it's normal expected behavior to show the question.

> With the way EFI_RCI2_TABLE is currently defined, my understanding is
> that 'make oldconfig' does not set the EFI_RCI2_TABLE to 'y' by default
> on arm64, but it asks the user the question. User has to say 'y' if he
> wants it to be set to 'y', else by default 'n' is set. This behavior is
> as expected.

If the option doesn't make sense on arm64 (more broadly: on non-X86),
it should depend on X86 || COMPILE_TEST, to avoid spamming the user
with (zillions of) options that do not matter for his platform.

> > One common approach is to let the Kconfig symbol for the platform (not for
> > all of X86!) select EFI_RCI2_TABLE.
> > That way it will be enabled automatically when needed.
>
> We did not intend to enable EFI_RCI2_TABLE option by default even on all
> X86 systems from the begining. As a result, we chose to set it to 'n' by
> default and added the guidance in 'help' section to say 'y' for Dell EMC
> PowerEdge systems.

Good.

>> > Another approach is to not force the option on, but guide the user towards
> > enabling it, by adding "default y if <platform_symbol>".
>
> As mentioned above, we want to keep the default to n.

OK.

> > Without the "|| COMPILE_TEST", you cannot enable compile-testing of
> > the driver on non-x86 platforms with EFI.
>
> Ok. We could keep the check. Could we make it independent of platforms
> by adding 'defbool y if COMPILE_TEST' ?

Please don't do that, as it with always enable the driver if COMPILE_TEST=y,
without providing a way to opt-out for the user.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
