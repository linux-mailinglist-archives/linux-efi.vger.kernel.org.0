Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEE4692AD
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbhLFJiv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241022AbhLFJim (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSFllL0K7X0KVTucBJnSMumxKusMGygWrLDj1HKAn7A=;
        b=IqwG6v+Z41nswfRU9oACRkVqlAsq32kJblIVJO03zKldDQU2P7eoCF9GafXmCaBq7WO7Ay
        SQ0d4WKTaEqZybAA0uyqPq1iwJHT7wSVDfeA6oBAPvzDRZl3nFC6hk6i+AbhAz7KuNurrm
        45luCs8ezgD5AkKLTjJyQbmjj5qk1PI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-11-iD-Zz3iNMzav62Xi_GAH_A-1; Mon, 06 Dec 2021 04:35:07 -0500
X-MC-Unique: iD-Zz3iNMzav62Xi_GAH_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB7C4101F003;
        Mon,  6 Dec 2021 09:35:04 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 309E25DF3F;
        Mon,  6 Dec 2021 09:34:49 +0000 (UTC)
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
Subject: [PATCH v4 13/20] power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
Date:   Mon,  6 Dec 2021 10:33:11 +0100
Message-Id: <20211206093318.45214-14-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

