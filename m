Return-Path: <linux-efi+bounces-989-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898E8B40A1
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 22:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA00B24115
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B122EE8;
	Fri, 26 Apr 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbGT03zf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45187208CA;
	Fri, 26 Apr 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161790; cv=none; b=Tn5EBuCI1qykorFQ61jksz7STLCE0sX6l4nQPmA1Iof99N3boE7XRfejuGSJmaftHxDtZRHN52tLnXwVkDakkjwy5MjyRicUQkxI2kOOud2DYw720+d59i1wnx+IzL9VSe8YIsOSPr40/D9IcxWQLynG8PhyXgmeKXPFTbyY/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161790; c=relaxed/simple;
	bh=F/ZpLt5mL5j8/Mowvno1eE6OPUHz5rYnhyxW0OzTeLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8JGmqTxNd3EJtRV5iwETdfhY5b61AdoA/uTsl1V6y7TXDsf+J3ASqoSsVK7chyKkpTCingZRULp1d9+eGwrqmxeEB32SYRJBFnI8TRi5fnTJ8HpPrkxKXt28/5AcFkh6EYbaxmbo7NMAD74WGLr2OhE54J3R48H0FEpWBYuf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbGT03zf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161789; x=1745697789;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=F/ZpLt5mL5j8/Mowvno1eE6OPUHz5rYnhyxW0OzTeLI=;
  b=mbGT03zfgVftkp2gDiEM+tqsrCslvD9pBMeHn5RGlwQcOUmu6OlwUYHC
   fdKmVJ36lzMI1C/KZxKNe6jZPwaHR1pSnIgdxXyfFK8bsCbl/731JrW9N
   ojqErsOafLgxBjSnH9Yl0dK5CiR4QVh3dgJNIfOoqRpoALlKSfcs0ZFtE
   WlCimNvdiySzFa+rm2I5XEhklL8pmmu9wUhvG9vIc5Y9LQ+uqJ+vLq547
   rmiiXGoGncvIloo5UUajVDN3+EkEPazde7I7lxZz0tijugQJuVqVj9Roo
   VFx4K9BVCH7ZSWvtg+qI9AhzdjKL1RUOuSPL3SQygJY4wKUeyxltFBPNF
   g==;
X-CSE-ConnectionGUID: 6TR6OPGNTZe+QZXLBIKVNQ==
X-CSE-MsgGUID: hIN+0/n9S0W681sAyoGMqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9787171"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9787171"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:03:07 -0700
X-CSE-ConnectionGUID: XIjHDFD2Sj6Cv5b/JM7F1A==
X-CSE-MsgGUID: 2GymRFcBRlSI0xhtFHv6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25516142"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.176.246])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:03:06 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 26 Apr 2024 13:02:59 -0700
Subject: [PATCH v3 1/2] acpi/ghes: Process CXL Component Events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-cxl-cper3-v3-1-6ade7dfc849e@intel.com>
References: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
In-Reply-To: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714161785; l=8069;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=F/ZpLt5mL5j8/Mowvno1eE6OPUHz5rYnhyxW0OzTeLI=;
 b=XtKF+roJ18hxwc/sOqn2c+h/zSvEYi586NHQsJdkmYTdXE3FVGZdm6oHIA6byrKa2XFzRyF9m
 zURdrjfTXBAAu5R2g7FYh/foNyiC+Wh7P4CjmWvccLydScZaf9dNM4/
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

The CXL code is required to be called from process context as it needs
to take a device lock.  The GHES code may be in interrupt context.  This
complicated the use of a callback.  Dan Williams suggested the use of
work items as an atomic way of switching between the callback execution
and a default handler.[1]

The use of a kfifo simplifies queue processing by providing lock free
fifo operations.  cxl_cper_kfifo_get() allows easier management of the
kfifo between the ghes and cxl modules.

CXL 3.1 Table 8-127 requires a device to have a queue depth of 1 for
each of the four event logs.  A combined queue depth of 32 is chosen to
provide room for 8 entries of each log type.

Add GHES support to detect CXL CPER records.  Add the ability for the
CXL sub-system to register a work queue to process the events.

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
[iweiny: fix checkpatch errors despite formatting changes in if
	 statement]
[djbw: better define the choice of 32 kfifo entries]
[djbw: let CXL layer declare work struct and handle sync to simplify
       GHES code]
---
 drivers/acpi/apei/ghes.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cxl-event.h |  27 ++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 512067cac170..2247a1535b52 100644
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
@@ -673,6 +676,101 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
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
+/* Room for 8 entries for each of the 4 event log queues */
+#define CXL_CPER_FIFO_DEPTH 32
+DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_work changes */
+static DEFINE_SPINLOCK(cxl_cper_work_lock);
+struct work_struct *cxl_cper_work;
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
+int cxl_cper_register_work(struct work_struct *work)
+{
+	if (cxl_cper_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, CXL);
+
+int cxl_cper_unregister_work(struct work_struct *work)
+{
+	if (cxl_cper_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, CXL);
+
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -707,6 +805,18 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..a0067c49e2ca 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_CXL_EVENT_H
 #define _LINUX_CXL_EVENT_H
 
+#include <linux/workqueue_types.h>
+
 /*
  * Common Event Record Format
  * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
@@ -140,4 +142,29 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
+struct cxl_cper_work_data {
+	enum cxl_event_type event_type;
+	struct cxl_cper_event_rec rec;
+};
+
+#ifdef CONFIG_ACPI_APEI_GHES
+int cxl_cper_register_work(struct work_struct *work);
+int cxl_cper_unregister_work(struct work_struct *work);
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
+#else
+static inline int cxl_cper_register_work(struct work_struct *work);
+{
+	return 0;
+}
+
+static inline int cxl_cper_unregister_work(struct work_struct *work);
+{
+	return 0;
+}
+static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */

-- 
2.44.0


