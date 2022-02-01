Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B34A5D19
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiBANJA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238513AbiBANIg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IN0mnNEwFmzq1najf8olbC/23ovGo+/79HPbN8C12RI=;
        b=VummJnb9OUYLrhAIj3JX+LfJghvFNe5vW9SLhLH8b4y00RPdQbpP1f3OnR47eYcVAj68xn
        TD0KqvLvnJbjyxs78kSqSRwLLbSXH7LRN69QOEeI2+zrqPeDJoQx0/XGoAJ2DUcAv4/Hfi
        D8UMAkpD4cPakR5nXUjVpomze1wDsB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-vIcX3hnIMAGcP4VelK5Pnw-1; Tue, 01 Feb 2022 08:08:33 -0500
X-MC-Unique: vIcX3hnIMAGcP4VelK5Pnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEF4D100C662;
        Tue,  1 Feb 2022 13:08:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2CEA795B1;
        Tue,  1 Feb 2022 13:08:26 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 14/20] mfd: intel_soc_pmic_chtwc: Add cht_wc_model data to struct intel_soc_pmic
Date:   Tue,  1 Feb 2022 14:07:00 +0100
Message-Id: <20220201130706.46685-15-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
an Intel Whiskey Cove PMIC do not use a single standard setup for
the charger, fuel-gauge and other chips surrounding the PMIC /
charging+data USB port.

Unlike what is normal on x86 this diversity in designs is not handled
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
running on in each MFD-cell driver, add a check for this to the
shared drivers/mfd/intel_soc_pmic_chtwc.c code by using a
DMI table for all 3 known models:

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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- Put '{' and comment of DMI entries on separate lines (requested by Lee)
- Drop comment on terminating empty entry in DMI table

Changes in v3:
- Store the model in struct intel_soc_pmic instead of adding a helper
  function to retreive it

Changes in v2:
- New patch in v2 of this patch-set
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 40 ++++++++++++++++++++++++++++++
 include/linux/mfd/intel_soc_pmic.h |  8 ++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 49c5f71664bc..4eab191e053a 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -134,9 +135,44 @@ static const struct regmap_irq_chip cht_wc_regmap_irq_chip = {
 	.num_regs = 1,
 };
 
+static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
+	{
+		/* GPD win / GPD pocket mini laptops */
+		.driver_data = (void *)(long)INTEL_CHT_WC_GPD_WIN_POCKET,
+		/*
+		 * This DMI match may not seem unique, but it is. In the 67000+
+		 * DMI decode dumps from linux-hardware.org only 116 have
+		 * board_vendor set to "AMI Corporation" and of those 116 only
+		 * the GPD win's and pocket's board_name is "Default string".
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		},
+	}, {
+		/* Xiaomi Mi Pad 2 */
+		.driver_data = (void *)(long)INTEL_CHT_WC_XIAOMI_MIPAD2,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	}, {
+		/* Lenovo Yoga Book X90F / X91F / X91L */
+		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
+		.matches = {
+			/* Non exact match to match all versions */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
+		},
+	},
+	{ }
+};
+
 static int cht_wc_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	const struct dmi_system_id *id;
 	struct intel_soc_pmic *pmic;
 	acpi_status status;
 	unsigned long long hrv;
@@ -160,6 +196,10 @@ static int cht_wc_probe(struct i2c_client *client)
 	if (!pmic)
 		return -ENOMEM;
 
+	id = dmi_first_match(cht_wc_model_dmi_ids);
+	if (id)
+		pmic->cht_wc_model = (long)id->driver_data;
+
 	pmic->irq = client->irq;
 	pmic->dev = dev;
 	i2c_set_clientdata(client, pmic);
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 6a88e34cb955..945bde1fe55c 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -13,6 +13,13 @@
 
 #include <linux/regmap.h>
 
+enum intel_cht_wc_models {
+	INTEL_CHT_WC_UNKNOWN,
+	INTEL_CHT_WC_GPD_WIN_POCKET,
+	INTEL_CHT_WC_XIAOMI_MIPAD2,
+	INTEL_CHT_WC_LENOVO_YOGABOOK1,
+};
+
 /**
  * struct intel_soc_pmic - Intel SoC PMIC data
  * @irq: Master interrupt number of the parent PMIC device
@@ -39,6 +46,7 @@ struct intel_soc_pmic {
 	struct regmap_irq_chip_data *irq_chip_data_crit;
 	struct device *dev;
 	struct intel_scu_ipc_dev *scu;
+	enum intel_cht_wc_models cht_wc_model;
 };
 
 int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
-- 
2.33.1

