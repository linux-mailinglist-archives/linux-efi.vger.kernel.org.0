Return-Path: <linux-efi+bounces-88-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050E7F5BE9
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FE61C20DB0
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD61224D1;
	Thu, 23 Nov 2023 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6D4ZIWw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42210D9;
	Thu, 23 Nov 2023 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734045; x=1732270045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tzAt7QISCosBSiPi2y68kDzl7xHEO4UQ7yEioSdJzTc=;
  b=d6D4ZIWw51g4zde6DbTb4vdlnMgeSj1Rhd5UCuht/Jp65HSTJz4gEZgD
   coiUu9MpdWr8HW2ufqRjCNhSnbLJtZ2CbhdtwHUob2PMxoMy64b3jpntN
   B6Erz/CScmEB+cvUEGj+NOOb/aY8Svc/AGlrLSRifeoJ/wXzzw/WrUxN4
   bYPeMJFr03g32I7REq2d/MsM8jtbtDTG8I0M+d/dE4lNWjxmlOHr9LtUm
   jRuBgNpyaTQ8ar2n4Id0+P/fx7r0Q5MUxLbz46P54y7rrpBdQqnSGVPZT
   gW0URWfeoW4tDO0n63+dy+5q66ywaieCFT30/OlIGCF/PGBbcAhME3/b9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576394"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576394"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160433"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160433"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:07 -0800
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
Subject: [PATCH v3 1/5] ACPI: bus: update acpi_dev_uid_match() to support multiple types
Date: Thu, 23 Nov 2023 15:36:13 +0530
Message-Id: <20231123100617.28020-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

According to ACPI specification, a _UID object can evaluate to either
a numeric value or a string. Update acpi_dev_uid_match() helper to
support _UID matching for both integer and string types.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 19 -------------------
 include/acpi/acpi_bus.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h    |  8 +++-----
 3 files changed, 43 insertions(+), 25 deletions(-)

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
index ec6a673dcb95..a4622d95a36d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -857,10 +857,49 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
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
+#define CONSTIFY(type, x)			\
+	const type: x,				\
+	type: x
+
+#define ACPI_STR_TYPE(match)			\
+	CONSTIFY(unsigned char *, match),	\
+	CONSTIFY(signed char *, match),		\
+	CONSTIFY(char *, match),		\
+	CONSTIFY(void *, match)
+
+#define acpi_dev_uid_match(adev, uid2)					\
+	_Generic(uid2,							\
+		 /* Treat @uid2 as a string for acpi string types */	\
+		 ACPI_STR_TYPE(acpi_str_uid_match),			\
+		 /* Treat as an integer otherwise */			\
+		 default: acpi_int_uid_match)(adev, uid2)
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b556f716d115..6f1e9f98fa44 100644
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


