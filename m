Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F724CD22B
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 11:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiCDKQ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiCDKQ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 05:16:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4119F474;
        Fri,  4 Mar 2022 02:16:07 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-254-208.2.247.pool.telefonica.de [2.247.254.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A55101EC01CE;
        Fri,  4 Mar 2022 11:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646388962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bFaJ+pgjAxFW1LzTGdEz+z955VNt8YjBwsq1/jL6288=;
        b=Ji5NmR69d3nEw00/ommsOZz1LzfeiY62ytQlOKgpXfBltHGFX6TEyYC8wDqDGS/4rqbal5
        TB6fRGJfGrBCLgkl+4X4X+nxtBISzKu9PgjsJxOdBRasXJDTplOdjTCeyuySfRvsRn/vfu
        ILEheq2gWk2CZhFPyhAZqCyFXzBbv78=
Date:   Fri, 4 Mar 2022 11:16:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v6 2/2] EDAC/ghes: use cper functions to avoid code
 duplication
Message-ID: <YiHm1WHwO6HigCZx@nazgul.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220303122626.99740-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303122626.99740-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 03, 2022 at 08:26:26PM +0800, Shuai Xue wrote:
> To Borislav: Sorry, I only delete the format change summary in this commit
> log in this version. If I missed any comments, could you please point out
> clearly? Thank you very much.

I can't be more clear than the below - I simply took your patch and
heavily massaged it because it is a lot quicker this way.

You can compare it with your version and see what needed to be changed.
And you can of course ask questios why, if it is not clear. But it
should be - a shortlog of what I did is also in the commit message.

Now, when you look at the resulting patch you can see what the change
does. Yours did more than one logical thing - which a patch should never
do.

Also, I'd really really urge you to read

Documentation/process/submitting-patches.rst

carefully before sending other patches. I won't do this heavy editing
in the future so you're going to have to read review comments and
*incorporate* them into your patches before submitting them again.

You can test the below on your machine now to make sure it still
performs as expected.

Thx.

---
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Thu, 3 Mar 2022 20:26:26 +0800
Subject: [PATCH] EDAC/ghes: Unify CPER memory error location reporting

Switch the GHES EDAC memory error reporting functions to use the common
CPER ones and get rid of code duplication.

  [ bp:
      - rewrite commit message, remove useless text
      - rip out useless reformatting
      - align function params on the opening brace
      - rename function to a more descriptive name
      - drop useless function exports
      - handle buffer lengths properly when printing other detail
      - remove useless casting
  ]

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220303122626.99740-3-xueshuai@linux.alibaba.com
---
 drivers/edac/Kconfig        |   1 +
 drivers/edac/ghes_edac.c    | 200 +++++++-----------------------------
 drivers/firmware/efi/cper.c |   4 +-
 include/linux/cper.h        |   2 +
 4 files changed, 42 insertions(+), 165 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..23f11554f400 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -55,6 +55,7 @@ config EDAC_DECODE_MCE
 config EDAC_GHES
 	bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
 	depends on ACPI_APEI_GHES && (EDAC=y)
+	select UEFI_CPER
 	help
 	  Not all machines support hardware-driven error report. Some of those
 	  provide a BIOS-driven error report mechanism via ACPI, using the
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6d1ddecbf0da..2805d5610300 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,11 +15,13 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
+#define OTHER_DETAIL_LEN	400
+
 struct ghes_pvt {
 	struct mem_ctl_info *mci;
 
 	/* Buffers for the error handling routine */
-	char other_detail[400];
+	char other_detail[OTHER_DETAIL_LEN];
 	char msg[80];
 };
 
@@ -235,8 +237,34 @@ static void ghes_scan_system(void)
 	system_scanned = true;
 }
 
+static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char *msg,
+					const char *location, unsigned int len)
+{
+	u32 n;
+
+	if (!msg)
+		return 0;
+
+	n = 0;
+	len -= 1;
+
+	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
+
+	if (!(mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS))
+		goto out;
+
+	n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
+	n += scnprintf(msg + n, len - n, "%s ", cper_mem_err_status_str(mem->error_status));
+
+out:
+	msg[n] = '\0';
+
+	return n;
+}
+
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
+	struct cper_mem_err_compact cmem;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
@@ -292,60 +320,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	/* Error type, mapped on e->msg */
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
+		u8 etype = mem_err->error_type;
+
 		p = pvt->msg;
-		switch (mem_err->error_type) {
-		case 0:
-			p += sprintf(p, "Unknown");
-			break;
-		case 1:
-			p += sprintf(p, "No error");
-			break;
-		case 2:
-			p += sprintf(p, "Single-bit ECC");
-			break;
-		case 3:
-			p += sprintf(p, "Multi-bit ECC");
-			break;
-		case 4:
-			p += sprintf(p, "Single-symbol ChipKill ECC");
-			break;
-		case 5:
-			p += sprintf(p, "Multi-symbol ChipKill ECC");
-			break;
-		case 6:
-			p += sprintf(p, "Master abort");
-			break;
-		case 7:
-			p += sprintf(p, "Target abort");
-			break;
-		case 8:
-			p += sprintf(p, "Parity Error");
-			break;
-		case 9:
-			p += sprintf(p, "Watchdog timeout");
-			break;
-		case 10:
-			p += sprintf(p, "Invalid address");
-			break;
-		case 11:
-			p += sprintf(p, "Mirror Broken");
-			break;
-		case 12:
-			p += sprintf(p, "Memory Sparing");
-			break;
-		case 13:
-			p += sprintf(p, "Scrub corrected error");
-			break;
-		case 14:
-			p += sprintf(p, "Scrub uncorrected error");
-			break;
-		case 15:
-			p += sprintf(p, "Physical Memory Map-out event");
-			break;
-		default:
-			p += sprintf(p, "reserved error (%d)",
-				     mem_err->error_type);
-		}
+		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
 	} else {
 		strcpy(pvt->msg, "unknown error");
 	}
@@ -362,52 +340,19 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	/* Memory error location, mapped on e->location */
 	p = e->location;
-	if (mem_err->validation_bits & CPER_MEM_VALID_NODE)
-		p += sprintf(p, "node:%d ", mem_err->node);
-	if (mem_err->validation_bits & CPER_MEM_VALID_CARD)
-		p += sprintf(p, "card:%d ", mem_err->card);
-	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE)
-		p += sprintf(p, "module:%d ", mem_err->module);
-	if (mem_err->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
-		p += sprintf(p, "rank:%d ", mem_err->rank);
-	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
-		p += sprintf(p, "bank:%d ", mem_err->bank);
-	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_GROUP)
-		p += sprintf(p, "bank_group:%d ",
-			     mem_err->bank >> CPER_MEM_BANK_GROUP_SHIFT);
-	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
-		p += sprintf(p, "bank_address:%d ",
-			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
-	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
-		u32 row = mem_err->row;
-
-		row |= cper_get_mem_extension(mem_err->validation_bits, mem_err->extended);
-		p += sprintf(p, "row:%d ", row);
-	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
-		p += sprintf(p, "col:%d ", mem_err->column);
-	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
-		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
+	cper_mem_err_pack(mem_err, &cmem);
+	p += cper_mem_err_location(&cmem, p);
+
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
-		const char *bank = NULL, *device = NULL;
 		struct dimm_info *dimm;
 
-		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
-		if (bank != NULL && device != NULL)
-			p += sprintf(p, "DIMM location:%s %s ", bank, device);
-		else
-			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
-				     mem_err->mem_dev_handle);
-
+		p += cper_dimm_err_location(&cmem, p);
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
 			strcpy(e->label, dimm->label);
 		}
 	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		p += sprintf(p, "chipID: %d ",
-			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
 	if (p > e->location)
 		*(p - 1) = '\0';
 
@@ -416,78 +361,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
-	p += snprintf(p, sizeof(pvt->other_detail),
-		"APEI location: %s ", e->location);
-	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
-		u64 status = mem_err->error_status;
-
-		p += sprintf(p, "status(0x%016llx): ", (long long)status);
-		switch ((status >> 8) & 0xff) {
-		case 1:
-			p += sprintf(p, "Error detected internal to the component ");
-			break;
-		case 16:
-			p += sprintf(p, "Error detected in the bus ");
-			break;
-		case 4:
-			p += sprintf(p, "Storage error in DRAM memory ");
-			break;
-		case 5:
-			p += sprintf(p, "Storage error in TLB ");
-			break;
-		case 6:
-			p += sprintf(p, "Storage error in cache ");
-			break;
-		case 7:
-			p += sprintf(p, "Error in one or more functional units ");
-			break;
-		case 8:
-			p += sprintf(p, "component failed self test ");
-			break;
-		case 9:
-			p += sprintf(p, "Overflow or undervalue of internal queue ");
-			break;
-		case 17:
-			p += sprintf(p, "Virtual address not found on IO-TLB or IO-PDIR ");
-			break;
-		case 18:
-			p += sprintf(p, "Improper access error ");
-			break;
-		case 19:
-			p += sprintf(p, "Access to a memory address which is not mapped to any component ");
-			break;
-		case 20:
-			p += sprintf(p, "Loss of Lockstep ");
-			break;
-		case 21:
-			p += sprintf(p, "Response not associated with a request ");
-			break;
-		case 22:
-			p += sprintf(p, "Bus parity error - must also set the A, C, or D Bits ");
-			break;
-		case 23:
-			p += sprintf(p, "Detection of a PATH_ERROR ");
-			break;
-		case 25:
-			p += sprintf(p, "Bus operation timeout ");
-			break;
-		case 26:
-			p += sprintf(p, "A read was issued to data that has been poisoned ");
-			break;
-		default:
-			p += sprintf(p, "reserved ");
-			break;
-		}
-	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
-		p += sprintf(p, "requestorID: 0x%016llx ",
-			     (long long)mem_err->requestor_id);
-	if (mem_err->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
-		p += sprintf(p, "responderID: 0x%016llx ",
-			     (long long)mem_err->responder_id);
-	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		p += sprintf(p, "targetID: 0x%016llx ",
-			     (long long)mem_err->responder_id);
+	p += print_mem_error_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
 	if (p > pvt->other_detail)
 		*(p - 1) = '\0';
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 34eeaa59f04a..215c778fb33c 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -237,7 +237,7 @@ const char *cper_mem_err_status_str(u64 status)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
 
-static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 
@@ -291,7 +291,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	return n;
 }
 
-static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 	const char *bank = NULL, *device = NULL;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 5b1dd27b317d..eacb7dd7b3af 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -569,5 +569,7 @@ void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
 
 #endif
-- 
2.23.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
