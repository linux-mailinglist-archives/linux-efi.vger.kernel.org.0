Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF752A7174
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgKDXYQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgKDXYG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:06 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48172C0613D3
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:05 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id c2so80210qtx.3
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3UiL5aZl1zoNS4ptaNbzC4VXHpr9TUoirP268mk09Uk=;
        b=noGn4lGf4pHRhdHAbccR4qKPLxfwGlPRrH1hu6Z/S4hJJ94CVF4vZRGDvcLc8CLvLB
         rlBLfmtIh8eySUW24t4zvdxWsgZmhcR+UfKitAfXJZ3YQCrOR4axSh+SPnFGtX4M0dh6
         2lxZrkJ0RavehHy4vv7ndunRSLFb7sfaTAbqSJ/5vb8d51b16+AutnPyXJtujhxJJ0A6
         3yAQ+rJQ7++qRtZR42AjQEl2xzI4IjrCQQjVdJKoOEJPN8s5AV6PGp7XTxWMjKlxIRTi
         jOzNyUnroIQ6XF9Owf+g5wtTOKHraigvmroDmzGIJI3kgEgP28C9CuMruIWUeMYX8GOu
         FTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UiL5aZl1zoNS4ptaNbzC4VXHpr9TUoirP268mk09Uk=;
        b=NGFRk5/f1oOqM/qiWK5MowX7g9B9ioyCMngvFprpbwFu3O9LG+9Rzxq4Fep1Fz1OQA
         u2Kwi48gTpumLmFrEUMp0DFrtlqZn8SjJiseDBdqnBlvqt9pV6CbyVcB9di8k1UQUKSr
         vu0tAYknZCUAd2Oq3ew8MQXmFInEAysp9CmM6/uBkJuOZK1k5hNZL59NAl4cCwmRPhqL
         1vxTZTI9D7QzZG3VoaztgmPdIZjxOHWtJlNGKVUf8lYU4cY9myecO/l7c2iShZrdLawR
         nmON1PIFhYyel7g29tMxOHxPBTr76Q4gF1YcyBnQUyQKKtxil5fJ/GHIyHYb8IWW4HCa
         GXiw==
X-Gm-Message-State: AOAM5313/8buxcitJP0bob05YQH3ahLhT3iAGuZc7PbnVWW5U6ka1UPe
        J/CydR6lFwV00td+mZJtFArCZe6xf2xWTBs=
X-Google-Smtp-Source: ABdhPJxNuGw6B1V226sbOgHc9ABVKn4kbuxcxy1UF+XJInvvR8Arcsve/X1COiNq9EfDXCMuf7LsNTsfqP5+e0A=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:47b0:: with SMTP id
 a16mr287784qvz.22.1604532244395; Wed, 04 Nov 2020 15:24:04 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:39 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-3-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 02/18] Revert "driver core: Rename dev_links_info.defer_sync
 to defer_hook"
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

This reverts commit ec7bd78498f29680f536451fbdf9464e851273ed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 22 +++++++++++-----------
 include/linux/device.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a56601e68a8c..2328c8951695 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -961,11 +961,11 @@ static void __device_links_queue_sync_state(struct device *dev,
 	 */
 	dev->state_synced = true;
 
-	if (WARN_ON(!list_empty(&dev->links.defer_hook)))
+	if (WARN_ON(!list_empty(&dev->links.defer_sync)))
 		return;
 
 	get_device(dev);
-	list_add_tail(&dev->links.defer_hook, list);
+	list_add_tail(&dev->links.defer_sync, list);
 }
 
 /**
@@ -983,8 +983,8 @@ static void device_links_flush_sync_list(struct list_head *list,
 {
 	struct device *dev, *tmp;
 
-	list_for_each_entry_safe(dev, tmp, list, links.defer_hook) {
-		list_del_init(&dev->links.defer_hook);
+	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
+		list_del_init(&dev->links.defer_sync);
 
 		if (dev != dont_lock_dev)
 			device_lock(dev);
@@ -1022,12 +1022,12 @@ void device_links_supplier_sync_state_resume(void)
 	if (defer_sync_state_count)
 		goto out;
 
-	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_hook) {
+	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
 		/*
 		 * Delete from deferred_sync list before queuing it to
-		 * sync_list because defer_hook is used for both lists.
+		 * sync_list because defer_sync is used for both lists.
 		 */
-		list_del_init(&dev->links.defer_hook);
+		list_del_init(&dev->links.defer_sync);
 		__device_links_queue_sync_state(dev, &sync_list);
 	}
 out:
@@ -1045,8 +1045,8 @@ late_initcall(sync_state_resume_initcall);
 
 static void __device_links_supplier_defer_sync(struct device *sup)
 {
-	if (list_empty(&sup->links.defer_hook) && dev_has_sync_state(sup))
-		list_add_tail(&sup->links.defer_hook, &deferred_sync);
+	if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(sup))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
 static void device_link_drop_managed(struct device_link *link)
@@ -1276,7 +1276,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
-	list_del_init(&dev->links.defer_hook);
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -2409,7 +2409,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
-	INIT_LIST_HEAD(&dev->links.defer_hook);
+	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index da00f8e449bb..1e771ea4dca6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -352,7 +352,7 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
- * @defer_hook: Hook to global list of devices that have deferred sync_state.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
  * @need_for_probe: If needs_suppliers is on a list, this indicates if the
  *		    suppliers are needed for probe or not.
  * @status: Driver status information.
@@ -361,7 +361,7 @@ struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	struct list_head needs_suppliers;
-	struct list_head defer_hook;
+	struct list_head defer_sync;
 	bool need_for_probe;
 	enum dl_dev_state status;
 };
-- 
2.29.1.341.ge80a0c044ae-goog

