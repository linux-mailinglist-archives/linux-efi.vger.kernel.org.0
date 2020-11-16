Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14402B4B46
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgKPQex (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 11:34:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35195 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgKPQex (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 11:34:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id n11so16620120ota.2;
        Mon, 16 Nov 2020 08:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6r+TMuXBaWk+0YlYimRvQ3UQLh6IAXQbc5v0U3Ytpw=;
        b=A/DkBwv36Hx6eCE6p6k/oGdOq0EEGvqZclZxkTMKgpsYXugw1mZuN1cvSArmh+RYB5
         XnJgD5puOt/KJa7SHqx9KZYIs26Aijf130/jVnb3TskkADMLbyaI+f73STB/7xAOTfaO
         4c7q8HUSqoy5c6ecqpwkQtYBXe7miWSzzIQSH1pity7dRc3y4A5vXlxs1BwoKOvhtGdV
         iBPyeftuz26XlvPyp2iie4WZrbLamxZAxHOywFrXAXEjIejzOVw2uiVGXRtLNYeiTCyH
         sNK2CQ15VIldWXrcBCtGflwlp6dZ94lG5hLvFptc67fZbhjAUCGiK9sJzSce2jlGI9SH
         xXkw==
X-Gm-Message-State: AOAM532yd+kgi/LYm3iywxQm2CuycEWT79lmHYJhnw9sLK65kPmZgog4
        ex+YqYCTcPalEFLG7PZ0IdairCTbWJrTeqMQZOQ9AyJzSAU=
X-Google-Smtp-Source: ABdhPJxXfOjX8Lhy1wwWUe392JncSbAGxcKFQfRzrNKGlBugUCM6FToKHQOVyMbEwnMz2xffTepsuPCWMTdjBP+D1T8=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr46532ota.321.1605544492320;
 Mon, 16 Nov 2020 08:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-15-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-15-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:34:41 +0100
Message-ID: <CAJZ5v0hQFRo8DzA=RFV8_L7_feiZF=7XMT8vVXgG5VtbLPEJ5Q@mail.gmail.com>
Subject: Re: [PATCH v1 14/18] driver core: Use device's fwnode to check if it
 is waiting for suppliers
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
> To check if a device is still waiting for its supplier devices to be
> added, we used to check if the devices is in a global
> waiting_for_suppliers list. Since the global list will be deleted in
> subsequent patches, this patch stops using this check.

My kind of educated guess is that you want to drop
waiting_for_suppliers and that's why you want to use supplier links
here.

>
> Instead, this patch uses a more device specific check. It checks if the
> device's fwnode has any fwnode links that haven't been converted to
> device links yet.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4ae5f2885ac5..d51dd564add1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
>  static DEFINE_MUTEX(fwnode_link_lock);
> +static bool fw_devlink_is_permissive(void);
>
>  /**
>   * fwnode_link_add - Create a link between two fwnode_handles.
> @@ -994,13 +995,13 @@ int device_links_check_suppliers(struct device *dev)
>          * Device waiting for supplier to become available is not allowed to
>          * probe.
>          */
> -       mutex_lock(&wfs_lock);
> -       if (!list_empty(&dev->links.needs_suppliers) &&
> -           dev->links.need_for_probe) {
> -               mutex_unlock(&wfs_lock);
> +       mutex_lock(&fwnode_link_lock);
> +       if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> +           !fw_devlink_is_permissive()) {
> +               mutex_unlock(&fwnode_link_lock);
>                 return -EPROBE_DEFER;
>         }
> -       mutex_unlock(&wfs_lock);
> +       mutex_unlock(&fwnode_link_lock);
>
>         device_links_write_lock();
>
> @@ -1166,10 +1167,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
>         bool val;
>
>         device_lock(dev);
> -       mutex_lock(&wfs_lock);
> -       val = !list_empty(&dev->links.needs_suppliers)
> -             && dev->links.need_for_probe;
> -       mutex_unlock(&wfs_lock);

Why isn't the lock needed any more?

Or maybe it wasn't needed previously too?

> +       val = !list_empty(&dev->fwnode->suppliers);
>         device_unlock(dev);
>         return sysfs_emit(buf, "%u\n", val);
>  }
> @@ -2226,7 +2224,7 @@ static int device_add_attrs(struct device *dev)
>                         goto err_remove_dev_groups;
>         }
>
> -       if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> +       if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {

And why is this change needed?

>                 error = device_create_file(dev, &dev_attr_waiting_for_supplier);
>                 if (error)
>                         goto err_remove_dev_online;
> --
> 2.29.1.341.ge80a0c044ae-goog
>
