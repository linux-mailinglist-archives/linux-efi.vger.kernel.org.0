Return-Path: <linux-efi+bounces-278-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671B81ABB2
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12348B24AC0
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351A639;
	Thu, 21 Dec 2023 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhxiK8gQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D70290E;
	Thu, 21 Dec 2023 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118286; x=1734654286;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zIWhIRcV76GfackzOVRO6PLFxmhAI6EHp2TzwnX1E/4=;
  b=GhxiK8gQy+GPFb6XHVB1WlGqbkxOYNGGD8wrBCWivGe+S8Fu3rTOu4bb
   2vtlIfTUtN+TdZHQmpWbzwdLVvxIt2G0gisy/XqUOm0V8GNOoecoDhKdj
   fiE9L3TcKrVPE0ZVtjzWRUdFTSApKivsRdj7r4Ei7eT5XtxgOT+XLfPqt
   dDwZDRdYsOcUkbFDhjozjghG986JynBPTFOJq5AP06OFJXeLm2G7jNpF+
   6OccJXjZNo9Adprc5YwNlv4ffB4tfYpFQbf9t8xetIRWVAGwFtg7rfdEh
   xIVg7nl2rte+W9mcknckBbvX+BqEW1NpIXUJflbiyixFk99rm87R2xg6r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730075"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730075"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661632"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661632"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 20 Dec 2023 16:17:34 -0800
Subject: [PATCH v5 7/9] acpi/ghes: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-cxl-cper-v5-7-1bb8a4ca2c7a@intel.com>
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
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=6682;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=zIWhIRcV76GfackzOVRO6PLFxmhAI6EHp2TzwnX1E/4=;
 b=kzwveYs9u8kMzJVr08jIAxsoGQU5jtLN8qMJHQByo21XnjKJy4fbZJITYT/sWD9zYjWYJOi9y
 kJssL1T9j9uCjg4bVPugooEY0vQrFYPeAaWA6WUOEShWTpPB8fULSx3
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

BIOS can configure memory devices as firmware first.  This will send CXL
events to the firmware instead of the OS.  The firmware can then send
these events to the OS via UEFI.

UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
format for CXL Component Events.  The format is mostly the same as the
CXL Common Event Record Format.  The difference is the use of a GUID in
the Section Type rather than a UUID as part of the event itself.

Add GHES support to detect CXL CPER records and call a registered
callback with the event.

A notifier chain was considered for the callback but the complexity did
not justify the use case as only the CXL subsystem requires this event.
Enforce that only one callback can be registered at any time.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Ard, Due to Dan's feedback[1] the code is moved to ghes which is
entirely in Rafael's subsystem.  That said I have left you on the CC so
you know what is going on.

Changes for v5
[Smita/djbw: move section type parsing and callback to ghes_do_proc()]
[Smita/djbw: Fix __packed usage]
[djbw/Jonathan: s/notifier/callback/]
[Jonathan: fix typo]
[iweiny: Eliminate parsing the section type a 2nd time]
[iweiny: update error messages]

[1] https://lore.kernel.org/all/6580b21723b2c_269bd294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
---
 drivers/acpi/apei/ghes.c  | 88 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h | 50 +++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 63ad0541db38..aed465d2fd68 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
+#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -657,6 +658,78 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+/*
+ * Only a single callback can be registered for CXL CPER events.
+ */
+static DECLARE_RWSEM(cxl_cper_rw_sem);
+static cxl_cper_callback cper_callback;
+
+/* CXL Event record UUIDs are formated as GUIDs and reported in section type */
+
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
+	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
+
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CPER_SEC_CXL_DRAM_GUID						\
+	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CPER_SEC_CXL_MEM_MODULE_GUID					\
+	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
+
+static void cxl_cper_post_event(enum cxl_event_type event_type,
+				struct cxl_cper_event_rec *rec)
+{
+	if (rec->hdr.length <= sizeof(rec->hdr) ||
+	    rec->hdr.length > sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
+		       rec->hdr.length);
+		return;
+	}
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "CXL CPER invalid event\n");
+		return;
+	}
+
+	guard(rwsem_read)(&cxl_cper_rw_sem);
+	if (cper_callback)
+		cper_callback(event_type, rec);
+}
+
+int cxl_cper_register_callback(cxl_cper_callback callback)
+{
+	guard(rwsem_write)(&cxl_cper_rw_sem);
+	if (cper_callback)
+		return -EINVAL;
+	cper_callback = callback;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
+
+int cxl_cper_unregister_callback(cxl_cper_callback callback)
+{
+	guard(rwsem_write)(&cxl_cper_rw_sem);
+	if (callback != cper_callback)
+		return -EINVAL;
+	cper_callback = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -690,6 +763,21 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev);
+		}
+		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+		}
+		else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+		}
+		else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 18dab4d90dc8..71e3646f7569 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -108,4 +108,54 @@ struct cxl_event_record_raw {
 	union cxl_event event;
 } __packed;
 
+enum cxl_event_type {
+	CXL_CPER_EVENT_GEN_MEDIA,
+	CXL_CPER_EVENT_DRAM,
+	CXL_CPER_EVENT_MEM_MODULE,
+};
+
+#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
+#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
+#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
+struct cxl_cper_event_rec {
+	struct {
+		u32 length;
+		u64 validation_bits;
+		struct cper_cxl_event_devid {
+			u16 vendor_id;
+			u16 device_id;
+			u8 func_num;
+			u8 device_num;
+			u8 bus_num;
+			u16 segment_num;
+			u16 slot_num; /* bits 2:0 reserved */
+			u8 reserved;
+		} __packed device_id;
+		struct cper_cxl_event_sn {
+			u32 lower_dw;
+			u32 upper_dw;
+		} __packed dev_serial_num;
+	} __packed hdr;
+
+	union cxl_event event;
+} __packed;
+
+typedef void (*cxl_cper_callback)(enum cxl_event_type type,
+				  struct cxl_cper_event_rec *rec);
+
+#ifdef CONFIG_ACPI_APEI_GHES
+int cxl_cper_register_callback(cxl_cper_callback callback);
+int cxl_cper_unregister_callback(cxl_cper_callback callback);
+#else
+static inline int cxl_cper_register_callback(cxl_cper_callback callback)
+{
+	return 0;
+}
+
+static inline int cxl_cper_unregister_callback(cxl_cper_callback callback)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */

-- 
2.43.0


