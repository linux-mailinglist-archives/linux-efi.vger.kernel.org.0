Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693C15B0A94
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiIGQq7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIGQqp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:46:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E6BBA4F;
        Wed,  7 Sep 2022 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569202; x=1694105202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8qb/UTEEil6615JKf6e9+EljojGbq/vMMOf6vhsxNk=;
  b=N2UxokThIGGWJhrB+OLWvXus5Ms1U3EApEvOqBuz0MoQT4zAa7eWIWXL
   Cub0PqHJyT502/FaB49C+jOqCz2SJrW42mmbhFUYj1UWafp7fSWVl5Yc9
   2o7MD2ALwGlojqUB8iKD0/bKq9tgzMA5VGk2+Q9qPEmlZahE6L6ljvGvy
   DfNco35zzthgWEWZbmiMv9iw+ubrdre3OhmoRrqD3icO+mKp2reUydNkk
   5YdemHWj4dUeLOlQfkg71rlJH0Qt1R/hlOe2Oj8F6hyDYQwqi0DicYC4x
   xCfh70NG+eFUMk/ebo6k/mjw33G3Lgj151dQSQ/xCa33Ovk5yDMOqbmvm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295667998"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295667998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="565591846"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 09:46:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11A29235; Wed,  7 Sep 2022 19:46:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v1 5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:03 +0300
Message-Id: <20220907164606.65742-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
an integer. Use it instead of custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 8716032f030a..4fd4b3799596 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2230,34 +2230,27 @@ static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
 	const struct acpi_device_id *aid;
 	struct acpi_device *adev;
-	unsigned long bus_id = 0;
-	const char *uid;
+	u64 bus_id;
 	int ret;
 
 	if (acpi_disabled)
 		return -ENOENT;
 
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENXIO;
-
 	aid = acpi_match_device(mlxbf_i2c_acpi_ids, dev);
 	if (!aid)
 		return -ENODEV;
 
 	priv->chip = (struct mlxbf_i2c_chip_info *)aid->driver_data;
 
-	uid = acpi_device_uid(adev);
-	if (!uid || !(*uid)) {
+	ret = acpi_dev_uid_to_integer(adev, &bus_id);
+	if (ret) {
 		dev_err(dev, "Cannot retrieve UID\n");
-		return -ENODEV;
+		return ret;
 	}
 
-	ret = kstrtoul(uid, 0, &bus_id);
-	if (!ret)
-		priv->bus = bus_id;
+	priv->bus = bus_id;
 
-	return ret;
+	return 0;
 }
 #else
 static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
-- 
2.35.1

