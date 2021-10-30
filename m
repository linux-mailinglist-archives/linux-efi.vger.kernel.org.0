Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B03440B34
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhJ3Sbr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhJ3Sba (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUspNMepzsV3gt9zAr51OvvfE1pc4mjqmhHE949y10A=;
        b=dSxPjegt8g74fOQjUKx69ULv0t6SQfw34ctB4es4z2ZfxDFe20jDhyYK3+Znl2PAuxP+w6
        yoql4gNAe+BkjHK6KL9I84GTIT038KvceC4CDhRNPPsCAuju+0jc52orQx13khUIS/MWTj
        GDg5Y0XDkjHVDdRFHuxlp/htzQdFwqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-bnG8VKYiNyujiy2At0-kPA-1; Sat, 30 Oct 2021 14:28:53 -0400
X-MC-Unique: bnG8VKYiNyujiy2At0-kPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5048018AC;
        Sat, 30 Oct 2021 18:28:51 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B83845F4E1;
        Sat, 30 Oct 2021 18:28:48 +0000 (UTC)
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
Subject: [PATCH 11/13] i2c: cht-wc: Add support for devices using a bq25890 charger
Date:   Sat, 30 Oct 2021 20:28:11 +0200
Message-Id: <20211030182813.116672-12-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
in that it is always connected to the I2C charger IC of the board on
which the PMIC is used; and the charger IC is not described in ACPI,
so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.

So far there has been a rudimentary check to make sure the ACPI tables
are at least somewhat as expected by checking for the presence of an
INT33FE device and sofar the code has assumed that if this INT33FE
device is present that the used charger then is a bq24290i.

But some boards with an INT33FE device in their ACPI tables use a
different charger IC and some boards don't have an INT33FE device at all.

Since the information about the used charger + fuel-gauge + other chips is
necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
which reliably describes the board's setup of the PMIC.

Switch to using the "intel,cht-wc-setup" property and add support for
instantiating an i2c-client for either a bq24292i or a bq25890 charger.

This has been tested on a GPD pocket (which uses the old bq24292i setup)
and on a Xiaomi Mi Pad 2 with a bq25890 charger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 77 +++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 1cf68f85b2e1..e7d62af6c39d 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/bq24190_charger.h>
+#include <linux/power/bq25890_charger.h>
 #include <linux/slab.h>
 
 #define CHT_WC_I2C_CTRL			0x5e24
@@ -304,18 +305,55 @@ static struct bq24190_platform_data bq24190_pdata = {
 	.regulator_init_data = &bq24190_vbus_init_data,
 };
 
+static struct i2c_board_info bq24190_board_info = {
+	.type = "bq24190",
+	.addr = 0x6b,
+	.dev_name = "bq24190",
+	.swnode = &bq24190_node,
+	.platform_data = &bq24190_pdata,
+};
+
+static struct regulator_consumer_supply bq25890_vbus_consumer = {
+	.supply = "vbus",
+	.dev_name = "cht_wcove_pwrsrc",
+};
+
+static const struct regulator_init_data bq25890_vbus_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = &bq25890_vbus_consumer,
+	.num_consumer_supplies = 1,
+};
+
+static struct bq25890_platform_data bq25890_pdata = {
+	.regulator_init_data = &bq25890_vbus_init_data,
+};
+
+static const struct property_entry bq25890_props[] = {
+	PROPERTY_ENTRY_BOOL("ti,skip-init"),
+	{ }
+};
+
+static const struct software_node bq25890_node = {
+	.properties = bq25890_props,
+};
+
+static struct i2c_board_info bq25890_board_info = {
+	.type = "bq25890",
+	.addr = 0x6a,
+	.dev_name = "bq25890",
+	.swnode = &bq25890_node,
+	.platform_data = &bq25890_pdata,
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
+	const char *str;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -379,17 +417,20 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
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
+	ret = device_property_read_string(pdev->dev.parent, "intel,cht-wc-setup", &str);
+	if (ret)
+		dev_warn(&pdev->dev, "intel,cht-wc-setup not set, not instantiating charger device\n");
+	else if (!strcmp(str, "bq24292i,max17047,fusb302,pi3usb30532"))
+		board_info = &bq24190_board_info;
+	else if (!strcmp(str, "bq25890,bq27520"))
+		board_info = &bq25890_board_info;
+	else
+		dev_warn(&pdev->dev, "Unknown intel,cht-wc-setup value: '%s', not instantiating charger device\n",
+			 str);
+
+	if (board_info) {
+		board_info->irq = adap->client_irq;
+		adap->client = i2c_new_client_device(&adap->adapter, board_info);
 		if (IS_ERR(adap->client)) {
 			ret = PTR_ERR(adap->client);
 			goto del_adapter;
-- 
2.31.1

