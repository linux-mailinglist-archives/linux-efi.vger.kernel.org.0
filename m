Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8C7DE745
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKAVLz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344343AbjKAVLx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 17:11:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02F115;
        Wed,  1 Nov 2023 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873106; x=1730409106;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Zo3HeS5u7C3gKkhcg3JU4X4HxmqS88JGyVb/Un7c/rU=;
  b=NvGltRntWkplCqLdhyvJvZNmMg21ZfLRRHZWTn4AiK5yyCBaULwfMJ25
   9Sdl08KwyV3mPcZ2eB+MSaW4RWuspLjV+bjMfcOBYYv0P1QrurCEll8M1
   nLvwCIbkFdukPezZNlc9DGcwzGNZOeNp7r1DpF2QpQ25u+b1jnAzNNvMd
   51paeN748laMs6k/w6aJdiyIMU+L9Qc6iBMj18uK89H6hKzrIrf4sPFy7
   /ySERbTPdSgL3yBg/ogknTJhljxDdXIpmJAxFGmORTZkkkEi+M2zH6lMw
   9ZzX7FeVKf62R51P8sXD2ZDw0Tgpi1T0eXCJ6IaYC0ypbCmpCu0FGHf38
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373625216"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="373625216"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737533785"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="737533785"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.80.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Nov 2023 14:11:20 -0700
Subject: [PATCH RFC v3 3/6] cxl/events: Remove UUID from non-generic event
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v3-3-0189d61f7956@intel.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
In-Reply-To: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698873100; l=8810;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=Zo3HeS5u7C3gKkhcg3JU4X4HxmqS88JGyVb/Un7c/rU=;
 b=8WvyDXqRLM/vjrAqpCaARsk7V18k8GbvohIEyxb6c9u4VJKLNrbAjCl8YC1ZBCR1qcnIDAs/l
 JNbSOo1wQfRAG+cZfxLxi10eiMRS38ODkITy1maDBR3SD7sY0xlrW8v
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI CXL CPER structure does not include the UUID.  Now that the
UUID is only reported in the generic CXL trace event there is no need to
carry the UUID in the structures which could come from CPER records.

Remove the UUID from the event record header.  Retain the UUID for
processing the raw records.  Create dummy structures for creating test
records.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v2:
[iweiny: new patch]
---
 drivers/cxl/core/mbox.c      |   2 +-
 drivers/cxl/core/trace.h     |   2 +-
 include/linux/cxl-event.h    |  10 ++--
 tools/testing/cxl/test/mem.c | 135 +++++++++++++++++++++++++------------------
 4 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..f27c409f9034 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -864,7 +864,7 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
-	uuid_t *id = &record->hdr.id;
+	uuid_t *id = &record->id;
 
 	if (uuid_equal(id, &gen_media_event_uuid)) {
 		struct cxl_event_gen_media *rec =
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 79ed03637604..72c620597708 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -235,7 +235,7 @@ TRACE_EVENT(cxl_generic_event,
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
-		memcpy(&__entry->hdr_uuid, &rec->hdr.id, sizeof(uuid_t));
+		memcpy(&__entry->hdr_uuid, &rec->id, sizeof(uuid_t));
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
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
index 464fc39ed277..85862be00c48 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -330,9 +330,9 @@ static void cxl_mock_event_trigger(struct device *dev)
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
@@ -342,9 +342,9 @@ struct cxl_event_record_raw maint_needed = {
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
@@ -353,64 +353,85 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
-struct cxl_event_gen_media gen_media = {
-	.hdr = {
-		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
-				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
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
+	.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+			0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
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
-		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
-				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
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
+	.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+			0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
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
-		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
-				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
-		.length = sizeof(struct cxl_event_mem_module),
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_mem_module {
+	uuid_t id;
+	struct cxl_event_mem_module rec;
+} __packed;
+
+struct cxl_test_mem_module mem_module = {
+	.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+			0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
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
@@ -432,11 +453,11 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
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
2.41.0

