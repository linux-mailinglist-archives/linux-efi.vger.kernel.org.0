Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B508E2CDE77
	for <lists+linux-efi@lfdr.de>; Thu,  3 Dec 2020 20:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLCTGn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Dec 2020 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgLCTGn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Dec 2020 14:06:43 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1DC061A4E
        for <linux-efi@vger.kernel.org>; Thu,  3 Dec 2020 11:06:02 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id k65so3033181ybk.5
        for <linux-efi@vger.kernel.org>; Thu, 03 Dec 2020 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zY1/UVNK1lpCKgo46pv7M4xtEHqMkdRqZiYe+oaE/HI=;
        b=kBXK6rf2l4HvR3AS0yI+1werbY73mRV1JLVfNayiYB24G4hZ+mMX9KhAe6rtLui6wT
         l+lgZE+6rx2soFftZ/7j+GPO2PmOscV4Vbqt0Ff03wqQ5toUTRKCyOAdLNdoDa1pKbjg
         7j4e4l749WlmL7AXqJPQOVJjPkHPHSs6J2y+ZCElAN/sF033I+N/QZot64Qd+YYYqF+d
         8RqTgH/KtpaMY9PolKpcFzZMTF/JbjDk/O7PXIUOxQ6Ryo2icN6J5B9PqMJ6eC7uVBTJ
         DXSm2kocF3znjF9z9rF3V7J2WMpCDm+VePuBTnXeflnecy2J7uOGs4/nlDeDyjlCGIhO
         fE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zY1/UVNK1lpCKgo46pv7M4xtEHqMkdRqZiYe+oaE/HI=;
        b=lcO5OHYRwRQOCNtSAe7mEeAtrBtlycEqfcqIWrUhO6mLEBp8K9FSf3WLuwGZ4xNeUM
         hAJNvaj9l1c8O3wtR0G9lyo+VsYh+RMKFxf0X66Y/boRPeoLVz1meBFSdvw/jDux+TV2
         VILqzW0VCvLEryh+IuLIYfDJUvenA35gBm8aH3fLqvzK22AXAPPb4SUbyFTZpOemuy8n
         dtRgTjvvphdqDrVMd1maUjdRWK45PodqblGf792YmEsToNo1oKwT80yeaa0MwbnvcWSc
         lDWbiVRJX7jLFplOTS1NiEUJCA1HcHqUfn0LZBMuxhe0va2P9vGlgKXDmr+vgV2uj1CH
         qStQ==
X-Gm-Message-State: AOAM532qjAQocSPVPlv6GE3VqRMEgfB0H2L4Hnz3xc8Eu5X6nej25iWa
        +QXZvxOm2/UZqRloXDv/PrTUEldSNZ7BeBSTo6GMWA==
X-Google-Smtp-Source: ABdhPJyByVU3U6UwdjEq6N0aHqjYPPhLQgY+wiLEv+vExlD872m6k9m3aMBysR1FSGFum9W802/y/aH7VgFItnp+7lI=
X-Received: by 2002:a25:8401:: with SMTP id u1mr969238ybk.96.1607022361930;
 Thu, 03 Dec 2020 11:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <758a1b59-1033-b0ae-2549-84c8eeea4b11@ti.com>
In-Reply-To: <758a1b59-1033-b0ae-2549-84c8eeea4b11@ti.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 3 Dec 2020 11:05:26 -0800
Message-ID: <CAGETcx_CzrPDZA_C+8JvCeL-bSPB814jfDLscEEe+TLiHhBxjA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Refactor fw_devlink to significantly improve
 boot time
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 24, 2020 at 12:29 AM 'Tomi Valkeinen' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi,
>
> On 21/11/2020 04:02, Saravana Kannan wrote:
> > The current implementation of fw_devlink is very inefficient because it
> > tries to get away without creating fwnode links in the name of saving
> > memory usage. Past attempts to optimize runtime at the cost of memory
> > usage were blocked with request for data showing that the optimization
> > made significant improvement for real world scenarios.
> >
> > We have those scenarios now. There have been several reports of boot
> > time increase in the order of seconds in this thread [1]. Several OEMs
> > and SoC manufacturers have also privately reported significant
> > (350-400ms) increase in boot time due to all the parsing done by
> > fw_devlink.
> >
> > So this patch series refactors fw_devlink to be more efficient. The key
> > difference now is the addition of support for fwnode links -- just a few
> > simple APIs. This also allows most of the code to be moved out of
> > firmware specific (DT mostly) code into driver core.
> >
> > This brings the following benefits:
> > - Instead of parsing the device tree multiple times (complexity was
> >   close to O(N^3) where N in the number of properties) during bootup,
> >   fw_devlink parses each fwnode node/property only once and creates
> >   fwnode links. The rest of the fw_devlink code then just looks at these
> >   fwnode links to do rest of the work.
> >
> > - Makes it much easier to debug probe issue due to fw_devlink in the
> >   future. fw_devlink=on blocks the probing of devices if they depend on
> >   a device that hasn't been added yet. With this refactor, it'll be very
> >   easy to tell what that device is because we now have a reference to
> >   the fwnode of the device.
> >
> > - Much easier to add fw_devlink support to ACPI and other firmware
> >   types. A refactor to move the common bits from DT specific code to
> >   driver core was in my TODO list as a prerequisite to adding ACPI
> >   support to fw_devlink. This series gets that done.
> >
> > Laurent and Grygorii tested the v1 series and they saw boot time
> > improvment of about 12 seconds and 3 seconds, respectively.
>
> Tested v2 on OMAP4 SDP. With my particular config, boot time to starting init went from 18.5 seconds
> to 12.5 seconds.
>
>  Tomi

Rafael,

Friendly reminder for a review.

-Saravana
