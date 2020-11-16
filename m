Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC12B4BDA
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgKPQ56 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 11:57:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45415 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbgKPQ56 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 11:57:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id k3so16627219otp.12;
        Mon, 16 Nov 2020 08:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmtwyIbPmAPFs/gTz0w7XLIu0QzTRgivfbqX2mV6WSg=;
        b=YoeR5r7wx46nBnVd3P6g4PaJ702Mw42Z7ztSOwz+Y6mV8q6uUMV6kTBcdgIkJC9jUX
         DWyTMstyq9d5jbm8KlaGo3q3/qkaEwLEn8JUxdQ1mH0VD/Zxw86UlNgVIVdzM9s4Z5DH
         idiRHu/aLKJp9JzJHIo0uokft2Cude7vi11tacWC0EPckfiyxLAojto4qSSQKpY020kW
         b1bA7slfqBp8H6/P7cULW/udSCIRQLMBOxgSzm2g2JcNu+6VquD96w3rj62zXcC7hW9x
         Po2dPzgpeaXDrHRGNHSNvhzkACBd5CZS8di/IYYHtxPnpJfNgjV8fs1nGn4pMMxUGXPw
         Hlzg==
X-Gm-Message-State: AOAM530//XY7yg4WMlPF+tKkwe1c4vV9AeqXlYgtJpw30uq7SJZ104xa
        o82lcq2Nw+P9gHzRkMHn6KzmelNzm3RfFP+8/cWaRBXyOME=
X-Google-Smtp-Source: ABdhPJwzUipjfGFxVCrhvhtd3iWbpG5HY2UufOmg4YHucTU4fyui3Q0NiJjfauMdUE2y7HszNgi/GgQE+5gzMaBW5yQ=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr124071ota.321.1605545876901;
 Mon, 16 Nov 2020 08:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-18-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-18-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:57:45 +0100
Message-ID: <CAJZ5v0gALooTYTLr9JOynHTT=Bqvzp1iTdpQ+SfQn+2u__w-0w@mail.gmail.com>
Subject: Re: [PATCH v1 17/18] driver core: Add helper functions to convert
 fwnode links to device links
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
> Add helper functions __fw_devlink_link_to_consumers() and
> __fw_devlink_link_to_suppliers() that convert fwnode links to device
> links.
>
> __fw_devlink_link_to_consumers() is for creating:
> - Device links between a newly added device and all its consumer devices
>   that have been added to driver core.
> - Proxy SYNC_STATE_ONLY device links between the newly added device and
>   the parent devices of all its consumers that have not been added to
>   driver core yet.
>
> __fw_devlink_link_to_suppliers() is for creating:
> - Device links between a newly added device and all its supplier devices
> - Proxy SYNC_STATE_ONLY device links between the newly added device and
>   all the supplier devices of its child device nodes.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 228 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 228 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d51dd564add1..0c87ff949d81 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1585,6 +1585,234 @@ static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>         return dev;
>  }
>
> +/**
> + * fw_devlink_create_devlink - Create a device link from a consumer to fwnode

Have you considered renaming "fw_devlink" to "fwnode_link"?

That would be much less confusing IMO and the name of this function
would be clearer.

> + * @con - Consumer device for the device link
> + * @sup - fwnode handle of supplier
> + *
> + * This function will try to create a device link between the consumer and the
> + * supplier devices.

"... between consumer device @con and the supplier device represented
by @sup" (and see below).

> + *
> + * The supplier has to be provided as a fwnode because incorrect cycles in
> + * fwnode links can sometimes cause the supplier device to never be created.
> + * This function detects such cases and returns an error if a device link being
> + * created in invalid.

"... returns an error if it cannot create a device link from the
consumer to a missing supplier."

> + *
> + * Returns,
> + * 0 on successfully creating a device link
> + * -EINVAL if the device link being attempted is invalid

"if the device link cannot be created as expected"

> + * -EAGAIN if the device link needs to be attempted again in the future

"if the device link cannot be created right now, but it may be
possible to do that in the future."

> + */
> +static int fw_devlink_create_devlink(struct device *con,
> +                                    struct fwnode_handle *sup, u32 flags)

I'd call the second arg sup_handle to indicate that it is not a struct device.

> +{
> +       struct device *sup_dev, *sup_par_dev;
> +       int ret = 0;
> +
> +       sup_dev = get_dev_from_fwnode(sup);
> +       /*
> +        * If we can't find the supplier device from its fwnode, it might be
> +        * due to a cyclic dependcy between fwnodes. Some of these cycles can

dependency

> +        * be broken by applying logic. Check for these types of cycles and
> +        * break them so that devices in the cycle probe properly.
> +        */

I would do

if (sup_dev) {
        if (!device_link_add(con, sup_dev, flags))
                ret = -EINVAL;

        put_device(sup_dev);
        return ret;
}

here and the cycle detection (error code path) below, possibly using
the same dev pointer.

> +       if (!sup_dev) {
> +               /*
> +                * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
> +                * cycles. So cycle detection isn't necessary and shouldn't be
> +                * done.
> +                */
> +               if (flags & DL_FLAG_SYNC_STATE_ONLY)
> +                       return -EAGAIN;
> +
> +               sup_par_dev = fwnode_get_next_parent_dev(sup);
> +
> +               /*
> +                * If the supplier's parent is dependent on the consumer, then
> +                * the consumer-supplier dependency is a false dependency. So,
> +                * treat it as an invalid link.
> +                */
> +               if (sup_par_dev && device_is_dependent(con, sup_par_dev)) {
> +                       dev_dbg(con, "Not linking to %pfwP - False link\n",
> +                               sup);
> +                       ret = -EINVAL;
> +               } else {
> +                       /*
> +                        * Can't check for cycles or no cycles. So let's try
> +                        * again later.
> +                        */
> +                       ret = -EAGAIN;
> +               }
> +
> +               put_device(sup_par_dev);
> +               return ret;
> +       }
> +
> +       /*
> +        * If we get this far and fail, this is due to cycles in device links.
> +        * Just give up on this link and treat it as invalid.
> +        */
> +       if (!device_link_add(con, sup_dev, flags))
> +               ret = -EINVAL;
> +       put_device(sup_dev);
> +
> +       return ret;
> +}
> +
> +/**
> + * __fw_devlink_link_to_consumers - Create device links to consumers of a device
> + * @dev - Device that needs to be linked to its consumers
> + *
> + * This function looks at all the consumer fwnodes of @dev and creates device
> + * links between the consumer device and @dev (supplier).
> + *
> + * If the consumer device has not been added yet, then this function creates a
> + * SYNC_STATE_ONLY link between @dev (supplier) and the closest ancestor device
> + * of the consumer fwnode. This is necessary to make sure @dev doesn't get a
> + * sync_state() callback before the real consumer device gets to be added and
> + * then probed.
> + *
> + * Once device links are created from the real consumer to @dev (supplier), the
> + * fwnode links are deleted.
> + */
> +static void __fw_devlink_link_to_consumers(struct device *dev)
> +{
> +       struct fwnode_handle *fwnode = dev->fwnode;
> +       struct fwnode_link *link, *tmp;
> +
> +       list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
> +               u32 dl_flags = fw_devlink_get_flags();
> +               struct device *con_dev;
> +               bool own_link = true;
> +               int ret;
> +
> +               con_dev = get_dev_from_fwnode(link->consumer);
> +               /*
> +                * If consumer device is not available yet, make a "proxy"
> +                * SYNC_STATE_ONLY link from the consumer's parent device to
> +                * the supplier device. This is necessary to make sure the
> +                * supplier doesn't get a sync_state() callback before the real
> +                * consumer can create a device link to the supplier.
> +                *
> +                * This proxy link step is needed to handle the case where the
> +                * consumer's parent device is added before the supplier.
> +                */
> +               if (!con_dev) {
> +                       con_dev = fwnode_get_next_parent_dev(link->consumer);
> +                       /*
> +                        * However, if the consumer's parent device is also the
> +                        * parent of the supplier, don't create a
> +                        * consumer-supplier link from the parent to its child
> +                        * device. Such a dependency is impossible.
> +                        */
> +                       if (con_dev &&
> +                           fwnode_is_ancestor_of(con_dev->fwnode, fwnode)) {
> +                               put_device(con_dev);
> +                               con_dev = NULL;
> +                       } else {
> +                               own_link = false;
> +                               dl_flags = DL_FLAG_SYNC_STATE_ONLY;
> +                       }
> +               }
> +
> +               if (!con_dev)
> +                       continue;
> +
> +               ret = fw_devlink_create_devlink(con_dev, fwnode, dl_flags);
> +               put_device(con_dev);
> +               if (!own_link || ret == -EAGAIN)
> +                       continue;
> +
> +               list_del(&link->s_hook);
> +               list_del(&link->c_hook);
> +               kfree(link);
> +       }
> +}
> +
> +/**
> + * __fw_devlink_link_to_suppliers - Create device links to suppliers of a device
> + * @dev - The consumer device that needs to be linked to its suppliers
> + * @fwnode - Root of the fwnode tree that is used to create device links
> + *
> + * This function looks at all the supplier fwnodes of fwnode tree rooted at
> + * @fwnode and creates device links between @dev (consumer) and all the
> + * supplier devices of the entire fwnode tree at @fwnode. See
> + * fw_devlink_create_devlink() for more details.
> + *
> + * The function creates normal (non-SYNC_STATE_ONLY) device links between @dev
> + * and the real suppliers of @dev. Once these device links are created, the
> + * fwnode links are deleted. When such device links are successfully created,
> + * this function is called recursively on those supplier devices. This is
> + * needed to detect and break some invalid cycles in fwnode links.
> + *
> + * In addition, it also looks at all the suppliers of the entire fwnode tree
> + * because some of the child devices of @dev that have not been added yet
> + * (because @dev hasn't probed) might already have their suppliers added to
> + * driver core. So, this function creates SYNC_STATE_ONLY device links between
> + * @dev (consumer) and these suppliers to make sure they don't execute their
> + * sync_state() callbacks before these child devices have a chance to create
> + * their device links. The fwnode links that correspond to the child devices
> + * aren't delete because they are needed later to create the device links
> + * between the real consumer and supplier devices.
> + */
> +static void __fw_devlink_link_to_suppliers(struct device *dev,
> +                                          struct fwnode_handle *fwnode)
> +{
> +       bool own_link = (dev->fwnode == fwnode);
> +       struct fwnode_link *link, *tmp;
> +       struct fwnode_handle *child = NULL;
> +       u32 dl_flags;
> +
> +       if (own_link)
> +               dl_flags = fw_devlink_get_flags();
> +       else
> +               dl_flags = DL_FLAG_SYNC_STATE_ONLY;
> +
> +       list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
> +               int ret;
> +               struct device *sup_dev;
> +               struct fwnode_handle *sup = link->supplier;
> +
> +               ret = fw_devlink_create_devlink(dev, sup, dl_flags);
> +               if (!own_link || ret == -EAGAIN)
> +                       continue;
> +
> +               list_del(&link->s_hook);
> +               list_del(&link->c_hook);
> +               kfree(link);
> +
> +               /* If no device link was created, nothing more to do. */
> +               if (ret)
> +                       continue;
> +
> +               /*
> +                * If a device link was successfully created to a supplier, we
> +                * now need to try and link the supplier to all its suppliers.
> +                *
> +                * This is needed to detect and delete false dependencies in
> +                * fwnode links that haven't been converted to a device link
> +                * yet. See comments in fw_devlink_create_devlink() for more
> +                * details on the false dependency.
> +                *
> +                * Without deleting these false dependencies, some devices will
> +                * never probe because they'll keep waiting for their false
> +                * dependency fwnode links to be converted to device links.
> +                */
> +               sup_dev = get_dev_from_fwnode(sup);
> +               __fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
> +               put_device(sup_dev);
> +       }
> +
> +       /*
> +        * Make "proxy" SYNC_STATE_ONLY device links to represent the needs of
> +        * all the descendants. This proxy link step is needed to handle the
> +        * case where the supplier is added before the consumer's parent device
> +        * (@dev).
> +        */
> +       while ((child = fwnode_get_next_available_child_node(fwnode, child)))
> +               __fw_devlink_link_to_suppliers(dev, child);
> +}
> +
>  static void fw_devlink_link_device(struct device *dev)
>  {
>         int fw_ret;
> --
> 2.29.1.341.ge80a0c044ae-goog
>
