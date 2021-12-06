Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB246927B
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhLFJhT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240889AbhLFJhS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NpFdB1bVbDNAo3VG1s0TVH/ohpEAXL05zlAcvCO9sw=;
        b=URpRsdl+r13NHEwNKFMZmCxzWC66rxmchMLF14ofDT8gzaKkVfi8pNELaU3tF5k7soBQn8
        wgV3uePNdRi59TAk946f4ocIkCXKxLqKWALnvF1whQyoDWqDzPU5aM51Xp/YzlqHkfsYsu
        yivgd2t0SvfdIGmHqp31/SF077UNS4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-ShiRPCZ1MSOwmElRgz8y4w-1; Mon, 06 Dec 2021 04:33:44 -0500
X-MC-Unique: ShiRPCZ1MSOwmElRgz8y4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E32101F001;
        Mon,  6 Dec 2021 09:33:42 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3F11ADD6;
        Mon,  6 Dec 2021 09:33:38 +0000 (UTC)
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
Subject: [PATCH v4 03/20] power: supply: bq25890: Reduce reported CONSTANT_CHARGE_CURRENT_MAX for low temperatures
Date:   Mon,  6 Dec 2021 10:33:01 +0100
Message-Id: <20211206093318.45214-4-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index fb987579d05a..7a3269c06b38 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -94,6 +94,7 @@ struct bq25890_state {
 	u8 vsys_status;
 	u8 boost_fault;
 	u8 bat_fault;
+	u8 ntc_fault;
 };
 
 struct bq25890_device {
@@ -407,6 +408,14 @@ enum bq25890_chrg_fault {
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
@@ -499,6 +508,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 
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
@@ -583,7 +604,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
-		{F_CHG_FAULT,	&state->chrg_fault}
+		{F_CHG_FAULT,	&state->chrg_fault},
+		{F_NTC_FAULT,	&state->ntc_fault}
 	};
 
 	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
@@ -594,9 +616,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
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

