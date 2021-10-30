Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144A4440B05
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJ3SbB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhJ3SbA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfAWTpqD6xHOwrNh8jWCx0PvwaLrx5zHt5cmNcz+EB4=;
        b=gT5bK1xoxhnJTlQ0XvieLU0azomyAtkwiY9MK0EDuhswm2gdFfY6lMeAE/T40Fz3fzyAy0
        UfXCe92NCSzXtemn4wLALk/A9hdPoldQ1mMWgsC+BcbjhcK4TQKJWilkwGy7AR1s3q0uXf
        Mfd25SSuReKzMmu8PhPi3zgTwQhCGDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-0DSIdl-dOsOrGj5SanVZcw-1; Sat, 30 Oct 2021 14:28:25 -0400
X-MC-Unique: 0DSIdl-dOsOrGj5SanVZcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD15210055BC;
        Sat, 30 Oct 2021 18:28:23 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08E915F4E1;
        Sat, 30 Oct 2021 18:28:20 +0000 (UTC)
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
Subject: [PATCH 02/13] platform/x86: dmi_device_properties: Add setup info for boards with a CHT Whiskey Cove PMIC
Date:   Sat, 30 Oct 2021 20:28:02 +0200
Message-Id: <20211030182813.116672-3-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new "intel,cht-wc-setup" string property to the "INT34D3:00"
i2c_client for the Whiskey Cove PMIC found on several Cherry Trail
based devices. At least 3 setups are known:

1. The WC PMIC is connected to a TI BQ24292i charger, paired with
   a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
   a PI3USB30532 USB switch, for a fully functional Type-C port

2. The WC PMIC is connected to a TI BQ25890 charger, paired with
   a TI BQ27520 fuelgauge, for a USB-2 only Type-C port without PD

3. The WC PMIC is connected to a TI BQ25890 charger, paired with
   a TI BQ27542 fuelgauge, for a micro-USB port

Which setup is in use cannot be determined reliably from the ACPI tables
and various drivers (extcon-intel-cht-wc.c, i2c-cht-wc.c, ...) need
to know which setup they are dealing with.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/dmi_device_properties.c | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/platform/x86/dmi_device_properties.c b/drivers/platform/x86/dmi_device_properties.c
index 1bcd14a0bc78..bd973afbde5f 100644
--- a/drivers/platform/x86/dmi_device_properties.c
+++ b/drivers/platform/x86/dmi_device_properties.c
@@ -387,6 +387,16 @@ static const struct ts_dmi_data gp_electronic_t701_data = {
 	.properties	= gp_electronic_t701_props,
 };
 
+static const struct property_entry gpd_win_pocket_props[] = {
+	PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq24292i,max17047,fusb302,pi3usb30532"),
+	{ }
+};
+
+static const struct ts_dmi_data gpd_win_pocket_data = {
+	.acpi_name      = "INT34D3:00",
+	.properties     = gpd_win_pocket_props,
+};
+
 static const struct property_entry irbis_tw90_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1138),
@@ -978,6 +988,16 @@ static const struct ts_dmi_data vinga_twizzle_j116_data = {
 	.properties	= vinga_twizzle_j116_props,
 };
 
+static const struct property_entry xiaomi_mi_pad2_props[] = {
+	PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq25890,bq27520"),
+	{ }
+};
+
+static const struct ts_dmi_data xiaomi_mi_pad2_data = {
+	.acpi_name      = "INT34D3:00",
+	.properties     = xiaomi_mi_pad2_props,
+};
+
 /* NOTE: Please keep this table sorted alphabetically */
 const struct dmi_system_id dmi_device_properties[] = {
 	{
@@ -1166,6 +1186,24 @@ const struct dmi_system_id dmi_device_properties[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
 		},
 	},
+	{
+		/* GPD win / GPD pocket mini laptops */
+		.driver_data = (void *)&gpd_win_pocket_data,
+		/*
+		 * Note this may not seem like a very unique match, but in the
+		 * 24000+ DMI decode dumps from linux-hardware.org only 42 have
+		 * a board_vendor value of "AMI Corporation" and of those 42
+		 * only 1 (the GPD win/pocket entry) has a board_name of
+		 * "Default string". Also few devices have both board_ and
+		 * product_name not set.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		},
+	},
 	{
 		/* Irbis TW90 */
 		.driver_data = (void *)&irbis_tw90_data,
@@ -1578,6 +1616,14 @@ const struct dmi_system_id dmi_device_properties[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "TW700")
 		},
 	},
+	{
+		/* Xiaomi Mi Pad 2 */
+		.driver_data = (void *)&xiaomi_mi_pad2_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	},
 	{
 		/* Yours Y8W81, same case and touchscreen as Chuwi Vi8 */
 		.driver_data = (void *)&chuwi_vi8_data,
-- 
2.31.1

