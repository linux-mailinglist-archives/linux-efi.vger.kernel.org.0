Return-Path: <linux-efi+bounces-959-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8D8AD73C
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D511C20EDC
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74212E648;
	Mon, 22 Apr 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuAZUa8V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35E20B3E;
	Mon, 22 Apr 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824751; cv=none; b=rodG5pXWE5JIKPbTbUFEu6hNJnxV8FSs3x1zRLuQcm5ONBUIJyZtReSDAQcpyT+qPPLiWwdmyf3WOwx+hX2xNg2HK4wutPCCV39o/o525Oz4RrsolESzoHAbq6QJh6w7CXTV8g7PMxLFvqsAQ/pIv/pDNWm4NZbeu30KuNSsl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824751; c=relaxed/simple;
	bh=HSlzvekfuGX48lbMZ9IX5Hy3qmdabMn0Ull4KJcDRVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8xjr2SvGpLvDBU6TA706nXAtUwjLqdHQYxmdbLmssnIdfrj5qieCG0b56h08lZGndRQzJYdGhW281F/aOI2XtNS4ic1qVh3V2fOHtxa5keyGAii4iV+COa22JS3KjvPhr7s+4e3onHdpcD3yEf7K7Tie3EKXSIFQYlzAX08f7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuAZUa8V; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824750; x=1745360750;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HSlzvekfuGX48lbMZ9IX5Hy3qmdabMn0Ull4KJcDRVM=;
  b=kuAZUa8Vy1fJBIlzosVkKiPIeo7TuKub8Kw2ykPcUm5tF/3I3Oxghh+K
   /qT369qyKF/2tPpZ22pPqZ7AnlCkZYpS4U3AqGKL8ICGX7nklW1R/vRWK
   voiSvbXXnKuev24h2TNHwKYH1+GRf9fOL0mNROLRn6N+BqXofb/3VcnVU
   gZb8iSoHRm5rKdKbXMONR7eB1pHKYtV/N+zHHvE2aygAspRG7W15/EmxJ
   qJzr1kXCwrKxll9r5B8omzmtBt/R4PhrOHUOOqiZzIvqGfg3PkpnZSkKq
   bn1zyIQ0ochgWjhnzku2dtnIejtGh3635PqES7BCI137Irn/JK4ey3AaJ
   g==;
X-CSE-ConnectionGUID: 1GEI5y4zTiyxdZzV1ESeFw==
X-CSE-MsgGUID: SNilurnvQUqmKowBdvvnPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19997738"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19997738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:49 -0700
X-CSE-ConnectionGUID: KaP251WmQPmwkshi1SNWFQ==
X-CSE-MsgGUID: VdtjcoDqS+Ocz9cetqBZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55094329"
Received: from iweiny-mobl.sc.intel.com (HELO localhost) ([10.144.160.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:48 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 22 Apr 2024 15:25:47 -0700
Subject: [PATCH v2 3/3] ras/events: Trace CXL CPER events without CXL stack
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-cxl-cper3-v2-3-5cdd378fcd0b@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713824744; l=3872;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=HSlzvekfuGX48lbMZ9IX5Hy3qmdabMn0Ull4KJcDRVM=;
 b=8TPefWkzkSCNtXmWmjR1wes/F764EaD2M5Yrgi3deqbnXKg0K4/7HnVUO66PpoJ8FXKqEtkHO
 ru1z8cm6RgiCI7Fgtfn047S3fakhQXrigDSlPLYQUF+WV1cEkWieNr0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

If CXL is solely managed by firmware (including HDM configuration and
event processing via firmware first) it is possible to run the system
without the CXL software loaded.  In this case no CXL callback will be
loaded and CXL CPER errors will not be processed at all.

In this case memory device and region (HPA) information is missing but
omitting the error completely is not friendly.  Some device information
is available the event.

Trace CXL CPER events if the CXL stack is not loaded.  A balance was
chosen to decode only the CPER header as this configuration is likely
rare.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[djbw: remove local work task and call trace directly]
[djbw: strip down the generic trace information]
---
 drivers/acpi/apei/ghes.c |  6 +++++-
 include/ras/ras_event.h  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cdcfdf6ebe81..20a0e622f829 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -739,8 +739,12 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 	guard(spinlock_irqsave)(&cxl_cper_work_lock);
 
-	if (!cxl_cper_work)
+	if (!cxl_cper_work) {
+		union cxl_event *evt = &rec->event;
+
+		trace_cper_cxl_event(rec, &evt->generic, event_type);
 		return;
+	}
 
 	wd.event_type = event_type;
 	memcpy(&wd.rec, rec, sizeof(wd.rec));
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c011ea236e9b..c1fac66fb44a 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -422,6 +422,57 @@ TRACE_EVENT(memory_failure_event,
 	)
 );
 #endif /* CONFIG_MEMORY_FAILURE */
+
+#include <linux/cxl-event.h>
+#include <asm-generic/unaligned.h>
+
+TRACE_EVENT(cper_cxl_event,
+
+	TP_PROTO(struct cxl_cper_event_rec *cper_rec,
+		 struct cxl_event_generic *gen_rec,
+		 enum cxl_event_type event_type),
+
+	TP_ARGS(cper_rec, gen_rec, event_type),
+
+	/* packed record */
+	TP_STRUCT__entry(
+		__field(u16, segment)
+		__field(u8, bus)
+		__field(u8, device)
+		__field(u32, hdr_flags)
+		__field(u64, serial)
+		__field(u64, hdr_timestamp)
+		__field(u8, func)
+		__field(u8, hdr_length)
+		__field(u8, hdr_maint_op_class)
+		__field(u8, event_type)
+		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
+	),
+
+	TP_fast_assign(
+		__entry->event_type = event_type;
+		__entry->segment = cper_rec->hdr.device_id.segment_num;
+		__entry->bus = cper_rec->hdr.device_id.bus_num;
+		__entry->device = cper_rec->hdr.device_id.device_num;
+		__entry->func = cper_rec->hdr.device_id.func_num;
+		__entry->serial = (((u64)cper_rec->hdr.dev_serial_num.upper_dw) << 32) |
+				 cper_rec->hdr.dev_serial_num.lower_dw;
+		__entry->hdr_length = gen_rec->hdr.length;
+		__entry->hdr_flags = get_unaligned_le24(gen_rec->hdr.flags);
+		__entry->hdr_timestamp = le64_to_cpu(gen_rec->hdr.timestamp);
+		__entry->hdr_maint_op_class = gen_rec->hdr.maint_op_class;
+		memcpy(__entry->data, gen_rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
+	),
+
+	TP_printk("device=%04x:%02x:%02x.%02x serial=%lld : event_type=%d time=%llu "
+		  "len=%d flags=%x maint_op_class=%u : %s",
+		__entry->segment, __entry->bus, __entry->device, __entry->func,
+		__entry->serial, __entry->event_type, __entry->hdr_timestamp,
+		__entry->hdr_length, __entry->hdr_flags, __entry->hdr_maint_op_class,
+		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
+
+);
+
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */

-- 
2.44.0


