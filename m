Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AF4A5D2C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiBANJP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238506AbiBANIq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A90HaalXBx1gVGuJBR3n6goMO3ddmchQxDA4Piw5CdM=;
        b=H/kZXeHZoa1gx4u/sGRFKeHgqcscoWewUvHr496w7TYfda99wDJCpC5WVyHKHbCdL1uSmI
        fS4BlXvKezEuUQoMd47dN/NYv3yFYJ5Xu1oTVeKz0nr/aj5xtQsB0s+cW0YAUxY6KNWOeg
        18nUHSUZo/NbBNcwgRW4CZHf1bzPGkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-gsutqPjsNY2awyCncXfCHQ-1; Tue, 01 Feb 2022 08:08:41 -0500
X-MC-Unique: gsutqPjsNY2awyCncXfCHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A6B98519EB;
        Tue,  1 Feb 2022 13:08:38 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8360795B1;
        Tue,  1 Feb 2022 13:08:34 +0000 (UTC)
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
Subject: [PATCH v5 16/20] extcon: intel-cht-wc: Use new cht_wc_model intel_soc_pmic field
Date:   Tue,  1 Feb 2022 14:07:02 +0100
Message-Id: <20220201130706.46685-17-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CHT_WC_VBUS_GPIO_CTLO GPIO actually driving an external 5V Vboost
converter for Vbus depends on the board on which the Cherry Trail -
Whiskey Cove PMIC is actually used.

Since the information about the exact PMIC setup is necessary in other
places too, struct intel_soc_pmic now has a new cht_wc_model field
indicating the board model.

Only poke the CHT_WC_VBUS_GPIO_CTLO GPIO if this new field is set to
INTEL_CHT_WC_GPD_WIN_POCKET, which indicates the Type-C (with PD and
DP-altmode) setup used on the GPD pocket and GPD win; and on which
this GPIO actually controls an external 5V Vboost converter.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Use the new cht_wc_model intel_soc_pmic field which replaces the
  intel_cht_wc_get_model() helper and adjust the commit msg to match
---
 drivers/extcon/extcon-intel-cht-wc.c | 35 +++++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 771f6f4cf92e..81cae8c75850 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -358,20 +359,26 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
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
+	switch (pmic->cht_wc_model) {
+	case INTEL_CHT_WC_GPD_WIN_POCKET:
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
+		break;
+	default:
+		break;
+	}
 
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
-- 
2.33.1

