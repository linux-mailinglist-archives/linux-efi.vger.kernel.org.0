Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EF4A5D0D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiBANIm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236980AbiBANIa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWOq8ipKdu0ye8zyovRqB7y2IogztxuaG/1JG6BNsoQ=;
        b=Sc2/JPFdCQA7zMRD89rHlaTomUQ7ukAwuaxSnvqUNi/yQqnwTM/wEIIJAWs7xyoBxEAOy+
        4w4yr5NvnSD+Tkj/p3sIMDA3QGvhaGVrOtuUdu+QCAcObHsfTdTrqjKn83IBjOC8fjxzK1
        vSzlw1zCzDtaKZX/HzIIa/pEufBQ5Uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-hNnwRmZwON2cIvMFq8l4-g-1; Tue, 01 Feb 2022 08:08:29 -0500
X-MC-Unique: hNnwRmZwON2cIvMFq8l4-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE23344E2;
        Tue,  1 Feb 2022 13:08:26 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFEE4795B7;
        Tue,  1 Feb 2022 13:08:22 +0000 (UTC)
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
Subject: [PATCH v5 13/20] power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
Date:   Tue,  1 Feb 2022 14:06:59 +0100
Message-Id: <20220201130706.46685-14-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the devm_regmap_field_bulk_alloc() helper function instead of
open-coding this ourselves.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

