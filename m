Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49579440AFB
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJ3Sa5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhJ3Sa5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cdF+sE/SLgTIc7hDDLi/Ba/YvIkdSSZy+iz0SwSwrw=;
        b=GFfbNoDWeEW2HzHLyYPxWAQ/sge4deqZCrmgHkRb07GhLHIkRYjEXR0mGlosYxsOculS0D
        zTjLbcgMXl8Ohxqebx4ge3qChVDF7HOVc15Fhosp3DYZD0F3E/CxqHPa654iEVCqIs0W1F
        d5h2HsBLRsK5pxD2LoDlI59c7RQjHh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-BkS4txVNN-GYa76GsBKkJQ-1; Sat, 30 Oct 2021 14:28:22 -0400
X-MC-Unique: BkS4txVNN-GYa76GsBKkJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E4F362F9;
        Sat, 30 Oct 2021 18:28:20 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E95575F4E1;
        Sat, 30 Oct 2021 18:28:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 01/13] platform/x86: Rename touchscreen_dmi to dmi_device_properties
Date:   Sat, 30 Oct 2021 20:28:01 +0200
Message-Id: <20211030182813.116672-2-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The ability to attach device-properties to (I2C) devices based on
a DMI + I2C device-name match to address the hw-description in
some ACPI tables being incomplete is useful for more things then just
touchscreens. Rename the Kconfig option and file to reflect this.

The specific use-case triggering this change is describing the
hardware surrounding the Whiskey Cove PMIC found on several
Cherry Trail based devices. At least 3 configs are known:

1. The WC PMIC is connected to a TI BQ24292i charger, paired with
   a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
   a PI3USB30532 USB switch, for a fully functional Type-C port

2. The WC PMIC is connected to a TI BQ25890 charger, paired with
   a TI BQ27520 fuelgauge, for a USB-2 only Type-C port without PD

3. The WC PMIC is connected to a TI BQ25890 charger, paired with
   a TI BQ27542 fuelgauge, for a micro-USB port

And various drivers (extcon-intel-cht-wc.c, i2c-cht-wc.c, ...) need
to know which config they are dealing with.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/firmware/efi/embedded-firmware.c      |  4 ++--
 drivers/platform/x86/Kconfig                  | 20 ++++++++++---------
 drivers/platform/x86/Makefile                 |  2 +-
 ...chscreen_dmi.c => dmi_device_properties.c} |  8 ++++----
 include/linux/efi_embedded_fw.h               |  2 +-
 6 files changed, 20 insertions(+), 18 deletions(-)
 rename drivers/platform/x86/{touchscreen_dmi.c => dmi_device_properties.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09abc1d84a7f..fe6a952c0232 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17156,7 +17156,7 @@ L:	linux-input@vger.kernel.org
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/silead.c
-F:	drivers/platform/x86/touchscreen_dmi.c
+F:	drivers/platform/x86/dmi_device_properties.c
 
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
index f5be8e22305b..f8212af0ba5e 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -21,8 +21,8 @@ bool efi_embedded_fw_checked;
 EXPORT_SYMBOL_NS_GPL(efi_embedded_fw_checked, TEST_FIRMWARE);
 
 static const struct dmi_system_id * const embedded_fw_table[] = {
-#ifdef CONFIG_TOUCHSCREEN_DMI
-	touchscreen_dmi_table,
+#ifdef CONFIG_DMI_DEVICE_PROPERTIES
+	dmi_device_properties,
 #endif
 	NULL
 };
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b110a2e6b8f3..9cb8d33cc6e1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -981,17 +981,19 @@ config MLX_PLATFORM
 
 	  If you have a Mellanox system, say Y or M here.
 
-config TOUCHSCREEN_DMI
-	bool "DMI based touchscreen configuration info"
-	depends on ACPI && DMI && I2C=y && TOUCHSCREEN_SILEAD
+config DMI_DEVICE_PROPERTIES
+	bool "DMI based extra device properties"
+	depends on ACPI && DMI && I2C=y
 	select EFI_EMBEDDED_FIRMWARE if EFI
 	help
-	  Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
-	  do not have enough data in ACPI tables for the touchscreen driver to
-	  handle the touchscreen properly, as OEMs expect the data to be baked
-	  into the tablet model specific version of the driver shipped with the
-	  the OS-image for the device. This option supplies the missing info.
-	  Enable this for x86 tablets with Silead or Chipone touchscreens.
+	  Sometimes ACPI based x86 devices do not have enough data in their ACPI
+	  tables to fully describe the hardware. This option enables support for
+	  supplying the missing info based on DMI (vendor & model string)
+	  matching for devices where this info has been added to the
+	  dmi-device-properties code.
+
+	  This option is often necessary for correct operation of x86 based
+	  tablets and 2-in-1 devices. If in doubt, say Y here.
 
 config FW_ATTR_CLASS
 	tristate
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 219478061683..3f610332b556 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -107,10 +107,10 @@ obj-$(CONFIG_SYSTEM76_ACPI)	+= system76_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
+obj-$(CONFIG_DMI_DEVICE_PROPERTIES)	+= dmi_device_properties.o
 obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
-obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/dmi_device_properties.c
similarity index 99%
rename from drivers/platform/x86/touchscreen_dmi.c
rename to drivers/platform/x86/dmi_device_properties.c
index b5d007875423..1bcd14a0bc78 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/dmi_device_properties.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Touchscreen driver DMI based configuration code
+ * DMI based device-property addition (adding info missing from ACPI tables)
  *
- * Copyright (c) 2017 Red Hat Inc.
+ * Copyright (c) 2017-2021 Red Hat Inc.
  *
  * Red Hat authors:
  * Hans de Goede <hdegoede@redhat.com>
@@ -979,7 +979,7 @@ static const struct ts_dmi_data vinga_twizzle_j116_data = {
 };
 
 /* NOTE: Please keep this table sorted alphabetically */
-const struct dmi_system_id touchscreen_dmi_table[] = {
+const struct dmi_system_id dmi_device_properties[] = {
 	{
 		/* Chuwi Hi8 */
 		.driver_data = (void *)&chuwi_hi8_data,
@@ -1633,7 +1633,7 @@ static int __init ts_dmi_init(void)
 	const struct dmi_system_id *dmi_id;
 	int error;
 
-	dmi_id = dmi_first_match(touchscreen_dmi_table);
+	dmi_id = dmi_first_match(dmi_device_properties);
 	if (!dmi_id)
 		return 0; /* Not an error */
 
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
index a97a12bb2c9e..01105c38a309 100644
--- a/include/linux/efi_embedded_fw.h
+++ b/include/linux/efi_embedded_fw.h
@@ -34,7 +34,7 @@ struct efi_embedded_fw_desc {
 	u8 sha256[32];
 };
 
-extern const struct dmi_system_id touchscreen_dmi_table[];
+extern const struct dmi_system_id dmi_device_properties[];
 
 int efi_get_embedded_fw(const char *name, const u8 **dat, size_t *sz);
 
-- 
2.31.1

