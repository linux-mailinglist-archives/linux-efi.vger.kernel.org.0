Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7C5B7858
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiIMRkc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiIMRjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBF7CAAC;
        Tue, 13 Sep 2022 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086775; x=1694622775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Li1WN8sCVHEAq82ItBnE/csBRZWXw+X9ZOrYZ4j6bLY=;
  b=H6Npwu+med9T8WQFfoUfFHGlR23/O51b3Cw1mFpLHPyl2VWv/TaoUcxH
   +q9vCE8QqqDoJJIg7b6roSJzFYw4aiewo0dqj8QmW0KARlbXvQjlU1WLq
   fJ2R5LmOWC++Mqup4UvUtohx6LyvwVTIJBmLjd7P6HgFjevkoZVMRBDMa
   Au6ZPS0OLSQR4TJ5KgKtU0ZwnRgyFb6bA5hxFtVpeDwzNTf0FYZJiLFbV
   Cmky9DAQVFDT+kzfiofamtbKN99Gt+rW+VnZ7aSy/GpO6ahQLmdDoancU
   jmBlQCDBZCdeIOKdfBLiD1QjCoGGdVm+uOdGSuLzN0czmjiATOeG2d8Oi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="324432995"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="324432995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="758857587"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2022 09:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 522A7363; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
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
Subject: [PATCH v3 3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:42 +0300
Message-Id: <20220913163147.24258-4-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/x86/utils.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 664070fc8349..2764b4778ce7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -351,11 +351,17 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
 	long quirks = 0;
+	u64 uid;
+	int ret;
 
 	*skip = false;
 
-	/* !dev_is_platform() to not match on PNP enumerated debug UARTs */
-	if (!adev || !adev->pnp.unique_id || !dev_is_platform(controller_parent))
+	ret = acpi_dev_uid_to_integer(adev, &uid);
+	if (ret)
+		return 0;
+
+	/* to not match on PNP enumerated debug UARTs */
+	if (!dev_is_platform(controller_parent))
 		return 0;
 
 	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
@@ -363,10 +369,10 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 		quirks = (unsigned long)dmi_id->driver_data;
 
 	if (quirks & ACPI_QUIRK_UART1_TTY_UART2_SKIP) {
-		if (!strcmp(adev->pnp.unique_id, "1"))
+		if (uid == 1)
 			return -ENODEV; /* Create tty cdev instead of serdev */
 
-		if (!strcmp(adev->pnp.unique_id, "2"))
+		if (uid == 2)
 			*skip = true;
 	}
 
-- 
2.35.1

