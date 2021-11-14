Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52444F970
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhKNRId (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236233AbhKNRHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdxwmnlmBPdqk9J2W0qKJTJXaLjrLyAPUqGoZc8Jy8Y=;
        b=aztRTv+SrC21qFMQWCIcc2r3GNeHPzW5znonJPImStabs5RX7HZ4PzD2a/EtVg32h1O4jN
        GZFCl53b+OYS5SULsh5it9lVB3Tc2Gcy0+S5+aRqAWbBI5S8+kXICRbPGfUDEhsbTsgrE9
        kO98xOKqTFU7Tf+MDZHlymm99/dAdO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-Oky9LtFgNb-p0HeP-eFpYQ-1; Sun, 14 Nov 2021 12:04:28 -0500
X-MC-Unique: Oky9LtFgNb-p0HeP-eFpYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444A215721;
        Sun, 14 Nov 2021 17:04:26 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADC6E1346F;
        Sun, 14 Nov 2021 17:04:22 +0000 (UTC)
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
Subject: [PATCH v2 12/20] power: supply: bq25890: On the bq25892 set the IINLIM based on external charger detection
Date:   Sun, 14 Nov 2021 18:03:27 +0100
Message-Id: <20211114170335.66994-13-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The bq25892 does not have builtin charger-type detection like the bq25980,
there might be some external charger detection capability, which will be
modelled as a power_supply class-device supplying the bq25892.

Use the usb_type property value from the supplier psy-device to set the
input-current-limit (when available).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index e06ca7b0eb3e..57e4034bc9cd 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -564,6 +564,38 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 	return 0;
 }
 
+/* On the BQ25892 try to get charger-type info from our supplier */
+static void bq25890_charger_external_power_changed(struct power_supply *psy)
+{
+	struct bq25890_device *bq = power_supply_get_drvdata(psy);
+	union power_supply_propval val;
+	int input_current_limit, ret;
+
+	if (bq->chip_version != BQ25892)
+		return;
+
+	ret = power_supply_get_property_from_supplier(bq->charger,
+						      POWER_SUPPLY_PROP_USB_TYPE,
+						      &val);
+	if (ret)
+		return;
+
+	switch (val.intval) {
+	case POWER_SUPPLY_USB_TYPE_DCP:
+		input_current_limit = bq25890_find_idx(2000000, TBL_IINLIM);
+		break;
+	case POWER_SUPPLY_USB_TYPE_CDP:
+	case POWER_SUPPLY_USB_TYPE_ACA:
+		input_current_limit = bq25890_find_idx(1500000, TBL_IINLIM);
+		break;
+	case POWER_SUPPLY_USB_TYPE_SDP:
+	default:
+		input_current_limit = bq25890_find_idx(500000, TBL_IINLIM);
+	}
+
+	bq25890_field_write(bq, F_IINLIM, input_current_limit);
+}
+
 static int bq25890_get_chip_state(struct bq25890_device *bq,
 				  struct bq25890_state *state)
 {
@@ -787,6 +819,7 @@ static const struct power_supply_desc bq25890_power_supply_desc = {
 	.properties = bq25890_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
 	.get_property = bq25890_power_supply_get_property,
+	.external_power_changed	= bq25890_charger_external_power_changed,
 };
 
 static int bq25890_power_supply_init(struct bq25890_device *bq)
-- 
2.31.1

