Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00B3440B18
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJ3SbR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232008AbhJ3SbK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+AVB+iQtmAvSP/G/6vABVHFG7BeK3k8Ncl4QBHM/dc=;
        b=TK7CJPWmr3w11bhnsugePJ2vFfLPMrkJH6Zl1wxpmrZ9efbSAo+sqj3Bceo718L55PT5ni
        tZsAdpZwKDbXy0SZJTV2CeNTkde0EVlOzKBQ5EDcedF2ybkWdr2LWaVFbxwSx4HB0Y7m31
        ZJh4L1Q3mglBlXuKAX4x90G0Wphb/i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-OGzIgCvkO62ic-hRyno7HQ-1; Sat, 30 Oct 2021 14:28:38 -0400
X-MC-Unique: OGzIgCvkO62ic-hRyno7HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED1B1808317;
        Sat, 30 Oct 2021 18:28:36 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5736B5F4E1;
        Sat, 30 Oct 2021 18:28:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 06/13] power: supply: bq25890: Add support for skipping initialization
Date:   Sat, 30 Oct 2021 20:28:06 +0200
Message-Id: <20211030182813.116672-7-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On most X86/ACPI devices there is no devicetree to supply the necessary
init-data. Instead the firmware already fully initializes the bq25890
charger at boot.

At support for a new "ti,skip-init" boolean property to support this.
So far this new property is only used on X86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 1ec93a565631..280821a6a6c6 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -73,6 +73,7 @@ enum bq25890_fields {
 
 /* initial field values, converted to register values */
 struct bq25890_init_data {
+	u8 write_cfg;	/* write firmware cfg to chip?	*/
 	u8 ichg;	/* charge current		*/
 	u8 vreg;	/* regulation voltage		*/
 	u8 iterm;	/* termination current		*/
@@ -638,7 +639,7 @@ static int bq25890_chip_reset(struct bq25890_device *bq)
 
 static int bq25890_rw_init_data(struct bq25890_device *bq)
 {
-	bool write = true;
+	bool write = bq->init_data.write_cfg;
 	int ret;
 	int i;
 
@@ -682,10 +683,12 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 {
 	int ret;
 
-	ret = bq25890_chip_reset(bq);
-	if (ret < 0) {
-		dev_dbg(bq->dev, "Reset failed %d\n", ret);
-		return ret;
+	if (bq->init_data.write_cfg) {
+		ret = bq25890_chip_reset(bq);
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Reset failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* disable watchdog */
@@ -920,6 +923,10 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	int ret;
 	struct bq25890_init_data *init = &bq->init_data;
 
+	init->write_cfg = !device_property_read_bool(bq->dev, "ti,skip-init");
+	if (!init->write_cfg)
+		return 0;
+
 	ret = bq25890_fw_read_u32_props(bq);
 	if (ret < 0)
 		return ret;
@@ -1033,8 +1040,10 @@ static int bq25890_remove(struct i2c_client *client)
 	if (!IS_ERR_OR_NULL(bq->usb_phy))
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
 
-	/* reset all registers to default values */
-	bq25890_chip_reset(bq);
+	if (bq->init_data.write_cfg) {
+		/* reset all registers to default values */
+		bq25890_chip_reset(bq);
+	}
 
 	return 0;
 }
-- 
2.31.1

