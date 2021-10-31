Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29367440F6E
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhJaQ1y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhJaQ1b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43RHVcXzgVdUhw+/pZf5mkYqD1b97Ig5TszqYmG6xeA=;
        b=N+ZNmz4mNxIhiY5QghL4lBZBcoRiCwuRthcUmATn3IUce57xxozFXS9NXY7b9xDg8/ICte
        RRgEgITktsHnORqSrm8KuudDsqrwfYruPTfOkW6sKAk5XMeJ0DNekQz9ElgKRyjULImNJH
        L8WWcWKdEf1q95a5uimIJmKIYEhtlOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-jSV6xw2DNWecYeYNoZm9ug-1; Sun, 31 Oct 2021 12:24:54 -0400
X-MC-Unique: jSV6xw2DNWecYeYNoZm9ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FDF210A8E00;
        Sun, 31 Oct 2021 16:24:51 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 446AB100763D;
        Sun, 31 Oct 2021 16:24:48 +0000 (UTC)
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
Subject: [RFC 5/5] power: supply: bq27xxx: Add support for ACPI enumeration
Date:   Sun, 31 Oct 2021 17:24:28 +0100
Message-Id: <20211031162428.22368-6-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
References: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some x86/ACPI devices with a bq27xxx fuel-gauge do not use the standard
ACPI battery API for battery monitoring. Instead they have an ACPI
device describing the actual fuel-gauge IC and expect the OS to have
a native driver for the fuel-gauge.

Add support for such ACPI enumerated bq27xxx fuel-gauges.

To get the fuel-gauge to work properly on ACPI devs 3 changes are needed:

1. Add an acpi_match_table and set di->chip based on this, note the
   new "if (id) check also fixes a NULL pointer deref when someone tries to
   manually bind the driver from sysfs.

2. When the charger IC has external power applied or removed, the psy-core
   should call bq27xxx_external_power_changed(). This requires a valid
   consumer<->supplier link between the charger and the fuel-gauge
   power-supplies. For ACPI enumerated fuel-gauges this link is missing.

   The charger-ICs used on these devices already contain a special
   power_supply_config.supplied_to default set to "main-battery".
   This commit makes use of this by setting the power-supply's name to
   "main-battery" when enumerated by ACPI, to establish the missing
   consumer<->supplier link.

3. Sometimes the irqflags in the ACPI tables are no good, override them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 38 ++++++++++++++++++----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 0a1b922389e1..c3fe1e4b08bd 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -139,8 +140,10 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
+	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &client->dev;
 	struct bq27xxx_device_info *di;
+	unsigned long irqflags = 0;
 	int ret;
 	char *name;
 	int num;
@@ -152,17 +155,31 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	if (num < 0)
 		return num;
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", id->name, num);
-	if (!name)
-		goto err_mem;
-
 	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
 		goto err_mem;
 
+	if (id) {
+		di->chip = id->driver_data;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!acpi_id)
+			return -ENODEV;
+
+		irqflags = IRQF_TRIGGER_RISING;
+		di->chip = acpi_id->driver_data;
+	}
+
+	if (acpi_id && num == 0) {
+		name = "main-battery";
+	} else {
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", id->name, num);
+		if (!name)
+			goto err_mem;
+	}
+
 	di->id = num;
 	di->dev = dev;
-	di->chip = id->driver_data;
 	di->name = name;
 
 	di->bus.read = bq27xxx_battery_i2c_read;
@@ -182,7 +199,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
-				IRQF_ONESHOT,
+				irqflags | IRQF_ONESHOT,
 				di->name, di);
 		if (ret) {
 			dev_err(dev, "Unable to register IRQ %d error %d\n",
@@ -292,10 +309,19 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id bq27xxx_acpi_match[] = {
+	{ "TXN27520", BQ2752X },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, bq27xxx_acpi_match);
+#endif
+
 static struct i2c_driver bq27xxx_battery_i2c_driver = {
 	.driver = {
 		.name = "bq27xxx-battery",
 		.of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
+		.acpi_match_table = ACPI_PTR(bq27xxx_acpi_match),
 	},
 	.probe = bq27xxx_battery_i2c_probe,
 	.remove = bq27xxx_battery_i2c_remove,
-- 
2.31.1

