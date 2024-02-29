Return-Path: <linux-efi+bounces-671-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075286C1AE
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 08:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DF289E2B
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055F45C04;
	Thu, 29 Feb 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0D5PMke"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F544C67;
	Thu, 29 Feb 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190807; cv=none; b=fGMAgZQ2XovNuQc5dKzFXT4386jyA89ILsuD0ClKJ1RyhCsJE71N9DT5Ti0peL/68n7yRRbAQ6Y6+SfaYQlprib6vel7buOtBzedpQs6oaMiT95Cl94cQfLW72ySXf2yfQgyirINF58CaFocF1820FAo02NeKTHJwAD/rWAzfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190807; c=relaxed/simple;
	bh=5eM5w7VZ6NPyCjmyhwlq6ycAHOyOHREv7WbgfWiRXaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Al5gWNWTgvit/fVHc/PHg+c5nDNdi4/Jt2y0Gt1aR25wV9fzLj4s8jyKQB3FzaulqkDuNtQp9kC7jBjt7nH0bsHNfrCSq3N9wD7/jnyeWxQHtg9i7HDf+mxL8l809fn+zJG1j9qXniRbT46ZhkBtcNjX5f4hfR5Fqm6vlhQYm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0D5PMke; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190805; x=1740726805;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5eM5w7VZ6NPyCjmyhwlq6ycAHOyOHREv7WbgfWiRXaU=;
  b=Y0D5PMkeXhhvdjDFjvT2hTvXxdBi/tXv4qKJ64wsFQ4rtS5NVjPeWLjx
   fkvXZMiVDp9ia0+R0xIhtDuNdFhmtvWEVLXs4kASO9Kjdnqrt3l4Q+Pms
   gZl1Ynnd528jXXPhsEYnjDilEjX+4KexfMPEGy+/HPQi9XBdh+7xqKauz
   HewGKB52+9s7kfL0xHwp0ndpEmMVzSP9rWkh86L7CPIOZzcx45HXgVCVp
   w3MHAU4d3Ya614l/9iasCYoqvIK1mtXibLFFulYjCO+MQIWheJcN2H7P+
   xopw8B90VBMSR8O2zL8MDBbtt9JrYqRK1gqpzQPGXaZ61pjRMsBEgWQzm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3519861"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3519861"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8283950"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.166.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:24 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 28 Feb 2024 23:13:17 -0800
Subject: [PATCH 2/4] acpi/ghes: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-cxl-cper3-v1-2-6aa3f1343c6c@intel.com>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
In-Reply-To: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709190800; l=8205;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=5eM5w7VZ6NPyCjmyhwlq6ycAHOyOHREv7WbgfWiRXaU=;
 b=V6e5g2S1NJtnryWVa+ppMCFhjuHNy2s9mMoKu4D4/wbJLBGxxya6zJermX0/mP4lB7F6qNjL0
 5naxmG8GfIEDl0CNuRES5QIAjXsHBmUCO0eNwM8q1ZlH/MhuSxKVoKA
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

BIOS can configure memory devices as firmware first.  This will send CXL
events to the firmware instead of the OS.  The firmware can then send
these events to the OS via UEFI.  Currently a configuration such as this
will trace a non standard event in the log.  Using the specific CXL
trace points with the additional information CXL can provide is much
more useful to users.  Specifically, future support can be added to CXL
provide the DPA to HPA mapping configured at the time of the event.

UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
format for CXL Component Events.  The format is mostly the same as the
CXL Common Event Record Format.  The difference is the use of a GUID in
the Section Type rather than a UUID as part of the event itself.

Add GHES support to detect CXL CPER records and call into the CXL code
to process the event.

Multiple methods were considered for the call into the CXL code.  A
notifier chain was considered for the callback but the complexity did
not justify the use case.  Furthermore, the CXL code is required to be
called from process context as it needs to take a device lock so a
simple callback register proved difficult.  Dan Williams suggested
using 2 work items as an atomic way of switching between a callback
being registered and not.  This allows the callback to run without any
locking.[1]

Note that a local work item is required to dump any messages seen during
a race between any check done in cxl_cper_post_event() and the
scheduling of work.  That said, no attempt is made to stop the addition
of messages into the kfifo because this local work item provides a hook
to add a local CXL CPER trace point in a future patch.

This new combined patch addresses the report by Dan Carpenter[2].  Thus
the reported by tag.

[1] https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
[2] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
[djbw: use kfifo for record data]
[djbw: Use work struct for sync between cxl reg and ghes code]
---
 drivers/acpi/apei/ghes.c  | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h |  18 +++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ab2a82cb1b0b..f433f4eae888 100644
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
@@ -33,6 +34,7 @@
 #include <linux/irq_work.h>
 #include <linux/llist.h>
 #include <linux/genalloc.h>
+#include <linux/kfifo.h>
 #include <linux/pci.h>
 #include <linux/pfn.h>
 #include <linux/aer.h>
@@ -673,6 +675,116 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
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
+struct cxl_cper_work_data {
+	enum cxl_event_type event_type;
+	struct cxl_cper_event_rec rec;
+};
+
+DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, 32);
+static DEFINE_SPINLOCK(cxl_cper_read_lock);
+static DEFINE_SPINLOCK(cxl_cper_write_lock);
+
+static cxl_cper_callback cper_callback;
+/* cb function dumps the records */
+static void cxl_cper_cb_fn(struct work_struct *work)
+{
+	struct cxl_cper_work_data wd;
+
+	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
+			&cxl_cper_read_lock)) {
+		cper_callback(wd.event_type, &wd.rec);
+	}
+}
+static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
+
+static void cxl_cper_local_fn(struct work_struct *work)
+{
+	struct cxl_cper_work_data wd;
+
+	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
+			&cxl_cper_read_lock)) {
+		/* drop msg */
+	}
+}
+static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
+
+/* Pointer for atomic switch of record processing */
+struct work_struct *cxl_cper_work = &cxl_local_work;
+
+static void cxl_cper_post_event(enum cxl_event_type event_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cxl_cper_work_data wd;
+
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
+	wd.event_type = event_type;
+	memcpy(&wd.rec, rec, sizeof(wd.rec));
+
+	kfifo_in_spinlocked(&cxl_cper_fifo, &wd, 1, &cxl_cper_write_lock);
+	schedule_work(cxl_cper_work);
+}
+
+int cxl_cper_register_callback(cxl_cper_callback callback)
+{
+	if (cper_callback)
+		return -EINVAL;
+	cper_callback = callback;
+	/* Atomic switch back to callback processing */
+	cxl_cper_work = &cxl_cb_work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
+
+int cxl_cper_unregister_callback(cxl_cper_callback callback)
+{
+	if (callback != cper_callback)
+		return -EINVAL;
+
+	/* Atomic switch back to ghes processing */
+	cxl_cper_work = &cxl_local_work;
+	cancel_work_sync(&cxl_cb_work);
+	cper_callback = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -707,6 +819,21 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
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
index 812ed16ffc2f..4834cf23656e 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -143,4 +143,22 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
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


