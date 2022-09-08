Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C730A5B1EFC
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiIHN3c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiIHN3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6212C4A0;
        Thu,  8 Sep 2022 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643745; x=1694179745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V80BdvPU7ap78HoolUzQor9A2iHpp5rs73DM1e1058s=;
  b=UM4rIvKu4Op9DzSNQ0BNa2HPZ7Urdr1NuLdbp3wYNhk/cgId9lWDPRr0
   auCKpvGm7azkU2z3P0t+9qKf9S7DrOe5/O6Q872MUnfk9G92f4Pfqrjfe
   Px/V+URUVJ74/Hh8+MnPDBa/+oO4H/3hEFsKciaWpUd1VIWXWG6tMEcSy
   H1JVougd9JPu987tcLlqiGmXYtVNQl7S3zXZ3787LdlqtJFCgwve2VA7W
   PIzS7j0rd31UAo3k6OdK18zGuRTuMKsgTNbzy32JmXkShHSiEtRFWI8sQ
   Yw8cnUE82bfvMzBh6gjs1St4GaHFh5ldyXBJRMANQo/C9xNxuf5lHnFH/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280196135"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280196135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683232432"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 06:28:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2183F7; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
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
Subject: [PATCH v2 1/8] ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
Date:   Thu,  8 Sep 2022 16:29:03 +0300
Message-Id: <20220908132910.62122-2-andriy.shevchenko@linux.intel.com>
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

Some users interpret _UID only as integer and for them it's easier to
have an integer representation of _UID. Add respective helper for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/utils.c    | 24 ++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 4acd6f7d1395..2ea14648a661 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -793,6 +793,30 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
+/**
+ * acpi_dev_uid_to_integer - treat ACPI device _UID as integer
+ * @adev: ACPI device to get _UID from
+ * @integer: output buffer for integer
+ *
+ * Considers _UID as integer and converts it to @integer.
+ *
+ * Returns 0 on success, or negative error code otherwise.
+ */
+int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
+{
+	const char *uid;
+
+	if (!adev)
+		return -ENODEV;
+
+	uid = acpi_device_uid(adev);
+	if (!uid)
+		return -ENODATA;
+
+	return kstrtou64(uid, 0, integer);
+}
+EXPORT_SYMBOL(acpi_dev_uid_to_integer);
+
 /**
  * acpi_dev_found - Detect presence of a given ACPI device in the namespace.
  * @hid: Hardware ID of the device.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 42f76f2c2d49..1804d7a70918 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -739,6 +739,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 }
 
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
+int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed4aa395cc49..619b2b1e4fb4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -799,6 +799,11 @@ acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *u
 	return false;
 }
 
+static inline int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
+{
+	return -ENODEV;
+}
+
 static inline struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 {
-- 
2.35.1

