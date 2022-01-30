Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3184A3932
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356243AbiA3UrK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:47:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356251AbiA3UrI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4njHS/l+xCpUU6oJvmynOFwMBGuHnqEE6FG5/Vy8lc=;
        b=OFkF1qqkf7SjBYJMjdxJh9dmqLyyfM3thuhPjq0LCFw1XVumPMIiMSC2rIMer9CLVSpDjb
        Ub6fb90HTCOI+M+KhSMqj3Q8bYAjSLt4FKvr/5Hy86TCfoHg/wcqPcQ3pYRQUKym/1XfpY
        9s+ibXwfIrOTYRSrXZZGlRs5aK7SXTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-4cuJuRSZP92RlBmrS6_f5w-1; Sun, 30 Jan 2022 15:47:03 -0500
X-MC-Unique: 4cuJuRSZP92RlBmrS6_f5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7783A814245;
        Sun, 30 Jan 2022 20:47:01 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9971061093;
        Sun, 30 Jan 2022 20:46:55 +0000 (UTC)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 08/20] power: supply: bq25890: Drop dev->platform_data == NULL check
Date:   Sun, 30 Jan 2022 21:45:45 +0100
Message-Id: <20220130204557.15662-9-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop the "if (!dev->platform_data)" check, this seems to be an attempt
for allowing loading the driver on devices without devicetree stemming
from the initial commit of the driver (with the presumed intention being
the "return -ENODEV" else branch getting replaced with something else).

With the new "linux,skip-init" and "linux,read-back-settings" properties
the driver can actually supports devices without devicetree and this
check no longer makes sense.

While at it, also switch to dev_err_probe(), which is already used in
various other places in the driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index d185299db9c3..548d1a793e31 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1048,16 +1048,9 @@ static int bq25890_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (!dev->platform_data) {
-		ret = bq25890_fw_probe(bq);
-		if (ret < 0) {
-			dev_err(dev, "Cannot read device properties: %d\n",
-				ret);
-			return ret;
-		}
-	} else {
-		return -ENODEV;
-	}
+	ret = bq25890_fw_probe(bq);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "reading device properties\n");
 
 	ret = bq25890_hw_init(bq);
 	if (ret < 0) {
-- 
2.33.1

