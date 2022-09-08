Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601C05B1F00
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiIHN3d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiIHN3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5AED3B4;
        Thu,  8 Sep 2022 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643745; x=1694179745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=adHNCOHaDWaBW06VxfUdXxmZS2GrV/y8MfNhTXjAr2s=;
  b=nMcyp4gvCSnD6OW9SAdeRA/coxnY/HzE80qsHvWJ+y3V/XCrEW3WpzBy
   R2Pxb/4ujhDPO7lbPCftmPxdqmKVqczhNTzs2nja1C6A2RpiD8hcmTAp4
   qYkUj1VJxU7LYliA/UeFszB2nTzf2HUsvU0iEKub6DBgDf6MT8tlBK5vs
   Ddqm02tyujV/mAPAtLHoKw2uC833MTloVOByEbswv8iQHuW0dgL9q6OJ2
   AnRHTK6u9iYhsebJLx1SJEtFGCH39BwurLqj0hnqewcU475jD20YVnSe6
   keD4Fw0LQT/6hrO9HYVDhAfUYkWnFgLANkR9qaXE3SRwljwh+AzJvQSt+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="276901058"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276901058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="610693597"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Sep 2022 06:28:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DFCE450D; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
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
Subject: [PATCH v2 4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:06 +0300
Message-Id: <20220908132910.62122-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

