Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153F944F984
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhKNRI6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236250AbhKNRHg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVv8YUteH9MirfaKYfDD1ToB/iZr9iQujBoD/v0QeWk=;
        b=R/o3HniABhzAGpKl140fM+9+1gMFws37WvNjrZHr95aSegEt93mAodJ30+Axg/fm9whm+n
        GCTBTIVoGx92e/VOBfMHv2j6qXloKIEKx668YtZCJNlYwt1kr5mqfCNlf6qAJyzhU4/S3H
        wt/HMaIs6gAxKMTqYJsWaYqcp1Ho1mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-7R6Re83DPDGuJ3SoplgHRQ-1; Sun, 14 Nov 2021 12:04:36 -0500
X-MC-Unique: 7R6Re83DPDGuJ3SoplgHRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9281808303;
        Sun, 14 Nov 2021 17:04:33 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41D951346F;
        Sun, 14 Nov 2021 17:04:30 +0000 (UTC)
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
Subject: [PATCH v2 14/20] mfd: intel_soc_pmic_chtwc: Add intel_cht_wc_get_model() helper function
Date:   Sun, 14 Nov 2021 18:03:29 +0100
Message-Id: <20211114170335.66994-15-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
an Intel Whiskey Cove PMIC do not use a single standard setup for
the charger, fuel-gauge and other chips surrounding the PMIC /
charging+data USB port.

Unlike what is normal on X86 this diversity in designs is not handled
by the ACPI tables. On 2 of the 3 known designs there are no standard
(PNP0C0A) ACPI battery devices and on the 3th design the ACPI battery
device does not work under Linux due to it requiring non-standard
and undocumented ACPI behavior.

So to make things work under Linux we use native charger and fuel-gauge
drivers on these devices, re-using the native drivers used on ARM boards
with the same charger / fuel-gauge ICs.

This requires various MFD-cell drivers for the CHT-WC PMIC cells to
know which model they are exactly running on so that they can e.g.
instantiate an I2C-client for the right model charger-IC (the charger
is connected to an I2C-controller which is part of the PMIC).

Rather then duplicating DMI-id matching to check which model we are
running on in each MFD-cell driver add a helper function for this
and make this id all 3 known models:

1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
but the Pocket re-uses the GPD Win's design in a different housing:

The WC PMIC is connected to a TI BQ24292i charger, paired with
a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
a PI3USB30532 USB switch, for a fully functional Type-C port.

2. The Xiaomi Mi Pad 2:

The WC PMIC is connected to a TI BQ25890 charger, paired with
a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
detection, for a USB-2 only Type-C port without PD.

3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:

The WC PMIC is connected to a TI BQ25892 charger, paired with
a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
detection and using the BQ25892's Mediatek Pump Express+ (1.0)
support to enable charging with up to 12V through a micro-USB port.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 46 ++++++++++++++++++++++++++++++
 include/linux/mfd/intel_soc_pmic.h |  9 ++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 49c5f71664bc..3432bd18f5d0 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -134,6 +135,51 @@ static const struct regmap_irq_chip cht_wc_regmap_irq_chip = {
 	.num_regs = 1,
 };
 
+static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
+	{	/* GPD win / GPD pocket mini laptops */
+		.driver_data = (void *)(long)INTEL_CHT_WC_GPD_WIN_POCKET,
+		/*
+		 * Note this may not seem like a very unique match, but in the
+		 * 24000+ DMI decode dumps from linux-hardware.org only 42 have
+		 * a board_vendor value of "AMI Corporation" and of those 42
+		 * only 1 (the GPD win/pocket entry) has a board_name of
+		 * "Default string". Also very few devices have both board_ and
+		 * product_name not set.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		},
+	}, {	/* Xiaomi Mi Pad 2 */
+		.driver_data = (void *)(long)INTEL_CHT_WC_XIAOMI_MIPAD2,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	}, {	/* Lenovo Yoga Book X90F / X91F / X91L */
+		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
+		.matches = {
+		  /* Non exact match to match all versions */
+		  DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
+		},
+	},
+	{ } /* Terminating empty */
+};
+
+enum intel_cht_wc_models intel_cht_wc_get_model(void)
+{
+	const struct dmi_system_id *id;
+
+	id = dmi_first_match(cht_wc_model_dmi_ids);
+	if (!id)
+		return INTEL_CHT_WC_UNKNOWN;
+
+	return (long)id->driver_data;
+}
+EXPORT_SYMBOL_GPL(intel_cht_wc_get_model);
+
 static int cht_wc_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 6a88e34cb955..dd17d7f82434 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -41,7 +41,16 @@ struct intel_soc_pmic {
 	struct intel_scu_ipc_dev *scu;
 };
 
+enum intel_cht_wc_models {
+	INTEL_CHT_WC_UNKNOWN,
+	INTEL_CHT_WC_GPD_WIN_POCKET,
+	INTEL_CHT_WC_XIAOMI_MIPAD2,
+	INTEL_CHT_WC_LENOVO_YOGABOOK1,
+};
+
 int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 					      u32 value, u32 mask);
 
+enum intel_cht_wc_models intel_cht_wc_get_model(void);
+
 #endif	/* __INTEL_SOC_PMIC_H__ */
-- 
2.31.1

