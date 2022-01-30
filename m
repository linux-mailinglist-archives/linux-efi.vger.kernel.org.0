Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A34A3913
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356177AbiA3UqT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356165AbiA3UqP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYS2h3p3lpBeNwIUetzv1DXvJEBFhFws3NDxYu0MJ1g=;
        b=ax5bRU+ThNmffqbK4y7er02OQPu8RuVWfAWtbSOING8cmCFvteJM/8j4O9al8Vrl7RdGLY
        IC4vzqdB1/ONPO4SwuMlLJ10oD8u5Z8haJfmFyJiXu8v5CfPod+Oo4+re1ikwBzftC4V8t
        PXPAjPHDMNI2PuINuHKKc2Wg28j2+FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-apOBWIddMvSpO7jPE8CdGg-1; Sun, 30 Jan 2022 15:46:09 -0500
X-MC-Unique: apOBWIddMvSpO7jPE8CdGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479F22F25;
        Sun, 30 Jan 2022 20:46:07 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F12161093;
        Sun, 30 Jan 2022 20:46:02 +0000 (UTC)
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
Subject: [PATCH v4 01/20] power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
Date:   Sun, 30 Jan 2022 21:45:38 +0100
Message-Id: <20220130204557.15662-2-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some (USB) charger ICs have variants with USB D+ and D- pins to do their
own builtin charger-type detection, like e.g. the bq24190 and bq25890 and
also variants which lack this functionality, e.g. the bq24192 and bq25892.

In case the charger-type; and thus the input-current-limit detection is
done outside the charger IC then we need some way to communicate this to
the charger IC. In the past extcon was used for this, but if the external
detection does e.g. full USB PD negotiation then the extcon cable-types do
not convey enough information.

For these setups it was decided to model the external charging "brick"
and the parameters negotiated with it as a power_supply class-device
itself; and power_supply_set_input_current_limit_from_supplier() was
introduced to allow drivers to get the input-current-limit this way.

But in some cases psy drivers may want to know other properties, e.g. the
bq25892 can do "quick-charge" negotiation by pulsing its current draw,
but this should only be done if the usb_type psy-property of its supplier
is set to DCP (and device-properties indicate the board allows higher
voltages).

Instead of adding extra helper functions for each property which
a psy-driver wants to query from its supplier, refactor
power_supply_set_input_current_limit_from_supplier() into a
more generic power_supply_get_property_from_supplier() function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c   | 10 ++++-
 drivers/power/supply/power_supply_core.c | 57 +++++++++++++-----------
 include/linux/power_supply.h             |  5 ++-
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 06c34b09349c..c8a06ee6bd51 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1206,8 +1206,16 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	struct bq24190_dev_info *bdi =
 		container_of(work, struct bq24190_dev_info,
 			     input_current_limit_work.work);
+	union power_supply_propval val;
+	int ret;
 
-	power_supply_set_input_current_limit_from_supplier(bdi->charger);
+	ret = power_supply_get_property_from_supplier(bdi->charger,
+						      POWER_SUPPLY_PROP_CURRENT_MAX,
+						      &val);
+	if (ret == 0)
+		bq24190_charger_set_property(bdi->charger,
+					     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+					     &val);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ec838c9bcc0a..df4471e50d33 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -376,46 +376,49 @@ int power_supply_is_system_supplied(void)
 }
 EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 
-static int __power_supply_get_supplier_max_current(struct device *dev,
-						   void *data)
+struct psy_get_supplier_prop_data {
+	struct power_supply *psy;
+	enum power_supply_property psp;
+	union power_supply_propval *val;
+};
+
+static int __power_supply_get_supplier_property(struct device *dev, void *_data)
 {
-	union power_supply_propval ret = {0,};
 	struct power_supply *epsy = dev_get_drvdata(dev);
-	struct power_supply *psy = data;
+	struct psy_get_supplier_prop_data *data = _data;
 
-	if (__power_supply_is_supplied_by(epsy, psy))
-		if (!epsy->desc->get_property(epsy,
-					      POWER_SUPPLY_PROP_CURRENT_MAX,
-					      &ret))
-			return ret.intval;
+	if (__power_supply_is_supplied_by(epsy, data->psy))
+		if (!epsy->desc->get_property(epsy, data->psp, data->val))
+			return 1; /* Success */
 
-	return 0;
+	return 0; /* Continue iterating */
 }
 
-int power_supply_set_input_current_limit_from_supplier(struct power_supply *psy)
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val)
 {
-	union power_supply_propval val = {0,};
-	int curr;
-
-	if (!psy->desc->set_property)
-		return -EINVAL;
+	struct psy_get_supplier_prop_data data = {
+		.psy = psy,
+		.psp = psp,
+		.val = val,
+	};
+	int ret;
 
 	/*
 	 * This function is not intended for use with a supply with multiple
-	 * suppliers, we simply pick the first supply to report a non 0
-	 * max-current.
+	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	curr = class_for_each_device(power_supply_class, NULL, psy,
-				      __power_supply_get_supplier_max_current);
-	if (curr <= 0)
-		return (curr == 0) ? -ENODEV : curr;
-
-	val.intval = curr;
+	ret = class_for_each_device(power_supply_class, NULL, &data,
+				    __power_supply_get_supplier_property);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ENODEV;
 
-	return psy->desc->set_property(psy,
-				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(power_supply_set_input_current_limit_from_supplier);
+EXPORT_SYMBOL_GPL(power_supply_get_property_from_supplier);
 
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e218041cc000..006111917d1a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -597,8 +597,9 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
-extern int power_supply_set_input_current_limit_from_supplier(
-					 struct power_supply *psy);
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
 
 #ifdef CONFIG_POWER_SUPPLY
-- 
2.33.1

