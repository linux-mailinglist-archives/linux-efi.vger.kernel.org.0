Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180184A3910
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356171AbiA3UqS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 15:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356168AbiA3UqR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 15:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jz1fNkwNL3m8bCXWTNGgBE6ANjGGJ2t0kezR8UmnVuk=;
        b=aYy+BZE3lamkIKZ3v0Qy6TZz52hUtSNA1qN4txzP7jJzOnzzeXzb/asXx7G5tp0U8b4+37
        pyUFgtKGpj7PQPYPPjh/25YESNLNnjCYwo5gkWcLaiF9Y4G8jEvFuhhUHYFPVWmstUyBjw
        BzGxsFnbuyvScnkBYKHBsMU2Ehqc3OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-PHNFiIKUPPSLug2BVslikQ-1; Sun, 30 Jan 2022 15:46:13 -0500
X-MC-Unique: PHNFiIKUPPSLug2BVslikQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081C91006AA0;
        Sun, 30 Jan 2022 20:46:11 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90FFC61093;
        Sun, 30 Jan 2022 20:46:07 +0000 (UTC)
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
Subject: [PATCH v4 02/20] power: supply: bq25890: Rename IILIM field to IINLIM
Date:   Sun, 30 Jan 2022 21:45:39 +0100
Message-Id: <20220130204557.15662-3-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index e62da9dc4f35..fb987579d05a 100644
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
@@ -322,7 +322,7 @@ static const union {
 	/* TODO: BQ25896 has max ICHG 3008 mA */
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
-	[TBL_IILIM] =   { .rt = {100000,  3250000, 50000} },	 /* uA */
+	[TBL_IINLIM] =  { .rt = {100000,  3250000, 50000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
@@ -528,11 +528,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
2.33.1

