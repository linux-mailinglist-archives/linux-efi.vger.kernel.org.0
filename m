Return-Path: <linux-efi+bounces-673-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9986C1B2
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 08:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926861C21ADF
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A4482DF;
	Thu, 29 Feb 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pxhe90Kx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA147F5F;
	Thu, 29 Feb 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190809; cv=none; b=T4PKZ/NnqUYGHHYhfx3spcMOeCFNbMAZ4HhFu9sf9TyOu7yZE2t0N/rAeciq5FuTXYLRiQLNbCuaAybV8coBHDEst/8kgd0XTbIxUVCypNwJOIaqFiLoG5e91wYj0ej0sQ/gdFVtTT0714NSQQ1VReLV6YCujiLTGftu36rDBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190809; c=relaxed/simple;
	bh=d6szCcRr1xJz3ioCRqW/Jzj0XJlHmJymM212OssLqV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtTfOAkE5frWyItjJ69cHiMV8Ldiw+0e+P45kRsfF0feKgjXup5N018Ge2d15Q3FT7YIodKK5Dy/26j59ymGHflRmPStASC95ZwxiyeQLkfW/kIlVI4wzhX7FBuqv5jFPIUpNPkKfISZhh4w/BkmiFfKV3xI8Apyd9TPZqkwK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pxhe90Kx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190808; x=1740726808;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=d6szCcRr1xJz3ioCRqW/Jzj0XJlHmJymM212OssLqV8=;
  b=Pxhe90Kx5tV+wVG0ENzmQjFvO+8OC+/Fy+JB4Jt2Dnp8vpvgeE2wroNI
   GZwDcV4Jki1UsxfyNIbTJKYZa+nJCdYdJ3MxCcTy2Xne2RNZshY4lvDGN
   9rZYdL2gHAQ0lz1m9bWZGQl1X0KOY23p/+Qf5yZrTU9VkE4EihnwlVHR1
   /dQlFDh401b5ypsTjhO6X/5yurnFEZVgSmCZYgMrYUl0JkN9/xy7QuDl9
   J9hWiF83Fyblpx9sXdkLUaCMgLLHVTMjmh/i4J/3yX9ALT2zoXcks42AZ
   /TGCzurK/5vrKP9aTN5HWyN6Wt7xs7FRm7J9vMpEjrnJU/tyUe4V3pGq6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3519880"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3519880"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8283957"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.166.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:26 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 28 Feb 2024 23:13:19 -0800
Subject: [PATCH 4/4] ras/events: Trace CXL CPER events even without the CXL
 stack loaded
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-cxl-cper3-v1-4-6aa3f1343c6c@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709190800; l=5654;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=d6szCcRr1xJz3ioCRqW/Jzj0XJlHmJymM212OssLqV8=;
 b=QdCvHwK33KkZUETbo+6ZurAroMJdTuJYMUu7rMVJkz+oC972HYA7r1dhQZm4t1iEdiv3KLVOP
 0cKA5vRSNM9ADzIJG8qQCFbEUSfAWvHU0VweYpvcwxA8cAvDH6vaDOQ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If CXL is solely managed by firmware (including HDM configuration and
event processing via firmware first) it is possible to run the system
without the CXL software loaded.  In this case no CXL callback will be
loaded and CXL CPER errors will not be processed at all.

In this case memory device and region (HPA) information is missing but
omitting the error completely is not friendly for such a user.  Some
device information is available in the generic event which could prove
useful to a user.

Utilize the local work item to trace a generic CXL CPER event.

Duplicate the pattern of decoding the CXL event header to aid in adding
future trace points if needed.  This was an easy lift from the CXL trace
points.  But stop at header decoding only because this is an unlikely
configuration for the system.  Further decoding can be obtained with
user space tools or added later if needed.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/acpi/apei/ghes.c |  5 ++-
 include/ras/ras_event.h  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f433f4eae888..9ac323cbf195 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -729,7 +729,10 @@ static void cxl_cper_local_fn(struct work_struct *work)
 
 	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
 			&cxl_cper_read_lock)) {
-		/* drop msg */
+		struct cxl_cper_event_rec *rec = &wd.rec;
+		union cxl_event *evt = &rec->event;
+
+		trace_cper_cxl_gen_event(rec, &evt->generic);
 	}
 }
 static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..319faf552b65 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -422,6 +422,96 @@ TRACE_EVENT(memory_failure_event,
 	)
 );
 #endif /* CONFIG_MEMORY_FAILURE */
+
+#include <linux/cxl-event.h>
+#include <asm-generic/unaligned.h>
+
+/*
+ * Common Event Record Format
+ * CXL 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
+#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
+#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
+#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
+	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
+	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
+	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
+	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
+)
+
+/*
+ * Define macros for the common header of each CPER CXL event.
+ *
+ * Tracepoints using these macros must do 3 things:
+ *
+ *	1) Add CPER_CXL_EVT_TP_entry to TP_STRUCT__entry
+ *	2) Use CPER_CXL_EVT_TP_fast_assign within TP_fast_assign;
+ *	   pass the serial number and CXL event header
+ *	3) Use CPER_CXL_EVT_TP_printk() instead of TP_printk()
+ *
+ * See the generic_event tracepoint as an example.
+ */
+#define CPER_CXL_EVT_TP_entry					\
+	__field(u16, segment)					\
+	__field(u8, bus)					\
+	__field(u8, device)					\
+	__field(u8, func)					\
+	__field(u64, serial)					\
+	__field(u32, hdr_flags)					\
+	__field(u16, hdr_handle)				\
+	__field(u16, hdr_related_handle)			\
+	__field(u64, hdr_timestamp)				\
+	__field(u8, hdr_length)					\
+	__field(u8, hdr_maint_op_class)
+
+#define CPER_CXL_EVT_TP_fast_assign(cper_rec, evt_hdr)				\
+	__entry->segment = cper_rec->hdr.device_id.segment_num;			\
+	__entry->bus = cper_rec->hdr.device_id.bus_num;				\
+	__entry->device = cper_rec->hdr.device_id.device_num;			\
+	__entry->func = cper_rec->hdr.device_id.func_num;			\
+	__entry->serial = (((u64)cper_rec->hdr.dev_serial_num.upper_dw) << 32) |\
+			 cper_rec->hdr.dev_serial_num.lower_dw;			\
+	__entry->hdr_length = (evt_hdr).length;					\
+	__entry->hdr_flags = get_unaligned_le24((evt_hdr).flags);		\
+	__entry->hdr_handle = le16_to_cpu((evt_hdr).handle);			\
+	__entry->hdr_related_handle = le16_to_cpu((evt_hdr).related_handle);	\
+	__entry->hdr_timestamp = le64_to_cpu((evt_hdr).timestamp);		\
+	__entry->hdr_maint_op_class = (evt_hdr).maint_op_class
+
+#define CPER_CXL_EVT_TP_printk(fmt, ...)					\
+	TP_printk("device=%04x:%02x:%02x.%02x serial=%lld : time=%llu "		\
+		"len=%d flags='%s' handle=%x related_handle=%x "		\
+		"maint_op_class=%u : " fmt,					\
+		__entry->segment, __entry->bus, __entry->device, __entry->func,	\
+		__entry->serial,						\
+		__entry->hdr_timestamp, __entry->hdr_length,			\
+		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
+		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
+		##__VA_ARGS__)
+
+TRACE_EVENT(cper_cxl_gen_event,
+
+	TP_PROTO(struct cxl_cper_event_rec *cper_rec,
+		 struct cxl_event_generic *gen_rec),
+
+	TP_ARGS(cper_rec, gen_rec),
+
+	TP_STRUCT__entry(
+		CPER_CXL_EVT_TP_entry
+		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
+	),
+
+	TP_fast_assign(
+		CPER_CXL_EVT_TP_fast_assign(cper_rec, gen_rec->hdr);
+		memcpy(__entry->data, gen_rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
+	),
+
+	CPER_CXL_EVT_TP_printk("%s",
+		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
+);
+
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */

-- 
2.43.0


