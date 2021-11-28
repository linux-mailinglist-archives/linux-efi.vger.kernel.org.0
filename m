Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2614608A9
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359436AbhK1SYQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359044AbhK1SWI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jS99cMxod1d+bUJ3I8d7+KjfVxmX1FkL4W0WV6LzkI=;
        b=Pg3tWhlkrDQ1bm54/QtV7oCH7xieTS52xUKuvPIVPj1VmJuhShNeomvh5EeUZIP+MAJ1SC
        SLq+mPn57nvnNoHQoCD+RXjOxQoIAgGhhYffUY1ykg7s24RKt72DgoGcKs1TilOLUG3lcQ
        H5dPZg/fnKa6lkgxNGH3b7n+oAbNo0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-c6yQahdROeqwRahFs-XHnA-1; Sun, 28 Nov 2021 13:18:48 -0500
X-MC-Unique: c6yQahdROeqwRahFs-XHnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6949D10B7462;
        Sun, 28 Nov 2021 18:18:45 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0901A10016F4;
        Sun, 28 Nov 2021 18:18:41 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 08/20] power: supply: bq25890: Drop dev->platform_data == NULL check
Date:   Sun, 28 Nov 2021 19:17:57 +0100
Message-Id: <20211128181809.326736-9-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index aa643f533295..d0a7b9289034 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1013,16 +1013,9 @@ static int bq25890_probe(struct i2c_client *client,
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

