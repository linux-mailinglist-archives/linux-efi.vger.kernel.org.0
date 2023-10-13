Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCD7C7E36
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjJMGz0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJMGzZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 02:55:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D9BD;
        Thu, 12 Oct 2023 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697180122; x=1728716122;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JQAbTe0ieOadd0hoG/pD/c+KBl0PX6rseZ5XazSEsPQ=;
  b=mBr8tYvyUGSuvMSFc1ZDS7YwKNrJG3O6CyFNVAn4Nis/0aYfWvICqsA4
   504txvlzLK7IuGAP4fFXPUPvsXZrFMEw77K0oUmNvV+LICZyccr0ITDs5
   loeIMtYCZsxWPUdwHPYrf4WzawitEDO1GQnCDTl1PGBxmoFy9QDL+cBFH
   j3u18gJ9XHY7PY/x3HT24lPoYfVaVp4UiQ3m76GQI+/qmYWUIXfy+l6qL
   HI33t6Q6YxZe6eillt4Z3+8yrE8XK534A2icn+t50HbyvKMpo/S5YT/s/
   YTFlXlpBWoBvahxiGI6Gy39zYcx1Z9E90o3O+bNiu5rkY1dR7DNXXs/JH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451596010"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="451596010"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704512902"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="704512902"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.55.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 12 Oct 2023 23:55:20 -0700
Subject: [PATCH RFC 2/2] cxl/memdev: Register for and process CPER events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-2-99ba43f8f770@intel.com>
References: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
In-Reply-To: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
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
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697180119; l=6111;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=JQAbTe0ieOadd0hoG/pD/c+KBl0PX6rseZ5XazSEsPQ=;
 b=tJ8cgVM2yqRPwooLNSeaBEKFjX6JljDnrGlEuxEJX54NEEvMs+pV/k92yVrLcliMFh9wFlVWO
 gtJbsMlpC3EAZ+I1+NVag+KZudkxb3lvDw02V+eawp5nRjJY7DlG+5M
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.

Detect firmware first configuration and register a notifier callback to
process catch records for this memdev.  Process those records destined
for this memdev through the normal trace mechanism.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
RFC comments:
The matching of the CPER event to the MDS is a bit hacky right now and
could probably be much more robust.  But the general approach seems
sound.  Simply register a notifier for each device and when that device
finds a record for itself call the normal trace mechanisms.
---
 drivers/cxl/core/mbox.c |  7 ++---
 drivers/cxl/cxlmem.h    |  5 ++++
 drivers/cxl/pci.c       | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..3a8ce7801e04 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -860,9 +860,9 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    struct cxl_event_record_raw *record)
 {
 	uuid_t *id = &record->hdr.id;
 
@@ -885,6 +885,7 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		trace_cxl_generic_event(cxlmd, type, record);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 				  enum cxl_event_log_type log,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..2b4210c291b9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -477,6 +477,8 @@ struct cxl_memdev_state {
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
 
+	struct notifier_block cxl_cper_nb;
+
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
@@ -863,6 +865,9 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    struct cxl_event_record_raw *record);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..19922e32c098 100644
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
@@ -748,6 +750,70 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+int cxl_cper_event(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct cxl_cper_notifier_data *nd = data;
+	struct cxl_event_record_raw record;
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
+	/*
+	 * UEFI v2.10 defines N.2.14 defines the CXL CPER record as not
+	 * including the uuid field from the CXL record.
+	 *
+	 * Build the record from the UUID passed.
+	 */
+	record = (struct cxl_event_record_raw) {
+		.hdr.id = nd->uuid,
+	};
+	memcpy(&record.hdr.length, &nd->rec->comp_event_log,
+		CPER_CXL_REC_LEN(nd->rec));
+
+	/* ensure record can always handle the full CPER provided data */
+	BUILD_BUG_ON(sizeof(record) <
+		(CPER_CXL_COMP_EVENT_LOG_SIZE + sizeof(record.hdr.id)));
+
+	hdr_flags = get_unaligned_le24(record.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, &record);
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
+	mds->cxl_cper_nb.notifier_call = cxl_cper_event;
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
@@ -758,8 +824,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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

