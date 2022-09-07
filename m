Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D95B0AC2
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIGQ4d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIGQ4W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:56:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69DB7289;
        Wed,  7 Sep 2022 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569773; x=1694105773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vWuqTMwBi1O+c6apP2Lqjqedt+arQ1UJd2QI0oH89zo=;
  b=JgxM1Vs/sMejEvf6oBeTygHpfUklvWNUZooZW4znkDosMYs+wKXL4OZq
   wV8iFZ9NaLO5wf/PbOZmbe9FcbP5SXimoeY0ERup5dgy7QWdyVdSaX+p1
   Vivj5d3OnepS+cWdcZyXxYkMpqmshD/trdnEfp+8SXe/4MJ4hl065t+Sk
   wQIZPTuezbgBM2aXi18eoH4zvQaHKdJoS2x6+6gUXK4IU8dEE5MFcxm7M
   upZQPmhu1Wk8CsFjXS0ysoQlC8QqSG3ZCCoEiIIGc+wB5uLaKcr9T/63X
   pRMzgi06sy9TGxJ+B6BOsD8z0204tIRqCwSxQ67VxieghvSqZJg7VG1rg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298271992"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="298271992"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="703675635"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 09:45:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9FE0363; Wed,  7 Sep 2022 19:46:11 +0300 (EEST)
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
Subject: [PATCH v1 3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:01 +0300
Message-Id: <20220907164606.65742-4-andriy.shevchenko@linux.intel.com>
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

