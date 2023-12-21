Return-Path: <linux-efi+bounces-273-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1D81ABA6
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70F42872CF
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DF5138C;
	Thu, 21 Dec 2023 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhaLfDqG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11380639;
	Thu, 21 Dec 2023 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118284; x=1734654284;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HM/wBx9ZMBQ51wv7WPgVJhsqmvKRB25uMpdYVTWj/TI=;
  b=PhaLfDqG/A+zCzKG1KxKJL39LFfj2wozhewmhg5SHU89Wm22bNDJ3lyf
   oEuHB3mc4NvzSQTt2ayGWbgrDjYWacL3g0270d2IP1mj8rB8NtzUyvBTB
   4inhlld3bIbiIAgFoN8Bg6TSFG38MKpiCodeKP6QyObH8v3mPBjuneDpf
   BvS8ilspADGksY7H6q9hBgHfJww+Egace8P/LmBznpG6EULYNSSDXp/HV
   R3wnPSym1KWGdmZdf1ik4XNwlW2HBIqqO/9I+c3Z9USJKVTaq7Cb2eDZv
   UeKpHU+AeTFSwaPCX++wusstafu4Pf26GZS9CHrDCDXbb+PhE2yl2fgZJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730060"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730060"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661622"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661622"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:39 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 20 Dec 2023 16:17:31 -0800
Subject: [PATCH v5 4/9] cxl/events: Remove passing a UUID to known event
 traces
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-cxl-cper-v5-4-1bb8a4ca2c7a@intel.com>
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
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=5214;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=HM/wBx9ZMBQ51wv7WPgVJhsqmvKRB25uMpdYVTWj/TI=;
 b=yVd9doVY/ccNSQlbCyOmLATwMpEwwucEOQPypuqPnkugbyJWUDwKVSsRiH7fWxwZ7Fyr7G+sk
 vWuleQfX9OJD7HnS7WeHNapPitrwC9yVFmcZSKCXWpTQKwQTXZAm8br
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

The UUID data is redundant in the known event trace types.  The addition
of static defines allows the trace macros to create the UUID data inside
the trace thus removing unnecessary code.

Have well known trace events use static data to set the uuid field based
on the event type.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v5:
New patch
---
 drivers/cxl/core/mbox.c  |  6 +++---
 drivers/cxl/core/trace.h | 28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 1ccc3a56e0af..5f3681de10de 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -846,16 +846,16 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		struct cxl_event_gen_media *rec =
 				(struct cxl_event_gen_media *)record;
 
-		trace_cxl_general_media(cxlmd, type, id, rec);
+		trace_cxl_general_media(cxlmd, type, rec);
 	} else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID)) {
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
-		trace_cxl_dram(cxlmd, type, id, rec);
+		trace_cxl_dram(cxlmd, type, rec);
 	} else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID)) {
 		struct cxl_event_mem_module *rec =
 				(struct cxl_event_mem_module *)record;
 
-		trace_cxl_memory_module(cxlmd, type, id, rec);
+		trace_cxl_memory_module(cxlmd, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(cxlmd, type, id, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 3da16026b8db..312cfa9e0004 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -181,6 +181,7 @@ TRACE_EVENT(cxl_overflow,
  *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
  *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
  *	   pass the dev, log, and CXL event header
+ *	   NOTE: The uuid must be assigned by the specific trace event
  *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
  *
  * See the generic_event tracepoint as an example.
@@ -198,12 +199,11 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_length)					\
 	__field(u8, hdr_maint_op_class)
 
-#define CXL_EVT_TP_fast_assign(cxlmd, l, uuid, hdr)				\
+#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, (uuid), sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
@@ -235,7 +235,8 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, uuid, sizeof(uuid_t));
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
@@ -315,9 +316,9 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 const uuid_t *uuid, struct cxl_event_gen_media *rec),
+		 struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, uuid, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -336,7 +337,8 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, &CXL_EVENT_GEN_MEDIA_UUID, sizeof(uuid_t));
 
 		/* General Media */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -398,9 +400,9 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 const uuid_t *uuid, struct cxl_event_dram *rec),
+		 struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, uuid, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -422,7 +424,8 @@ TRACE_EVENT(cxl_dram,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
 
 		/* DRAM */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -547,9 +550,9 @@ TRACE_EVENT(cxl_dram,
 TRACE_EVENT(cxl_memory_module,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 const uuid_t *uuid, struct cxl_event_mem_module *rec),
+		 struct cxl_event_mem_module *rec),
 
-	TP_ARGS(cxlmd, log, uuid, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -569,7 +572,8 @@ TRACE_EVENT(cxl_memory_module,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, &CXL_EVENT_MEM_MODULE_UUID, sizeof(uuid_t));
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;

-- 
2.43.0


