Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA65B1F1C
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiIHN3s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiIHN3O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D181B00;
        Thu,  8 Sep 2022 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643752; x=1694179752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMp9w4wgPvBJFcprqiqbm816Nf5nzWcjGT/HX2kTYFE=;
  b=GsMmKkCtlCjuuF/zSeuF0ZMWHRiWiYz66eUAFBdwx3fobXIoFMB2BlKY
   gWvVUlmEVYo97gp6r/r07/IPoRcTgmX9xX11RmPscLDjfNaqCT4BY4Z2P
   lKPxrBWIh3XCVPEFsUm/TxLaFWbqVfFUqjwr4LvSJPLBiPfIZnJBs9Ncs
   Ip1gRoNSmcrSlud/8ZfTFvdYpYMQ93Hyly/whyizw3hwqRwHzevY1K7Z0
   Zdo7zBnJIrWDHcpxBO7/qxx9tdTkx0rubCCMX/GqwehkfbfABp8/B1cE9
   8cjpZntpBPqMrjvE6Gg7o5ykBI6ig1S07JQ8/WlwYNLmPncAcBl7vBeSy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284189185"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284189185"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="610693628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Sep 2022 06:29:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A0726D1; Thu,  8 Sep 2022 16:29:13 +0300 (EEST)
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
Subject: [PATCH v2 8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:10 +0300
Message-Id: <20220908132910.62122-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/dev-path-parser.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index eb9c65f97841..f80d87c199c3 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -15,9 +15,11 @@
 static long __init parse_acpi_path(const struct efi_dev_path *node,
 				   struct device *parent, struct device **child)
 {
-	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
 	struct acpi_device *adev;
 	struct device *phys_dev;
+	char hid[ACPI_ID_LEN];
+	u64 uid;
+	int ret;
 
 	if (node->header.length != 12)
 		return -EINVAL;
@@ -27,12 +29,12 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
 			node->acpi.hid >> 16);
-	sprintf(uid, "%u", node->acpi.uid);
 
 	for_each_acpi_dev_match(adev, hid, NULL, -1) {
-		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
+		ret = acpi_dev_uid_to_integer(adev, &uid);
+		if (ret == 0 && node->acpi.uid == uid)
 			break;
-		if (!adev->pnp.unique_id && node->acpi.uid == 0)
+		if (ret == -ENODATA && node->acpi.uid == 0)
 			break;
 	}
 	if (!adev)
-- 
2.35.1

