Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD59469284
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhLFJhZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240933AbhLFJhZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fANyvle+meUJ4owjhpqvoJKR2AJ1xpjSPkIqPG9nFHk=;
        b=evGt7nc/WhTlEpzmRThd5t36aSRnFm9T+pmw1i44m9Jghp5fcsi8irx/FEjTSa1swB2U8a
        N4UK0UMTcIXk2kcYI6UzW8Jk7qT2/BPb9kpYLAU/5rQORM/eYNjMCVbBmTf9O/CfN21UF0
        buX4rIaaUvv5oIVAoLkcplNo9eIAmTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-VDXfFfaVM66dZyl6b79tJQ-1; Mon, 06 Dec 2021 04:33:52 -0500
X-MC-Unique: VDXfFfaVM66dZyl6b79tJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E981281CCB5;
        Mon,  6 Dec 2021 09:33:49 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 679F0ADD6;
        Mon,  6 Dec 2021 09:33:46 +0000 (UTC)
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
Subject: [PATCH v4 05/20] power: supply: bq25890: Add support to skip reset at probe() / remove()
Date:   Mon,  6 Dec 2021 10:33:03 +0100
Message-Id: <20211206093318.45214-6-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On most x86/ACPI devices the firmware already fully initializes
the bq25890 charger at boot, in this case it is best to not reset
it at probe() time.

At support for a new "linux,skip-reset" boolean property to support this.
So far this new property is only used on x86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- New patch in v2 of this series, together with the "linux,read-back-settings"
  patch, this patch replaces the "ti,skip-init" patch from v1
---
 drivers/power/supply/bq25890_charger.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index eaf0400b632f..cd80d748df92 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -110,6 +110,7 @@ struct bq25890_device {
 	struct regmap *rmap;
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
 
+	bool skip_reset;
 	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
@@ -739,10 +740,12 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 {
 	int ret;
 
-	ret = bq25890_chip_reset(bq);
-	if (ret < 0) {
-		dev_dbg(bq->dev, "Reset failed %d\n", ret);
-		return ret;
+	if (!bq->skip_reset) {
+		ret = bq25890_chip_reset(bq);
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Reset failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* disable watchdog */
@@ -977,6 +980,8 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	int ret;
 	struct bq25890_init_data *init = &bq->init_data;
 
+	bq->skip_reset = device_property_read_bool(bq->dev, "linux,skip-reset");
+
 	ret = bq25890_fw_read_u32_props(bq);
 	if (ret < 0)
 		return ret;
@@ -1089,8 +1094,10 @@ static int bq25890_remove(struct i2c_client *client)
 	if (!IS_ERR_OR_NULL(bq->usb_phy))
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
 
-	/* reset all registers to default values */
-	bq25890_chip_reset(bq);
+	if (!bq->skip_reset) {
+		/* reset all registers to default values */
+		bq25890_chip_reset(bq);
+	}
 
 	return 0;
 }
-- 
2.33.1

