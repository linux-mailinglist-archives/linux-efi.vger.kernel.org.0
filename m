Return-Path: <linux-efi+bounces-15-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF67E7430
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A837F2814D8
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933138FA2;
	Thu,  9 Nov 2023 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7Q1ReuL"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FD38FA5;
	Thu,  9 Nov 2023 22:07:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7930E4211;
	Thu,  9 Nov 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567648; x=1731103648;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=89P0Gz+OZyaC0SIBn7fHkxw5FwBBiLp9OdjNEacCe4g=;
  b=n7Q1ReuL2kUUt3MKY668AWaFoG+/RoMu3NPNdPYfOcZiHd9V6091R8/k
   MCYFyT6y4BpzV58ck6pv74aYLciVwLzwoRxd62XfUQa9QbCtS7GiDjgtD
   9Za9BEoviJ/MTkP2mkMB/vuuJPPu/nwdxHHccNTkvBH+sm/6eEsmKy21B
   2HvNF1svVSynNAM82JF4WizhW5mEOt4TNQYeacP2ZzB8PRiWT9c6UkN+p
   yCUKBtunxAJTA/gKd2qhy6coTNSGL7FyCCKfUEXeA7AEvG7taAKTDNjoD
   itgcvTZCwInB/tC5hNjgRFA9MgSUhy4/hejabhVzq3mOTefvG744ULDZz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124186"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453323"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453323"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:27 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 09 Nov 2023 14:07:18 -0800
Subject: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=7444;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=89P0Gz+OZyaC0SIBn7fHkxw5FwBBiLp9OdjNEacCe4g=;
 b=t3jxMCykNFhGitJ1m0i0rNakizVn7+Lkqu90sXn24kEsg5nmI34109PJJ8GeITnL65e/AM8v/
 yXxPL4dh/rQA3WIQRjG4ncX4Jag4R1BiIuP2EXjsM9wk48vvHR4g87c
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

BIOS can configure memory devices as firmware first.  This will send CXL
events to the firmware instead of the OS.  The firmware can then send
these events to the OS via UEFI.

UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
format for CXL Component Events.  The format is mostly the same as the
CXL Common Event Record Format.  The difference is a GUID is used in
the Section Type to identify the event type.

Add EFI support to detect CXL CPER records and call a notifier chain
with the record data blobs to be processed by the CXL code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v3
[Smita: ensure cper_cxl_event_rec is packed]

Changes from RFC v2
[djbw: use common event structures]
[djbw: remove print in core cper code]
[djbw: export register call as NS_GPL]
[iweiny: fix 0day issues]

Changes from RFC v1
[iweiny: use an enum for know record types and skip converting GUID to UUID]
[iweiny: commit to the UUID not being part of the event record data]
[iweiny: use defines for GUID definitions]
---
 drivers/firmware/efi/cper.c     | 15 +++++++++++++
 drivers/firmware/efi/cper_cxl.c | 40 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++++++
 include/linux/cxl-event.h       | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..3d0b60144a07 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -22,6 +22,7 @@
 #include <linux/aer.h>
 #include <linux/printk.h>
 #include <linux/bcd.h>
+#include <linux/cxl-event.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 #include "cper_cxl.h"
@@ -607,6 +608,20 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE)) {
+		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
+
+		if (rec->hdr.length <= sizeof(rec->hdr))
+			goto err_section_too_small;
+
+		if (rec->hdr.length > sizeof(*rec)) {
+			pr_err(FW_WARN "error section length is too big\n");
+			return;
+		}
+
+		cper_post_cxl_event(newpfx, sec_type, rec);
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..bf642962a7ba 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <linux/cxl-event.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -187,3 +188,42 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+/* CXL CPER notifier chain */
+static BLOCKING_NOTIFIER_HEAD(cxl_cper_chain_head);
+
+void cper_post_cxl_event(const char *pfx, guid_t *sec_type,
+			 struct cper_cxl_event_rec *rec)
+{
+	struct cxl_cper_notifier_data nd = {
+		.rec = rec,
+	};
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "cxl event no Component Event Log present\n");
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA))
+		nd.event_type = CXL_CPER_EVENT_GEN_MEDIA;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM))
+		nd.event_type = CXL_CPER_EVENT_DRAM;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE))
+		nd.event_type = CXL_CPER_EVENT_MEM_MODULE;
+
+	if (blocking_notifier_call_chain(&cxl_cper_chain_head, 0, (void *)&nd)
+			== NOTIFY_BAD)
+		pr_err(FW_WARN "cxl event notifier chain failed\n");
+}
+
+int register_cxl_cper_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&cxl_cper_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(register_cxl_cper_notifier, CXL);
+
+void unregister_cxl_cper_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(unregister_cxl_cper_notifier, CXL);
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..aa3d36493586 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -10,11 +10,38 @@
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
+#include <linux/cxl-event.h>
+
 /* CXL Protocol Error Section */
 #define CPER_SEC_CXL_PROT_ERR						\
 	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
 		  0x4B, 0x77, 0x10, 0x48)
 
+/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CPER_SEC_CXL_GEN_MEDIA						\
+	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
+
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CPER_SEC_CXL_DRAM						\
+	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CPER_SEC_CXL_MEM_MODULE						\
+	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
+
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -62,5 +89,7 @@ struct cper_sec_prot_err {
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cper_post_cxl_event(const char *pfx, guid_t *sec_type,
+			 struct cper_cxl_event_rec *rec);
 
 #endif //__CPER_CXL_
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 6b689e1efc78..733ab2ab8639 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -108,4 +108,53 @@ struct cxl_event_record_raw {
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
+struct cper_cxl_event_rec {
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
+		} device_id;
+		struct cper_cxl_event_sn {
+			u32 lower_dw;
+			u32 upper_dw;
+		} dev_serial_num;
+	} hdr;
+
+	union cxl_event event;
+} __packed;
+
+struct cxl_cper_notifier_data {
+	enum cxl_event_type event_type;
+	struct cper_cxl_event_rec *rec;
+};
+
+#ifdef CONFIG_UEFI_CPER
+int register_cxl_cper_notifier(struct notifier_block *nb);
+void unregister_cxl_cper_notifier(struct notifier_block *nb);
+#else
+static inline int register_cxl_cper_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline void unregister_cxl_cper_notifier(struct notifier_block *nb) { }
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */

-- 
2.41.0


