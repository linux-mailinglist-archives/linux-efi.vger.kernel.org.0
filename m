Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4284692C7
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbhLFJjQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:39:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241344AbhLFJjE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QL/WD4L6XD5XSuq043YqRwsHsQuEMvnmzfJcrbvUXAg=;
        b=gbDV/LJ26199Jm37n5FRv3AUg9eTlj15t7iboMyIXG8XjUKqAeOuulkgM1xnrnX4hp8HhT
        Oz5LtlF1Ewy3dLV13O50s0NtMNT/Yz842Wraaj5K0ob1sop2zRX/D/ZBiQtBHU9TgYjxVN
        pKYolb0be/K+u0Ch26n4wBvJdTW7h88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-prEyuviROoeohwErBEuS0w-1; Mon, 06 Dec 2021 04:35:30 -0500
X-MC-Unique: prEyuviROoeohwErBEuS0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D4A185302A;
        Mon,  6 Dec 2021 09:35:27 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 563725DF2E;
        Mon,  6 Dec 2021 09:35:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 19/20] extcon: intel-cht-wc: Add support for registering a power_supply class-device
Date:   Mon,  6 Dec 2021 10:33:17 +0100
Message-Id: <20211206093318.45214-20-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The bq25890 used on the Yogabook YB1-X90 / -X91 models relies on
the extcon-driver's BC-1.2 charger detection, and the bq25890 driver
expect this info to be  available through a parent power_supply
class-device which models the detected charger (idem to how the Type-C
TCPM code registers a power_supply classdev for the connected charger).

Add support for registering the power_supply class-device expected
by this setup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Some minor tweaks based on Andy's review
---
 drivers/extcon/extcon-intel-cht-wc.c | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 150637bea417..144cb5d8cd47 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -106,6 +107,8 @@ struct cht_wc_extcon_data {
 	struct extcon_dev *edev;
 	struct usb_role_switch *role_sw;
 	struct regulator *vbus_boost;
+	struct power_supply *psy;
+	enum power_supply_usb_type usb_type;
 	unsigned int previous_cable;
 	bool usb_host;
 	bool vbus_boost_enabled;
@@ -170,18 +173,23 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 		dev_warn(ext->dev,
 			"Unhandled charger type %d, defaulting to SDP\n",
 			 ret);
+		ext->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
 		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_SDP:
 	case CHT_WC_USBSRC_TYPE_FLOATING:
 	case CHT_WC_USBSRC_TYPE_OTHER:
+		ext->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
 		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_CDP:
+		ext->usb_type = POWER_SUPPLY_USB_TYPE_CDP;
 		return EXTCON_CHG_USB_CDP;
 	case CHT_WC_USBSRC_TYPE_DCP:
 	case CHT_WC_USBSRC_TYPE_DCP_EXTPHY:
 	case CHT_WC_USBSRC_TYPE_MHL: /* MHL2+ delivers upto 2A, treat as DCP */
+		ext->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
 		return EXTCON_CHG_USB_DCP;
 	case CHT_WC_USBSRC_TYPE_ACA:
+		ext->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
 		return EXTCON_CHG_USB_ACA;
 	}
 }
@@ -266,6 +274,8 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	bool ignore_get_charger_errors = ext->usb_host;
 	enum usb_role role;
 
+	ext->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+
 	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
 	if (ret) {
 		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
@@ -320,6 +330,9 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	ret = usb_role_switch_set_role(ext->role_sw, role);
 	if (ret)
 		dev_err(ext->dev, "Error setting USB-role: %d\n", ret);
+
+	if (ext->psy)
+		power_supply_changed(ext->psy);
 }
 
 static irqreturn_t cht_wc_extcon_isr(int irq, void *data)
@@ -420,6 +433,59 @@ static int cht_wc_extcon_get_role_sw_and_regulator(struct cht_wc_extcon_data *ex
 	return 0;
 }
 
+static int cht_wc_extcon_psy_get_prop(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct cht_wc_extcon_data *ext = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = ext->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ext->usb_type ? 1 : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_usb_type cht_wc_extcon_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_ACA,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+};
+
+static const enum power_supply_property cht_wc_extcon_psy_props[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc cht_wc_extcon_psy_desc = {
+	.name = "cht_wcove_pwrsrc",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = cht_wc_extcon_psy_usb_types,
+	.num_usb_types = ARRAY_SIZE(cht_wc_extcon_psy_usb_types),
+	.properties = cht_wc_extcon_psy_props,
+	.num_properties = ARRAY_SIZE(cht_wc_extcon_psy_props),
+	.get_property = cht_wc_extcon_psy_get_prop,
+};
+
+static int cht_wc_extcon_register_psy(struct cht_wc_extcon_data *ext)
+{
+	struct power_supply_config psy_cfg = { .drv_data = ext };
+
+	ext->psy = devm_power_supply_register(ext->dev,
+					      &cht_wc_extcon_psy_desc,
+					      &psy_cfg);
+	return PTR_ERR_OR_ZERO(ext->psy);
+}
+
 static int cht_wc_extcon_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
@@ -463,6 +529,21 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 		cht_wc_extcon_set_5v_boost(ext, false);
 		break;
 	case INTEL_CHT_WC_LENOVO_YOGABOOK1:
+		/* Do this first, as it may very well return -EPROBE_DEFER. */
+		ret = cht_wc_extcon_get_role_sw_and_regulator(ext);
+		if (ret)
+			return ret;
+		/*
+		 * The bq25890 used here relies on this driver's BC-1.2 charger
+		 * detection, and the bq25890 driver expect this info to be
+		 * available through a parent power_supply class device which
+		 * models the detected charger (idem to how the Type-C TCPM code
+		 * registers a power_supply classdev for the connected charger).
+		 */
+		ret = cht_wc_extcon_register_psy(ext);
+		if (ret)
+			return ret;
+		break;
 	case INTEL_CHT_WC_XIAOMI_MIPAD2:
 		ret = cht_wc_extcon_get_role_sw_and_regulator(ext);
 		if (ret)
-- 
2.33.1

