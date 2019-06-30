Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8C5B200
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfF3VPn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 17:15:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50072 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfF3VPm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 17:15:42 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA314255;
        Sun, 30 Jun 2019 23:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561929339;
        bh=ovOJRUKGuB0B+RSWGOmJMUYTVzj7mL2ayN8AUFBIu2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldGx5vNtc4yCQQ3gLtoRrO/n97/UY5ZnZY0gcotp7JbPSLEKnMpadMMqg4DOCCtFl
         ewsfEDLY2skIB00hNAYBILOQA1protB2QAXohQvEfNBr1sLNZA2J1B6FWeGmcFBEjM
         sFLPtc7yAgk3wIcQfJKSdood9wFvscQcwYcx8eCk=
Date:   Mon, 1 Jul 2019 00:15:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Clark <robdclark@gmail.com>
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
Subject: Re: [PATCH 0/4] drm+dt+efi: support devices with multiple possible
 panels
Message-ID: <20190630211520.GI7043@pendragon.ideasonboard.com>
References: <20190630203614.5290-1-robdclark@gmail.com>
 <20190630204723.GH7043@pendragon.ideasonboard.com>
 <CAF6AEGvA-wVyC4jJC-nZU-pdVH=KYtye9twDgup-Nq0C_+wtvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6AEGvA-wVyC4jJC-nZU-pdVH=KYtye9twDgup-Nq0C_+wtvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Rob,

On Sun, Jun 30, 2019 at 02:05:21PM -0700, Rob Clark wrote:
> On Sun, Jun 30, 2019 at 1:47 PM Laurent Pinchart wrote:
> > On Sun, Jun 30, 2019 at 01:36:04PM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Now that we can deal gracefully with bootloader (firmware) initialized
> > > display on aarch64 laptops[1], the next step is to deal with the fact
> > > that the same model of laptop can have one of multiple different panels.
> > > (For the yoga c630 that I have, I know of at least two possible panels,
> > > there might be a third.)
> >
> > I have to ask the obvious question: why doesn't the boot loader just
> > pass a correct DT to Linux ? There's no point in passing a list of
> > panels that are not there, this seems quite a big hack to me. A proper
> > boot loader should construct the DT based on hardware detection.
> 
> Hi Laurent,
> 
> Actually the bootloader on these devices is passing *no* dt (they boot
> ACPI, we are loading dtb from grub currently)

Ah, the broken promises of ACPI on ARM64. I wonder how long it will take
before a public acknowledgement that it was a bad idea. Bad ideas happen
and can be forgiven, but stubborness in claiming it was the right
decision is another story.

(Not that you can be blamed for this of course :-))

> I think normally a device built w/ dt in mind would populate
> /chosen/panel-id directly (rather than the way it is currently
> populated based on reading an efi variable prior to ExitBootServices).
> But that is considerably easier ask than having it re-write of_graph
> bindings. Either way, we aren't in control of the bootloader on these
> devices,

If you can't control the initial boot loader, then I see two options,
none of which you will like I'm afraid.

- As you pass the DT to Linux from grub, there's your intermediate boot
  loader where you can construct a valid DT.

- If the ACPI cult needs to be venerated, then drivers should be
  converted to support ACPI without the need for DT.

A possible a middleground could be a platform driver (in
drivers/firmware/efi/ ? in drivers/platform/ ?) that will patch the DT
to instantiate the right panel based on the information retrieved from
the boot loader. We will need something similar for the Intel IPU3
camera driver, as Intel decided to come up with two different ACPI
"bindings", one for Windows and one for Chrome OS, leaving Windows
machine impossible to handle from a kernel driver due to required
information being hardcoded in Windows drivers shipped by Intel. This is
thus an option that may (unfortunately) need to become more widespread
for ACPI-based systems.

> so it is a matter of coming up with something that works on actual hw
> that we don't like rather than idealized hw that we don't have ;-)

That doesn't however justify not going for the best solution we can
achieve. What do you like best in the above ? :-)

-- 
Regards,

Laurent Pinchart
