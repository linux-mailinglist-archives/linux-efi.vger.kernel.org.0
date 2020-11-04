Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FE2A7192
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbgKDXYs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733130AbgKDXYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120AC0613D6
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y11so368820ybm.22
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=orxE1MK+VCMR2ve5H0WDkTIY0N4gMeA6rHktC95zIcA=;
        b=nnx9jd2oJEhJ3pHwIgO16YDAqaTuilWdruK/2oSYX4gvUTTrKBszRrSEFZFu6TkeeC
         RDHPoO6yKDBTh66sk1OI4p5CAqWE5QunqsduHu6Xytct4qlbmErBEaoMxmU/R20qBu0u
         XZtY00GxvXtqpwMHgrl+PJx5MglPgvBZqnTJsbIjzUD0lnx9pHJe+QswXalrXDcH8fy0
         zJjCth/1qPRDL+uCAoHJjecCNlSljkn0oVcDx/BJUiQ5VcPGZltVwMdTIaaAXXrdTdBs
         fctL+Ume5aU3MimkcwHkrcEm66vVE5Uz3nVj/MGxrTDP0FNGi9r79pD+r0Xa+yRPlohe
         xrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=orxE1MK+VCMR2ve5H0WDkTIY0N4gMeA6rHktC95zIcA=;
        b=N7OE6h8zPCE1SzpTKLzs3eM2foPjYYxgZzdV+HKaZGDhz+gYiplqcsy/Lgd6aheiSM
         HCcx5YQbfWiiWtH9E3bU/g4cLyaQqsWItqG9/m1hFxZzALAGxPkYJbwQu96oO2P+J8cL
         BR3sFO/hExZ7SVJrxo3yp59Tco6oHYCOrd3dCuBsmX/3m/IyZmCYkKNkfONMWiMkTorh
         cUn/qNlVp0bvpm/rDvVn3ycSJiW4ScwtbYAzM3by6pnzcc/vPwoVhuYAC8GWY7b17qVL
         cALNEyImKDp97oz54jTKE+m1FmA7KpoiK9zLtjaXgZYssBNL59QbUs23QR6ee+lWO56R
         yjhg==
X-Gm-Message-State: AOAM532Ezl1ALRBsmRr2Q/EhVu8WLCJY4voqIsN/Jr7GXLA2J+/5w4e0
        OS3qqslHBYaNiTagAvXW3NX8RxgytcNK+ls=
X-Google-Smtp-Source: ABdhPJyMvwixP2xnnsuS7H+s5t5wu3FKZYhd1nRvOCSDaSPC3lScgr6okCR4XLH8GNPZ59R7lXmTwleaul7fN4o=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:59d5:: with SMTP id
 n204mr318723ybb.282.1604532285157; Wed, 04 Nov 2020 15:24:45 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:55 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-19-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 18/18] driver core: Refactor fw_devlink feature
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current implementation of fw_devlink is very inefficient because it
tries to get away without creating fwnode links in the name of saving
memory usage. Past attempts to optimize runtime at the cost of memory
usage were blocked with request for data showing that the optimization
made significant improvement for real world scenarios.

We have those scenarios now. There have been several reports of boot
time increase in the order of seconds in this thread [1]. Several OEMs
and SoC manufacturers have also privately reported significant
(350-400ms) increase in boot time due to all the parsing done by
fw_devlink.

So this patch uses all the setup done by the previous patches in this
series to refactor fw_devlink to be more efficient. Most of the code has
been moved out of firmware specific (DT mostly) code into driver core.

This brings the following benefits:
- Instead of parsing the device tree multiple times during bootup,
  fw_devlink parses each fwnode node/property only once and creates
  fwnode links. The rest of the fw_devlink code then just looks at these
  fwnode links to do rest of the work.

- Makes it much easier to debug probe issue due to fw_devlink in the
  future. fw_devlink=on blocks the probing of devices if they depend on
  a device that hasn't been added yet. With this refactor, it'll be very
  easy to tell what that device is because we now have a reference to
  the fwnode of the device.

- Much easier to add fw_devlink support to ACPI and other firmware
  types. A refactor to move the common bits from DT specific code to
  driver core was in my TODO list as a prerequisite to adding ACPI
  support to fw_devlink. This series gets that done.

[1] - https://lore.kernel.org/linux-omap/ea02f57e-871d-cd16-4418-c1da4bbc4696@ti.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 98 +++++-------------------------------------
 include/linux/device.h |  5 ---
 2 files changed, 11 insertions(+), 92 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0c87ff949d81..d76ca59252fb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,8 +46,6 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
 /* Device links support. */
-static LIST_HEAD(wait_for_suppliers);
-static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
@@ -800,74 +798,6 @@ struct device_link *device_link_add(struct device *consumer,
 }
 EXPORT_SYMBOL_GPL(device_link_add);
 
-/**
- * device_link_wait_for_supplier - Add device to wait_for_suppliers list
- * @consumer: Consumer device
- *
- * Marks the @consumer device as waiting for suppliers to become available by
- * adding it to the wait_for_suppliers list. The consumer device will never be
- * probed until it's removed from the wait_for_suppliers list.
- *
- * The caller is responsible for adding the links to the supplier devices once
- * they are available and removing the @consumer device from the
- * wait_for_suppliers list once links to all the suppliers have been created.
- *
- * This function is NOT meant to be called from the probe function of the
- * consumer but rather from code that creates/adds the consumer device.
- */
-static void device_link_wait_for_supplier(struct device *consumer,
-					  bool need_for_probe)
-{
-	mutex_lock(&wfs_lock);
-	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
-	consumer->links.need_for_probe = need_for_probe;
-	mutex_unlock(&wfs_lock);
-}
-
-static void device_link_wait_for_mandatory_supplier(struct device *consumer)
-{
-	device_link_wait_for_supplier(consumer, true);
-}
-
-static void device_link_wait_for_optional_supplier(struct device *consumer)
-{
-	device_link_wait_for_supplier(consumer, false);
-}
-
-/**
- * device_link_add_missing_supplier_links - Add links from consumer devices to
- *					    supplier devices, leaving any
- *					    consumer with inactive suppliers on
- *					    the wait_for_suppliers list
- *
- * Loops through all consumers waiting on suppliers and tries to add all their
- * supplier links. If that succeeds, the consumer device is removed from
- * wait_for_suppliers list. Otherwise, they are left in the wait_for_suppliers
- * list.  Devices left on the wait_for_suppliers list will not be probed.
- *
- * The fwnode add_links callback is expected to return 0 if it has found and
- * added all the supplier links for the consumer device. It should return an
- * error if it isn't able to do so.
- *
- * The caller of device_link_wait_for_supplier() is expected to call this once
- * it's aware of potential suppliers becoming available.
- */
-static void device_link_add_missing_supplier_links(void)
-{
-	struct device *dev, *tmp;
-
-	mutex_lock(&wfs_lock);
-	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
-				 links.needs_suppliers) {
-		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (!ret)
-			list_del_init(&dev->links.needs_suppliers);
-		else if (ret != -ENODEV)
-			dev->links.need_for_probe = false;
-	}
-	mutex_unlock(&wfs_lock);
-}
-
 #ifdef CONFIG_SRCU
 static void __device_link_del(struct kref *kref)
 {
@@ -1194,9 +1124,8 @@ void device_links_driver_bound(struct device *dev)
 	 * the device links it needs to or make new device links as it needs
 	 * them. So, it no longer needs to wait on any suppliers.
 	 */
-	mutex_lock(&wfs_lock);
-	list_del_init(&dev->links.needs_suppliers);
-	mutex_unlock(&wfs_lock);
+	if (dev->fwnode && dev->fwnode->dev == dev)
+		fwnode_links_purge_suppliers(dev->fwnode);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
@@ -1487,10 +1416,6 @@ static void device_links_purge(struct device *dev)
 	if (dev->class == &devlink_class)
 		return;
 
-	mutex_lock(&wfs_lock);
-	list_del(&dev->links.needs_suppliers);
-	mutex_unlock(&wfs_lock);
-
 	/*
 	 * Delete all of the remaining links from this device to any other
 	 * devices (either consumers or suppliers).
@@ -1815,17 +1740,17 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 
 static void fw_devlink_link_device(struct device *dev)
 {
-	int fw_ret;
+	struct fwnode_handle *fwnode = dev->fwnode;
+
+	if (!fw_devlink_flags)
+		return;
 
-	device_link_add_missing_supplier_links();
+	fw_devlink_parse_fwtree(fwnode);
 
-	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
-		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
-			device_link_wait_for_mandatory_supplier(dev);
-		else if (fw_ret)
-			device_link_wait_for_optional_supplier(dev);
-	}
+	mutex_lock(&fwnode_link_lock);
+	__fw_devlink_link_to_consumers(dev);
+	__fw_devlink_link_to_suppliers(dev, fwnode);
+	mutex_unlock(&fwnode_link_lock);
 }
 
 /* Device links support end. */
@@ -2683,7 +2608,6 @@ void device_initialize(struct device *dev)
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
-	INIT_LIST_HEAD(&dev->links.needs_suppliers);
 	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 1e771ea4dca6..89bb8b84173e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -351,18 +351,13 @@ enum dl_dev_state {
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
- * @needs_suppliers: Hook to global list of devices waiting for suppliers.
  * @defer_sync: Hook to global list of devices that have deferred sync_state.
- * @need_for_probe: If needs_suppliers is on a list, this indicates if the
- *		    suppliers are needed for probe or not.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
-	struct list_head needs_suppliers;
 	struct list_head defer_sync;
-	bool need_for_probe;
 	enum dl_dev_state status;
 };
 
-- 
2.29.1.341.ge80a0c044ae-goog

