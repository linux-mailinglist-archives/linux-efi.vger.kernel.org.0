Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641352BBBD0
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKUCBU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgKUCBU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:01:20 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E975AC0613CF
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:01:19 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id l14so10370110ybq.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lptBBbGushlHJUmT2AIfJv9BrkLAXhn95EN3DEBkcQw=;
        b=kPJh46MIin1X5MmomtGmy+IMegd1fnFrRN5XCBU0BDeFY/SPYlUaHWi2XwcDhT8zpH
         llJb0JTUYtli9u94w48Nt/YENr3SUlo3KoMOOezh2njap0ClbfsHpIJZwSGYeY5lUegd
         K/6UvEMs3rCivA+uscms3XDbhVJzYlUPLwXdky9RO/Q3oL/IbcDhdhNN7NrDxRf6C2Ar
         t5f0tY/S4VosrrEn5PqrH/JLQntmambrJ1huRNGnAzroEDAf7rzsbyS65Pg5QH5AdaPX
         HjLiChlxtcBtXIDF+rm14mSpZozeinDkEqIpzhD1viKtwqrTe0HDrNLe/9CHIcvjJiuE
         2Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lptBBbGushlHJUmT2AIfJv9BrkLAXhn95EN3DEBkcQw=;
        b=mKtUOVcTETNFWMQsjAStbjTv4jJ+DhvoZczWchVA4sh9tQ0eS7epBSfbzDYj8o5jbu
         CYrZYD56imlaEvfEUncLID16bzZ5bVdcTY1BRolT1IO2cMBKmkTfJLFw8L7zLSsqrxVK
         w0/2RLZkAi5RzAdDlEWtNlG7iZyz9KVGq+fWNZtlvaXqzgRY5zdqNhte7+TQ6K1QlDlJ
         +5v/dNTdyOzG5/v3xKls5MiMjarhkMN7NQ7IouM23ucqVgZcOwU/iDFXq/AacAAMuvri
         Sr/wIUcLFGSUsCGslQK0+KZtHFbpW+QEGew1YJcS6/5aQvdmfp1UOW+WZoHw0IVTir96
         7Faw==
X-Gm-Message-State: AOAM532eNE/l5d8L0/+MSOA2I6HEplqLYinInICcwNv8E9EdAGI6b5PS
        PdCSQrHplwQ774fnhWF11ppwIa1B+D5dThBSAxAdjw==
X-Google-Smtp-Source: ABdhPJwL+RWOtK1NK29JcTWnyDUn955B8Vc2hZVf1e8KN5TtA1N4vftbkBqKUHcWaybv95OBkNNlmFjIuyCz4UCouZk=
X-Received: by 2002:a25:c483:: with SMTP id u125mr23456504ybf.310.1605924079027;
 Fri, 20 Nov 2020 18:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-18-saravanak@google.com> <CAJZ5v0gALooTYTLr9JOynHTT=Bqvzp1iTdpQ+SfQn+2u__w-0w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gALooTYTLr9JOynHTT=Bqvzp1iTdpQ+SfQn+2u__w-0w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 18:00:43 -0800
Message-ID: <CAGETcx-nbUVm5LL9n0Ee=p6GV-b0r048S56zWJ6e_Fd421krjA@mail.gmail.com>
Subject: Re: [PATCH v1 17/18] driver core: Add helper functions to convert
 fwnode links to device links
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 16, 2020 at 8:57 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add helper functions __fw_devlink_link_to_consumers() and
> > __fw_devlink_link_to_suppliers() that convert fwnode links to device
> > links.
> >
> > __fw_devlink_link_to_consumers() is for creating:
> > - Device links between a newly added device and all its consumer devices
> >   that have been added to driver core.
> > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> >   the parent devices of all its consumers that have not been added to
> >   driver core yet.
> >
> > __fw_devlink_link_to_suppliers() is for creating:
> > - Device links between a newly added device and all its supplier devices
> > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> >   all the supplier devices of its child device nodes.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 228 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 228 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d51dd564add1..0c87ff949d81 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1585,6 +1585,234 @@ static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
> >         return dev;
> >  }
> >
> > +/**
> > + * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
>
> Have you considered renaming "fw_devlink" to "fwnode_link"?

I avoided using fwnode_link prefix because it's not related to the
fwnode link APIs. This is a fw_devlink feature related code and hence
the fw_devlink prefix.

I could just call it fw_devlink_create() or fw_devlink_create_links()
or fwnode_to_dev_link() if that's less confusing. Any preferences?

> That would be much less confusing IMO and the name of this function
> would be clearer.
>
> > + * @con - Consumer device for the device link
> > + * @sup - fwnode handle of supplier
> > + *
> > + * This function will try to create a device link between the consumer and the
> > + * supplier devices.
>
> "... between consumer device @con and the supplier device represented
> by @sup" (and see below).
>
> > + *
> > + * The supplier has to be provided as a fwnode because incorrect cycles in
> > + * fwnode links can sometimes cause the supplier device to never be created.
> > + * This function detects such cases and returns an error if a device link being
> > + * created in invalid.
>
> "... returns an error if it cannot create a device link from the
> consumer to a missing supplier."
>
> > + *
> > + * Returns,
> > + * 0 on successfully creating a device link
> > + * -EINVAL if the device link being attempted is invalid
>
> "if the device link cannot be created as expected"
>
> > + * -EAGAIN if the device link needs to be attempted again in the future
>
> "if the device link cannot be created right now, but it may be
> possible to do that in the future."

Ack to all the documentation comments above.

>
> > + */
> > +static int fw_devlink_create_devlink(struct device *con,
> > +                                    struct fwnode_handle *sup, u32 flags)
>
> I'd call the second arg sup_handle to indicate that it is not a struct device.

Ack

>
> > +{
> > +       struct device *sup_dev, *sup_par_dev;
> > +       int ret = 0;
> > +
> > +       sup_dev = get_dev_from_fwnode(sup);
> > +       /*
> > +        * If we can't find the supplier device from its fwnode, it might be
> > +        * due to a cyclic dependcy between fwnodes. Some of these cycles can
>
> dependency
>

Ack

> > +        * be broken by applying logic. Check for these types of cycles and
> > +        * break them so that devices in the cycle probe properly.
> > +        */
>
> I would do
>
> if (sup_dev) {
>         if (!device_link_add(con, sup_dev, flags))
>                 ret = -EINVAL;
>
>         put_device(sup_dev);
>         return ret;
> }
>
> here and the cycle detection (error code path) below, possibly using
> the same dev pointer.

Nice suggestion, thanks!


-Saravana
