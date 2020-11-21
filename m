Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF62BBBBE
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKUCAc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgKUCAc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:00:32 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9FCC061A04
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:31 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s8so10307063yba.13
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJ5z0tVbBQ7VCLT8sp/5juMZ091JD7XqJCeF4EvVFNw=;
        b=HJITK/af57wdm/BTl9j0m7WiTqJw7nFv50SdYolhoyDIzl+Xia7Nh/STQ2R0OfVH3I
         GES4Bo0L1ecNwkfeDnDN9/xh0vRP++L2FmHxJGbjlga9jCiEz0c6uhPgeL5bTc2kqIlT
         g+ajoUwKGDitBb8kanZm5QlELC5rIkUZa03eLVS7aJw00PlWu91NpkwCyfMbxHKnM2fm
         0COwEohBdA/iizGpGS9xRDYaeJLI8UtmZsZvSdgxD4bIc59M8etaJRz9l6v2ks/6PZ/M
         +/W+uZSP4DDUcr3Y+A/l2sbaMrAdCpQv4gLtNEzVSHD2x0+JNMlO+ExCqsN6n47SeiMs
         ExRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ5z0tVbBQ7VCLT8sp/5juMZ091JD7XqJCeF4EvVFNw=;
        b=k9hYWgChsGaOWtdP4dkCbjZtNaX/CeezqHIgdz7ETfJsLSErmGXBoEDdg4NaX8xgWc
         D7uz08TG9depyRDK0aO2YeMmGiozZR+9YofPhAhYL6eN9+g3yRqKPy7Ga1LaZ14ASDYV
         TLzBJTSHAJ2gaWaZ7AV6G1a256Mhvnr6UTLDdlSA/Vpl5/6/oH4tjooaveAlaDeCtCky
         yrJevw4V5UhnJRxnMlD83UfzfUMENj6tL7+3RAx4D+eayz+A00DiU4X8nfWiywo9H0pa
         Bh3UhMPgRhx9jBfCjya4GjMONYGYNWcY1VX0BIhnAQCfCor1y8bSnUKxRSQu9uZlOfIn
         JkhA==
X-Gm-Message-State: AOAM533ARZDDUE+ivx+oMTb1smufA/1jFhFrk5cY43ZIwTFivOAJTgKq
        Wc7C7IZZMsmLpAunOv7Ca2QKJmBhscgunH4zNwScSw==
X-Google-Smtp-Source: ABdhPJxT2y4zVe+cUD5k32Ww4LVs2ECUDAo0TuccKAbwPGTL8aNvauikmgoTPrO6IreF4GjWu0610kOCaGWNhRxSoe0=
X-Received: by 2002:a25:e805:: with SMTP id k5mr40326756ybd.32.1605924030966;
 Fri, 20 Nov 2020 18:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-12-saravanak@google.com> <CAJZ5v0hxdq2prUUkoPwpW5+crAD096eYQAQ7PZ2oaFKT7_gcHA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hxdq2prUUkoPwpW5+crAD096eYQAQ7PZ2oaFKT7_gcHA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 17:59:54 -0800
Message-ID: <CAGETcx8YUCcj-GUsR8=CCgapBTPs8Sxdq4ZWiq7Dwys91SyHCw@mail.gmail.com>
Subject: Re: [PATCH v1 11/18] driver core: Redefine the meaning of fwnode_operations.add_links()
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

On Mon, Nov 16, 2020 at 8:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Change the meaning of fwnode_operations.add_links() to just create
> > fwnode links by parsing the properties of a given fwnode.
> >
> > This patch doesn't actually make any code changes. To keeps things more
> > digestable, the actual functional changes come in later patches in this
> > series.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  include/linux/fwnode.h | 42 +++---------------------------------------
> >  1 file changed, 3 insertions(+), 39 deletions(-)
> >
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index afde643f37a2..ec02e1e939cc 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -78,44 +78,8 @@ struct fwnode_reference_args {
> >   *                            endpoint node.
> >   * @graph_get_port_parent: Return the parent node of a port node.
> >   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
> > - * @add_links: Called after the device corresponding to the fwnode is added
> > - *             using device_add(). The function is expected to create device
> > - *             links to all the suppliers of the device that are available at
> > - *             the time this function is called.  The function must NOT stop
> > - *             at the first failed device link if other unlinked supplier
> > - *             devices are present in the system.  This is necessary for the
> > - *             driver/bus sync_state() callbacks to work correctly.
> > - *
> > - *             For example, say Device-C depends on suppliers Device-S1 and
> > - *             Device-S2 and the dependency is listed in that order in the
> > - *             firmware.  Say, S1 gets populated from the firmware after
> > - *             late_initcall_sync().  Say S2 is populated and probed way
> > - *             before that in device_initcall(). When C is populated, if this
> > - *             add_links() function doesn't continue past a "failed linking to
> > - *             S1" and continue linking C to S2, then S2 will get a
> > - *             sync_state() callback before C is probed. This is because from
> > - *             the perspective of S2, C was never a consumer when its
> > - *             sync_state() evaluation is done. To avoid this, the add_links()
> > - *             function has to go through all available suppliers of the
> > - *             device (that corresponds to this fwnode) and link to them
> > - *             before returning.
> > - *
> > - *             If some suppliers are not yet available (indicated by an error
> > - *             return value), this function will be called again when other
> > - *             devices are added to allow creating device links to any newly
> > - *             available suppliers.
> > - *
> > - *             Return 0 if device links have been successfully created to all
> > - *             the known suppliers of this device or if the supplier
> > - *             information is not known.
> > - *
> > - *             Return -ENODEV if the suppliers needed for probing this device
> > - *             have not been registered yet (because device links can only be
> > - *             created to devices registered with the driver core).
> > - *
> > - *             Return -EAGAIN if some of the suppliers of this device have not
> > - *             been registered yet, but none of those suppliers are necessary
> > - *             for probing the device.
> > + * @add_links: Create fwnode links to all the suppliers of the fwnode. Return
> > + *             zero on success, a negative error code otherwise.
>
> I'd say something like "Create fwnode links to all nodes that
> represent devices supplying resources to the device represented by the
> current fwnode.  Return ..., or a negative ... on failure."

I don't have a strong opinion about this, but want to clarify that I'm
intentionally choosing not to say "device" because not all fwnodes
will have devices created for them. Do you still want me to make this
change?


>
> >   */
> >  struct fwnode_operations {
> >         struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> > @@ -155,7 +119,7 @@ struct fwnode_operations {
> >         (*graph_get_port_parent)(struct fwnode_handle *fwnode);
> >         int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
> >                                     struct fwnode_endpoint *endpoint);
> > -       int (*add_links)(const struct fwnode_handle *fwnode,
> > +       int (*add_links)(struct fwnode_handle *fwnode,
> >                          struct device *dev);
> >  };
> >
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
