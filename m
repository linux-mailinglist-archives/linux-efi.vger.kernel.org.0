Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049174A5D2A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiBANJO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238597AbiBANIv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6m/oOMAeql9tfpB3KRE+NG5uI7PXHCqGYzT2XNpmPYw=;
        b=T9dDtJvssDAefeTvdXtGmIFVcRNhma+9ivrekYC/A4LI6byXCzZqSRhT16kVW17k58G0da
        /+h/8u7vbJY0zpgwmHZS1PXhhXJx0w/aCpnqGb9x1NXVEUflyljrJF0Y0OJKwWoRMUrYVN
        h7Sep3lMeb5Rkttu8HGCuS7TLgwJpxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-BHeNKujnNq6vC_kNUSxtZA-1; Tue, 01 Feb 2022 08:08:48 -0500
X-MC-Unique: BHeNKujnNq6vC_kNUSxtZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDAE91091DA0;
        Tue,  1 Feb 2022 13:08:45 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 595CB795B1;
        Tue,  1 Feb 2022 13:08:42 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v5 18/20] extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
Date:   Tue,  1 Feb 2022 14:07:04 +0100
Message-Id: <20220201130706.46685-19-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a preparation patch for adding support for registering
a power_supply class device.

Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
will make the following switch-case return EXTCON_CHG_USB_SDP
just as before, so there is no functional change.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
- s/Save/safe/ in a comment (spelling fix)

Changes in v3:
- Reword the commit message
---
 drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 3fc5dd06849a..a828ca89ca7f 100644
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
+		/* Safe fallback */
+		usbsrc = CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT;
 	}
 
 	usbsrc = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
-- 
2.33.1

