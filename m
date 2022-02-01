Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60274A5D08
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiBANIl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238626AbiBANI0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdkSM+dit0FawOKebprfdbNLLFD6Ew/yIEsh7pDx4Fc=;
        b=eDNsJFiibhrjPJ7moBRj8V2oQU1WTo8SALR4tyKNvHUeF4J1jSEDNT9f7KY7BrC3zDk08g
        AP00jzTzDxujnAjRTeUr4Xwx1XF0+aPaGiKHzz7kCpgZFCsegy/vL7GtPrD+iLBpx6WddH
        4pp1ILk9gh/ges3zp8P8R7xWVKq0Zac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-Dv6zCaXoNBCgUSQYbaU23A-1; Tue, 01 Feb 2022 08:08:21 -0500
X-MC-Unique: Dv6zCaXoNBCgUSQYbaU23A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAAB3344AF;
        Tue,  1 Feb 2022 13:08:18 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F04C0795B1;
        Tue,  1 Feb 2022 13:08:14 +0000 (UTC)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 11/20] power: supply: bq25890: On the bq25892 set the IINLIM based on external charger detection
Date:   Tue,  1 Feb 2022 14:06:57 +0100
Message-Id: <20220201130706.46685-12-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The bq25892 does not have builtin charger-type detection like the bq25980,
there might be some external charger detection capability, which will be
modelled as a power_supply class-device supplying the bq25892.

Use the usb_type property value from the supplier psy-device to set the
input-current-limit (when available).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 637cdd3b6b11..3de72f0fbf3e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -594,6 +594,38 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
@@ -818,6 +850,7 @@ static const struct power_supply_desc bq25890_power_supply_desc = {
 	.properties = bq25890_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
 	.get_property = bq25890_power_supply_get_property,
+	.external_power_changed	= bq25890_charger_external_power_changed,
 };
 
 static int bq25890_power_supply_init(struct bq25890_device *bq)
-- 
2.33.1

