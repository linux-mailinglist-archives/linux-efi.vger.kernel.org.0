Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A744F966
	for <lists+linux-efi@lfdr.de>; Sun, 14 Nov 2021 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhKNRHy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Nov 2021 12:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236185AbhKNRGy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Nov 2021 12:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OsrSqIS8dRf7JRKcuWamIO8LFYSgkzTf71ZkiaHlxY=;
        b=SzdhCdyhBji0yK4ePBw6WiHMDorWkeO17Tcp1lgh65ph4hS1JzNnPb2woTtjAr3hmBWJP+
        BEevAbFOEn6o6AIZVJiU7FFmNSW62nv5yEmoygbGIb4eXALhciTcVzktX849UrRWJebcVO
        gRlhyA2/AqkmrG/EVcrraMRUBtd02mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-1pxDy5bLNS6uSzOaqv-_Aw-1; Sun, 14 Nov 2021 12:03:54 -0500
X-MC-Unique: 1pxDy5bLNS6uSzOaqv-_Aw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F1D802B7A;
        Sun, 14 Nov 2021 17:03:51 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1A61346F;
        Sun, 14 Nov 2021 17:03:48 +0000 (UTC)
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
Subject: [PATCH v2 03/20] power: supply: bq25890: Rename IILIM field to IINLIM
Date:   Sun, 14 Nov 2021 18:03:18 +0100
Message-Id: <20211114170335.66994-4-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Rename the Input Current Limit field in the REG00 from IILIM to IINLIM
accordingly with the bq2589x datasheet. This is just cosmetical change
to reduce confusion.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index b7eac5428083..b208cc2193b8 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -40,7 +40,7 @@ static const char *const bq25890_chip_name[] = {
 };
 
 enum bq25890_fields {
-	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
+	F_EN_HIZ, F_EN_ILIM, F_IINLIM,				     /* Reg00 */
 	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
 	F_CONV_START, F_CONV_RATE, F_BOOSTF, F_ICO_EN,
 	F_HVDCP_EN, F_MAXC_EN, F_FORCE_DPM, F_AUTO_DPDM_EN,	     /* Reg02 */
@@ -153,7 +153,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	/* REG00 */
 	[F_EN_HIZ]		= REG_FIELD(0x00, 7, 7),
 	[F_EN_ILIM]		= REG_FIELD(0x00, 6, 6),
-	[F_IILIM]		= REG_FIELD(0x00, 0, 5),
+	[F_IINLIM]		= REG_FIELD(0x00, 0, 5),
 	/* REG01 */
 	[F_BHOT]		= REG_FIELD(0x01, 6, 7),
 	[F_BCOLD]		= REG_FIELD(0x01, 5, 5),
@@ -256,7 +256,7 @@ enum bq25890_table_ids {
 	/* range tables */
 	TBL_ICHG,
 	TBL_ITERM,
-	TBL_IILIM,
+	TBL_IINLIM,
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
@@ -299,7 +299,7 @@ static const union {
 	/* TODO: BQ25896 has max ICHG 3008 mA */
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
-	[TBL_IILIM] =   { .rt = {100000,  3250000, 50000} },	 /* uA */
+	[TBL_IINLIM] =  { .rt = {100000,  3250000, 50000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
@@ -503,11 +503,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = bq25890_field_read(bq, F_IILIM);
+		ret = bq25890_field_read(bq, F_IINLIM);
 		if (ret < 0)
 			return ret;
 
-		val->intval = bq25890_find_val(ret, TBL_IILIM);
+		val->intval = bq25890_find_val(ret, TBL_IINLIM);
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-- 
2.31.1

