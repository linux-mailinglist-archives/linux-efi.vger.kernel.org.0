Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753372BBBDE
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKUCCv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgKUCCv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16620C061A04
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c24so114442pfd.13
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C0bHKb1/iWiLgdtF9sSmjqtEvvSI0v807amqNyJzdNU=;
        b=oVICUpmkGZYeD7GCm7OHZePNr0D7oNE9MGHDeA14TlrhsrfYTroblrGIZDXkuUvKJy
         1xmlgXXXtOvWXNsWsBLt4bjiHDWfOXdlI7nWqGRa/D++ATibv0GyA81LGS2AyZV2uvhZ
         x1VfPlF7j5GZQUE6NdUdZj40qx2f51YwrtoiBrZdlrx7qx0MrmlCwAe5UWli6SN7FtbP
         bLbzo5MqzQ4xydQHAZfNdgDtBArIgPU44e6eGAm5wOsWzo6Xx/5rTfinOOyVkJkMiID9
         bH+2ZhrIwEgzDXXX/v946bSvkc4YQrqI7kbnnhnitJIohJMixgsYDLl0FdY66/cdy6V9
         cocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C0bHKb1/iWiLgdtF9sSmjqtEvvSI0v807amqNyJzdNU=;
        b=Nsubxjt6h5+qVOxDAoKMiTkbU26Fx6J/McUSCZjjGnT7ZIo3OM5hTWW3uASaGrwunt
         SsZ1wGn6TFhI6VihASCufmcP3+gJtgmg7YecuCcHwsh8Sxw9IZVN/uClv3zQjy9/yhkG
         wrgBBYsE1E4CqJdD/LwDgmkFEhpIj1QkGxLtwJdKX5mCqiiWxUa0AUUk1btlnWKUXFDr
         +I9e1/7WJRF+1bEsO7haPremxD5Jz2eVUNDxj8rogmJkxtDgcDYfPOSyiN9NqOfUpg4K
         YyU7ARt3fcgIBZpbWSshUotcQOpaSe5BLhmxgsrghH29/dK1nRiGUdZPqzuJii6ayPis
         BQpg==
X-Gm-Message-State: AOAM531Q9MXBFcrDE+lG8a0Kd6moabFPBj6yg3TtjB19uzkj1yXrxPVV
        JUU0c5cLfbGYDRRPAinsT2bJiFH+l+VspNs=
X-Google-Smtp-Source: ABdhPJwkoh7gsKp85NKgP+D91F1jQ8SL7LKV9shZgwbKa77TXviiL3HDVdSCd11fSTpospmRJjxFmFG2oPfHfGM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:aa7:8552:0:b029:18e:f030:e514 with SMTP
 id y18-20020aa785520000b029018ef030e514mr15787534pfn.2.1605924169466; Fri, 20
 Nov 2020 18:02:49 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:17 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-3-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 02/17] Revert "driver core: Rename dev_links_info.defer_sync
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

This field rename was done to reuse defer_syc list head for multiple
lists. That's not needed anymore and this list head will only be used
for defer sync. So revert this patch to avoid conflicts with the other
reverts coming after this.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 22 +++++++++++-----------
 include/linux/device.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b202fe54f46a..c91ff2546247 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -959,11 +959,11 @@ static void __device_links_queue_sync_state(struct device *dev,
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
@@ -981,8 +981,8 @@ static void device_links_flush_sync_list(struct list_head *list,
 {
 	struct device *dev, *tmp;
 
-	list_for_each_entry_safe(dev, tmp, list, links.defer_hook) {
-		list_del_init(&dev->links.defer_hook);
+	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
+		list_del_init(&dev->links.defer_sync);
 
 		if (dev != dont_lock_dev)
 			device_lock(dev);
@@ -1020,12 +1020,12 @@ void device_links_supplier_sync_state_resume(void)
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
@@ -1043,8 +1043,8 @@ late_initcall(sync_state_resume_initcall);
 
 static void __device_links_supplier_defer_sync(struct device *sup)
 {
-	if (list_empty(&sup->links.defer_hook) && dev_has_sync_state(sup))
-		list_add_tail(&sup->links.defer_hook, &deferred_sync);
+	if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(sup))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
 static void device_link_drop_managed(struct device_link *link)
@@ -1274,7 +1274,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
-	list_del_init(&dev->links.defer_hook);
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -2407,7 +2407,7 @@ void device_initialize(struct device *dev)
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
2.29.2.454.gaff20da3a2-goog

