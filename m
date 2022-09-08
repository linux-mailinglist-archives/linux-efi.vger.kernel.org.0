Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A95B1F05
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiIHN3e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiIHN3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C1612952A;
        Thu,  8 Sep 2022 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643746; x=1694179746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Li1WN8sCVHEAq82ItBnE/csBRZWXw+X9ZOrYZ4j6bLY=;
  b=OoI+mnDxmbueyjkh6gzf+mbbatMV4VItgzJKg7K8fLxlw2uo1pHGkUhw
   sR+nezm41/6y/V6AC3RgsHA8dkfyZkUi3fClAc09NNBK1uTg6ucNlz9sE
   uj9SxDM1FznYnPvzmTBd8sq1NqsmZLNPLs04KGPf6RTKjDMg04IBNVODx
   nKqJdNNj1GE37ZESi+tWuqRU/SU5iHTFVg2LHDldWRDocYqGG1gnVpsZI
   nywj71xOruC92seNfQEyOVYcyqrDLok6HdvSVidOwWzpWE088c6tVaIMd
   7Jcu1x1845nRD41QsPdypJFEHZWAzbcd5a3ESe/B8QTxz5wv2t15HNQYf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="294748623"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="294748623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="565942466"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 06:28:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D11A245C; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
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
Subject: [PATCH v2 3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:05 +0300
Message-Id: <20220908132910.62122-4-andriy.shevchenko@linux.intel.com>
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

