Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DF4CBE10
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfJDOwP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOwO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2373489F39E;
        Fri,  4 Oct 2019 14:52:14 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D994B5C1D8;
        Fri,  4 Oct 2019 14:52:06 +0000 (UTC)
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
Subject: [PATCH v7 8/8] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date:   Fri,  4 Oct 2019 16:50:56 +0200
Message-Id: <20191004145056.43267-9-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 04 Oct 2019 14:52:14 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
Chipone ICN8505 touchscreen controller, with the firmware used by the
touchscreen embedded in the EFI firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Remove PROPERTY_ENTRY_BOOL("efi-embedded-firmware") properties entry,
  as this is no longer necessary

Changes in v6:
- Switch from crc sums to SHA256 hashes for the firmware hash
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 8a7d5c8df114..8bfef880e216 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -132,6 +132,18 @@ static const struct ts_dmi_data chuwi_vi8_data = {
 	.properties     = chuwi_vi8_props,
 };
 
+static const struct ts_dmi_data chuwi_vi8_plus_data = {
+	.embedded_fw = {
+		.name	= "chipone/icn8505-HAMP0002.fw",
+		.prefix = { 0xb0, 0x07, 0x00, 0x00, 0xe4, 0x07, 0x00, 0x00 },
+		.length	= 35012,
+		.sha256	= { 0x93, 0xe5, 0x49, 0xe0, 0xb6, 0xa2, 0xb4, 0xb3,
+			    0x88, 0x96, 0x34, 0x97, 0x5e, 0xa8, 0x13, 0x78,
+			    0x72, 0x98, 0xb8, 0x29, 0xeb, 0x5c, 0xa7, 0xf1,
+			    0x25, 0x13, 0x43, 0xf4, 0x30, 0x7c, 0xfc, 0x7c },
+	},
+};
+
 static const struct property_entry chuwi_vi10_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 0),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 4),
@@ -709,6 +721,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 Plus (CWI519) */
+		.driver_data = (void *)&chuwi_vi8_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.driver_data = (void *)&chuwi_vi10_data,
@@ -1085,6 +1106,9 @@ static int __init ts_dmi_init(void)
 		return 0; /* Not an error */
 
 	ts_data = dmi_id->driver_data;
+	/* Some dmi table entries only provide an efi_embedded_fw_desc */
+	if (!ts_data->properties)
+		return 0;
 
 	error = bus_register_notifier(&i2c_bus_type, &ts_dmi_notifier);
 	if (error)
-- 
2.23.0

