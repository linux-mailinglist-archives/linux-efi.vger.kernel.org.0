Return-Path: <linux-efi+bounces-64-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9283D7F2AB9
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47040282343
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B3F4EC;
	Tue, 21 Nov 2023 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ25NazC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D1113;
	Tue, 21 Nov 2023 02:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563126; x=1732099126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=U7qXPbkOU+uJnKsznZCchO4LL3iAWvuDM1CUIkNhqaI=;
  b=PJ25NazCbLyTp3oUFnggMQ9WcpDd1J44m+fZ68QyHNazjH5koDCT46FD
   Ot/BuNAJ8TR+Od5ridnGjd5vj3kHjZned4KcQkA2JEjv4DleyFUOP/+++
   cPtUR1+zb78vVQgZ3kqQsC8J0tSxIxckwvz3hKvpIdgFTae6wlyd2i9dm
   YksFAehXMsvO/cExGeqZTsC6bDtWBbvSRmrPr1mm7MrM/G02u0ro4ukYF
   d8e01Y/xw/Tg6rj7pGTpWZylpD9tKiPftn44KrV8NAXBBbfX4YhszSJJ/
   a+7Pnrrq+6HWZ2CYRwPa2esEzOVrHY31EwdYXsE2GkotOTqqZl/GC+rhf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986897"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871936"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:42 -0800
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
Subject: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support multiple types
Date: Tue, 21 Nov 2023 16:08:25 +0530
Message-Id: <20231121103829.10027-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
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
index ec6a673dcb95..bcd78939bab4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -9,6 +9,7 @@
 #ifndef __ACPI_BUS_H__
 #define __ACPI_BUS_H__
 
+#include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/property.h>
 
@@ -857,10 +858,42 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
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
+/* Treat uid as a string for array and pointer types, treat as an integer otherwise */
+#define get_uid_type(x) \
+	(__builtin_choose_expr(is_array_or_pointer_type(x), (const char *)0, (u64)0))
+
+#define acpi_dev_uid_match(adev, uid2)				\
+	_Generic(get_uid_type(uid2),				\
+		 const char *: acpi_str_uid_match,		\
+		 u64: acpi_int_uid_match)(adev, uid2)
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b63d7811c728..aae3a459d63c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -763,6 +763,9 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
 
+/* Get rid of the -Wunused-variable for adev */
+#define acpi_dev_uid_match(adev, uid2)			(adev && false)
+
 #include <acpi/acpi_numa.h>
 
 struct fwnode_handle;
@@ -779,11 +782,6 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
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


