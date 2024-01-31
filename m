Return-Path: <linux-efi+bounces-443-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7293D844D6F
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23DF1F26DC4
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 23:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B763B19E;
	Wed, 31 Jan 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Erg4DIo5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11213A8E3;
	Wed, 31 Jan 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745343; cv=none; b=UKULoq35TD5jKECpH8RkmDfQJ1AinRCJGbHujuijkVGFcWnFQIWKw+Zftu1swAcjGSiPW2rQWW4KzH+vDl4Cgo0tHPopUVj3RedPriV8KLV4HqkpKNDaHnEe+nKB5jMnp+NlCCHXb47ABup7XouHMT4yUbQNRjBPCyGeC2Sb/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745343; c=relaxed/simple;
	bh=+pvEwzCD7x/Hyfef0NHFwqsH416wRZ6bX4MkIzq3/X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHuGuoq0F6/yWtUiy3GfV/QRcgaEyT337nsI0TYXjGRRsa4JImhWgbQKj0R20o8wnSHbXjBYArfxvEEBnHhciX9jQhJFdQGj3VzgpbiTUpnOAvUiqX7h9x5z7U0GKfCdps1FRbHZ+mDsQ+9gYW3xjAvKyDaMG4P6SN9HfdLmWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Erg4DIo5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706745342; x=1738281342;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+pvEwzCD7x/Hyfef0NHFwqsH416wRZ6bX4MkIzq3/X0=;
  b=Erg4DIo5iyYc16U3zG0ykicSdKVXp4Z0qgGRfHsCrYXvMYo9AO5Wn8we
   /5NhL9kJLbRPxNPTaClRq3wO5E5teGlN6p/VvlOWtbIYicepgdp/yZlsX
   S90QgzrDENVpjFjn4pW0iPJVp48G0M87VruXzYblaFKgQemj+RibCsyND
   FBYHAizAbkdQoNAvoU703TZDBli2PMS1w3Fcn4i6Gvmy1XFckZCS6rE7z
   kdeUJEXlm6r0HhlC76CPa/86+UN+F6ZYfni9S8i2sYhPR5ePUDDLucW7S
   SW6Ipc8dRqfzFq/U2GzBZ6r605+EezTX156nM0DQinks07NFEbOn6Idzf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3597906"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3597906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822752087"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="822752087"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.174.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:40 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 31 Jan 2024 15:55:38 -0800
Subject: [PATCH 1/2] cxl/cper: Fix errant CPER prints for CXL events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
In-Reply-To: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706745337; l=5120;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=+pvEwzCD7x/Hyfef0NHFwqsH416wRZ6bX4MkIzq3/X0=;
 b=Zod7ZtGq72VUKujAfQKIcbpzz1z4qyWARkVMAdnwE45WI65zjtwQwfGJtidrtDv6zecQK+bS6
 ZERxxnGEdZXAvPzXvE3skfyWvk3Rnp4jAazEcLtCdXxFATUr54ooiBe
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Jonathan reports that CXL CPER events dump an extra generic error
message.

	{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
	{1}[Hardware Error]: event severity: recoverable
	{1}[Hardware Error]:  Error 0, type: recoverable
	{1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
	{1}[Hardware Error]:   section length: 0x90
	{1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086 ................
	{1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000 ................
	...

CXL events were rerouted though the CXL subsystem for additional
processing.  However, when that work was done it was missed that
cper_estatus_print_section() continued with a generic error message
which is confusing.

Teach CPER print code to ignore printing details of some section types.
Assign the CXL event GUIDs to this set to prevent confusing unknown
prints.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/acpi/apei/ghes.c    | 26 --------------------------
 drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
 include/linux/cper.h        | 23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7b7c605166e0..fe825a432c5b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -680,32 +680,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 static DECLARE_RWSEM(cxl_cper_rw_sem);
 static cxl_cper_callback cper_callback;
 
-/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
-
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
-	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
-
-/*
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-#define CPER_SEC_CXL_DRAM_GUID						\
-	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-#define CPER_SEC_CXL_MEM_MODULE_GUID					\
-	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
-
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
 {
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..9b3884ff81e6 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -523,6 +523,17 @@ static void cper_print_tstamp(const char *pfx,
 	}
 }
 
+struct ignore_section {
+	guid_t guid;
+	const char *name;
+};
+
+static const struct ignore_section ignore_sections[] = {
+	{ .guid = CPER_SEC_CXL_GEN_MEDIA_GUID, .name = "CXL General Media Event" },
+	{ .guid = CPER_SEC_CXL_DRAM_GUID, .name = "CXL DRAM Event" },
+	{ .guid = CPER_SEC_CXL_MEM_MODULE_GUID, .name = "CXL Memory Module Event" },
+};
+
 static void
 cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
 			   int sec_no)
@@ -543,6 +554,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		printk("%s""fru_text: %.20s\n", pfx, gdata->fru_text);
 
 	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	for (int i = 0; i < ARRAY_SIZE(ignore_sections); i++) {
+		if (guid_equal(sec_type, &ignore_sections[i].guid)) {
+			printk("%ssection_type: %s\n", newpfx, ignore_sections[i].name);
+			return;
+		}
+	}
+
 	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
 		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index c1a7dc325121..265b0f8fc0b3 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -90,6 +90,29 @@ enum {
 	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
 		  0x72, 0x2D, 0xEB, 0x41)
 
+/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
+	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CPER_SEC_CXL_DRAM_GUID						\
+	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CPER_SEC_CXL_MEM_MODULE_GUID					\
+	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
+
 /*
  * Flags bits definitions for flags in struct cper_record_header
  * If set, the error has been recovered

-- 
2.43.0


