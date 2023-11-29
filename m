Return-Path: <linux-efi+bounces-104-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EC7FDF04
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1393B21321
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C84F89B;
	Wed, 29 Nov 2023 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4tgxvLW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143B194;
	Wed, 29 Nov 2023 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280856; x=1732816856;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UzNYx2klhz/20kKuKajkCuf3Q8j7YQi/dCHkgJunIgs=;
  b=N4tgxvLWFS/g5ZrUCWNkFEb3J09ADLoewOWc11mW1yyXlTf2QMo/Flyg
   oNryQro6yXoZChcyPT3sLBI9AD/XhH7DztqPF+mdLNjTb536Om2MJZq5M
   s62fSlrk6J4mynIfpkbNWaYHDLzVeAiN3BbL4duldvAMgc4oJSTFJm5og
   NAPBv/MrzMTx0a8EZjdldpBzH0o+ucHLLefeCHq1ufXzpKGiZD/j7N75y
   mbogbTl7PhWNE8Kw7Kqxfs/ysNSiFbUDFAkCDuh1sRu1t/bvuGjB6cuYH
   QauGczgylWGN/xTQl5i3wXknC3/mn2PRJuQrSFs1MkAvGCSf45/gzWbSN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457524513"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="457524513"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835096138"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835096138"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.127.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:52 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 29 Nov 2023 10:00:46 -0800
Subject: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
In-Reply-To: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701280847; l=6220;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=UzNYx2klhz/20kKuKajkCuf3Q8j7YQi/dCHkgJunIgs=;
 b=2MmmtkBqgAOA6rAvGpyGOJJZgA5n/0L0n+BXi/du4BLqrcixBKeC9Nkwlc12W9ErGO+wdEdtY
 bPS2fq//WuMAxOJr92jbpIxM+2ItzwI42JhvpVSE9mW4FdPNBOxNrLK
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.
Matching memory devices to the CPER records can be done via Bus, Device,
Function which is part of the CPER record header.

Detect firmware first, register a notifier callback for each memdev, and
trace events when they match the proper device.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  6 +++++
 drivers/cxl/pci.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5ccc3843b736..8a0d4f67540d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -860,9 +860,30 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    union cxl_event *event)
+{
+	switch (event_type) {
+	case CXL_CPER_EVENT_GEN_MEDIA:
+		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
+					&event->gen_media);
+		break;
+	case CXL_CPER_EVENT_DRAM:
+		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
+		break;
+	case CXL_CPER_EVENT_MEM_MODULE:
+		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
+					&event->mem_module);
+		break;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+
+static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+				     enum cxl_event_log_type type,
+				     struct cxl_event_record_raw *record)
 {
 	union cxl_event *evt = &record->event;
 	uuid_t *id = &record->id;
@@ -985,8 +1006,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f0e7ebb84f02..9cb0e3448780 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -481,6 +481,8 @@ struct cxl_memdev_state {
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
 
+	struct notifier_block cxl_cper_nb;
+
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
@@ -778,6 +780,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
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
index 0155fb66b580..ec65c11baf17 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -741,6 +742,59 @@ static bool cxl_event_int_is_fw(u8 setting)
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
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
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
@@ -751,8 +805,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
2.42.0


