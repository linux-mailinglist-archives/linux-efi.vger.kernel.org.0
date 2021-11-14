Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0756F44F965
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhKNRHv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236265AbhKNRHM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbo3H69E27X3xdtb6FN9nDkX51ICU4AEhWEkpawIJNY=;
        b=BT8Jwdm7nGOGEUjlfjirmRRb+TSXErXFvA9VsHg6n9BCnEGFYJAQmyqt2nEcWA9gg7vsjR
        i0+BoSzbg47bnJf0xuXDa/xmj4/KaL7zaP07hLgC9ZEt1c+BY39XemAfd8vblgth3tmDJs
        z7rKMaqEFCxiZWgvTpYBTngaj6jI28k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-H7tedUprPKi7WQNDbL-MAw-1; Sun, 14 Nov 2021 12:04:13 -0500
X-MC-Unique: H7tedUprPKi7WQNDbL-MAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8B415720;
        Sun, 14 Nov 2021 17:04:10 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA2E19EF9;
        Sun, 14 Nov 2021 17:04:07 +0000 (UTC)
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
Subject: [PATCH v2 08/20] power: supply: bq25890: Enable charging on boards where we skip reset
Date:   Sun, 14 Nov 2021 18:03:23 +0100
Message-Id: <20211114170335.66994-9-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On boards where the "linux,skip-reset" boolean property is set we don't
reset the charger; and on some boards where the fw takes care of
initalizition F_CHG_CFG is set to 0 before handing control over to the OS.

Explicitly set F_CHG_CFG to 1 on boards where we don't reset the charger,
so that charging is always enabled on these boards, like it is always
enabled on boards where we do reset the charger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b7c38d2c5ede..a69a2173e31a 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -717,6 +717,17 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 			dev_dbg(bq->dev, "Reset failed %d\n", ret);
 			return ret;
 		}
+	} else {
+		/*
+		 * Ensure charging is enabled, on some boards where the fw
+		 * takes care of initalizition F_CHG_CFG is set to 0 before
+		 * handing control over to the OS.
+		 */
+		ret = bq25890_field_write(bq, F_CHG_CFG, 1);
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Enabling charging failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* disable watchdog */
-- 
2.31.1

