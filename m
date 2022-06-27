Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A3555C71F
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbiF0WbJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiF0WbE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 18:31:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552A1EEF3
        for <linux-efi@vger.kernel.org>; Mon, 27 Jun 2022 15:31:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31772f8495fso99500637b3.4
        for <linux-efi@vger.kernel.org>; Mon, 27 Jun 2022 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ic6C0bmcH9AgkMQw+lCa1TYZynXLTTH9ZtnkkH22rmQ=;
        b=LZDHLASs1pFn3pf9nxMtict4BJANcSxCih32m6h5gd9YyS20OCjLsZqZ+DJWi3MNxV
         VGWmo8NqVXvWA0Cjwmprwy+ywLQjDvUfC2uSaJchZRMC8avuyq6cwyNBdMTz+cjclD4t
         HIcGcUg1dbPRl6Dgs4f7OzldgFJcbAD8FkFDwyqnlaBusbwAwy299uhlvgGuct744OBl
         /Si/Rq1GDUkeIZUqf80/9OxdkA9gjljHaigE+au4rED07FGnmIW4HAGZuAo0zXQ89Lqr
         b4LzYr2pm9PqZ4J4YFUhAQYpWJtjGhCwUwr9Iz86RrhGswHth/IquH158keCc3EBJP70
         w72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ic6C0bmcH9AgkMQw+lCa1TYZynXLTTH9ZtnkkH22rmQ=;
        b=vZSrmS0VSi4YNMbiLnzDxjzbhgvroeEGstmDqbu0nCKZq/AisNgHPx66bRY2VVnDHF
         wk9aqCAn0+FS8nnDgc8K0T8D4vf/bysVPXrFIEhnVFfXpopbaUoxFskS90j49eiqVJJZ
         CNDtzgeS2eKqJcR64tlUuENcpruK8CkP3NIM4xp/XtxAMewStnVGHslEnYhWYHg/F9Ix
         Q9cBiAilFgWT6NyaOGFNvZczN46JUTiLx+HXWKAO9B0X+Et8aFBE6yDjTr6yfR+HRZT5
         2G7+3ge1hGY3KIVm1iB0GJfg8OHAuGLEx8dvkX0GSLRap+H/7JdU7s0pm9sa6pD4AwK/
         BG0A==
X-Gm-Message-State: AJIora9IG1FyrgHOGkqBtybMn0kgc1E/dcPSYfYekjHmpLm+SP9nV69O
        //rf2/A6wpwhPtIjunw78M8whMoNpsdkykTmrB/qng==
X-Google-Smtp-Source: AGRyM1tUFYXa1u3wVtkxZxboJ89DDS4AuPHiVdMC0xYBTCaN8yVy6QiA1xNf+bXnuCHOV2mlpfP9gkMh9RNKKcrJLQM=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr18136555ywe.126.1656369061313; Mon, 27
 Jun 2022 15:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-14-saravanak@google.com>
 <YrmXpcU1NTYW6T/n@linaro.org>
In-Reply-To: <YrmXpcU1NTYW6T/n@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Jun 2022 15:30:25 -0700
Message-ID: <CAGETcx8dwNcZFFzhhv=kMhpuQnyaEekrycpAmGusD-s+qfvA9g@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] driver core: Use device's fwnode to check if it
 is waiting for suppliers
To:     Abel Vesa <abel.vesa@linaro.org>
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
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 27, 2022 at 4:42 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 20-11-20 18:02:28, Saravana Kannan wrote:
> > To check if a device is still waiting for its supplier devices to be
> > added, we used to check if the devices is in a global
> > waiting_for_suppliers list. Since the global list will be deleted in
> > subsequent patches, this patch stops using this check.
> >
> > Instead, this patch uses a more device specific check. It checks if the
> > device's fwnode has any fwnode links that haven't been converted to
> > device links yet.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 395dece1c83a..1873cecb0cc4 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
> >  static LIST_HEAD(deferred_sync);
> >  static unsigned int defer_sync_state_count = 1;
> >  static DEFINE_MUTEX(fwnode_link_lock);
> > +static bool fw_devlink_is_permissive(void);
> >
> >  /**
> >   * fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
> >        * Device waiting for supplier to become available is not allowed to
> >        * probe.
> >        */
> > -     mutex_lock(&wfs_lock);
> > -     if (!list_empty(&dev->links.needs_suppliers) &&
> > -         dev->links.need_for_probe) {
> > -             mutex_unlock(&wfs_lock);
> > +     mutex_lock(&fwnode_link_lock);
> > +     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > +         !fw_devlink_is_permissive()) {
> > +             mutex_unlock(&fwnode_link_lock);
>
> Hi Saravana,
>
> First of, sorry for going back to this.

No worries at all. If there's an issue with fw_devlink, I want to have it fixed.

> There is a scenario where this check will not work and probably should
> work. It goes like this:
>
> A clock controller is not allowed to probe because it uses a clock from a child device of a
> consumer, like so:
>
>         dispcc: clock-controller@af00000 {
>                 clocks = <&dsi0_phy 0>;
>         };
>
>         mdss: mdss@ae00000 {
>                 clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
>
>                 dsi0_phy: dsi-phy@ae94400 {
>                         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>                 };
>         };
>
> This is a real scenario actually, but I stripped it down to the essentials.

I'm well aware of this scenario and explicitly wrote code to address this :)

See this comment in fw_devlink_create_devlink()

       /*
         * If we can't find the supplier device from its fwnode, it might be
         * due to a cyclic dependency between fwnodes. Some of these cycles can
         * be broken by applying logic. Check for these types of cycles and
         * break them so that devices in the cycle probe properly.
         *
         * If the supplier's parent is dependent on the consumer, then the
         * consumer and supplier have a cyclic dependency. Since fw_devlink
         * can't tell which of the inferred dependencies are incorrect, don't
         * enforce probe ordering between any of the devices in this cyclic
         * dependency. Do this by relaxing all the fw_devlink device links in
         * this cycle and by treating the fwnode link between the consumer and
         * the supplier as an invalid dependency.
         */

Applying this comment to your example, dispcc is the "consumer",
dsi0_phy is the "supplier" and mdss is the "supplier's parent".

And because we can't guarantee the order of addition of these top
level devices is why I also have this piece of recursive call inside
__fw_devlink_link_to_suppliers():

                /*
                 * If a device link was successfully created to a supplier, we
                 * now need to try and link the supplier to all its suppliers.
                 *
                 * This is needed to detect and delete false dependencies in
                 * fwnode links that haven't been converted to a device link
                 * yet. See comments in fw_devlink_create_devlink() for more
                 * details on the false dependency.
                 *
                 * Without deleting these false dependencies, some devices will
                 * never probe because they'll keep waiting for their false
                 * dependency fwnode links to be converted to device links.
                 */
                sup_dev = get_dev_from_fwnode(sup);
                __fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
                put_device(sup_dev);

So when mdss gets added, we'll link it to dispcc and then check if
dispcc has any suppliers it needs to link to. And that's when the
logic will catch the cycle and fix it.

Can you tell me why this wouldn't unblock the probing of dispcc? Are
you actually hitting this on a device? If so, can you please check why
this logic isn't sufficient to catch and undo the cycle?

Thanks,
Saravana

> So, the dsi0_phy will be "device_add'ed" (through of_platform_populate) by the mdss probe.
> The mdss will probe defer waiting for the DISP_CC_MDSS_MDP_CLK, while
> the dispcc will probe defer waiting for the dsi0_phy (supplier).
>
> Basically, this 'supplier availability check' does not work when a supplier might
> be populated by a consumer of the device that is currently trying to probe.
>
>
> Abel
>
>
> >               return -EPROBE_DEFER;
> >       }
> > -     mutex_unlock(&wfs_lock);
> > +     mutex_unlock(&fwnode_link_lock);
> >
> >       device_links_write_lock();
> >
> > @@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
> >       bool val;
> >
> >       device_lock(dev);
> > -     mutex_lock(&wfs_lock);
> > -     val = !list_empty(&dev->links.needs_suppliers)
> > -           && dev->links.need_for_probe;
> > -     mutex_unlock(&wfs_lock);
> > +     val = !list_empty(&dev->fwnode->suppliers);
> >       device_unlock(dev);
> >       return sysfs_emit(buf, "%u\n", val);
> >  }
> > @@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
> >                       goto err_remove_dev_groups;
> >       }
> >
> > -     if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> > +     if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
> >               error = device_create_file(dev, &dev_attr_waiting_for_supplier);
> >               if (error)
> >                       goto err_remove_dev_online;
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
> >
