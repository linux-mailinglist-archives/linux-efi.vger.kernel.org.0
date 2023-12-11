Return-Path: <linux-efi+bounces-179-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1580DEB5
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC3E2825FF
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0E56440;
	Mon, 11 Dec 2023 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbUObPu0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66DC2;
	Mon, 11 Dec 2023 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335468; x=1733871468;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CwTPlAF0ArYqx1stByrQ0oJMumbFJaMi/41hrj9BSwg=;
  b=YbUObPu0F9QFwsjGenHvTUVThuaOT6FhJdMNmHrPiHuJkbOM7a1el+d+
   tyn6IAM4GoSEjb0361JIXFQs+LLRRdu5c7HGL0UW7Xkv2W7qZrrCsGxjP
   dp14TcXsXZo55KvPr7ONAElzM1M0dqFfIJrffqCXuHNiI9o1L0wypXx4U
   Feb1LzXQi39zCF/q5SWq0HFbpXNqkCcaQ0HMU6AF7jipRYKEYQMCmGWLM
   s9y1zJwsoF5gh4ovHqwvX7xyxAbB953M4wZeCg1Un7VAhIsz7XXTYuVY3
   kv8JJE0EVYg2tDAIE7rHy7l+bJQdpom8/txXhWJMjlUZ8hOVsnaQ5g6S3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084359"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084359"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513475"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513475"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:46 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 11 Dec 2023 14:57:43 -0800
Subject: [PATCH v2 3/7] cxl/events: Create common event UUID defines
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-3-c116900ba658@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335463; l=4420;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=CwTPlAF0ArYqx1stByrQ0oJMumbFJaMi/41hrj9BSwg=;
 b=o0Ieh3Kal1Q09YGZMQy1YKETRRVXqb1FbmXwJFUOaFYfmfgYe1zsLcXP/quFJ0/LLr6uriujd
 MAdFyFhEHGNCejH+EOmouUvHlPF0Flbb2jvH930whS2We5mZuX7Q3hs
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Dan points out in review that the cxl_test code could be made better
through the use of UUID's defines rather than being open coded.[1]
Static const variable still need to exist to be passed to the trace
code.

Create UUID defines and use them rather than open coding them.

[1] https://lore.kernel.org/all/65738d09e30e2_45e0129451@dwillia2-xfh.jf.intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
new patch for v2:
---
 drivers/cxl/core/mbox.c      | 12 +++---------
 drivers/cxl/cxlmem.h         | 24 ++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |  9 +++------
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 00f429c440df..6866fb403fa1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -840,25 +840,19 @@ EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
  */
-static const uuid_t gen_media_event_uuid =
-	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
+static const uuid_t gen_media_event_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 
 /*
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-static const uuid_t dram_event_uuid =
-	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
+static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
 
 /*
  * Memory Module Event Record
  * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
  */
-static const uuid_t mem_mod_event_uuid =
-	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+static const uuid_t mem_mod_event_uuid = CXL_EVENT_MEM_MODULE_UUID;
 
 static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f0e7ebb84f02..e5d770e26e02 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -580,6 +580,30 @@ struct cxl_mbox_identify {
 	u8 qos_telemetry_caps;
 } __packed;
 
+/*
+ * General Media Event Record UUID
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MEDIA_UUID					\
+       UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
+                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
+
+/*
+ * DRAM Event Record UUID
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CXL_EVENT_DRAM_UUID						\
+       UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
+                 0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
+
+/*
+ * Memory Module Event Record UUID
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CXL_EVENT_MEM_MODULE_UUID					\
+       UUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
+                 0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
+
 /*
  * Get Event Records output payload
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ee61fa3a2411..5a95b04b329a 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -362,8 +362,7 @@ struct cxl_event_record_raw hardware_replace = {
 
 struct cxl_event_gen_media gen_media = {
 	.hdr = {
-		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
-				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+		.id = CXL_EVENT_GEN_MEDIA_UUID,
 		.length = sizeof(struct cxl_event_gen_media),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
 		/* .handle = Set dynamically */
@@ -380,8 +379,7 @@ struct cxl_event_gen_media gen_media = {
 
 struct cxl_event_dram dram = {
 	.hdr = {
-		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
-				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+		.id = CXL_EVENT_DRAM_UUID,
 		.length = sizeof(struct cxl_event_dram),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
 		/* .handle = Set dynamically */
@@ -400,8 +398,7 @@ struct cxl_event_dram dram = {
 
 struct cxl_event_mem_module mem_module = {
 	.hdr = {
-		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
-				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+		.id = CXL_EVENT_MEM_MODULE_UUID,
 		.length = sizeof(struct cxl_event_mem_module),
 		/* .handle = Set dynamically */
 		.related_handle = cpu_to_le16(0),

-- 
2.43.0


