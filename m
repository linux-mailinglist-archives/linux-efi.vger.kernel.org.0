Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434CC4A3938
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbiA3UrM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356252AbiA3UrL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkHMjBM63zGg47ORcfkgLOvjulrZ8Qq0h9KQnMkwKnc=;
        b=Ijp7uMOprH3aX1It/bL1wzeZPUnj89YMgNC3tUMl2OD3cjf5COJVYoeQh9af7037CwjAHJ
        zBPcGyqZ/POJzZlzjRkwxDpiqRZPwIy408eLMwxgS1H9lRPKfT8zhM7WQtNxnmKywEYgsP
        DDOFPpJVEPBBL9USHfRi/R02RfbBjlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332--9mU_lNdMkmLguuV0mrLiQ-1; Sun, 30 Jan 2022 15:47:07 -0500
X-MC-Unique: -9mU_lNdMkmLguuV0mrLiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC801006AA3;
        Sun, 30 Jan 2022 20:47:05 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C03CE61093;
        Sun, 30 Jan 2022 20:47:01 +0000 (UTC)
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
Subject: [PATCH v4 09/20] power: supply: bq25890: Add bq25890_set_otg_cfg() helper
Date:   Sun, 30 Jan 2022 21:45:46 +0100
Message-Id: <20220130204557.15662-10-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a bq25890_set_otg_cfg() helper function, this is a preparation
patch for adding regulator support.

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

