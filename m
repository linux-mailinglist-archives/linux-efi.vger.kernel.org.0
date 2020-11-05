Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB372A8A9B
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 00:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKEXUy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 18:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgKEXUx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Nov 2020 18:20:53 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A2C0613CF
        for <linux-efi@vger.kernel.org>; Thu,  5 Nov 2020 15:20:53 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o70so2863969ybc.1
        for <linux-efi@vger.kernel.org>; Thu, 05 Nov 2020 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wFZyYqtSK1R4m/q7QRLFzt9lunj5huoU2docdk+JL4=;
        b=VQr5C/I+TFiFZ5SGKU1BeWphObfdjJTDj5xi0jFRSsliyimc1RaZmy7UsImMxmeFwx
         /h64JqNojRtsW8BCZc5+H+0Lkvcfr+JQiygd+PXcKPeHs07sxkiiMwMJ6ofbAHcgLlui
         eQO9PSZ4XzjFSiEPmAHbJ6IP8032bP54RzqZQzoyw4KK+2fBBP6/qiemKmzS9lXEe48G
         98wXlcIhrJ2gawyLq7TEOaqZxP4IwKgwzodTpxxlY3vQbdEJsZ3ZhemZ1Cwq8J1cxUPI
         fvBIp8I6iZo5winR1KYZJN/o0I79n+h1fVGga1PX3HmfvT8Xj6x9RquXOd1wwzSazJ1I
         32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wFZyYqtSK1R4m/q7QRLFzt9lunj5huoU2docdk+JL4=;
        b=JJBKxgBZnBgF3YkWsM/WEdhgRUx+akuqNzPK2FZV/AehGBvFDxVl3nH0xywcYYS9nQ
         fvLSekRUA/CzqEHKdRpM6jSpvHHD7yQ4A+92YZfyJH9AWbmC8aSu5jzSYCgUJYhAWxN1
         WGF3pTUyTye+skPCfeskEAuZ+cIAXUY6iHeY2iS0gHZnZeKFC5y3D26QclOXdKSW/WOI
         D1ii8WofsESTv2zKgPAbBJjb0GGOA/kq/QKceIGJtm5iS6SXSEJ7n20VaLJPiss/Tm5y
         wp2qckMQ4z1+O0yXljbC8FHfKd31PGogP48f/2IpUoxArVM2Y4IRujaBztvHv+J23ni6
         hsTg==
X-Gm-Message-State: AOAM530xbhYz22vsm5yXctpEKYUc2bNaQjJnis/eQq7r0Dw5o+ytYR7U
        5d2mMpI47zmxhUFxVC3fBzF+kdifE8eDB9TBQnRhNg==
X-Google-Smtp-Source: ABdhPJwI8PTuLr/THqyxcoxyPhiBcXvDcwi5nHO4ERWE9lM50eQ300SCgVr+U1Wi7ljrzOM7oFCREm+TDa0BnbK69Y4=
X-Received: by 2002:a25:268e:: with SMTP id m136mr6904500ybm.346.1604618452430;
 Thu, 05 Nov 2020 15:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-8-saravanak@google.com> <20201105093604.GD3439341@kroah.com>
In-Reply-To: <20201105093604.GD3439341@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 15:20:16 -0800
Message-ID: <CAGETcx-ShEUaFzL_1oExk8KeVn+cnXLnYSz7vKxphHbnGERrhQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/18] driver core: Add fwnode_init()
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

On Thu, Nov 5, 2020 at 1:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:23:44PM -0800, Saravana Kannan wrote:
> > There are multiple locations in the kernel where a struct fwnode_handle
> > is initialized. Add fwnode_init() so that we have one way of
> > initializing a fwnode_handle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/acpi/property.c         | 2 +-
> >  drivers/acpi/scan.c             | 2 +-
> >  drivers/base/swnode.c           | 2 +-
> >  drivers/firmware/efi/efi-init.c | 8 ++++----
> >  include/linux/fwnode.h          | 5 +++++
> >  include/linux/of.h              | 2 +-
> >  kernel/irq/irqdomain.c          | 2 +-
> >  7 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index d04de10a63e4..24e87b630573 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -76,7 +76,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
> >               return false;
> >
> >       dn->name = link->package.elements[0].string.pointer;
> > -     dn->fwnode.ops = &acpi_data_fwnode_ops;
> > +     fwnode_init(&dn->fwnode, &acpi_data_fwnode_ops);
> >       dn->parent = parent;
> >       INIT_LIST_HEAD(&dn->data.properties);
> >       INIT_LIST_HEAD(&dn->data.subnodes);
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index a896e5e87c93..0ac19f9274b8 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1589,7 +1589,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
> >       device->device_type = type;
> >       device->handle = handle;
> >       device->parent = acpi_bus_get_parent(handle);
> > -     device->fwnode.ops = &acpi_device_fwnode_ops;
> > +     fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
> >       acpi_set_device_status(device, sta);
> >       acpi_device_get_busid(device);
> >       acpi_set_pnp_ids(handle, &device->pnp, type);
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 010828fc785b..4a4b2008fbc2 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -653,7 +653,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
> >       swnode->parent = parent;
> >       swnode->allocated = allocated;
> >       swnode->kobj.kset = swnode_kset;
> > -     swnode->fwnode.ops = &software_node_ops;
> > +     fwnode_init(&swnode->fwnode, &software_node_ops);
> >
> >       ida_init(&swnode->child_ids);
> >       INIT_LIST_HEAD(&swnode->entry);
> > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> > index f55a92ff12c0..b148f1459fb3 100644
> > --- a/drivers/firmware/efi/efi-init.c
> > +++ b/drivers/firmware/efi/efi-init.c
> > @@ -359,9 +359,7 @@ static const struct fwnode_operations efifb_fwnode_ops = {
> >       .add_links = efifb_add_links,
> >  };
> >
> > -static struct fwnode_handle efifb_fwnode = {
> > -     .ops = &efifb_fwnode_ops,
> > -};
> > +static struct fwnode_handle efifb_fwnode;
> >
> >  static int __init register_gop_device(void)
> >  {
> > @@ -375,8 +373,10 @@ static int __init register_gop_device(void)
> >       if (!pd)
> >               return -ENOMEM;
> >
> > -     if (IS_ENABLED(CONFIG_PCI))
> > +     if (IS_ENABLED(CONFIG_PCI)) {
> > +             fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
> >               pd->dev.fwnode = &efifb_fwnode;
> > +     }
> >
> >       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> >       if (err)
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index e0abafbb17f8..593fb8e58f21 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -169,6 +169,11 @@ struct fwnode_operations {
> >                       (fwnode)->ops->op(fwnode, ## __VA_ARGS__);      \
> >       } while (false)
> >  #define get_dev_from_fwnode(fwnode)  get_device((fwnode)->dev)
> > +static inline void fwnode_init(struct fwnode_handle *fwnode,
> > +                            const struct fwnode_operations *ops)
> > +{
> > +     fwnode->ops = ops;
> > +}
> >
>
> A blank line before a new inline function is always nice to have :)
>

Ack

-Saravana
