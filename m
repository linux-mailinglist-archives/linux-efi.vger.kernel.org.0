Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDF2D7D65
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436646AbgLKRwt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 12:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436640AbgLKRwg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Dec 2020 12:52:36 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89AC0613D3
        for <linux-efi@vger.kernel.org>; Fri, 11 Dec 2020 09:51:55 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 82so1851459yby.6
        for <linux-efi@vger.kernel.org>; Fri, 11 Dec 2020 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q09SnWNYOGRP1aNUnVwFGO3MFQmvVcctUwsQU76BGc=;
        b=nByrL7+1KjFw3I/zYNYfdITtVIH2sUB1nu7ab1NWcdA8d9RUIyx3D8ncYGF2AQay/M
         gZvQUoqxfz9zh+IHsxoksiXUA5dFkwt5KAvxAUnLd6gy5d+CrNVkPijTcZjVlGNGyX12
         /AUf58EyclUw/MN+Qp6b0kBjAtntMdSfoEARdDqo/Do4IkOnsHjBjHRdWk7+5sygM4TM
         Qu/hkTyBUPqKMXpOddtqNqpI8SmmG1/OEbIRBFOkTSEDxkldAzLD9nL/heWiE6PVjHMs
         gKmMpbyDBiSyz241Lc0PPj1/J2FzTyEanWMyfoa0d0y8c8T8cuS6n4LxO2jz+72KORc/
         7g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q09SnWNYOGRP1aNUnVwFGO3MFQmvVcctUwsQU76BGc=;
        b=f2f/sCzhibz/oL/A5LM1KwQLenJIo2DZ6FBDBksMCBYLw4PDC6853IKoJojxBEbnW5
         qCsowPTyRhA4oGOUr7UBmJAzsWDYOdBIX1kk3RkrjLYaOD3n87dMG8Mb6F27damTHorK
         deOtQJVty/O9uoMA9fcNmeW2N3UXXPHIYmFbdB2YRT9ZVWMw5uciw9SV2xS6626d+Ljs
         hk+mWmrpmQy05clvSNsBVRQNIYdKGTVm6aqMQAq/zIi6KzIvMWkyuI1Q6iJ/OHwUggDf
         Hhl+Wao0HZ1lgyGuFU4Y1nc+K0hBOiAYiJdqd5q5aY1BvWufLDBTNZQWijuU0nSxCb+j
         dR+A==
X-Gm-Message-State: AOAM530nlwTI7AuWpOlEJlus+KwQFJM6fAdJotRDkMPFQplLLjQ6x7fB
        XNJ20rfmiDs0Pj71WzG/FrM95aE6d34gL9BwBq4T8A==
X-Google-Smtp-Source: ABdhPJyKV8I72WSxCSW58eTlK3Q2/Bh0uk6M0D9gYiFdPQFjwUoPp6YT9DUKiRv0Idghprhgulkb5EjOOhWixxO6L50=
X-Received: by 2002:a25:6604:: with SMTP id a4mr21355396ybc.412.1607709114755;
 Fri, 11 Dec 2020 09:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-17-saravanak@google.com>
 <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com> <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com>
In-Reply-To: <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 11 Dec 2020 09:51:18 -0800
Message-ID: <CAGETcx-MsNyWWT=s1H6hDK+=QvibBLQrT9rM51y5bkomV_+G6g@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Qian Cai <qcai@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 11, 2020 at 8:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-12-11 14:11, Qian Cai wrote:
> > On Fri, 2020-11-20 at 18:02 -0800, Saravana Kannan wrote:
> >> The current implementation of fw_devlink is very inefficient because it
> >> tries to get away without creating fwnode links in the name of saving
> >> memory usage. Past attempts to optimize runtime at the cost of memory
> >> usage were blocked with request for data showing that the optimization
> >> made significant improvement for real world scenarios.
> >>
> >> We have those scenarios now. There have been several reports of boot
> >> time increase in the order of seconds in this thread [1]. Several OEMs
> >> and SoC manufacturers have also privately reported significant
> >> (350-400ms) increase in boot time due to all the parsing done by
> >> fw_devlink.
> >>
> >> So this patch uses all the setup done by the previous patches in this
> >> series to refactor fw_devlink to be more efficient. Most of the code has
> >> been moved out of firmware specific (DT mostly) code into driver core.
> >>
> >> This brings the following benefits:
> >> - Instead of parsing the device tree multiple times during bootup,
> >>    fw_devlink parses each fwnode node/property only once and creates
> >>    fwnode links. The rest of the fw_devlink code then just looks at these
> >>    fwnode links to do rest of the work.
> >>
> >> - Makes it much easier to debug probe issue due to fw_devlink in the
> >>    future. fw_devlink=on blocks the probing of devices if they depend on
> >>    a device that hasn't been added yet. With this refactor, it'll be very
> >>    easy to tell what that device is because we now have a reference to
> >>    the fwnode of the device.
> >>
> >> - Much easier to add fw_devlink support to ACPI and other firmware
> >>    types. A refactor to move the common bits from DT specific code to
> >>    driver core was in my TODO list as a prerequisite to adding ACPI
> >>    support to fw_devlink. This series gets that done.
> >>
> >> [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >
> > Reverting this commit and its dependency:
> >
> > 2d09e6eb4a6f driver core: Delete pointless parameter in fwnode_operations.add_links
> >
> > from today's linux-next fixed a boot crash on an arm64 Thunder X2 server.
>
> Since the call stack implicates the platform-device-wrangling we do in
> IORT code I took a quick look; AFAICS my guess would be it's blowing up
> trying to walk a zeroed list head since "driver core: Add fwnode_init()"
> missed acpi_alloc_fwnode_static().

Thanks Robin. I'm pretty sure this is the reason. I thought I fixed
all ACPI cases, but clearly I missed this one. I'll send out a patch
for this today. If you think there are any other places I missed
please let me know. I'll try some git grep foo to see if I missed any
other instances of fwnode ops being set.

-Saravana
