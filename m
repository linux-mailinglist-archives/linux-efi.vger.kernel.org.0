Return-Path: <linux-efi+bounces-210-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0081246F
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 02:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E7F1C212DA
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AA642;
	Thu, 14 Dec 2023 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoZqiHlY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA1F4;
	Wed, 13 Dec 2023 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702516811; x=1734052811;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qLwPvAV9e6SsTZK7Vc3V4cpzZP0Iy2p3Bpd1PDPZIO4=;
  b=UoZqiHlYa8UwXnCGS4CWtchOY506Q4LEyrhoi9XoNEH05h3E3nCWf2xF
   bTBfKdZjoaJD+JPumhC2pvRIz5v7iHmjR2NP0YOzP+N5cS06TS0DLsP9R
   TXJCK9V5Hy9KiAENVrmGWosrKHJt/j2vW3kdzYc2nKW9xJhv7VbP7tX4z
   LqtcCbSTVK2uMWWuLz+DJtr9fnCa97h98xItHkAfEZGchfcCH44LaPEnK
   oKZ2jJzCbgJG1spWoXRKH0nxw7q6RZ40Ad4r15NwvZvv/4A0j1pk3kO50
   6LvOq9oeMbK1uBRiDioo9tglzCahSq+exFQOPDi7WuGidsPOu3gybFkyN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13747616"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="13747616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767436310"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767436310"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.117.241])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 13 Dec 2023 17:19:55 -0800
Subject: [PATCH v3 2/7] cxl/events: Promote CXL event structures to a core
 header
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-cxl-cper-v3-2-7fd863dd0d25@intel.com>
References: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
In-Reply-To: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702516806; l=5632;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=qLwPvAV9e6SsTZK7Vc3V4cpzZP0Iy2p3Bpd1PDPZIO4=;
 b=Ssn6pZIiErFSQ2lw3rNwdmIxoBoLLOVMEmOmph048sZ0N1AlP5vsXTiJ4i7s7dYBRaND0cJwq
 mm6+ejaMBgSDdlKeQzW1EuJNvbk3TlUxd70CT9+XctoQJ5nrsSR3xdA
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

UEFI code can process CXL events through CPER records.  Those records
use almost the same format as the CXL events.

Lift the CXL event structures to a core header to be shared in later
patches.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/cxlmem.h      |  90 +----------------------------------------
 include/linux/cxl-event.h | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..f0e7ebb84f02 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/cxl-event.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -579,27 +580,6 @@ struct cxl_mbox_identify {
 	u8 qos_telemetry_caps;
 } __packed;
 
-/*
- * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
- */
-struct cxl_event_record_hdr {
-	uuid_t id;
-	u8 length;
-	u8 flags[3];
-	__le16 handle;
-	__le16 related_handle;
-	__le64 timestamp;
-	u8 maint_op_class;
-	u8 reserved[15];
-} __packed;
-
-#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
-struct cxl_event_record_raw {
-	struct cxl_event_record_hdr hdr;
-	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
-} __packed;
-
 /*
  * Get Event Records output payload
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
@@ -641,74 +621,6 @@ struct cxl_mbox_clear_event_payload {
 } __packed;
 #define CXL_CLEAR_EVENT_MAX_HANDLES U8_MAX
 
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
-struct cxl_event_gen_media {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 device[3];
-	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
-	u8 reserved[46];
-} __packed;
-
-/*
- * DRAM Event Record - DER
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
- */
-#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
-struct cxl_event_dram {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 nibble_mask[3];
-	u8 bank_group;
-	u8 bank;
-	u8 row[3];
-	u8 column[2];
-	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
-	u8 reserved[0x17];
-} __packed;
-
-/*
- * Get Health Info Record
- * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
- */
-struct cxl_get_health_info {
-	u8 health_status;
-	u8 media_status;
-	u8 add_status;
-	u8 life_used;
-	u8 device_temp[2];
-	u8 dirty_shutdown_cnt[4];
-	u8 cor_vol_err_cnt[4];
-	u8 cor_per_err_cnt[4];
-} __packed;
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-struct cxl_event_mem_module {
-	struct cxl_event_record_hdr hdr;
-	u8 event_type;
-	struct cxl_get_health_info info;
-	u8 reserved[0x3d];
-} __packed;
-
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
new file mode 100644
index 000000000000..1c94e8fdd227
--- /dev/null
+++ b/include/linux/cxl-event.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CXL_EVENT_H
+#define _LINUX_CXL_EVENT_H
+
+/*
+ * CXL event records; CXL rev 3.0
+ *
+ * Copyright(c) 2023 Intel Corporation.
+ */
+
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+struct cxl_event_record_hdr {
+	uuid_t id;
+	u8 length;
+	u8 flags[3];
+	__le16 handle;
+	__le16 related_handle;
+	__le64 timestamp;
+	u8 maint_op_class;
+	u8 reserved[15];
+} __packed;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+struct cxl_event_record_raw {
+	struct cxl_event_record_hdr hdr;
+	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
+} __packed;
+
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
+struct cxl_event_gen_media {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 device[3];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 reserved[46];
+} __packed;
+
+/*
+ * DRAM Event Record - DER
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
+struct cxl_event_dram {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u8 column[2];
+	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+	u8 reserved[0x17];
+} __packed;
+
+/*
+ * Get Health Info Record
+ * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u8 device_temp[2];
+	u8 dirty_shutdown_cnt[4];
+	u8 cor_vol_err_cnt[4];
+	u8 cor_per_err_cnt[4];
+} __packed;
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+struct cxl_event_mem_module {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	struct cxl_get_health_info info;
+	u8 reserved[0x3d];
+} __packed;
+
+#endif /* _LINUX_CXL_EVENT_H */

-- 
2.43.0


