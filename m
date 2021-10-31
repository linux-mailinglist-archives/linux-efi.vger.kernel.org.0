Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2060440F50
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhJaQ1Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbhJaQ1N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FN7A1ujpQU/zFOX8EqwJrJMl7Y0oOgtAm3LGtcEJ7Ko=;
        b=FStI00fFlE+oEIST/8aOdLmjrip00dx0wO9etNavPKzhJ8ONDQun+1vACGyqpNx1J57mse
        CO69qLedBQRxYiiMHwmBQNWW87IhJZkfbxkM6Clch57DeMYTOMWaRHWUIZUSdiRBNdR4j0
        Q3/0Es3KdfajR2elYzg2Ra2MIwjn3gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-LN3JFnwcPSeZLLd5YiDyLw-1; Sun, 31 Oct 2021 12:24:39 -0400
X-MC-Unique: LN3JFnwcPSeZLLd5YiDyLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA8F8018AC;
        Sun, 31 Oct 2021 16:24:37 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F30B1017CE8;
        Sun, 31 Oct 2021 16:24:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [RFC 1/5] ACPI / x86: Add 3 devices on the Xiaomi Mi Pad 2 to the always_present list
Date:   Sun, 31 Oct 2021 17:24:24 +0100
Message-Id: <20211031162428.22368-2-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
References: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Xiaomi Mi Pad 2 ships in both Windows and Android variants and the BIOS
detects the OS by looking at the EFI executable the efibootmgr entry points
to. If this executable is not the original Android bootloader (signed with
Xiaomi's own keys) it detects the OS as Windows and sets the OSID variable
used in the DSDT to "1".

This causes the following problems when running Linux:

1. Like many other CHT based tablets the Xiaomi Mi Pad 2 does not have
   a properly working ACPI battery interface instead we need to load
   a native driver for the fuel-gauge, but the TXN27520 ACPI device for
   the fuel-gauge gets hidden when OSID == "1".

2. There are backlit LEDs behind the capacitive menu, home, back buttons
   below the screen which are controlled by the second PWM controller of
   the CHT SoC, this gets hidden when OSID == "1".

3. There is an I2C attached KTD2026 RGB LED controller for the notification
   LED, this gets hidden when OSID != "4".

Add always_present_ids table entries for these devices so that they are
always seen as present independent of the OSID value.

Note the TXN27520 ACPI device does not have a UID set, so add support for
matching devices with no UID.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index f22f23933063..831949fda492 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -58,6 +58,11 @@ static const struct always_present_id always_present_ids[] = {
 	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
 		}),
+	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
+	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+	      }),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
@@ -107,6 +112,24 @@ static const struct always_present_id always_present_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "05/25/2017")
 	      }),
+	/*
+	 * The Xiaomi Mi Pad 2 does not use the ACPI battery interface
+	 * instead we need to load a native driver for the fuel-gauge,
+	 * but if the BIOS thinks we are Windows rather then Android,
+	 * the fuel-gauge ACPI device is hidden.
+	 */
+	ENTRY("TXN27520", NULL, X86_MATCH(ATOM_AIRMONT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+	      }),
+	/*
+	 * The Xiaomi Mi Pad 2 has a RGB LED controller for its notifcation
+	 * LED which is hidden when the BIOS thinks we are Windows, unhide it.
+	 */
+	ENTRY("KTD20260", "1", X86_MATCH(ATOM_AIRMONT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+	      }),
 };
 
 bool acpi_device_always_present(struct acpi_device *adev)
@@ -118,8 +141,8 @@ bool acpi_device_always_present(struct acpi_device *adev)
 		if (acpi_match_device_ids(adev, always_present_ids[i].hid))
 			continue;
 
-		if (!adev->pnp.unique_id ||
-		    strcmp(adev->pnp.unique_id, always_present_ids[i].uid))
+		if (always_present_ids[i].uid && (!adev->pnp.unique_id ||
+		    strcmp(adev->pnp.unique_id, always_present_ids[i].uid)))
 			continue;
 
 		if (!x86_match_cpu(always_present_ids[i].cpu_ids))
-- 
2.31.1

