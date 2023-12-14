Return-Path: <linux-efi+bounces-211-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039D812471
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 02:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62D11C214A5
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9965B;
	Thu, 14 Dec 2023 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9M5QHgP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05259F5;
	Wed, 13 Dec 2023 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702516812; x=1734052812;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uixc73K3Ph9AEgYbksGkDPEk7Uhh7jGlrJEOveUxU5g=;
  b=a9M5QHgPie8zUmIhyaKHVvkAZ5ZORZo18fIMn41NjtKE7lo7Zl5h5LOY
   fMqx7p7AhVAIbkDlufeND6ljOhN3VtvagK5HYLinLUCTfjR75+4dMuc3x
   9/tOXwRNbsJNBRGgRTCAQzL6b6oZCw7wie2pW+aDpI6PWj+ZURYf1p8Ya
   I7ByzxZTIt3O8A7nkpSYG38PifMUw9Exk1dXuj2WUSM1yI9pCpAFKhx9d
   ZCkpsEl5uEuH+HkP5cAgitHL+ULZ1unr9PHamWRttT2eqWd351Qw66pob
   L+iyVY3G/RvvQmOb+3cQAty4aAPZrvQlHGU3rhNEl4UDPHHTWwWExtB1F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13747621"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="13747621"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767436319"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767436319"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.117.241])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:11 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 13 Dec 2023 17:19:56 -0800
Subject: [PATCH v3 3/7] cxl/events: Create common event UUID defines
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-cxl-cper-v3-3-7fd863dd0d25@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702516806; l=4543;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=uixc73K3Ph9AEgYbksGkDPEk7Uhh7jGlrJEOveUxU5g=;
 b=m9eQKrZCZhbcC0HciRNnP6CsdGQAORvfyQzTqbqm6uqmnFjSumSfF42SOHfQKmIQ2Ri5NsvY6
 I9qUEY9gKT/CORSFHYk+G0Eq7YZXv7WyTYuFtz1zU4lz/KOuQpA5pIf
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Dan points out in review that the cxl_test code could be made better
through the use of UUID's defines rather than being open coded.[1]
Static const variables still need to exist to be passed to the trace
code.

Create UUID defines and use them rather than open coding them.

[1] https://lore.kernel.org/all/65738d09e30e2_45e0129451@dwillia2-xfh.jf.intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v3:
[iweiny: move comments along with defines]
---
 drivers/cxl/core/mbox.c      | 26 +++-----------------------
 drivers/cxl/cxlmem.h         | 24 ++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |  9 +++------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 00f429c440df..be2ad3b6f431 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -836,29 +836,9 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-static const uuid_t gen_media_event_uuid =
-	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
-
-/*
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-static const uuid_t dram_event_uuid =
-	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-static const uuid_t mem_mod_event_uuid =
-	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+static const uuid_t gen_media_event_uuid = CXL_EVENT_GEN_MEDIA_UUID;
+static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
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


