Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86944F9A8
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhKNROG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236396AbhKNRHv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shJ57dElBm4RG/R44dnCJ2w5WNB/dQYTx2QpI9Dvl2I=;
        b=TxSMwg3gQMHnk1Z6IRebB0bglBdID4f8kgoo+/PoNbm3OzUIgC0qC9g83XiwUHaflstpKt
        2ZibZzqMd7HO0Kkwe/UP92PqqOKYyvzKgkayKYWqriudVtFPQmtDEyOO6pEyVnlmSzVotU
        pGPu/xDJyNLnAkDnpe3N3MxrA3ePY7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-U42T4QZaOx-imQHISHXUlA-1; Sun, 14 Nov 2021 12:04:51 -0500
X-MC-Unique: U42T4QZaOx-imQHISHXUlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3BE315720;
        Sun, 14 Nov 2021 17:04:48 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1861346F;
        Sun, 14 Nov 2021 17:04:45 +0000 (UTC)
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
Subject: [PATCH v2 18/20] extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
Date:   Sun, 14 Nov 2021 18:03:33 +0100
Message-Id: <20211114170335.66994-19-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Refactor cht_wc_extcon_get_charger() to have all the returns are in
the "switch (usbsrc)" cases.

This is a preparation patch for adding support for registering
a power_supply class device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 119b83793123..f2b93a99a625 100644
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
2.31.1

