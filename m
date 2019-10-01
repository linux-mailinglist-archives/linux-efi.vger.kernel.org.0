Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F260C2F82
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfJAJDt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 05:03:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34598 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfJAJDt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 05:03:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so10913880otp.1;
        Tue, 01 Oct 2019 02:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHb/q0D5mq2W+1z309ghRX/uOTtJacVT4nymLRBbTcY=;
        b=htkYd76D3kiDKEcy1bWVrY8+LBE/JTkBI+mpbmAmo2K653WzDQPZopJzPaUzyvcsD8
         PUcIsjBHr4bk3NFJ5aX9ecsYZIv44d0o1Kl3tC6e6kB+LWm2ydN6iL7CNkI3TsOpGpB5
         QY1OHSFgiZmHAnudnKRjUyL4CU27rK2x+dLLeeG1Eu19JwE06buCpYwGOrXicxUNlZZv
         ttrROxujt0T89cVt+1FEVtNTp2GqwqN01vxkFoFknhLC+bA7Qb297JsqydOuxaKuJsM5
         v93nTjBmphU/RKczONQdAaFyp8Fucjeq3t7XyEDX2qk3aNsaGSYw36250H48rEzIDLid
         4G2Q==
X-Gm-Message-State: APjAAAWlkXeMrrIqMKKayfl1MDbu8F7jjCsSTihgEGNfhmXYf6NwYbgE
        uT7g7pqxhSt5IdIZRwCnyl3+jZUMhf8pa4tqo7s=
X-Google-Smtp-Source: APXvYqyt8Fr5MNj8xgi9zNhfzNfGel2OzKPctcEPWiUOWLO4+kzE7HEg5SIyhaqF7N+eaUzd0/bjIui+DRWnMOK6Apw=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr17494480oti.39.1569920628345;
 Tue, 01 Oct 2019 02:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org> <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
In-Reply-To: <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 11:03:37 +0200
Message-ID: <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Tue, Oct 1, 2019 at 10:54 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Tue, 1 Oct 2019 at 10:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Aug 12, 2019 at 5:07 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > From: Narendra K <Narendra.K@dell.com>
> > >
> > > System firmware advertises the address of the 'Runtime
> > > Configuration Interface table version 2 (RCI2)' via
> > > an EFI Configuration Table entry. This code retrieves the RCI2
> > > table from the address and exports it to sysfs as a binary
> > > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > The approach adopted is similar to the attribute 'DMI' under
> > > /sys/firmware/dmi/tables.
> > >
> > > RCI2 table contains BIOS HII in XML format and is used to populate
> > > BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > The BIOS setup page contains BIOS tokens which can be configured.
> > >
> > > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Thanks, this is now commit 1c5fecb61255aa12 ("efi: Export Runtime
> > Configuration Interface table to sysfs").
> >
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
> > >           have been evicted, since otherwise it will trigger even on clean
> > >           reboots.
> > >
> > > +config EFI_RCI2_TABLE
> > > +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > +       help
> > > +         Displays the content of the Runtime Configuration Interface
> > > +         Table version 2 on Dell EMC PowerEdge systems as a binary
> > > +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > +
> > > +         RCI2 table contains BIOS HII in XML format and is used to populate
> > > +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > +         The BIOS setup page contains BIOS tokens which can be configured.
> > > +
> > > +         Say Y here for Dell EMC PowerEdge systems.
> >
> > A quick Google search tells me these are Intel Xeon.
> > Are arm/arm64/ia64 variants available, too?
> > If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).
>
> The code in question is entirely architecture agnostic, and defaults
> to 'n', so I am not convinced this is needed. (It came up in the
> review as well)

"make oldconfig" still asks me the question on e.g. arm64, where it is
irrelevant, until arm64 variants of the hardware show up.

So IMHO it should have "depends on X86 || COMPILE_TEST".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
