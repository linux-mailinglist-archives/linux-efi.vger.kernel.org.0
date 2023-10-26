Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327497D8836
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbjJZSWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjJZSWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 14:22:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A51B5;
        Thu, 26 Oct 2023 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698344536; x=1729880536;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aFGHMQZucOpaNQpI8yGfGV/YBqlkB0jG0SYOjReuNm0=;
  b=cA5T0Mqqh2OZhuTqDmXmkHGqvb8lNjxBMOUgtsE3Pn65ydFrwJ6rZyu5
   N7jjUnCKX1ky+2Q6B2DnD8+J+XvxZncTpfDB0kcg+HH67LL2oeQizCHX2
   WLIB3oC8qXPM8bABmOPQVJCT+cjRd53mTidcFfqGdsaDAhOXuQJaIYLrv
   pVPXfeDC3uikTYYNVeX6pjxcLtoibnFOr44EOZRkdSg24dF5DrSlgh8K9
   3d/qOvbO72LA9m5AXbtZg3gnQPS5lbEKqTuy+3A19yiC3xV/5GXVXf2lV
   As2SbRtwxPc6Lu5NUffIwVltR3LPr5lCvYh5URpIYdvJsz6wPMGK42GTQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418733785"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="418733785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825087503"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825087503"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.121.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 26 Oct 2023 11:21:40 -0700
Subject: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
In-Reply-To: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698344500; l=7873;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=aFGHMQZucOpaNQpI8yGfGV/YBqlkB0jG0SYOjReuNm0=;
 b=g6ZBjEoQdn+srl7iOajjcAeD0OF6Rn383oPMz3TzmRC/HoWn+tDXw7bQdDYu7+c5qG+bHDxc+
 BDfmnuBxj/OC2aVZhg5GvT2tQBxL3PD6Kh50LjiMpdHIkdQzZSVL7Zx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  Matching memory
devices to the CPER records can be done via the serial number which is
part of the CPER record header.

Detect firmware first, register a notifier callback for each memdev, and
trace events when they match a device registered.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v1:
[iweiny: adjust to cper_event enum instead of converting guids]
---
 drivers/cxl/core/mbox.c | 45 +++++++++++++++++++++++++-------
 drivers/cxl/cxlmem.h    |  7 +++++
 drivers/cxl/pci.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..3f760d1d21de 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -860,26 +860,51 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    struct cxl_event_record_raw *record,
+			    enum cxl_cper_event cper_event)
 {
-	uuid_t *id = &record->hdr.id;
-
-	if (uuid_equal(id, &gen_media_event_uuid)) {
+	switch (cper_event) {
+	case CXL_CPER_EVENT_GEN_MEDIA: {
 		struct cxl_event_gen_media *rec =
 				(struct cxl_event_gen_media *)record;
 
 		trace_cxl_general_media(cxlmd, type, rec);
-	} else if (uuid_equal(id, &dram_event_uuid)) {
+		break;
+		}
+	case CXL_CPER_EVENT_DRAM: {
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
 		trace_cxl_dram(cxlmd, type, rec);
-	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
+		break;
+		}
+	case CXL_CPER_EVENT_MEM_MODULE: {
 		struct cxl_event_mem_module *rec =
 				(struct cxl_event_mem_module *)record;
 
 		trace_cxl_memory_module(cxlmd, type, rec);
+		break;
+		}
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+
+static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+				     enum cxl_event_log_type type,
+				     struct cxl_event_record_raw *record)
+{
+	uuid_t *id = &record->hdr.id;
+
+	if (uuid_equal(id, &gen_media_event_uuid)) {
+		cxl_event_trace_record(cxlmd, type, record,
+				       CXL_CPER_EVENT_GEN_MEDIA);
+	} else if (uuid_equal(id, &dram_event_uuid)) {
+		cxl_event_trace_record(cxlmd, type, record,
+				       CXL_CPER_EVENT_DRAM);
+	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
+		cxl_event_trace_record(cxlmd, type, record,
+				       CXL_CPER_EVENT_MEM_MODULE);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(cxlmd, type, record);
@@ -991,8 +1016,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..89bd85e7f51c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/efi.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -477,6 +478,8 @@ struct cxl_memdev_state {
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
 
+	struct notifier_block cxl_cper_nb;
+
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
@@ -863,6 +866,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    struct cxl_event_record_raw *record,
+			    enum cxl_cper_event cper_event);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..36d6f03e55de 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -10,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -748,6 +750,69 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct cxl_cper_notifier_data *nd = data;
+	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
+		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
+	};
+	enum cxl_event_log_type log_type;
+	struct cxl_memdev_state *mds;
+	u32 hdr_flags;
+
+	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
+
+	/* Need serial number for device identification */
+	if (!(nd->rec->hdr.validation_bits & CPER_CXL_DEVICE_SN_VALID))
+		return NOTIFY_DONE;
+
+	/* FIXME endianess and bytes of serial number need verification */
+	/* FIXME Should other values be checked? */
+	if (memcmp(&mds->cxlds.serial, &nd->rec->hdr.dev_serial_num,
+		   sizeof(mds->cxlds.serial)))
+		return NOTIFY_DONE;
+
+	/* ensure record can always handle the full CPER provided data */
+	BUILD_BUG_ON(sizeof(record) <
+		(CPER_CXL_COMP_EVENT_LOG_SIZE + sizeof(record.hdr.id)));
+
+	/*
+	 * UEFI v2.10 defines N.2.14 defines the CXL CPER record as not
+	 * including the uuid field.
+	 */
+	memcpy(&record.hdr.length, &nd->rec->comp_event_log,
+		CPER_CXL_REC_LEN(nd->rec));
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(record.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, &record,
+			       nd->cper_event);
+
+	return NOTIFY_OK;
+}
+
+static void cxl_unregister_cper_events(void *_mds)
+{
+	struct cxl_memdev_state *mds = _mds;
+
+	unregister_cxl_cper_notifier(&mds->cxl_cper_nb);
+}
+
+static void register_cper_events(struct cxl_memdev_state *mds)
+{
+	mds->cxl_cper_nb.notifier_call = cxl_cper_event_call;
+
+	if (register_cxl_cper_notifier(&mds->cxl_cper_nb)) {
+		dev_err(mds->cxlds.dev, "CPER registration failed\n");
+		return;
+	}
+
+	devm_add_action_or_reset(mds->cxlds.dev, cxl_unregister_cper_events, mds);
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds)
 {
@@ -758,8 +823,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	 * When BIOS maintains CXL error reporting control, it will process
 	 * event records.  Only one agent can do so.
 	 */
-	if (!host_bridge->native_cxl_error)
+	if (!host_bridge->native_cxl_error) {
+		register_cper_events(mds);
 		return 0;
+	}
 
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)

-- 
2.41.0

