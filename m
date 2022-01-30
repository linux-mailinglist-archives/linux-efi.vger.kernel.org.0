Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6B4A394B
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356245AbiA3Urf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356296AbiA3Urb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSFllL0K7X0KVTucBJnSMumxKusMGygWrLDj1HKAn7A=;
        b=PLBM4ETc7YDlKromNM5tkujHsbTg3OzEyv2ORYdckfWaCSnY2u5pawF9dDbixzQv74P/s2
        0QUPk4bgwexW7TGkuUPU5eHRM2Xzfoo7+ue508GI4TNt2Z6HcqNufW+EhfLY0gHQ7EDCcl
        tzvK5riFIzWebc4f9dHmeuI9FHm9jHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-x_bNB88xPy2MWfIC91eylg-1; Sun, 30 Jan 2022 15:47:24 -0500
X-MC-Unique: x_bNB88xPy2MWfIC91eylg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4971E18397A7;
        Sun, 30 Jan 2022 20:47:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9FFB61093;
        Sun, 30 Jan 2022 20:47:18 +0000 (UTC)
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
Subject: [PATCH v4 13/20] power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
Date:   Sun, 30 Jan 2022 21:45:50 +0100
Message-Id: <20220130204557.15662-14-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the devm_regmap_field_bulk_alloc() helper function instead of
open-coding this ourselves.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-series
---
 drivers/power/supply/bq25890_charger.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 179abed92f9b..852a6fec4339 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1165,7 +1165,6 @@ static int bq25890_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct bq25890_device *bq;
 	int ret;
-	int i;
 
 	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq)
@@ -1182,15 +1181,10 @@ static int bq25890_probe(struct i2c_client *client,
 		return dev_err_probe(dev, PTR_ERR(bq->rmap),
 				     "failed to allocate register map\n");
 
-	for (i = 0; i < ARRAY_SIZE(bq25890_reg_fields); i++) {
-		const struct reg_field *reg_fields = bq25890_reg_fields;
-
-		bq->rmap_fields[i] = devm_regmap_field_alloc(dev, bq->rmap,
-							     reg_fields[i]);
-		if (IS_ERR(bq->rmap_fields[i]))
-			return dev_err_probe(dev, PTR_ERR(bq->rmap_fields[i]),
-					     "cannot allocate regmap field\n");
-	}
+	ret = devm_regmap_field_bulk_alloc(dev, bq->rmap, bq->rmap_fields,
+					   bq25890_reg_fields, F_MAX_FIELDS);
+	if (ret)
+		return ret;
 
 	i2c_set_clientdata(client, bq);
 
-- 
2.33.1

