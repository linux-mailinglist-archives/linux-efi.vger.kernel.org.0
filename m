Return-Path: <linux-efi+bounces-276-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF381ABAE
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A988B257E6
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAF5CAC;
	Thu, 21 Dec 2023 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC0iBrvV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB31367;
	Thu, 21 Dec 2023 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118285; x=1734654285;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g9zeiQ0wd5i9ymO0m/+melFI97qLH3mOOLksPAT5rTs=;
  b=YC0iBrvVk5fwkdhFCoxwDF6vYiRLMncGcydxuZOdpV/RtgFRm7uPBX4K
   CxPYOQ1dneKrT21Z42gXXRfsfWYhJfG7INk2uddSJgRwjyiK/6EVM51W5
   94t8YbsiFE9fYvhlo3+egjTjZxHlPNbOJg57URm4fNCRRlSfGg1/6FeS1
   8xKcrR7TaI5Ekreej/PhRqgXCWK07E8/6vPZFzYSUJG/ZyUB5Ofr7vWxF
   4zQMhdPYpvWBdoUs3s6II+h56xvxFuUsIMRgbUTQ+4wNszsC/wt2tCwuy
   8wyOl0WuhbKue8si8V56Da4OmnXoPla2xnn4Vs5XLpS9ZfCZNeMZjGkMb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730070"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730070"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661629"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661629"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 20 Dec 2023 16:17:33 -0800
Subject: [PATCH v5 6/9] cxl/events: Create a CXL event union
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-cxl-cper-v5-6-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
In-Reply-To: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=6738;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=g9zeiQ0wd5i9ymO0m/+melFI97qLH3mOOLksPAT5rTs=;
 b=l1DWhChdMm92ZdaOGwYhwPUUtH5ZGNN3WwqAWSbuTnhrBy39S1ELgQVtc+bOYABJPybaorkZO
 3mEKL2ocCM3AN0x5zk//RogVCA7RAbnbN5W7t8JFX7N104wuBkI74LR
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
index 4c5161896826..06957696247b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -840,26 +840,17 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
+	union cxl_event *evt = &record->event;
 	uuid_t *id = &record->id;
 
-	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID)) {
-		struct cxl_event_gen_media *rec =
-				(struct cxl_event_gen_media *)record;
-
-		trace_cxl_general_media(cxlmd, type, rec);
-	} else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID)) {
-		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
-
-		trace_cxl_dram(cxlmd, type, rec);
-	} else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID)) {
-		struct cxl_event_mem_module *rec =
-				(struct cxl_event_mem_module *)record;
-
-		trace_cxl_memory_module(cxlmd, type, rec);
-	} else {
-		/* For unknown record types print just the header */
-		trace_cxl_generic_event(cxlmd, type, id, record);
-	}
+	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID))
+		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
+	else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID))
+		trace_cxl_dram(cxlmd, type, &evt->dram);
+	else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID))
+		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
+	else
+		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -902,7 +893,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
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
index 312cfa9e0004..89445435303a 100644
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
@@ -235,9 +235,9 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, gen_rec->hdr);
 		memcpy(&__entry->hdr_uuid, uuid, sizeof(uuid_t));
-		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
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


