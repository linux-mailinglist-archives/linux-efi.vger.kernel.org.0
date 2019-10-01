Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E0C3FBF
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfJASYG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 14:24:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43036 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbfJASYG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 14:24:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so15305191oih.10;
        Tue, 01 Oct 2019 11:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o50ESmIuAdPE+zNHnDtpkityBBSbRZVmr7JwkUQQS2g=;
        b=cVuM1YQRyhRXbu1zUNk6VvBScNAm7kBV0w9yyTiCNStl/qHPcicuJDnqK+Ia2LFdC2
         L3kbKFpcgBSLDGmwUYTNpAKwAutstclirsXJxv8yKZfnPigL6dnsmZZOlwLegkqbvIQ/
         iYBTdfm4HG8TtAx45V2/StFqoVrM1k2QCMOhT/aflC4bMXPaXdAzPFn4CzuOqeyATy9J
         +jMXUtOcOzfirvLe/bToziYvTGAHl5Hw6ScvPksljjHcMud9vXO+yJQSQs5tLzMZq+p4
         +TICaejvX9AzVzyvB+po059LJVjTz85WMU5FIYAGgO+Kvk8kz7EZxwVzFRXwP3rdrc0d
         P0GA==
X-Gm-Message-State: APjAAAULO62A3BL0DG3Ma41qQ9iE0sK/wD3jUCxqy/ZLmoMDknvL/bq2
        g20nqR7g071zhrsLzXPC1Mj6dvRap8NarS/OsTg=
X-Google-Smtp-Source: APXvYqxYvfXEXhp3h2FIAJ1Qf8w8ukHAMINaYApKrNyGLfChbcaqtBSHyTPdD9h5SnOEVKG/wNZIyr9iGMav57+5iao=
X-Received: by 2002:aca:3908:: with SMTP id g8mr4963165oia.54.1569954243743;
 Tue, 01 Oct 2019 11:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org> <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
 <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
 <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
 <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM> <20191001180133.GA2279@localhost.localdomain>
In-Reply-To: <20191001180133.GA2279@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 20:23:51 +0200
Message-ID: <CAMuHMdUMh4mCczCOxFtLn3E0Wu84ixFBsFuXk0p9QVXtg4dmoQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com
Cc:     Mario.Limonciello@dell.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Narendra,

On Tue, Oct 1, 2019 at 8:01 PM <Narendra.K@dell.com> wrote:
> On Tue, Oct 01, 2019 at 01:20:46PM +0000, Limonciello, Mario wrote:
> [...]
> > > > > > > +config EFI_RCI2_TABLE
> > > > > > > +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > > > > > +       help
> > > > > > > +         Displays the content of the Runtime Configuration Interface
> > > > > > > +         Table version 2 on Dell EMC PowerEdge systems as a binary
> > > > > > > +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > > > > > +
> > > > > > > +         RCI2 table contains BIOS HII in XML format and is used to populate
> > > > > > > +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > > > > > +         The BIOS setup page contains BIOS tokens which can be configured.
> > > > > > > +
> > > > > > > +         Say Y here for Dell EMC PowerEdge systems.
> > > > > >
> > > > > > A quick Google search tells me these are Intel Xeon.
> > > > > > Are arm/arm64/ia64 variants available, too?
> > > > > > If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).
> > > > >
> > > > > The code in question is entirely architecture agnostic, and defaults
> > > > > to 'n', so I am not convinced this is needed. (It came up in the
> > > > > review as well)
> > > >
> > > > "make oldconfig" still asks me the question on e.g. arm64, where it is
> > > > irrelevant, until arm64 variants of the hardware show up.
> > > >
> > > > So IMHO it should have "depends on X86 || COMPILE_TEST".
> > > >
> > >
> > > Fair enough. I am going to send out a bunch of EFI fixes this week, so
> > > I'll accept a patch that makes the change above.
> >
> > Is it really a problem to just say n?
> >
> > I think this seems like a needless change that would slow down adoption of
> > !x86 if Dell EMC PowerEdge systems did start going that route, especially
> > when it comes to distributions that move glacially slow with picking up new
> > kernel code.
>
> Hi Ard/Geert,
>
> Any additional thoughts here ?

Sure ;-)

A typical platform-specific sarm/arm64 .config file has almost 3000
config options
disabled.  Hence that means I have to say "n" almost 3000 times.
Fortunately I started doing this several years ago, so I can do this
incrementally ;-)

Perhaps someone should try to remove all lines like "depends on ... ||
COMPILE_TEST", run "make oldconfig", read all help texts before saying "n",
and time the whole operation...

I hope I managed to convince you of the benefits.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
