Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA285B0AD4
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGQ6M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIGQ5w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:57:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168ABD090;
        Wed,  7 Sep 2022 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569865; x=1694105865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6djZzfesjXmWCyiZuKYgE8QLWSt9qAJBAVV89VeFhJk=;
  b=gnuyuiQ9J/ktQ0WyuVcyzSuv465YL4gCk5AazSYMF65EbJqwa4hTEg1L
   zdiwU7fvqoEV6iAiC7c3z6pMzBEsPGANcgtdt1XwYaUv1U9FeJ6jsw/2l
   BrQhbYjWL3dCCiYmYAzdATjWUmtS+lwVrZVyNRcWKZC+VgRF8JE20jdxe
   xdYCsAMUxgxFummkB63jH4lm5MMdLZm002NjAZaAmbs/0UkSVg706xNWt
   WwTmgipVSTut8oSREixA4GvweD5zx9fCxpPDgxHLYBf7p06AqXi58IbHM
   9/CxODv3IusaaD8rzcTgrPTkKPXsgvK+70EdzrNc5IY9RGlDvINqE/Odp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297740725"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297740725"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="682886539"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2022 09:46:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 427CF6CD; Wed,  7 Sep 2022 19:46:12 +0300 (EEST)
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
Subject: [PATCH v1 8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:06 +0300
Message-Id: <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
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
---
 drivers/firmware/efi/dev-path-parser.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index eb9c65f97841..113b3ca1bd76 100644
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
+	long ret;
+	u64 uid;
 
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
+		if (ret == -ENODATA && node->acpi.uid == 0)
 			break;
-		if (!adev->pnp.unique_id && node->acpi.uid == 0)
+		if (ret == 0 && node->acpi.uid == uid)
 			break;
 	}
 	if (!adev)
-- 
2.35.1

