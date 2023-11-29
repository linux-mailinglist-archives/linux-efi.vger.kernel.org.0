Return-Path: <linux-efi+bounces-103-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2247FDF02
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E21C20D84
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263965B5D5;
	Wed, 29 Nov 2023 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyQ3Sg6I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632310F;
	Wed, 29 Nov 2023 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280853; x=1732816853;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xTpGQ+PAxSHwBHlBs9slgZFpE0GWKjPb/q9ceypqoEA=;
  b=KyQ3Sg6IF41YnJOGNND24PfZWG4rcy6LORcg+bgBTtA92WoADBZSp+fp
   zuz94reqLSEXnK9POdM72Tt7O/w242PYATRVlZZwkmAOzwsYTl2xpuVA8
   qcF8pY7f8yAmp1Al0fwVYlj77pKRSIisecgmdQDHeK9YocWj208UBP4jt
   JFkThXZx93Rl+6XhoE9/jJCLDzi57Qa7GexGiFQj9YWfrt5qFkt0SUsrd
   q/zppP4j+M3eADNOXRiT+p0o7m2CeL/e9TrS+ooIoi4XT1ODOiLZGe2PB
   yXktmn3CxjOr9PUbZkwIEnBVw3zLMXScBQQpIvWDD+IjUTBadDQNRSr5O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457524504"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="457524504"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835096131"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835096131"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.127.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:51 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 29 Nov 2023 10:00:45 -0800
Subject: [PATCH 5/6] firmware/efi: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-5-d19f1ac18ab6@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701280847; l=7089;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=xTpGQ+PAxSHwBHlBs9slgZFpE0GWKjPb/q9ceypqoEA=;
 b=gr5HqxjUGUaUZtmD/R99qm/2pfDlrjOEk/RkhOr3F+6ff6nYq9hhr1CchBLXP3qbnCyGKBEmx
 JikGTfUZ+VWDzDA3piryQyqJ5TGSNB0nK1il1a7Fc9rBdNR67CtVMED
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
Changes from RFC:
[Smita: use pragma packed for cper structures]
---
 drivers/firmware/efi/cper.c     | 15 ++++++++++++
 drivers/firmware/efi/cper_cxl.c | 40 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++++
 include/linux/cxl-event.h       | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)

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
index 18dab4d90dc8..114f8abb7152 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -108,4 +108,57 @@ struct cxl_event_record_raw {
 	union cxl_event event;
 } __packed;
 
+enum cxl_event_type {
+	CXL_CPER_EVENT_GEN_MEDIA,
+	CXL_CPER_EVENT_DRAM,
+	CXL_CPER_EVENT_MEM_MODULE,
+};
+
+#pragma pack(1)
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
+};
+
+struct cxl_cper_notifier_data {
+	enum cxl_event_type event_type;
+	struct cper_cxl_event_rec *rec;
+};
+
+#pragma pack()
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
2.42.0


