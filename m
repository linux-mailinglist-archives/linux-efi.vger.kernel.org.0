Return-Path: <linux-efi+bounces-11-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5537E742B
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 23:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ECF280FE6
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6338FA1;
	Thu,  9 Nov 2023 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRnroKXb"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE938FA8;
	Thu,  9 Nov 2023 22:07:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C073C03;
	Thu,  9 Nov 2023 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567641; x=1731103641;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sQT7AHzTpN1glfVUujcNOKHJcJFcMz5m4cRJCrQpzoI=;
  b=gRnroKXbE+QqHPPoWAIDYPFDYsoX8Pv4gppEG5qCv2WMJvo1fQ22XN7l
   JbIKkbeySR23hMGV30BQCdGGSq4OYhWTexbFsRR4L/MYERdQBKFNFq3IY
   VbwM6/sCIOeTMt/9fMGmemLZ5xUFUaQbw70PZQHiKoxXzOe61kvzkD/2E
   T+i4nZxCJSFIqb/9jq7Q1T7hPja/GlsywJelhp6EAf4FYcsK0zPd3IVv1
   jR+L48HmF0OZpK4Nx13FO4GOGwknMKaO97JxoO5F0EHSsENSekq2i9KiM
   hzmsHcZ8BN1Qv8opyWJ9M7CM6yZhmNk6Xc0K+HeW0iZdyv8E7k9fRR0VO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124163"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453299"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453299"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:20 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 09 Nov 2023 14:07:14 -0800
Subject: [PATCH RFC v4 1/6] cxl/trace: Pass uuid explicitly to event traces
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v4-1-47bb901f135e@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=6076;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=sQT7AHzTpN1glfVUujcNOKHJcJFcMz5m4cRJCrQpzoI=;
 b=zpckfLOets+inAFVIk0gPUjWyBgFEqtXNeC1XPcFJDmuBclOCBHKBraxtfv882K/edd0EP0YA
 Tmsr1CHbwN/C1vdqcWCjI/21j9yKodIApqlwazXZr6J+uEzA2WxoYU9
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

CPER CXL events do not have a UUID associated with them.  It is
desirable to share event structures between the CPER CXL event and the
CXL event log events.

Pass the UUID explicitly to each trace event to be able to remove the
UUID from the event structures.

Originally it was desirable to remove the UUID from the well known event
because the UUID value was redundant.  However, the trace API was
already in place.[1]

[1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC V3:
[iweiny: drop remove uuid patch; replaced it with this one]
---
 drivers/cxl/core/mbox.c  |  8 ++++----
 drivers/cxl/core/trace.h | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..43aad71810e2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -870,19 +870,19 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		struct cxl_event_gen_media *rec =
 				(struct cxl_event_gen_media *)record;
 
-		trace_cxl_general_media(cxlmd, type, rec);
+		trace_cxl_general_media(cxlmd, type, id, rec);
 	} else if (uuid_equal(id, &dram_event_uuid)) {
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
-		trace_cxl_dram(cxlmd, type, rec);
+		trace_cxl_dram(cxlmd, type, id, rec);
 	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
 		struct cxl_event_mem_module *rec =
 				(struct cxl_event_mem_module *)record;
 
-		trace_cxl_memory_module(cxlmd, type, rec);
+		trace_cxl_memory_module(cxlmd, type, id, rec);
 	} else {
 		/* For unknown record types print just the header */
-		trace_cxl_generic_event(cxlmd, type, record);
+		trace_cxl_generic_event(cxlmd, type, id, record);
 	}
 }
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..2aef185f4cd0 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -189,7 +189,7 @@ TRACE_EVENT(cxl_overflow,
 	__string(memdev, dev_name(&cxlmd->dev))			\
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
-	__field_struct(uuid_t, hdr_uuid)			\
+	__field_struct(uuid_t, uuid)				\
 	__field(u64, serial)					\
 	__field(u32, hdr_flags)					\
 	__field(u16, hdr_handle)				\
@@ -198,12 +198,12 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_length)					\
 	__field(u8, hdr_maint_op_class)
 
-#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
+#define CXL_EVT_TP_fast_assign(cxlmd, l, uuid, hdr)				\
 	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
+	memcpy(&__entry->uuid, (uuid), sizeof(uuid_t));				\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
@@ -217,7 +217,7 @@ TRACE_EVENT(cxl_overflow,
 		"maint_op_class=%u : " fmt,					\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
-		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
+		__entry->hdr_timestamp, &__entry->uuid, __entry->hdr_length,	\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
 		##__VA_ARGS__)
@@ -225,9 +225,9 @@ TRACE_EVENT(cxl_overflow,
 TRACE_EVENT(cxl_generic_event,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_record_raw *rec),
+		 const uuid_t *uuid, struct cxl_event_record_raw *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -235,7 +235,7 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
@@ -315,9 +315,9 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_gen_media *rec),
+		 const uuid_t *uuid, struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -336,7 +336,7 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* General Media */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -398,9 +398,9 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_dram *rec),
+		 const uuid_t *uuid, struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -422,7 +422,7 @@ TRACE_EVENT(cxl_dram,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* DRAM */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -547,9 +547,9 @@ TRACE_EVENT(cxl_dram,
 TRACE_EVENT(cxl_memory_module,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_mem_module *rec),
+		 const uuid_t *uuid, struct cxl_event_mem_module *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -569,7 +569,7 @@ TRACE_EVENT(cxl_memory_module,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;

-- 
2.41.0


