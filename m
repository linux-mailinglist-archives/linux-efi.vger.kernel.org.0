Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6646B163
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 04:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhLGDWp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 22:22:45 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:32920 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhLGDWn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 22:22:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Uzhxh3P_1638847148;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Uzhxh3P_1638847148)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 11:19:10 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH 1/2] ghes_edac: refactor memory error location processing
Date:   Tue,  7 Dec 2021 11:19:04 +0800
Message-Id: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory error location processing in ghes_edac_report_mem_error() have
Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
cper_mem_err_type_str() in drivers/firmware/efi/cper.c.

To avoid the duplicated code, this patch introduces the above cper_*() into
ghes_edac_report_mem_error().

The EDAC error log is now properly reporting the error as follows (all
Validation Bits are enabled):

[  375.938411] EDAC MC0: 1 CE single-symbol chipkill ECC on unknown memory (node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 page:0x898b86 offset:0x20 grain:1 syndrome:0x0 - APEI location: node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 status(0x0000000000000000): reserved)
[  375.938416] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[  375.938417] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
[  375.938418] {2}[Hardware Error]: event severity: corrected
[  375.938419] {2}[Hardware Error]:  Error 0, type: corrected
[  375.938420] {2}[Hardware Error]:   section_type: memory error
[  375.938421] {2}[Hardware Error]:   error_status: 0x0000000000000000
[  375.938422] {2}[Hardware Error]:   physical_address: 0x0000000898b86020
[  375.938422] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[  375.938426] {2}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
[  375.938426] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[  375.938428] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/edac/ghes_edac.c    | 108 ++++--------------------------------
 drivers/firmware/efi/cper.c |   4 +-
 include/linux/cper.h        |   2 +
 3 files changed, 14 insertions(+), 100 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6d1ddecbf0da..7b25c3207c11 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -239,6 +239,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
+	struct cper_mem_err_compact cmem;
 	struct ghes_pvt *pvt;
 	unsigned long flags;
 	char *p;
@@ -292,60 +293,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
@@ -362,42 +313,13 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
+		p += cper_dimm_err_location(&cmem, p);
 
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
@@ -405,9 +327,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			strcpy(e->label, dimm->label);
 		}
 	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		p += sprintf(p, "chipID: %d ",
-			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
+
 	if (p > e->location)
 		*(p - 1) = '\0';
 
@@ -479,15 +399,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			break;
 		}
 	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
-		p += sprintf(p, "requestorID: 0x%016llx ",
-			     (long long)mem_err->requestor_id);
-	if (mem_err->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
-		p += sprintf(p, "responderID: 0x%016llx ",
-			     (long long)mem_err->responder_id);
-	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		p += sprintf(p, "targetID: 0x%016llx ",
-			     (long long)mem_err->responder_id);
+
 	if (p > pvt->other_detail)
 		*(p - 1) = '\0';
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 6ec8edec6329..08eabb2e23f8 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -211,7 +211,7 @@ const char *cper_mem_err_type_str(unsigned int etype)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
 
-static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 
@@ -265,7 +265,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	return n;
 }
 
-static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 	const char *bank = NULL, *device = NULL;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 6a511a1078ca..918e7efffb60 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -568,5 +568,7 @@ void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
 
 #endif
-- 
2.20.1.12.g72788fdb

