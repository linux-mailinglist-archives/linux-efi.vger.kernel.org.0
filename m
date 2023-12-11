Return-Path: <linux-efi+bounces-183-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914180DEB9
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BB728265B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC756460;
	Mon, 11 Dec 2023 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSD4bYCx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD04111;
	Mon, 11 Dec 2023 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335473; x=1733871473;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IJfx1gYDZ0UHGe7QHcNCiqVNAiyyHnr8dAG7AlR/pnw=;
  b=KSD4bYCx/9LK/OfHIlYmdKHO3plWjH1NumDZvpuOJOwBEM04/p11JOO+
   H3M6OKJOpEsSboSR0oTtcrYYP5OCs36cQtiC+8uRP1WB/2k7PZpUcQcRf
   DEhh6C62byPRR5/Xf6rDPcj3Mq/mxfEU+YLZcPfQyOeUmbpxAFtNKCiEA
   shDD8B0saYZKPcx54TokhM1UdCuXN8h0p8nLWGQimbcetPvHs6HcT7cq/
   je/jsTKHXHbPMSsdWjSA2YWHnk8RZ/aQKbi6pMzI9SzktX8NUhXVLC9Nd
   dOerGg4gOz4hb0qZOPAV7y79LLxZ1TWj6y14EZMkSyc5pqgJvgFLoMxiH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084385"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513499"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513499"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:51 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 11 Dec 2023 14:57:47 -0800
Subject: [PATCH v2 7/7] cxl/memdev: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-7-c116900ba658@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335463; l=5631;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=IJfx1gYDZ0UHGe7QHcNCiqVNAiyyHnr8dAG7AlR/pnw=;
 b=rPBSiaLPH47p8XVnoFkTEIt4jVBqca/v7FGqeWyosJkaJgA92CR9n6phEo/YIhcrVVgY8e81b
 Jc7a0JqI5PKCD6tv82ivcjUIAowgQ108mUbsv6xlM7imcOGcKohQ553
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.

CPER records contain Bus, Device, Function information which can be used
to identify the PCI device which is sending the event.

Change pci driver registration to include registration for a CXL CPER
callback to process the events through the trace subsystem.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
[djbw: use single registration function]
---
 drivers/cxl/core/mbox.c | 31 ++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  6 ++++++
 drivers/cxl/pci.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a67161f8764a..da262bbc3519 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -854,9 +854,30 @@ static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
  */
 static const uuid_t mem_mod_event_uuid = CXL_EVENT_MEM_MODULE_UUID;
 
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
@@ -979,8 +1000,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e5d770e26e02..7a891b4641cc 100644
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
@@ -802,6 +804,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
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
index 0155fb66b580..30a98399d013 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -969,6 +970,55 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_cper_event_call(struct cxl_cper_event_data *ev_data)
+{
+	struct cper_cxl_event_devid *device_id = &ev_data->rec->hdr.device_id;
+	struct cxl_dev_state *cxlds = NULL;
+	enum cxl_event_log_type log_type;
+	struct pci_dev *pdev;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+
+	guard(mutex)(&pdev->dev.mutex);
+	if (pdev->driver == &cxl_pci_driver)
+		cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		goto out;
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(ev_data->rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_data->event_type,
+			       &ev_data->rec->event);
+out:
+	pci_dev_put(pdev);
+}
+
+static int __init cxl_pci_driver_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&cxl_pci_driver);
+	if (rc)
+		return rc;
+
+	cxl_cper_register_notifier(cxl_cper_event_call);
+	return 0;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_notifier();
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);

-- 
2.43.0


