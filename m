Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A36440B08
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhJ3SbG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhJ3SbD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrrTuUxsrl1Oeg8B72TGUw5tNWzGAIZr3rniIiQjl/A=;
        b=Je3vX0e+oaWzl5Q6tQ1o13STapxGicS+gZyuQmBFkCMM9PgumalBbz2TSTO5/sHc2NiFYU
        X5m+HmzOBf5zsHEa7UCv4CqpbyL8PI4NEymKl/+xGwQ5elR0CVu5WFZo3mfdueWn6xJz8D
        /jULB3Qpjfi4xkiFwoKjo3+zOlj+VcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-xUbbNizWM3WwSodiMeAfNA-1; Sat, 30 Oct 2021 14:28:29 -0400
X-MC-Unique: xUbbNizWM3WwSodiMeAfNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E226D806689;
        Sat, 30 Oct 2021 18:28:26 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 207DF5F4E1;
        Sat, 30 Oct 2021 18:28:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 03/13] power: supply: bq25890: Fix race causing oops at boot
Date:   Sat, 30 Oct 2021 20:28:03 +0200
Message-Id: <20211030182813.116672-4-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before this commit the driver was registering its interrupt handler before
it registered the power_supply, causing bq->charger to potentially be NULL
when the interrupt handler runs, triggering a NULL pointer exception in
the interrupt handler:

[   21.213531] BUG: kernel NULL pointer dereference, address: 0000000000000680
...
[   21.213573] Hardware name: Xiaomi Inc Mipad2/Mipad, BIOS MIPad-P4.X64.0043.R03.1603071414 03/07/2016
[   21.213576] RIP: 0010:__lock_acquire+0x5c5/0x1de0
...
[   21.213629] Call Trace:
[   21.213636]  ? disable_irq_nosync+0x10/0x10
[   21.213644]  ? __mutex_unlock_slowpath+0x35/0x260
[   21.213655]  lock_acquire+0xb5/0x2b0
[   21.213661]  ? power_supply_changed+0x23/0x90
[   21.213670]  ? disable_irq_nosync+0x10/0x10
[   21.213676]  _raw_spin_lock_irqsave+0x48/0x60
[   21.213682]  ? power_supply_changed+0x23/0x90
[   21.213687]  power_supply_changed+0x23/0x90
[   21.213697]  __bq25890_handle_irq+0x5e/0xe0 [bq25890_charger]
[   21.213709]  bq25890_irq_handler_thread+0x26/0x40 [bq25890_charger]
[   21.213718]  irq_thread_fn+0x20/0x60
...

Fix this by moving the power_supply_register() call to above the
request_threaded_irq() call.

Note this fix includes making the following 2 (necessary) changes:

1. Switch to the devm version of power_supply_register() to avoid the
need to make the error-handling in probe() more complicated.

2. Rename the "irq_fail" label to "err_unregister_usb_notifier" since
the old name no longer makes sense after this fix.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 945c3257ca93..491d36a3811a 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -734,8 +734,9 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
 	psy_cfg.supplied_to = bq25890_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(bq25890_charger_supplied_to);
 
-	bq->charger = power_supply_register(bq->dev, &bq25890_power_supply_desc,
-					    &psy_cfg);
+	bq->charger = devm_power_supply_register(bq->dev,
+						 &bq25890_power_supply_desc,
+						 &psy_cfg);
 
 	return PTR_ERR_OR_ZERO(bq->charger);
 }
@@ -985,22 +986,22 @@ static int bq25890_probe(struct i2c_client *client,
 		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
 	}
 
+	ret = bq25890_power_supply_init(bq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register power supply\n");
+		goto err_unregister_usb_notifier;
+	}
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq25890_irq_handler_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					BQ25890_IRQ_PIN, bq);
 	if (ret)
-		goto irq_fail;
-
-	ret = bq25890_power_supply_init(bq);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register power supply\n");
-		goto irq_fail;
-	}
+		goto err_unregister_usb_notifier;
 
 	return 0;
 
-irq_fail:
+err_unregister_usb_notifier:
 	if (!IS_ERR_OR_NULL(bq->usb_phy))
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
 
@@ -1011,8 +1012,6 @@ static int bq25890_remove(struct i2c_client *client)
 {
 	struct bq25890_device *bq = i2c_get_clientdata(client);
 
-	power_supply_unregister(bq->charger);
-
 	if (!IS_ERR_OR_NULL(bq->usb_phy))
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
 
-- 
2.31.1

