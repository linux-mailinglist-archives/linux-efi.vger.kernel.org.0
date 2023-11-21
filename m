Return-Path: <linux-efi+bounces-66-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE557F2ABC
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E61AB216E4
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5447787;
	Tue, 21 Nov 2023 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFkK+81N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B5B9;
	Tue, 21 Nov 2023 02:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563131; x=1732099131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dxaWexg84suTd0yeCu0NfS/UZPVtK67Wtmy9gG5EJdU=;
  b=IFkK+81NYod3fmlTE5UfY/I+r194FUvIb1CQCKITCN6C+1pKMH7BOCBR
   djn7j2fUHLrf9FhQEbGI5jaRyf+Nzyhj7x4SkId6lrm2q+3l46PLsHJxB
   1bcO7o6qIkuO/EjQAtzN0rCyy2iVwGuEaL9KNSaRfweZPy2BYobJDnlWS
   dTb7iK8inLfX5p3fn50YnmYdA/hrfcD1/R08OIvEtWTb/BDQmzLFWiEBA
   AJDOO9UhIf2iIPwuQMe/+Cdlfih82WM5e0lzw4tGv64pkJDdD94bCVc6g
   2YGn8H+F1IkMQ3rLPNJexa5XjYE4ZOljncDJrT5dC2H6j9V1Cum9YyT3S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986916"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871942"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:47 -0800
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
Subject: [PATCH v2 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
Date: Tue, 21 Nov 2023 16:08:26 +0530
Message-Id: <20231121103829.10027-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Now that we have _UID matching support for both integer and string types,
we can support them into acpi_dev_hid_uid_match() helper as well.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 29 -----------------------------
 include/acpi/acpi_bus.h | 24 +++++++++++++++++++++++-
 include/linux/acpi.h    |  7 +------
 3 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index fe7e850c6479..03f6de9a0807 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,35 +824,6 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
-/**
- * acpi_dev_hid_uid_match - Match device by supplied HID and UID
- * @adev: ACPI device to match.
- * @hid2: Hardware ID of the device.
- * @uid2: Unique ID of the device, pass NULL to not check _UID.
- *
- * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
- * will be treated as a match. If user wants to validate @uid2, it should be
- * done before calling this function.
- *
- * Returns:
- *  - %true if matches or @uid2 is NULL.
- *  - %false otherwise.
- */
-bool acpi_dev_hid_uid_match(struct acpi_device *adev,
-			    const char *hid2, const char *uid2)
-{
-	const char *hid1 = acpi_device_hid(adev);
-
-	if (strcmp(hid1, hid2))
-		return false;
-
-	if (!uid2)
-		return true;
-
-	return acpi_dev_uid_match(adev, uid2);
-}
-EXPORT_SYMBOL(acpi_dev_hid_uid_match);
-
 /**
  * acpi_dev_uid_to_integer - treat ACPI device _UID as integer
  * @adev: ACPI device to get _UID from
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bcd78939bab4..6f10c3de9488 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -858,9 +858,15 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
-bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
+static inline bool acpi_dev_hid_match(struct acpi_device *adev, const char *hid2)
+{
+	const char *hid1 = acpi_device_hid(adev);
+
+	return hid1 && hid2 && !strcmp(hid1, hid2);
+}
+
 static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)
 {
 	const char *uid1 = acpi_device_uid(adev);
@@ -894,6 +900,22 @@ static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
 		 const char *: acpi_str_uid_match,		\
 		 u64: acpi_int_uid_match)(adev, uid2)
 
+/**
+ * acpi_dev_hid_uid_match - Match device by supplied HID and UID
+ * @adev: ACPI device to match.
+ * @hid2: Hardware ID of the device.
+ * @uid2: Unique ID of the device, pass 0 or NULL to not check _UID.
+ *
+ * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
+ * will be treated as a match. If user wants to validate @uid2, it should be
+ * done before calling this function.
+ *
+ * Returns: %true if matches or @uid2 is 0 or NULL, %false otherwise.
+ */
+#define acpi_dev_hid_uid_match(adev, hid2, uid2)		\
+	(acpi_dev_hid_match(adev, hid2) &&			\
+		(!(uid2) || acpi_dev_uid_match(adev, uid2)))
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index aae3a459d63c..fda188ff3dcf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -765,6 +765,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 
 /* Get rid of the -Wunused-variable for adev */
 #define acpi_dev_uid_match(adev, uid2)			(adev && false)
+#define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
 
 #include <acpi/acpi_numa.h>
 
@@ -782,12 +783,6 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
-static inline bool
-acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
-{
-	return false;
-}
-
 static inline int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
 {
 	return -ENODEV;
-- 
2.17.1


