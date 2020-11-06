Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2438B2A8C0C
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 02:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgKFBZ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 20:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFBZ1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Nov 2020 20:25:27 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA072C0613D4
        for <linux-efi@vger.kernel.org>; Thu,  5 Nov 2020 17:25:26 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id o70so3083327ybc.1
        for <linux-efi@vger.kernel.org>; Thu, 05 Nov 2020 17:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzV9usbcyvrZBezSzuliRNMORjroXFiHCPOIQMppm20=;
        b=mFp6wXmb3dx9Iz2MBUFPuVyhUmTP9lVcgCQyveXhQC419PlTNsEI22yTsPSMZG3kax
         nCA+1dWmdyC3cWpzU49fyRrvZeCLfP1DG4UmaQghxfel1tj/ATOuawBGgVV7u7rd3IXM
         B3nOHiSCZ0UVphZueGqjVfoII+u+8CgPeywRQoPZiN90fLMexZ4OTiIWWVcJZpGuww0b
         5i1H1jHOQRmOezoZJCcZrJFBPQxgzXBPiRWAD7uMqyCVSeIAy0hKx54ImBx5TMTl5tM1
         ODvAV2PnmUPZgqwW3qnqbwsT2wQij3uP3CiH3p3nXpvFTtKUXi+vJi/c3j/+B8DEr9kj
         uBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzV9usbcyvrZBezSzuliRNMORjroXFiHCPOIQMppm20=;
        b=XlHhEdAjLcJjl9Z/5OxaDSnF8GuJ2kumsZ3qFuH8GQRR+lK1Xs0ymXQ+lFRzQBSRqn
         RfW6BSIdNWEAky+9li2UNpHl3YqKTAhdIBlyezb5+CXNWTOUVgNfyLw2AS+9RNpkfr/N
         GItLwwlGHub90XL+oLZHfjYGQjZ4BeyMZ5YdQsT/bmUMXtKF5WRF9tPQXYRMecgcZQM0
         39GTSULR1hU2Mmsb2j+u31SUMIdzlinZHMgwcLiKLDy88rDQohcGuQFKx5Glup4oZ6h8
         8HOZ8w5RlHyJICLxt70CbyXYSysun2XxEMDH+7G7YKlp0Y/7Gh29rjcqslP7AE4z4ZcO
         vh/Q==
X-Gm-Message-State: AOAM531cLqVkO4AgoncY4xLEKJQgY3j4iHYCzoVYb8ejMleYLTM8aujv
        CBvrevgHyUPFHWdqtVvqpvQQPnSdhhmpAVZrLORA+w==
X-Google-Smtp-Source: ABdhPJyYHml/89uqvPtNmXYMF2Pm87o8/A6MHGqILFDdIGr3l1sb+4jGsYPEXHB+yaFTcNWWksQrzvjmCxCbmsk95lA=
X-Received: by 2002:a25:9c02:: with SMTP id c2mr7063033ybo.228.1604625925368;
 Thu, 05 Nov 2020 17:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-16-saravanak@google.com> <20201105094228.GE3439341@kroah.com>
 <CAGETcx-0TPte6g3Cf5F3WJwdW-9yUptLDj3AcEdvWN0YJ2H4qg@mail.gmail.com>
In-Reply-To: <CAGETcx-0TPte6g3Cf5F3WJwdW-9yUptLDj3AcEdvWN0YJ2H4qg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 17:24:49 -0800
Message-ID: <CAGETcx-AcCk2c4Jq9HGfxUcCdnpWb5d_ubNd=r6KciHCFUdAVw@mail.gmail.com>
Subject: Re: [PATCH v1 15/18] of: property: Update implementation of
 add_links() to create fwnode links
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

On Thu, Nov 5, 2020 at 3:25 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Nov 5, 2020 at 1:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 04, 2020 at 03:23:52PM -0800, Saravana Kannan wrote:
> > > The semantics of add_links() has changed from creating device link
> > > between devices to creating fwnode links between fwnodes. So, update the
> > > implementation of add_links() to match the new semantics.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 150 ++++++++++++------------------------------
> > >  1 file changed, 41 insertions(+), 109 deletions(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 408a7b5f06a9..86303803f1b3 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1038,33 +1038,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
> > >  }
> > >
> > >  /**
> > > - * of_get_next_parent_dev - Add device link to supplier from supplier phandle
> > > - * @np: device tree node
> > > - *
> > > - * Given a device tree node (@np), this function finds its closest ancestor
> > > - * device tree node that has a corresponding struct device.
> > > - *
> > > - * The caller of this function is expected to call put_device() on the returned
> > > - * device when they are done.
> > > - */
> > > -static struct device *of_get_next_parent_dev(struct device_node *np)
> > > -{
> > > -     struct device *dev = NULL;
> > > -
> > > -     of_node_get(np);
> > > -     do {
> > > -             np = of_get_next_parent(np);
> > > -             if (np)
> > > -                     dev = get_dev_from_fwnode(&np->fwnode);
> > > -     } while (np && !dev);
> > > -     of_node_put(np);
> > > -     return dev;
> > > -}
> > > -
> > > -/**
> > > - * of_link_to_phandle - Add device link to supplier from supplier phandle
> > > - * @dev: consumer device
> > > - * @sup_np: phandle to supplier device tree node
> > > + * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> > > + * @con_np: consumer device tree node
> > > + * @sup_np: supplier device tree node
> > >   *
> > >   * Given a phandle to a supplier device tree node (@sup_np), this function
> > >   * finds the device that owns the supplier device tree node and creates a
> > > @@ -1074,16 +1050,14 @@ static struct device *of_get_next_parent_dev(struct device_node *np)
> > >   * cases, it returns an error.
> > >   *
> > >   * Returns:
> > > - * - 0 if link successfully created to supplier
> > > - * - -EAGAIN if linking to the supplier should be reattempted
> > > + * - 0 if fwnode link successfully created to supplier
> > >   * - -EINVAL if the supplier link is invalid and should not be created
> > > - * - -ENODEV if there is no device that corresponds to the supplier phandle
> > > + * - -ENODEV if struct device will never be create for supplier
> > >   */
> > > -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > > -                           u32 dl_flags)
> > > +static int of_link_to_phandle(struct device_node *con_np,
> > > +                           struct device_node *sup_np)
> > >  {
> > > -     struct device *sup_dev, *sup_par_dev;
> > > -     int ret = 0;
> > > +     struct device *sup_dev;
> > >       struct device_node *tmp_np = sup_np;
> > >
> > >       of_node_get(sup_np);
> > > @@ -1106,7 +1080,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > >       }
> > >
> > >       if (!sup_np) {
> > > -             dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
> > > +             pr_debug("Not linking %pOFP to %pOFP - No device\n",
> > > +                      con_np, tmp_np);
> >
> > Who is calling this function without a valid dev pointer?
>
> Sorry, I plan to delete the "dev" parameter as it's not really used
> anywhere. I'm trying to do that without causing build time errors and
> making the series into digestible small patches.

*facepalm* for my earlier response. You'll notice that I've already
deleted the "dev" input param to this function. That's why I can't use
it here :)

-Saravana
