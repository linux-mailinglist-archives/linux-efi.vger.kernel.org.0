Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF8440F67
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaQ1q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbhJaQ12 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPOEwjI1K1hO+z9xpZRtE63xzqb/sG/Qd2WRtIRCf0M=;
        b=HOp/vxAohmSwK5gTgcSAhsxh3K+ixCeodwfsDzzn/x3kVIkBKH62dRuMRoNattun3drsjF
        Z+eXjoARmNwR6WOWZmYWJtwyDMUJYMAHMky7RTUz/95M1w8nhSx4m83ftrM3xxrlj+Cbhd
        THLmRtcIOJOf8tIIGGJR6vBjxE+uIsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-m8dTSM8mMaaylGzLBFFztA-1; Sun, 31 Oct 2021 12:24:50 -0400
X-MC-Unique: m8dTSM8mMaaylGzLBFFztA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB4A362F9;
        Sun, 31 Oct 2021 16:24:47 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE3F100763D;
        Sun, 31 Oct 2021 16:24:44 +0000 (UTC)
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
Subject: [RFC 4/5] power: supply: bq27xxx: Add dev helper variable to bq27xxx_battery_i2c_probe()
Date:   Sun, 31 Oct 2021 17:24:27 +0100
Message-Id: <20211031162428.22368-5-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
References: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a dev local variable to the bq27xxx_battery_i2c_probe(), to replace
"&client->dev" in various places.

Note the resulting cleanup is somewhat minimal, this is mostly
a preparation for adding ACPI enumeration support which will
use the new "dev" variable more.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index cf38cbfe13e9..0a1b922389e1 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -139,6 +139,7 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct bq27xxx_device_info *di;
 	int ret;
 	char *name;
@@ -151,16 +152,16 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	if (num < 0)
 		return num;
 
-	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, num);
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", id->name, num);
 	if (!name)
 		goto err_mem;
 
-	di = devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
+	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
 		goto err_mem;
 
 	di->id = num;
-	di->dev = &client->dev;
+	di->dev = dev;
 	di->chip = id->driver_data;
 	di->name = name;
 
@@ -179,13 +180,12 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
 		if (ret) {
-			dev_err(&client->dev,
-				"Unable to register IRQ %d error %d\n",
+			dev_err(dev, "Unable to register IRQ %d error %d\n",
 				client->irq, ret);
 			bq27xxx_battery_teardown(di);
 			goto err_failed;
-- 
2.31.1

