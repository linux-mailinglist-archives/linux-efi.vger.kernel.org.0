Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1B44F972
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhKNRIj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236260AbhKNRHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQMG15WrD+SpaKEYHtpgquyp9rViWR4bcOU93QQhbm0=;
        b=WhVi63H9PxkQ1wlnotu7B2KY92e6WGxCyMBSVHwEwA4yk9AvpmpUUwhKD6WnQa03Qapu2T
        iFKBFIbpGGgqYGIJAMSM1XAITsvt0x2KMpVyx/th+fV5tg5yF0wmHMlFTESk7CWwYzGpJv
        410vcs0rSrr2Gx67yNQsC7JpbhZw/1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-A12mLeL2MYuSc6VUlOazAw-1; Sun, 14 Nov 2021 12:04:24 -0500
X-MC-Unique: A12mLeL2MYuSc6VUlOazAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65DAD180831E;
        Sun, 14 Nov 2021 17:04:22 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5B301346F;
        Sun, 14 Nov 2021 17:04:18 +0000 (UTC)
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
Subject: [PATCH v2 11/20] power: supply: bq25890: Add support for registering the Vbus boost converter as a regulator
Date:   Sun, 14 Nov 2021 18:03:26 +0100
Message-Id: <20211114170335.66994-12-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Changes in v2:
- When the usb-phy framework is not used, turn off the Vboost regulator
  on shutdown
- Some minor code-tweaks based on Andy's review
---
 drivers/power/supply/bq25890_charger.c | 80 ++++++++++++++++++++++++++
 include/linux/power/bq25890_charger.h  | 15 +++++
 2 files changed, 95 insertions(+)
 create mode 100644 include/linux/power/bq25890_charger.h

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 3c41fe86b3d3..e06ca7b0eb3e 100644
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
@@ -845,6 +847,45 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
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
@@ -1044,6 +1085,22 @@ static int bq25890_probe(struct i2c_client *client,
 		bq->usb_nb.notifier_call = bq25890_usb_notifier;
 		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
 	}
+#ifdef CONFIG_REGULATOR
+	else {
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
+	}
+#endif
 
 	ret = bq25890_power_supply_init(bq);
 	if (ret < 0) {
@@ -1082,6 +1139,28 @@ static int bq25890_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void bq25890_shutdown(struct i2c_client *client)
+{
+	struct bq25890_device *bq = i2c_get_clientdata(client);
+
+	/*
+	 * TODO this if + return should probably be removed, but that would
+	 * introduce a function change for boards using the usb-phy framework.
+	 * This needs to be tested on such a board before making this change.
+	 */
+	if (!IS_ERR_OR_NULL(bq->usb_phy))
+		return;
+
+	/*
+	 * Turn off the 5v Boost regulator which outputs Vbus to the device's
+	 * Micro-USB or Type-C USB port. Leaving this on drains power and
+	 * this avoids the PMIC on some device-models seeing this as Vbus
+	 * getting inserted after shutdown, causing the device to immediately
+	 * power-up again.
+	 */
+	bq25890_set_otg_cfg(bq, 0);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int bq25890_suspend(struct device *dev)
 {
@@ -1161,6 +1240,7 @@ static struct i2c_driver bq25890_driver = {
 	},
 	.probe = bq25890_probe,
 	.remove = bq25890_remove,
+	.shutdown = bq25890_shutdown,
 	.id_table = bq25890_i2c_ids,
 };
 module_i2c_driver(bq25890_driver);
diff --git a/include/linux/power/bq25890_charger.h b/include/linux/power/bq25890_charger.h
new file mode 100644
index 000000000000..c706ddb77a08
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
+struct regulator_init_data;
+
+struct bq25890_platform_data {
+	const struct regulator_init_data *regulator_init_data;
+};
+
+#endif
-- 
2.31.1

