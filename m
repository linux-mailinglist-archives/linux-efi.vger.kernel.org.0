Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C492EC6E8
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jan 2021 00:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbhAFXbH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Jan 2021 18:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbhAFXbH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Jan 2021 18:31:07 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D501C061799
        for <linux-efi@vger.kernel.org>; Wed,  6 Jan 2021 15:30:27 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d37so4447446ybi.4
        for <linux-efi@vger.kernel.org>; Wed, 06 Jan 2021 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkZ+tBm9DJy8ILrpTit9EqnPMeCYXvm6a+UrRSokuhs=;
        b=cAtEsU2WvriyLKRIxXdYJMIUIVZec6582XfQBbHHAOb6DhuXKIOIzP38bL0ZlqryK0
         Fp1RopXcO2ZJAOjsxvIrsiKQQE2b95zNog8NeLYMBCuNZomVwRz2kkgmhxA/58NUasvj
         mqLCl7N7fyMSlS3TZD80IDFfikPZHs/GUOgVMAmIQW7cRODXc4EMia9m3MrbKmENh7VJ
         DcsmbgZARpWtoiOomEcm4R7qBiu7kz4u9tvb0VCbOTKgmvfb7ExWl1acnQCzH9E7HMbi
         DXy1LbSz6R/0rdcDPRsvvNFo74uqAjabwyBctz9apAmXiuTxmEvcaOR6QE7XLs9uXnIn
         FrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkZ+tBm9DJy8ILrpTit9EqnPMeCYXvm6a+UrRSokuhs=;
        b=T4NVHGiwoBniB2X0wwH9ZXPJpmLNpVSEDMcnVdzwXVj8e6gYR7LW7aItPKMc3NWuWF
         R5UNH8aMqY3Z33UuRTaHNyOs0/5inF1ZFnbv4XJaqZXLRwb0yapyWhenWNpc3fRfMiRS
         D/iTW7zU1vI5WJ2nHDnwKiP00ZD8Th1OxctuWPN/QTh01IdGGhWKucIhpNFyXIa53Ogg
         HSX7v1h6d/6KD24TK0JRbEh1uHgf9mDNKzlf4MNLWyPsOAsS5PsImUtlnJHugY6hgN7Y
         BWPgXIPnOZCXlLe1kVpYGZxTwa+iwS0DVcH0IKZLH3KTet3l2yS6sizZ8VavE5huhAoG
         tq+w==
X-Gm-Message-State: AOAM5328A6J/Dw5SVWPo9QS8GT1LlRs9oWP8V/fariS+N+YHyHUnHhSH
        bsrPyHmokVypSrJxOlQlpnadwpxM09i9VIgTUcVv1A==
X-Google-Smtp-Source: ABdhPJw3X2Ha3LvGtOc0eoki7udP2ibLrIlYCKWATc5it6dLO0bfZYAoOXHcWZ3ALwPhx/XELKxqeXl9RKRVODVQggg=
X-Received: by 2002:a25:d295:: with SMTP id j143mr10306287ybg.20.1609975826057;
 Wed, 06 Jan 2021 15:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-17-saravanak@google.com>
 <20201229033440.32142-1-michael@walle.cc> <CAGETcx8BNkvz=F7Z6HGRZyEcPcQGyJ1hneVMZ=mOeJ8hdbGt1A@mail.gmail.com>
 <6d5914f095556119f4a38def9297accd@walle.cc>
In-Reply-To: <6d5914f095556119f4a38def9297accd@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Jan 2021 15:29:50 -0800
Message-ID: <CAGETcx_taUrZc0LSZrT9WP5qBxiCfUJ=N9AGaFD87Pd+TJu8YA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
To:     Michael Walle <michael@walle.cc>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 5, 2021 at 1:04 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-01-05 20:00, schrieb Saravana Kannan:
> > On Mon, Dec 28, 2020 at 7:35 PM Michael Walle <michael@walle.cc> wrote:
> >>
> >> > The current implementation of fw_devlink is very inefficient because it
> >> > tries to get away without creating fwnode links in the name of saving
> >> > memory usage. Past attempts to optimize runtime at the cost of memory
> >> > usage were blocked with request for data showing that the optimization
> >> > made significant improvement for real world scenarios.
> >> >
> >> > We have those scenarios now. There have been several reports of boot
> >> > time increase in the order of seconds in this thread [1]. Several OEMs
> >> > and SoC manufacturers have also privately reported significant
> >> > (350-400ms) increase in boot time due to all the parsing done by
> >> > fw_devlink.
> >> >
> >> > So this patch uses all the setup done by the previous patches in this
> >> > series to refactor fw_devlink to be more efficient. Most of the code has
> >> > been moved out of firmware specific (DT mostly) code into driver core.
> >> >
> >> > This brings the following benefits:
> >> > - Instead of parsing the device tree multiple times during bootup,
> >> >   fw_devlink parses each fwnode node/property only once and creates
> >> >   fwnode links. The rest of the fw_devlink code then just looks at these
> >> >   fwnode links to do rest of the work.
> >> >
> >> > - Makes it much easier to debug probe issue due to fw_devlink in the
> >> >   future. fw_devlink=on blocks the probing of devices if they depend on
> >> >   a device that hasn't been added yet. With this refactor, it'll be very
> >> >   easy to tell what that device is because we now have a reference to
> >> >   the fwnode of the device.
> >> >
> >> > - Much easier to add fw_devlink support to ACPI and other firmware
> >> >   types. A refactor to move the common bits from DT specific code to
> >> >   driver core was in my TODO list as a prerequisite to adding ACPI
> >> >   support to fw_devlink. This series gets that done.
> >> >
> >> > [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
> >> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >>
> >> git bisect show that this commit broke my board in 5.11-rc1:
> >>
> >> [    2.294375] sysfs: cannot create duplicate filename
> >> '/devices/virtual/devlink/0000:00:00.1--0000:00:00.1'
> >> [    2.303999] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> >> 5.11.0-rc1-00016-ga0fb284b267 #267
> >> [    2.312125] Hardware name: Kontron SMARC-sAL28 (4 Lane) (DT)
> >> [    2.317804] Call trace:
> >> [    2.320253]  dump_backtrace+0x0/0x1b8
> >> [    2.323936]  show_stack+0x20/0x70
> >> [    2.327263]  dump_stack+0xd8/0x134
> >> [    2.330677]  sysfs_warn_dup+0x6c/0x88
> >> [    2.334351]  sysfs_create_dir_ns+0xe8/0x100
> >> [    2.338547]  kobject_add_internal+0x9c/0x290
> >> [    2.342833]  kobject_add+0xa0/0x108
> >> [    2.346331]  device_add+0xfc/0x798
> >> [    2.349746]  device_link_add+0x454/0x5e0
> >> [    2.353682]  fw_devlink_create_devlink+0xb8/0xc8
> >> [    2.358316]  __fw_devlink_link_to_suppliers+0x84/0x180
> >> [    2.363474]  __fw_devlink_link_to_suppliers+0x134/0x180
> >> [    2.368718]  device_add+0x778/0x798
> >> [    2.372217]  device_register+0x28/0x38
> >> [    2.375979]  __mdiobus_register+0x94/0x340
> >> [    2.380089]  of_mdiobus_register+0xb4/0x380
> >> [    2.384285]  enetc_pf_probe+0x73c/0xb10
> >> [    2.388132]  local_pci_probe+0x48/0xb8
> >> [    2.391896]  pci_device_probe+0x120/0x1c0
> >> [    2.395920]  really_probe+0xec/0x3c0
> >> [    2.399505]  driver_probe_device+0x60/0xc0
> >> [    2.403614]  device_driver_attach+0x7c/0x88
> >> [    2.407810]  __driver_attach+0x60/0xe8
> >> [    2.411570]  bus_for_each_dev+0x7c/0xd0
> >> [    2.415419]  driver_attach+0x2c/0x38
> >> [    2.419004]  bus_add_driver+0x194/0x1f8
> >> [    2.422851]  driver_register+0x6c/0x128
> >> [    2.426698]  __pci_register_driver+0x4c/0x58
> >> [    2.430983]  enetc_pf_driver_init+0x2c/0x38
> >> [    2.435181]  do_one_initcall+0x54/0x2d8
> >> [    2.439029]  kernel_init_freeable+0x1fc/0x268
> >> [    2.443403]  kernel_init+0x1c/0x120
> >> [    2.446904]  ret_from_fork+0x10/0x30
> >> [    2.450502] kobject_add_internal failed for
> >> 0000:00:00.1--0000:00:00.1 with -EEXIST, don't try to register things
> >> with the same name in the same directory.
> >>
> >> Looks like it will generate that link twice? Let me know if I can help
> >> testing.
> >>
> >> See also: https://lavalab.kontron.com/scheduler/job/3894#L831
> >
> > I'll look into this this week. Is the DT for this board in upstream?
> > If so, can you point me to the DT file(s)?
>
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
>
> > Also, can you give me the output of this?
> > find /sys/devices -type d | grep "0000:00:00.1"
>
> # uname -a
> Linux buildroot 5.11.0-rc1-next-20210104 #298 SMP PREEMPT Tue Jan 5
> 21:55:23 CET 2021 aarch64 GNU/Linux
> # find /sys/devices -type d | grep "0000:00:00.1"
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/statistics
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-6
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-6/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-4
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-4/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-7
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-2
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-2/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-5
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-0
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-0/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-3
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-1
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-7
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-7/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-5
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-5/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-3
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-3/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-6
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-1
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/tx-1/byte_queue_limits
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-4
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-2
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/net/eno1/queues/rx-0
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/statistics
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/statistics
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/regulator
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/regulator/regulator.3
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/regulator/regulator.3/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/regulator/regulator.4
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/regulator/regulator.4/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/mdio_bus/0000:00:00.1/0000:00:00.1:04/power
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/msi_irqs
> /sys/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/link
> /sys/devices/virtual/devlink/5000000.iommu--0000:00:00.1


Sent a fix. Any further discussion will most likely continue in that thread.
https://lore.kernel.org/lkml/20210106232641.459081-1-saravanak@google.com/T/#u

-Saravana
