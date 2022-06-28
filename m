Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DD55E6E2
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbiF1PzI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiF1PzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 11:55:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9335AA7
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 08:55:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so18191217edb.6
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DL6UdLR7FEJazkCj2FBmbmojXNOORr6ZP3bxU8f4s34=;
        b=l0dA5NX94rb9ZtgdVBBElJ7NSfh1y1w9K5EBLTCi6RyVbe81X5TmiiqC/bsBYdeHsA
         VKjaosDs3VClNI0MJyP4z+CekQuEBc7r1lgfi17LJUxp8uxAVRpsPNfhD0jkS2wRPhFD
         g70V1tChV3KlHnnkaVw13E/AzJpuuwwrcY4PoY+s+cGG+9M3lh9BSTUGVxX++ofdUUab
         QmLAnTgAGAjzn6/yiCkJUnxWgTYdg45D2Uh7N+TzXuGTGqhwbGOKE5GnhXSJJ/42TTsK
         dzSkP9Z6qw2a+vvUPHveUIfSQl3kJWIfYvKHGSmqsVHF3Tqg3qgH6AghHVOmWXscDGcF
         n5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DL6UdLR7FEJazkCj2FBmbmojXNOORr6ZP3bxU8f4s34=;
        b=uPmK08lZz5fVhmt64auKFM27DB7U1f4r8WpHEIg/1+QmLO60bIJH4RenVps/99ZY7W
         LUppv9BcGmmt73720BXTN6M1p9WATpodD3x171IAw3OfbfyFnTipv0EOqlQARaFuaOb5
         lfc9m5NEX/Mbo6hVTOabHYAf12+ymeHa6JLo1gwnkpsXuJDutRkKyfOxIODOLrQMEPqW
         4rTn+25/2ZaKS9hgBLT2TCy4RmhBUlcwp71hfgQhmh3hr3Jl+b3OyWTk7tXKbyHj1X09
         ivw0Piot2RCzR40eY7FLGHCZh+U1U4ox2DBMQEPQkzcUPABn1ztPPyYBDIMl0xtLQSlt
         K0eg==
X-Gm-Message-State: AJIora/ulfvfxT1Ph95/UHpGSmAtrn+76vzZYggilmRNXRKe5RquGdth
        UlrpUYL9Uj/dzb9eHLdV2ZWnqQ==
X-Google-Smtp-Source: AGRyM1u9rro4xRv9FJA6pS1u5agZm7Yo8S41wqUnC+qxUtvszIakDl3IlWWUuftH/pjc1KRB2WmOhg==
X-Received: by 2002:a05:6402:328f:b0:435:7f7a:7666 with SMTP id f15-20020a056402328f00b004357f7a7666mr23627336eda.168.1656431703419;
        Tue, 28 Jun 2022 08:55:03 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b004355dc75066sm9726089edo.86.2022.06.28.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:55:02 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:55:00 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
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
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 13/17] driver core: Use device's fwnode to check if it
 is waiting for suppliers
Message-ID: <YrskVLshWeps+NXw@linaro.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-14-saravanak@google.com>
 <YrmXpcU1NTYW6T/n@linaro.org>
 <CAGETcx8dwNcZFFzhhv=kMhpuQnyaEekrycpAmGusD-s+qfvA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8dwNcZFFzhhv=kMhpuQnyaEekrycpAmGusD-s+qfvA9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 22-06-27 15:30:25, Saravana Kannan wrote:
> On Mon, Jun 27, 2022 at 4:42 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 20-11-20 18:02:28, Saravana Kannan wrote:
> > > To check if a device is still waiting for its supplier devices to be
> > > added, we used to check if the devices is in a global
> > > waiting_for_suppliers list. Since the global list will be deleted in
> > > subsequent patches, this patch stops using this check.
> > >
> > > Instead, this patch uses a more device specific check. It checks if the
> > > device's fwnode has any fwnode links that haven't been converted to
> > > device links yet.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/core.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 395dece1c83a..1873cecb0cc4 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
> > >  static LIST_HEAD(deferred_sync);
> > >  static unsigned int defer_sync_state_count = 1;
> > >  static DEFINE_MUTEX(fwnode_link_lock);
> > > +static bool fw_devlink_is_permissive(void);
> > >
> > >  /**
> > >   * fwnode_link_add - Create a link between two fwnode_handles.
> > > @@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
> > >        * Device waiting for supplier to become available is not allowed to
> > >        * probe.
> > >        */
> > > -     mutex_lock(&wfs_lock);
> > > -     if (!list_empty(&dev->links.needs_suppliers) &&
> > > -         dev->links.need_for_probe) {
> > > -             mutex_unlock(&wfs_lock);
> > > +     mutex_lock(&fwnode_link_lock);
> > > +     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > > +         !fw_devlink_is_permissive()) {
> > > +             mutex_unlock(&fwnode_link_lock);
> >
> > Hi Saravana,
> >
> > First of, sorry for going back to this.
>
> No worries at all. If there's an issue with fw_devlink, I want to have it fixed.
>
> > There is a scenario where this check will not work and probably should
> > work. It goes like this:
> >
> > A clock controller is not allowed to probe because it uses a clock from a child device of a
> > consumer, like so:
> >
> >         dispcc: clock-controller@af00000 {
> >                 clocks = <&dsi0_phy 0>;
> >         };
> >
> >         mdss: mdss@ae00000 {
> >                 clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
> >
> >                 dsi0_phy: dsi-phy@ae94400 {
> >                         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> >                 };
> >         };
> >
> > This is a real scenario actually, but I stripped it down to the essentials.
>
> I'm well aware of this scenario and explicitly wrote code to address this :)
>

Actually, the problem seems to be when you have two dsi phys.
Like so:

         dispcc: clock-controller@af00000 {
                 clocks = <&dsi0_phy 0>;
                 clocks = <&dsi1_phy 0>;
         };

         mdss: mdss@ae00000 {
                 clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;

                 dsi0_phy: dsi-phy@ae94400 {
                         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
                 };

		 dsi1_phy: dsi-phy@ae64400 {
                         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
                 };
         };

And from what I've seen happening so far is that the device_is_dependent
check for the parent of the supplier (if it also a consumer) seems to return
false on second pass of the same link due to the DL_FLAG_SYNC_STATE_ONLY
being set this time around.

> See this comment in fw_devlink_create_devlink()
>
>        /*
>          * If we can't find the supplier device from its fwnode, it might be
>          * due to a cyclic dependency between fwnodes. Some of these cycles can
>          * be broken by applying logic. Check for these types of cycles and
>          * break them so that devices in the cycle probe properly.
>          *
>          * If the supplier's parent is dependent on the consumer, then the
>          * consumer and supplier have a cyclic dependency. Since fw_devlink
>          * can't tell which of the inferred dependencies are incorrect, don't
>          * enforce probe ordering between any of the devices in this cyclic
>          * dependency. Do this by relaxing all the fw_devlink device links in
>          * this cycle and by treating the fwnode link between the consumer and
>          * the supplier as an invalid dependency.
>          */
>

So when this thing you mentioned above is happening for the second dsi
phy (order doesn't matter), since the dsi phy itself cannot be found,
the device_is_dependent is run for the same link: dispcc -> mdss
(supplier -> consumer), but again, since it has the
DL_FLAG_SYNC_STATE_ONLY this time around, it will skip that specific
link.

> Applying this comment to your example, dispcc is the "consumer",
> dsi0_phy is the "supplier" and mdss is the "supplier's parent".
>
> And because we can't guarantee the order of addition of these top
> level devices is why I also have this piece of recursive call inside
> __fw_devlink_link_to_suppliers():
>
>                 /*
>                  * If a device link was successfully created to a supplier, we
>                  * now need to try and link the supplier to all its suppliers.
>                  *
>                  * This is needed to detect and delete false dependencies in
>                  * fwnode links that haven't been converted to a device link
>                  * yet. See comments in fw_devlink_create_devlink() for more
>                  * details on the false dependency.
>                  *
>                  * Without deleting these false dependencies, some devices will
>                  * never probe because they'll keep waiting for their false
>                  * dependency fwnode links to be converted to device links.
>                  */
>                 sup_dev = get_dev_from_fwnode(sup);
>                 __fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
>                 put_device(sup_dev);
>
> So when mdss gets added, we'll link it to dispcc and then check if
> dispcc has any suppliers it needs to link to. And that's when the
> logic will catch the cycle and fix it.
>
> Can you tell me why this wouldn't unblock the probing of dispcc? Are
> you actually hitting this on a device? If so, can you please check why
> this logic isn't sufficient to catch and undo the cycle?
>

This is happening on Qualcomm SDM845 with Linus's tree.

> Thanks,
> Saravana
>
> > So, the dsi0_phy will be "device_add'ed" (through of_platform_populate) by the mdss probe.
> > The mdss will probe defer waiting for the DISP_CC_MDSS_MDP_CLK, while
> > the dispcc will probe defer waiting for the dsi0_phy (supplier).
> >
> > Basically, this 'supplier availability check' does not work when a supplier might
> > be populated by a consumer of the device that is currently trying to probe.
> >
> >
> > Abel
> >
> >
> > >               return -EPROBE_DEFER;
> > >       }
> > > -     mutex_unlock(&wfs_lock);
> > > +     mutex_unlock(&fwnode_link_lock);
> > >
> > >       device_links_write_lock();
> > >
> > > @@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
> > >       bool val;
> > >
> > >       device_lock(dev);
> > > -     mutex_lock(&wfs_lock);
> > > -     val = !list_empty(&dev->links.needs_suppliers)
> > > -           && dev->links.need_for_probe;
> > > -     mutex_unlock(&wfs_lock);
> > > +     val = !list_empty(&dev->fwnode->suppliers);
> > >       device_unlock(dev);
> > >       return sysfs_emit(buf, "%u\n", val);
> > >  }
> > > @@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
> > >                       goto err_remove_dev_groups;
> > >       }
> > >
> > > -     if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> > > +     if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
> > >               error = device_create_file(dev, &dev_attr_waiting_for_supplier);
> > >               if (error)
> > >                       goto err_remove_dev_online;
> > > --
> > > 2.29.2.454.gaff20da3a2-goog
> > >
> > >
>
