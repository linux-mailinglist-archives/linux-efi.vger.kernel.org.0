Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3E4A5D38
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiBANJp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238523AbiBANJB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0k8qmopVRDS/Fv3iqd9Jcw5dP0WQfGSVwqFKczDcaqk=;
        b=Xbvcpgrfq3z26eQ8S9L/Db44SRDYLxJAzoMEFOk1nT3c38xu9ZjaD2D104sPLg55csGZAM
        c7BqrcDRer18mhJyPp6fRjg6TwB+FxZwoeeXsRggGmp17T6a4ssXLoJUbJ/VFdIuzfcgE7
        Alc4jAQ8u0ZLJqK15cIhv5N2J+u7s34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-1BtNRsGmMqG8mJwKJwvbGQ-1; Tue, 01 Feb 2022 08:08:55 -0500
X-MC-Unique: 1BtNRsGmMqG8mJwKJwvbGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 280B31B2C984;
        Tue,  1 Feb 2022 13:08:53 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B80DB795B1;
        Tue,  1 Feb 2022 13:08:49 +0000 (UTC)
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
Subject: [PATCH v5 20/20] extcon: intel-cht-wc: Report RID_A for ACA adapters
Date:   Tue,  1 Feb 2022 14:07:06 +0100
Message-Id: <20220201130706.46685-21-hdegoede@redhat.com>
In-Reply-To: <20220201130706.46685-1-hdegoede@redhat.com>
References: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
they are a RID_B ACA even though they clearly are a RID_A ACA.

To workaround this simply always return INTEL_USB_RID_A, which
matches all the ACAs which users can actually buy.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index cf74acb92fe3..89a6449e3f4a 100644
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
2.33.1

