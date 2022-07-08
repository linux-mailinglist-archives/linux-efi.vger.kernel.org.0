Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B756BA70
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiGHNOZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiGHNOY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 09:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C70A61A3BB
        for <linux-efi@vger.kernel.org>; Fri,  8 Jul 2022 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657286062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTLPSkPg91ZVPHWFVosWsgpnvQEs03edyu3/bORaMt0=;
        b=jQkfCcy4V9Pwn4U4+4HKU5loImlIKz2UR969jWyssJ1FFcZKtg7TTGa6apnB/Q5uzHmIbp
        QD1kgMF5klSbHT7ZLk0zCDLrghZWFhOGMNx51zx9COydRctfXLm60NwZUR5IcJ8vB+fUg2
        19ZNXxHSsqYWzVPIBLus8pe7p0ENMXw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-G1U-F32WNdiLXCRnoW8U9g-1; Fri, 08 Jul 2022 09:14:18 -0400
X-MC-Unique: G1U-F32WNdiLXCRnoW8U9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F02E5380406B;
        Fri,  8 Jul 2022 13:14:17 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61C381121314;
        Fri,  8 Jul 2022 13:14:16 +0000 (UTC)
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
Subject: [PATCH 2/2] efi: Fix efi_power_off() not being run before acpi_power_off() when necessary
Date:   Fri,  8 Jul 2022 15:14:12 +0200
Message-Id: <20220708131412.81078-3-hdegoede@redhat.com>
In-Reply-To: <20220708131412.81078-1-hdegoede@redhat.com>
References: <20220708131412.81078-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

This is a problem when the old global pm_power_off handler would later
be overwritten, such as done by the late_initcall(efi_shutdown_init):

	if (efi_poweroff_required())
		pm_power_off = efi_power_off;

The old global pm_power_off handler gets run with a priority of
SYS_OFF_PRIO_DEFAULT which is lower then SYS_OFF_PRIO_FIRMWARE, causing
acpi_power_off() to run first, changing the behavior from before
the ACPI sleep code switched to the new register_sys_off_handler().

Switch the registering of efi_power_off over to register_sys_off_handler()
with a priority of SYS_OFF_PRIO_FIRMWARE + 1 so that it will run before
acpi_power_off() as before.

Note since the new sys-off-handler code will try all handlers in
priority order, there is no more need for the EFI code to store and
call the original pm_power_off handler.

Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/firmware/efi/reboot.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
index 73089a24f04b..ceae84c19d22 100644
--- a/drivers/firmware/efi/reboot.c
+++ b/drivers/firmware/efi/reboot.c
@@ -6,7 +6,7 @@
 #include <linux/efi.h>
 #include <linux/reboot.h>
 
-static void (*orig_pm_power_off)(void);
+static struct sys_off_handler *efi_sys_off_handler;
 
 int efi_reboot_quirk_mode = -1;
 
@@ -51,15 +51,11 @@ bool __weak efi_poweroff_required(void)
 	return false;
 }
 
-static void efi_power_off(void)
+static int efi_power_off(struct sys_off_data *data)
 {
 	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
-	/*
-	 * The above call should not return, if it does fall back to
-	 * the original power off method (typically ACPI poweroff).
-	 */
-	if (orig_pm_power_off)
-		orig_pm_power_off();
+
+	return NOTIFY_DONE;
 }
 
 static int __init efi_shutdown_init(void)
@@ -68,8 +64,13 @@ static int __init efi_shutdown_init(void)
 		return -ENODEV;
 
 	if (efi_poweroff_required()) {
-		orig_pm_power_off = pm_power_off;
-		pm_power_off = efi_power_off;
+		/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
+		efi_sys_off_handler =
+			register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						 SYS_OFF_PRIO_FIRMWARE + 1,
+						 efi_power_off, NULL);
+		if (IS_ERR(efi_sys_off_handler))
+			return PTR_ERR(efi_sys_off_handler);
 	}
 
 	return 0;
-- 
2.36.0

