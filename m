Return-Path: <linux-efi+bounces-89-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB217F5BEC
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 11:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE45C1C20DA5
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33B224D7;
	Thu, 23 Nov 2023 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kq0gVa/R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181510DF;
	Thu, 23 Nov 2023 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734047; x=1732270047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UiSJDgehd3ZmZrMiVJSfKgyDPoJmiX2ZPNSPqcXf4ys=;
  b=Kq0gVa/Rbbqvwi9qHmf/ChbmHC0mx/iVDs8WcAdrWOJEA6tPpYCAQ6Xn
   zwDOH11XAY0h4CcxTsLdjNJQYNgu78j+cLGshjp5f0BIgfJrLphmlzn7V
   VCsQIKH2jR8NzTFq+K0b2ibIuiYWKwaSKPFCPwxR+uTC+Irr5rul0DAo/
   dIoksejh0QIKcCiXpu7ofvISthm15FBosLlJGHlj62hZlKJ/U5dHaHIfZ
   satVtOsvq5ipRh2xq3U+8G9qpc6nxnukCJytrfDlKzfV0kXRnx5SGmtyv
   847sdFklD1NGXV1OXOHlrq3a4mbBf/VEaSME6/B5ylKyF3/m3AIZGD1az
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576415"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576415"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160492"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160492"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:16 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 3/5] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date: Thu, 23 Nov 2023 15:36:15 +0530
Message-Id: <20231123100617.28020-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..79f4fc7d6871 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,13 +167,9 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
-		return;
-
-	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
+	if (acpi_dev_uid_match(pdata->adev, 1))
+		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
 }
 
 #define LPSS_I2C_ENABLE			0x6c
@@ -218,13 +214,9 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
-		return;
-
-	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
+	if (acpi_dev_uid_match(pdata->adev, 1))
+		pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
 }
 
 static const struct property_entry lpt_spi_properties[] = {
-- 
2.17.1


