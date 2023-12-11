Return-Path: <linux-efi+bounces-181-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDF80DEB6
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316DA2825BC
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748655C3D;
	Mon, 11 Dec 2023 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRYNUr79"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950DE4;
	Mon, 11 Dec 2023 14:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335470; x=1733871470;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Wh6w+U6hISsmCWTf+hNF1aRXAEAgHGQkwXc7Og8WW4g=;
  b=QRYNUr79B1IuuPawSPEg44ZLiVGrFVYEho/kjyHTE51nlrp9T7qAYByL
   jFw0WVosYRqVIDmWZwdB+HxWE48PqacD+ph4tvBj8akLO8x4sYerGAadW
   yKmxzen51bT4Rgis91Y8BnD55XCyEc837/Y8Yht5w5CSwtPOrZGhBQm3U
   0JxHGZPt0zQyMvoi0ESvImS89MSyIIN4Xe9G1z02O/Yila8QGgGyPjB2y
   JR93m/ozix3PCF0f/hUphwr4gkgB+RbqeU8OH7Iu/LGyWJCc0MYN7qAYb
   caJNzPt/Rc7buaaa2W4TlkK3rxt7LaD8xAg/WDcnVA+zfIup7NTEIKXkI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084372"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513485"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513485"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:48 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 11 Dec 2023 14:57:45 -0800
Subject: [PATCH v2 5/7] cxl/events: Create a CXL event union
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-5-c116900ba658@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335463; l=6756;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=Wh6w+U6hISsmCWTf+hNF1aRXAEAgHGQkwXc7Og8WW4g=;
 b=+zi64UWodIRtLcj1EnrLRvLy7cHQEJ/kYwNlTmmdhswnIp22zWfWChsl8Jcj9Sc9nJ/j9NXiJ
 kBINR8yOHppDpVOCtp4ecWsz/sF4dSlNNbqX8joCYNwuAzGeMYmox33
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

The CXL CPER and event log records share everything but a UUID/GUID in
their structures.

Define a cxl_event union without the UUID/GUID to be shared between the
CPER and event log record formats.  Adjust the code to use this union.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
[iweiny: ensure event union is packed]
---
 drivers/cxl/core/mbox.c      | 32 +++++++++++++-------------------
 drivers/cxl/core/trace.h     |  8 ++++----
 include/linux/cxl-event.h    | 23 +++++++++++++++++------
 tools/testing/cxl/test/mem.c | 31 ++++++++++++++++++-------------
 4 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f4d82e29435d..a67161f8764a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -858,26 +858,17 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
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
@@ -920,7 +911,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
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
index 68973a101a75..3e09f2f2d7df 100644
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


