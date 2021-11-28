Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED44608BE
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359623AbhK1SYg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359145AbhK1SWc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0C3Ldn0Cfkx4/nsKi8BL8ewBsIjFPAKNhcBTlVzOw0=;
        b=E6WxYXy1ZX/ZozdxNidtdK5JL7pKALDZv6MYEQ2P4nqEqx57d9HUqmKcaki8F8aLZ1UqEm
        CpdDn1Z+PUFimUO6f/Wu+IJehYZrBhHgvJoPsJYcgIEssEBT/yva2PL0wzU7R/P7HLETeg
        AnsY+Pxl7q4lyLPYzhqNKUKn9/wDx0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-wkY6Rn5tNsm_7j-k6ZljxA-1; Sun, 28 Nov 2021 13:19:12 -0500
X-MC-Unique: wkY6Rn5tNsm_7j-k6ZljxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C05D33E741;
        Sun, 28 Nov 2021 18:19:10 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8462D10016F4;
        Sun, 28 Nov 2021 18:19:07 +0000 (UTC)
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
Subject: [PATCH v3 13/20] power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
Date:   Sun, 28 Nov 2021 19:18:02 +0100
Message-Id: <20211128181809.326736-14-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 5d23544c84a8..bfaab39153f8 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1130,7 +1130,6 @@ static int bq25890_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct bq25890_device *bq;
 	int ret;
-	int i;
 
 	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq)
@@ -1147,15 +1146,10 @@ static int bq25890_probe(struct i2c_client *client,
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

