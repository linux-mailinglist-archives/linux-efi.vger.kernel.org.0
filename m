Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67BC2D1A19
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLGT4y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 14:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGT4y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 14:56:54 -0500
Date:   Mon, 7 Dec 2020 21:56:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607370973;
        bh=yPs9QDsuXZBj0AnHJQPLKk5uozke+DFy1FCuNPHFJoo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJywbZ6F2J2n4eSInxwY89uD9zCi+tJPVViTO3691+MbLs7gpFDUgsHVlISgnxaB7
         c6Q6Gc5kLSk58ing3N17b3+fDpNAMQNcEZ0S6sBLEcJL1qggNTKcDJAaVRHUZJ7vsn
         IHEfwaOhAARTvu3xTRQhd3uK9sEWHcVC9XY5ot+uwbbn5OfWMOHrZGpShI+dseMtFb
         uhdRD/+roWdSMfEkiKVnPn4Zy4BvB1jRTFcgHWd8Ncx9goUulpxSHxOczempw61nn7
         MBvtpw3qDK0eSJ7jesv6ALXVKqqjoiF3kFJ04FAQZaTwKNjNtYaJG/+9sV46cHkFZQ
         vSDpsnS4WsP/A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v2 08/17] driver core: Add fwnode link support
Message-ID: <20201207195607.GG693271@unreal>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-9-saravanak@google.com>
 <20201206074840.GB687065@unreal>
 <CAGETcx8296K_v1p2-KAW7ABQjB02P63sBzz2aZoRW3E3WHb4Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8296K_v1p2-KAW7ABQjB02P63sBzz2aZoRW3E3WHb4Dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 07, 2020 at 11:25:03AM -0800, Saravana Kannan wrote:
> On Sat, Dec 5, 2020 at 11:48 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 06:02:23PM -0800, Saravana Kannan wrote:
> > > Add support for creating supplier-consumer links between fwnodes.  It is
> > > intended for internal use the driver core and generic firmware support
> > > code (eg. Device Tree, ACPI), so it is simple by design and the API
> > > provided is limited.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/core.c    | 98 ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/of/dynamic.c   |  1 +
> > >  include/linux/fwnode.h | 14 ++++++
> > >  3 files changed, 113 insertions(+)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 401fa7e3505c..e2b246a44d1a 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -50,6 +50,104 @@ static LIST_HEAD(wait_for_suppliers);
> > >  static DEFINE_MUTEX(wfs_lock);
> > >  static LIST_HEAD(deferred_sync);
> > >  static unsigned int defer_sync_state_count = 1;
> > > +static DEFINE_MUTEX(fwnode_link_lock);
> > > +
> > > +/**
> > > + * fwnode_link_add - Create a link between two fwnode_handles.
> > > + * @con: Consumer end of the link.
> > > + * @sup: Supplier end of the link.
> > > + *
> > > + * Create a fwnode link between fwnode handles @con and @sup. The fwnode link
> > > + * represents the detail that the firmware lists @sup fwnode as supplying a
> > > + * resource to @con.
> > > + *
> > > + * The driver core will use the fwnode link to create a device link between the
> > > + * two device objects corresponding to @con and @sup when they are created. The
> > > + * driver core will automatically delete the fwnode link between @con and @sup
> > > + * after doing that.
> > > + *
> > > + * Attempts to create duplicate links between the same pair of fwnode handles
> > > + * are ignored and there is no reference counting.
> >
> > Sorry to ask, but why is that?
> > Isn't this a programmer error?
>
> No, not a programmer error.
>
> One firmware node can point to the same supplier many times. For
> example, the consumer can be using multiple clocks from the same
> supplier clock controller. In the context of fw_devlink, there's no
> reason to keep track of each clock dependency separately because we'll
> be creating only one device link from fwnode link. So multiple fwnode
> link attempts between the same two devices are just treated as one
> instance of dependency. I hope that clarifies things.

Yes, thanks.

>
> -Saravana
