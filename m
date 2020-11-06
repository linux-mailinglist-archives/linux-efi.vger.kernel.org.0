Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC73E2A9149
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 09:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKFIaE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 03:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKFIaE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Nov 2020 03:30:04 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE1C0613CF
        for <linux-efi@vger.kernel.org>; Fri,  6 Nov 2020 00:30:04 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s89so437555ybi.12
        for <linux-efi@vger.kernel.org>; Fri, 06 Nov 2020 00:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rD9/ZK7971oPQsgTQDh0lNY/GvvQHJh4mKJIEvE3uW4=;
        b=swGAdYh9B4UcdKFMGOCYdOwSbZ937eS+baY29gHnJVzue1i6yqXwQF+5BKXpvKHr4Z
         RUmRrSbxIH9BqZJTbba/OvEVoirIt9d4jzAHqxguCotfDN1/W40/GMutFHguG2mUwzhi
         M4uq4gk+4QW2Ba7xpUV83eZSWr8OAGFvs+oJFFb6ym0AFvmVFkWocz+me2nV5VLsF+xA
         CaJMSqO+80UsA+xoFLE7I95pNMW3c4O9qWTgJBC5dOKZGc1+v9vPFzDgWjdMlQn1vHF0
         cPyugi+aPoE2+5RhsKIIn37Ics5Kgj0P4Cerj20T/T4lcehFRB/jWr2wp0dbMGqKlhM3
         Unxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rD9/ZK7971oPQsgTQDh0lNY/GvvQHJh4mKJIEvE3uW4=;
        b=KpvzScIX54V9mm94a9X1S1bHXoQdCw2BsnZSoUkceIuDXIPBdF9644W3OSqLU2Sms4
         hpLDmSrRTjyC0yRAbKdZV3xLfxIAhBA66Jy7fovK2Uo1X0SCC05GpVAjtE7a9zW3KWIb
         7ympnbc5Klp8EIFCfqba5oIUQ25MFzuAZoRE8m/M8daq3/YGKwzqSHxP9ERfhba2mBoQ
         M29SS2Hn1bjeq5dr7tkPnDjBwUC6KPeISyN59vMaQK5k0d1qzgzFeyZJhfO75Hgv++zu
         /1H3k0hhqoUuT4iIb1reA/pl9xvZIAb8oDMku0GJe8kirxklHLOkP0I3C3XaoU2erLjF
         T1iQ==
X-Gm-Message-State: AOAM532xZbRf9ap+BaAkuIzD8qRP7OistqGh6s04Rn3EAk8N7k4XimBh
        8RbgdOJOrhLRJ1VHeoRzV9AgqfloTd5KbGZxKr4lgg==
X-Google-Smtp-Source: ABdhPJwpd/q7RalIXkxlcZXBgsLbLVH8dlZ2vdkcPOrnPviYs7G3l0dFWmp/wsONIlbvLar8/0m7H/olvn4jVk0vsL4=
X-Received: by 2002:a25:3:: with SMTP id 3mr1306315yba.412.1604651403053; Fri,
 06 Nov 2020 00:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-16-saravanak@google.com> <20201105094228.GE3439341@kroah.com>
 <CAGETcx-0TPte6g3Cf5F3WJwdW-9yUptLDj3AcEdvWN0YJ2H4qg@mail.gmail.com>
 <20201106072247.GB2614221@kroah.com> <CAGETcx_tQboQPWuoj9hi38-1n=mAQihCi2b475z2r_9s_rXhNg@mail.gmail.com>
 <20201106075148.GA2619937@kroah.com>
In-Reply-To: <20201106075148.GA2619937@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Nov 2020 00:29:27 -0800
Message-ID: <CAGETcx9LNWAXmbbzp3_LMeA515jwOibBfrzcadAcsNTJPHVnnQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/18] of: property: Update implementation of
 add_links() to create fwnode links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
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

On Thu, Nov 5, 2020 at 11:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 05, 2020 at 11:41:20PM -0800, Saravana Kannan wrote:
> > On Thu, Nov 5, 2020 at 11:22 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Nov 05, 2020 at 03:25:56PM -0800, Saravana Kannan wrote:
> > > > On Thu, Nov 5, 2020 at 1:41 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Nov 04, 2020 at 03:23:52PM -0800, Saravana Kannan wrote:
> > > > > > The semantics of add_links() has changed from creating device link
> > > > > > between devices to creating fwnode links between fwnodes. So, update the
> > > > > > implementation of add_links() to match the new semantics.
> > > > > >
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > ---
> > > > > >  drivers/of/property.c | 150 ++++++++++++------------------------------
> > > > > >  1 file changed, 41 insertions(+), 109 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > index 408a7b5f06a9..86303803f1b3 100644
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1038,33 +1038,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > - * of_get_next_parent_dev - Add device link to supplier from supplier phandle
> > > > > > - * @np: device tree node
> > > > > > - *
> > > > > > - * Given a device tree node (@np), this function finds its closest ancestor
> > > > > > - * device tree node that has a corresponding struct device.
> > > > > > - *
> > > > > > - * The caller of this function is expected to call put_device() on the returned
> > > > > > - * device when they are done.
> > > > > > - */
> > > > > > -static struct device *of_get_next_parent_dev(struct device_node *np)
> > > > > > -{
> > > > > > -     struct device *dev = NULL;
> > > > > > -
> > > > > > -     of_node_get(np);
> > > > > > -     do {
> > > > > > -             np = of_get_next_parent(np);
> > > > > > -             if (np)
> > > > > > -                     dev = get_dev_from_fwnode(&np->fwnode);
> > > > > > -     } while (np && !dev);
> > > > > > -     of_node_put(np);
> > > > > > -     return dev;
> > > > > > -}
> > > > > > -
> > > > > > -/**
> > > > > > - * of_link_to_phandle - Add device link to supplier from supplier phandle
> > > > > > - * @dev: consumer device
> > > > > > - * @sup_np: phandle to supplier device tree node
> > > > > > + * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> > > > > > + * @con_np: consumer device tree node
> > > > > > + * @sup_np: supplier device tree node
> > > > > >   *
> > > > > >   * Given a phandle to a supplier device tree node (@sup_np), this function
> > > > > >   * finds the device that owns the supplier device tree node and creates a
> > > > > > @@ -1074,16 +1050,14 @@ static struct device *of_get_next_parent_dev(struct device_node *np)
> > > > > >   * cases, it returns an error.
> > > > > >   *
> > > > > >   * Returns:
> > > > > > - * - 0 if link successfully created to supplier
> > > > > > - * - -EAGAIN if linking to the supplier should be reattempted
> > > > > > + * - 0 if fwnode link successfully created to supplier
> > > > > >   * - -EINVAL if the supplier link is invalid and should not be created
> > > > > > - * - -ENODEV if there is no device that corresponds to the supplier phandle
> > > > > > + * - -ENODEV if struct device will never be create for supplier
> > > > > >   */
> > > > > > -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > > > > > -                           u32 dl_flags)
> > > > > > +static int of_link_to_phandle(struct device_node *con_np,
> > > > > > +                           struct device_node *sup_np)
> > > > > >  {
> > > > > > -     struct device *sup_dev, *sup_par_dev;
> > > > > > -     int ret = 0;
> > > > > > +     struct device *sup_dev;
> > > > > >       struct device_node *tmp_np = sup_np;
> > > > > >
> > > > > >       of_node_get(sup_np);
> > > > > > @@ -1106,7 +1080,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > > > > >       }
> > > > > >
> > > > > >       if (!sup_np) {
> > > > > > -             dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
> > > > > > +             pr_debug("Not linking %pOFP to %pOFP - No device\n",
> > > > > > +                      con_np, tmp_np);
> > > > >
> > > > > Who is calling this function without a valid dev pointer?
> > > >
> > > > Sorry, I plan to delete the "dev" parameter as it's not really used
> > > > anywhere. I'm trying to do that without causing build time errors and
> > > > making the series into digestible small patches.
> > > >
> > > > I can do the deletion of the parameter as a Patch 19/19. Will that work?
> > >
> > > That's fine, but why get rid of dev?  The driver core works on these
> > > things, and we want errors/messages/warnings to spit out what device is
> > > causing those issues.  It is fine to drag around a struct device pointer
> > > just for messages, that's to be expected, and is good.
> >
> > In general I agree. If the fwnode being parsed is related to the dev,
> > it's nice to have the dev name in the logs.
> >
> > But in this instance I feel it's analogous to printing the PID that's
> > parsing the fwnode -- kinda irrelevant. The device in question can
> > appear very random and it'll just cause more confusion than be of help
> > if it shows up in the logs.
> >
> > For example it can be something like:
> > <gpio device name>: linking <wifi fwnode> to <iommu fwnode>
> >
> > If the device was actually that of the wifi fwnode of the iommu
> > fwnode, I agree it'll be useful to carry around the dev even if it's
> > just for logs.
> >
> > Hope that makes sense.
>
> Not really, as the device here should be the one that is doing the
> linking, so why doesn't that matter?

No, the links being created here are fwnode links. Also, when a fwnode
is parsed (because the device corresponding to it is added), the whole
fwnode tree under it is also parsed. So the device in question won't
be either the consumer or the supplier when the log is printed. So the
device will just be some random ancestor up the parent chain.

-Saravana
