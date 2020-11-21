Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2862BBBE0
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKUCCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgKUCCx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C95C0613CF
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v13so14069421ybe.18
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W0J7h6NLwXezG3nw9wROdbEnvnNKGLsOxhSb3UWP0QY=;
        b=iyIhHWCU9fj/oBG0xaKujfMHdcE8iB1SHBs4M9uqPOEXOlyOZGNCOu4kJplToKtsqJ
         fm9DBFExGlNp0BWtvnxzXaRl0F2u7jENq1EfgLZiZAfHyGLUmsUve7IGj3V4JMdosQD/
         tpoo12lOko1CXTc92SEtontayS9W0+oxCJIHIp3E6HX/pgQ70Q4/4/DvH/6Rm0Pzddet
         GinuxCIH3bZkCO68pDwYARdQQ0Ygh4QCrpj5fBxPcuGt1CKVwtdaMxLpxgy1flqww/JQ
         EA1F39eN5dGotPk2TCgI2lBfxTDM4CROmmwjA0+wZ6znQee7HUsmCtDzqXxzZk1Xo/4N
         vM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W0J7h6NLwXezG3nw9wROdbEnvnNKGLsOxhSb3UWP0QY=;
        b=ETsPOhENkY3D0ZPLhD40P61go4o9wetNLJ55K2WYZoRFR0KpwbkPRFAcbpUp8CAg/h
         SEQPWJfHJPxIRJG9s0KPhBqSnuN2qAaj+3icPBGyG0O+HLTgnIiTOARBkGvP2wY1/DPJ
         iGDAl4hp5si64jHQ1mTHnkGNvyF1+6K5yvZgtj+PJA2G5OIxTgRy+abzFdQP/RSw81U3
         AWgB5y/5aTv2zZdTqNpOIc+K5bmt3253AIsW/jqO+1BcdaTLHtiOQ8KsuEVo2zXeg51j
         8J0RfpUjtsZcIO562XB9RiwOemRNMj5ayOPRFI/LrdZK/jLXW6UFEKFh+8lRECC5P6cs
         tClA==
X-Gm-Message-State: AOAM531k0LCDsIwYnHSmLpfYfVn0NsnHSsyNguYHONxarSRDpXCsZmhs
        WwUqk9HLpJcMz3dEyVNR4MRNLNJS4yO38MM=
X-Google-Smtp-Source: ABdhPJxaPaEuH/NuIAbXGDdgzhB6YudXw1v6b5GdSJ/2qVXcj02CQC8DkQhxDv4As8NeECYbE4iKP/J9Hk/OB9Y=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:ac1a:: with SMTP id
 w26mr32786299ybi.395.1605924172031; Fri, 20 Nov 2020 18:02:52 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:18 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-4-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 03/17] Revert "driver core: Don't do deferred probe in
 parallel with kernel_init thread"
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

This reverts commit cec72f3efc6272420c2c2c699607f03d09b93e41.

Commit cec72f3efc62 ("driver core: Don't do deferred probe in parallel
with kernel_init thread") was fixing a commit 716a7a259690 ("driver
core: fw_devlink: Add support for batching fwnode parsing"). Since the
commit being fixed itself is going to be reverted, the fix can also be
reverted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h | 1 +
 drivers/base/core.c | 1 +
 drivers/base/dd.c   | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 91cfb8405abd..c3562adf4789 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -156,6 +156,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void driver_deferred_probe_force_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index c91ff2546247..e6bb4bf4f19d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1548,6 +1548,7 @@ void fw_devlink_resume(void)
 		goto out;
 
 	device_link_add_missing_supplier_links();
+	driver_deferred_probe_force_trigger();
 out:
 	mutex_unlock(&defer_fw_devlink_lock);
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..001caa0b447c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -167,6 +167,11 @@ static void driver_deferred_probe_trigger(void)
 	if (!driver_deferred_probe_enable)
 		return;
 
+	driver_deferred_probe_force_trigger();
+}
+
+void driver_deferred_probe_force_trigger(void)
+{
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.29.2.454.gaff20da3a2-goog

