Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D144A395C
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356364AbiA3UsS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356369AbiA3Uru (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NP5ZZjbP+5a6CBKM4ARGc3cpSsivbTp+jHAFBgsPOcE=;
        b=DVuqI6EfVeNvl7uRReKkRzjru+uaVozhUtRVpUeSw/H+dJm8cPoYgFRtW3UpzQ6Fb+rlKn
        DGKAdahOHms9QHQ5WCk1atOurIrv/Qp9UQ0yuBWlwk9GQNZFmeXstS385H8oi9rWA0JSTp
        8LiJz7UwJO6PoToquTfEu4SflRdW8uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-m-MSK84kPD6lBQTUrkJh_A-1; Sun, 30 Jan 2022 15:47:44 -0500
X-MC-Unique: m-MSK84kPD6lBQTUrkJh_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B1F18397A7;
        Sun, 30 Jan 2022 20:47:41 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A22C61093;
        Sun, 30 Jan 2022 20:47:38 +0000 (UTC)
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
Subject: [PATCH v4 18/20] extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
Date:   Sun, 30 Jan 2022 21:45:55 +0100
Message-Id: <20220130204557.15662-19-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

