Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902284A5CF4
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBANIO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238482AbiBANII (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzmhutS/Gv65AIsAtOgd6A24T3ONzb9FueC1henp/ZM=;
        b=imcyCi99rrn64fKLvF3fGlxp/+7kPhQbVP/g1ppVPv79Cy7mIAzL8PdArdXhiIdOmECQl9
        uNVH/aywTWcUL6tZ7zb+0PcMo1fE39RHZmgoduEN2iJyg6j9QptXmI5UCaC7CHimo/2NS1
        nFyd34m4LcHU3toDeIehBlfoyo4uYIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-MwH2HwujPWCX3KhCRunTeg-1; Tue, 01 Feb 2022 08:08:05 -0500
X-MC-Unique: MwH2HwujPWCX3KhCRunTeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC001091DA5;
        Tue,  1 Feb 2022 13:08:02 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23A747A227;
        Tue,  1 Feb 2022 13:07:58 +0000 (UTC)
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
Subject: [PATCH v5 07/20] power: supply: bq25890: Enable charging on boards where we skip reset
Date:   Tue,  1 Feb 2022 14:06:53 +0100
Message-Id: <20220201130706.46685-8-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On boards where the "linux,skip-reset" boolean property is set we don't
reset the charger; and on some boards where the fw takes care of
initalizition F_CHG_CFG is set to 0 before handing control over to the OS.

Explicitly set F_CHG_CFG to 1 on boards where we don't reset the charger,
so that charging is always enabled on these boards, like it is always
enabled on boards where we do reset the charger.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f758e28046e5..d185299db9c3 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -747,6 +747,17 @@ static int bq25890_hw_init(struct bq25890_device *bq)
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
2.33.1

