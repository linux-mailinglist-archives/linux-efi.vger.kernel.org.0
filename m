Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32D2E6DA6
	for <lists+linux-efi@lfdr.de>; Tue, 29 Dec 2020 04:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgL2DgD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Dec 2020 22:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgL2DgD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Dec 2020 22:36:03 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2536C0613D6;
        Mon, 28 Dec 2020 19:35:22 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E039722802;
        Tue, 29 Dec 2020 04:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609212919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNdJDbDl/05MujOD4qQl4/7GqexrrHvbmx1qNqivlSU=;
        b=WM/xtIyBLhf31SuCiZgFmRkU8AS6VdMxcUgA/+iMcr5GeIDX82oWeb+NHgHO8DXlam3F9r
        t8PwP2aDtrFNXpGL0vC7HcTLESRO5qWs1eYqqSWpuUmCHEN3wOHE6TvBp64bT/FHf775I6
        c2J5isdcP499j2aMyDW2ot/unbwI0sY=
From:   Michael Walle <michael@walle.cc>
To:     saravanak@google.com
Cc:     ardb@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        grygorii.strashko@ti.com, kernel-team@android.com,
        laurent.pinchart@ideasonboard.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, rafael@kernel.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, tglx@linutronix.de,
        tomi.valkeinen@ti.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
Date:   Tue, 29 Dec 2020 04:34:40 +0100
Message-Id: <20201229033440.32142-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201121020232.908850-17-saravanak@google.com>
References: <20201121020232.908850-17-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
> So this patch uses all the setup done by the previous patches in this
> series to refactor fw_devlink to be more efficient. Most of the code has
> been moved out of firmware specific (DT mostly) code into driver core.
> 
> This brings the following benefits:
> - Instead of parsing the device tree multiple times during bootup,
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
> [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

git bisect show that this commit broke my board in 5.11-rc1:

[    2.294375] sysfs: cannot create duplicate filename '/devices/virtual/devlink/0000:00:00.1--0000:00:00.1'
[    2.303999] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc1-00016-ga0fb284b267 #267
[    2.312125] Hardware name: Kontron SMARC-sAL28 (4 Lane) (DT)
[    2.317804] Call trace:
[    2.320253]  dump_backtrace+0x0/0x1b8
[    2.323936]  show_stack+0x20/0x70
[    2.327263]  dump_stack+0xd8/0x134
[    2.330677]  sysfs_warn_dup+0x6c/0x88
[    2.334351]  sysfs_create_dir_ns+0xe8/0x100
[    2.338547]  kobject_add_internal+0x9c/0x290
[    2.342833]  kobject_add+0xa0/0x108
[    2.346331]  device_add+0xfc/0x798
[    2.349746]  device_link_add+0x454/0x5e0
[    2.353682]  fw_devlink_create_devlink+0xb8/0xc8
[    2.358316]  __fw_devlink_link_to_suppliers+0x84/0x180
[    2.363474]  __fw_devlink_link_to_suppliers+0x134/0x180
[    2.368718]  device_add+0x778/0x798
[    2.372217]  device_register+0x28/0x38
[    2.375979]  __mdiobus_register+0x94/0x340
[    2.380089]  of_mdiobus_register+0xb4/0x380
[    2.384285]  enetc_pf_probe+0x73c/0xb10
[    2.388132]  local_pci_probe+0x48/0xb8
[    2.391896]  pci_device_probe+0x120/0x1c0
[    2.395920]  really_probe+0xec/0x3c0
[    2.399505]  driver_probe_device+0x60/0xc0
[    2.403614]  device_driver_attach+0x7c/0x88
[    2.407810]  __driver_attach+0x60/0xe8
[    2.411570]  bus_for_each_dev+0x7c/0xd0
[    2.415419]  driver_attach+0x2c/0x38
[    2.419004]  bus_add_driver+0x194/0x1f8
[    2.422851]  driver_register+0x6c/0x128
[    2.426698]  __pci_register_driver+0x4c/0x58
[    2.430983]  enetc_pf_driver_init+0x2c/0x38
[    2.435181]  do_one_initcall+0x54/0x2d8
[    2.439029]  kernel_init_freeable+0x1fc/0x268
[    2.443403]  kernel_init+0x1c/0x120
[    2.446904]  ret_from_fork+0x10/0x30
[    2.450502] kobject_add_internal failed for 0000:00:00.1--0000:00:00.1 with -EEXIST, don't try to register things with the same name in the same directory.

Looks like it will generate that link twice? Let me know if I can help
testing.

See also: https://lavalab.kontron.com/scheduler/job/3894#L831

-michael
