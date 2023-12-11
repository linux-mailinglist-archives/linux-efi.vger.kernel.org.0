Return-Path: <linux-efi+bounces-180-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181380DEB7
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E12B212A3
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E955C3C;
	Mon, 11 Dec 2023 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1zdJakT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1773A9;
	Mon, 11 Dec 2023 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335469; x=1733871469;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LFJKcZC9/9yTeU+IYw82qPCKe4W3CryngEK7C31jeqA=;
  b=k1zdJakTO6uQuOGZX9ps4WfTeV4dr/1iFGBYN2K8gWnhxwiW+TH41IBD
   aCTvgl3hLUlg9K8l9rBWLftw7jIIzPAOe8Qh/6nKBGX9ahpOXCoVoSjKy
   fichlngEl9Vf0Rh1QF1Zq4ck8HcD0rCiwQplhN04l+lxN+JGipFHC/WID
   tVq79GOXYyUjMOKIYn0UliymYruKy8moIeRWcPKxLnLTmQAn7Lq7wI0qb
   jy8QxPZMtu+SpmPvDVK5MvCfs46hWzEhvSWN+ufRJlYvSzrG3+OaFOvoL
   PqnXaA/2ETh4QV8gspcLecxmNLt8xTJ6P20MU33wcrW7b+S0VUwVt5wv2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084365"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084365"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513482"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513482"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:47 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 11 Dec 2023 14:57:44 -0800
Subject: [PATCH v2 4/7] cxl/events: Separate UUID from event structures
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-4-c116900ba658@intel.com>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
In-Reply-To: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335463; l=7827;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=LFJKcZC9/9yTeU+IYw82qPCKe4W3CryngEK7C31jeqA=;
 b=kp90rcD7a1p+iW/P5x+krZsAYYjoq9DVfe19HxG780xvcZ2SEoJKdxik1+r7hXB8ge11Nf4up
 NFZFQWR5mP3DytgN4YUXnTEzjP8e+xAl0wQGPXP6vpO3FEmp7yoCqys
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

The UEFI CXL CPER structure does not include the UUID.  Now that the
UUID is passed separately to the trace event there is no need to have
the UUID in those structures.

Move UUID from the event record header to the raw structures.  Adjust
cxl-test to Create dummy structures for creating test records.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
[iweiny: adjust for new UUID defines]
---
 drivers/cxl/core/mbox.c      |   2 +-
 include/linux/cxl-event.h    |  10 ++--
 tools/testing/cxl/test/mem.c | 129 +++++++++++++++++++++++++------------------
 3 files changed, 81 insertions(+), 60 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6866fb403fa1..f4d82e29435d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -858,7 +858,7 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
-	uuid_t *id = &record->hdr.id;
+	uuid_t *id = &record->id;
 
 	if (uuid_equal(id, &gen_media_event_uuid)) {
 		struct cxl_event_gen_media *rec =
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 1c94e8fdd227..ebb00ead1496 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -8,12 +8,7 @@
  * Copyright(c) 2023 Intel Corporation.
  */
 
-/*
- * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
- */
 struct cxl_event_record_hdr {
-	uuid_t id;
 	u8 length;
 	u8 flags[3];
 	__le16 handle;
@@ -23,8 +18,13 @@ struct cxl_event_record_hdr {
 	u8 reserved[15];
 } __packed;
 
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
 struct cxl_event_record_raw {
+	uuid_t id;
 	struct cxl_event_record_hdr hdr;
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 5a95b04b329a..9cc2b8ce1efd 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -337,9 +337,9 @@ static void cxl_mock_event_trigger(struct device *dev)
 }
 
 struct cxl_event_record_raw maint_needed = {
+	.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
+			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 	.hdr = {
-		.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
-				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 		.length = sizeof(struct cxl_event_record_raw),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
 		/* .handle = Set dynamically */
@@ -349,9 +349,9 @@ struct cxl_event_record_raw maint_needed = {
 };
 
 struct cxl_event_record_raw hardware_replace = {
+	.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
+			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 	.hdr = {
-		.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
-				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 		.length = sizeof(struct cxl_event_record_raw),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
 		/* .handle = Set dynamically */
@@ -360,61 +360,82 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
-struct cxl_event_gen_media gen_media = {
-	.hdr = {
-		.id = CXL_EVENT_GEN_MEDIA_UUID,
-		.length = sizeof(struct cxl_event_gen_media),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_gen_media {
+	uuid_t id;
+	struct cxl_event_gen_media rec;
+} __packed;
+
+struct cxl_test_gen_media gen_media = {
+	.id = CXL_EVENT_GEN_MEDIA_UUID,
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_gen_media),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.phys_addr = cpu_to_le64(0x2000),
+		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+		/* .validity_flags = <set below> */
+		.channel = 1,
+		.rank = 30
 	},
-	.phys_addr = cpu_to_le64(0x2000),
-	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
-	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
-	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
-	/* .validity_flags = <set below> */
-	.channel = 1,
-	.rank = 30
 };
 
-struct cxl_event_dram dram = {
-	.hdr = {
-		.id = CXL_EVENT_DRAM_UUID,
-		.length = sizeof(struct cxl_event_dram),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_dram {
+	uuid_t id;
+	struct cxl_event_dram rec;
+} __packed;
+
+struct cxl_test_dram dram = {
+	.id = CXL_EVENT_DRAM_UUID,
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_dram),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.phys_addr = cpu_to_le64(0x8000),
+		.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+		.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+		.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+		/* .validity_flags = <set below> */
+		.channel = 1,
+		.bank_group = 5,
+		.bank = 2,
+		.column = {0xDE, 0xAD},
 	},
-	.phys_addr = cpu_to_le64(0x8000),
-	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
-	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
-	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
-	/* .validity_flags = <set below> */
-	.channel = 1,
-	.bank_group = 5,
-	.bank = 2,
-	.column = {0xDE, 0xAD},
 };
 
-struct cxl_event_mem_module mem_module = {
-	.hdr = {
-		.id = CXL_EVENT_MEM_MODULE_UUID,
-		.length = sizeof(struct cxl_event_mem_module),
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_mem_module {
+	uuid_t id;
+	struct cxl_event_mem_module rec;
+} __packed;
+
+struct cxl_test_mem_module mem_module = {
+	.id = CXL_EVENT_MEM_MODULE_UUID,
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_mem_module),
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.event_type = CXL_MMER_TEMP_CHANGE,
+		.info = {
+			.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+			.media_status = CXL_DHI_MS_ALL_DATA_LOST,
+			.add_status = (CXL_DHI_AS_CRITICAL << 2) |
+				      (CXL_DHI_AS_WARNING << 4) |
+				      (CXL_DHI_AS_WARNING << 5),
+			.device_temp = { 0xDE, 0xAD},
+			.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
+			.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+			.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		}
 	},
-	.event_type = CXL_MMER_TEMP_CHANGE,
-	.info = {
-		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
-		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
-		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
-			      (CXL_DHI_AS_WARNING << 4) |
-			      (CXL_DHI_AS_WARNING << 5),
-		.device_temp = { 0xDE, 0xAD},
-		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
-		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
-		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
-	}
 };
 
 static int mock_set_timestamp(struct cxl_dev_state *cxlds,
@@ -436,11 +457,11 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
-			   &gen_media.validity_flags);
+			   &gen_media.rec.validity_flags);
 
 	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
 			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
-			   &dram.validity_flags);
+			   &dram.rec.validity_flags);
 
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO,

-- 
2.43.0


