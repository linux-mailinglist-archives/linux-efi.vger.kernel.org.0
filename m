Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867802D017F
	for <lists+linux-efi@lfdr.de>; Sun,  6 Dec 2020 08:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLFHt0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Dec 2020 02:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgLFHtZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 6 Dec 2020 02:49:25 -0500
Date:   Sun, 6 Dec 2020 09:48:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607240924;
        bh=9RVRjkcvVquBMHyd3Wc3YEmznoMGzbtr/AV76Fx0Tz8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTxMmt4twoBw6wAl3BBQFHmmQfMShJO0R/dgxuZ6/6p2g1hsRUuNd3q2Zeu186GBQ
         IU4tNhTvARUxceZ7XeE55FxFaez+KWXQ55L/xnTYj58sdYAxvX2MeT9aqZcbwePXEV
         1yzrpblL7yjIuyLbr9Yb/Uba5iojEuxUFIuddXoXDVZZ03+Khre/SjqiPgXW980nEY
         npQOWuImlR1AQjGBYQkM1FaIzGcJz+AQH8yxvf1cLOvVNuDHzTL+Zf2dfxC3F1sB3u
         ZEOWOfAhoHWFajTAAPCRhdO/8bBuH78eXFOLLCwZ720bbg7qImONlmmj61hC3w/vlf
         2mBqqSU3GLGbA==
From:   Leon Romanovsky <leon@kernel.org>
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/17] driver core: Add fwnode link support
Message-ID: <20201206074840.GB687065@unreal>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-9-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-9-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 20, 2020 at 06:02:23PM -0800, Saravana Kannan wrote:
> Add support for creating supplier-consumer links between fwnodes.  It is
> intended for internal use the driver core and generic firmware support
> code (eg. Device Tree, ACPI), so it is simple by design and the API
> provided is limited.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 98 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/dynamic.c   |  1 +
>  include/linux/fwnode.h | 14 ++++++
>  3 files changed, 113 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 401fa7e3505c..e2b246a44d1a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -50,6 +50,104 @@ static LIST_HEAD(wait_for_suppliers);
>  static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
> +static DEFINE_MUTEX(fwnode_link_lock);
> +
> +/**
> + * fwnode_link_add - Create a link between two fwnode_handles.
> + * @con: Consumer end of the link.
> + * @sup: Supplier end of the link.
> + *
> + * Create a fwnode link between fwnode handles @con and @sup. The fwnode link
> + * represents the detail that the firmware lists @sup fwnode as supplying a
> + * resource to @con.
> + *
> + * The driver core will use the fwnode link to create a device link between the
> + * two device objects corresponding to @con and @sup when they are created. The
> + * driver core will automatically delete the fwnode link between @con and @sup
> + * after doing that.
> + *
> + * Attempts to create duplicate links between the same pair of fwnode handles
> + * are ignored and there is no reference counting.

Sorry to ask, but why is that?
Isn't this a programmer error?

Thanks
