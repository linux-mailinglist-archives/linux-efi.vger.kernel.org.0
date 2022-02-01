Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB84A5D26
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiBANJM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238707AbiBANIu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eitB46YwsrTiyPG9yVUWfbEqzNFt8Yd7fZW8caSs5Jw=;
        b=VX+I1IHwgeoHpt2LWCg4yzuPI0c1BUm5GK8PV0R2hVPxNVgTsy9nA0diUOjKyic4PI4B5N
        kmc6soZeVlYnhVZvRo2oDZoRfw2PiXRGUfemGaxlR7GyPyE0jvOJ0NBu1ikEGOOuA14YOk
        qtD84NCFXI/kkCBsBkxftu4SP0u2lzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-c3PEZx1YOHWrAFI9QGAzfA-1; Tue, 01 Feb 2022 08:08:44 -0500
X-MC-Unique: c3PEZx1YOHWrAFI9QGAzfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1244784DA40;
        Tue,  1 Feb 2022 13:08:42 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1C51795B1;
        Tue,  1 Feb 2022 13:08:38 +0000 (UTC)
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
Subject: [PATCH v5 17/20] extcon: intel-cht-wc: Support devs with Micro-B / USB-2 only Type-C connectors
Date:   Tue,  1 Feb 2022 14:07:03 +0100
Message-Id: <20220201130706.46685-18-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

So far the extcon-intel-cht-wc code has only been tested on devices with
a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
through a FUSB302 Type-C controller.

Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
connector, or an USB-2 only Type-C connector without USB-PD.

Which device-model we are running on can be identified with the new
cht_wc_model intel_soc_pmic field. On models without a Type-C controller
the extcon code must control the Vbus 5V boost converter and the USB role
switch depending on the detected cable-type.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
- Drop unnecessary inversion of an if condition and swap the if/else
  branches

Changes in v3:
- Some minor tweaks / spelling fixes based on Andy's review
---
 drivers/extcon/Kconfig               |  2 +
 drivers/extcon/extcon-intel-cht-wc.c | 91 ++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aab87c9b35c8..0d42e49105dd 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -61,6 +61,8 @@ config EXTCON_INTEL_INT3496
 config EXTCON_INTEL_CHT_WC
 	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
 	depends on INTEL_SOC_PMIC_CHTWC
+	depends on USB_SUPPORT
+	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable extcon support for charger detection / control
 	  on the Intel Cherrytrail Whiskey Cove PMIC.
diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 81cae8c75850..3fc5dd06849a 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -16,7 +16,9 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/usb/role.h>
 
 #include "extcon-intel.h"
 
@@ -102,8 +104,11 @@ struct cht_wc_extcon_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct extcon_dev *edev;
+	struct usb_role_switch *role_sw;
+	struct regulator *vbus_boost;
 	unsigned int previous_cable;
 	bool usb_host;
+	bool vbus_boost_enabled;
 };
 
 static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
@@ -217,6 +222,18 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
 				 CHT_WC_CHGRCTRL1_OTGMODE, val);
 	if (ret)
 		dev_err(ext->dev, "Error updating CHGRCTRL1 reg: %d\n", ret);
+
+	if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
+		if (enable)
+			ret = regulator_enable(ext->vbus_boost);
+		else
+			ret = regulator_disable(ext->vbus_boost);
+
+		if (ret)
+			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
+		else
+			ext->vbus_boost_enabled = enable;
+	}
 }
 
 static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
@@ -246,6 +263,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	unsigned int cable = EXTCON_NONE;
 	/* Ignore errors in host mode, as the 5v boost converter is on then */
 	bool ignore_get_charger_errors = ext->usb_host;
+	enum usb_role role;
 
 	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
 	if (ret) {
@@ -289,6 +307,18 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 
 	ext->usb_host = ((id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A));
 	extcon_set_state_sync(ext->edev, EXTCON_USB_HOST, ext->usb_host);
+
+	if (ext->usb_host)
+		role = USB_ROLE_HOST;
+	else if (pwrsrc_sts & CHT_WC_PWRSRC_VBUS)
+		role = USB_ROLE_DEVICE;
+	else
+		role = USB_ROLE_NONE;
+
+	/* Note: this is a no-op when ext->role_sw is NULL */
+	ret = usb_role_switch_set_role(ext->role_sw, role);
+	if (ret)
+		dev_err(ext->dev, "Error setting USB-role: %d\n", ret);
 }
 
 static irqreturn_t cht_wc_extcon_isr(int irq, void *data)
@@ -334,6 +364,61 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 	return ret;
 }
 
+static int cht_wc_extcon_find_role_sw(struct cht_wc_extcon_data *ext)
+{
+	const struct software_node *swnode;
+	struct fwnode_handle *fwnode;
+
+	swnode = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
+	if (!swnode)
+		return -EPROBE_DEFER;
+
+	fwnode = software_node_fwnode(swnode);
+	ext->role_sw = usb_role_switch_find_by_fwnode(fwnode);
+	fwnode_handle_put(fwnode);
+
+	return ext->role_sw ? 0 : -EPROBE_DEFER;
+}
+
+static void cht_wc_extcon_put_role_sw(void *data)
+{
+	struct cht_wc_extcon_data *ext = data;
+
+	usb_role_switch_put(ext->role_sw);
+}
+
+/* Some boards require controlling the role-sw and Vbus based on the id-pin */
+static int cht_wc_extcon_get_role_sw_and_regulator(struct cht_wc_extcon_data *ext)
+{
+	int ret;
+
+	ret = cht_wc_extcon_find_role_sw(ext);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(ext->dev, cht_wc_extcon_put_role_sw, ext);
+	if (ret)
+		return ret;
+
+	/*
+	 * On x86/ACPI platforms the regulator <-> consumer link is provided
+	 * by platform_data passed to the regulator driver. This means that
+	 * this info is not available before the regulator driver has bound.
+	 * Use devm_regulator_get_optional() to avoid getting a dummy
+	 * regulator and wait for the regulator to show up if necessary.
+	 */
+	ext->vbus_boost = devm_regulator_get_optional(ext->dev, "vbus");
+	if (IS_ERR(ext->vbus_boost)) {
+		ret = PTR_ERR(ext->vbus_boost);
+		if (ret == -ENODEV)
+			ret = -EPROBE_DEFER;
+
+		return dev_err_probe(ext->dev, ret, "getting Vbus regulator");
+	}
+
+	return 0;
+}
+
 static int cht_wc_extcon_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
@@ -376,6 +461,12 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 		 */
 		cht_wc_extcon_set_5v_boost(ext, false);
 		break;
+	case INTEL_CHT_WC_LENOVO_YOGABOOK1:
+	case INTEL_CHT_WC_XIAOMI_MIPAD2:
+		ret = cht_wc_extcon_get_role_sw_and_regulator(ext);
+		if (ret)
+			return ret;
+		break;
 	default:
 		break;
 	}
-- 
2.33.1

