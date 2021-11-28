Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C946088D
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359257AbhK1SXv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358842AbhK1SVu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeo0Kvcs2oZjjTwYy4XcIetJkM8oFK47+msaBYObHcA=;
        b=ha3fufBEHha8elx9YXamMMVFg6EvQSlFxie6K2MGTKgvSiIYyVuoa2MW2j5++sAuaz96OJ
        jAzVxplIgWq1SQQaPffQVeN7h0wSB04K5hGXe7yFzuSbNa+itOVoghyBtiCQWCb5A+BZIY
        1yOTNFBhjzvT1F44529WIzsTQtwmyug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-ik-GYt5AOQe1CTY0BoJn0g-1; Sun, 28 Nov 2021 13:18:30 -0500
X-MC-Unique: ik-GYt5AOQe1CTY0BoJn0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC983E741;
        Sun, 28 Nov 2021 18:18:27 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0DB010016F4;
        Sun, 28 Nov 2021 18:18:21 +0000 (UTC)
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
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v3 03/20] power: supply: bq25890: Reduce reported CONSTANT_CHARGE_CURRENT_MAX for low temperatures
Date:   Sun, 28 Nov 2021 19:17:52 +0100
Message-Id: <20211128181809.326736-4-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Drop chunk adding a F_JEITA_VSET read to bq25890_power_supply_get_property()
  which accidentally got added to this patch
---
 drivers/power/supply/bq25890_charger.c | 29 +++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b208cc2193b8..0ab797c681fd 100644
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
@@ -549,7 +570,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
-		{F_CHG_FAULT,	&state->chrg_fault}
+		{F_CHG_FAULT,	&state->chrg_fault},
+		{F_NTC_FAULT,	&state->ntc_fault}
 	};
 
 	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
@@ -560,9 +582,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
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
2.33.1

