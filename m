Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5B2A719A
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgKDXZG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbgKDXYn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305AC0613D4
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x197so377370ybg.18
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UFRlchaIccsk0JGD42LufUh5WHL/iRO0t5U2dOMSWQI=;
        b=DVZtwNlzUvhu1bT2ylduD17IaOiKiLS3Xrt/pqRBfM9JAG32+swkygL69PmMRvoWhD
         mj/Jpu82kklLO2wzJNnP0ZF/yF5jbqPKJkBHmeyJ74/LJDzu32tel3FiTYqhDMEt5SrI
         0ubtl2yP/UPmzJtTdhZ/puSkDPJYWSZtGZ02VQobv5MVspZhus+fqBb3M0XrOe8vXB9D
         90BykzQ1Y4VIrqlpT2R1/jNsyJ/fxiN4RpKrkTgO0hSeZpr1hMTlJEICVdTvq9rqJjEF
         aNxPctEVyYV7ognSHXbPb7puCiS4kRL9rPHzVgBbJa8t42aBS0UmoIgsQR6SU+HFLA5a
         j/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UFRlchaIccsk0JGD42LufUh5WHL/iRO0t5U2dOMSWQI=;
        b=dpoo0a2heTPNHlgjTxLNs7jvyJwMu3Z6OxLkXU6A9xtFj2C1Il7hjbn6P1NCp/ZCfy
         cqlBCwhKCpjtpkH5jqyL8+xdM1kNL5VwMplm+i9v5NmFwEH19Js4u8DScbziOgZvP/2p
         OfJSwFyOqsDOdyqQbq79LkD7jIK7br7wUzzc6S2kkZuwrxWndKv9VBWDMeN49lwlxwYn
         pVsAplTl2gWoJdD07nurU/Wl/MFbghgNrkAckDiX/DU4v8jGiA4d7mBdvfi5ofMahanW
         HmkDRFfCenW8YNmJZcaCoTrSwrKNOSWmEO608jgDhDG1SzofisY2vcWF4UjtL583dp14
         WJdg==
X-Gm-Message-State: AOAM531sQXwhVXvy1GZ1dCQX7Oal2yVwUZslPKlAgRJjVAVQuLVeXJN2
        YysWwyskzLb1Z+wF6JaeZsNw6Sp0sFpbMCo=
X-Google-Smtp-Source: ABdhPJyFTyTz9U39nyonyGauPk616+s3tOk5O4R2ocwWkkWD1/UZ5J5Wz1mvahqfCGL8MHVgQgmjjxoLzce+IEk=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:afc1:: with SMTP id
 d1mr268166ybj.27.1604532282595; Wed, 04 Nov 2020 15:24:42 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:54 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-18-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 17/18] driver core: Add helper functions to convert fwnode
 links to device links
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

Add helper functions __fw_devlink_link_to_consumers() and
__fw_devlink_link_to_suppliers() that convert fwnode links to device
links.

__fw_devlink_link_to_consumers() is for creating:
- Device links between a newly added device and all its consumer devices
  that have been added to driver core.
- Proxy SYNC_STATE_ONLY device links between the newly added device and
  the parent devices of all its consumers that have not been added to
  driver core yet.

__fw_devlink_link_to_suppliers() is for creating:
- Device links between a newly added device and all its supplier devices
- Proxy SYNC_STATE_ONLY device links between the newly added device and
  all the supplier devices of its child device nodes.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 228 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d51dd564add1..0c87ff949d81 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1585,6 +1585,234 @@ static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 	return dev;
 }
 
+/**
+ * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
+ * @con - Consumer device for the device link
+ * @sup - fwnode handle of supplier
+ *
+ * This function will try to create a device link between the consumer and the
+ * supplier devices.
+ *
+ * The supplier has to be provided as a fwnode because incorrect cycles in
+ * fwnode links can sometimes cause the supplier device to never be created.
+ * This function detects such cases and returns an error if a device link being
+ * created in invalid.
+ *
+ * Returns,
+ * 0 on successfully creating a device link
+ * -EINVAL if the device link being attempted is invalid
+ * -EAGAIN if the device link needs to be attempted again in the future
+ */
+static int fw_devlink_create_devlink(struct device *con,
+				     struct fwnode_handle *sup, u32 flags)
+{
+	struct device *sup_dev, *sup_par_dev;
+	int ret = 0;
+
+	sup_dev = get_dev_from_fwnode(sup);
+	/*
+	 * If we can't find the supplier device from its fwnode, it might be
+	 * due to a cyclic dependcy between fwnodes. Some of these cycles can
+	 * be broken by applying logic. Check for these types of cycles and
+	 * break them so that devices in the cycle probe properly.
+	 */
+	if (!sup_dev) {
+		/*
+		 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
+		 * cycles. So cycle detection isn't necessary and shouldn't be
+		 * done.
+		 */
+		if (flags & DL_FLAG_SYNC_STATE_ONLY)
+			return -EAGAIN;
+
+		sup_par_dev = fwnode_get_next_parent_dev(sup);
+
+		/*
+		 * If the supplier's parent is dependent on the consumer, then
+		 * the consumer-supplier dependency is a false dependency. So,
+		 * treat it as an invalid link.
+		 */
+		if (sup_par_dev && device_is_dependent(con, sup_par_dev)) {
+			dev_dbg(con, "Not linking to %pfwP - False link\n",
+				sup);
+			ret = -EINVAL;
+		} else {
+			/*
+			 * Can't check for cycles or no cycles. So let's try
+			 * again later.
+			 */
+			ret = -EAGAIN;
+		}
+
+		put_device(sup_par_dev);
+		return ret;
+	}
+
+	/*
+	 * If we get this far and fail, this is due to cycles in device links.
+	 * Just give up on this link and treat it as invalid.
+	 */
+	if (!device_link_add(con, sup_dev, flags))
+		ret = -EINVAL;
+	put_device(sup_dev);
+
+	return ret;
+}
+
+/**
+ * __fw_devlink_link_to_consumers - Create device links to consumers of a device
+ * @dev - Device that needs to be linked to its consumers
+ *
+ * This function looks at all the consumer fwnodes of @dev and creates device
+ * links between the consumer device and @dev (supplier).
+ *
+ * If the consumer device has not been added yet, then this function creates a
+ * SYNC_STATE_ONLY link between @dev (supplier) and the closest ancestor device
+ * of the consumer fwnode. This is necessary to make sure @dev doesn't get a
+ * sync_state() callback before the real consumer device gets to be added and
+ * then probed.
+ *
+ * Once device links are created from the real consumer to @dev (supplier), the
+ * fwnode links are deleted.
+ */
+static void __fw_devlink_link_to_consumers(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev->fwnode;
+	struct fwnode_link *link, *tmp;
+
+	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
+		u32 dl_flags = fw_devlink_get_flags();
+		struct device *con_dev;
+		bool own_link = true;
+		int ret;
+
+		con_dev = get_dev_from_fwnode(link->consumer);
+		/*
+		 * If consumer device is not available yet, make a "proxy"
+		 * SYNC_STATE_ONLY link from the consumer's parent device to
+		 * the supplier device. This is necessary to make sure the
+		 * supplier doesn't get a sync_state() callback before the real
+		 * consumer can create a device link to the supplier.
+		 *
+		 * This proxy link step is needed to handle the case where the
+		 * consumer's parent device is added before the supplier.
+		 */
+		if (!con_dev) {
+			con_dev = fwnode_get_next_parent_dev(link->consumer);
+			/*
+			 * However, if the consumer's parent device is also the
+			 * parent of the supplier, don't create a
+			 * consumer-supplier link from the parent to its child
+			 * device. Such a dependency is impossible.
+			 */
+			if (con_dev &&
+			    fwnode_is_ancestor_of(con_dev->fwnode, fwnode)) {
+				put_device(con_dev);
+				con_dev = NULL;
+			} else {
+				own_link = false;
+				dl_flags = DL_FLAG_SYNC_STATE_ONLY;
+			}
+		}
+
+		if (!con_dev)
+			continue;
+
+		ret = fw_devlink_create_devlink(con_dev, fwnode, dl_flags);
+		put_device(con_dev);
+		if (!own_link || ret == -EAGAIN)
+			continue;
+
+		list_del(&link->s_hook);
+		list_del(&link->c_hook);
+		kfree(link);
+	}
+}
+
+/**
+ * __fw_devlink_link_to_suppliers - Create device links to suppliers of a device
+ * @dev - The consumer device that needs to be linked to its suppliers
+ * @fwnode - Root of the fwnode tree that is used to create device links
+ *
+ * This function looks at all the supplier fwnodes of fwnode tree rooted at
+ * @fwnode and creates device links between @dev (consumer) and all the
+ * supplier devices of the entire fwnode tree at @fwnode. See
+ * fw_devlink_create_devlink() for more details.
+ *
+ * The function creates normal (non-SYNC_STATE_ONLY) device links between @dev
+ * and the real suppliers of @dev. Once these device links are created, the
+ * fwnode links are deleted. When such device links are successfully created,
+ * this function is called recursively on those supplier devices. This is
+ * needed to detect and break some invalid cycles in fwnode links.
+ *
+ * In addition, it also looks at all the suppliers of the entire fwnode tree
+ * because some of the child devices of @dev that have not been added yet
+ * (because @dev hasn't probed) might already have their suppliers added to
+ * driver core. So, this function creates SYNC_STATE_ONLY device links between
+ * @dev (consumer) and these suppliers to make sure they don't execute their
+ * sync_state() callbacks before these child devices have a chance to create
+ * their device links. The fwnode links that correspond to the child devices
+ * aren't delete because they are needed later to create the device links
+ * between the real consumer and supplier devices.
+ */
+static void __fw_devlink_link_to_suppliers(struct device *dev,
+					   struct fwnode_handle *fwnode)
+{
+	bool own_link = (dev->fwnode == fwnode);
+	struct fwnode_link *link, *tmp;
+	struct fwnode_handle *child = NULL;
+	u32 dl_flags;
+
+	if (own_link)
+		dl_flags = fw_devlink_get_flags();
+	else
+		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
+
+	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
+		int ret;
+		struct device *sup_dev;
+		struct fwnode_handle *sup = link->supplier;
+
+		ret = fw_devlink_create_devlink(dev, sup, dl_flags);
+		if (!own_link || ret == -EAGAIN)
+			continue;
+
+		list_del(&link->s_hook);
+		list_del(&link->c_hook);
+		kfree(link);
+
+		/* If no device link was created, nothing more to do. */
+		if (ret)
+			continue;
+
+		/*
+		 * If a device link was successfully created to a supplier, we
+		 * now need to try and link the supplier to all its suppliers.
+		 *
+		 * This is needed to detect and delete false dependencies in
+		 * fwnode links that haven't been converted to a device link
+		 * yet. See comments in fw_devlink_create_devlink() for more
+		 * details on the false dependency.
+		 *
+		 * Without deleting these false dependencies, some devices will
+		 * never probe because they'll keep waiting for their false
+		 * dependency fwnode links to be converted to device links.
+		 */
+		sup_dev = get_dev_from_fwnode(sup);
+		__fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
+		put_device(sup_dev);
+	}
+
+	/*
+	 * Make "proxy" SYNC_STATE_ONLY device links to represent the needs of
+	 * all the descendants. This proxy link step is needed to handle the
+	 * case where the supplier is added before the consumer's parent device
+	 * (@dev).
+	 */
+	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+		__fw_devlink_link_to_suppliers(dev, child);
+}
+
 static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
-- 
2.29.1.341.ge80a0c044ae-goog

