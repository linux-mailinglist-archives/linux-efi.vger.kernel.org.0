Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E772B4AFA
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgKPQZp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 11:25:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34562 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbgKPQZo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 11:25:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id j14so16589322ots.1;
        Mon, 16 Nov 2020 08:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Nc27M9ki9nKK3SIKwkHCnsf1A8616+iJpgisEL0zo4=;
        b=ihWUupm7LNY6quJsfIwPiAH98FIeUh4boKu5Y5ptabQAh4xA4JavBtrVCGUpO56bLf
         VMRx69ePxkDRGQ4Bt17xPqQGSh0F0oJBdvoBODOlZRK8T+KtcVtek09uUAv3cv/buMs9
         KMvuXOVoDrwVgLXKhQSJh4FOlsipo71F7Y8oEe1eXDIWYF5BDSvtyzbZcsJXtgAXBl0s
         eMqimhASylpvN6YdSt+FnNtYCNcG12mjrhRqVnYuzljSLsQEk3JWZeL3WYsC+FoeC7yD
         60nzkpE+MPXygNgYhpPdH/5VGTly5lcBNvSufmCedpwV+sr1GY6a5/iDdS1NEx8hgAi5
         zeCQ==
X-Gm-Message-State: AOAM5300NB1LYG98CRkYLEzZfZ0mCV1WgfllYORH6dX2EU2ap+/uO0Hg
        je0KtKrlh1zlefuElJGEf6SMiWD4DOvDNPdqrJw=
X-Google-Smtp-Source: ABdhPJwkIGRT8KJ1R50oN/HYp+g+UTL1v50WX4tmwPKkYgyP3a0+sWiF5eWeqZBT3UMgTvZ/iOm+4l1OeljlMxM0GpI=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr15316ota.321.1605543943606;
 Mon, 16 Nov 2020 08:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-13-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-13-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:25:32 +0100
Message-ID: <CAJZ5v0hM9cUeW58OMRRWfAfY+_GYuXy=Dt8bssU+TCufuhukmw@mail.gmail.com>
Subject: Re: [PATCH v1 12/18] driver core: Add fw_devlink_parse_fwtree()
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
> This function is a wrapper around fwnode_operations.add_links().
>
> This function parses each node in a fwnode tree and create fwnode links
> for each of those nodes. The information for creating the fwnode links
> (the supplier and consumer fwnode) is obtained by parsing the properties
> in each of the fwnodes.
>
> This function also ensures that no fwnode is parsed more than once by
> marking the fwnodes as parsed.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 19 +++++++++++++++++++
>  include/linux/fwnode.h |  3 +++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4a0907574646..ee28d8c7ee85 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1543,6 +1543,25 @@ static bool fw_devlink_is_permissive(void)
>         return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
>  }
>
> +static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
> +{
> +       if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
> +               return;

Why is the flag needed?

Duplicate links won't be created anyway and it doesn't cause the tree
walk to be terminated.

> +
> +       fwnode_call_int_op(fwnode, add_links, NULL);
> +       fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
> +}
> +
> +static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *child = NULL;
> +
> +       fw_devlink_parse_fwnode(fwnode);
> +
> +       while ((child = fwnode_get_next_available_child_node(fwnode, child)))

I'd prefer

for (child = NULL; child; child =
fwnode_get_next_available_child_node(fwnode, child))

> +               fw_devlink_parse_fwtree(child);
> +}
> +
>  static void fw_devlink_link_device(struct device *dev)
>  {
>         int fw_ret;
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index ec02e1e939cc..9aaf9e4f3994 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -15,12 +15,15 @@
>  struct fwnode_operations;
>  struct device;
>

Description here, please.

> +#define FWNODE_FLAG_LINKS_ADDED                BIT(0)
> +
>  struct fwnode_handle {
>         struct fwnode_handle *secondary;
>         const struct fwnode_operations *ops;
>         struct device *dev;
>         struct list_head suppliers;
>         struct list_head consumers;
> +       u32 flags;

That's a bit wasteful.  Maybe u8 would suffice for the time being?

>  };
>
>  struct fwnode_link {
> --
> 2.29.1.341.ge80a0c044ae-goog
>
