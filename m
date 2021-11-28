Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7474608A6
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359428AbhK1SYO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359114AbhK1SWN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVEIk8EiUeWBSijpXC9M9VBIiLZ9k41SUpzSjknrdXs=;
        b=J0MXT2hnOfAPVZmRtEC0W1q5Vha8WqWlc6eujpLWqNHsSoUEpGSQanRd0ykaw9tk5v1HCF
        NtrbsZYUnjGORo0kTY0Htcj5QSMr+/e17Qdv006rtcP+L9ukurTL/eiB2R0cgZG3F6PIUU
        eBv0N3zMqnRpQlO/Z0pS1jiuKSplSoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-BfZyqUF8NAW8e5aBLJ6HXQ-1; Sun, 28 Nov 2021 13:18:51 -0500
X-MC-Unique: BfZyqUF8NAW8e5aBLJ6HXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFC519253CD;
        Sun, 28 Nov 2021 18:18:48 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D5210016F4;
        Sun, 28 Nov 2021 18:18:45 +0000 (UTC)
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
Subject: [PATCH v3 09/20] power: supply: bq25890: Add bq25890_set_otg_cfg() helper
Date:   Sun, 28 Nov 2021 19:17:58 +0100
Message-Id: <20211128181809.326736-10-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index d0a7b9289034..2a420e77b4f1 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -797,6 +797,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
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
@@ -806,25 +817,16 @@ static void bq25890_usb_work(struct work_struct *data)
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

