Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797C32A9036
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 08:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKFHXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 02:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHXY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Nov 2020 02:23:24 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E346F20825;
        Fri,  6 Nov 2020 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604647403;
        bh=bZJj9WzPD8oFm2s1+akaeCuY5a6U01z3MrdDbjK8/Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIcEk99OJ4VFTbYW0yjOffgikbLeXsA+wGZwFN+Y8mCjh7EPIIibbGa5bK+p5Y+iJ
         TjCrMctji9tbz6sdmeR5D90XVG7CS0wFRHlQetPCM1jPQhgEWoavBDWYwCqzTL/UoQ
         /NLE8cZ86XvPHeVG7xAcrlFVIjVfRPKuzGMjSC9g=
Date:   Fri, 6 Nov 2020 08:24:10 +0100
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
Subject: Re: [PATCH v1 17/18] driver core: Add helper functions to convert
 fwnode links to device links
Message-ID: <20201106072410.GC2614221@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-18-saravanak@google.com>
 <20201105094350.GG3439341@kroah.com>
 <CAGETcx--D_KCpvK3b9NAQbMgWxzYT6MGEav1h2M8V7f=wK5L6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx--D_KCpvK3b9NAQbMgWxzYT6MGEav1h2M8V7f=wK5L6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 05, 2020 at 03:32:05PM -0800, Saravana Kannan wrote:
> On Thu, Nov 5, 2020 at 1:43 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 04, 2020 at 03:23:54PM -0800, Saravana Kannan wrote:
> > > Add helper functions __fw_devlink_link_to_consumers() and
> > > __fw_devlink_link_to_suppliers() that convert fwnode links to device
> > > links.
> > >
> > > __fw_devlink_link_to_consumers() is for creating:
> > > - Device links between a newly added device and all its consumer devices
> > >   that have been added to driver core.
> > > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> > >   the parent devices of all its consumers that have not been added to
> > >   driver core yet.
> > >
> > > __fw_devlink_link_to_suppliers() is for creating:
> > > - Device links between a newly added device and all its supplier devices
> > > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> > >   all the supplier devices of its child device nodes.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Did you just add build warnings with these static functions that no one
> > calls?
> 
> The next patch in this series uses it. I'm just splitting it up into a
> separate patch so that it's digestible and I can provide more details
> in the commit text.

But you can not add build warnings, you know this :)

> Couple of options:
> 1. Drop the static in this patch and add it back when it's used in patch 18/18.
> 2. Drop the commit text and squash this with 18/18 if you think the
> function documentation is clear enough and it won't make patch 18/18
> too hard to review.

It is hard to review new functions when you do not see them being used,
otherwise you have to flip back and forth between patches, which is
difficult.

Add the functions, and use them, in the same patch.  Otherwise we have
no idea _HOW_ you are using them, or even if you end up using them at
all.

thanks,

greg k-h
