Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677CE2A902F
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 08:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFHWC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 02:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHWC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Nov 2020 02:22:02 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F0B20825;
        Fri,  6 Nov 2020 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604647320;
        bh=i2EjFVFc/nx2RMuU8Nde7JRgivITs9LD27Q8XbxFmuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCwZXCwdWLtsO3lGzYTbgw5I/1r65MW3SvzEuXwBqqlhwy7QL5N3L/hDUrzPxxokW
         u5K7Vnbys9/vWJW27fvrzrNs98Ba+b/hM3po043KOpewZaE9GYCScdN/3edcmUS1nN
         z2x+XLuvU21EsoG1NFs1I5DzY/9wu9DmJjBOesHI=
Date:   Fri, 6 Nov 2020 08:22:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v1 15/18] of: property: Update implementation of
 add_links() to create fwnode links
Message-ID: <20201106072247.GB2614221@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-16-saravanak@google.com>
 <20201105094228.GE3439341@kroah.com>
 <CAGETcx-0TPte6g3Cf5F3WJwdW-9yUptLDj3AcEdvWN0YJ2H4qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-0TPte6g3Cf5F3WJwdW-9yUptLDj3AcEdvWN0YJ2H4qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 05, 2020 at 03:25:56PM -0800, Saravana Kannan wrote:
> On Thu, Nov 5, 2020 at 1:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 04, 2020 at 03:23:52PM -0800, Saravana Kannan wrote:
> > > The semantics of add_links() has changed from creating device link
> > > between devices to creating fwnode links between fwnodes. So, update the
> > > implementation of add_links() to match the new semantics.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 150 ++++++++++++------------------------------
> > >  1 file changed, 41 insertions(+), 109 deletions(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 408a7b5f06a9..86303803f1b3 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1038,33 +1038,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
> > >  }
> > >
> > >  /**
> > > - * of_get_next_parent_dev - Add device link to supplier from supplier phandle
> > > - * @np: device tree node
> > > - *
> > > - * Given a device tree node (@np), this function finds its closest ancestor
> > > - * device tree node that has a corresponding struct device.
> > > - *
> > > - * The caller of this function is expected to call put_device() on the returned
> > > - * device when they are done.
> > > - */
> > > -static struct device *of_get_next_parent_dev(struct device_node *np)
> > > -{
> > > -     struct device *dev = NULL;
> > > -
> > > -     of_node_get(np);
> > > -     do {
> > > -             np = of_get_next_parent(np);
> > > -             if (np)
> > > -                     dev = get_dev_from_fwnode(&np->fwnode);
> > > -     } while (np && !dev);
> > > -     of_node_put(np);
> > > -     return dev;
> > > -}
> > > -
> > > -/**
> > > - * of_link_to_phandle - Add device link to supplier from supplier phandle
> > > - * @dev: consumer device
> > > - * @sup_np: phandle to supplier device tree node
> > > + * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> > > + * @con_np: consumer device tree node
> > > + * @sup_np: supplier device tree node
> > >   *
> > >   * Given a phandle to a supplier device tree node (@sup_np), this function
> > >   * finds the device that owns the supplier device tree node and creates a
> > > @@ -1074,16 +1050,14 @@ static struct device *of_get_next_parent_dev(struct device_node *np)
> > >   * cases, it returns an error.
> > >   *
> > >   * Returns:
> > > - * - 0 if link successfully created to supplier
> > > - * - -EAGAIN if linking to the supplier should be reattempted
> > > + * - 0 if fwnode link successfully created to supplier
> > >   * - -EINVAL if the supplier link is invalid and should not be created
> > > - * - -ENODEV if there is no device that corresponds to the supplier phandle
> > > + * - -ENODEV if struct device will never be create for supplier
> > >   */
> > > -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > > -                           u32 dl_flags)
> > > +static int of_link_to_phandle(struct device_node *con_np,
> > > +                           struct device_node *sup_np)
> > >  {
> > > -     struct device *sup_dev, *sup_par_dev;
> > > -     int ret = 0;
> > > +     struct device *sup_dev;
> > >       struct device_node *tmp_np = sup_np;
> > >
> > >       of_node_get(sup_np);
> > > @@ -1106,7 +1080,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > >       }
> > >
> > >       if (!sup_np) {
> > > -             dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
> > > +             pr_debug("Not linking %pOFP to %pOFP - No device\n",
> > > +                      con_np, tmp_np);
> >
> > Who is calling this function without a valid dev pointer?
> 
> Sorry, I plan to delete the "dev" parameter as it's not really used
> anywhere. I'm trying to do that without causing build time errors and
> making the series into digestible small patches.
> 
> I can do the deletion of the parameter as a Patch 19/19. Will that work?

That's fine, but why get rid of dev?  The driver core works on these
things, and we want errors/messages/warnings to spit out what device is
causing those issues.  It is fine to drag around a struct device pointer
just for messages, that's to be expected, and is good.

> > And the only way it can be NULL is if fwnode is NULL, and as you control
> > the callers to it, how can that be the case?
> 
> fwnode represents a generic firmware node. The to_of_node() returns
> NULL if fwnode is not a DT node. So con_np can be NULL if that
> happens. That's why we need a NULL check here.  With the current code,
> that can never happen, bit I think it doesn't hurt to check in case
> there's a buggy caller. I don't have a strong opinion - so I can do it
> whichever way.

If it can't happen, no need to check for it :)

thanks,

greg k-h
