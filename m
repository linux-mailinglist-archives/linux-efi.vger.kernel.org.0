Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFF168BA7
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 02:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBVBkw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 20:40:52 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38557 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgBVBkt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Feb 2020 20:40:49 -0500
Received: by mail-pf1-f202.google.com with SMTP id 203so2348664pfx.5
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 17:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=On3eRiTUnDa5BtXq5RoayDWDf1ZPcj84ltPeiblPUMk=;
        b=vPVdBWrpXeFBwDzA5UrONBEBUuLscK8+OhywnT5ys4wGN35JJJwulswpUcPpYhqgK1
         m50/tOnt9RKLC2CDy1u57pKZq6LvoiBghI1GhMnyrgRkYCQ09XTbH5UbmTXGKlNWbuXQ
         J3yEVs2TUYmfQDwog+NbQIKm5eJ9aYIVY/QkapqWh4uUSlngOAWp12+cTIlG5o3vOPN2
         +awo8m7Idn6jacZxli1lQRoCqwPlXpk4w99usheYI6920vzDSttPbRIKRyN5a+UHZeOi
         IeuX7ehPEmlkLhMAz2fRsHA3Tok+GPP1xMC6bUPf2tkLmvFdE1m5ArcijHdbPJaf50Lj
         d1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=On3eRiTUnDa5BtXq5RoayDWDf1ZPcj84ltPeiblPUMk=;
        b=Z7blio2+X0QUX04idinr8huPFltRd0C0uqE8uic68WCbrxQFCkXM3ijYIMriGA9kOK
         apfC2qlMUolgdinUlB4iWqJWuBVKMXTtVthNdLoAZXePD0pudZsOrPNQuYu4/U4+C/qm
         HpZ66UamJ8uEbjSWE3+1cDIjqbNas5GKXTYL9o4phXrYLuE5gSPPMhvirLnNpppTGvyW
         J2OKx7rIen7h72ulSd5AWA5KOyz3zuBijh7ng1JQARKeWxvTiwdrZJnRKrOwQBqoWkkO
         H+2LK3kU7vRWvBJ1xLyjD3QLM4pbY7RzbeAGlWtfUQmCdrkEsv/ns1+zruRxE5yrPXMz
         5QdA==
X-Gm-Message-State: APjAAAUlHMecw+i0yIzCh8vLwb6Y/e7A8852V5YJCvlrmSW+3iMihha2
        +K3F3e1ghDd93vwWKnRbZ9HB63OSfydh+2s=
X-Google-Smtp-Source: APXvYqxcK8NEEB7SEtnQp1SzN8VYXqvTOUc2SeP/yCk74iurh+KqopNGx+3yHKNbMZyq5ledAISRoddCngOncis=
X-Received: by 2002:a63:4a47:: with SMTP id j7mr40867151pgl.196.1582335649047;
 Fri, 21 Feb 2020 17:40:49 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:40:35 -0800
In-Reply-To: <20200222014038.180923-1-saravanak@google.com>
Message-Id: <20200222014038.180923-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 2/5] driver core: Add fw_devlink kernel commandline option
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

fwnode_operations.add_links allows creating device links from
information provided by firmware.

fwnode_operations.add_links is currently implemented only by
OF/devicetree code and a specific case of efi. However, there's nothing
preventing ACPI or other firmware types from implementing it.

The OF implementation is currently controlled by a kernel commandline
parameter called of_devlink.

Since this feature is generic isn't limited to OF, add a generic
fw_devlink kernel commandline parameter to control this feature across
firmware types.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 18 +++++++++++++
 drivers/base/core.c                           | 27 ++++++++++++++++++-
 include/linux/fwnode.h                        |  2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d684627..29985152b66d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1350,6 +1350,24 @@
 			can be changed at run time by the max_graph_depth file
 			in the tracefs tracing directory. default: 0 (no limit)
 
+	fw_devlink=	[KNL] Create device links between consumer and supplier
+			devices by scanning the firmware to infer the
+			consumer/supplier relationships. This feature is
+			especially useful when drivers are loaded as modules as
+			it ensures proper ordering of tasks like device probing
+			(suppliers first, then consumers), supplier boot state
+			clean up (only after all consumers have probed),
+			suspend/resume & runtime PM (consumers first, then
+			suppliers).
+			Format: { off | permissive | on | rpm }
+			off --	Don't create device links from firmware info.
+			permissive -- Create device links from firmware info
+				but use it only for ordering boot state clean
+				up (sync_state() calls).
+			on -- 	Create device links from firmware info and use it
+				to enforce probe and suspend/resume ordering.
+			rpm --	Like "on", but also use to order runtime PM.
+
 	gamecon.map[2|3]=
 			[HW,JOY] Multisystem joystick and NES/SNES/PSX pad
 			support via parallel port (up to 5 devices per port)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d32a3aefff32..aeaca8a3aad9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2345,6 +2345,31 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
+u32 fw_devlink_flags;
+static int __init fw_devlink_setup(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "off") == 0) {
+		fw_devlink_flags = 0;
+	} else if (strcmp(arg, "permissive") == 0) {
+		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+	} else if (strcmp(arg, "on") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	} else if (strcmp(arg, "rpm") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
+				   DL_FLAG_PM_RUNTIME;
+	}
+	return 0;
+}
+early_param("fw_devlink", fw_devlink_setup);
+
+u32 fw_devlink_get_flags(void)
+{
+	return fw_devlink_flags;
+}
+
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
@@ -2493,7 +2518,7 @@ int device_add(struct device *dev)
 	 */
 	device_link_add_missing_supplier_links();
 
-	if (fwnode_has_op(dev->fwnode, add_links)) {
+	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
 		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
 		if (fw_ret == -ENODEV)
 			device_link_wait_for_mandatory_supplier(dev);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8feeb94b8acc..e0abafbb17f8 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -170,4 +170,6 @@ struct fwnode_operations {
 	} while (false)
 #define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
+extern u32 fw_devlink_get_flags(void);
+
 #endif
-- 
2.25.0.265.gbab2e86ba0-goog

