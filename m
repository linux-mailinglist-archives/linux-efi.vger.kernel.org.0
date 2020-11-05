Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D062A7AC0
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 10:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgKEJll (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 04:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgKEJll (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Nov 2020 04:41:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FBF206B5;
        Thu,  5 Nov 2020 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604569299;
        bh=huv8wqMA4Nar/cy2G12DUonScMbkvUlAnPO9dZGQUtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKgo+e0jMB+yeGjTteB4S3YVuCUPMaiLJOFkoXbbyYqSHYprT1ihS58FPBsDIOtGJ
         VXxIzszp2QyQihBD0dqxzpoXxQaFgXE9dY3ABTaOko7KIFNisxtt+aihSkE1dAxhFG
         ObhuGaItFXB0JxXrmkYIASQuaIOyQlLPA7tG2uZE=
Date:   Thu, 5 Nov 2020 10:42:28 +0100
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
Subject: Re: [PATCH v1 15/18] of: property: Update implementation of
 add_links() to create fwnode links
Message-ID: <20201105094228.GE3439341@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-16-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104232356.4038506-16-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 04, 2020 at 03:23:52PM -0800, Saravana Kannan wrote:
> The semantics of add_links() has changed from creating device link
> between devices to creating fwnode links between fwnodes. So, update the
> implementation of add_links() to match the new semantics.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 150 ++++++++++++------------------------------
>  1 file changed, 41 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 408a7b5f06a9..86303803f1b3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1038,33 +1038,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
>  }
>  
>  /**
> - * of_get_next_parent_dev - Add device link to supplier from supplier phandle
> - * @np: device tree node
> - *
> - * Given a device tree node (@np), this function finds its closest ancestor
> - * device tree node that has a corresponding struct device.
> - *
> - * The caller of this function is expected to call put_device() on the returned
> - * device when they are done.
> - */
> -static struct device *of_get_next_parent_dev(struct device_node *np)
> -{
> -	struct device *dev = NULL;
> -
> -	of_node_get(np);
> -	do {
> -		np = of_get_next_parent(np);
> -		if (np)
> -			dev = get_dev_from_fwnode(&np->fwnode);
> -	} while (np && !dev);
> -	of_node_put(np);
> -	return dev;
> -}
> -
> -/**
> - * of_link_to_phandle - Add device link to supplier from supplier phandle
> - * @dev: consumer device
> - * @sup_np: phandle to supplier device tree node
> + * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> + * @con_np: consumer device tree node
> + * @sup_np: supplier device tree node
>   *
>   * Given a phandle to a supplier device tree node (@sup_np), this function
>   * finds the device that owns the supplier device tree node and creates a
> @@ -1074,16 +1050,14 @@ static struct device *of_get_next_parent_dev(struct device_node *np)
>   * cases, it returns an error.
>   *
>   * Returns:
> - * - 0 if link successfully created to supplier
> - * - -EAGAIN if linking to the supplier should be reattempted
> + * - 0 if fwnode link successfully created to supplier
>   * - -EINVAL if the supplier link is invalid and should not be created
> - * - -ENODEV if there is no device that corresponds to the supplier phandle
> + * - -ENODEV if struct device will never be create for supplier
>   */
> -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> -			      u32 dl_flags)
> +static int of_link_to_phandle(struct device_node *con_np,
> +			      struct device_node *sup_np)
>  {
> -	struct device *sup_dev, *sup_par_dev;
> -	int ret = 0;
> +	struct device *sup_dev;
>  	struct device_node *tmp_np = sup_np;
>  
>  	of_node_get(sup_np);
> @@ -1106,7 +1080,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>  	}
>  
>  	if (!sup_np) {
> -		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
> +		pr_debug("Not linking %pOFP to %pOFP - No device\n",
> +			 con_np, tmp_np);

Who is calling this function without a valid dev pointer?

>  		return -ENODEV;
>  	}
>  
> @@ -1115,53 +1090,30 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>  	 * descendant nodes. By definition, a child node can't be a functional
>  	 * dependency for the parent node.
>  	 */
> -	if (of_is_ancestor_of(dev->of_node, sup_np)) {
> -		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
> +	if (of_is_ancestor_of(con_np, sup_np)) {
> +		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
> +			 con_np, sup_np);

Why not dev_dbg() here?  dev should be valid, correct?


>  		of_node_put(sup_np);
>  		return -EINVAL;
>  	}
> +
> +	/*
> +	 * Don't create links to "early devices" that won't have struct devices
> +	 * created for them.
> +	 */
>  	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
>  	if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
> -		/* Early device without struct device. */
> -		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
> -			sup_np);
> +		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
> +			 con_np, sup_np);

How is dev not valid here?  sup_dev might not be, but dev should be.


>  		of_node_put(sup_np);
>  		return -ENODEV;
> -	} else if (!sup_dev) {
> -		/*
> -		 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
> -		 * cycles. So cycle detection isn't necessary and shouldn't be
> -		 * done.
> -		 */
> -		if (dl_flags & DL_FLAG_SYNC_STATE_ONLY) {
> -			of_node_put(sup_np);
> -			return -EAGAIN;
> -		}
> -
> -		sup_par_dev = of_get_next_parent_dev(sup_np);
> -
> -		if (sup_par_dev && device_is_dependent(dev, sup_par_dev)) {
> -			/* Cyclic dependency detected, don't try to link */
> -			dev_dbg(dev, "Not linking to %pOFP - cycle detected\n",
> -				sup_np);
> -			ret = -EINVAL;
> -		} else {
> -			/*
> -			 * Can't check for cycles or no cycles. So let's try
> -			 * again later.
> -			 */
> -			ret = -EAGAIN;
> -		}
> -
> -		of_node_put(sup_np);
> -		put_device(sup_par_dev);
> -		return ret;
>  	}
> -	of_node_put(sup_np);
> -	if (!device_link_add(dev, sup_dev, dl_flags))
> -		ret = -EINVAL;
>  	put_device(sup_dev);
> -	return ret;
> +
> +	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
> +	of_node_put(sup_np);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1361,37 +1313,29 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>   * that list phandles to suppliers. If @prop_name isn't one, this function
>   * doesn't do anything.
>   *
> - * If @prop_name is one, this function attempts to create device links from the
> - * consumer device @dev to all the devices of the suppliers listed in
> - * @prop_name.
> + * If @prop_name is one, this function attempts to create fwnode links from the
> + * consumer device tree node @con_np to all the suppliers device tree nodes
> + * listed in @prop_name.
>   *
> - * Any failed attempt to create a device link will NOT result in an immediate
> + * Any failed attempt to create a fwnode link will NOT result in an immediate
>   * return.  of_link_property() must create links to all the available supplier
> - * devices even when attempts to create a link to one or more suppliers fail.
> + * device tree nodes even when attempts to create a link to one or more
> + * suppliers fail.
>   */
> -static int of_link_property(struct device *dev, struct device_node *con_np,
> -			     const char *prop_name)
> +static int of_link_property(struct device_node *con_np, const char *prop_name)
>  {
>  	struct device_node *phandle;
>  	const struct supplier_bindings *s = of_supplier_bindings;
>  	unsigned int i = 0;
>  	bool matched = false;
>  	int ret = 0;
> -	u32 dl_flags;
> -
> -	if (dev->of_node == con_np)
> -		dl_flags = fw_devlink_get_flags();
> -	else
> -		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
>  
>  	/* Do not stop at first failed link, link all available suppliers. */
>  	while (!matched && s->parse_prop) {
>  		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
>  			matched = true;
>  			i++;
> -			if (of_link_to_phandle(dev, phandle, dl_flags)
> -								== -EAGAIN)
> -				ret = -EAGAIN;
> +			of_link_to_phandle(con_np, phandle);
>  			of_node_put(phandle);
>  		}
>  		s++;
> @@ -1399,31 +1343,19 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
>  	return ret;
>  }
>  
> -static int of_link_to_suppliers(struct device *dev,
> -				  struct device_node *con_np)
> +static int of_fwnode_add_links(struct fwnode_handle *fwnode,
> +			       struct device *dev)
>  {
> -	struct device_node *child;
>  	struct property *p;
> -	int ret = 0;
> +	struct device_node *con_np = to_of_node(fwnode);
>  
> -	for_each_property_of_node(con_np, p)
> -		if (of_link_property(dev, con_np, p->name))
> -			ret = -ENODEV;
> -
> -	for_each_available_child_of_node(con_np, child)
> -		if (of_link_to_suppliers(dev, child) && !ret)
> -			ret = -EAGAIN;
> -
> -	return ret;
> -}
> +	if (unlikely(!con_np))
> +		return -EINVAL;

Can you prove that unlikely() results in faster code?  If not, don't use
it.

And the only way it can be NULL is if fwnode is NULL, and as you control
the callers to it, how can that be the case?

thanks,

greg k-h
