Return-Path: <linux-efi+bounces-957-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B58AD738
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E52E282B6F
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3479208C7;
	Mon, 22 Apr 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBA326ix"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AA1DFF8;
	Mon, 22 Apr 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824749; cv=none; b=BZLrn6L/Pq+0Vn88PbuoFZPoFBe6mhqV6TNoTM74jkxynDNjiuo6EbdxxlYReMiNjScNDcg8ha1phG/MTTQTZQnmINfDBXhsSsJoXD5OngLgsaPLau7rnLvVfAzy19TprKt3iYBtPB8MCSZgG8Vc9HWa5OYwh8G/SlCUY2EHWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824749; c=relaxed/simple;
	bh=FuKDSZ4aVWr6HwKf++NZRo3+jf6WhoN4NAPNrDMZ3EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6XKHAtX90do+jWVjA6IFngCRTEydxnjtUi4xm7IPJBUr0y0d6cvWz4XCvzwKki4PgU8hq/2LKDAqFpKImp2yUNYLK0s0z0PMzkXTLRFbocZpVwspNaWtUWBXV5sAPPCJ3VV1By094CbtvjQkfElVWKmOtHfybmngtAUheZgNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBA326ix; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824748; x=1745360748;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FuKDSZ4aVWr6HwKf++NZRo3+jf6WhoN4NAPNrDMZ3EM=;
  b=cBA326ixDIWmCGv4eHGLFHG0dpN10M/QnMnTnL6AHtdChoOEIYAstBev
   0E0Eeb2lsSjUR3WpwAp5I/gKspOfOUWinmGnOu0cq7QLJOy8N80UREmCq
   q2tPrCJ9PbHWMymB2mktQJAC42+RFEpHc33G+JRqt7BfmhPrq+N1IUOCW
   2mNl5mGmReL1rtatWttprgBg5vCAzE8dLhnpYeHhEgpFZSurLFl5yn6zM
   pf1QtE9/hxUzpVYwgfeRR+ApeOuBUpuIYaum0lIJE3lcRgyLnslq7pCLw
   rzUqA3jLTOo3GFczQou6wWChBubwdwjkJ1HiHNkJDcH8g07vZHPa0jXFv
   A==;
X-CSE-ConnectionGUID: X24VXZYqSd2XcBJe2dSnyg==
X-CSE-MsgGUID: q/2kgjAmQySZzSh5dmfm7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19997724"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19997724"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:47 -0700
X-CSE-ConnectionGUID: hDJnKfM5Q1KNHrqq6lM9TA==
X-CSE-MsgGUID: 9Lj0cPdhQ0ClaRNxffyV6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55094323"
Received: from iweiny-mobl.sc.intel.com (HELO localhost) ([10.144.160.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:46 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 22 Apr 2024 15:25:45 -0700
Subject: [PATCH v2 1/3] acpi/ghes: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-cxl-cper3-v2-1-5cdd378fcd0b@intel.com>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
In-Reply-To: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713824744; l=7480;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=FuKDSZ4aVWr6HwKf++NZRo3+jf6WhoN4NAPNrDMZ3EM=;
 b=Xq3SKAGTWo/3IOxU1w+AJTN68PLHFzuAelr5m1Ngg3Bhy5goNoehcwoRguQvUEJ3j5k9VLxrN
 jScCMZPIevfD7oPqWIokCqJxrnuCFLf93XdkrPP3UhWi+y7W9YmGzJI
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

BIOS can configure memory devices as firmware first.  This will send CXL
events to the firmware instead of the OS.  The firmware can then inform
the OS of these events via UEFI.

UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
format for CXL Component Events.  The format is mostly the same as the
CXL Common Event Record Format.  The difference lies in the use of a
GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
Table 8-43.

Currently a configuration such as this will trace a non standard event
in the log omitting useful details of the event.  In addition the CXL
sub-system contains additional region and HPA information useful to the
user.[0]

Add GHES support to detect CXL CPER records.  Add the ability for the
CXL sub-system to register a callback to receive the events.

The CXL code is required to be called from process context as it needs
to take a device lock.  The GHES code may be in interrupt context.  This
complicated the use of a callback.  Dan Williams suggested the use of
work items as an atomic way of switching between the callback execution
and a default handler.[1]

This patch adds back the functionality which was removed to fix the
report by Dan Carpenter[2].

[0]
Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
[1]
Link: https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
[2]
Link: https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: clarify commit message]
[djbw: remove local wt]
---
 drivers/acpi/apei/ghes.c  | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h |  18 +++++++
 2 files changed, 142 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 512067cac170..cdcfdf6ebe81 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
+#include <linux/cleanup.h>
+#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -33,6 +35,7 @@
 #include <linux/irq_work.h>
 #include <linux/llist.h>
 #include <linux/genalloc.h>
+#include <linux/kfifo.h>
 #include <linux/pci.h>
 #include <linux/pfn.h>
 #include <linux/aer.h>
@@ -673,6 +676,112 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
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
+static DEFINE_SPINLOCK(cxl_cper_work_lock);
+static cxl_cper_callback cper_callback;
+static void cxl_cper_cb_fn(struct work_struct *work)
+{
+	struct cxl_cper_work_data wd;
+
+	while (kfifo_get(&cxl_cper_fifo, &wd))
+		cper_callback(wd.event_type, &wd.rec);
+}
+static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
+struct work_struct *cxl_cper_work = NULL;
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
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+
+	if (!cxl_cper_work)
+		return;
+
+	wd.event_type = event_type;
+	memcpy(&wd.rec, rec, sizeof(wd.rec));
+
+	if (!kfifo_put(&cxl_cper_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_work);
+}
+
+int cxl_cper_register_callback(cxl_cper_callback callback)
+{
+	if (cper_callback)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cper_callback = callback;
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
+	/* Avoid guard() because cancel_work_sync() can sleep */
+	spin_lock(&cxl_cper_work_lock);
+	cxl_cper_work = NULL;
+	spin_unlock(&cxl_cper_work_lock);
+
+	cancel_work_sync(&cxl_cb_work);
+	cper_callback = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -707,6 +816,21 @@ static bool ghes_do_proc(struct ghes *ghes,
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
index 03fa6d50d46f..91125eca4c8a 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -140,4 +140,22 @@ struct cxl_cper_event_rec {
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
2.44.0


