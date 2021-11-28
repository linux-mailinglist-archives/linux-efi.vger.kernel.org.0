Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46F4608D8
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359183AbhK1SZA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359188AbhK1SWz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJq6tqdBzpqmFgoJbA6IQF9RYULArc1usxXeNF9a/yU=;
        b=SffvEAf3dJtyoqvFzuyRX8wCDsDZ48+Sb8TykmY1q8Wsffk4Zcc648JLacv/UJxccpKZnx
        WPsfYwJizll0cU5u+1za/cgDDB+dymSlvJnLjDlRF4FOb0SNX/dF4yVL+U/7jNPeuioZpD
        MCMNTC+ajo2xlSQfhNas08Te2zh8C8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-565-a8Ca5Sz8MuuTrFXjeKFUIg-1; Sun, 28 Nov 2021 13:19:37 -0500
X-MC-Unique: a8Ca5Sz8MuuTrFXjeKFUIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6613106B3A3;
        Sun, 28 Nov 2021 18:19:34 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7215E10016F4;
        Sun, 28 Nov 2021 18:19:29 +0000 (UTC)
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
Subject: [PATCH v3 18/20] extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
Date:   Sun, 28 Nov 2021 19:18:07 +0100
Message-Id: <20211128181809.326736-19-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a preparation patch for adding support for registering
a power_supply class device.

Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
will make the following switch-case return EXTCON_CHG_USB_SDP
just as before, so there is no functional change.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Reword the commit message
---
 drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index edc386937dee..150637bea417 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -153,14 +153,15 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 	} while (time_before(jiffies, timeout));
 
 	if (status != CHT_WC_USBSRC_STS_SUCCESS) {
-		if (ignore_errors)
-			return EXTCON_CHG_USB_SDP; /* Save fallback */
+		if (!ignore_errors) {
+			if (status == CHT_WC_USBSRC_STS_FAIL)
+				dev_warn(ext->dev, "Could not detect charger type\n");
+			else
+				dev_warn(ext->dev, "Timeout detecting charger type\n");
+		}
 
-		if (status == CHT_WC_USBSRC_STS_FAIL)
-			dev_warn(ext->dev, "Could not detect charger type\n");
-		else
-			dev_warn(ext->dev, "Timeout detecting charger type\n");
-		return EXTCON_CHG_USB_SDP; /* Save fallback */
+		/* Save fallback */
+		usbsrc = CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT;
 	}
 
 	usbsrc = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
-- 
2.33.1

