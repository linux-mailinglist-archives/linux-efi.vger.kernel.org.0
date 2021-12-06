Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15F14692CA
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhLFJjT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241349AbhLFJjE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJ60w9l5x9z7ezkDeL8gMwQfAMNkzdnrdHE2RsyKQDs=;
        b=E9v+HzkfYAQrOroHo4geNmshbByKZj4BbChoLtLYhz0zstqJU7DdjarofCZbFfju7zVrbb
        40SrLzMjW3kesv6+50wfQ/3UAUfs916qfSj2Keu1xeLZzvupZA9d785m/fJ27+doP1bhEz
        Sw5u7m8dJcObhg9ANYcRTTFwGFd9ga4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-wAupVm9qOCuQ-sKq7nCHaA-1; Mon, 06 Dec 2021 04:35:34 -0500
X-MC-Unique: wAupVm9qOCuQ-sKq7nCHaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E585835B47;
        Mon,  6 Dec 2021 09:35:31 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 184D75DAA5;
        Mon,  6 Dec 2021 09:35:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 20/20] extcon: intel-cht-wc: Report RID_A for ACA adapters
Date:   Mon,  6 Dec 2021 10:33:18 +0100
Message-Id: <20211206093318.45214-21-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 144cb5d8cd47..2a8d41cbf41c 100644
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

