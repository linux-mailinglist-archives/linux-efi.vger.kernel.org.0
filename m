Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084445B0AC5
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIGQ4l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIGQ4b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:56:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28439B9F9B;
        Wed,  7 Sep 2022 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569782; x=1694105782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVYgnFuqeArS+VSqk9IjZd0qcqmew4m2Zul+wVsLztM=;
  b=J1m7zL/O45mwQjDCwc/l3OvMc/wLGAwlKmr8yoENFVKDyickmYXQFsN4
   RulrnW2hPXkym7Ws8nKRMyhBi/6yl4WzVHf6d8tOJEf6TutQ17o+btw5M
   ixuCNnJTItQlIQ8bqYh6TVVp2D5c0eDn00tzSFMfIOL41r5n9enUARGnt
   Fwe6jejCmyJdxa97wP8BRLjFR01ZFOAOPk6xuT/V6GiSI3HVnvAAQiCx+
   bGR+NU1Wq+mMD1Amue1WbNw8IhMQh41nDi+/c2f/IkLK4DnhgUFzJ77Gi
   isonKWUOgqQUTV0avWywRtilhkA0zNwHc15IwGKLDZwZgPhHjDBH5yOeT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298272029"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="298272029"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="718212972"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2022 09:46:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 27B0D57F; Wed,  7 Sep 2022 19:46:12 +0300 (EEST)
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
Subject: [PATCH v1 6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:04 +0300
Message-Id: <20220907164606.65742-7-andriy.shevchenko@linux.intel.com>
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
 drivers/perf/qcom_l2_pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 30234c261b05..aa68e230e020 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -843,13 +843,14 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct l2cache_pmu *l2cache_pmu = data;
 	struct cluster_pmu *cluster;
-	unsigned long fw_cluster_id;
+	u64 fw_cluster_id;
 	int err;
 	int irq;
 
-	if (!adev || kstrtoul(adev->pnp.unique_id, 10, &fw_cluster_id) < 0) {
+	err = acpi_dev_uid_to_integer(adev, &fw_cluster_id);
+	if (err) {
 		dev_err(&pdev->dev, "unable to read ACPI uid\n");
-		return -ENODEV;
+		return err;
 	}
 
 	cluster = devm_kzalloc(&pdev->dev, sizeof(*cluster), GFP_KERNEL);
-- 
2.35.1

