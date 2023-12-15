Return-Path: <linux-efi+bounces-231-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91A815475
	for <lists+linux-efi@lfdr.de>; Sat, 16 Dec 2023 00:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F061C238C3
	for <lists+linux-efi@lfdr.de>; Fri, 15 Dec 2023 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48A56391;
	Fri, 15 Dec 2023 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHjB/YbU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4149F71;
	Fri, 15 Dec 2023 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682795; x=1734218795;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ReAK8ewUlfQLJ8Kr8JnEs+zfB+t7VJktaVtfjbJqW3g=;
  b=CHjB/YbUmnL7ZMDgmi8g3mjv7dKdllKSbnwmQyjyB00clcr8ZvvnCel6
   nAbkRh3Bc7Va7rwkU/neVB5R0bHo5pVteHeqB0BOMUgYYl6UmbRaKNFkU
   gGCnHa4f1bmw8xL/dJXed0MJMMdg0Ftay2sTD0xrSEwlfydemQp/ENWxd
   6BNXnn64Y7sYxygpYN+UAYDZwG3MZzyUxvIaUtGOnTqVpblVbdkOr1jM0
   k8hNLgjW4mJav7YpzqWrRFxYHagdMcOOQYsx5RgnZLkAM4itAaCDVVDQX
   CYcavab1Ys2ABqB8oxCh4M6Fb7Ysrned9dohgECEtdx33ECjgS1ajSBXj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="426468796"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="426468796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778439266"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="778439266"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.164.93])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 15 Dec 2023 15:26:31 -0800
Subject: [PATCH v4 5/7] cxl/events: Create a CXL event union
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-cxl-cper-v4-5-01b6dab44fcd@intel.com>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
In-Reply-To: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702682786; l=6690;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=ReAK8ewUlfQLJ8Kr8JnEs+zfB+t7VJktaVtfjbJqW3g=;
 b=GjgkHOOBOwIgjNXqvlKsUXs4xqtLYAGrGMIVEae8NwNPN/KbAcNtvhvlnL9GBhkvV+XPOHZml
 aQW7KVGCfyEB1Ev7RHcv8OPs3q5znAySp/qrhmsRYCaMQEI1WNlw/Ct
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

The CXL CPER and event log records share everything but a UUID/GUID in
their structures.

Define a cxl_event union without the UUID/GUID to be shared between the
CPER and event log record formats.  Adjust the code to use this union.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c      | 32 +++++++++++++-------------------
 drivers/cxl/core/trace.h     |  8 ++++----
 include/linux/cxl-event.h    | 23 +++++++++++++++++------
 tools/testing/cxl/test/mem.c | 31 ++++++++++++++++++-------------
 4 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5c4e4a692dea..b7efa058a100 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -844,26 +844,17 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
+	union cxl_event *evt = &record->event;
 	uuid_t *id = &record->id;
 
-	if (uuid_equal(id, &gen_media_event_uuid)) {
-		struct cxl_event_gen_media *rec =
-				(struct cxl_event_gen_media *)record;
-
-		trace_cxl_general_media(cxlmd, type, id, rec);
-	} else if (uuid_equal(id, &dram_event_uuid)) {
-		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
-
-		trace_cxl_dram(cxlmd, type, id, rec);
-	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
-		struct cxl_event_mem_module *rec =
-				(struct cxl_event_mem_module *)record;
-
-		trace_cxl_memory_module(cxlmd, type, id, rec);
-	} else {
-		/* For unknown record types print just the header */
-		trace_cxl_generic_event(cxlmd, type, id, record);
-	}
+	if (uuid_equal(id, &gen_media_event_uuid))
+		trace_cxl_general_media(cxlmd, type, id, &evt->gen_media);
+	else if (uuid_equal(id, &dram_event_uuid))
+		trace_cxl_dram(cxlmd, type, id, &evt->dram);
+	else if (uuid_equal(id, &mem_mod_event_uuid))
+		trace_cxl_memory_module(cxlmd, type, id, &evt->mem_module);
+	else
+		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -906,7 +897,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	 */
 	i = 0;
 	for (cnt = 0; cnt < total; cnt++) {
-		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
+		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
+		struct cxl_event_generic *gen = &raw->event.generic;
+
+		payload->handles[i++] = gen->hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
 			le16_to_cpu(payload->handles[i]));
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 3da16026b8db..862b50cb1829 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -225,9 +225,9 @@ TRACE_EVENT(cxl_overflow,
 TRACE_EVENT(cxl_generic_event,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 const uuid_t *uuid, struct cxl_event_record_raw *rec),
+		 const uuid_t *uuid, struct cxl_event_generic *gen_rec),
 
-	TP_ARGS(cxlmd, log, uuid, rec),
+	TP_ARGS(cxlmd, log, uuid, gen_rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -235,8 +235,8 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
-		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, gen_rec->hdr);
+		memcpy(__entry->data, gen_rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
 	CXL_EVT_TP_printk("%s",
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index ebb00ead1496..18dab4d90dc8 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -18,13 +18,8 @@ struct cxl_event_record_hdr {
 	u8 reserved[15];
 } __packed;
 
-/*
- * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
- */
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
-struct cxl_event_record_raw {
-	uuid_t id;
+struct cxl_event_generic {
 	struct cxl_event_record_hdr hdr;
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
@@ -97,4 +92,20 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
+union cxl_event {
+	struct cxl_event_generic generic;
+	struct cxl_event_gen_media gen_media;
+	struct cxl_event_dram dram;
+	struct cxl_event_mem_module mem_module;
+} __packed;
+
+/*
+ * Common Event Record Format; in event logs
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+struct cxl_event_record_raw {
+	uuid_t id;
+	union cxl_event event;
+} __packed;
+
 #endif /* _LINUX_CXL_EVENT_H */
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9cc2b8ce1efd..35ee41e435ab 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -251,7 +251,8 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
 		memcpy(&pl->records[i], event_get_current(log),
 		       sizeof(pl->records[i]));
-		pl->records[i].hdr.handle = event_get_cur_event_handle(log);
+		pl->records[i].event.generic.hdr.handle =
+				event_get_cur_event_handle(log);
 		log->cur_idx++;
 	}
 
@@ -339,25 +340,29 @@ static void cxl_mock_event_trigger(struct device *dev)
 struct cxl_event_record_raw maint_needed = {
 	.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
 			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
-	.hdr = {
-		.length = sizeof(struct cxl_event_record_raw),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0xa5b6),
+	.event.generic = {
+		.hdr = {
+			.length = sizeof(struct cxl_event_record_raw),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0xa5b6),
+		},
+		.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 	},
-	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
 struct cxl_event_record_raw hardware_replace = {
 	.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
 			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
-	.hdr = {
-		.length = sizeof(struct cxl_event_record_raw),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0xb6a5),
+	.event.generic = {
+		.hdr = {
+			.length = sizeof(struct cxl_event_record_raw),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0xb6a5),
+		},
+		.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 	},
-	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
 struct cxl_test_gen_media {

-- 
2.43.0


