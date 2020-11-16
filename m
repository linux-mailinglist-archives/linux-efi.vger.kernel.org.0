Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1E2B49EF
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgKPPvq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 10:51:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39821 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPPvq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 10:51:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id f11so5565313oij.6;
        Mon, 16 Nov 2020 07:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6BhWVUPlp+sxbhC/biJ0Qbq43f3USshsqWNEHivfAE=;
        b=lICjOeDFzxVHOPB6nVzDwf0Y6n++w7NO/5jOYsU+MJsOgaUlXhqnlunHHhkCC4fDEl
         x1rhZOt1vtT+xnTcX3Jy6yKQvNhE8mM0bA1a0mkgCYjHvhRs5f7vUeG+dasQkZhMcMlS
         8EcK+aBjUkJcMz1MVQceXkmD2y9HlJqRQyMmGD5aX2yJBQ4vWGMrNTGBLBkQaIcQCRyD
         ojlK6c1L7qVHdLbY/kI3HWC3fg7Pr/f8FJfmZ1Wl64gy5y5BcHW8e+t1vPmytuQHTNdt
         I5g373OgcL03ACdfZWUhWXLfy+/D8VFcwtzLtomjFwbAJp/4wZ8ouBrfjxyppX0WVACL
         K7/Q==
X-Gm-Message-State: AOAM531SylM2VL1/8kz2ghRHHbZO9GGT0yukspo65KcSnT4tApB5zVuJ
        KHE6raK18hvS+9bFjklQZ1yXipVsPuCE0/32xWA=
X-Google-Smtp-Source: ABdhPJx7AZgd52Eraq7o5B0azLdJssVRdqorylldk6A9FqX6PvhOXf6BprbvnW3q+S/XElzb1tREm2QZDfKxIar4ZlM=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr43045oig.157.1605541905112;
 Mon, 16 Nov 2020 07:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-9-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-9-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 16:51:34 +0100
Message-ID: <CAJZ5v0iKAzkP1jDo202J117Mb=NipEMiLiV0-C8b4LPLDyUSmw@mail.gmail.com>
Subject: Re: [PATCH v1 08/18] driver core: Add fwnode link support
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
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> This patch adds support for creating supplier-consumer links between

Generally speaking the "This patch" part is redundant.  It is
sufficient to simply say "Add ...".

> fwnode.

fwnodes (plural)?

> It is intentionally kept simple and with limited APIs as it is
> meant to be used only by driver core and firmware code (Eg: device tree,
> ACPI, etc).

I'd say "It is intended for internal use in the driver core and
generic firmware support code (eg. Device Tree, ACPI), so it is simple
by design and the API provided by it is limited."

>
> We can expand the APIs later if there is ever a need for
> drivers/frameworks to start using them.

The above is totally redundant IMO.

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 95 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/dynamic.c   |  1 +
>  include/linux/fwnode.h | 14 +++++++
>  3 files changed, 110 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 31a76159f118..1a1d9a55645c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -50,6 +50,101 @@ static LIST_HEAD(wait_for_suppliers);
>  static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
> +static DEFINE_MUTEX(fwnode_link_lock);
> +
> +/**
> + * fwnode_link_add - Create a link between two fwnode_handles.
> + * @con: Consumer end of the link.
> + * @sup: Supplier end of the link.
> + *
> + * Creates a fwnode link between two fwnode_handles. These fwnode links are

Why don't you refer to the arguments here, that is "Create a link
between fwnode handles @con and @sup ..."

> + * used by the driver core to automatically generate device links. Attempts to
> + * create duplicate links are simply ignored and there is no refcounting.

And I'd generally write it this way:

"Create a link between fwnode handles @con and @sup representing a
pair of devices the first of which uses certain resources provided by
the second one, respectively.

The driver core will use that link to create a device link between the
two device objects corresponding to @con and @sup when they are
created and it will automatically delete the link between @con and
@sup after doing that.

Attempts to create a duplicate link between the same pair of fwnode
handles are ignored and there is no reference counting."

> + *
> + * These links are automatically deleted once they are converted to device
> + * links or when the fwnode_handles (or their corresponding devices) are
> + * deleted.
> + */
> +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)

Why doesn't it return a pointer to the new link or NULL?

That would be consistent with device_link_add().

> +{
> +       struct fwnode_link *link;
> +       int ret = 0;
> +
> +       mutex_lock(&fwnode_link_lock);
> +
> +       /* Duplicate requests are intentionally not refcounted. */

Is this comment really necessary?

> +       list_for_each_entry(link, &sup->consumers, s_hook)
> +               if (link->consumer == con)
> +                       goto out;

It is also necessary to look the other way around AFAICS, that is if
there is a link between the two fwnode handles in the other direction
already, the creation of a new one should fail.

> +
> +       link = kzalloc(sizeof(*link), GFP_KERNEL);
> +       if (!link) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       link->supplier = sup;
> +       INIT_LIST_HEAD(&link->s_hook);
> +       link->consumer = con;
> +       INIT_LIST_HEAD(&link->c_hook);
> +
> +       list_add(&link->s_hook, &sup->consumers);
> +       list_add(&link->c_hook, &con->suppliers);
> +out:
> +       mutex_unlock(&fwnode_link_lock);
> +
> +       return ret;
> +}
> +
> +/**
> + * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
> + * @fwnode: fwnode whose supplier links needs to be deleted

s/needs/need/

> + *
> + * Deletes all supplier links connecting directly to a fwnode.

I'd say "Delete all supplier links connecting directly to @fwnode."
and analogously below.

> + */
> +static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_link *link, *tmp;
> +
> +       mutex_lock(&fwnode_link_lock);
> +       list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
> +               list_del(&link->s_hook);
> +               list_del(&link->c_hook);
> +               kfree(link);
> +       }
> +       mutex_unlock(&fwnode_link_lock);
> +}
> +
> +/**
> + * fwnode_links_purge_consumers - Delete all consumer links of fwnode_handle.
> + * @fwnode: fwnode whose consumer links needs to be deleted
> + *
> + * Deletes all consumer links connecting directly to a fwnode.
> + */
> +static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_link *link, *tmp;
> +
> +       mutex_lock(&fwnode_link_lock);
> +       list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
> +               list_del(&link->s_hook);
> +               list_del(&link->c_hook);
> +               kfree(link);

I'd avoid the code duplication, even though it doesn't appear to be
significant ATM.

> +       }
> +       mutex_unlock(&fwnode_link_lock);
> +}
> +
> +/**
> + * fwnode_links_purge - Delete all links connected to a fwnode_handle.
> + * @fwnode: fwnode whose links needs to be deleted
> + *
> + * Deletes all links connecting directly to a fwnode.
> + */
> +void fwnode_links_purge(struct fwnode_handle *fwnode)
> +{
> +       fwnode_links_purge_suppliers(fwnode);

Dropping the lock here may turn out to be problematic at one point
going forward.  IMO it is better to hold it throughout the entire
operation.

> +       fwnode_links_purge_consumers(fwnode);

I'd get rid of the two functions above, add something like
fwnode_link_del() and walk the lists directly here calling it for
every link on the way.

> +}
>
>  #ifdef CONFIG_SRCU
>  static DEFINE_MUTEX(device_links_lock);
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index fe64430b438a..9a824decf61f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -356,6 +356,7 @@ void of_node_release(struct kobject *kobj)
>
>         property_list_free(node->properties);
>         property_list_free(node->deadprops);
> +       fwnode_links_purge(of_fwnode_handle(node));
>
>         kfree(node->full_name);
>         kfree(node->data);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 593fb8e58f21..afde643f37a2 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -10,6 +10,7 @@
>  #define _LINUX_FWNODE_H_
>
>  #include <linux/types.h>
> +#include <linux/list.h>
>
>  struct fwnode_operations;
>  struct device;
> @@ -18,6 +19,15 @@ struct fwnode_handle {
>         struct fwnode_handle *secondary;
>         const struct fwnode_operations *ops;
>         struct device *dev;
> +       struct list_head suppliers;
> +       struct list_head consumers;
> +};
> +
> +struct fwnode_link {
> +       struct fwnode_handle *supplier;
> +       struct list_head s_hook;
> +       struct fwnode_handle *consumer;
> +       struct list_head c_hook;
>  };
>
>  /**
> @@ -173,8 +183,12 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
>                                const struct fwnode_operations *ops)
>  {
>         fwnode->ops = ops;
> +       INIT_LIST_HEAD(&fwnode->consumers);
> +       INIT_LIST_HEAD(&fwnode->suppliers);
>  }
>
>  extern u32 fw_devlink_get_flags(void);
> +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
> +void fwnode_links_purge(struct fwnode_handle *fwnode);
>
>  #endif
> --
> 2.29.1.341.ge80a0c044ae-goog
>
