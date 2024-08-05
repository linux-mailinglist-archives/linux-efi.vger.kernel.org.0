Return-Path: <linux-efi+bounces-1533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D5947B54
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58322281F23
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35F15AD8B;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl36+k44"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF57159209;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862446; cv=none; b=EY+1Jtl3mfoDdF2ScF6V1NM3WMjjIKIlnRbtSKlpChDZK/odGUfdZ07gCrhqzNTR7RabgtAdbi4B8MHxr0EOUKZISX1tb8Sxihh3I9QsioTy9d85HMN4fx/8/m77bpBOw7T10VRHstpUS7ERtrisNYZ3BlqIt1GVEmCe5WAmyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862446; c=relaxed/simple;
	bh=qvrl/9oyuQCy8rh63h+2SLCQP0eGNCvXSDn8ZBYMvGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgK3grvtnypRuXlOYUy3ongQHbwrPKzhoLIO5jRetjrXzIRhzNwObT3GMg0Eiov4YTI0rZv1RV0dtJBakgvk2kFDOjDhOb/kva8BZHjSsCirswwu0BlGdURqQtPY3iPh9zk8xTYmPnXkw5w1ziWHS9TB5p9nyHRGsa1zS1pvMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl36+k44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA13DC4AF12;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862446;
	bh=qvrl/9oyuQCy8rh63h+2SLCQP0eGNCvXSDn8ZBYMvGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl36+k44RfYZ/VJm2jDGagXNGHyCk2DO0SeP1iUhXqbPfX9N2ecEjPeYRuBZXi8vx
	 Sp8fBhl2ylBDB+/FkjEnVWibwql155OOb001J5Bzvx1xd4Fy1IFuJJdhwVBwcqP3g7
	 X3tSKVGptdfLCHEAGESSkFiPgc+8kfe5BrJNiesn2gqTOY60VNbXDpDkvaBKSdBDIl
	 9QsKvRVauPSOsQJSrYVGgeeHiHbEDg/j1639bOATlacP5dG9EEjRIjerVi+qY+op60
	 4Nr22REZs3BbZVIM1aEitnM5738eZz5lu2+0gPSthIcwf9hEJM51xrk8+nXl2kkgl2
	 ISeXZNQRpuB7Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1saxDv-0000000CyYs-3saR;
	Mon, 05 Aug 2024 14:54:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Rafael J. Wysocki" <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alison Schofield <alison.schofield@intel.com>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <mchehab+huawei@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
Date: Mon,  5 Aug 2024 14:53:35 +0200
Message-ID: <65cab717663e79def53d156ccf689235769b070c.1722861911.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722861911.git.mchehab+huawei@kernel.org>
References: <cover.1722861911.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Up to UEFI spec 2.9, the type byte of CPER struct for ARM processor
was defined simply as:

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

Spec 2.10 also preserve the same encoding as 2.9A.

Adjust CPER and GHES handling code for both generic and ARM
processors to properly handle UEFI 2.9A and 2.10 encoding.

Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c        | 15 ++++++----
 drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++-----------------
 include/linux/cper.h            | 10 +++----
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 06d9351a9abc..d7d78d546f68 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -533,6 +533,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -545,9 +546,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-		const char *error_type = "unknown error";
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
@@ -561,12 +561,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
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
index 25858a7608b7..3670b866ac11 100644
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


