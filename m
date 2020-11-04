Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5E2A71B7
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgKDX0E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbgKDXYC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDCC0613D2
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u11so408992ybh.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BhUjYszSk71wZlQtq5hRNOUlleKEQKCmateQuUAc1A0=;
        b=Bww/3yKY+ONgWcJ3cLoSeSWBPGJ2hOS3FdcxPbz3akcI3W+hgtgq3R4WoTmlARlZqP
         M5VyJmlXPSgGfPOYla6Cr/RUJZuHSF9L09ESU8I+XQA4i6jtltKJmyG4dMVDrewSrptv
         76WeaxXUGcIgP8+ND2sovEN0lVt08XBee3p4OrzTZR1SCw8rQG5BOiY2hrKG0LRpmlT8
         qP9m3pO8wXlMHwqmjZAhN62bCK9gb8jUT1x7Dp19hJ5/C+z5Ufi7chERIKkwy6mfEZgx
         QLry5+3skYHHqz3iXBKFg7dr8izgsH8XuAdEa0Soi2x7Jl6vRfd8282WGtqjKOAYIJEM
         FFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BhUjYszSk71wZlQtq5hRNOUlleKEQKCmateQuUAc1A0=;
        b=PCgsbJoBMkVunUOXrpktFR6f3VP+/hysfHdMPvlbNETFHw09Ps7xI2MC4xxpsUQH44
         DIZ2pWuvG6a9QJdThn8qcEW6mNKHCE0tjrAR1AJlHRx7aNWOb+xl6lecdljm1nX9OeHU
         9+spbx71Iqs3M/J9QI7LX+t1UGKICkoXNe6RPfqOdW3SiChUCsEdpUCEJDx9qAIIMedU
         FUIiciCdTesDpYgIdp6s1ftVQm89kr1UEGQgey4MbarVig8TgzCwHPb+uOIBhZB28c0e
         8cQEmozygWFem0MXZRraIiF8P4Hn1JvxgHE421deL3KffHGvho5cw3hm2OPTwlmuaxmu
         UF+Q==
X-Gm-Message-State: AOAM5305+4Ims7E+yeilu1UIwApa6lJlBV9NCY1UQjofrfPuphpArgIj
        YgYidRNdkIEfraBb2Jq/kBd3fz0Y+tE1oTM=
X-Google-Smtp-Source: ABdhPJwpeEFN4gVsTaAomYr1fpuXRu2jKJlLJc0sAndfUh392UG+hSNst+uctyYjAO2rEcnP1boxrdw2x+fGHZo=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:40c5:: with SMTP id
 n188mr274862yba.514.1604532241782; Wed, 04 Nov 2020 15:24:01 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:38 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-2-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 01/18] Revert "driver core: Avoid deferred probe due to fw_devlink_pause/resume()"
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

This reverts commit 2451e746478a6a6e981cfa66b62b791ca93b90c8.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 21 ---------------------
 include/linux/device.h |  3 +--
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 78114ddac755..a56601e68a8c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -51,7 +51,6 @@ static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static unsigned int defer_fw_devlink_count;
-static LIST_HEAD(deferred_fw_devlink);
 static DEFINE_MUTEX(defer_fw_devlink_lock);
 static bool fw_devlink_is_permissive(void);
 
@@ -1472,12 +1471,6 @@ static void fw_devlink_link_device(struct device *dev)
 			fw_ret = -EAGAIN;
 	} else {
 		fw_ret = -ENODEV;
-		/*
-		 * defer_hook is not used to add device to deferred_sync list
-		 * until device is bound. Since deferred fw devlink also blocks
-		 * probing, same list hook can be used for deferred_fw_devlink.
-		 */
-		list_add_tail(&dev->links.defer_hook, &deferred_fw_devlink);
 	}
 
 	if (fw_ret == -ENODEV)
@@ -1546,9 +1539,6 @@ void fw_devlink_pause(void)
  */
 void fw_devlink_resume(void)
 {
-	struct device *dev, *tmp;
-	LIST_HEAD(probe_list);
-
 	mutex_lock(&defer_fw_devlink_lock);
 	if (!defer_fw_devlink_count) {
 		WARN(true, "Unmatched fw_devlink pause/resume!");
@@ -1560,19 +1550,8 @@ void fw_devlink_resume(void)
 		goto out;
 
 	device_link_add_missing_supplier_links();
-	list_splice_tail_init(&deferred_fw_devlink, &probe_list);
 out:
 	mutex_unlock(&defer_fw_devlink_lock);
-
-	/*
-	 * bus_probe_device() can cause new devices to get added and they'll
-	 * try to grab defer_fw_devlink_lock. So, this needs to be done outside
-	 * the defer_fw_devlink_lock.
-	 */
-	list_for_each_entry_safe(dev, tmp, &probe_list, links.defer_hook) {
-		list_del_init(&dev->links.defer_hook);
-		bus_probe_device(dev);
-	}
 }
 /* Device links support end. */
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 5ed101be7b2e..da00f8e449bb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -352,8 +352,7 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
- * @defer_hook: Hook to global list of devices that have deferred sync_state or
- *		deferred fw_devlink.
+ * @defer_hook: Hook to global list of devices that have deferred sync_state.
  * @need_for_probe: If needs_suppliers is on a list, this indicates if the
  *		    suppliers are needed for probe or not.
  * @status: Driver status information.
-- 
2.29.1.341.ge80a0c044ae-goog

