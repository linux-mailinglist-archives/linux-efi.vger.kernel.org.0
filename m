Return-Path: <linux-efi+bounces-215-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79884812477
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 02:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7871C214F7
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 01:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF437F9;
	Thu, 14 Dec 2023 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NV0ZBkIP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D1118;
	Wed, 13 Dec 2023 17:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702516817; x=1734052817;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QabimTFqHHA46EWqIGCooIWwsIn6OStsXBwnDMbb9VI=;
  b=NV0ZBkIPLKQ1ENTVUG7DS47D7VW4I7VhKbbtnfv7Lep/R6s3em6w0yU2
   EdvzLCYsJxtD/JC3LEsui3Dlo/jlI2T//BTVe131AxH/qYGLeTT1QJgct
   7zNtyyXnzd3RnIAcx0Om8NyTK1NylZHt+VuDyATjgUE0DPUycKHR73uFY
   vARhtLLvXgCX1L9NX4XouTLLDymDbVdKpYL90H3PGXpdkVx+VpQId1yl2
   /TcUskmIyBwOMuDK4CYOy7bP8UkkGxebgYu3WBrBuvL+VyJW/OqcvsHn8
   PhMcU3PmqgRdPHwr00qWis4RMP4rwgOfGbDoa0MdQS+23IFaZmeCe3ZQB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13747648"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="13747648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767436355"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767436355"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.117.241])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:16 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 13 Dec 2023 17:20:00 -0800
Subject: [PATCH v3 7/7] cxl/memdev: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-cxl-cper-v3-7-7fd863dd0d25@intel.com>
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
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702516806; l=7003;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=QabimTFqHHA46EWqIGCooIWwsIn6OStsXBwnDMbb9VI=;
 b=10kHk0JItYn9I6Nayz73mW7YHp1JKVzr3DQj8c/fd8u98j1fS/p7cKBkbiaV1bdwWwdVkAMZS
 8h2mIIHmVN1B+u865k0FxoPN7KChJXvsSNqMm3CS8NWtvN1M+kYl4YK
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.

CPER records contain Bus, Device, Function information which can be used
to identify the PCI device which is sending the event.

Change pci driver registration to include registration for a CXL CPER
notifier to process the events through the trace subsystem.

Define and use scoped based management to simplify the handling of the
pci device object.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE this patch depends on Dan's addition of a device guard[1].

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/

Changes for v3:
[djbw: define a __free(pci_dev_put) to release the device automatically]
[djbw: use device guard from Vishal]
[iweiny: delete old notifier block structure]
[iweiny: adjust for new notifier interface]
---
 drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  4 ++++
 drivers/cxl/pci.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h     |  2 ++
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b7efa058a100..c9aa723e3391 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -840,9 +840,30 @@ static const uuid_t gen_media_event_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
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
@@ -965,8 +986,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e5d770e26e02..e7e9508fecac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
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
index 0155fb66b580..638275569d63 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -969,6 +970,58 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_cper_event_call(enum cxl_event_type ev_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	struct cxl_dev_state *cxlds = NULL;
+	enum cxl_event_log_type log_type;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver == &cxl_pci_driver)
+		cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);
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
+	rc = cxl_cper_register_notifier(cxl_cper_event_call);
+	if (rc)
+		pci_unregister_driver(&cxl_pci_driver);
+
+	return rc;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_notifier(cxl_cper_event_call);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..290d0a2651b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
@@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),

-- 
2.43.0


