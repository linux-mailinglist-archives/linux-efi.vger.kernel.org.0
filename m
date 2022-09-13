Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90695B784E
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiIMRke (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiIMRjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A0A7215;
        Tue, 13 Sep 2022 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086759; x=1694622759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xgxQe/9VuRknZlyDDD0FzxD71AXddVq2scuKrzOQ48U=;
  b=PQKh8CcCmDfCtZShfS4csAnrpi+MmrtSYBAGy/mt2jDQuV8+HXAXAUkX
   V42vPtaBqCWinHhRwgg/GANyPx9sqHny3SfnKTHVhOaEtSyEQEtDHuNPk
   ivQEOLe6JFgNs8scWVd9g438Fp7WCLd3oXWnN/Z2JUT9wgvyHIkD/ee7d
   h8lHTatN/XMUkzi/R0hk9yaFRbcL5jKy3sCVH6Bfmos0nND3QeypLvrsb
   Mvk3b34ctYrOLuk/oQTLeyYfz8Z454rCk29gp0WsGsMf9obkLPWd9GxKy
   ljKI4iKGKWAEAqjv8H15gdSTHQaRp+SIOTZPOe0jXcRiJNWABh/TrcCOU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299523979"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="299523979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="742221651"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2022 09:31:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 978916CD; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
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
Subject: [PATCH v3 8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:47 +0300
Message-Id: <20220913163147.24258-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
References: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

