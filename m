Return-Path: <linux-efi+bounces-227-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D098A81546C
	for <lists+linux-efi@lfdr.de>; Sat, 16 Dec 2023 00:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017D71C23985
	for <lists+linux-efi@lfdr.de>; Fri, 15 Dec 2023 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F018EDF;
	Fri, 15 Dec 2023 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2qKf3KE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDF18EC5;
	Fri, 15 Dec 2023 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682790; x=1734218790;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/ElbTHmh6oagM5IskNKHdwjkZkzuoHneaESCi/RpMN0=;
  b=G2qKf3KEBuz8Ag8Z7O77oeUl2Wtz1cRhuTFtld6RHPwCHezZDL6DvoMO
   7siw6787i7h48Gd6q87JSYAC5Gum2ZIHVvQz3Q0HHuWsbE0th0NSKbDsQ
   46lLiIrMhAnyy2rm3RJjs3c2Y5+d/iQvP0At01rYREUtIju9Zxr9OZw5u
   3dXRt7r6Eh1TUIJuAaOjFIBBWkVrJJ75w96ft0fKyEU+WtiC5BMBpRqAj
   s6fuLBlGHmCniHVpXhKImHTZs0xGsu7auMDufBIC3BIR2E6c/gfoh5zv3
   bU7x/EElmrKxxsn6vKVCn64S/xZKPlhNyOlcPnjyVzK3SqGOREy15UOPu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395079632"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="395079632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="724605082"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="724605082"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.164.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:28 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 15 Dec 2023 15:26:27 -0800
Subject: [PATCH v4 1/7] cxl/trace: Pass uuid explicitly to event traces
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-cxl-cper-v4-1-01b6dab44fcd@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702682786; l=5521;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=/ElbTHmh6oagM5IskNKHdwjkZkzuoHneaESCi/RpMN0=;
 b=MaQIcXVyNlct7h+tBzuRwe0j59XBfIE50v3lrbGwJI9bUCz8eiiP2q3teclbhLsqb+uqP9L0a
 /VbFDn6l1bNARWbh/+3enX0rl0h9HapMZHrLBcGHsG30BdyrHA3Mo+t
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

CXL CPER events are identified by the CPER Section Type GUID. The GUID
correlates with the CXL UUID for the event record. It turns out that a
CXL CPER record is a strict subset of the CXL event record, only the
UUID header field is chopped.

In order to unify handling between native and CPER flavors of CXL
events, prepare the code for the UUID to be passed in rather than
inferred from the record itself.

Later patches update the passed in record to only refer to the common
data between the formats.

Pass the UUID explicitly to each trace event to be able to remove the
UUID from the event structures.

Originally it was desirable to remove the UUID from the well known event
because the UUID value was redundant.  However, the trace API was
already in place.[1]

[1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c  |  8 ++++----
 drivers/cxl/core/trace.h | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..00f429c440df 100644
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
index a0b5819bc70b..3da16026b8db 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
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
+	memcpy(&__entry->hdr_uuid, (uuid), sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
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
2.43.0


