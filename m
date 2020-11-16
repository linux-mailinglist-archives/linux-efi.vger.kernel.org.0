Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BED2B4B02
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 17:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgKPQ1V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 11:27:21 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43985 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbgKPQ1U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 11:27:20 -0500
Received: by mail-oo1-f67.google.com with SMTP id h10so2457556ooi.10;
        Mon, 16 Nov 2020 08:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf/c2Bl0LKSLy/2BRYxp58QUykMnC0SpcawnTE36dag=;
        b=ho5KnlN5rBsM22w1gg3WtCOv9ufHIg+GVexdALBEysvtoclWluu8eWs6h/lar8gLeJ
         3pDH2dx/upeTArSXX1ymPM3nL2qP3v1XV8vTmOWNqimpUhFIObEDQZjChkKWNxokSTJ1
         Wy/7fNKSKJNfBoyM/vUQZ8rKNUXIodlm2qDGtRPCZSdEGYU6ehE+PkJaR0+dVKZ9m5r0
         Em51u4r8XesPTaCSJn9nSpA+hFIOhyQuW++cQBRH+0LzMywMqmiaIBnWjCN05kQqBAU6
         9LOoZ6J138eZeyz84WuP9JD0hlZ6ZY5x5PhKgu7p/cvtu/N7Tm8NJV7VOLWzKQBR1+Ri
         A8Fg==
X-Gm-Message-State: AOAM531tplixk0n068dg3cnx51AOnXxY96ypj7kjmpYpmxDYJxEMr8p8
        zC+q1TtQs5AWv6mfK/lui9tucIArQezEs/z0+d6JTh9B
X-Google-Smtp-Source: ABdhPJymR65UUIvisBsI+lq9YGIqUU4yE9nPrcP2jprlqU70qkrN9p6QO98tHnyp1ZfUmRNUDaNzjbRUAfGTcMV+LUg=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr115974oob.1.1605544039581;
 Mon, 16 Nov 2020 08:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-14-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-14-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:27:08 +0100
Message-ID: <CAJZ5v0hVRd2pYfGwpa4FLwhtrS2pj9Ng2a2gf61BO5F-94PPXQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/18] driver core: Add fwnode_get_next_parent_dev()
 helper function
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
> Given a fwnode, this function finds the closest ancestor fwnode that has
> a corresponding struct device. The function returns this struct device.
> This function will be used in a subsequent patch in this series.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

I would combine this one with patch [10/18].

> ---
>  drivers/base/core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ee28d8c7ee85..4ae5f2885ac5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1562,6 +1562,31 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
>                 fw_devlink_parse_fwtree(child);
>  }
>
> +/**
> + * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> + * @fwnode: firmware node
> + *
> + * Given a firmware node (@fwnode), this function finds its closest ancestor
> + * firmware node that has a corresponding struct device and returns that struct
> + * device.
> + *
> + * The caller of this function is expected to call put_device() on the returned
> + * device when they are done.
> + */
> +static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
> +{
> +       struct device *dev = NULL;
> +
> +       fwnode_handle_get(fwnode);
> +       do {
> +               fwnode = fwnode_get_next_parent(fwnode);
> +               if (fwnode)
> +                       dev = get_dev_from_fwnode(fwnode);
> +       } while (fwnode && !dev);
> +       fwnode_handle_put(fwnode);
> +       return dev;
> +}
> +
>  static void fw_devlink_link_device(struct device *dev)
>  {
>         int fw_ret;
> --
> 2.29.1.341.ge80a0c044ae-goog
>
