Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC604701F3
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 14:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhLJNoC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 08:44:02 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45544 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhLJNoB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Dec 2021 08:44:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-ADOcC_1639143620;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V-ADOcC_1639143620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 21:40:23 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v2 1/3] ghes_edac: unify memory error report format with cper
Date:   Fri, 10 Dec 2021 21:40:17 +0800
Message-Id: <20211210134019.28536-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The changes are to:

- add device info into ghes_edac
- change bit_pos to bit_position, col to column, requestorID to
  requestor_id, etc in ghes_edac
- move requestor_id, responder_id, target_id and chip_id into memory error
  location in ghes_edac
- add "DIMM location: not present." for DIMM location in ghes_edac
- remove the 'space' delimiter after the colon in ghes_edac and cper

The original EDAC and cper error log are as follows (all Validation Bits
are enabled):

[31940.060454] EDAC MC0: 1 CE Single-symbol ChipKill ECC on unknown memory (node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 page:0x93724c offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 status(0x0000000000000000): reserved requestorID: 0x0000000000000000 responderID: 0x0000000000000000 targetID: 0x0000000000000000)
[31940.060459] {3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[31940.060460] {3}[Hardware Error]: It has been corrected by h/w and requires no further action
[31940.060462] {3}[Hardware Error]: event severity: corrected
[31940.060463] {3}[Hardware Error]:  Error 0, type: corrected
[31940.060464] {3}[Hardware Error]:   section_type: memory error
[31940.060465] {3}[Hardware Error]:   error_status: 0x0000000000000000
[31940.060466] {3}[Hardware Error]:   physical_address: 0x000000093724c020
[31940.060466] {3}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[31940.060469] {3}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 257 bank_group: 1 bank_address: 1 device: 0 row: 75492 column: 8 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
[31940.060470] {3}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[31940.060471] {3}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000

Now, the EDAC and cper error log are properly reporting the error as
follows (all Validation Bits are enabled):

[  117.973657] EDAC MC0: 1 CE Single-symbol ChipKill ECC on 0x0000 (node:0 card:0 module:0 rank:0 bank:1026 bank_group:4 bank_address:2 device:0 row:6749 column:8 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0 DIMM location:not present. DIMM DMI handle:0x0000 page:0x8d2ef4 offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:1026 bank_group:4 bank_address:2 device:0 row:6749 column:8 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0 DIMM location:not present. DIMM DMI handle:0x0000 status(0x0000000000000000):reserved)
[  117.973663] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[  117.973664] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
[  117.973665] {2}[Hardware Error]: event severity: corrected
[  117.973666] {2}[Hardware Error]:  Error 0, type: corrected
[  117.973667] {2}[Hardware Error]:   section_type: memory error
[  117.973668] {2}[Hardware Error]:   error_status: 0x0000000000000000
[  117.973669] {2}[Hardware Error]:   physical_address: 0x00000008d2ef4020
[  117.973670] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[  117.973672] {2}[Hardware Error]:   node:0 card:0 module:0 rank:0 bank:1026 bank_group:4 bank_address:2 device:0 row:6749 column:8 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0
[  117.973673] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[  117.973674] {2}[Hardware Error]:   DIMM location: not present. DMI handle:0x0000

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/edac/ghes_edac.c    | 35 +++++++++++++++++++----------------
 drivers/firmware/efi/cper.c | 34 +++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6d1ddecbf0da..526a28cbb19b 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
 		p += sprintf(p, "bank_address:%d ",
 			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
+	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
+		p += sprintf(p, "device:%d ", mem_err->device);
 	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem_err->row;
 
@@ -385,9 +387,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "row:%d ", row);
 	}
 	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
-		p += sprintf(p, "col:%d ", mem_err->column);
+		p += sprintf(p, "column:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
-		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
+		p += sprintf(p, "bit_position:%d ", mem_err->bit_pos);
+	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
+		p += sprintf(p, "requestor_id:0x%016llx ",
+			     (long long)mem_err->requestor_id);
+	if (mem_err->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
+		p += sprintf(p, "responder_id:0x%016llx ",
+			     (long long)mem_err->responder_id);
+	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
+		p += sprintf(p, "target_id:0x%016llx ",
+			     (long long)mem_err->responder_id);
+	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		p += sprintf(p, "chip_id:%d ",
+			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
 		struct dimm_info *dimm;
@@ -396,7 +410,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		if (bank != NULL && device != NULL)
 			p += sprintf(p, "DIMM location:%s %s ", bank, device);
 		else
-			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
+			p += sprintf(p, "DIMM location:not present. DIMM DMI handle:0x%.4x ",
 				     mem_err->mem_dev_handle);
 
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
@@ -405,9 +419,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			strcpy(e->label, dimm->label);
 		}
 	}
-	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		p += sprintf(p, "chipID: %d ",
-			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
 	if (p > e->location)
 		*(p - 1) = '\0';
 
@@ -421,7 +432,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
 		u64 status = mem_err->error_status;
 
-		p += sprintf(p, "status(0x%016llx): ", (long long)status);
+		p += sprintf(p, "status(0x%016llx):", (long long)status);
 		switch ((status >> 8) & 0xff) {
 		case 1:
 			p += sprintf(p, "Error detected internal to the component ");
@@ -479,15 +490,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
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
index 6ec8edec6329..77b39b058924 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -221,45 +221,45 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
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
@@ -276,10 +276,10 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 	len = CPER_REC_LEN;
 	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
-		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
+		n = snprintf(msg, len, "DIMM location:%s %s ", bank, device);
 	else
 		n = snprintf(msg, len,
-			     "DIMM location: not present. DMI handle: 0x%.4x ",
+			     "DIMM location: not present. DMI handle:0x%.4x ",
 			     mem->mem_dev_handle);
 
 	return n;
-- 
2.20.1.12.g72788fdb

