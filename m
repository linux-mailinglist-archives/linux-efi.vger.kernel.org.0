Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C965B1F28
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiIHN3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiIHN3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E03F5F7D4;
        Thu,  8 Sep 2022 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643750; x=1694179750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J12ArvUpT0DBpVB2Z6wl3Lorr8ZN6snQKzGYUIXMmcc=;
  b=mcgX0P0BTyvUbicb5yvjHjAlztF53LSERNF+CXvo939pYIhEVwQwXLqy
   5JciiSBQltn3XNZWhatBrDizsVCGNG6yajWg1h/vCdr7B6+MkMSp/ZPDM
   Y5CBxQFvGB4JtcjuHY+VUPBo5cHP9tuMjrBXGboccR6JIT3wJdDvQjLj0
   BQ97IQRFyAu6ZoA+2QqpzoHzmJgCdCLJJgXHZWDX+Ju1ooh4hErEcs4ZE
   Gu5d+i2pKHi8aOz/Lw+TImo+l8N0BkWE6OsR/1a7pSetuo8ht7Jj8sDwD
   G1X3cjJeTGn9vRzfeylTUS/zDvONiYfvddHAuMEGELJCMFFpPWOUNzYOV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280196188"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280196188"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704006402"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 06:29:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 055595E4; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
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
Subject: [PATCH v2 6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:08 +0300
Message-Id: <20220908132910.62122-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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
 drivers/perf/qcom_l2_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 30234c261b05..ad4a41e1287f 100644
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
-- 
2.35.1

