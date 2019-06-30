Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06175B214
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfF3VfW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 17:35:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45429 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfF3VfW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 17:35:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so19246600edv.12;
        Sun, 30 Jun 2019 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drW2YTBKN6ODzV8fpJChJUilq9RUfbBjnjppu5Nuk2w=;
        b=cJ6bekFPnfqGyakEnAscY4w+19vNzVvyQTnuLMUpd9zx0kBpuoYqRAfbyxgMnI15JD
         QQBafOwtBzLUiUz+e5G4jv7g2YcEXJ0SJR1H/Okt7ZOsYgpstIqNb9k/EY5gK761qMMN
         /6FC0Ap2qs6nnorET907XIZsxwZOlYwLLFr/4Dyw5AjFGaSPm6KrJykDIsLlGmFRMtWJ
         056BNBqVLWyhMdP8yWQ5CzLV0SArxzqim2kozKYIXmVWiRra9m4xlwYa+rqVQ2PWsct2
         NK6DGHZ0/1Uh1b9NOdEkAMw0/fKw6hNs9dSMT32jigjyzg5lEQJvmdbzngP/Ung2Hrrs
         TrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drW2YTBKN6ODzV8fpJChJUilq9RUfbBjnjppu5Nuk2w=;
        b=kqk/P/ssXphs5Z7vS+qX+jlF571w61R/DJXXlVdve0Cf8HL+eHy/5vl30U55xwbDGc
         hH5UZZ/zgxlJsafEtpr5zmaeNbop6o2jqiME8V8zQckWZx8msPSag0cKDR2u+x784UmT
         //4ft4aqGTOl50wucmT2wxY/Y+we26v6nB8ftQ011ixHB8nOfLxlFWsxxFygSAX6qvUD
         A51lHge4hGtbw5eQpIUODsJXkI57qiwm7V8/DlirqE8ZiOn2LWpa70jqOUwRWhHC8t+V
         mSmNQHihZ76o67G0cmNW5tdzpO6WxP7hWlJnxyz0ZBg4ntSqh8cO1cPHWKXM4U7m1oqS
         7Llw==
X-Gm-Message-State: APjAAAVCupjyCbxCHqeP7SH5wewKVPXi9pw1dieZNNJmL5cCMWgvN+tO
        ddqy6J5svsK2adGtRiazFaPj3e6JJltIpACqmno=
X-Google-Smtp-Source: APXvYqyfzt5ulq5SOtHkjn3qBwTNbdXmkvyLV9Y0HOd765n8mKeEG94kxcuB56qn/tdJ6mZ6/TSKAUbb6wKfdt+MToo=
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr19281848ejb.265.1561930519755;
 Sun, 30 Jun 2019 14:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630204723.GH7043@pendragon.ideasonboard.com>
 <CAF6AEGvA-wVyC4jJC-nZU-pdVH=KYtye9twDgup-Nq0C_+wtvQ@mail.gmail.com> <20190630211520.GI7043@pendragon.ideasonboard.com>
In-Reply-To: <20190630211520.GI7043@pendragon.ideasonboard.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 30 Jun 2019 14:35:04 -0700
Message-ID: <CAF6AEGtA=xB6QCAZK0oiv4DVd3VvVX-f=C_+23tW2fBqyfLqbw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm+dt+efi: support devices with multiple possible panels
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 30, 2019 at 2:15 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On Sun, Jun 30, 2019 at 02:05:21PM -0700, Rob Clark wrote:
> > On Sun, Jun 30, 2019 at 1:47 PM Laurent Pinchart wrote:
> > > On Sun, Jun 30, 2019 at 01:36:04PM -0700, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Now that we can deal gracefully with bootloader (firmware) initialized
> > > > display on aarch64 laptops[1], the next step is to deal with the fact
> > > > that the same model of laptop can have one of multiple different panels.
> > > > (For the yoga c630 that I have, I know of at least two possible panels,
> > > > there might be a third.)
> > >
> > > I have to ask the obvious question: why doesn't the boot loader just
> > > pass a correct DT to Linux ? There's no point in passing a list of
> > > panels that are not there, this seems quite a big hack to me. A proper
> > > boot loader should construct the DT based on hardware detection.
> >
> > Hi Laurent,
> >
> > Actually the bootloader on these devices is passing *no* dt (they boot
> > ACPI, we are loading dtb from grub currently)
>
> Ah, the broken promises of ACPI on ARM64. I wonder how long it will take
> before a public acknowledgement that it was a bad idea. Bad ideas happen
> and can be forgiven, but stubborness in claiming it was the right
> decision is another story.
>
> (Not that you can be blamed for this of course :-))

To be fair, I think the only blame here is that MS let qcom get away
with some things in their ACPI and UEFI implementation..  I think
we'll need to shift to ACPI eventually for these laptops, in order to
keep up.  DT isn't a thing that would scale with the volume of x86
laptops that exist, and if aarch64 laptops get there too, we'll need
ACPI.  Lets face it, the # of different dt devices supported upstream
is a drop in the bucket compared to number of *actually physically
different* x86 devices supported by upstream.  (And I don't mean
individual models of laptops, but different production runs where they
picked a different panel or trackpad or whatever.)

But we have a lot of upstream work to get there to support how ACPI
works on these things:

 * The new Platform Extension Plugin (PEP) model for device power
   control
 * untangling drm bridge hookup from DT
 * untangling drm panel hook from DT
 * figuring out how to deal with mis-matches between dt device
   model and ACPI device model

There is some early work for ACPI support for these devices, but
realistically I think it is going to take a better part of a year to
get there.  Until then we rely on DT.

That isn't to say my proposal doesn't make a ton of sense.  We also
need to solve this problem for DT based devices, and I think
/chosen/panel-id makes a *ton* of sense for those devices.

> > I think normally a device built w/ dt in mind would populate
> > /chosen/panel-id directly (rather than the way it is currently
> > populated based on reading an efi variable prior to ExitBootServices).
> > But that is considerably easier ask than having it re-write of_graph
> > bindings. Either way, we aren't in control of the bootloader on these
> > devices,
>
> If you can't control the initial boot loader, then I see two options,
> none of which you will like I'm afraid.
>
> - As you pass the DT to Linux from grub, there's your intermediate boot
>   loader where you can construct a valid DT.

not really a solution that is going to scale

> - If the ACPI cult needs to be venerated, then drivers should be
>   converted to support ACPI without the need for DT.

we're working on it

> A possible a middleground could be a platform driver (in
> drivers/firmware/efi/ ? in drivers/platform/ ?) that will patch the DT
> to instantiate the right panel based on the information retrieved from
> the boot loader. We will need something similar for the Intel IPU3
> camera driver, as Intel decided to come up with two different ACPI
> "bindings", one for Windows and one for Chrome OS, leaving Windows
> machine impossible to handle from a kernel driver due to required
> information being hardcoded in Windows drivers shipped by Intel. This is
> thus an option that may (unfortunately) need to become more widespread
> for ACPI-based systems.

again, a kernel (or bootloader) side massively intrusive re-write the
dt approach isn't going to scale.  If you keep it simple, ie.
/chosen/panel-id I can see a possibility to move my patch from
drivers/firmware/efi into an earlier stage.  But if it has to re-write
graph, that falls apart as soon as a new device comes along with a
different bridge, or perhaps some vendor decides to use dsi directly
and forego the bridge.

usually (from what I've seen so far) there are a few gpios to probe to
decide which panel you have.  So after a few lines of gpio banging you
can either ask fw engineers to set appropriate node in chosen.. or
re-write of_graph bindings.  I think the former has a chance of
gaining traction on android devices.. latter not so much.  You are
really making too big of an ask for fw engineers ;-)

> > so it is a matter of coming up with something that works on actual hw
> > that we don't like rather than idealized hw that we don't have ;-)
>
> That doesn't however justify not going for the best solution we can
> achieve. What do you like best in the above ? :-)

I want a solution that is achievable ;-)

BR,
-R
