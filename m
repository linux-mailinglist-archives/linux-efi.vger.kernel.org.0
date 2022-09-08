Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C65B1F1A
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiIHN3o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiIHN3L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B71AB1AD;
        Thu,  8 Sep 2022 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643750; x=1694179750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WrWxiQuiUTX6EaggRQCN+4NAW99qANSsfg8ToIRMN0=;
  b=YeUtuIdP2n6L3Nx23qKLD4utLjzUUcwBq/I9ralgBuoqgFh+CH/hiJLu
   CxwQxw+9QZ17XrgkOXVIuFSIqmbVvIuvlUhx6gY6wsmHKpqr/IfX/KrsX
   5VwSv66RrPStgEy/dnqIoQdXxQRO8lXi0KTRPhryMDNTDpj+3wjSrKwzH
   PKrHhAmV7qkIb5bixLzPiahHAIeQ6lJR0KEa3QeF7D7Z4cFp9ChIfajwX
   cUsu4TEzzndCSv7zRmJIbIZhMFm1QW+IerQU1hdPwvcmEFmwKTc2MJpln
   xvY8AB+fiwwlUmUvQPVvvPjbsQwE0JhnAPz0Hdim8Eal6yoE9y7vTZ7xY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297166486"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297166486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943343367"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 06:29:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EACED57F; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:07 +0300
Message-Id: <20220908132910.62122-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 8716032f030a..32235c62f3d2 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2229,35 +2229,27 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_i2c_acpi_ids);
 static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
 	const struct acpi_device_id *aid;
-	struct acpi_device *adev;
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
+	ret = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &bus_id);
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

