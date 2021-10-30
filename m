Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE90440B3B
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhJ3Sby (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232186AbhJ3Sbd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6HmNT833c+9fVgs3GgWn5FyPC8j48ztpTXVuqbk+XU=;
        b=eVXFpdl8FR3v8fvzLX0JU44bQ538LwTaPwFgWvPImS+c+XusA60sCge1fKxrge1pbBo9o2
        0zXkQ/MjpimuY4ei861R/FVPhgWc+FD8PGzYKBKjTELhcumXeEOscnJOA9kTg3T/GQsref
        EPxzFlOICA8adtQMonSemIlShIr/WoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-ws3MFhw3PN2RDUpf6G4_5A-1; Sat, 30 Oct 2021 14:28:56 -0400
X-MC-Unique: ws3MFhw3PN2RDUpf6G4_5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC7D7806688;
        Sat, 30 Oct 2021 18:28:54 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09D6D5F4E1;
        Sat, 30 Oct 2021 18:28:51 +0000 (UTC)
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
Subject: [PATCH 12/13] extcon: intel-cht-wc: Check new "intel,cht-wc-setup" device-property
Date:   Sat, 30 Oct 2021 20:28:12 +0200
Message-Id: <20211030182813.116672-13-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CHT_WC_VBUS_GPIO_CTLO GPIO actually driving an external 5V Vboost
converter for Vbus depends on the board on which the Cherry Trail -
Whiskey Cove PMIC is actually used.

Since the information about the exact PMIC setup is necessary in other
places too, the kernel now adds a "intel,cht-wc-setup" string property
to the Whiskey Cove PMIC i2c-client based on DMI matching.

Only poke the CHT_WC_VBUS_GPIO_CTLO GPIO if this new property has the
"bq24292i,max17047,fusb302,pi3usb30532" value which indicates the Type-C
(with PD and DP-altmode) setup used on the GPD pocket and GPD win; and
on which this GPIO actually controls an external 5V Vboost converter.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 38 ++++++++++++++++------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 771f6f4cf92e..a7a6b43d699b 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -338,8 +339,8 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct cht_wc_extcon_data *ext;
 	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
-	int pwrsrc_sts, id;
-	int irq, ret;
+	int id, irq, pwrsrc_sts, ret;
+	const char *setup;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -358,20 +359,25 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	if (IS_ERR(ext->edev))
 		return PTR_ERR(ext->edev);
 
-	/*
-	 * When a host-cable is detected the BIOS enables an external 5v boost
-	 * converter to power connected devices there are 2 problems with this:
-	 * 1) This gets seen by the external battery charger as a valid Vbus
-	 *    supply and it then tries to feed Vsys from this creating a
-	 *    feedback loop which causes aprox. 300 mA extra battery drain
-	 *    (and unless we drive the external-charger-disable pin high it
-	 *    also tries to charge the battery causing even more feedback).
-	 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
-	 * Since the external battery charger has its own 5v boost converter
-	 * which does not have these issues, we simply turn the separate
-	 * external 5v boost converter off and leave it off entirely.
-	 */
-	cht_wc_extcon_set_5v_boost(ext, false);
+	ret = device_property_read_string(ext->dev->parent, "intel,cht-wc-setup", &setup);
+	if (ret) {
+		dev_warn(ext->dev, "intel,cht-wc-setup not set\n");
+	} else if (!strcmp(setup, "bq24292i,max17047,fusb302,pi3usb30532")) {
+		/*
+		 * When a host-cable is detected the BIOS enables an external 5v boost
+		 * converter to power connected devices there are 2 problems with this:
+		 * 1) This gets seen by the external battery charger as a valid Vbus
+		 *    supply and it then tries to feed Vsys from this creating a
+		 *    feedback loop which causes aprox. 300 mA extra battery drain
+		 *    (and unless we drive the external-charger-disable pin high it
+		 *    also tries to charge the battery causing even more feedback).
+		 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
+		 * Since the external battery charger has its own 5v boost converter
+		 * which does not have these issues, we simply turn the separate
+		 * external 5v boost converter off and leave it off entirely.
+		 */
+		cht_wc_extcon_set_5v_boost(ext, false);
+	}
 
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
-- 
2.31.1

