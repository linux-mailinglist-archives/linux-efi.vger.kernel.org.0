Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E54608AE
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359062AbhK1SYT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359121AbhK1SWO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGdHbLSyzw8O8liNh04PvxG2uc3HM+v3Jj+AjiKxwfg=;
        b=JSPBAn9Pt4nZgURQX8h50tmmWCiBJHj3rrWDPQZgFOhRxaFOVF9kJVR3N8uMJRSkxEtdoy
        lH2g2NyCluOCwu83LTJBXYplRVvAuBDDfTYvo9FaeMNyW5bQG+tCDMQgYcoeE91C/iV7ys
        NUiefzP/iNsxVDM+3mOsJdGhQd73hok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-G0FAp2u4Pd2z_ClODI8P7w-1; Sun, 28 Nov 2021 13:18:55 -0500
X-MC-Unique: G0FAp2u4Pd2z_ClODI8P7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B081E3E741;
        Sun, 28 Nov 2021 18:18:52 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 425BD10016F4;
        Sun, 28 Nov 2021 18:18:49 +0000 (UTC)
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
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 10/20] power: supply: bq25890: Add support for registering the Vbus boost converter as a regulator
Date:   Sun, 28 Nov 2021 19:17:59 +0100
Message-Id: <20211128181809.326736-11-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
index 2a420e77b4f1..750e0204e887 100644
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
@@ -841,6 +843,45 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
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
@@ -1040,6 +1081,22 @@ static int bq25890_probe(struct i2c_client *client,
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
@@ -1078,6 +1135,28 @@ static int bq25890_remove(struct i2c_client *client)
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
@@ -1157,6 +1236,7 @@ static struct i2c_driver bq25890_driver = {
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
2.33.1

