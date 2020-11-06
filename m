Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617C52A8E94
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 06:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKFFJp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 00:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKFFJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Nov 2020 00:09:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F14C0613CF;
        Thu,  5 Nov 2020 21:09:45 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BE333D;
        Fri,  6 Nov 2020 06:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604639383;
        bh=72/KUrhMBGIoUetzc6guWYFWopnI5c0uHM8v4HvuRPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezicyJe3TH8q8Ejj8OJ4o9ti4tZBl8nP0nWdq3cOvkoDRGPrmeo4/M6VqLD7PYK44
         9UF8TtdfQpkYyEDrqEMG7KTEdsRoZGs5g8ssxNGacB5T1tVM05IYsjcpRedN3Auqs2
         QN7HhTIBAHZG/EsFOmyKA0hho5RSOtc5Rn93tW6Y=
Date:   Fri, 6 Nov 2020 07:09:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 00/18] Refactor fw_devlink to significantly improve
 boot time
Message-ID: <20201106050940.GG16469@pendragon.ideasonboard.com>
References: <20201104232356.4038506-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Saravana,

Thank you for working on this !

On Wed, Nov 04, 2020 at 03:23:37PM -0800, Saravana Kannan wrote:
> The current implementation of fw_devlink is very inefficient because it
> tries to get away without creating fwnode links in the name of saving
> memory usage. Past attempts to optimize runtime at the cost of memory
> usage were blocked with request for data showing that the optimization
> made significant improvement for real world scenarios.
> 
> We have those scenarios now. There have been several reports of boot
> time increase in the order of seconds in this thread [1]. Several OEMs
> and SoC manufacturers have also privately reported significant
> (350-400ms) increase in boot time due to all the parsing done by
> fw_devlink.
> 
> So this patch series refactors fw_devlink to be more efficient. The key
> difference now is the addition of support for fwnode links -- just a few
> simple APIs. This also allows most of the code to be moved out of
> firmware specific (DT mostly) code into driver core.
> 
> This brings the following benefits:
> - Instead of parsing the device tree multiple times (complexity was
>   close to O(N^3) where N in the number of properties) during bootup,
>   fw_devlink parses each fwnode node/property only once and creates
>   fwnode links. The rest of the fw_devlink code then just looks at these
>   fwnode links to do rest of the work.
> 
> - Makes it much easier to debug probe issue due to fw_devlink in the
>   future. fw_devlink=on blocks the probing of devices if they depend on
>   a device that hasn't been added yet. With this refactor, it'll be very
>   easy to tell what that device is because we now have a reference to
>   the fwnode of the device.
> 
> - Much easier to add fw_devlink support to ACPI and other firmware
>   types. A refactor to move the common bits from DT specific code to
>   driver core was in my TODO list as a prerequisite to adding ACPI
>   support to fw_devlink. This series gets that done.
> 
> Tomi/Laurent/Grygorii,
> 
> If you can test this series, that'd be great!

I gave it a try, rebasing my branch from v5.9 to v5.10-rc2 first. On
v5.10-rc2 the kernel dies when booting due to a deadlock (reported by
lockdep, so hopefully not too hard to debug). *sigh*. Fortunately, it
dies after the fw_devlink initialization, so I can still report results.

Before your series:

[    0.743065] cpuidle: using governor menu
[   13.350259] No ATAGs?

With your series applied:

[    0.722670] cpuidle: using governor menu
[    1.135859] No ATAGs?

That's a very clear improvement :-)

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> [1] - https://lore.kernel.org/linux-pm/CAGETcx-aiW251dhEXT1GNb9bi6YcX8W=jLBrro5CnPuEjGL09g@mail.gmail.com/
> 
> Saravana Kannan (18):
>   Revert "driver core: Avoid deferred probe due to fw_devlink_pause/resume()"
>   Revert "driver core: Rename dev_links_info.defer_sync to defer_hook"
>   Revert "driver core: Don't do deferred probe in parallel with kernel_init thread"
>   Revert "driver core: Remove check in driver_deferred_probe_force_trigger()"
>   Revert "of: platform: Batch fwnode parsing when adding all top level devices"
>   Revert "driver core: fw_devlink: Add support for batching fwnode parsing"
>   driver core: Add fwnode_init()
>   driver core: Add fwnode link support
>   driver core: Allow only unprobed consumers for SYNC_STATE_ONLY device links
>   device property: Add fwnode_is_ancestor_of()
>   driver core: Redefine the meaning of fwnode_operations.add_links()
>   driver core: Add fw_devlink_parse_fwtree()
>   driver core: Add fwnode_get_next_parent_dev() helper function
>   driver core: Use device's fwnode to check if it is waiting for suppliers
>   of: property: Update implementation of add_links() to create fwnode links
>   efi: Update implementation of add_links() to create fwnode links
>   driver core: Add helper functions to convert fwnode links to device links
>   driver core: Refactor fw_devlink feature
> 
>  drivers/acpi/property.c         |   2 +-
>  drivers/acpi/scan.c             |   2 +-
>  drivers/base/core.c             | 584 +++++++++++++++++++++-----------
>  drivers/base/property.c         |  27 ++
>  drivers/base/swnode.c           |   2 +-
>  drivers/firmware/efi/efi-init.c |  31 +-
>  drivers/of/dynamic.c            |   1 +
>  drivers/of/platform.c           |   2 -
>  drivers/of/property.c           | 150 +++-----
>  include/linux/device.h          |  10 +-
>  include/linux/fwnode.h          |  66 ++--
>  include/linux/of.h              |   2 +-
>  include/linux/property.h        |   2 +
>  kernel/irq/irqdomain.c          |   2 +-
>  14 files changed, 490 insertions(+), 393 deletions(-)

-- 
Regards,

Laurent Pinchart
