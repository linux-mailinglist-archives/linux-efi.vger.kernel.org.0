Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381367DE746
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 22:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjKAVL4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344391AbjKAVLy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 17:11:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6FBD;
        Wed,  1 Nov 2023 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873108; x=1730409108;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0o4EeCzY6elFazCtz9kh1dNEb3UpHG1rbZZJsdEjJN4=;
  b=mN7ymAIw31v1JE+BZPA4ciBXzUBUHQbFwIqmXF/82JMG6QzU//gu/qxN
   J2P83yFR52r6yoVAoi102h5LStChss2v4WtqtqM1Qn5YuF4dnwnzbqkdn
   io9NmD28TmZIf4EZ+pT4TWlPp0aj1E9pLv9YQ3aVjZCop51wIEhJ+h5qt
   ZgBrW8zXTb2zHz/lEVqql49kEDXmt97Nczb6DHnc57cmyIutwXowM+77g
   s01VfP/LsWrliIxBlVaBflZfSihSNEkkLqBTD3VJOAKcVDWhz1XiNaUZo
   B7cYqFqu1RsYUxA24fo0DgGNpg89NbabSg63zuzC70qtxmXX/TUQtI2XO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10120112"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="10120112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092482760"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1092482760"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.80.64])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Nov 2023 14:11:22 -0700
Subject: [PATCH RFC v3 5/6] firmware/efi: Process CXL Component Events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v3-5-0189d61f7956@intel.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
In-Reply-To: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
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
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698873100; l=7487;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=0o4EeCzY6elFazCtz9kh1dNEb3UpHG1rbZZJsdEjJN4=;
 b=akinlqSvykE2s1BeeokyQuXOBaQpVjM9ZqHRMSenL6vMM2zwMQGRVslaDfaIM07FBikm8if41
 vN/ornowC1PAetMkgN2NIdSlFPqMsEad9Yh3rU3Vd9mbGT8Fy+6F7Ge
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

BIOS can configure memory devices as firmware first.  This will send CXL
events to the firmware instead of the OS.  The firmware can then send
these events to the OS via UEFI.

UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
format for CXL Component Events.  The format is mostly the same as the
CXL Common Event Record Format.  The only difference is the UUID is
passed via the Section Type as a GUID and not included as part of the
record data.

Add EFI support to detect CXL CPER records and call a notifier chain
with the record data blobs.

Note that the format of a GUID and UUID are not the same.  Therefore the
Section Type GUID defines are duplicated from the CXL code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
index 86bfcf7909ec..e83d727f7489 100644
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
 
+/* CXL Event record UUIDs are used as the section type */
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
index 6b689e1efc78..2bdadde80f1a 100644
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
+};
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

