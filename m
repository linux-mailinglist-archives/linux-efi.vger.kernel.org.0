Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63C1497786
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jan 2022 03:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiAXCsJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Jan 2022 21:48:09 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59440 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240765AbiAXCsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 23 Jan 2022 21:48:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2cQ9ls_1642992485;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2cQ9ls_1642992485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jan 2022 10:48:06 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [RESEND PATCH v3 2/2] EDAC/ghes: use cper functions to avoid code duplication
Date:   Mon, 24 Jan 2022 10:47:59 +0800
Message-Id: <20220124024759.19176-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory error location processing in ghes_edac_report_mem_error() have
Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
cper_mem_err_type_str() in drivers/firmware/efi/cper.c. To avoid the
duplicated code, introduce the above cper_*() into
ghes_edac_report_mem_error().

A side effect is that the report format in ghes_edac is changed. The
changes are to:

- add device info into ghes_edac
- change bit_pos to bit_position, col to column, requestorID to
  requestor_id, etc in ghes_edac
- move requestor_id, responder_id, target_id and chip_id into memory error
  location in ghes_edac
- add "DIMM location: not present." for DIMM location in ghes_edac
- remove the 'space' delimiter after the colon in cper_mem_err_location(), suggested by Robert

The original EDAC and cper error log are as follows (all Validation Bits
are enabled):
--------------------------------------------------------------------
[  281.759984] EDAC MC0: 1 CE Single-symbol ChipKill ECC on unknown memory (node:0 card:0 module:0 rank:0 bank:1793 bank_group:7 bank_address:1 row:5310 col:520 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 page:0x8a5f45 offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:1793 bank_group:7 bank_address:1 row:5310 col:520 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 status(0x0000000000000000): reserved requestorID: 0x0000000000000000 responderID: 0x0000000000000000 targetID: 0x0000000000000000)
[  281.818273] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[  281.828878] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
[  281.839687] {2}[Hardware Error]: event severity: corrected
[  281.847522] {2}[Hardware Error]:  Error 0, type: corrected
[  281.855331] {2}[Hardware Error]:   section_type: memory error
[  281.863389] {2}[Hardware Error]:   error_status: 0x0000000000000000
[  281.871983] {2}[Hardware Error]:   physical_address: 0x00000008a5f45020
[  281.880944] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[  281.890361] {2}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 1793 bank_group: 7 bank_address: 1 device: 0 row: 5310 column: 520 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 target_id: 0x0000000000000000 chip_id: 0
[  281.921361] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[  281.931021] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
--------------------------------------------------------------------

Now, the EDAC and cper error log are properly reporting the error as
follows (all Validation Bits are enabled):
--------------------------------------------------------------------
[ 2335.677847] EDAC MC0: 1 CE single-symbol chipkill ECC on 0x0000 (node:0 card:0 module:0 rank:0 bank:770 bank_group:3 bank_address:2 device:0 row:6510 column:1544 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0 DIMM location: not present. DMI handle: 0x0000 page:0x8cb743 offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:770 bank_group:3 bank_address:2 device:0 row:6510 column:1544 bit_position:0 requestor_id: 0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0 DIMM location: not present. DMI handle: 0x0000 status(0x0000000000000000): reserved)
[ 2335.753234] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[ 2335.763930] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
[ 2335.774828] {2}[Hardware Error]: event severity: corrected
[ 2335.782761] {2}[Hardware Error]:  Error 0, type: corrected
[ 2335.790671] {2}[Hardware Error]:   section_type: memory error
[ 2335.798838] {2}[Hardware Error]:   error_status: 0x0000000000000000, reserved
[ 2335.808444] {2}[Hardware Error]:   physical_address: 0x00000008cb743020
[ 2335.817552] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[ 2335.827098] {2}[Hardware Error]:   node:0 card:0 module:0 rank:0 bank:770 bank_group:3 bank_address:2 device:0 row:6510 column:1544 bit_position:0 requestor_id: 0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0
[ 2335.857212] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[ 2335.867001] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
--------------------------------------------------------------------

NOTE: Not all bits are populated by BIOS in my platform, I manually enable all
validation bits during test so that we can see log message and differences of
all fields more clearly. Therefore, the values of some fields look strange.

        +       mem_err->validation_bits = 0xfffffffffffffff;

Although the UEFI_CPER/EDAC_GHES dependency is always solved through
ACPI_APEI_GHES/ACPI_APEI, add the UEFI_CPER dependency explicitly for
EDAC_GHES in Kconfig.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/edac/Kconfig        |   1 +
 drivers/edac/ghes_edac.c    | 196 +++++++-----------------------------
 drivers/firmware/efi/cper.c |  36 +++----
 include/linux/cper.h        |   2 +
 4 files changed, 56 insertions(+), 179 deletions(-)

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
index 6d1ddecbf0da..94e9f6b45817 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -235,10 +235,36 @@ static void ghes_scan_system(void)
 	system_scanned = true;
 }
 
+static int ghes_edac_mem_err_other_detail(const struct cper_sec_mem_err *mem,
+				char *msg, const char *location)
+{
+	u32 len, n;
+
+	if (!msg)
+		return 0;
+
+	n = 0;
+	len = 2 * CPER_REC_LEN - 1;
+
+	n += snprintf(msg + n, len - n, "APEI location: %s ", location);
+
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
+		u64 status = mem->error_status;
+
+		n += snprintf(msg + n, len - n,  "status(0x%016llx): ",
+				(long long)status);
+		n += snprintf(msg + n, len - n, "%s ", cper_mem_err_status_str(status));
+	}
+
+	msg[n] = '\0';
+	return n;
+}
+
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
+	struct cper_mem_err_compact cmem;
 	struct ghes_pvt *pvt;
 	unsigned long flags;
 	char *p;
@@ -292,60 +318,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
@@ -362,52 +338,19 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
 
@@ -416,78 +359,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
+	p += ghes_edac_mem_err_other_detail(mem_err, p, e->location);
 	if (p > pvt->other_detail)
 		*(p - 1) = '\0';
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index addafccecd84..3efec4aca212 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -254,7 +254,7 @@ const char *cper_mem_err_status_str(u64 status)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
 
-static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 
@@ -264,51 +264,52 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	n = 0;
 	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
-		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
+		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
-		n += scnprintf(msg + n, len - n, "card: %d ", mem->card);
+		n += scnprintf(msg + n, len - n, "card:%d ", mem->card);
 	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
-		n += scnprintf(msg + n, len - n, "module: %d ", mem->module);
+		n += scnprintf(msg + n, len - n, "module:%d ", mem->module);
 	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
-		n += scnprintf(msg + n, len - n, "rank: %d ", mem->rank);
+		n += scnprintf(msg + n, len - n, "rank:%d ", mem->rank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK)
-		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
+		n += scnprintf(msg + n, len - n, "bank:%d ", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK_GROUP)
-		n += scnprintf(msg + n, len - n, "bank_group: %d ",
+		n += scnprintf(msg + n, len - n, "bank_group:%d ",
 			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
-		n += scnprintf(msg + n, len - n, "bank_address: %d ",
+		n += scnprintf(msg + n, len - n, "bank_address:%d ",
 			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
-		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
+		n += scnprintf(msg + n, len - n, "device:%d ", mem->device);
 	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem->row;
 
 		row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
-		n += scnprintf(msg + n, len - n, "row: %d ", row);
+		n += scnprintf(msg + n, len - n, "row:%d ", row);
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
-		n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
+		n += scnprintf(msg + n, len - n, "column:%d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
-		n += scnprintf(msg + n, len - n, "bit_position: %d ",
+		n += scnprintf(msg + n, len - n, "bit_position:%d ",
 			       mem->bit_pos);
 	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
-		n += scnprintf(msg + n, len - n, "requestor_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "requestor_id:0x%016llx ",
 			       mem->requestor_id);
 	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
-		n += scnprintf(msg + n, len - n, "responder_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "responder_id:0x%016llx ",
 			       mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		n += scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
+		n += scnprintf(msg + n, len - n, "target_id:0x%016llx ",
 			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		n += scnprintf(msg + n, len - n, "chip_id: %d ",
+		n += scnprintf(msg + n, len - n, "chip_id:%d ",
 			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_location);
 
-static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 	const char *bank = NULL, *device = NULL;
@@ -327,6 +328,7 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_dimm_err_location);
 
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
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
2.20.1.12.g72788fdb

