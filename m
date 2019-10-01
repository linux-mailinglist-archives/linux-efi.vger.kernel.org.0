Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B646CC307C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfJAJlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 05:41:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37777 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbfJAJlu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 05:41:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so2459228wmc.2
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2019 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vi+sFa/+bKOzmEgzPLyHTjnkLYnraiSelUjtcSuIz18=;
        b=EHCoy2wuDrKlcHpLccfnylgzN8VpxoY+w7gOmCndjNy7myqA2eGnN2c3OdFk5i+4yQ
         PtT+b21SKSVmhgcLkrIQZi5oV8kmtTnhFPRvHko54sohSTQlq8RZP4ycPlYXquW/5KFk
         lh4cLIn1L2ZsNfwWGY0OFadUygqKPF4HBFM6yzz9aHr7DdpoGPTWvSCovYLgy9x1U27x
         HhJMaycw007fJznmeFJKY9EogXH8OPMNLQR8HKSaQKOblz5I+U1ha9M1vXCXeB4C3AjA
         a/1uzJ+5ePKz0VW1y5jaIjoBrlMPgRX63Fqc1001Vulf1OIWxt9I7GsjvXbgDC7GN8f7
         aUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi+sFa/+bKOzmEgzPLyHTjnkLYnraiSelUjtcSuIz18=;
        b=Kb0Gt6oC7ZL1oohu1qZtKNXPTRlu+PBxNv8akOGiVUA/xHKFoohJx4XA5ZxhtjqvYU
         6JnVhsFNBLo56Jp9KYO+5O1lqZv9aTZxaLTXAQj6pplEZHC+wd07HiKT87UUzg4yP9E7
         hPuXwf2D9WBlVEML79hyrO6fQbglS50NxfeW6DENPCL2HXxNNzEtV8IxIQ4jDoLCp65l
         cdihBj7T77edjEHM/LD1XX5vEffCQBhUcHgx5th0MoCDpSqk/IT1E4UPuMPZ0ebNpdCP
         kb1Xq3DOW0B1y5MRZQd8mHjDQJf/q81D/or46HEAoO29zTt+VlDKkjCzqmfIWDTyVyIn
         xLMg==
X-Gm-Message-State: APjAAAWlUqO6OA+dWrQkBhUKdArdCn+TDIEvAgysb/3PEeeKapEe16gn
        Du8Ajjn1wUN0AKNarKNqdHEg82F3GF9fmwcKFwW/MA==
X-Google-Smtp-Source: APXvYqwczxAXrTbgBGOXAhD4ZakB4fvWFnguJrxw2LJF6kwEsICo7eng3AC6GjuGwAm2CQjpf8GOFgARh5ZiMjpzXf4=
X-Received: by 2002:a1c:e906:: with SMTP id q6mr1685973wmc.136.1569922908018;
 Tue, 01 Oct 2019 02:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org> <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com> <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
In-Reply-To: <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 1 Oct 2019 11:41:35 +0200
Message-ID: <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, 1 Oct 2019 at 11:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
> On Tue, Oct 1, 2019 at 10:54 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Tue, 1 Oct 2019 at 10:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Aug 12, 2019 at 5:07 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > From: Narendra K <Narendra.K@dell.com>
> > > >
> > > > System firmware advertises the address of the 'Runtime
> > > > Configuration Interface table version 2 (RCI2)' via
> > > > an EFI Configuration Table entry. This code retrieves the RCI2
> > > > table from the address and exports it to sysfs as a binary
> > > > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > > The approach adopted is similar to the attribute 'DMI' under
> > > > /sys/firmware/dmi/tables.
> > > >
> > > > RCI2 table contains BIOS HII in XML format and is used to populate
> > > > BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > > The BIOS setup page contains BIOS tokens which can be configured.
> > > >
> > > > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > > > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > Thanks, this is now commit 1c5fecb61255aa12 ("efi: Export Runtime
> > > Configuration Interface table to sysfs").
> > >
> > > > --- a/drivers/firmware/efi/Kconfig
> > > > +++ b/drivers/firmware/efi/Kconfig
> > > > @@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
> > > >           have been evicted, since otherwise it will trigger even on clean
> > > >           reboots.
> > > >
> > > > +config EFI_RCI2_TABLE
> > > > +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > > +       help
> > > > +         Displays the content of the Runtime Configuration Interface
> > > > +         Table version 2 on Dell EMC PowerEdge systems as a binary
> > > > +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > > +
> > > > +         RCI2 table contains BIOS HII in XML format and is used to populate
> > > > +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > > +         The BIOS setup page contains BIOS tokens which can be configured.
> > > > +
> > > > +         Say Y here for Dell EMC PowerEdge systems.
> > >
> > > A quick Google search tells me these are Intel Xeon.
> > > Are arm/arm64/ia64 variants available, too?
> > > If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).
> >
> > The code in question is entirely architecture agnostic, and defaults
> > to 'n', so I am not convinced this is needed. (It came up in the
> > review as well)
>
> "make oldconfig" still asks me the question on e.g. arm64, where it is
> irrelevant, until arm64 variants of the hardware show up.
>
> So IMHO it should have "depends on X86 || COMPILE_TEST".
>

Fair enough. I am going to send out a bunch of EFI fixes this week, so
I'll accept a patch that makes the change above.
