Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7482D7D99
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbgLKSE0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 13:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388652AbgLKSD6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Dec 2020 13:03:58 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305DF23D3C;
        Fri, 11 Dec 2020 18:03:17 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knml9-000Wtq-4f; Fri, 11 Dec 2020 18:03:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Dec 2020 18:03:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Qian Cai <qcai@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
In-Reply-To: <CAGETcx-MsNyWWT=s1H6hDK+=QvibBLQrT9rM51y5bkomV_+G6g@mail.gmail.com>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-17-saravanak@google.com>
 <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com>
 <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com>
 <CAGETcx-MsNyWWT=s1H6hDK+=QvibBLQrT9rM51y5bkomV_+G6g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <813b3fbd80ad4dfee7ff8517d4829a1f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, robin.murphy@arm.com, qcai@redhat.com, rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org, ardb@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com, tglx@linutronix.de, devicetree@vger.kernel.org, grygorii.strashko@ti.com, sfr@canb.auug.org.au, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, kernel-team@android.com, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-12-11 17:51, Saravana Kannan wrote:
> On Fri, Dec 11, 2020 at 8:34 AM Robin Murphy <robin.murphy@arm.com> 
> wrote:
>> 
>> On 2020-12-11 14:11, Qian Cai wrote:
>> > On Fri, 2020-11-20 at 18:02 -0800, Saravana Kannan wrote:
>> >> The current implementation of fw_devlink is very inefficient because it
>> >> tries to get away without creating fwnode links in the name of saving
>> >> memory usage. Past attempts to optimize runtime at the cost of memory
>> >> usage were blocked with request for data showing that the optimization
>> >> made significant improvement for real world scenarios.
>> >>
>> >> We have those scenarios now. There have been several reports of boot
>> >> time increase in the order of seconds in this thread [1]. Several OEMs
>> >> and SoC manufacturers have also privately reported significant
>> >> (350-400ms) increase in boot time due to all the parsing done by
>> >> fw_devlink.
>> >>
>> >> So this patch uses all the setup done by the previous patches in this
>> >> series to refactor fw_devlink to be more efficient. Most of the code has
>> >> been moved out of firmware specific (DT mostly) code into driver core.
>> >>
>> >> This brings the following benefits:
>> >> - Instead of parsing the device tree multiple times during bootup,
>> >>    fw_devlink parses each fwnode node/property only once and creates
>> >>    fwnode links. The rest of the fw_devlink code then just looks at these
>> >>    fwnode links to do rest of the work.
>> >>
>> >> - Makes it much easier to debug probe issue due to fw_devlink in the
>> >>    future. fw_devlink=on blocks the probing of devices if they depend on
>> >>    a device that hasn't been added yet. With this refactor, it'll be very
>> >>    easy to tell what that device is because we now have a reference to
>> >>    the fwnode of the device.
>> >>
>> >> - Much easier to add fw_devlink support to ACPI and other firmware
>> >>    types. A refactor to move the common bits from DT specific code to
>> >>    driver core was in my TODO list as a prerequisite to adding ACPI
>> >>    support to fw_devlink. This series gets that done.
>> >>
>> >> [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
>> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> >> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> >> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> >
>> > Reverting this commit and its dependency:
>> >
>> > 2d09e6eb4a6f driver core: Delete pointless parameter in fwnode_operations.add_links
>> >
>> > from today's linux-next fixed a boot crash on an arm64 Thunder X2 server.
>> 
>> Since the call stack implicates the platform-device-wrangling we do in
>> IORT code I took a quick look; AFAICS my guess would be it's blowing 
>> up
>> trying to walk a zeroed list head since "driver core: Add 
>> fwnode_init()"
>> missed acpi_alloc_fwnode_static().
> 
> Thanks Robin. I'm pretty sure this is the reason. I thought I fixed
> all ACPI cases, but clearly I missed this one. I'll send out a patch
> for this today. If you think there are any other places I missed
> please let me know. I'll try some git grep foo to see if I missed any
> other instances of fwnode ops being set.

Yup, that fixed it here (QDF2400).

Thanks,

         M.

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..2630c2e953f7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -55,7 +55,7 @@ static inline struct fwnode_handle 
*acpi_alloc_fwnode_static(void)
  	if (!fwnode)
  		return NULL;

-	fwnode->ops = &acpi_static_fwnode_ops;
+	fwnode_init(fwnode, &acpi_static_fwnode_ops);

  	return fwnode;
  }



-- 
Jazz is not dead. It just smells funny...
