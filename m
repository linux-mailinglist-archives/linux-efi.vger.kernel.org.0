Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F007D8834
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjJZSWT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjJZSWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 14:22:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A91B1;
        Thu, 26 Oct 2023 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698344536; x=1729880536;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kzUu5T88aXPV2ML7F1LVIjz5BeKGE7YYrbnViZM8dYU=;
  b=le4Ab4gBJnQNSG7mzDvA153C5WCtV2Epa0I3q+h9wxgw4B1Xj/XpdK5A
   /oitwZWDycEcdE1y5QVXbz+eA5M9g4Z4r3FEcXORWtaQbUisjv8MOHyI3
   8LTGtUbV6d+QBeV0U3nJdu2VdP/GMoCCuG8Bvg7E8Ac66HBtpvWPd4hfG
   U13R4h/ETRmMT2SN9peoEZvlZUofZy5pQNdP22IxdTtXpDKUOgBhVkhlS
   6PtzA+YtdZ2KhiEVlLYLt3EWM1zlubKR6/JLjRLL/ErU0vL6aSUPzTaVr
   qzo522j/047HIwUFiEYijzYld6NuXFt36cQf3rY1Odo3ktAWfDLayhkcd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418733777"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="418733777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825087500"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825087500"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.121.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 26 Oct 2023 11:21:39 -0700
Subject: [PATCH RFC v2 2/3] firmware/efi: Process CXL Component Events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v2-2-314d9c36ab02@intel.com>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
In-Reply-To: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698344500; l=7303;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=kzUu5T88aXPV2ML7F1LVIjz5BeKGE7YYrbnViZM8dYU=;
 b=xKcWPrImgCCOPtaHcL3ztPKdVhS4fiJcRVA5NZ/dfBsx9GMlVOg1I2lG+qL9ftbBO7jsNySEy
 SQeBkJec+jNDEShxTuDaGKS3H1wCYOHt5FeUv6wppHjgAvxOaTrE3hr
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes from RFC v1
[iweiny: use an enum for know record types and skip converting GUID to UUID]
[iweiny: commit to the UUID not being part of the event record data]
[iweiny: use defines for GUID definitions]
---
 drivers/firmware/efi/cper.c     | 16 +++++++++++
 drivers/firmware/efi/cper_cxl.c | 40 ++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++
 include/linux/efi.h             | 59 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..d6415c94d584 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM) ||
+		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE)) {
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
index a55771b99a97..04234884898d 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -187,3 +187,43 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
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
+		nd.cper_event = CXL_CPER_EVENT_GEN_MEDIA;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM))
+		nd.cper_event = CXL_CPER_EVENT_DRAM;
+	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE))
+		nd.cper_event = CXL_CPER_EVENT_MEM_MODULE;
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
index 86bfcf7909ec..ca26126cd9b8 100644
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6eaf..b5b8b46c8deb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1355,4 +1355,63 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+/*
+ * Event log size adjusted for CPER
+ *
+ * Base table from CXL r3.0 Table 8-42: (30h + 50h)
+ * For lack of UUID: - 10h
+ *
+ * (30h + 50h) - 10h = 70h
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
+enum cxl_cper_event {
+	CXL_CPER_EVENT_GEN_MEDIA,
+	CXL_CPER_EVENT_DRAM,
+	CXL_CPER_EVENT_MEM_MODULE,
+};
+
+struct cxl_cper_notifier_data {
+	enum cxl_cper_event cper_event;
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

