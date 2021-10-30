Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EDB440B2A
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhJ3Sbf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhJ3SbY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8ehFW74+rnLZNypt0ZkCrhURw1z4RaFbmbqdkI9heM=;
        b=WhvIQRj/z1TDrYypgRXRo0z/hZD0UK+4JnLeB7L0TiJPdw5K2ezJGCHcHdTWjRPdmjVWuc
        sVz3oOi9GDvV/CT7pEwbNi45vNkzUErO4qD7RdBqDpv5mV9yFLh45fZKa62AAQkEo6rdBb
        uRk7KGXi9eGyFA/i5dTHBwwJwyo6tXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-zGGXNK6_ODuxC9CQaVJyeQ-1; Sat, 30 Oct 2021 14:28:50 -0400
X-MC-Unique: zGGXNK6_ODuxC9CQaVJyeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 704CA1006AA2;
        Sat, 30 Oct 2021 18:28:48 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9CD5F4E1;
        Sat, 30 Oct 2021 18:28:45 +0000 (UTC)
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
Subject: [PATCH 10/13] power: supply: bq25890: Add support for registering the Vbus boost converter as a regulator
Date:   Sat, 30 Oct 2021 20:28:10 +0200
Message-Id: <20211030182813.116672-11-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The bq25890_charger code supports enabling/disabling the boost converter
based on usb-phy notifications. But the usb-phy framework is not used on
all boards/platforms. At support for registering the Vbus boost converter
as a standard regulator when there is no usb-phy on the board.

Also add support for providing regulator_init_data through platform_data
for use on boards where device-tree is not used and the platform code must
thus provide the regulator_init_data.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 56 ++++++++++++++++++++++++++
 include/linux/power/bq25890_charger.h  | 15 +++++++
 2 files changed, 71 insertions(+)
 create mode 100644 include/linux/power/bq25890_charger.h

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7504e30f1e4d..eaadb7a82c67 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -8,7 +8,9 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/power_supply.h>
+#include <linux/power/bq25890_charger.h>
 #include <linux/regmap.h>
+#include <linux/regulator/driver.h>
 #include <linux/types.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -817,6 +819,45 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_REGULATOR
+static int bq25890_vbus_enable(struct regulator_dev *rdev)
+{
+	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+
+	return bq25890_set_otg_cfg(bq, 1);
+}
+
+static int bq25890_vbus_disable(struct regulator_dev *rdev)
+{
+	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+
+	return bq25890_set_otg_cfg(bq, 0);
+}
+
+static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
+{
+	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+
+	return bq25890_field_read(bq, F_OTG_CFG);
+}
+
+static const struct regulator_ops bq25890_vbus_ops = {
+	.enable = bq25890_vbus_enable,
+	.disable = bq25890_vbus_disable,
+	.is_enabled = bq25890_vbus_is_enabled,
+};
+
+static const struct regulator_desc bq25890_vbus_desc = {
+	.name = "usb_otg_vbus",
+	.of_match = "usb-otg-vbus",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25890_vbus_ops,
+	.fixed_uV = 5000000,
+	.n_voltages = 1,
+};
+#endif
+
 static int bq25890_get_chip_version(struct bq25890_device *bq)
 {
 	int id, rev;
@@ -1018,6 +1059,21 @@ static int bq25890_probe(struct i2c_client *client,
 		INIT_WORK(&bq->usb_work, bq25890_usb_work);
 		bq->usb_nb.notifier_call = bq25890_usb_notifier;
 		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
+#ifdef CONFIG_REGULATOR
+	} else {
+		struct bq25890_platform_data *pdata = dev_get_platdata(dev);
+		struct regulator_config cfg = { };
+		struct regulator_dev *reg;
+
+		cfg.dev = dev;
+		cfg.driver_data = bq;
+		if (pdata)
+			cfg.init_data = pdata->regulator_init_data;
+
+		reg = devm_regulator_register(dev, &bq25890_vbus_desc, &cfg);
+		if (IS_ERR(reg))
+			return dev_err_probe(dev, PTR_ERR(reg), "registering regulator");
+#endif
 	}
 
 	ret = bq25890_power_supply_init(bq);
diff --git a/include/linux/power/bq25890_charger.h b/include/linux/power/bq25890_charger.h
new file mode 100644
index 000000000000..8a36c0d787c7
--- /dev/null
+++ b/include/linux/power/bq25890_charger.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Platform data for the TI bq25890 battery charger driver.
+ */
+
+#ifndef _BQ25890_CHARGER_H_
+#define _BQ25890_CHARGER_H_
+
+#include <linux/regulator/machine.h>
+
+struct bq25890_platform_data {
+	const struct regulator_init_data *regulator_init_data;
+};
+
+#endif
-- 
2.31.1

