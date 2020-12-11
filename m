Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90882D7DFF
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbgLKSXG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 13:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403962AbgLKSWP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Dec 2020 13:22:15 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B643C061793
        for <linux-efi@vger.kernel.org>; Fri, 11 Dec 2020 10:21:35 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id k78so8842617ybf.12
        for <linux-efi@vger.kernel.org>; Fri, 11 Dec 2020 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nfCZOSqX7COlA0cX0qwHs2uGtZKPhKQtcgW7ARql84=;
        b=TTj3anE2uKBi65yax42DvVyXtHiR5dNluaIDzNsBzVLxREPMI0Bv3a3JJkzWlFWVxs
         EcTM7YX14DVsq611DEoo9rmdi1Ocnp3UTkyhNJB2W7Q34gK0k2M7rGDXI6o0gcH/bNDp
         DkOX459MIk75crR+cRJ6tgP2MCDkfAclWerJpMa5YdgryyZN9AITPOSxuwm6dfsusT6Y
         UIWShFAdm9wbcaYDkFSFPAdnSGycyTCLHdK7sagUX+feyZUp44z/r3R4troXKCuyBG+d
         rvpVWobLXW9SJ15paSnqjDrt9Q6EiS7BccFFO5Zl+Gl5MpI8RTi6i3FGPpMBxpcSFqUk
         U8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nfCZOSqX7COlA0cX0qwHs2uGtZKPhKQtcgW7ARql84=;
        b=XFT55OGra+zOuK21VmNbyvwmShpYCK/k/psHcraY5iiV1vsPoD2EniCfUgteWIAcwo
         KJzCjxilUxbFwALSpJMf5+EGwoh+v0xWsQ2LxSWUG8ePf1SbkbFg4roUScWAkp1765A0
         BSdJD3sNrpJrBWJbeJ/JBzVRnW4T4YRzP2VrLnbLbNMTlAbcV227wj6jVkWat3HMskkj
         NG1i7vV7YoBl02x18Ka94rgPuVCxH+hp9SmE0kklVGxEkiSRfRayQFJphHjhnNlsE7lH
         iJlcZzvMQvr5B3aeArserItcYUYxzH4fsA9V92e71tFPFPOG97srSbfhH4on/aF/5j78
         04dA==
X-Gm-Message-State: AOAM532mjNgqAxpbio/MOM+0qP/nv9fHHxHhRqxkt78sa9toMmFjDvx5
        wbZn+X1vNqR1Sq+2CM2TU+o6n7Q7aPYlDabs8P3G9Q==
X-Google-Smtp-Source: ABdhPJxAiV+XtwJamoCUeVUhu+ibpatPBAR0rjxSrKWUqKVWEHeqwsrOQAEylJ6pRw/sGUzjlziknTO/PevczSvPNbE=
X-Received: by 2002:a25:824e:: with SMTP id d14mr13356399ybn.346.1607710894170;
 Fri, 11 Dec 2020 10:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-17-saravanak@google.com>
 <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com>
 <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com> <CAGETcx-MsNyWWT=s1H6hDK+=QvibBLQrT9rM51y5bkomV_+G6g@mail.gmail.com>
 <813b3fbd80ad4dfee7ff8517d4829a1f@kernel.org>
In-Reply-To: <813b3fbd80ad4dfee7ff8517d4829a1f@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 11 Dec 2020 10:20:58 -0800
Message-ID: <CAGETcx_hPVv1iTt6q3gLmBN=q+_O6vTwxeS5Nj55Smm3FNk24Q@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
To:     Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Qian Cai <qcai@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
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

On Fri, Dec 11, 2020 at 10:03 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-12-11 17:51, Saravana Kannan wrote:
> > On Fri, Dec 11, 2020 at 8:34 AM Robin Murphy <robin.murphy@arm.com>
> > wrote:
> >>
> >> On 2020-12-11 14:11, Qian Cai wrote:
> >> > On Fri, 2020-11-20 at 18:02 -0800, Saravana Kannan wrote:
> >> >> The current implementation of fw_devlink is very inefficient because it
> >> >> tries to get away without creating fwnode links in the name of saving
> >> >> memory usage. Past attempts to optimize runtime at the cost of memory
> >> >> usage were blocked with request for data showing that the optimization
> >> >> made significant improvement for real world scenarios.
> >> >>
> >> >> We have those scenarios now. There have been several reports of boot
> >> >> time increase in the order of seconds in this thread [1]. Several OEMs
> >> >> and SoC manufacturers have also privately reported significant
> >> >> (350-400ms) increase in boot time due to all the parsing done by
> >> >> fw_devlink.
> >> >>
> >> >> So this patch uses all the setup done by the previous patches in this
> >> >> series to refactor fw_devlink to be more efficient. Most of the code has
> >> >> been moved out of firmware specific (DT mostly) code into driver core.
> >> >>
> >> >> This brings the following benefits:
> >> >> - Instead of parsing the device tree multiple times during bootup,
> >> >>    fw_devlink parses each fwnode node/property only once and creates
> >> >>    fwnode links. The rest of the fw_devlink code then just looks at these
> >> >>    fwnode links to do rest of the work.
> >> >>
> >> >> - Makes it much easier to debug probe issue due to fw_devlink in the
> >> >>    future. fw_devlink=on blocks the probing of devices if they depend on
> >> >>    a device that hasn't been added yet. With this refactor, it'll be very
> >> >>    easy to tell what that device is because we now have a reference to
> >> >>    the fwnode of the device.
> >> >>
> >> >> - Much easier to add fw_devlink support to ACPI and other firmware
> >> >>    types. A refactor to move the common bits from DT specific code to
> >> >>    driver core was in my TODO list as a prerequisite to adding ACPI
> >> >>    support to fw_devlink. This series gets that done.
> >> >>
> >> >> [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
> >> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> >> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> >> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> >
> >> > Reverting this commit and its dependency:
> >> >
> >> > 2d09e6eb4a6f driver core: Delete pointless parameter in fwnode_operations.add_links
> >> >
> >> > from today's linux-next fixed a boot crash on an arm64 Thunder X2 server.
> >>
> >> Since the call stack implicates the platform-device-wrangling we do in
> >> IORT code I took a quick look; AFAICS my guess would be it's blowing
> >> up
> >> trying to walk a zeroed list head since "driver core: Add
> >> fwnode_init()"
> >> missed acpi_alloc_fwnode_static().
> >
> > Thanks Robin. I'm pretty sure this is the reason. I thought I fixed
> > all ACPI cases, but clearly I missed this one. I'll send out a patch
> > for this today. If you think there are any other places I missed
> > please let me know. I'll try some git grep foo to see if I missed any
> > other instances of fwnode ops being set.
>
> Yup, that fixed it here (QDF2400).
>
> Thanks,
>
>          M.
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 39263c6b52e1..2630c2e953f7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -55,7 +55,7 @@ static inline struct fwnode_handle
> *acpi_alloc_fwnode_static(void)
>         if (!fwnode)
>                 return NULL;
>
> -       fwnode->ops = &acpi_static_fwnode_ops;
> +       fwnode_init(fwnode, &acpi_static_fwnode_ops);
>
>         return fwnode;
>   }
>

Lol, my only contribution to the patch will be the commit text. I'll
send them with reported-by, suggested-by and tested-by if no one less
beats me to it.

-Saravana
