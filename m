Return-Path: <linux-efi+bounces-16-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABED7E7431
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 23:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F50C2816FF
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76238FA1;
	Thu,  9 Nov 2023 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsVIttZh"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902B38FA7;
	Thu,  9 Nov 2023 22:07:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658C386A;
	Thu,  9 Nov 2023 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567649; x=1731103649;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KhPyMx3hNg9FHHyBj/Cc6rSLoReQOrKtjb51FZZ8nHg=;
  b=CsVIttZh+nUBHv2QeJ8RU9dYb+m/0kA8q7nLnP0uKajzGGLrAJH7zfSn
   nzzeEq2TyqnxWx7LGBx3EGcqLDtVpb0e84DwvzMDsyz+9/gcgjqicYPIr
   pCN2dH7iuq/YD8wCqhr75mO+MfsLsv2UYVVsF6qVVk1UOkJzim4rIoEms
   K9/kStkLpA9E1byARCljAaC0J9lLGpcxGDzm1Zhfg4zQIxmOiQkliClM/
   swNL2DrJa2CfjBGxOM7DwbgmUpWN1y5IqzAZb3nKsl5ruXU50gcHadCtZ
   8lQ5BGtGtY1Zx4ysli5MSozQkW+nbKYmXjBHlacRtReHROu7mmSzwH+wj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124191"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453332"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453332"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:28 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 09 Nov 2023 14:07:19 -0800
Subject: [PATCH RFC v4 6/6] cxl/memdev: Register for and process CPER
 events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v4-6-47bb901f135e@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=6559;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=KhPyMx3hNg9FHHyBj/Cc6rSLoReQOrKtjb51FZZ8nHg=;
 b=rQp+YTv/A3nh8IyZeA8DK2ijBDrs90ptbPWe4RjTXwQK7G3jr62GHxLr+fNBZbOjaYs1noLjd
 XyVau0HBm0EADD9jkEa1ZMEMNHw+3g5uo2R6HKbJQ0BoUEBat6OjySP
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
Changes from RFC v3:
[smita: use PCI_DEVFN()]
[iweiny: put uuid back in]

Changes from RFC v2:
[smita/djbw: use BDF not serial number for memdev ID]
[smita: eliminate memcpy]
[djbw: adjust to new structures]
[iweiny: fix 0day errors]

Changes from RFC v1:
[iweiny: adjust to cper_event enum instead of converting guids]
---
 drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  6 +++++
 drivers/cxl/pci.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ac44f3659d84..7c8691e392ae 100644
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
index 44a21ab7add5..09d9e060f0f2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -748,6 +749,59 @@ static bool cxl_event_int_is_fw(u8 setting)
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
@@ -758,8 +812,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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


