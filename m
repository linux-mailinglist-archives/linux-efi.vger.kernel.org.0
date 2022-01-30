Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039E4A396C
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiA3Utg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356323AbiA3UrY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YW1BIUN5jOVdVEK6YUCLi1iFqHOlFG02FpWo0wk7en4=;
        b=R8BkBfzSFrYNbSbTbRngAtjCD5Df1V4Uqnt2JX4PxkmoTmIt+LfMp5ZY+DJZGR4uy1wH3G
        3d3+TxTJcagxhBSAQY5Rfw14bJvcCNqutuyJhZ+eGdt550geCuPPYSWl7D6fTpTmpJB/9f
        9fGmleeDLyprTDZUMw5q3956Dxf5OXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-WMi23sfeNASuHxijnNHlMw-1; Sun, 30 Jan 2022 15:47:20 -0500
X-MC-Unique: WMi23sfeNASuHxijnNHlMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E2318397BE;
        Sun, 30 Jan 2022 20:47:18 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DBBA61093;
        Sun, 30 Jan 2022 20:47:15 +0000 (UTC)
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
Subject: [PATCH v4 12/20] power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol
Date:   Sun, 30 Jan 2022 21:45:49 +0100
Message-Id: <20220130204557.15662-13-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Add a "linux,pump-express-vbus-max" property which indicates if the Pump
Express+ protocol should be used to increase the charging protocol.

If this new property is set and a DCP charger is detected then request
a higher charging voltage through the Pump Express+ protocol.

So far this new property is only used on x86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Changes by Hans de Goede:
- Port to my bq25890 patch-series + various cleanups
- Make behavior configurable through a new "linux,pump-express-vbus-max"
  device-property
- Sleep 1 second before re-checking the Vbus voltage after requesting
  it to be raised, to ensure that the ADC has time to sampled the new Vbus
- Add VBUSV bq25890_tables[] entry and use it in bq25890_get_vbus_voltage()
- Tweak commit message

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Re-indent bq25890_tables to make checkpatch happy
- Add _uV postfix to PUMP_EXPRESS_VBUS_MARGIN
- Use regmap_field_read_poll_timeout() to wait for F_PUMPX_UP bit to clear
- Don't error check device_property_read_u32() call for optional prop

Changes in v2:
- New patch in v2 of this series, also see "Changes by Hans de Goede"
---
 drivers/power/supply/bq25890_charger.c | 92 +++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 3de72f0fbf3e..179abed92f9b 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -27,6 +27,10 @@
 #define BQ25895_ID			7
 #define BQ25896_ID			0
 
+#define PUMP_EXPRESS_START_DELAY	(5 * HZ)
+#define PUMP_EXPRESS_MAX_TRIES		6
+#define PUMP_EXPRESS_VBUS_MARGIN_uV	1000000
+
 enum bq25890_chip_version {
 	BQ25890,
 	BQ25892,
@@ -107,6 +111,7 @@ struct bq25890_device {
 	struct usb_phy *usb_phy;
 	struct notifier_block usb_nb;
 	struct work_struct usb_work;
+	struct delayed_work pump_express_work;
 	unsigned long usb_event;
 
 	struct regmap *rmap;
@@ -114,6 +119,7 @@ struct bq25890_device {
 
 	bool skip_reset;
 	bool read_back_init_data;
+	u32 pump_express_vbus_max;
 	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
@@ -265,6 +271,7 @@ enum bq25890_table_ids {
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
+	TBL_VBUSV,
 	TBL_VBATCOMP,
 	TBL_RBATCOMP,
 
@@ -325,14 +332,15 @@ static const union {
 } bq25890_tables[] = {
 	/* range tables */
 	/* TODO: BQ25896 has max ICHG 3008 mA */
-	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
-	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
-	[TBL_IINLIM] =  { .rt = {100000,  3250000, 50000} },	 /* uA */
-	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
-	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
-	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
-	[TBL_VBATCOMP] ={ .rt = {0,        224000, 32000} },	 /* uV */
-	[TBL_RBATCOMP] ={ .rt = {0,        140000, 20000} },	 /* uOhm */
+	[TBL_ICHG] =	 { .rt = {0,        5056000, 64000} },	 /* uA */
+	[TBL_ITERM] =	 { .rt = {64000,    1024000, 64000} },	 /* uA */
+	[TBL_IINLIM] =   { .rt = {100000,   3250000, 50000} },	 /* uA */
+	[TBL_VREG] =	 { .rt = {3840000,  4608000, 16000} },	 /* uV */
+	[TBL_BOOSTV] =	 { .rt = {4550000,  5510000, 64000} },	 /* uV */
+	[TBL_SYSVMIN] =  { .rt = {3000000,  3700000, 100000} },	 /* uV */
+	[TBL_VBUSV] =	 { .rt = {2600000, 15300000, 100000} },	 /* uV */
+	[TBL_VBATCOMP] = { .rt = {0,         224000, 32000} },	 /* uV */
+	[TBL_RBATCOMP] = { .rt = {0,         140000, 20000} },	 /* uOhm */
 
 	/* lookup tables */
 	[TBL_TREG] =	{ .lt = {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
@@ -435,6 +443,17 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 
 static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq);
 
+static int bq25890_get_vbus_voltage(struct bq25890_device *bq)
+{
+	int ret;
+
+	ret = bq25890_field_read(bq, F_VBUSV);
+	if (ret < 0)
+		return ret;
+
+	return bq25890_find_val(ret, TBL_VBUSV);
+}
+
 static int bq25890_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -613,6 +632,11 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 	switch (val.intval) {
 	case POWER_SUPPLY_USB_TYPE_DCP:
 		input_current_limit = bq25890_find_idx(2000000, TBL_IINLIM);
+		if (bq->pump_express_vbus_max) {
+			queue_delayed_work(system_power_efficient_wq,
+					   &bq->pump_express_work,
+					   PUMP_EXPRESS_START_DELAY);
+		}
 		break;
 	case POWER_SUPPLY_USB_TYPE_CDP:
 	case POWER_SUPPLY_USB_TYPE_ACA:
@@ -878,6 +902,53 @@ static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
 	return ret;
 }
 
+static void bq25890_pump_express_work(struct work_struct *data)
+{
+	struct bq25890_device *bq =
+		container_of(data, struct bq25890_device, pump_express_work.work);
+	int voltage, i, ret;
+
+	dev_dbg(bq->dev, "Start to request input voltage increasing\n");
+
+	/* Enable current pulse voltage control protocol */
+	ret = bq25890_field_write(bq, F_PUMPX_EN, 1);
+	if (ret < 0)
+		goto error_print;
+
+	for (i = 0; i < PUMP_EXPRESS_MAX_TRIES; i++) {
+		voltage = bq25890_get_vbus_voltage(bq);
+		if (voltage < 0)
+			goto error_print;
+		dev_dbg(bq->dev, "input voltage = %d uV\n", voltage);
+
+		if ((voltage + PUMP_EXPRESS_VBUS_MARGIN_uV) >
+					bq->pump_express_vbus_max)
+			break;
+
+		ret = bq25890_field_write(bq, F_PUMPX_UP, 1);
+		if (ret < 0)
+			goto error_print;
+
+		/* Note a single PUMPX up pulse-sequence takes 2.1s */
+		ret = regmap_field_read_poll_timeout(bq->rmap_fields[F_PUMPX_UP],
+						     ret, !ret, 100000, 3000000);
+		if (ret < 0)
+			goto error_print;
+
+		/* Make sure ADC has sampled Vbus before checking again */
+		msleep(1000);
+	}
+
+	bq25890_field_write(bq, F_PUMPX_EN, 0);
+
+	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
+		 voltage);
+
+	return;
+error_print:
+	dev_err(bq->dev, "Failed to request hi-voltage charging\n");
+}
+
 static void bq25890_usb_work(struct work_struct *data)
 {
 	int ret;
@@ -1068,6 +1139,10 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	int ret;
 	struct bq25890_init_data *init = &bq->init_data;
 
+	/* Optional, left at 0 if property is not present */
+	device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
+				 &bq->pump_express_vbus_max);
+
 	bq->skip_reset = device_property_read_bool(bq->dev, "linux,skip-reset");
 	bq->read_back_init_data = device_property_read_bool(bq->dev,
 						"linux,read-back-settings");
@@ -1100,6 +1175,7 @@ static int bq25890_probe(struct i2c_client *client,
 	bq->dev = dev;
 
 	mutex_init(&bq->lock);
+	INIT_DELAYED_WORK(&bq->pump_express_work, bq25890_pump_express_work);
 
 	bq->rmap = devm_regmap_init_i2c(client, &bq25890_regmap_config);
 	if (IS_ERR(bq->rmap))
-- 
2.33.1

