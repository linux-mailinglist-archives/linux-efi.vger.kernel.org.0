Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54EF4A5CFF
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiBANIj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238576AbiBANIT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fql1fsmkbt4ewCGLU1c7E+Xi7wnkciIvO4OTkH1Y4qs=;
        b=DW+KpG9HVbbGMBYI4l0WTChL2LVPJuk79PYua++on+gCyFPCo5n0wYmWBMeJMUWRjqQk/7
        YKfvHOtnxi1/bbonQlckvPo8Qp/4L5D3mkYS3uCiosPFdmPoIWyAFF05RsorxbZdNtWXUK
        J37mdQapGWYbQM8hVAYQKbGLwsT1e/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-WVsVP21RPeeDu4HSppQOqA-1; Tue, 01 Feb 2022 08:08:13 -0500
X-MC-Unique: WVsVP21RPeeDu4HSppQOqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9378519E2;
        Tue,  1 Feb 2022 13:08:10 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03A20795B1;
        Tue,  1 Feb 2022 13:08:06 +0000 (UTC)
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
Subject: [PATCH v5 09/20] power: supply: bq25890: Add bq25890_set_otg_cfg() helper
Date:   Tue,  1 Feb 2022 14:06:55 +0100
Message-Id: <20220201130706.46685-10-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a bq25890_set_otg_cfg() helper function, this is a preparation
patch for adding regulator support.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 548d1a793e31..162bffb02410 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -832,6 +832,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
 	return PTR_ERR_OR_ZERO(bq->charger);
 }
 
+static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
+{
+	int ret;
+
+	ret = bq25890_field_write(bq, F_OTG_CFG, val);
+	if (ret < 0)
+		dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);
+
+	return ret;
+}
+
 static void bq25890_usb_work(struct work_struct *data)
 {
 	int ret;
@@ -841,25 +852,16 @@ static void bq25890_usb_work(struct work_struct *data)
 	switch (bq->usb_event) {
 	case USB_EVENT_ID:
 		/* Enable boost mode */
-		ret = bq25890_field_write(bq, F_OTG_CFG, 1);
-		if (ret < 0)
-			goto error;
+		bq25890_set_otg_cfg(bq, 1);
 		break;
 
 	case USB_EVENT_NONE:
 		/* Disable boost mode */
-		ret = bq25890_field_write(bq, F_OTG_CFG, 0);
-		if (ret < 0)
-			goto error;
-
-		power_supply_changed(bq->charger);
+		ret = bq25890_set_otg_cfg(bq, 0);
+		if (ret == 0)
+			power_supply_changed(bq->charger);
 		break;
 	}
-
-	return;
-
-error:
-	dev_err(bq->dev, "Error switching to boost/charger mode.\n");
 }
 
 static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
-- 
2.33.1

