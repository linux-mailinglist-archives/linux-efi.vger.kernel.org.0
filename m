Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998E044F962
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhKNRHo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236191AbhKNRGz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfVMrmBQBfsg/z794ziYgV346QpjZYdALcF2KlNGNYI=;
        b=a3TvO5Ed2oRO4Yjwi8K+VHDzIdUGTN+D+QFsuSMSlTufKd8z+JAz8er4qU1qaawF/eKmHt
        qVLfLw2/X66D+qA20DT4BhMyLIQk2lfTHFJuwJjck6E0/7fDo9dmnnZMpt8FtCu7bQUAUQ
        VRlfSUxn98TJ8JJx0SwjY6taoSbG+H4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-MpC3RtzdPF6YFM1zYo7_4w-1; Sun, 14 Nov 2021 12:03:57 -0500
X-MC-Unique: MpC3RtzdPF6YFM1zYo7_4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C38C15722;
        Sun, 14 Nov 2021 17:03:55 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15B441346F;
        Sun, 14 Nov 2021 17:03:51 +0000 (UTC)
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
Subject: [PATCH v2 04/20] power: supply: bq25890: Reduce reported CONSTANT_CHARGE_CURRENT_MAX for low temperatures
Date:   Sun, 14 Nov 2021 18:03:19 +0100
Message-Id: <20211114170335.66994-5-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Take into account possible current reduction due to low-temperature when
reading POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX. As described in
the datasheet in cool (0-20° Celcius) conditions the current limit is
decreased to 20% or 50% of ICHG field value depended on JEITA_ISET field.

Also add NTC_FAULT field value to the debug message in
bq25890_get_chip_state().

Changed by Hans de Goede:
- Fix reading F_CHG_FAULT instead of F_NTC_FIELD for state->ntc_fault
- Only read JEITA_ISET field if necessary
- Tweak commit message a bit

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 33 +++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b208cc2193b8..617a653221ab 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -94,6 +94,7 @@ struct bq25890_state {
 	u8 vsys_status;
 	u8 boost_fault;
 	u8 bat_fault;
+	u8 ntc_fault;
 };
 
 struct bq25890_device {
@@ -383,6 +384,14 @@ enum bq25890_chrg_fault {
 	CHRG_FAULT_TIMER_EXPIRED,
 };
 
+enum bq25890_ntc_fault {
+	NTC_FAULT_NORMAL = 0,
+	NTC_FAULT_WARM = 2,
+	NTC_FAULT_COOL = 3,
+	NTC_FAULT_COLD = 5,
+	NTC_FAULT_HOT = 6,
+};
+
 static bool bq25890_is_adc_property(enum power_supply_property psp)
 {
 	switch (psp) {
@@ -474,6 +483,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+
+		/* When temperature is too low, charge current is decreased */
+		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
+			ret = bq25890_field_read(bq, F_JEITA_ISET);
+			if (ret < 0)
+				return ret;
+
+			if (ret)
+				val->intval /= 5;
+			else
+				val->intval /= 2;
+		}
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
@@ -486,6 +507,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
+		ret = bq25890_field_read(bq, F_JEITA_VSET);
+		if (ret < 0)
+			return ret;
+
 		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
 		val->intval = 2304000 + ret * 20000;
 		break;
@@ -549,7 +574,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
-		{F_CHG_FAULT,	&state->chrg_fault}
+		{F_CHG_FAULT,	&state->chrg_fault},
+		{F_NTC_FAULT,	&state->ntc_fault}
 	};
 
 	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
@@ -560,9 +586,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		*state_fields[i].data = ret;
 	}
 
-	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT=%d/%d/%d\n",
+	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
 		state->chrg_status, state->online, state->vsys_status,
-		state->chrg_fault, state->boost_fault, state->bat_fault);
+		state->chrg_fault, state->boost_fault, state->bat_fault,
+		state->ntc_fault);
 
 	return 0;
 }
-- 
2.31.1

