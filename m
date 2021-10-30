Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B394C440B1F
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhJ3SbT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhJ3SbS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5I5u7rZgS0hlNCSBlHnDbyo/0DfFLenVV2CPz8MtkPA=;
        b=jGN7UUyUbh2YstNcAFaz1xV5grPqG976SetSWPyNImA/rrTKcXEQ4r0ia1pDmND8t35OTT
        OPR5is06mrnrUPZdschNa+fKiffcYSdbsAdO7Bx+TDbm6TZSiy9jeSqQSUa6tjyxgQxvGh
        BUXNhhiwDdxslQkzWz6eMWohHp9kqDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-PsKouzDrOPGf4HO5oaye5Q-1; Sat, 30 Oct 2021 14:28:44 -0400
X-MC-Unique: PsKouzDrOPGf4HO5oaye5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4284810066F3;
        Sat, 30 Oct 2021 18:28:42 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 724FF5F4E1;
        Sat, 30 Oct 2021 18:28:39 +0000 (UTC)
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
Subject: [PATCH 08/13] power: supply: bq25890: Drop dev->platform_data == NULL check
Date:   Sat, 30 Oct 2021 20:28:08 +0200
Message-Id: <20211030182813.116672-9-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop the "if (!dev->platform_data)" check, this seems to be an attempt
for allowing loading the driver on devices without devicetree stemming
from the initial commit of the driver (with the presumed intention being
the "return -ENODEV" else branch getting replaced with something else).

With the new "ti,skip-init" property the driver can actually supports
devices without devicetree and this check no longer makes sense.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index aa4d04d20cdc..163ca5d761aa 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -990,14 +990,10 @@ static int bq25890_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (!dev->platform_data) {
-		ret = bq25890_fw_probe(bq);
-		if (ret < 0) {
-			dev_err(dev, "Cannot read device properties.\n");
-			return ret;
-		}
-	} else {
-		return -ENODEV;
+	ret = bq25890_fw_probe(bq);
+	if (ret < 0) {
+		dev_err(dev, "Cannot read device properties.\n");
+		return ret;
 	}
 
 	ret = bq25890_hw_init(bq);
-- 
2.31.1

