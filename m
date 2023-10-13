Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCC7C7E34
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMGzZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjJMGzY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 02:55:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89391;
        Thu, 12 Oct 2023 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697180122; x=1728716122;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N0U8aFIru2efMmgu1BQSCX4SzMURyiiTsuUumsEVSp4=;
  b=bQzT07+DWykZptq3B7aIbqLZEOwkpYbPFgKnF2Zu4aJ59zYjsSnUPl5W
   yPjTy0vQ2bog6d80orwjjN1tpscepY+080+uXmAOF+v1Ui9qtFSeMTFDc
   yKjlgYCQDVsFThYf1movuBC/kATGnEgEDo/m+bObIcaLwyag5JIXOkR8S
   e6mSJ1F9f39MfT64xe2cYBmVmOvz3WG34QbZ51ssHnqQIiYKMNy0uHAIA
   0r92/w2/4ib9MC2EAhApXZpcoHki7OohqznXUu0FYAW3FZ34mOcalNXfF
   D1zVn9Gy/aKRrWoQMH7yi2yS8afCAZPxj8fbj+hnwZ5VrJaba87G42wKB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451596004"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="451596004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704512898"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="704512898"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.55.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 12 Oct 2023 23:55:19 -0700
Subject: [PATCH RFC 1/2] firmware/efi: Process CXL Component Events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697180119; l=7767;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=N0U8aFIru2efMmgu1BQSCX4SzMURyiiTsuUumsEVSp4=;
 b=6hV7rg/aEFOuzOZ08EGIpSCjlRV+CttcOUx8Tgp81nED2gL4F7PVe36JcNWwGhDMLUhzU9lsv
 FeRE236nNiVAD3qkXzIP2V5lbzViG6/qO5LPBF+nlGRYVLL97f/0NdC
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
Section Type GUID must be converted to a UUID prior to being used by the
CXL code.  Make that conversion and send it along to those registered.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
RFC comments:
I'm still not sure if the 'CXL Component Event Log' portion of the CPER
record includes the UUID from the CXL Common Event Record Format.

The 2.10 version of the UEFI spec says:

"For the CXL Component Event Log: Refer to the Common Event Record field
(Offset 16) of the Events Record Format for each CXL component."

This implies that the first 16 bytes (the UUID) is not included.  It
would be nice if the UUID were included there as a copy of what would
normally be in the CXL event log.  If so the Section Type GUID could be
used solely to match for a CXL record and ignored in the CXL code.

For now convert the GUID to UUID and pass to the notifier users.

Smita, Another idea I had was to add your cper_print_comp_event()
function to the dump here to capture that CPER specific data in the EFI
log.
---
 drivers/firmware/efi/cper.c     | 16 ++++++++++++++
 drivers/firmware/efi/cper_cxl.c | 39 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++++++
 include/linux/efi.h             | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..af2c59f5e21d 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &gen_media_event_guid) ||
+		   guid_equal(sec_type, &dram_event_guid) ||
+		   guid_equal(sec_type, &mem_mod_event_guid)) {
+		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
+
+		printk("%ssection type: CXL Event\n", newpfx);
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
index a55771b99a97..9b1a64ed542e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -187,3 +187,42 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			       sizeof(cxl_ras->header_log), 0);
 	}
 }
+
+/* CXL CPER notifier chain */
+static BLOCKING_NOTIFIER_HEAD(cxl_cper_chain_head);
+
+void cper_post_cxl_event(const char *pfx, guid_t *guid, struct cper_cxl_event_rec *rec)
+{
+	struct cxl_cper_notifier_data nd = {
+		.rec = rec,
+	};
+	char guid_str[UUID_STRING_LEN + 1]; /* + trailing NULL */
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "cxl event no Compoent Event Log present\n");
+		return;
+	}
+
+	snprintf(guid_str, UUID_STRING_LEN + 1, "%pU", guid);
+	if (uuid_parse(guid_str, &nd.uuid))
+		pr_err(FW_WARN "cxl event uuid conversion failed\n");
+
+	pr_info("%s cxl event guid %pU, uuid %pU\n", pfx, guid, &nd.uuid);
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
+EXPORT_SYMBOL(register_cxl_cper_notifier);
+
+void unregister_cxl_cper_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
+}
+EXPORT_SYMBOL(unregister_cxl_cper_notifier);
+
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..47fc83dad8d2 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -10,11 +10,38 @@
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
+#include <linux/efi.h>
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
+static const guid_t gen_media_event_guid =
+	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
+
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+static const guid_t dram_event_guid =
+	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const guid_t mem_mod_event_guid =
+	GUID_INIT(0xfe927475, 0xdd59, 0x4339,
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
@@ -62,5 +89,7 @@ struct cper_sec_prot_err {
 #pragma pack()
 
 void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cper_post_cxl_event(const char *pfx, guid_t *guid,
+			 struct cper_cxl_event_rec *rec);
 
 #endif //__CPER_CXL_
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6eaf..eb03962b2547 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1355,4 +1355,53 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+/*
+ * CXL r3.0 Table 8-42
+ * 30h + 50h - 10h (For lack of UUID)
+ */
+#define CPER_CXL_COMP_EVENT_LOG_SIZE 0x70
+#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
+#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
+#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
+struct cper_cxl_event_rec {
+	struct {
+		u32 length;
+		u64 validation_bits;
+		struct {
+			u16 vendor_id;
+			u16 device_id;
+			u8 func_num;
+			u8 device_num;
+			u8 bus_num;
+			u16 segment_num;
+			u16 slot_num; /* bits 2:0 reserved */
+			u8 reserved;
+		} device_id;
+		struct {
+			u32 lower_dw;
+			u32 upper_dw;
+		} dev_serial_num;
+	} hdr;
+
+	u8 comp_event_log[CPER_CXL_COMP_EVENT_LOG_SIZE];
+};
+#define CPER_CXL_REC_LEN(rec) (rec->hdr.length - sizeof(rec->hdr))
+
+struct cxl_cper_notifier_data {
+	uuid_t uuid;
+	struct cper_cxl_event_rec *rec;
+};
+
+#ifdef CONFIG_EFI
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
 #endif /* _LINUX_EFI_H */

-- 
2.41.0

