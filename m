Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF024A1D5
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHSOg7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 10:36:59 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:2584 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgHSOg4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 10:36:56 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEScBp028763;
        Wed, 19 Aug 2020 14:36:51 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 3304nsxf2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:36:51 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id C764591;
        Wed, 19 Aug 2020 14:36:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 201855)
        id 696FD200FDA48; Wed, 19 Aug 2020 09:36:50 -0500 (CDT)
From:   Alex Kluver <alex.kluver@hpe.com>
To:     linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, mchehab@kernel.org, bp@alien8.de,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        kluveralex@gmail.com, Alex Kluver <alex.kluver@hpe.com>
Subject: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error Record
Date:   Wed, 19 Aug 2020 09:35:43 -0500
Message-Id: <20200819143544.155096-2-alex.kluver@hpe.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200819143544.155096-1-alex.kluver@hpe.com>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190128
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Memory errors could be printed with incorrect row values since the DIMM
size has outgrown the 16 bit row field in the CPER structure. UEFI
Specification Version 2.8 has increased the size of row by allowing it to
use the first 2 bits from a previously reserved space within the structure.

When needed, add the extension bits to the row value printed.

Based on UEFI 2.8 Table 299. Memory Error Record

Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
---

v1 -> v2:
   * Add static inline cper_get_mem_extension() to make it 
    more readable, as suggested by Borislav Petkov.

   * Add second patch for bank field, bank group, and chip id.

---
 drivers/edac/ghes_edac.c    |  8 ++++++--
 drivers/firmware/efi/cper.c |  9 +++++++--
 include/linux/cper.h        | 16 ++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..98fcdaf72a09 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -337,8 +337,12 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
-	if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
-		p += sprintf(p, "row:%d ", mem_err->row);
+	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row = mem_err->row;
+
+		row |= cper_get_mem_extension(mem_err->validation_bits, mem_err->extended);
+		p += sprintf(p, "row:%d ", row);
+	}
 	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
 		p += sprintf(p, "col:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f564e15fbc7e..a60acd17bcaa 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -234,8 +234,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
-	if (mem->validation_bits & CPER_MEM_VALID_ROW)
-		n += scnprintf(msg + n, len - n, "row: %d ", mem->row);
+	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row = mem->row;
+
+		row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
+		n += scnprintf(msg + n, len - n, "row: %d ", row);
+	}
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
 		n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
@@ -292,6 +296,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->requestor_id = mem->requestor_id;
 	cmem->responder_id = mem->responder_id;
 	cmem->target_id = mem->target_id;
+	cmem->extended = mem->extended;
 	cmem->rank = mem->rank;
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 8537e9282a65..bd2d8a77a784 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -230,6 +230,10 @@ enum {
 #define CPER_MEM_VALID_RANK_NUMBER		0x8000
 #define CPER_MEM_VALID_CARD_HANDLE		0x10000
 #define CPER_MEM_VALID_MODULE_HANDLE		0x20000
+#define CPER_MEM_VALID_ROW_EXT			0x40000
+
+#define CPER_MEM_EXT_ROW_MASK			0x3
+#define CPER_MEM_EXT_ROW_SHIFT			16
 
 #define CPER_PCIE_VALID_PORT_TYPE		0x0001
 #define CPER_PCIE_VALID_VERSION			0x0002
@@ -443,7 +447,7 @@ struct cper_sec_mem_err_old {
 	u8	error_type;
 };
 
-/* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
+/* Memory Error Section (UEFI >= v2.3), UEFI v2.8 sec N.2.5 */
 struct cper_sec_mem_err {
 	u64	validation_bits;
 	u64	error_status;
@@ -461,7 +465,7 @@ struct cper_sec_mem_err {
 	u64	responder_id;
 	u64	target_id;
 	u8	error_type;
-	u8	reserved;
+	u8	extended;
 	u16	rank;
 	u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
 	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
@@ -483,8 +487,16 @@ struct cper_mem_err_compact {
 	u16	rank;
 	u16	mem_array_handle;
 	u16	mem_dev_handle;
+	u8      extended;
 };
 
+static inline u32 cper_get_mem_extension(u64 mem_valid, u8 mem_extended)
+{
+	if (!(mem_valid & CPER_MEM_VALID_ROW_EXT))
+		return 0;
+	return (mem_extended & CPER_MEM_EXT_ROW_MASK) << CPER_MEM_EXT_ROW_SHIFT;
+}
+
 /* PCI Express Error Section, UEFI v2.7 sec N.2.7 */
 struct cper_sec_pcie {
 	u64		validation_bits;
-- 
2.26.2

