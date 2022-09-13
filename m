Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A435B7866
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiIMRk2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiIMRjl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B2A7221;
        Tue, 13 Sep 2022 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086741; x=1694622741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeDF2xSviZhU3KN3WMgjO56/nBhapQiTY2+YlehU628=;
  b=kqXg0jVQyRYUjGvhycffGL62k+hT4NDc7mZZgp2G+h1XCeCP7u3Gf16N
   AGp3l5q4T30L/OUrIIsr1cbfAjuFvr6FTz8MpWgEca92HEQ/6bdW1FuUp
   CivFbQ27v+HJ3d2CnBjtKrcSw+KvG6BBRjINg/GjKxXgcVZqATglol90B
   beX5FhdBuBxgPuklNW5MVcX0YCsiOLovHuT99n50tClpacpKjLFkZIIPO
   Kr8+r74mu3PdeRZVKYuMJRtPy8Kh/ckGb48UOILHY04qPbY8bAD3mGimF
   KTRrfM6+XGRF6et1vK5mxkGRlo9iOD+4d+I8WRUYYOG4cNaIb4U0tTlgZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="362135470"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="362135470"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="791992110"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2022 09:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CA7E50D; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v3 5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:44 +0300
Message-Id: <20220913163147.24258-6-andriy.shevchenko@linux.intel.com>
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
Acked-by: Wolfram Sang <wsa@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 8716032f030a..32235c62f3d2 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2229,35 +2229,27 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_i2c_acpi_ids);
 static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
 	const struct acpi_device_id *aid;
-	struct acpi_device *adev;
-	unsigned long bus_id = 0;
-	const char *uid;
+	u64 bus_id;
 	int ret;
 
 	if (acpi_disabled)
 		return -ENOENT;
 
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENXIO;
-
 	aid = acpi_match_device(mlxbf_i2c_acpi_ids, dev);
 	if (!aid)
 		return -ENODEV;
 
 	priv->chip = (struct mlxbf_i2c_chip_info *)aid->driver_data;
 
-	uid = acpi_device_uid(adev);
-	if (!uid || !(*uid)) {
+	ret = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &bus_id);
+	if (ret) {
 		dev_err(dev, "Cannot retrieve UID\n");
-		return -ENODEV;
+		return ret;
 	}
 
-	ret = kstrtoul(uid, 0, &bus_id);
-	if (!ret)
-		priv->bus = bus_id;
+	priv->bus = bus_id;
 
-	return ret;
+	return 0;
 }
 #else
 static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
-- 
2.35.1

