Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0E2D48B7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Dec 2020 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgLISPj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Dec 2020 13:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731866AbgLISPj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Dec 2020 13:15:39 -0500
Date:   Wed, 9 Dec 2020 19:16:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607537698;
        bh=Awgb97eqMBhLF2z692oQRlyuDrGF+9hPTYxSsdle5bA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0PaQLP6use6Dz/Xo4q+WevXeigi0daf/C/knM3UQ5XhYuOFNjPo8xFgM2DSu3cZx
         GCMLSFEf1C/ASc63Chak8CwVO/V80jSRzdqDe2wZUWf1EXG17XlAx87NKAchGuL/20
         XWG80R7mN+rWEbVOJytVmM5Khg4lTm2Vb/LYAt7Q=
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
Subject: Re: [PATCH v2 00/17] Refactor fw_devlink to significantly improve
 boot time
Message-ID: <X9EUbji0tILG6PvX@kroah.com>
References: <20201121020232.908850-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 20, 2020 at 06:02:15PM -0800, Saravana Kannan wrote:
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
> Laurent and Grygorii tested the v1 series and they saw boot time
> improvment of about 12 seconds and 3 seconds, respectively.

Now queued up to my tree.  Note, I had to hand-apply patches 13 and 16
due to some reason (for 13, I have no idea, for 16 it was due to a
previous patch applied to my tree that I cc:ed you on.)

Verifying I got it all correct would be great :)

thanks,

greg k-h
