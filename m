Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C75B0A8D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIGQqt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiIGQqn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:46:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697980F6A;
        Wed,  7 Sep 2022 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569199; x=1694105199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IreFFSbzDFZGfkcBSxeZQScWewSs28Fo3w9m3W8uX74=;
  b=FEkvAg9J6us49GwYghpJNCfjtVCLQayZ5aUB0B6VphGPMUcf7xwWboM/
   pTK6wzwca3u/bmkafo8U4QStvSGen08W92LE6Gab8690RVCPSZtc//WsT
   d2ohiMh/M/hlhlNJ/MhMjZ/drMnmhNaBuJ24zny5ZX6LGyRb0t4UhwlTK
   nLDEBeCucTz8HB1U0hDTNoca5p4f/0cHl7pQS3uI7FrHqPifjefUu6Stw
   kXxaam/F2D+Ot0TJ5jVhWT5bsu5x7odKgWg1gEUYkZ4Zn+h3jlGYoYrVI
   7J98H2LDxdDI5aGfyO4qj7kvh/XmSdIOm2TRvPj5CC3pwmS1Oxm/pI6So
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="296932669"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="296932669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="591788324"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 09:45:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01F1945C; Wed,  7 Sep 2022 19:46:11 +0300 (EEST)
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
Subject: [PATCH v1 4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:02 +0300
Message-Id: <20220907164606.65742-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
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

