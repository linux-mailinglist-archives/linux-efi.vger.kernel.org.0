Return-Path: <linux-efi+bounces-1375-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B092A0E3
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED251C211BD
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A807E57F;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqocIwNf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874F7D06E;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=MZK9dZOMndPsMtkarJnBpOR9hJaamz/Wsus/ip74QfbrxREwORYpGdTsMJUHbcNdvoesWz0IGW2mLGjYCm8rgvma/Kbx67iMMGSv447xnuAhT1ztRpP9pds/e1ZTbtkmB9q83mKrLL14pQaBhzcijOWpfzoOCsEHsW5UExFQLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=6zeKktLBxvGVhQx+TZOJafFPKQrmsZYPJP+g/sKx30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amzGOxVdOvDZLuE5I1vRWFe/IfLHq4Re0C+lbANVMSkbNrrDJLeEXxgm5HSWHvM3fsgweJUN1wRoC7jyXomi4U5HoL4cCybBAU3PZPWyDJNT/36nFMs75mkrfgzqgzFPS3sfGOU0Lk572WtOZSTyGH3Az66SRw/XLDAXxuqffns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqocIwNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB01C4AF10;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=6zeKktLBxvGVhQx+TZOJafFPKQrmsZYPJP+g/sKx30k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqocIwNfR/jgQhwDXse5JckjIub1RpNN2L/UiAHX+ATt1a/kbgcpd4A2bhtAYOMwx
	 YI72b5bTHLQshswE3CgJRB/W3NlY9WPfHYLqhtODYcGuZPljAQtr/vuLuMemE6fApw
	 cwjNXriGHt2oV2VED58VMaha6XVcqnlmsDwpZeKFCmSb1BGIxoZDMpVO5K4vhIPa3m
	 WQblPD4EjFBmVMv3cojTmzwMiQl6ioeuaCGEUBjp9FJ7Mf6NwdFcOADgY2woFEopZm
	 Fm45kDl/UwwJ+OsSsYG6QSBi/zszw47Qp1gXkUCkr4Ng/usYlblNm0V05lCN6YBEFD
	 85I5vqArT0qow==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQp-2jes;
	Mon, 08 Jul 2024 13:19:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
Date: Mon,  8 Jul 2024 13:18:14 +0200
Message-ID: <ecdee36a787c1ec2c3982e376db3d09576e07a27.1720436039.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Up to UEFI spec, the type byte of CPER struct for ARM processor was
defined simply as:

Type at byte offset 4:

	- Cache error
	- TLB Error
	- Bus Error
	- Micro-architectural Error
	All other values are reserved

Yet, there was no information about how this would be encoded.

Spec 2.9A errata corrected it by defining:

	- Bit 1 - Cache Error
	- Bit 2 - TLB Error
	- Bit 3 - Bus Error
	- Bit 4 - Micro-architectural Error
	All other values are reserved

That actually aligns with the values already defined on older
versions at N.2.4.1. Generic Processor Error Section.

Spec 2.10 also preserve the same encoding as 2.9A

Adjust CPER and GHES handling code for both generic and ARM
processors to properly handle UEFI 2.9A and 2.10 encoding.

Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c        | 15 ++++++----
 drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++-----------------
 include/linux/cper.h            | 10 +++----
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 90efca025d27..e796140d93f0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -535,6 +535,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 #if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	char error_type[120];
 	int sec_sev, i;
 	char *p;
 
@@ -546,9 +547,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-		const char *error_type = "unknown error";
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
@@ -562,12 +562,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 			continue;
 		}
 
-		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
-			error_type = cper_proc_error_type_strs[err_info->type];
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
 
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type: %s\n",
-				    error_type);
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
 		p += err_info->length;
 	}
 #endif
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index eb7ee6af55f2..52d18490b59e 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -93,15 +93,11 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	bool proc_context_corrupt, corrected, precise_pc, restartable_pc;
 	bool time_out, access_mode;
 
-	/* If the type is unknown, bail. */
-	if (type > CPER_ARM_MAX_TYPE)
-		return;
-
 	/*
 	 * Vendor type errors have error information values that are vendor
 	 * specific.
 	 */
-	if (type == CPER_ARM_VENDOR_ERROR)
+	if (type & CPER_ARM_VENDOR_ERROR)
 		return;
 
 	if (error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) {
@@ -116,43 +112,38 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	if (error_info & CPER_ARM_ERR_VALID_OPERATION_TYPE) {
 		op_type = ((error_info >> CPER_ARM_ERR_OPERATION_SHIFT)
 			   & CPER_ARM_ERR_OPERATION_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_cache_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%scache error, operation type: %s\n", pfx,
 				       arm_cache_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_TLB_ERROR:
+		}
+		if (type & CPER_ARM_TLB_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_tlb_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sTLB error, operation type: %s\n", pfx,
 				       arm_tlb_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_BUS_ERROR:
+		}
+		if (type & CPER_ARM_BUS_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_bus_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sbus error, operation type: %s\n", pfx,
 				       arm_bus_err_op_strs[op_type]);
 			}
-			break;
 		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_LEVEL) {
 		level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
 			 & CPER_ARM_ERR_LEVEL_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR)
 			printk("%scache level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_TLB_ERROR:
+
+		if (type & CPER_ARM_TLB_ERROR)
 			printk("%sTLB level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_BUS_ERROR:
+
+		if (type & CPER_ARM_BUS_ERROR)
 			printk("%saffinity level at which the bus error occurred: %d\n",
 			       pfx, level);
-			break;
-		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
@@ -241,6 +232,7 @@ void cper_print_proc_arm(const char *pfx,
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
+	char error_type[120];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
@@ -289,9 +281,15 @@ void cper_print_proc_arm(const char *pfx,
 				       newpfx);
 		}
 
-		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
-			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
-			cper_proc_error_type_strs[err_info->type] : "unknown");
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		printk("%serror_type: 0x%02x: %s%s\n", newpfx, err_info->type,
+		       error_type,
+		       (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+
 		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
 			printk("%serror_info: 0x%016llx\n", newpfx,
 			       err_info->error_info);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index c2f14b916bfb..fc62a80575e8 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -293,11 +293,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
-#define CPER_ARM_CACHE_ERROR			0
-#define CPER_ARM_TLB_ERROR			1
-#define CPER_ARM_BUS_ERROR			2
-#define CPER_ARM_VENDOR_ERROR			3
-#define CPER_ARM_MAX_TYPE			CPER_ARM_VENDOR_ERROR
+#define CPER_ARM_ERR_TYPE_MASK			GENMASK(4,1)
+#define CPER_ARM_CACHE_ERROR			BIT(1)
+#define CPER_ARM_TLB_ERROR			BIT(2)
+#define CPER_ARM_BUS_ERROR			BIT(3)
+#define CPER_ARM_VENDOR_ERROR			BIT(4)
 
 #define CPER_ARM_ERR_VALID_TRANSACTION_TYPE	BIT(0)
 #define CPER_ARM_ERR_VALID_OPERATION_TYPE	BIT(1)
-- 
2.45.2


