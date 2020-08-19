Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FAA24A1D8
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHSOhF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 10:37:05 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:54302 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgHSOhD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 10:37:03 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JESxB6012756;
        Wed, 19 Aug 2020 14:36:59 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 330m84fgur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:36:59 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 5AE934F;
        Wed, 19 Aug 2020 14:36:58 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 201855)
        id ED1C7200FDA48; Wed, 19 Aug 2020 09:36:57 -0500 (CDT)
From:   Alex Kluver <alex.kluver@hpe.com>
To:     linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, mchehab@kernel.org, bp@alien8.de,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        kluveralex@gmail.com, Alex Kluver <alex.kluver@hpe.com>
Subject: [PATCH v2 2/2] cper,edac,efi: Memory Error Record: bank group/address and chip id
Date:   Wed, 19 Aug 2020 09:35:44 -0500
Message-Id: <20200819143544.155096-3-alex.kluver@hpe.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200819143544.155096-1-alex.kluver@hpe.com>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190127
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Updates to the UEFI 2.8 Memory Error Record allow splitting the bank field
into bank address and bank group, and using the last 3 bits of the extended
field as a chip identifier.

When needed, print correct version of bank field, bank group, and chip
identification

Based on UEFI 2.8 Table 299. Memory Error Record

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
---

v1 -> v2:
   * Add static inline cper_get_mem_extension() to make it
    more readable, as suggested by Borislav Petkov.

   * Add second patch for bank field, bank group, and chip id.

---
 drivers/edac/ghes_edac.c    | 9 +++++++++
 drivers/firmware/efi/cper.c | 9 +++++++++
 include/linux/cper.h        | 8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 98fcdaf72a09..31eb72b67265 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -337,6 +337,12 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
+	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_GROUP)
+		p += sprintf(p, "bank_group:%d ",
+			     mem_err->bank >> CPER_MEM_BANK_GROUP_SHIFT);
+	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
+		p += sprintf(p, "bank_address:%d ",
+			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem_err->row;
 
@@ -362,6 +368,9 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		if (index >= 0)
 			e->top_layer = index;
 	}
+	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		p += sprintf(p, "chipID: %d ",
+			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
 	if (p > e->location)
 		*(p - 1) = '\0';
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index a60acd17bcaa..e15d484b6a5a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -232,6 +232,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "rank: %d ", mem->rank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK)
 		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
+	if (mem->validation_bits & CPER_MEM_VALID_BANK_GROUP)
+		n += scnprintf(msg + n, len - n, "bank_group: %d ",
+			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
+	if (mem->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
+		n += scnprintf(msg + n, len - n, "bank_address: %d ",
+			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
 	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
@@ -254,6 +260,9 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
 		scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
 			  mem->target_id);
+	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		scnprintf(msg + n, len - n, "chip_id: %d ",
+			  mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
 	msg[n] = '\0';
 	return n;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index bd2d8a77a784..6a511a1078ca 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -231,10 +231,18 @@ enum {
 #define CPER_MEM_VALID_CARD_HANDLE		0x10000
 #define CPER_MEM_VALID_MODULE_HANDLE		0x20000
 #define CPER_MEM_VALID_ROW_EXT			0x40000
+#define CPER_MEM_VALID_BANK_GROUP		0x80000
+#define CPER_MEM_VALID_BANK_ADDRESS		0x100000
+#define CPER_MEM_VALID_CHIP_ID			0x200000
 
 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
 
+#define CPER_MEM_BANK_ADDRESS_MASK		0xff
+#define CPER_MEM_BANK_GROUP_SHIFT		8
+
+#define CPER_MEM_CHIP_ID_SHIFT			5
+
 #define CPER_PCIE_VALID_PORT_TYPE		0x0001
 #define CPER_PCIE_VALID_VERSION			0x0002
 #define CPER_PCIE_VALID_COMMAND_STATUS		0x0004
-- 
2.26.2

