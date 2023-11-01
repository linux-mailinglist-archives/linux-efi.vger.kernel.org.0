Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602487DE748
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 22:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKAVL5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbjKAVLy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 17:11:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE39F;
        Wed,  1 Nov 2023 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873111; x=1730409111;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R14xiT6/6E/eZD3s9rwT23M0l2D/qfY75h+6Vek5I+o=;
  b=lZNDWbYKZ1rkfvYee3y+0JzgC5kNdrLPfKSAUrQYrSqjZZJ6VSq67zYs
   w48hkWVJDoipbdaskrzA41PXQW06NtkTrE6NkVxjkfD9WBDj6OTYuiy9/
   IZ/s/+DTeHfpsgInrYqdclByiJaI2L2ukEM+c7yCpOL3rMKFJ6ytS2dHq
   DiS2oQDyL6Xj7WhInoOdFW+mwUjRerk+5pqZKPT9kfJqR9Dy6CvH5U6XL
   DDs8FwDwY6ycMPaPgrZ4uzdn7oNYSICc1sY38PwLD7TekiG8FwAYx3f6W
   2sunGFLs2C4UQcK51cUYKHnmFafgNCyCuMRLHtqeC8jZQQbh42nEZpUJH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10120118"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="10120118"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092482764"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1092482764"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.80.64])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Nov 2023 14:11:23 -0700
Subject: [PATCH RFC v3 6/6] cxl/memdev: Register for and process CPER
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v3-6-0189d61f7956@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698873100; l=7182;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=R14xiT6/6E/eZD3s9rwT23M0l2D/qfY75h+6Vek5I+o=;
 b=ZvU8BEBgSw2EE4I/dsmpKcYexbPuPDrVi/N6sbIyqW1nYtzOoU8e2SMXEiha8n0wbnxbilfWG
 +Qvi2C4+hw9CxzNKHsM5GWsuehfbwW4RNgKpSH9FktFjDz04+hOA9qq
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

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  Matching memory
devices to the CPER records can be done via Bus, Device, Function which
is part of the CPER record header.

Detect firmware first, register a notifier callback for each memdev, and
trace events when they match the proper device.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v2:
[smita/djbw: use BDF not serial number for memdev ID]
[smita: eliminate memcpy]
[djbw: adjust to new structures]
[iweiny: fix 0day errors]

Changes from RFC v1:
[iweiny: adjust to cper_event enum instead of converting guids]
---
 drivers/cxl/core/mbox.c | 42 ++++++++++++++++++++++++++---------
 drivers/cxl/cxlmem.h    |  6 +++++
 drivers/cxl/pci.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bb40b844e3bd..b949abb1b765 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -860,22 +860,44 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    union cxl_event *event)
 {
-	union cxl_event *evt = &record->event;
+	switch (event_type) {
+	case CXL_CPER_EVENT_GEN_MEDIA:
+		trace_cxl_general_media(cxlmd, type, &event->gen_media);
+		break;
+	case CXL_CPER_EVENT_DRAM:
+		trace_cxl_dram(cxlmd, type, &event->dram);
+		break;
+	case CXL_CPER_EVENT_MEM_MODULE:
+		trace_cxl_memory_module(cxlmd, type, &event->mem_module);
+		break;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+
+static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+				     enum cxl_event_log_type type,
+				     struct cxl_event_record_raw *record)
+{
+	enum cxl_event_type event_type;
 	uuid_t *id = &record->id;
 
 	if (uuid_equal(id, &gen_media_event_uuid)) {
-		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
+		event_type = CXL_CPER_EVENT_GEN_MEDIA;
 	} else if (uuid_equal(id, &dram_event_uuid)) {
-		trace_cxl_dram(cxlmd, type, &evt->dram);
+		event_type = CXL_CPER_EVENT_DRAM;
 	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
-		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
+		event_type = CXL_CPER_EVENT_MEM_MODULE;
 	} else {
-		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
+		trace_cxl_generic_event(cxlmd, type, id, &record->event.generic);
+		return;
 	}
+
+	cxl_event_trace_record(cxlmd, type, event_type, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -986,8 +1008,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d694820ce8f5..b85cbf421cf4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -478,6 +478,8 @@ struct cxl_memdev_state {
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
 
+	struct notifier_block cxl_cper_nb;
+
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
@@ -775,6 +777,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    union cxl_event *event);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..37add91068c0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -748,6 +749,60 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	struct cxl_cper_notifier_data *nd = data;
+	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
+	enum cxl_event_log_type log_type;
+	struct cxl_memdev_state *mds;
+	struct cxl_dev_state *cxlds;
+	struct pci_dev *pdev;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
+
+	/* PCI_DEVFN() would require 2 extra bit shifts; skip those */
+	devfn = (device_id->slot_num & 0xfff8) | (device_id->func_num & 0x07);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+	cxlds = pci_get_drvdata(pdev);
+	if (cxlds != &mds->cxlds) {
+		pci_dev_put(pdev);
+		return NOTIFY_DONE;
+	}
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(nd->rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, nd->event_type,
+			       &nd->rec->event);
+	pci_dev_put(pdev);
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
@@ -758,8 +813,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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

