Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F92A7AAD
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgKEJfQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 04:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgKEJfQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Nov 2020 04:35:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C572080D;
        Thu,  5 Nov 2020 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604568915;
        bh=bASPlTaQ67dRFUqsBoKIOD+05XQnomuuiHur3vOvvqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqJXHLDyayT35P82XeUnk/0Zgo7844vWyzad+aqx7DIX9pn/vZQzv3owttNMODQ3F
         4Wd1uXk3+hU2zuoVTb0FWAzHcHeAbSq/fxJ1VsIks1NTLKjlipKaZxftL6EpS/J1ng
         JxV4WbVxgEkWvMjQ74wD77hqdpPY+tCKBXAvDI+s=
Date:   Thu, 5 Nov 2020 10:36:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
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
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 07/18] driver core: Add fwnode_init()
Message-ID: <20201105093604.GD3439341@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-8-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104232356.4038506-8-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 04, 2020 at 03:23:44PM -0800, Saravana Kannan wrote:
> There are multiple locations in the kernel where a struct fwnode_handle
> is initialized. Add fwnode_init() so that we have one way of
> initializing a fwnode_handle.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/acpi/property.c         | 2 +-
>  drivers/acpi/scan.c             | 2 +-
>  drivers/base/swnode.c           | 2 +-
>  drivers/firmware/efi/efi-init.c | 8 ++++----
>  include/linux/fwnode.h          | 5 +++++
>  include/linux/of.h              | 2 +-
>  kernel/irq/irqdomain.c          | 2 +-
>  7 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d04de10a63e4..24e87b630573 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -76,7 +76,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
>  		return false;
>  
>  	dn->name = link->package.elements[0].string.pointer;
> -	dn->fwnode.ops = &acpi_data_fwnode_ops;
> +	fwnode_init(&dn->fwnode, &acpi_data_fwnode_ops);
>  	dn->parent = parent;
>  	INIT_LIST_HEAD(&dn->data.properties);
>  	INIT_LIST_HEAD(&dn->data.subnodes);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a896e5e87c93..0ac19f9274b8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1589,7 +1589,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>  	device->device_type = type;
>  	device->handle = handle;
>  	device->parent = acpi_bus_get_parent(handle);
> -	device->fwnode.ops = &acpi_device_fwnode_ops;
> +	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
>  	acpi_set_device_status(device, sta);
>  	acpi_device_get_busid(device);
>  	acpi_set_pnp_ids(handle, &device->pnp, type);
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 010828fc785b..4a4b2008fbc2 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -653,7 +653,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>  	swnode->parent = parent;
>  	swnode->allocated = allocated;
>  	swnode->kobj.kset = swnode_kset;
> -	swnode->fwnode.ops = &software_node_ops;
> +	fwnode_init(&swnode->fwnode, &software_node_ops);
>  
>  	ida_init(&swnode->child_ids);
>  	INIT_LIST_HEAD(&swnode->entry);
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index f55a92ff12c0..b148f1459fb3 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -359,9 +359,7 @@ static const struct fwnode_operations efifb_fwnode_ops = {
>  	.add_links = efifb_add_links,
>  };
>  
> -static struct fwnode_handle efifb_fwnode = {
> -	.ops = &efifb_fwnode_ops,
> -};
> +static struct fwnode_handle efifb_fwnode;
>  
>  static int __init register_gop_device(void)
>  {
> @@ -375,8 +373,10 @@ static int __init register_gop_device(void)
>  	if (!pd)
>  		return -ENOMEM;
>  
> -	if (IS_ENABLED(CONFIG_PCI))
> +	if (IS_ENABLED(CONFIG_PCI)) {
> +		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
>  		pd->dev.fwnode = &efifb_fwnode;
> +	}
>  
>  	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
>  	if (err)
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index e0abafbb17f8..593fb8e58f21 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -169,6 +169,11 @@ struct fwnode_operations {
>  			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
>  	} while (false)
>  #define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
> +static inline void fwnode_init(struct fwnode_handle *fwnode,
> +			       const struct fwnode_operations *ops)
> +{
> +	fwnode->ops = ops;
> +}
>  

A blank line before a new inline function is always nice to have :)

thanks,

greg k-h
