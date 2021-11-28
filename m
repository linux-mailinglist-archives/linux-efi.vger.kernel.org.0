Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DF460896
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358850AbhK1SX4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 13:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358901AbhK1SVw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hdYprHAUKH6/UGtDCwRWZnaQcilvfgfZw6rW+7VTMs=;
        b=PwF9mjtPSslim1nTl2ZBrGCAoQV+tCrp+BN9qEWJkCkw3tn8RE9z79lY06EbNhCeynXO1X
        PcAll4DkafI3wMSApdtlKYxRsTA00VBv+lUDSQQoQDtPGStaOC+t7M2zWURFp6xj1ySWrO
        aVg59eGC8TEHxJa4W4TNL3pysTYaiOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-sXIx980-OFeAugytI7tC0A-1; Sun, 28 Nov 2021 13:18:33 -0500
X-MC-Unique: sXIx980-OFeAugytI7tC0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48E8801B01;
        Sun, 28 Nov 2021 18:18:30 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 828CB10016F4;
        Sun, 28 Nov 2021 18:18:27 +0000 (UTC)
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
Subject: [PATCH v3 04/20] power: supply: bq25890: Add a bq25890_rw_init_data() helper
Date:   Sun, 28 Nov 2021 19:17:53 +0100
Message-Id: <20211128181809.326736-5-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On most x86/ACPI devices there is no devicetree to supply the necessary
init-data. Instead the firmware already fully initializes the bq25890
charger at boot.

Factor out the current code to write all the init_data from devicetree
into a new bq25890_rw_init_data() helper which can both write the data
to the charger (the current behavior) as well as read it back from
the charger into the init_data struct.

This is a preparation patch for adding support for x86/ACPI device's
where the init_data must be read back from the bq25890 charger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 62 +++++++++++++++++---------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 0ab797c681fd..46a0d745067e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -659,29 +659,52 @@ static int bq25890_chip_reset(struct bq25890_device *bq)
 	return 0;
 }
 
-static int bq25890_hw_init(struct bq25890_device *bq)
+static int bq25890_rw_init_data(struct bq25890_device *bq)
 {
+	bool write = true;
 	int ret;
 	int i;
 
 	const struct {
 		enum bq25890_fields id;
-		u32 value;
+		u8 *value;
 	} init_data[] = {
-		{F_ICHG,	 bq->init_data.ichg},
-		{F_VREG,	 bq->init_data.vreg},
-		{F_ITERM,	 bq->init_data.iterm},
-		{F_IPRECHG,	 bq->init_data.iprechg},
-		{F_SYSVMIN,	 bq->init_data.sysvmin},
-		{F_BOOSTV,	 bq->init_data.boostv},
-		{F_BOOSTI,	 bq->init_data.boosti},
-		{F_BOOSTF,	 bq->init_data.boostf},
-		{F_EN_ILIM,	 bq->init_data.ilim_en},
-		{F_TREG,	 bq->init_data.treg},
-		{F_BATCMP,	 bq->init_data.rbatcomp},
-		{F_VCLAMP,	 bq->init_data.vclamp},
+		{F_ICHG,	 &bq->init_data.ichg},
+		{F_VREG,	 &bq->init_data.vreg},
+		{F_ITERM,	 &bq->init_data.iterm},
+		{F_IPRECHG,	 &bq->init_data.iprechg},
+		{F_SYSVMIN,	 &bq->init_data.sysvmin},
+		{F_BOOSTV,	 &bq->init_data.boostv},
+		{F_BOOSTI,	 &bq->init_data.boosti},
+		{F_BOOSTF,	 &bq->init_data.boostf},
+		{F_EN_ILIM,	 &bq->init_data.ilim_en},
+		{F_TREG,	 &bq->init_data.treg},
+		{F_BATCMP,	 &bq->init_data.rbatcomp},
+		{F_VCLAMP,	 &bq->init_data.vclamp},
 	};
 
+	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
+		if (write) {
+			ret = bq25890_field_write(bq, init_data[i].id,
+						  *init_data[i].value);
+		} else {
+			ret = bq25890_field_read(bq, init_data[i].id);
+			if (ret >= 0)
+				*init_data[i].value = ret;
+		}
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Accessing init data failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int bq25890_hw_init(struct bq25890_device *bq)
+{
+	int ret;
+
 	ret = bq25890_chip_reset(bq);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Reset failed %d\n", ret);
@@ -696,14 +719,9 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 	}
 
 	/* initialize currents/voltages and other parameters */
-	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
-		ret = bq25890_field_write(bq, init_data[i].id,
-					  init_data[i].value);
-		if (ret < 0) {
-			dev_dbg(bq->dev, "Writing init data failed %d\n", ret);
-			return ret;
-		}
-	}
+	ret = bq25890_rw_init_data(bq);
+	if (ret)
+		return ret;
 
 	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0) {
-- 
2.33.1

