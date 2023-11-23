Return-Path: <linux-efi+bounces-90-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006CF7F5BED
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789A9B2108D
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC606224D6;
	Thu, 23 Nov 2023 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0/9uDb4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40114D5C;
	Thu, 23 Nov 2023 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734047; x=1732270047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M17rtlGu3x0u3QSxZOF2OqZZLdquFjrEe7DlHL2uUIM=;
  b=g0/9uDb4clB/q4HySwqyj4+a4xz+4oYB5oN4f81TZUrctuBwnBJmfnYS
   3r5GAq732atzqh4QbLPiKo6Ez2NKAmtawuastxOtWrwsTJ8u5Vmd5KnYh
   sFopdsJe4lO2/ugOo3Q0yhobwh/SHsIVhemVWOe9oXF+ug+qFLTrfzGXS
   Lcc+qE33t9ysfgANmoPU/LaGlpqd/3RKoq1FyEeqr2quCJyNyfusQ4jDV
   2CI17tcgWlE35z5/0iQsgwU2clQ1+Bqs1FlaDeCX3cAgiwRgulumCTiSY
   lxdjC8qiOUXvfj0l0hb0D0ekdXaYRquIb7znNWhcZPv/Bbt/FGg/SWcaT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576407"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576407"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160473"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160473"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:12 -0800
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
Subject: [PATCH v3 2/5] ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
Date: Thu, 23 Nov 2023 15:36:14 +0530
Message-Id: <20231123100617.28020-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Now that we have _UID matching support for both integer and string types,
we can support them into acpi_dev_hid_uid_match() helper as well.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
index a4622d95a36d..e5b4c3f8d2be 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -857,9 +857,15 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
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
@@ -900,6 +906,22 @@ static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
 		 /* Treat as an integer otherwise */			\
 		 default: acpi_int_uid_match)(adev, uid2)
 
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
+#define acpi_dev_hid_uid_match(adev, hid2, uid2)			\
+	(acpi_dev_hid_match(adev, hid2) &&				\
+		(!(uid2) || acpi_dev_uid_match(adev, uid2)))
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f1e9f98fa44..118a18b7ff84 100644
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


