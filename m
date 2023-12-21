Return-Path: <linux-efi+bounces-279-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD681ABB5
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451081F246D1
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC87B654;
	Thu, 21 Dec 2023 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J38KJWBr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92D5CB0;
	Thu, 21 Dec 2023 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118288; x=1734654288;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N2E+XqjGpnp5wSMKK1QhwJx7oXQI3n2Jb8mKT2WB0Jk=;
  b=J38KJWBrKwUAAuAdihCokLofSIbf8qqOPv7OIaIl0UEraPHYQwyAV8Qv
   CsnGzEBkZwH+cdPkO+QHHsgtIoSYco7O8C+eDhqP30pW9Nu9k5IXI8Zgf
   4oxT8IOKlBAYe9RxgjB3WE2BN58PvcGNFUQXzzApboeShQ8GpAeCyuZC3
   vMmz2bPzHbwpEphmNJ+vKV4qmuCgWhd7iSppZD4cggXdsN9wR+lZZBYc2
   kOeRfY8UtS9p9wGyc4uhM0umkDfDPbiR/GrODdiYu92dfwQwoQ8Z+N6Xy
   iY6jGE0UhEk/H73bTA+cXOXOwTQatJ8HpTJYQ04v4jiNER7Keyne3sLYL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730089"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730089"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661638"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661638"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 20 Dec 2023 16:17:36 -0800
Subject: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
In-Reply-To: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=7019;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=N2E+XqjGpnp5wSMKK1QhwJx7oXQI3n2Jb8mKT2WB0Jk=;
 b=t+Uj4uCd8zoHdRNz3XoTEQSndDRLGtOqg9MDncjf36jHTmddMAO3wDdY7qt1VvrKkeEyKGxSx
 K8y8r6AbFgqBzXbrB3PmaUaOZV67ykEVcevs4dF58M3qGUHEuyARiSA
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.

CPER records contain Bus, Device, Function information which can be used
to identify the PCI device which is sending the event.

Change the PCI driver registration to include registration of a CXL
CPER callback to process events through the trace subsystem.

Use new scoped based management to simplify the handling of the PCI
device object.

NOTE this patch depends on Dan's addition of a device guard[1].

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/

---
Changes for v5:
[Smita/djbw: trace a generic UUID if the type is unknown]
[Jonathan: clean up pci and device state error handling]
[iweiny: consolidate the trace function]
---
 drivers/cxl/core/mbox.c   | 49 ++++++++++++++++++++++++++++-----------
 drivers/cxl/cxlmem.h      |  4 ++++
 drivers/cxl/pci.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/cxl-event.h |  1 +
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 06957696247b..b801faaccd45 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -836,21 +836,44 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    const uuid_t *uuid, union cxl_event *evt)
 {
-	union cxl_event *evt = &record->event;
-	uuid_t *id = &record->id;
-
-	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID))
+	switch (event_type) {
+	case CXL_CPER_EVENT_GEN_MEDIA:
 		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-	else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID))
+		break;
+	case CXL_CPER_EVENT_DRAM:
 		trace_cxl_dram(cxlmd, type, &evt->dram);
-	else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID))
+		break;
+	case CXL_CPER_EVENT_MEM_MODULE:
 		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
-	else
-		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
+		break;
+	case CXL_CPER_EVENT_GENERIC:
+	default:
+		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
+		break;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+
+static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+				     enum cxl_event_log_type type,
+				     struct cxl_event_record_raw *record)
+{
+	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
+	const uuid_t *uuid = &record->id;
+
+	if (uuid_equal(uuid, &CXL_EVENT_GEN_MEDIA_UUID))
+		ev_type = CXL_CPER_EVENT_GEN_MEDIA;
+	else if (uuid_equal(uuid, &CXL_EVENT_DRAM_UUID))
+		ev_type = CXL_CPER_EVENT_DRAM;
+	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
+		ev_type = CXL_CPER_EVENT_MEM_MODULE;
+
+	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -961,8 +984,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e5d770e26e02..80076c235073 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..b14237f824cf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -969,6 +970,61 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_cper_event_call(enum cxl_event_type ev_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	enum cxl_event_log_type log_type;
+	struct cxl_dev_state *cxlds;
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
+	if (pdev->driver != &cxl_pci_driver)
+		return;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
+			       &uuid_null, &rec->event);
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
+	rc = cxl_cper_register_callback(cxl_cper_event_call);
+	if (rc)
+		pci_unregister_driver(&cxl_pci_driver);
+
+	return rc;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_callback(cxl_cper_event_call);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 71e3646f7569..17eadee819b6 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -109,6 +109,7 @@ struct cxl_event_record_raw {
 } __packed;
 
 enum cxl_event_type {
+	CXL_CPER_EVENT_GENERIC,
 	CXL_CPER_EVENT_GEN_MEDIA,
 	CXL_CPER_EVENT_DRAM,
 	CXL_CPER_EVENT_MEM_MODULE,

-- 
2.43.0


