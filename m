Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006364A394D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbiA3Urn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356337AbiA3Urg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmrPouzyJORqeW8YegyrXzTKKZke8QnXRejNnVcuGaU=;
        b=hhUvXkipZehQyGM+r9CcqdgQqtsq13PTrNESoL5M2QVnxJrJFEXcaMA5V/jKid10Wb0nj+
        2S3kkj6qoihVWtZqxrMFIKARaqjkXELerktKMbVtsEM9mLlD90QxFksRQVNZNe+HGqNY8c
        ofSOwJeLKo7qiKnxEw+/XVqAc921v9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-VxhSskVmOBWCJDjWgcUC6A-1; Sun, 30 Jan 2022 15:47:32 -0500
X-MC-Unique: VxhSskVmOBWCJDjWgcUC6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD5F18397A7;
        Sun, 30 Jan 2022 20:47:29 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7121C61093;
        Sun, 30 Jan 2022 20:47:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 15/20] i2c: cht-wc: Make charger i2c-client instantiation board/device-model specific
Date:   Sun, 30 Jan 2022 21:45:52 +0100
Message-Id: <20220130204557.15662-16-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
in that it is always connected to the I2C charger IC of the board on
which the PMIC is used; and the charger IC is not described in ACPI,
so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.

So far this was hardcoded to instantiate an i2c-client for the
bq24292i, with all properties, etc. set to match how this charger
is used on the GPD win and GPD pocket devices.

There is a rudimentary check to make sure the ACPI tables are at least
somewhat as expected, but this is far from accurate, leading to
a wrong i2c-client being instantiated for the charger on some boards.

Switch to the new DMI based intel_cht_wc_get_model() helper which is
exported by the MFD driver for the CHT Whiskey Cove PMIC to help PMIC
cell drivers like the i2c-cht-wc code reliably detect which board
they are running on.

And add board_info for the charger ICs as found on the other 2 known
boards with a Whisky Cove PMIC.

This has been tested on all 3 known boards.

Acked-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add Wolfram's Ack for taking this upstream through another tree
  then the i2c tree
- Some minor tweaks / spelling fixes based on Andy's review
---
 drivers/i2c/busses/i2c-cht-wc.c | 120 +++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 1cf68f85b2e1..54e909f9eab6 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/bq24190_charger.h>
+#include <linux/power/bq25890_charger.h>
 #include <linux/slab.h>
 
 #define CHT_WC_I2C_CTRL			0x5e24
@@ -270,6 +271,7 @@ static const struct irq_chip cht_wc_i2c_irq_chip = {
 	.name			= "cht_wc_ext_chrg_irq_chip",
 };
 
+/********** GPD Win / Pocket charger IC settings **********/
 static const char * const bq24190_suppliers[] = {
 	"tcpm-source-psy-i2c-fusb302" };
 
@@ -304,17 +306,92 @@ static struct bq24190_platform_data bq24190_pdata = {
 	.regulator_init_data = &bq24190_vbus_init_data,
 };
 
+static struct i2c_board_info gpd_win_board_info = {
+	.type = "bq24190",
+	.addr = 0x6b,
+	.dev_name = "bq24190",
+	.swnode = &bq24190_node,
+	.platform_data = &bq24190_pdata,
+};
+
+/********** Xiaomi Mi Pad 2 charger IC settings  **********/
+static struct regulator_consumer_supply bq2589x_vbus_consumer = {
+	.supply = "vbus",
+	.dev_name = "cht_wcove_pwrsrc",
+};
+
+static const struct regulator_init_data bq2589x_vbus_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = &bq2589x_vbus_consumer,
+	.num_consumer_supplies = 1,
+};
+
+static struct bq25890_platform_data bq2589x_pdata = {
+	.regulator_init_data = &bq2589x_vbus_init_data,
+};
+
+static const struct property_entry xiaomi_mipad2_props[] = {
+	PROPERTY_ENTRY_BOOL("linux,skip-reset"),
+	PROPERTY_ENTRY_BOOL("linux,read-back-settings"),
+	{ }
+};
+
+static const struct software_node xiaomi_mipad2_node = {
+	.properties = xiaomi_mipad2_props,
+};
+
+static struct i2c_board_info xiaomi_mipad2_board_info = {
+	.type = "bq25890",
+	.addr = 0x6a,
+	.dev_name = "bq25890",
+	.swnode = &xiaomi_mipad2_node,
+	.platform_data = &bq2589x_pdata,
+};
+
+/********** Lenovo Yogabook YB1-X90F/-X91F/-X91L charger settings **********/
+static const char * const lenovo_yb1_bq25892_suppliers[] = { "cht_wcove_pwrsrc" };
+
+static const struct property_entry lenovo_yb1_bq25892_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from",
+				    lenovo_yb1_bq25892_suppliers),
+	PROPERTY_ENTRY_U32("linux,pump-express-vbus-max", 12000000),
+	PROPERTY_ENTRY_BOOL("linux,skip-reset"),
+	/*
+	 * The firmware sets everything to the defaults, which leads to a
+	 * somewhat low charge-current of 2048mA and worse to a battery-voltage
+	 * of 4.2V instead of 4.35V (when booted without a charger connected).
+	 * Use our own values instead of "linux,read-back-settings" to fix this.
+	 */
+	PROPERTY_ENTRY_U32("ti,charge-current", 4224000),
+	PROPERTY_ENTRY_U32("ti,battery-regulation-voltage", 4352000),
+	PROPERTY_ENTRY_U32("ti,termination-current", 256000),
+	PROPERTY_ENTRY_U32("ti,precharge-current", 128000),
+	PROPERTY_ENTRY_U32("ti,minimum-sys-voltage", 3500000),
+	PROPERTY_ENTRY_U32("ti,boost-voltage", 4998000),
+	PROPERTY_ENTRY_U32("ti,boost-max-current", 1400000),
+	PROPERTY_ENTRY_BOOL("ti,use-ilim-pin"),
+	{ }
+};
+
+static const struct software_node lenovo_yb1_bq25892_node = {
+	.properties = lenovo_yb1_bq25892_props,
+};
+
+static struct i2c_board_info lenovo_yogabook1_board_info = {
+	.type = "bq25892",
+	.addr = 0x6b,
+	.dev_name = "bq25892",
+	.swnode = &lenovo_yb1_bq25892_node,
+	.platform_data = &bq2589x_pdata,
+};
+
 static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_board_info *board_info = NULL;
 	struct cht_wc_i2c_adap *adap;
-	struct i2c_board_info board_info = {
-		.type = "bq24190",
-		.addr = 0x6b,
-		.dev_name = "bq24190",
-		.swnode = &bq24190_node,
-		.platform_data = &bq24190_pdata,
-	};
 	int ret, reg, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -379,17 +456,24 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_irq_domain;
 
-	/*
-	 * Normally the Whiskey Cove PMIC is paired with a TI bq24292i charger,
-	 * connected to this i2c bus, and a max17047 fuel-gauge and a fusb302
-	 * USB Type-C controller connected to another i2c bus. In this setup
-	 * the max17047 and fusb302 devices are enumerated through an INT33FE
-	 * ACPI device. If this device is present register an i2c-client for
-	 * the TI bq24292i charger.
-	 */
-	if (acpi_dev_present("INT33FE", NULL, -1)) {
-		board_info.irq = adap->client_irq;
-		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
+	switch (pmic->cht_wc_model) {
+	case INTEL_CHT_WC_GPD_WIN_POCKET:
+		board_info = &gpd_win_board_info;
+		break;
+	case INTEL_CHT_WC_XIAOMI_MIPAD2:
+		board_info = &xiaomi_mipad2_board_info;
+		break;
+	case INTEL_CHT_WC_LENOVO_YOGABOOK1:
+		board_info = &lenovo_yogabook1_board_info;
+		break;
+	default:
+		dev_warn(&pdev->dev, "Unknown model, not instantiating charger device\n");
+		break;
+	}
+
+	if (board_info) {
+		board_info->irq = adap->client_irq;
+		adap->client = i2c_new_client_device(&adap->adapter, board_info);
 		if (IS_ERR(adap->client)) {
 			ret = PTR_ERR(adap->client);
 			goto del_adapter;
-- 
2.33.1

