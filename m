Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FEB44F969
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhKNRIG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236283AbhKNRHQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZwGtdlc85THTd5OwQWqXkWR69/kUF2qMVHBRX0Ls8Y=;
        b=MoInqJFFCvYf3CaHbMdaGAcLIrslz3Yz3UThrcJ/uS2czOUrBPebiVbO3qhtUr0qLiZNtv
        dxEev4Tu/OycRgEPjlUlxGTCGkivUTYe7/EOu496eWf+TD5KlXckH6EFo9XR8HnjpP8T/0
        Cv4NVyZA8uKQWK6bJaMiZ+0tcXLe70Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-vKCbXiWAOaasvMZS-b2ZTw-1; Sun, 14 Nov 2021 12:04:20 -0500
X-MC-Unique: vKCbXiWAOaasvMZS-b2ZTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B617802575;
        Sun, 14 Nov 2021 17:04:18 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF6301346F;
        Sun, 14 Nov 2021 17:04:14 +0000 (UTC)
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
Subject: [PATCH v2 10/20] power: supply: bq25890: Add bq25890_set_otg_cfg() helper
Date:   Sun, 14 Nov 2021 18:03:25 +0100
Message-Id: <20211114170335.66994-11-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index 2bdfb58cda75..3c41fe86b3d3 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -801,6 +801,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
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
@@ -810,25 +821,16 @@ static void bq25890_usb_work(struct work_struct *data)
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
2.31.1

