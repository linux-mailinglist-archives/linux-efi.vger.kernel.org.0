Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF22D7B12
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgLKQfx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 11:35:53 -0500
Received: from foss.arm.com ([217.140.110.172]:39252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgLKQf0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Dec 2020 11:35:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844A031B;
        Fri, 11 Dec 2020 08:34:37 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82CC3F66B;
        Fri, 11 Dec 2020 08:34:33 -0800 (PST)
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
To:     Qian Cai <qcai@redhat.com>, Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel-team@android.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-17-saravanak@google.com>
 <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com>
Date:   Fri, 11 Dec 2020 16:34:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-12-11 14:11, Qian Cai wrote:
> On Fri, 2020-11-20 at 18:02 -0800, Saravana Kannan wrote:
>> The current implementation of fw_devlink is very inefficient because it
>> tries to get away without creating fwnode links in the name of saving
>> memory usage. Past attempts to optimize runtime at the cost of memory
>> usage were blocked with request for data showing that the optimization
>> made significant improvement for real world scenarios.
>>
>> We have those scenarios now. There have been several reports of boot
>> time increase in the order of seconds in this thread [1]. Several OEMs
>> and SoC manufacturers have also privately reported significant
>> (350-400ms) increase in boot time due to all the parsing done by
>> fw_devlink.
>>
>> So this patch uses all the setup done by the previous patches in this
>> series to refactor fw_devlink to be more efficient. Most of the code has
>> been moved out of firmware specific (DT mostly) code into driver core.
>>
>> This brings the following benefits:
>> - Instead of parsing the device tree multiple times during bootup,
>>    fw_devlink parses each fwnode node/property only once and creates
>>    fwnode links. The rest of the fw_devlink code then just looks at these
>>    fwnode links to do rest of the work.
>>
>> - Makes it much easier to debug probe issue due to fw_devlink in the
>>    future. fw_devlink=on blocks the probing of devices if they depend on
>>    a device that hasn't been added yet. With this refactor, it'll be very
>>    easy to tell what that device is because we now have a reference to
>>    the fwnode of the device.
>>
>> - Much easier to add fw_devlink support to ACPI and other firmware
>>    types. A refactor to move the common bits from DT specific code to
>>    driver core was in my TODO list as a prerequisite to adding ACPI
>>    support to fw_devlink. This series gets that done.
>>
>> [1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Reverting this commit and its dependency:
> 
> 2d09e6eb4a6f driver core: Delete pointless parameter in fwnode_operations.add_links
> 
> from today's linux-next fixed a boot crash on an arm64 Thunder X2 server.

Since the call stack implicates the platform-device-wrangling we do in 
IORT code I took a quick look; AFAICS my guess would be it's blowing up 
trying to walk a zeroed list head since "driver core: Add fwnode_init()" 
missed acpi_alloc_fwnode_static().

Robin.

> .config: https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> 
> [   57.413929][    T1] ACPI: 5 ACPI AML tables successfully acquired and loaded
> [   60.571643][    T1] ACPI: Interpreter enabled
> [   60.576104][    T1] ACPI: Using GIC for interrupt routing
> [   60.582474][    T1] ACPI: MCFG table detected, 1 entries
> [   60.588051][    T1] ACPI: IORT: SMMU-v3[402300000] Mapped to Proximity domain 0
> [   60.601374][    T1] Unable to handle kernel paging request at virtual address dfff800000000000
> [   60.610146][    T1] Mem abort info:
> [   60.613694][    T1]   ESR = 0x96000004
> [   60.617496][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   60.623616][    T1]   SET = 0, FnV = 0
> [   60.627420][    T1]   EA = 0, S1PTW = 0
> [   60.631304][    T1] Data abort info:
> [   60.634957][    T1]   ISV = 0, ISS = 0x00000004
> [   60.639546][    T1]   CM = 0, WnR = 0
> [   60.643255][    T1] [dfff800000000000] address between user and kernel address ranges
> [   60.651226][    T1] Internal error: Oops: 96000004 [#1] SMP
> [   60.656864][    T1] Modules linked in:
> [   60.660658][    T1] CPU: 38 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc7-next-20201211 #2
> [   60.670424][    T1] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020
> [   60.680979][    T1] pstate: 10400009 (nzcV daif +PAN -UAO -TCO BTYPE=--)
> [   60.687757][    T1] pc : device_add+0xf60/0x16b0
> [   60.692430][    T1] lr : device_add+0xf08/0x16b0
> [   60.697098][    T1] sp : ffff0000063bf7d0
> [   60.701147][    T1] x29: ffff0000063bf7d0 x28: ffff00001f760810
> [   60.707226][    T1] x27: fffffffffffffff8 x26: ffff00001f760858
> [   60.713304][    T1] x25: ffff00001f760c58 x24: fffffffffffffff8
> [   60.719381][    T1] x23: 1fffe00003eec10b x22: ffff8000190d0260
> [   60.725458][    T1] x21: ffff800011dba708 x20: 0000000000000000
> [   60.731535][    T1] x19: 1fffe00000c77f10 x18: 1fffe001cf0d53ed
> [   60.737616][    T1] x17: 0000000000000000 x16: 1ffff000033676f1
> [   60.743709][    T1] x15: 0000000000000000 x14: ffff800011731e34
> [   60.749786][    T1] x13: ffff700003217fb9 x12: 1ffff00003217fb8
> [   60.755864][    T1] x11: 1ffff00003217fb8 x10: ffff700003217fb8
> [   60.761940][    T1] x9 : dfff800000000000 x8 : ffff8000190bfdc7
> [   60.768017][    T1] x7 : 0000000000000001 x6 : ffff700003217fb9
> [   60.774094][    T1] x5 : ffff700003217fb9 x4 : ffff000006324a80
> [   60.780170][    T1] x3 : 1fffe00000c64951 x2 : 0000000000000000
> [   60.786247][    T1] x1 : 0000000000000000 x0 : dfff800000000000
> [   60.792324][    T1] Call trace:
> [   60.795495][    T1]  device_add+0xf60/0x16b0
> __fw_devlink_link_to_consumers at drivers/base/core.c:1583
> (inlined by) fw_devlink_link_device at drivers/base/core.c:1726
> (inlined by) device_add at drivers/base/core.c:3088
> [   60.799813][    T1]  platform_device_add+0x274/0x628
> [   60.804833][    T1]  acpi_iort_init+0x9d8/0xc50
> [   60.809415][    T1]  acpi_init+0x45c/0x4e8
> [   60.813556][    T1]  do_one_initcall+0x170/0xb70
> [   60.818224][    T1]  kernel_init_freeable+0x6a8/0x734
> [   60.823332][    T1]  kernel_init+0x18/0x12c
> [   60.827566][    T1]  ret_from_fork+0x10/0x1c
> [   60.831890][    T1] Code: f2fbffe0 d100205b d343fc41 aa1b03f8 (38e06820)
> [   60.838756][    T1] ---[ end trace fa5c8ce17a226d83 ]---
> [   60.844127][    T1] Kernel panic - not syncing: Oops: Fatal exception
> [   60.850881][    T1] SMP: stopping secondary CPUs
> [   60.855733][    T1] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
>> ---
>>   drivers/base/core.c    | 325 ++++++++++++++++++++++++++++++-----------
>>   include/linux/device.h |   5 -
>>   2 files changed, 238 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 1873cecb0cc4..9edf9084fc98 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -46,8 +46,6 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>>   #endif
>>   
>>   /* Device links support. */
>> -static LIST_HEAD(wait_for_suppliers);
>> -static DEFINE_MUTEX(wfs_lock);
>>   static LIST_HEAD(deferred_sync);
>>   static unsigned int defer_sync_state_count = 1;
>>   static DEFINE_MUTEX(fwnode_link_lock);
>> @@ -803,74 +801,6 @@ struct device_link *device_link_add(struct device *consumer,
>>   }
>>   EXPORT_SYMBOL_GPL(device_link_add);
>>   
>> -/**
>> - * device_link_wait_for_supplier - Add device to wait_for_suppliers list
>> - * @consumer: Consumer device
>> - *
>> - * Marks the @consumer device as waiting for suppliers to become available by
>> - * adding it to the wait_for_suppliers list. The consumer device will never be
>> - * probed until it's removed from the wait_for_suppliers list.
>> - *
>> - * The caller is responsible for adding the links to the supplier devices once
>> - * they are available and removing the @consumer device from the
>> - * wait_for_suppliers list once links to all the suppliers have been created.
>> - *
>> - * This function is NOT meant to be called from the probe function of the
>> - * consumer but rather from code that creates/adds the consumer device.
>> - */
>> -static void device_link_wait_for_supplier(struct device *consumer,
>> -					  bool need_for_probe)
>> -{
>> -	mutex_lock(&wfs_lock);
>> -	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
>> -	consumer->links.need_for_probe = need_for_probe;
>> -	mutex_unlock(&wfs_lock);
>> -}
>> -
>> -static void device_link_wait_for_mandatory_supplier(struct device *consumer)
>> -{
>> -	device_link_wait_for_supplier(consumer, true);
>> -}
>> -
>> -static void device_link_wait_for_optional_supplier(struct device *consumer)
>> -{
>> -	device_link_wait_for_supplier(consumer, false);
>> -}
>> -
>> -/**
>> - * device_link_add_missing_supplier_links - Add links from consumer devices to
>> - *					    supplier devices, leaving any
>> - *					    consumer with inactive suppliers on
>> - *					    the wait_for_suppliers list
>> - *
>> - * Loops through all consumers waiting on suppliers and tries to add all their
>> - * supplier links. If that succeeds, the consumer device is removed from
>> - * wait_for_suppliers list. Otherwise, they are left in the wait_for_suppliers
>> - * list.  Devices left on the wait_for_suppliers list will not be probed.
>> - *
>> - * The fwnode add_links callback is expected to return 0 if it has found and
>> - * added all the supplier links for the consumer device. It should return an
>> - * error if it isn't able to do so.
>> - *
>> - * The caller of device_link_wait_for_supplier() is expected to call this once
>> - * it's aware of potential suppliers becoming available.
>> - */
>> -static void device_link_add_missing_supplier_links(void)
>> -{
>> -	struct device *dev, *tmp;
>> -
>> -	mutex_lock(&wfs_lock);
>> -	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
>> -				 links.needs_suppliers) {
>> -		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
>> -		if (!ret)
>> -			list_del_init(&dev->links.needs_suppliers);
>> -		else if (ret != -ENODEV)
>> -			dev->links.need_for_probe = false;
>> -	}
>> -	mutex_unlock(&wfs_lock);
>> -}
>> -
>>   #ifdef CONFIG_SRCU
>>   static void __device_link_del(struct kref *kref)
>>   {
>> @@ -1195,9 +1125,8 @@ void device_links_driver_bound(struct device *dev)
>>   	 * the device links it needs to or make new device links as it needs
>>   	 * them. So, it no longer needs to wait on any suppliers.
>>   	 */
>> -	mutex_lock(&wfs_lock);
>> -	list_del_init(&dev->links.needs_suppliers);
>> -	mutex_unlock(&wfs_lock);
>> +	if (dev->fwnode && dev->fwnode->dev == dev)
>> +		fwnode_links_purge_suppliers(dev->fwnode);
>>   	device_remove_file(dev, &dev_attr_waiting_for_supplier);
>>   
>>   	device_links_write_lock();
>> @@ -1488,10 +1417,6 @@ static void device_links_purge(struct device *dev)
>>   	if (dev->class == &devlink_class)
>>   		return;
>>   
>> -	mutex_lock(&wfs_lock);
>> -	list_del(&dev->links.needs_suppliers);
>> -	mutex_unlock(&wfs_lock);
>> -
>>   	/*
>>   	 * Delete all of the remaining links from this device to any other
>>   	 * devices (either consumers or suppliers).
>> @@ -1561,19 +1486,246 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
>>   		fw_devlink_parse_fwtree(child);
>>   }
>>   
>> -static void fw_devlink_link_device(struct device *dev)
>> +/**
>> + * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
>> + * @con - Consumer device for the device link
>> + * @sup_handle - fwnode handle of supplier
>> + *
>> + * This function will try to create a device link between the consumer device
>> + * @con and the supplier device represented by @sup_handle.
>> + *
>> + * The supplier has to be provided as a fwnode because incorrect cycles in
>> + * fwnode links can sometimes cause the supplier device to never be created.
>> + * This function detects such cases and returns an error if it cannot create a
>> + * device link from the consumer to a missing supplier.
>> + *
>> + * Returns,
>> + * 0 on successfully creating a device link
>> + * -EINVAL if the device link cannot be created as expected
>> + * -EAGAIN if the device link cannot be created right now, but it may be
>> + *  possible to do that in the future
>> + */
>> +static int fw_devlink_create_devlink(struct device *con,
>> +				     struct fwnode_handle *sup_handle, u32 flags)
>> +{
>> +	struct device *sup_dev;
>> +	int ret = 0;
>> +
>> +	sup_dev = get_dev_from_fwnode(sup_handle);
>> +	if (sup_dev) {
>> +		/*
>> +		 * If this fails, it is due to cycles in device links.  Just
>> +		 * give up on this link and treat it as invalid.
>> +		 */
>> +		if (!device_link_add(con, sup_dev, flags))
>> +			ret = -EINVAL;
>> +
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
>> +	 * cycles. So cycle detection isn't necessary and shouldn't be
>> +	 * done.
>> +	 */
>> +	if (flags & DL_FLAG_SYNC_STATE_ONLY)
>> +		return -EAGAIN;
>> +
>> +	/*
>> +	 * If we can't find the supplier device from its fwnode, it might be
>> +	 * due to a cyclic dependency between fwnodes. Some of these cycles can
>> +	 * be broken by applying logic. Check for these types of cycles and
>> +	 * break them so that devices in the cycle probe properly.
>> +	 *
>> +	 * If the supplier's parent is dependent on the consumer, then
>> +	 * the consumer-supplier dependency is a false dependency. So,
>> +	 * treat it as an invalid link.
>> +	 */
>> +	sup_dev = fwnode_get_next_parent_dev(sup_handle);
>> +	if (sup_dev && device_is_dependent(con, sup_dev)) {
>> +		dev_dbg(con, "Not linking to %pfwP - False link\n",
>> +			sup_handle);
>> +		ret = -EINVAL;
>> +	} else {
>> +		/*
>> +		 * Can't check for cycles or no cycles. So let's try
>> +		 * again later.
>> +		 */
>> +		ret = -EAGAIN;
>> +	}
>> +
>> +out:
>> +	put_device(sup_dev);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * __fw_devlink_link_to_consumers - Create device links to consumers of a device
>> + * @dev - Device that needs to be linked to its consumers
>> + *
>> + * This function looks at all the consumer fwnodes of @dev and creates device
>> + * links between the consumer device and @dev (supplier).
>> + *
>> + * If the consumer device has not been added yet, then this function creates a
>> + * SYNC_STATE_ONLY link between @dev (supplier) and the closest ancestor device
>> + * of the consumer fwnode. This is necessary to make sure @dev doesn't get a
>> + * sync_state() callback before the real consumer device gets to be added and
>> + * then probed.
>> + *
>> + * Once device links are created from the real consumer to @dev (supplier), the
>> + * fwnode links are deleted.
>> + */
>> +static void __fw_devlink_link_to_consumers(struct device *dev)
>> +{
>> +	struct fwnode_handle *fwnode = dev->fwnode;
>> +	struct fwnode_link *link, *tmp;
>> +
>> +	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
>> +		u32 dl_flags = fw_devlink_get_flags();
>> +		struct device *con_dev;
>> +		bool own_link = true;
>> +		int ret;
>> +
>> +		con_dev = get_dev_from_fwnode(link->consumer);
>> +		/*
>> +		 * If consumer device is not available yet, make a "proxy"
>> +		 * SYNC_STATE_ONLY link from the consumer's parent device to
>> +		 * the supplier device. This is necessary to make sure the
>> +		 * supplier doesn't get a sync_state() callback before the real
>> +		 * consumer can create a device link to the supplier.
>> +		 *
>> +		 * This proxy link step is needed to handle the case where the
>> +		 * consumer's parent device is added before the supplier.
>> +		 */
>> +		if (!con_dev) {
>> +			con_dev = fwnode_get_next_parent_dev(link->consumer);
>> +			/*
>> +			 * However, if the consumer's parent device is also the
>> +			 * parent of the supplier, don't create a
>> +			 * consumer-supplier link from the parent to its child
>> +			 * device. Such a dependency is impossible.
>> +			 */
>> +			if (con_dev &&
>> +			    fwnode_is_ancestor_of(con_dev->fwnode, fwnode)) {
>> +				put_device(con_dev);
>> +				con_dev = NULL;
>> +			} else {
>> +				own_link = false;
>> +				dl_flags = DL_FLAG_SYNC_STATE_ONLY;
>> +			}
>> +		}
>> +
>> +		if (!con_dev)
>> +			continue;
>> +
>> +		ret = fw_devlink_create_devlink(con_dev, fwnode, dl_flags);
>> +		put_device(con_dev);
>> +		if (!own_link || ret == -EAGAIN)
>> +			continue;
>> +
>> +		list_del(&link->s_hook);
>> +		list_del(&link->c_hook);
>> +		kfree(link);
>> +	}
>> +}
>> +
>> +/**
>> + * __fw_devlink_link_to_suppliers - Create device links to suppliers of a device
>> + * @dev - The consumer device that needs to be linked to its suppliers
>> + * @fwnode - Root of the fwnode tree that is used to create device links
>> + *
>> + * This function looks at all the supplier fwnodes of fwnode tree rooted at
>> + * @fwnode and creates device links between @dev (consumer) and all the
>> + * supplier devices of the entire fwnode tree at @fwnode.
>> + *
>> + * The function creates normal (non-SYNC_STATE_ONLY) device links between @dev
>> + * and the real suppliers of @dev. Once these device links are created, the
>> + * fwnode links are deleted. When such device links are successfully created,
>> + * this function is called recursively on those supplier devices. This is
>> + * needed to detect and break some invalid cycles in fwnode links.  See
>> + * fw_devlink_create_devlink() for more details.
>> + *
>> + * In addition, it also looks at all the suppliers of the entire fwnode tree
>> + * because some of the child devices of @dev that have not been added yet
>> + * (because @dev hasn't probed) might already have their suppliers added to
>> + * driver core. So, this function creates SYNC_STATE_ONLY device links between
>> + * @dev (consumer) and these suppliers to make sure they don't execute their
>> + * sync_state() callbacks before these child devices have a chance to create
>> + * their device links. The fwnode links that correspond to the child devices
>> + * aren't delete because they are needed later to create the device links
>> + * between the real consumer and supplier devices.
>> + */
>> +static void __fw_devlink_link_to_suppliers(struct device *dev,
>> +					   struct fwnode_handle *fwnode)
>>   {
>> -	int fw_ret;
>> +	bool own_link = (dev->fwnode == fwnode);
>> +	struct fwnode_link *link, *tmp;
>> +	struct fwnode_handle *child = NULL;
>> +	u32 dl_flags;
>> +
>> +	if (own_link)
>> +		dl_flags = fw_devlink_get_flags();
>> +	else
>> +		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
>>   
>> -	device_link_add_missing_supplier_links();
>> +	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
>> +		int ret;
>> +		struct device *sup_dev;
>> +		struct fwnode_handle *sup = link->supplier;
>> +
>> +		ret = fw_devlink_create_devlink(dev, sup, dl_flags);
>> +		if (!own_link || ret == -EAGAIN)
>> +			continue;
>>   
>> -	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
>> -		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
>> -		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
>> -			device_link_wait_for_mandatory_supplier(dev);
>> -		else if (fw_ret)
>> -			device_link_wait_for_optional_supplier(dev);
>> +		list_del(&link->s_hook);
>> +		list_del(&link->c_hook);
>> +		kfree(link);
>> +
>> +		/* If no device link was created, nothing more to do. */
>> +		if (ret)
>> +			continue;
>> +
>> +		/*
>> +		 * If a device link was successfully created to a supplier, we
>> +		 * now need to try and link the supplier to all its suppliers.
>> +		 *
>> +		 * This is needed to detect and delete false dependencies in
>> +		 * fwnode links that haven't been converted to a device link
>> +		 * yet. See comments in fw_devlink_create_devlink() for more
>> +		 * details on the false dependency.
>> +		 *
>> +		 * Without deleting these false dependencies, some devices will
>> +		 * never probe because they'll keep waiting for their false
>> +		 * dependency fwnode links to be converted to device links.
>> +		 */
>> +		sup_dev = get_dev_from_fwnode(sup);
>> +		__fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
>> +		put_device(sup_dev);
>>   	}
>> +
>> +	/*
>> +	 * Make "proxy" SYNC_STATE_ONLY device links to represent the needs of
>> +	 * all the descendants. This proxy link step is needed to handle the
>> +	 * case where the supplier is added before the consumer's parent device
>> +	 * (@dev).
>> +	 */
>> +	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
>> +		__fw_devlink_link_to_suppliers(dev, child);
>> +}
>> +
>> +static void fw_devlink_link_device(struct device *dev)
>> +{
>> +	struct fwnode_handle *fwnode = dev->fwnode;
>> +
>> +	if (!fw_devlink_flags)
>> +		return;
>> +
>> +	fw_devlink_parse_fwtree(fwnode);
>> +
>> +	mutex_lock(&fwnode_link_lock);
>> +	__fw_devlink_link_to_consumers(dev);
>> +	__fw_devlink_link_to_suppliers(dev, fwnode);
>> +	mutex_unlock(&fwnode_link_lock);
>>   }
>>   
>>   /* Device links support end. */
>> @@ -2431,7 +2583,6 @@ void device_initialize(struct device *dev)
>>   #endif
>>   	INIT_LIST_HEAD(&dev->links.consumers);
>>   	INIT_LIST_HEAD(&dev->links.suppliers);
>> -	INIT_LIST_HEAD(&dev->links.needs_suppliers);
>>   	INIT_LIST_HEAD(&dev->links.defer_sync);
>>   	dev->links.status = DL_DEV_NO_DRIVER;
>>   }
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 1e771ea4dca6..89bb8b84173e 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -351,18 +351,13 @@ enum dl_dev_state {
>>    * struct dev_links_info - Device data related to device links.
>>    * @suppliers: List of links to supplier devices.
>>    * @consumers: List of links to consumer devices.
>> - * @needs_suppliers: Hook to global list of devices waiting for suppliers.
>>    * @defer_sync: Hook to global list of devices that have deferred sync_state.
>> - * @need_for_probe: If needs_suppliers is on a list, this indicates if the
>> - *		    suppliers are needed for probe or not.
>>    * @status: Driver status information.
>>    */
>>   struct dev_links_info {
>>   	struct list_head suppliers;
>>   	struct list_head consumers;
>> -	struct list_head needs_suppliers;
>>   	struct list_head defer_sync;
>> -	bool need_for_probe;
>>   	enum dl_dev_state status;
>>   };
>>   
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
