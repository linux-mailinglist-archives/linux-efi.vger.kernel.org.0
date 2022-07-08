Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943CC56BA62
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiGHNOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiGHNOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 09:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD993E17
        for <linux-efi@vger.kernel.org>; Fri,  8 Jul 2022 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657286061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5XQMgCfmhZL4LYvSLEJtLzGT9HVAJkUynKxpB5ttVE=;
        b=YYME66/LPEli8I0i01uZJhNFoBPYIyNuwGubK85y/NmMY/X2oHlkAxPLVtMVu9LykXrUtb
        nfVGD9rIjTnV0rl8EFEYfSz/krgWaLJ8icYTPyPlT8d6F2WlHjz4iPy7K+jdsjuxAy6sdB
        PR0KRPRoNy2B4p3PvGhYq/8/nmwcf+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-qk53IZJcOgulgx2KvvxJmw-1; Fri, 08 Jul 2022 09:14:16 -0400
X-MC-Unique: qk53IZJcOgulgx2KvvxJmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D9331035340;
        Fri,  8 Jul 2022 13:14:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 988F81121314;
        Fri,  8 Jul 2022 13:14:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again
Date:   Fri,  8 Jul 2022 15:14:11 +0200
Message-Id: <20220708131412.81078-2-hdegoede@redhat.com>
In-Reply-To: <20220708131412.81078-1-hdegoede@redhat.com>
References: <20220708131412.81078-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
switched the ACPI sleep code from directly setting the old global
pm_power_off handler to using the new register_sys_off_handler()
mechanism with a priority of SYS_OFF_PRIO_FIRMWARE.

This is a problem in special cases where the old global pm_power_off
handler later gets overwritten, such as the Lenovo Tab2 poweroff bugfix
in x86-android-tablets. The old global pm_power_off handler gets run
with a priority of SYS_OFF_PRIO_DEFAULT which is lower then
SYS_OFF_PRIO_FIRMWARE, causing the troublesome ACPI poweroff (which
freezes the system) to run first.

Switch the registering of lenovo_yoga_tab2_830_1050_power_off over to
register_sys_off_handler() with a priority of SYS_OFF_PRIO_FIRMWARE + 1
so that it will run before acpi_power_off() to fix this.

Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index f446be72e539..480375977435 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -27,8 +27,8 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/lp855x.h>
 #include <linux/platform_device.h>
-#include <linux/pm.h>
 #include <linux/power/bq24190_charger.h>
+#include <linux/reboot.h>
 #include <linux/rmi.h>
 #include <linux/serdev.h>
 #include <linux/spi/spi.h>
@@ -889,6 +889,7 @@ static const struct pinctrl_map lenovo_yoga_tab2_830_1050_codec_pinctrl_map =
 			  "INT33FC:02", "pmu_clk2_grp", "pmu_clk");
 
 static struct pinctrl *lenovo_yoga_tab2_830_1050_codec_pinctrl;
+static struct sys_off_handler *lenovo_yoga_tab2_830_1050_sys_off_handler;
 
 static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
 {
@@ -933,9 +934,11 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
  * followed by a normal 3 second press to recover. Avoid this by doing an EFI
  * poweroff instead.
  */
-static void lenovo_yoga_tab2_830_1050_power_off(void)
+static int lenovo_yoga_tab2_830_1050_power_off(struct sys_off_data *data)
 {
 	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
+
+	return NOTIFY_DONE;
 }
 
 static int __init lenovo_yoga_tab2_830_1050_init(void)
@@ -950,13 +953,19 @@ static int __init lenovo_yoga_tab2_830_1050_init(void)
 	if (ret)
 		return ret;
 
-	pm_power_off = lenovo_yoga_tab2_830_1050_power_off;
+	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
+	lenovo_yoga_tab2_830_1050_sys_off_handler =
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
+					 lenovo_yoga_tab2_830_1050_power_off, NULL);
+	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
+		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+
 	return 0;
 }
 
 static void lenovo_yoga_tab2_830_1050_exit(void)
 {
-	pm_power_off = NULL; /* Just turn poweroff into halt on module unload */
+	unregister_sys_off_handler(lenovo_yoga_tab2_830_1050_sys_off_handler);
 
 	if (lenovo_yoga_tab2_830_1050_codec_pinctrl) {
 		pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
-- 
2.36.0

