Return-Path: <linux-efi+bounces-55-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B47F12D0
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 13:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1953B282128
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315C18E31;
	Mon, 20 Nov 2023 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf2UoTg+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48290AA;
	Mon, 20 Nov 2023 04:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482145; x=1732018145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gvs+oGGs0WvlVsw/cdAYmZ/ijzQlY+bl7G7dinrml1Q=;
  b=kf2UoTg+NnH1CovoKECCnJtedN2L4PnpZNmuP2LsmjUD/0xaUkJBDQmc
   FTe29pKpTNrQXblJIen7+d7LyH+HzYHixSKc6xFENMu0xIJUAH91VtZph
   5lsqjfz4uU3bPZFexgzMZNoI+WO1AeqXS9p7rtYdaTnsGBpnrI2ErJqjx
   XIGPXz9Y7Kt03f8lpVbWLBGTAx42bgJ+Tb52tjObICDwvuJIEbLEMrqi/
   PZnvo9Ob2MIRQ/YYChaAmRjnXNVAx0SkVTatV+pzHr+ijnrFev3PxK+kM
   ORPkvRbC9Hd8GMHBYaaSBNHSSRaLM6wc4wNk0dvLJAGIn/bv6bAhM6hC5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455694"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455694"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878605"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878605"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:08:55 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/6] ACPI: bus: update acpi_dev_uid_match() to support multiple types
Date: Mon, 20 Nov 2023 17:38:33 +0530
Message-Id: <20231120120837.3002-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

According to ACPI specification, a _UID object can evaluate to either
a numeric value or a string. Update acpi_dev_uid_match() helper to
support _UID matching for both integer and string types.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 19 -------------------
 include/acpi/acpi_bus.h | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h    |  8 +++-----
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 28c75242fca9..fe7e850c6479 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,25 +824,6 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
-/**
- * acpi_dev_uid_match - Match device by supplied UID
- * @adev: ACPI device to match.
- * @uid2: Unique ID of the device.
- *
- * Matches UID in @adev with given @uid2.
- *
- * Returns:
- *  - %true if matches.
- *  - %false otherwise.
- */
-bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
-{
-	const char *uid1 = acpi_device_uid(adev);
-
-	return uid1 && uid2 && !strcmp(uid1, uid2);
-}
-EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
-
 /**
  * acpi_dev_hid_uid_match - Match device by supplied HID and UID
  * @adev: ACPI device to match.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 989ea623b1c2..25b9fabf350f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -9,6 +9,7 @@
 #ifndef __ACPI_BUS_H__
 #define __ACPI_BUS_H__
 
+#include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/property.h>
 
@@ -856,10 +857,42 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
-bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
+static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	const char *uid1 = acpi_device_uid(adev);
+
+	return uid1 && uid2 && !strcmp(uid1, uid2);
+}
+
+static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
+{
+	u64 uid1;
+
+	return !acpi_dev_uid_to_integer(adev, &uid1) && uid1 == uid2;
+}
+
+/**
+ * acpi_dev_uid_match - Match device by supplied UID
+ * @adev: ACPI device to match.
+ * @uid2: Unique ID of the device.
+ *
+ * Matches UID in @adev with given @uid2.
+ *
+ * Returns: %true if matches, %false otherwise.
+ */
+
+/* Treat uid as a string for pointer and array types, treat as an integer otherwise */
+#define get_uid_type(x) \
+	(__builtin_choose_expr(is_array_or_pointer_type(x), (const char *)0, (u64)0))
+
+#define acpi_dev_uid_match(adev, uid2)						\
+	_Generic(get_uid_type(uid2),						\
+		 const char *: acpi_str_uid_match,				\
+		 u64: acpi_int_uid_match)(adev, uid2)
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 54189e0e5f41..3d7ee8c0b86a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -756,6 +756,9 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
 
+/* Get rid of the -Wunused-variable for adev */
+#define acpi_dev_uid_match(adev, uid2)		(adev && false)
+
 #include <acpi/acpi_numa.h>
 
 struct fwnode_handle;
@@ -772,11 +775,6 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
-static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
-{
-	return false;
-}
-
 static inline bool
 acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
 {
-- 
2.17.1


