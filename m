Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB744F996
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhKNRKl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236423AbhKNRH7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKhlJl6L8XG/e1kTNa2zkugX2OC5+vLBLiGtbBb04F8=;
        b=MLOg2iwmBd3QCJ0ICb+PAK2bXOOoOhxNfBGmcZPkD2xoOKuOKSHkj/eZQtrddDe94xlEOK
        KhbL/PLnQrt92GbXvyAiYMumcw5c+KEwkSXQsTCrnH725w6HcqjkGItmpBy5etwRk0kRCS
        Q3tmUMYMgc2cRTAnItnGdPGqQ1JQTUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-sStz62q6NCWVIasF6iVnTA-1; Sun, 14 Nov 2021 12:04:58 -0500
X-MC-Unique: sStz62q6NCWVIasF6iVnTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C7E2809864;
        Sun, 14 Nov 2021 17:04:56 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFF3819EF9;
        Sun, 14 Nov 2021 17:04:52 +0000 (UTC)
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
Subject: [PATCH v2 20/20] extcon: intel-cht-wc: Report RID_A for ACA adapters
Date:   Sun, 14 Nov 2021 18:03:35 +0100
Message-Id: <20211114170335.66994-21-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Make cht_wc_extcon_get_id() report RID_A for ACA adapters, instead of
reporting ID_FLOAT.

According to the spec. we should read the USB-ID pin ADC value
to determine the resistance of the used pull-down resister and
then return RID_A / RID_B / RID_C based on this. But all "Accessory
Charger Adapter"s (ACAs) which users can actually buy always use
a combination of a charging port with one or more USB-A ports, so
they should always use a resistor indicating RID_A. But the spec
is hard to read / badly-worded so some of them actually indicate
they are a RID_B ACA evnen though they clearly are a RID_A ACA.

To workaround this simply always return INTEL_USB_RID_A, which
matches all the ACAs which users can actually buy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 1030610a3494..c92bc98cb428 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -121,13 +121,21 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
 		return INTEL_USB_ID_GND;
 	case CHT_WC_PWRSRC_RID_FLOAT:
 		return INTEL_USB_ID_FLOAT;
+	/*
+	 * According to the spec. we should read the USB-ID pin ADC value here
+	 * to determine the resistance of the used pull-down resister and then
+	 * return RID_A / RID_B / RID_C based on this. But all "Accessory
+	 * Charger Adapter"s (ACAs) which users can actually buy always use
+	 * a combination of a charging port with one or more USB-A ports, so
+	 * they should always use a resistor indicating RID_A. But the spec
+	 * is hard to read / badly-worded so some of them actually indicate
+	 * they are a RID_B ACA evnen though they clearly are a RID_A ACA.
+	 * To workaround this simply always return INTEL_USB_RID_A, which
+	 * matches all the ACAs which users can actually buy.
+	 */
 	case CHT_WC_PWRSRC_RID_ACA:
+		return INTEL_USB_RID_A;
 	default:
-		/*
-		 * Once we have IIO support for the GPADC we should read
-		 * the USBID GPADC channel here and determine ACA role
-		 * based on that.
-		 */
 		return INTEL_USB_ID_FLOAT;
 	}
 }
-- 
2.31.1

