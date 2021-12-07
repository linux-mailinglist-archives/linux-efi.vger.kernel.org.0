Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DC46B162
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 04:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhLGDWr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 22:22:47 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47463 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233757AbhLGDWo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 22:22:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Uzhxh3P_1638847148;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Uzhxh3P_1638847148)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 11:19:11 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH 2/2] ghes_edac: refactor error status fields decoding
Date:   Tue,  7 Dec 2021 11:19:05 +0800
Message-Id: <20211207031905.61906-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ghes_edac_report_mem_error() in ghes_edac.c is a Long Method in which the
error status fields decoding could be refactored for reuse. On the other
hand, the cper_print_mem() only reports the error status and misses its
description.

This patch introduces a new helper function cper_mem_err_status_str() which
is used to wrap up the decoding logics, and the cper_print_mem() will call
it and report the details of error status description.

The cper error log is now properly reporting the error as follows (all
Validation Bits are enabled):

[37863.026267] EDAC MC0: 1 CE single-symbol chipkill ECC on unknown memory (node: 0 card: 0 module: 0 rank: 0 bank: 1282 bank_group: 5 bank_address: 2 device: 0 row: 11387 column: 1544 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 page:0x963d9b offset:0x20 grain:1 syndrome:0x0 - APEI location: node: 0 card: 0 module: 0 rank: 0 bank: 1282 bank_group: 5 bank_address: 2 device: 0 row: 11387 column: 1544 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 status(0x0000000000000000): reserved)
[37863.026272] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[37863.026273] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
[37863.026275] {2}[Hardware Error]: event severity: corrected
[37863.026276] {2}[Hardware Error]:  Error 0, type: corrected
[37863.026278] {2}[Hardware Error]:   section_type: memory error
[37863.026279] {2}[Hardware Error]:   error_status: 0x0000000000000000, reserved
[37863.026279] {2}[Hardware Error]:   physical_address: 0x0000000963d9b020
[37863.026280] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
[37863.026282] {2}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 1282 bank_group: 5 bank_address: 2 device: 0 row: 11387 column: 1544 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
[37863.026283] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[37863.026284] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/edac/ghes_edac.c    | 89 +++++++++++--------------------------
 drivers/firmware/efi/cper.c | 49 ++++++++++++++++++--
 include/linux/cper.h        |  5 ++-
 3 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7b25c3207c11..b74ffd82f56b 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -235,6 +235,31 @@ static void ghes_scan_system(void)
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
@@ -336,69 +361,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
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
+	p += ghes_edac_mem_err_other_detail(mem_err, p, e->location);
 
 	if (p > pvt->other_detail)
 		*(p - 1) = '\0';
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 08eabb2e23f8..6bf3e293c006 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -211,7 +211,7 @@ const char *cper_mem_err_type_str(unsigned int etype)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
 
-int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_mem_err_location(const struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 
@@ -265,7 +265,7 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	return n;
 }
 
-int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_dimm_err_location(const struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
 	const char *bank = NULL, *device = NULL;
@@ -285,6 +285,48 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 	return n;
 }
 
+const char *cper_mem_err_status_str(u64 status)
+{
+	switch ((status >> 8) & 0xff) {
+	case 1:
+		return "Error detected internal to the component";
+	case 16:
+		return "Error detected in the bus";
+	case 4:
+		return "Storage error in DRAM memory";
+	case 5:
+		return "Storage error in TLB";
+	case 6:
+		return "Storage error in cache";
+	case 7:
+		return "Error in one or more functional units";
+	case 8:
+		return "component failed self test";
+	case 9:
+		return "Overflow or undervalue of internal queue";
+	case 17:
+		return "Virtual address not found on IO-TLB or IO-PDIR";
+	case 18:
+		return "Improper access error";
+	case 19:
+		return "Access to a memory address which is not mapped to any component";
+	case 20:
+		return "Loss of Lockstep";
+	case 21:
+		return "Response not associated with a request";
+	case 22:
+		return "Bus parity error - must also set the A, C, or D Bits";
+	case 23:
+		return "Detection of a PATH_ERROR ";
+	case 25:
+		return "Bus operation timeout";
+	case 26:
+		return "A read was issued to data that has been poisoned";
+	default:
+		return "reserved";
+	}
+}
+
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
 {
@@ -334,7 +376,8 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		return;
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
-		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
+		printk("%s""error_status: 0x%016llx, %s\n", pfx, mem->error_status,
+				cper_mem_err_status_str(mem->error_status));
 	if (mem->validation_bits & CPER_MEM_VALID_PA)
 		printk("%s""physical_address: 0x%016llx\n",
 		       pfx, mem->physical_addr);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 918e7efffb60..a45fb7ceacf8 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -568,7 +568,8 @@ void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
-int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
-int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
+int cper_mem_err_location(const struct cper_mem_err_compact *mem, char *msg);
+int cper_dimm_err_location(const struct cper_mem_err_compact *mem, char *msg);
+const char *cper_mem_err_status_str(u64 status);
 
 #endif
-- 
2.20.1.12.g72788fdb

