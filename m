Return-Path: <linux-efi+bounces-182-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785C80DEB8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE611F21A6D
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A855C37;
	Mon, 11 Dec 2023 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etYc2ypF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC977100;
	Mon, 11 Dec 2023 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335472; x=1733871472;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JvvYQOoiyMMtw/X3yyi/hKgeolU50zF5daJcQF3yg/E=;
  b=etYc2ypF7b+fZi0crk2MB18xxTx7EHT65JsJObM3esSOzDjSpOK2JP9S
   xlmkM1liLDFw+ECFB14fr8v746csO7c/6/k0o6mib+TbW71ImAxgizrs8
   JX4WUdQ/vDC/01voGVSJUZfGbifaTFLn4MmeD1Ou0+y4KwUtJYpw4qQFX
   b027WEmY+OlDpRz/4P7k8su4k8kqFwaeN29ayD00NjWkGOPv4guHpJJgv
   VhssiK5feWlRVAMQ7VTD0isP438cpYltcI9+66JSwzVYWkhz9BN09ZvGU
   LBTdnz95iAJiLnBq8h7QqYl1OdIKZMoKnt4GcNhgoiwHtPHQzm2JmW4Pj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084379"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513493"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513493"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:49 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 11 Dec 2023 14:57:46 -0800
Subject: [PATCH v2 6/7] firmware/efi: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335463; l=7205;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=JvvYQOoiyMMtw/X3yyi/hKgeolU50zF5daJcQF3yg/E=;
 b=ffSKa8xgOyMnflyI3+9+Ltgmbf6W1/eBNdhtmvyAFtDKCIqrorVIv02pO4RLo3vG7bwPlC0qr
 LIN1Z5HvyA+CM0xAyTFDgeqz+6SWb08zLdtFfUdYeI0CrvYjVyU20GS
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
Changes from v1:
[djbw: convert to single notifier callback]
[djbw: append _GUID to guid defines]
[iweiny: clean up function names]
---
 drivers/firmware/efi/cper.c     | 15 ++++++++++++
 drivers/firmware/efi/cper_cxl.c | 45 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 +++++++++++++++++++++++
 include/linux/cxl-event.h       | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..39c65733ae9b 100644
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
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
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
+		cxl_cper_post_event(newpfx, sec_type, rec);
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..669983f7956f 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <linux/cxl-event.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -187,3 +188,47 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+DECLARE_RWSEM(cxl_cper_rw_sem);
+static cxl_cper_notifier cper_notifier;
+
+void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
+			 struct cper_cxl_event_rec *rec)
+{
+	struct cxl_cper_event_data data = {
+		.rec = rec,
+	};
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "cxl event no Component Event Log present\n");
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID))
+		data.event_type = CXL_CPER_EVENT_GEN_MEDIA;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID))
+		data.event_type = CXL_CPER_EVENT_DRAM;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID))
+		data.event_type = CXL_CPER_EVENT_MEM_MODULE;
+
+	down_read(&cxl_cper_rw_sem);
+	if (cper_notifier)
+		cper_notifier(&data);
+	up_read(&cxl_cper_rw_sem);
+}
+
+void cxl_cper_register_notifier(cxl_cper_notifier notifier)
+{
+	down_write(&cxl_cper_rw_sem);
+	cper_notifier = notifier;
+	up_write(&cxl_cper_rw_sem);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_notifier, CXL);
+
+void cxl_cper_unregister_notifier(void)
+{
+	down_write(&cxl_cper_rw_sem);
+	cper_notifier = NULL;
+	up_write(&cxl_cper_rw_sem);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_notifier, CXL);
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..b1b1b0514f6b 100644
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
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -62,5 +89,7 @@ struct cper_sec_prot_err {
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
+			 struct cper_cxl_event_rec *rec);
 
 #endif //__CPER_CXL_
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 18dab4d90dc8..c764ff877a6d 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -108,4 +108,55 @@ struct cxl_event_record_raw {
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
+struct cxl_cper_event_data {
+	enum cxl_event_type event_type;
+	struct cper_cxl_event_rec *rec;
+};
+
+#pragma pack()
+
+typedef void (*cxl_cper_notifier)(struct cxl_cper_event_data *ev_data);
+
+#ifdef CONFIG_UEFI_CPER
+void cxl_cper_register_notifier(cxl_cper_notifier notifier);
+void cxl_cper_unregister_notifier(void);
+#else
+static inline void cxl_cper_register_notifier(cxl_cper_notifier notifier) { }
+static inline void cxl_cper_unregister_notifier(void) { }
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */

-- 
2.43.0


