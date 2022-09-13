Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D805B7839
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiIMRj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiIMRjd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF937D1E9;
        Tue, 13 Sep 2022 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086714; x=1694622714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0m7qErf7VtY8xsWlWb+ddH+SXJeXMzL+LVnonABMCEw=;
  b=gy4kgmHuKHjbqQVv4qThKgpUVqnqTZoBMck8XXJFVCcqwAcn4j11taiz
   UDGMdutjSh9NoC2GhgBcS6AhBZBpggPSMW3GFZ8gLuJ6Pm1BJB1znvQUJ
   K1cfLzTXz8G2kpDTi99M5qet9gojxX9Rwd/2G68abNo9NUQg19JcYOkkd
   pqWd/sDldbOqOKXq1cD+K/DQZjIH0hSnY0Swl31KRh+0J54POmRaJFP7B
   cLNOHvB+xg+1sgrWtyjnZ8PUYf7rhjDOULCGIDKzxfIKbXCO/lUZe/8Lu
   bO4ZUZlvQafVrslhinannS1cTkA5Kfc9V3LFkPXd/hFRQGHJhzWp9+VYm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285207775"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="285207775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="742221535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2022 09:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F1B145C; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
Subject: [PATCH v3 4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:43 +0300
Message-Id: <20220913163147.24258-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
References: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
an integer. Use it instead of custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Wolfram Sang <wsa@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-amd-mp2-plat.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index 84b7e6cbc67b..423fe0c8a471 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -244,14 +244,18 @@ static const struct i2c_adapter_quirks amd_i2c_dev_quirks = {
 
 static int i2c_amd_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct amd_i2c_dev *i2c_dev;
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct amd_mp2_dev *mp2_dev;
-	const char *uid;
+	u64 uid;
 
-	if (!adev)
-		return -ENODEV;
+	ret = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+	if (ret)
+		return dev_err_probe(dev, ret, "missing UID/bus id!\n");
+	if (uid >= 2)
+		return dev_err_probe(dev, -EINVAL, "incorrect UID/bus id \"%llu\"!\n", uid);
+	dev_dbg(dev, "bus id is %llu\n", uid);
 
 	/* The ACPI namespace doesn't contain information about which MP2 PCI
 	 * device an AMDI0011 ACPI device is related to, so assume that there's
@@ -266,6 +270,7 @@ static int i2c_amd_probe(struct platform_device *pdev)
 	if (!i2c_dev)
 		return -ENOMEM;
 
+	i2c_dev->common.bus_id = uid;
 	i2c_dev->common.mp2_dev = mp2_dev;
 	i2c_dev->pdev = pdev;
 	platform_set_drvdata(pdev, i2c_dev);
@@ -276,20 +281,6 @@ static int i2c_amd_probe(struct platform_device *pdev)
 	i2c_dev->common.resume = &i2c_amd_resume;
 #endif
 
-	uid = adev->pnp.unique_id;
-	if (!uid) {
-		dev_err(&pdev->dev, "missing UID/bus id!\n");
-		return -EINVAL;
-	} else if (strcmp(uid, "0") == 0) {
-		i2c_dev->common.bus_id = 0;
-	} else if (strcmp(uid, "1") == 0) {
-		i2c_dev->common.bus_id = 1;
-	} else {
-		dev_err(&pdev->dev, "incorrect UID/bus id \"%s\"!\n", uid);
-		return -EINVAL;
-	}
-	dev_dbg(&pdev->dev, "bus id is %u\n", i2c_dev->common.bus_id);
-
 	/* Register the adapter */
 	amd_mp2_pm_runtime_get(mp2_dev);
 
-- 
2.35.1

