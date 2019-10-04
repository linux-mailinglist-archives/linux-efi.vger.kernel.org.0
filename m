Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A093CBE0F
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfJDOwH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOwH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 700A330860CF;
        Fri,  4 Oct 2019 14:52:06 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2A895C1D8;
        Fri,  4 Oct 2019 14:52:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v7 7/8] platform/x86: touchscreen_dmi: Add EFI embedded firmware info support
Date:   Fri,  4 Oct 2019 16:50:55 +0200
Message-Id: <20191004145056.43267-8-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 04 Oct 2019 14:52:06 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sofar we have been unable to get permission from the vendors to put the
firmware for touchscreens listed in touchscreen_dmi in linux-firmware.

Some of the tablets with such a touchscreen have a touchscreen driver, and
thus a copy of the firmware, as part of their EFI code.

This commit adds the necessary info for the new EFI embedded-firmware code
to extract these firmwares, making the touchscreen work OOTB without the
user needing to manually add the firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Remove adding of PROPERTY_ENTRY_BOOL("efi-embedded-firmware"), to touchscreen
  props, as this is no longer necessary

Changes in v6:
- Switch from crc sums to SHA256 hashes for the firmware hashes
---
 drivers/firmware/efi/embedded-firmware.c |  3 ++
 drivers/platform/x86/Kconfig             |  1 +
 drivers/platform/x86/touchscreen_dmi.c   | 41 +++++++++++++++++++++++-
 include/linux/efi_embedded_fw.h          |  2 ++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
index 75d652f3148b..8038995fd258 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -24,6 +24,9 @@ struct embedded_fw {
 static LIST_HEAD(found_fw_list);
 
 static const struct dmi_system_id * const embedded_fw_table[] = {
+#ifdef CONFIG_TOUCHSCREEN_DMI
+	touchscreen_dmi_table,
+#endif
 	NULL
 };
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ae21d08c65e8..583af56d8bfa 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1251,6 +1251,7 @@ config INTEL_TURBO_MAX_3
 config TOUCHSCREEN_DMI
 	bool "DMI based touchscreen configuration info"
 	depends on ACPI && DMI && I2C=y && TOUCHSCREEN_SILEAD
+	select EFI_EMBEDDED_FIRMWARE if EFI
 	---help---
 	  Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
 	  do not have enough data in ACPI tables for the touchscreen driver to
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 1c7d8324ff5c..8a7d5c8df114 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -11,12 +11,15 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/efi_embedded_fw.h>
 #include <linux/i2c.h>
 #include <linux/notifier.h>
 #include <linux/property.h>
 #include <linux/string.h>
 
 struct ts_dmi_data {
+	/* The EFI embedded-fw code expects this to be the first member! */
+	struct efi_embedded_fw_desc embedded_fw;
 	const char *acpi_name;
 	const struct property_entry *properties;
 };
@@ -64,6 +67,15 @@ static const struct property_entry chuwi_hi8_pro_props[] = {
 };
 
 static const struct ts_dmi_data chuwi_hi8_pro_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3680-chuwi-hi8-pro.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 39864,
+		.sha256	= { 0xc0, 0x88, 0xc5, 0xef, 0xd1, 0x70, 0x77, 0x59,
+			    0x4e, 0xe9, 0xc4, 0xd8, 0x2e, 0xcd, 0xbf, 0x95,
+			    0x32, 0xd9, 0x03, 0x28, 0x0d, 0x48, 0x9f, 0x92,
+			    0x35, 0x37, 0xf6, 0x8b, 0x2a, 0xe4, 0x73, 0xff },
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= chuwi_hi8_pro_props,
 };
@@ -181,6 +193,15 @@ static const struct property_entry cube_iwork8_air_props[] = {
 };
 
 static const struct ts_dmi_data cube_iwork8_air_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3670-cube-iwork8-air.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 38808,
+		.sha256	= { 0xff, 0x62, 0x2d, 0xd1, 0x8a, 0x78, 0x04, 0x7b,
+			    0x33, 0x06, 0xb0, 0x4f, 0x7f, 0x02, 0x08, 0x9c,
+			    0x96, 0xd4, 0x9f, 0x04, 0xe1, 0x47, 0x25, 0x25,
+			    0x60, 0x77, 0x41, 0x33, 0xeb, 0x12, 0x82, 0xfc },
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= cube_iwork8_air_props,
 };
@@ -374,6 +395,15 @@ static const struct property_entry onda_v80_plus_v3_props[] = {
 };
 
 static const struct ts_dmi_data onda_v80_plus_v3_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3676-onda-v80-plus-v3.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 37224,
+		.sha256	= { 0x8f, 0xbd, 0x8f, 0x0c, 0x6b, 0xba, 0x5b, 0xf5,
+			    0xa3, 0xc7, 0xa3, 0xc0, 0x4f, 0xcd, 0xdf, 0x32,
+			    0xcc, 0xe4, 0x70, 0xd6, 0x46, 0x9c, 0xd7, 0xa7,
+			    0x4b, 0x82, 0x3f, 0xab, 0xc7, 0x90, 0xea, 0x23 },
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= onda_v80_plus_v3_props,
 };
@@ -440,6 +470,15 @@ static const struct property_entry pipo_w2s_props[] = {
 };
 
 static const struct ts_dmi_data pipo_w2s_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl1680-pipo-w2s.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 39072,
+		.sha256	= { 0xd0, 0x58, 0xc4, 0x7d, 0x55, 0x2d, 0x62, 0x18,
+			    0xd1, 0x6a, 0x71, 0x73, 0x0b, 0x3f, 0xbe, 0x60,
+			    0xbb, 0x45, 0x8c, 0x52, 0x27, 0xb7, 0x18, 0xf4,
+			    0x31, 0x00, 0x6a, 0x49, 0x76, 0xd8, 0x7c, 0xd3 },
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= pipo_w2s_props,
 };
@@ -608,7 +647,7 @@ static const struct ts_dmi_data trekstor_surftab_wintron70_data = {
 };
 
 /* NOTE: Please keep this table sorted alphabetically */
-static const struct dmi_system_id touchscreen_dmi_table[] = {
+const struct dmi_system_id touchscreen_dmi_table[] = {
 	{
 		/* Chuwi Hi8 */
 		.driver_data = (void *)&chuwi_hi8_data,
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
index ac70ff146d58..1ca4206ee006 100644
--- a/include/linux/efi_embedded_fw.h
+++ b/include/linux/efi_embedded_fw.h
@@ -20,6 +20,8 @@ struct efi_embedded_fw_desc {
 	u8 sha256[32];
 };
 
+extern const struct dmi_system_id touchscreen_dmi_table[];
+
 int efi_get_embedded_fw(const char *name, void **dat, size_t *sz);
 
 #endif
-- 
2.23.0

