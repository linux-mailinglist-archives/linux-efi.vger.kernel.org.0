Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B75B784B
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiIMRkp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiIMRjt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98147D1F9;
        Tue, 13 Sep 2022 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086777; x=1694622777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzmE1/IO0VatkJS0QWAbb13XUkBx68v4n4aNQ7ngE20=;
  b=AdscNvfP0hVRPg1xTSCyPGA7BqPCzHAXHRGqmS2kFBJkP3f7Elhf/SVD
   K9Nq62kwbdPmYXpXS7nNFTJrCRdv/mTWUVWva2GJRzW5dWGoz/Pk70Tl4
   mL0LT9MxzsOYzZ5LFiD8tHikd1TVEXA7nb044UPFxlwOXBO96N9Mw5clp
   zjlGv8bSu7xFN/FUnGLZ7lQM8C/v7Iv3lf5yVeVblz539l9Ysbd6V4/Hy
   yMhT2uxkt776oJhQ6lP/z2Z5sSC9mpQLYJytWfsVBOmbvYWbOiGCuvE2N
   0rTWJQNhGTUWEWQnQwfFwECWSOaJz5hD0pvyBStzJsegyOZ7tPUNLDnvH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="324433032"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="324433032"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="861610561"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2022 09:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 798A757F; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
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
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v3 6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:45 +0300
Message-Id: <20220913163147.24258-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
References: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/perf/qcom_l2_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 30234c261b05..aaca6db7d8f6 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -840,16 +840,16 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct platform_device *sdev = to_platform_device(dev);
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct l2cache_pmu *l2cache_pmu = data;
 	struct cluster_pmu *cluster;
-	unsigned long fw_cluster_id;
+	u64 fw_cluster_id;
 	int err;
 	int irq;
 
-	if (!adev || kstrtoul(adev->pnp.unique_id, 10, &fw_cluster_id) < 0) {
+	err = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &fw_cluster_id);
+	if (err) {
 		dev_err(&pdev->dev, "unable to read ACPI uid\n");
-		return -ENODEV;
+		return err;
 	}
 
 	cluster = devm_kzalloc(&pdev->dev, sizeof(*cluster), GFP_KERNEL);
@@ -879,7 +879,7 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 	}
 
 	dev_info(&pdev->dev,
-		"Registered L2 cache PMU cluster %ld\n", fw_cluster_id);
+		 "Registered L2 cache PMU cluster %lld\n", fw_cluster_id);
 
 	spin_lock_init(&cluster->pmu_lock);
 
-- 
2.35.1

