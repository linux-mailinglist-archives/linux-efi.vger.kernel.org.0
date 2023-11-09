Return-Path: <linux-efi+bounces-12-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83B7E742C
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 23:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13277281241
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86338F9F;
	Thu,  9 Nov 2023 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro1Pntqd"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577638F97;
	Thu,  9 Nov 2023 22:07:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA3386A;
	Thu,  9 Nov 2023 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567642; x=1731103642;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AbHDxCgPYsCq01Y4foGl48AbFUMq8e0fAJvgOZkGp3U=;
  b=Ro1Pntqd1ajBcXlniclItxr6v/RhE6ymlWNL0rqBcey2gNky8xOUhAL0
   QG5zosbh0sCr9q1jfe3EuahWQUQSLTf9t8a5/sNQfuM8hP0XgYwOFfif6
   G5b1Mqt4U0inguwa/o8izk1KntfHDUKso/LYUTV8qmA0HRac4ZhdKYQ7A
   +abFvqv6fObV+0Xhp3hQx976SZFHzAyKX4AWUHPnIb7De7GnSjEiJy8i4
   Z5GgjecjG+VzQNEDTi5z4SEzL3QdjHE6F1noHL+TboWjVAez9elii8/Xl
   7H5UZSnELi22ZW/8S4R0Fcj3W+ZzpBO0PZcMFiLreiWO99KYvhfZhG4ZM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124170"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453304"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453304"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:21 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 09 Nov 2023 14:07:15 -0800
Subject: [PATCH RFC v4 2/6] cxl/events: Promote CXL event structures to a
 core header
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v4-2-47bb901f135e@intel.com>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
In-Reply-To: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
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
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=5662;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=AbHDxCgPYsCq01Y4foGl48AbFUMq8e0fAJvgOZkGp3U=;
 b=0yphYR5e01hvNWf6rzt8n4MS74bRzbSkQJuNEYi1O6g7zwPZ59/0jK4EY+VihK/3h96AStw41
 DVPIRfXSFZ8AtLTcAiEjKFBzy1UGgm0UMWKEx/SMQmTEp57YgKbPLoN
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

UEFI code can process CXL events through CPER records.  Those records
use almost the same format as the CXL events.

Lift the CXL event structures to a core header to be shared.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v2:
[djbw: new patch]
---
 drivers/cxl/cxlmem.h      |  90 +----------------------------------------
 include/linux/cxl-event.h | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..d694820ce8f5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/cxl-event.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -576,27 +577,6 @@ struct cxl_mbox_identify {
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
@@ -638,74 +618,6 @@ struct cxl_mbox_clear_event_payload {
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
2.41.0


