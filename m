Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420952BBBB6
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKUCAK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKUCAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:00:10 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FCC061A04
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:10 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o71so10353125ybc.2
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RL33UOTlemNQ/vQ4qwl9EYK4T3gfkWAqCMJ5EwZ1yTY=;
        b=Sbi44ROn89jSK8XlzyBlrwwURpgLSbihh/F0n6JsqZvGBlqw8IlZCselUourV3uXVt
         sHszvmbbyueaU/ivacebDR45mAotQWucVjP35+UeQ5knBZzj+kbAoXy9Y40GhptM8yTX
         L5dJVeNDGmeBKTtwvDQm3mVk4OuvRfDRRM4r3FEba8eXqohYh6s+q4YSdeoUNguCc7H6
         N+Plww5vrPEmhZ5kz8jNVcyYESpsTm9PViVuLxVmpdW4HkFSpwHh0YyoEKuK6c2WlYc+
         H89NqB5aN6hD1i1yoLuT2uMtvyCZGBh5FVwwRbCeDG0iKOlVL0G8E2/fhrvD/FSasPjH
         jIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RL33UOTlemNQ/vQ4qwl9EYK4T3gfkWAqCMJ5EwZ1yTY=;
        b=TtmOcabCVvXP896gw/gCXVTqvfe+qUPGRoVSGoReIWfgTW7LnpuIlWa7hU6JbhRySP
         vV4tXNgaL3wduMaXFLdFIc8689PcWYE5kRX2/gRdpyxzfKxoLvC72t2UNnct5gw1bM2/
         sm0vNjE3fP9/ac+LVUAEcrtZIzSIof2td2JXNz2Z6RfDI2ZIUrx2t1lCvgXZHlN8ToCL
         l56kj3B5R6r2tWHn8tEMTwZwZG0yNuK5JuXn0M4IqMXXHC2uqbitCEEtq/vx6RV/nRJV
         Wum2ynfcqn6ggLobBjh8rugHUi8uuLRo8klSeEFaubWEWJu4XeqAcCubOdQV+qUZPt7Z
         jFzg==
X-Gm-Message-State: AOAM533xwx0p5Kp5JUfl33iVlWPQTkXh9C9MYWf3D1tjEzifbDdKBw4U
        yYiyOBoKLe/GxbuRkWLQTRYcvRliQTt0MlOWo16qrA==
X-Google-Smtp-Source: ABdhPJycFco7NhhJCzLELdACWMic5hnonHza8FX12/J6/oDiCBN0OtjIXt6xR1BOMfz82Hk1vNgpXPQaTkdvtWCLCeo=
X-Received: by 2002:a25:b090:: with SMTP id f16mr25880254ybj.466.1605924008934;
 Fri, 20 Nov 2020 18:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-9-saravanak@google.com> <CAJZ5v0iKAzkP1jDo202J117Mb=NipEMiLiV0-C8b4LPLDyUSmw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKAzkP1jDo202J117Mb=NipEMiLiV0-C8b4LPLDyUSmw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 17:59:32 -0800
Message-ID: <CAGETcx9-Vt5pWxoaBRwisCv4ZTUrCBp+jX3eVU7bh=cvNqqe_A@mail.gmail.com>
Subject: Re: [PATCH v1 08/18] driver core: Add fwnode link support
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

On Mon, Nov 16, 2020 at 7:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > This patch adds support for creating supplier-consumer links between
>
> Generally speaking the "This patch" part is redundant.  It is
> sufficient to simply say "Add ...".
>
> > fwnode.
>
> fwnodes (plural)?
>
> > It is intentionally kept simple and with limited APIs as it is
> > meant to be used only by driver core and firmware code (Eg: device tree,
> > ACPI, etc).
>
> I'd say "It is intended for internal use in the driver core and
> generic firmware support code (eg. Device Tree, ACPI), so it is simple
> by design and the API provided by it is limited."
>
> >
> > We can expand the APIs later if there is ever a need for
> > drivers/frameworks to start using them.
>
> The above is totally redundant IMO.
>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 95 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/dynamic.c   |  1 +
> >  include/linux/fwnode.h | 14 +++++++
> >  3 files changed, 110 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 31a76159f118..1a1d9a55645c 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -50,6 +50,101 @@ static LIST_HEAD(wait_for_suppliers);
> >  static DEFINE_MUTEX(wfs_lock);
> >  static LIST_HEAD(deferred_sync);
> >  static unsigned int defer_sync_state_count = 1;
> > +static DEFINE_MUTEX(fwnode_link_lock);
> > +
> > +/**
> > + * fwnode_link_add - Create a link between two fwnode_handles.
> > + * @con: Consumer end of the link.
> > + * @sup: Supplier end of the link.
> > + *
> > + * Creates a fwnode link between two fwnode_handles. These fwnode links are
>
> Why don't you refer to the arguments here, that is "Create a link
> between fwnode handles @con and @sup ..."

Ack/done to everything above.

>
> > + * used by the driver core to automatically generate device links. Attempts to
> > + * create duplicate links are simply ignored and there is no refcounting.
>
> And I'd generally write it this way:
>
> "Create a link between fwnode handles @con and @sup representing a
> pair of devices the first of which uses certain resources provided by
> the second one, respectively.
>
> The driver core will use that link to create a device link between the
> two device objects corresponding to @con and @sup when they are
> created and it will automatically delete the link between @con and
> @sup after doing that.
>
> Attempts to create a duplicate link between the same pair of fwnode
> handles are ignored and there is no reference counting."

Took most of this as is with some minor rewording.

>
> > + *
> > + * These links are automatically deleted once they are converted to device
> > + * links or when the fwnode_handles (or their corresponding devices) are
> > + * deleted.
> > + */
> > +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
>
> Why doesn't it return a pointer to the new link or NULL?
>
> That would be consistent with device_link_add().

However, as opposed to device_link_add(), I don't want the caller
holding any reference to the allocated link. So I don't want to return
any pointer to them.

> > +{
> > +       struct fwnode_link *link;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&fwnode_link_lock);
> > +
> > +       /* Duplicate requests are intentionally not refcounted. */
>
> Is this comment really necessary?

I guess with the function comment explicitly stating "no ref
counting", this is kind of redundant. I can remove this.

>
> > +       list_for_each_entry(link, &sup->consumers, s_hook)
> > +               if (link->consumer == con)
> > +                       goto out;
>
> It is also necessary to look the other way around AFAICS, that is if
> there is a link between the two fwnode handles in the other direction
> already, the creation of a new one should fail.

No, fwnode links can have cycles. At this state, we can't tell which
ones are invali.d When we create device links out of this, we have
more info at that point and we make sure not to add any device links
that can cause cycles. There are a bunch of corner cases where we
can't tell which one is the invalid fwnode link in the links that make
up the cycle and in those cases, we have to make the device links as
SYNC_STATE_ONLY device links. Long story short, cycles are allowed.

>
> > +
> > +       link = kzalloc(sizeof(*link), GFP_KERNEL);
> > +       if (!link) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       link->supplier = sup;
> > +       INIT_LIST_HEAD(&link->s_hook);
> > +       link->consumer = con;
> > +       INIT_LIST_HEAD(&link->c_hook);
> > +
> > +       list_add(&link->s_hook, &sup->consumers);
> > +       list_add(&link->c_hook, &con->suppliers);
> > +out:
> > +       mutex_unlock(&fwnode_link_lock);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
> > + * @fwnode: fwnode whose supplier links needs to be deleted
>
> s/needs/need/

Ack

>
> > + *
> > + * Deletes all supplier links connecting directly to a fwnode.
>
> I'd say "Delete all supplier links connecting directly to @fwnode."
> and analogously below.

Ack

>
> > + */
> > +static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
> > +{
> > +       struct fwnode_link *link, *tmp;
> > +
> > +       mutex_lock(&fwnode_link_lock);
> > +       list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
> > +               list_del(&link->s_hook);
> > +               list_del(&link->c_hook);
> > +               kfree(link);
> > +       }
> > +       mutex_unlock(&fwnode_link_lock);
> > +}
> > +
> > +/**
> > + * fwnode_links_purge_consumers - Delete all consumer links of fwnode_handle.
> > + * @fwnode: fwnode whose consumer links needs to be deleted
> > + *
> > + * Deletes all consumer links connecting directly to a fwnode.
> > + */
> > +static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
> > +{
> > +       struct fwnode_link *link, *tmp;
> > +
> > +       mutex_lock(&fwnode_link_lock);
> > +       list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
> > +               list_del(&link->s_hook);
> > +               list_del(&link->c_hook);
> > +               kfree(link);
>
> I'd avoid the code duplication, even though it doesn't appear to be
> significant ATM.

I'd like to leave this as is for now if that's okay.

> > +       }
> > +       mutex_unlock(&fwnode_link_lock);
> > +}
> > +
> > +/**
> > + * fwnode_links_purge - Delete all links connected to a fwnode_handle.
> > + * @fwnode: fwnode whose links needs to be deleted
> > + *
> > + * Deletes all links connecting directly to a fwnode.
> > + */
> > +void fwnode_links_purge(struct fwnode_handle *fwnode)
> > +{
> > +       fwnode_links_purge_suppliers(fwnode);
>
> Dropping the lock here may turn out to be problematic at one point
> going forward.  IMO it is better to hold it throughout the entire
> operation.

It's not really a problem as there's nothing that can happen in
between these two calls that can cause a problem but won't be a
problem if it happens after these two calls. I was trying to avoid
repeating the purge supplier/consumer code here again. Can we leave
this as is for now?

>
> > +       fwnode_links_purge_consumers(fwnode);
>
> I'd get rid of the two functions above, add something like
> fwnode_link_del() and walk the lists directly here calling it for
> every link on the way.

I need a fwnode_links_purge_suppliers() (as in, not purging consumer
links) though. I used it later in the series. So instead of repeating
that code for fwnode_links_purge(), I created
fwnode_links_purge_consumers() and called both functions from here.
Can we leave this as is?

-Saravana

>
> > +}
> >
> >  #ifdef CONFIG_SRCU
> >  static DEFINE_MUTEX(device_links_lock);
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index fe64430b438a..9a824decf61f 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -356,6 +356,7 @@ void of_node_release(struct kobject *kobj)
> >
> >         property_list_free(node->properties);
> >         property_list_free(node->deadprops);
> > +       fwnode_links_purge(of_fwnode_handle(node));
> >
> >         kfree(node->full_name);
> >         kfree(node->data);
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 593fb8e58f21..afde643f37a2 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -10,6 +10,7 @@
> >  #define _LINUX_FWNODE_H_
> >
> >  #include <linux/types.h>
> > +#include <linux/list.h>
> >
> >  struct fwnode_operations;
> >  struct device;
> > @@ -18,6 +19,15 @@ struct fwnode_handle {
> >         struct fwnode_handle *secondary;
> >         const struct fwnode_operations *ops;
> >         struct device *dev;
> > +       struct list_head suppliers;
> > +       struct list_head consumers;
> > +};
> > +
> > +struct fwnode_link {
> > +       struct fwnode_handle *supplier;
> > +       struct list_head s_hook;
> > +       struct fwnode_handle *consumer;
> > +       struct list_head c_hook;
> >  };
> >
> >  /**
> > @@ -173,8 +183,12 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
> >                                const struct fwnode_operations *ops)
> >  {
> >         fwnode->ops = ops;
> > +       INIT_LIST_HEAD(&fwnode->consumers);
> > +       INIT_LIST_HEAD(&fwnode->suppliers);
> >  }
> >
> >  extern u32 fw_devlink_get_flags(void);
> > +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
> > +void fwnode_links_purge(struct fwnode_handle *fwnode);
> >
> >  #endif
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
