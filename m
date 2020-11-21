Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADE2BBBC6
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgKUCAt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgKUCAs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:00:48 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651DC061A47
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:47 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s8so10307459yba.13
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2wWUWZqYKnQ8zyB+N3c82zv7RQJgeeS1mhMIBzqBbs=;
        b=Hn9e9Va7VU3kQCVvYW94zaiI0ssP/bahrUDyg+we8Uf5fpBld+4Zb9pVNeSB94QuCR
         ueyC+rhR/83c0G0FHJWCSQT6wubY/9Fh7mnt/yDEuOL1q7j+tq2SkU3q47D5DVsW8fbm
         JIzgYzKyCbTSqr7PAsZWGOgFV52SY0BaoievmbUe0sVrZ+ESavXqBdhdyHx8PiTEA+tD
         howQO/65LTMCkAS/v6MfIJSicSq4gOyzQHiox526RKrP4EYzjCDyB6bdGKZjhtQHYj05
         d2/nO3fNjoDZLIy5qkrlRinpX3f097uRM5QxNVHRsRNdte/0ZGOYSOZvHmwPU3JaH/29
         2iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2wWUWZqYKnQ8zyB+N3c82zv7RQJgeeS1mhMIBzqBbs=;
        b=Z5mJgA9qfgJyP7RBRl5jdD/9/KrIGfScuAdCvugp6vVAwDccXJpVsSR3O9aHXgxzWH
         vBaM1YU0vexPnZoZvNqTPIoF+zJm+P/zCLNZCcBje85Ddlgbuh+SoPWg6XYoDP/SNG+D
         cqbcceJXDuz871+McO4qrErRD/uNe/TCgjiShJn9IWPDrvU2DOgFjw5Lzpj5Ioo/JhXa
         5+fs4lCK3s5Piz7QF6umBzYUgKcYJ5UZAksDHxPX33ReElnABbzatBWqNJYOhU33rYxu
         WC0RSvY5yA5SBnejm96+eXttZAXnsCBukQseEM01Mlr1ye+/YnEOBWS7tDqSr8IFEFDQ
         Tpfg==
X-Gm-Message-State: AOAM5319gr07jL3qhcYZR/h+2cFCSAmBmJ6DThkLe3cW+PbJe31XXHkM
        4kphIDNHcqVTQoxY+55/o7RO5dq9NZ1vbKfV9zWd2A==
X-Google-Smtp-Source: ABdhPJyvwTxSbO8UktNx9w1dInoBL/DB/rklOZuS30YiPBNmF94x5zjdboDH7Drkq+bARi73mxzx9vI1xKTs/rMjwaQ=
X-Received: by 2002:a25:df05:: with SMTP id w5mr36113642ybg.20.1605924046981;
 Fri, 20 Nov 2020 18:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-13-saravanak@google.com> <CAJZ5v0hM9cUeW58OMRRWfAfY+_GYuXy=Dt8bssU+TCufuhukmw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hM9cUeW58OMRRWfAfY+_GYuXy=Dt8bssU+TCufuhukmw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 18:00:11 -0800
Message-ID: <CAGETcx_7b-mUumRTqT7R9zDWANtJnzkPWFyeU1Z6Tw4jK_gdmA@mail.gmail.com>
Subject: Re: [PATCH v1 12/18] driver core: Add fw_devlink_parse_fwtree()
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

On Mon, Nov 16, 2020 at 8:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > This function is a wrapper around fwnode_operations.add_links().
> >
> > This function parses each node in a fwnode tree and create fwnode links
> > for each of those nodes. The information for creating the fwnode links
> > (the supplier and consumer fwnode) is obtained by parsing the properties
> > in each of the fwnodes.
> >
> > This function also ensures that no fwnode is parsed more than once by
> > marking the fwnodes as parsed.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 19 +++++++++++++++++++
> >  include/linux/fwnode.h |  3 +++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4a0907574646..ee28d8c7ee85 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1543,6 +1543,25 @@ static bool fw_devlink_is_permissive(void)
> >         return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
> >  }
> >
> > +static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
> > +{
> > +       if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
> > +               return;
>
> Why is the flag needed?
>
> Duplicate links won't be created anyway and it doesn't cause the tree
> walk to be terminated.

To avoid parsing a fwnode more than once. The cumulative impact of the
repeated parsing is actually quite high.

And I intentionally didn't do this check at the tree walk level
because DT overlay can add/remove/change individual fwnodes and I want
to reparse those when they are added while avoiding parsing other
nodes that have already been parsed and not changed by DT overlay.

>
> > +
> > +       fwnode_call_int_op(fwnode, add_links, NULL);
> > +       fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
> > +}
> > +
> > +static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
> > +{
> > +       struct fwnode_handle *child = NULL;
> > +
> > +       fw_devlink_parse_fwnode(fwnode);
> > +
> > +       while ((child = fwnode_get_next_available_child_node(fwnode, child)))
>
> I'd prefer
>
> for (child = NULL; child; child =
> fwnode_get_next_available_child_node(fwnode, child))

I was about to change to this and then realized it won't work. It
would have to be

for (child = fwnode_get_next_available_child_node(fwnode, NULL));
       child;
       child = fwnode_get_next_available_child_node(fwnode, child))

Is that really better? The while() seems a lot more readable to me. I
don't have a strong opinion, so I'll go with whatever you say after
reading this.

>
> > +               fw_devlink_parse_fwtree(child);
> > +}
> > +
> >  static void fw_devlink_link_device(struct device *dev)
> >  {
> >         int fw_ret;
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index ec02e1e939cc..9aaf9e4f3994 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -15,12 +15,15 @@
> >  struct fwnode_operations;
> >  struct device;
> >
>
> Description here, please.

Ack

>
> > +#define FWNODE_FLAG_LINKS_ADDED                BIT(0)
> > +
> >  struct fwnode_handle {
> >         struct fwnode_handle *secondary;
> >         const struct fwnode_operations *ops;
> >         struct device *dev;
> >         struct list_head suppliers;
> >         struct list_head consumers;
> > +       u32 flags;
>
> That's a bit wasteful.  Maybe u8 would suffice for the time being?

Ack.


-Saravana
