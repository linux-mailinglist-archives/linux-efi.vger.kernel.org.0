Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD52BBBD8
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgKUCCs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKUCCs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:48 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C4C061A48
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:47 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e22so8886515qte.22
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1MIEjHYAUOmtfDtnN00T8oexuLD0a1GaxYDVE08u5Wg=;
        b=WRnGMJKiRCk+glHvgvynNYZv8x92G9pyeda7gKEvfbRpg9wlzldzuLg06cUuDtlwLU
         XVUNn90Kf8v22rIHed41Qj+nv4l1ynOtpQEApSlJD/2mZ9F9RPkrAKTTcXsYnS3+lPlt
         HM70l30j1V3rlsBytAQMz5JtXe/w2lKBJPIAr8bnoYQYNXB6mESh3Mo2ZYmyNjr0x4fn
         VKgHJwd7OYW2tCam3CHhiEs3oMmKgqTAuDvvPdsNAYdXPb6RH5p6eDoC6vbY6Rw/IMKZ
         dGrXBwzFvOl0lod6guKxN2S6Z/b1qG/OwhAojwkGMGNgWr4rlq9Mnww0d82Q2IA4ImNZ
         UlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1MIEjHYAUOmtfDtnN00T8oexuLD0a1GaxYDVE08u5Wg=;
        b=oth8oRI6IHavDG+oVxKLklzZbR6GbNKZcdeZrNJNsL8w/9fRHtzxK5OmdJHMBA7yDD
         b7BGDFXebLDhjnX++Nx8x1kTZ4KQHoHI9kOGlidE4zf1hLR0H2SqBwQ/zWofqkgb11IG
         9WmdkvivRtiir7ldV+8YDixBqyeG391L134gDR9Jnd2ky195khh8hxMcLYGwrRNnLtlM
         /rliGxCeh98YB6Xs2+OhhuF4rIDmhM8ZI7mGi+VIO8uPT1sgeTbYecW1GEbM/Wa6WlGY
         +G5OyhJv3KX4VZf8bwGAOjAItZ1lP18BJiN6WAtdcTdIBQ1N4ajEyAdt2yNZbVAFP25j
         cPGw==
X-Gm-Message-State: AOAM530ZvoI0atMNgPSCT5Jjk8cRkRryzWy0lnQt66SOx5M1Yqh9sg+U
        H0sb5MAytMeAp7mxqgq/U9fLufI9jCyW2R0=
X-Google-Smtp-Source: ABdhPJwsK6KYV3vtcuQpWlijpToTJEH99q4w1i+0OrCZcZTmMCpUf85uz7XbU4cltly1bkZZXZr1IPTfDIdhv7A=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:5587:: with SMTP id
 e7mr19801981qvx.33.1605924166877; Fri, 20 Nov 2020 18:02:46 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:16 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-2-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 01/17] Revert "driver core: Avoid deferred probe due to fw_devlink_pause/resume()"
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

fw_devlink_pause/resume() was an incomplete attempt at boot time
optimization. That's going to get replaced by a much better optimization
at the end of the series. Since fw_devlink_pause/resume() is going away,
changes made for that can also go away.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 21 ---------------------
 include/linux/device.h |  3 +--
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d661ada1518f..b202fe54f46a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -51,7 +51,6 @@ static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static unsigned int defer_fw_devlink_count;
-static LIST_HEAD(deferred_fw_devlink);
 static DEFINE_MUTEX(defer_fw_devlink_lock);
 static bool fw_devlink_is_permissive(void);
 
@@ -1470,12 +1469,6 @@ static void fw_devlink_link_device(struct device *dev)
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
@@ -1544,9 +1537,6 @@ void fw_devlink_pause(void)
  */
 void fw_devlink_resume(void)
 {
-	struct device *dev, *tmp;
-	LIST_HEAD(probe_list);
-
 	mutex_lock(&defer_fw_devlink_lock);
 	if (!defer_fw_devlink_count) {
 		WARN(true, "Unmatched fw_devlink pause/resume!");
@@ -1558,19 +1548,8 @@ void fw_devlink_resume(void)
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
2.29.2.454.gaff20da3a2-goog

