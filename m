Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D60440B3D
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJ3Sb4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232192AbhJ3Sbe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUEju/CsoIc2q4rUI+8q7/o17IamENQRRYq/c3o9VcM=;
        b=D9ClmcwXx8RJGxWVH59mGqiU2zdTN9P2C7JXInwx4Bz/8MRtw+c1ENXoQuX9NTwul+rUGg
        Vm/PMKGzgpTrnCvZe100mOaearvOnqirIF5Xnb4W1FDBRO85tijf3p6ZOiJTqJc5iv0vPa
        KWxiZ5CVdz0rOmvuAXX8pih4agmTfNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-E1K4M_LjOcGeJ06IU2lowg-1; Sat, 30 Oct 2021 14:29:00 -0400
X-MC-Unique: E1K4M_LjOcGeJ06IU2lowg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E691980668A;
        Sat, 30 Oct 2021 18:28:57 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F4445F4E9;
        Sat, 30 Oct 2021 18:28:54 +0000 (UTC)
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
Subject: [PATCH 13/13] extcon: intel-cht-wc: Add support for devices with an USB-micro-B connector
Date:   Sat, 30 Oct 2021 20:28:13 +0200
Message-Id: <20211030182813.116672-14-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

So far the extcon-intel-cht-wc code has only been tested on devices with
a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
through a FUSB302 Type-C controller.

Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
connector, or an USB-2 only Type-C connector without USB-PD.

These device are identified by "intel,cht-wc-setup" = "bq25890,bq27520",
since there is no Type-C controller on these devices the extcon code must
control the Vbus 5V boost converter and the USB role switch depending on
the detected cable-type.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index a7a6b43d699b..d8d0a69f4ddd 100644
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
+		if (ret == 0)
+			ext->vbus_boost_enabled = enable;
+		else
+			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
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
@@ -334,6 +364,29 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 	return ret;
 }
 
+static int cht_wc_find_role_sw(struct cht_wc_extcon_data *ext)
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
+static void cht_wc_put_role_sw(void *data)
+{
+	struct cht_wc_extcon_data *ext = data;
+
+	usb_role_switch_put(ext->role_sw);
+}
+
 static int cht_wc_extcon_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
@@ -377,6 +430,34 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 		 * external 5v boost converter off and leave it off entirely.
 		 */
 		cht_wc_extcon_set_5v_boost(ext, false);
+	} else if (!strcmp(setup, "bq25890,bq27520")) {
+		/*
+		 * Classic micro USB-B setup, this requires controling
+		 * the role-sw and vbus based on the id-pin.
+		 */
+		ret = cht_wc_find_role_sw(ext);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(ext->dev, cht_wc_put_role_sw, ext);
+		if (ret)
+			return ret;
+
+		/*
+		 * On x86/ACPI platforms the regulator <-> consumer link is provided
+		 * by platform_data passed to the regulator driver. This means that
+		 * this info is not available before the regulator driver has bound.
+		 * Use devm_regulator_get_optional() to avoid getting a dummy
+		 * regulator and wait for the regulator to show up if necessary.
+		 */
+		ext->vbus_boost = devm_regulator_get_optional(ext->dev, "vbus");
+		if (IS_ERR(ext->vbus_boost)) {
+			ret = PTR_ERR(ext->vbus_boost);
+			if (ret == -ENODEV)
+				ret = -EPROBE_DEFER;
+
+			return dev_err_probe(ext->dev, ret, "getting vbus regulator");
+		}
 	}
 
 	/* Enable sw control */
-- 
2.31.1

