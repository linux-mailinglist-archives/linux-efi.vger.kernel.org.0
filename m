Return-Path: <linux-efi+bounces-5861-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA0CC03F2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECD5A30399B3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852232ED3E;
	Mon, 15 Dec 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X5Tds7yc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C79EEAB;
	Mon, 15 Dec 2025 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842113; cv=none; b=l9NmdqrkiyfyNwAXEyv4blmVg8d6o4XmGzpYSTuCjyfmzBTz97P6KME7mf/1NomaPzA7l7crwIS+CyNsJmoJe3ejDyqHnSAOhAlgL+uCaaF40cal8PL/FzsqUr19HRa2DOkDeZH6lidPcFEFodNiDFL3lzEy10kAyBTXIXbWf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842113; c=relaxed/simple;
	bh=zVX3kDIM9j26/SQc2TECyWl7kHr7nWizlyFR59IojD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFMCYak6blm+X2TiUKUWfLCaaRxBC65gXiMrpQXCqIjAiJQimKdMC4BldCSw0bucscCKM/v+x8JS0araq/dj6Y0wd5Ewjc5B+JQRt96sYqbHnUfV4xBEwsSx26fQtZ5QyjGxqvbV3TQ+igMc1Gzh8Gml+ysXTtjqhcVH2O2BWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X5Tds7yc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCAoT2796180;
	Mon, 15 Dec 2025 23:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rP4/i
	QNMLlJOyoN4SozXXkccVejXNUbkIm3B/M3I0OA=; b=X5Tds7ycktypa3YPX76Az
	+QCN3ULTlQyf7Ar61BZUwAstqqKzOHBcVhnOJwhInEt+DAqo/AlNQrYZf+FwIeo+
	y1EKw9OrckXMpjx2uIjnld2oAaADqIv371xRx14Je0nggX+KqgS+pHtBFiBArNTt
	zPqYcRy3awnNxRR3KiHQ3lcmwrU0Oq1ZVxXMtlFrpguwY1k/niNoeDUCW+9Ddpd+
	U1lnodoY7tzmNz30mXwmOj4FHYv1Pqa5V0ar5ULx44oXQ2nk1R9hkKKfP7NqJeZP
	uDGwIXWe9JHbjHoLaJ6yZKvqneD1SGdiCjUPYuhLiZwBJUk4FiAU80zlwe9xjERU
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja318r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLEBS2022494;
	Mon, 15 Dec 2025 23:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkccx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeu3N010824;
	Mon, 15 Dec 2025 23:40:56 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:56 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v15 16/28] x86/txt: Intel Trusted eXecution Technology (TXT) definitions
Date: Mon, 15 Dec 2025 15:33:04 -0800
Message-ID: <20251215233316.1076248-17-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=69409c8a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=L368t5SSUCExVKV_nIAA:9 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX5Y18mxG1FLSS
 ZwDkri3olTHJwqzfhWNjdcVK8D89wOR27kvJBcM+us4RfSec2TIiXTHngU05B4O3qNxgJcseRHd
 e2kH2U6qr6/21zIeGubrFIyltIOa7dJYSlDxVk1bgSHup4SygqQOd9RLWjzSirq3CbC3FaoyDuh
 kPohF/OYmqa7q6aTN8vqPfr5hF6qyfVfeD1w18XqCIHn9qGkTaUPdDux3wxBayphUrSHki8LLGB
 HhMOA2/BKr2SgNG62dRhv5EdM7+e67NgP0qWUvo7q+KVjrdz/OzLQPQHUtyYroctzZ+w9YJQlVP
 tHHLS/zsFykX4jyYwhqyOjWlAnwj+YAfq4k+uzVMUAiVMHB5nOKgthPPfj4qu4c76QXGgzqVgRl
 wxdWkHYLa5CueSHbD2ha5rFIpcjUWUMozQbZc+l0fQJDPZ3MTH8=
X-Proofpoint-ORIG-GUID: CiVKv8-cdmZcqrUKMe_46y9hBg8gGC4n
X-Proofpoint-GUID: CiVKv8-cdmZcqrUKMe_46y9hBg8gGC4n

Intel TXT architectural specific definitions. See the specification
for detailed information:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/txt.h | 330 +++++++++++++++++++++++++++++++++++++
 1 file changed, 330 insertions(+)
 create mode 100644 arch/x86/include/asm/txt.h

diff --git a/arch/x86/include/asm/txt.h b/arch/x86/include/asm/txt.h
new file mode 100644
index 000000000000..3886fd7b248a
--- /dev/null
+++ b/arch/x86/include/asm/txt.h
@@ -0,0 +1,330 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel Trusted eXecution Technology (TXT) Definitions
+ *
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _ASM_X86_TXT_H
+#define _ASM_X86_TXT_H
+
+/*
+ * Intel Safer Mode Extensions (SMX)
+ *
+ * Intel SMX provides a programming interface to establish a Measured Launched
+ * Environment (MLE). The measurement and protection mechanisms are supported by the
+ * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
+ * the processor's programming interface in an Intel TXT platform.
+ *
+ * See:
+ *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
+ *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
+ */
+
+/*
+ * SMX GETSEC Leaf Functions
+ */
+#define SMX_X86_GETSEC_SEXIT	5
+#define SMX_X86_GETSEC_SMCTRL	7
+#define SMX_X86_GETSEC_WAKEUP	8
+
+/*
+ * Intel Trusted Execution Technology MMIO Registers Banks
+ */
+#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
+#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
+#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
+				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
+
+/*
+ * Intel Trusted Execution Technology (TXT) Registers
+ */
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_CMD_RESET		0x0038
+#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_EMIF			0x0200
+#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_MLE_JOIN			0x0290
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_SCRATCHPAD		0x0378
+#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
+#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
+#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
+#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
+#define TXT_CR_CMD_SECRETS		0x08e0
+#define TXT_CR_CMD_NO_SECRETS		0x08e8
+#define TXT_CR_E2STS			0x08f0
+
+/* TXT default register value */
+#define TXT_REGVALUE_ONE		0x1ULL
+
+/* TXTCR_STS status bits */
+#define TXT_SENTER_DONE_STS		BIT(0)
+#define TXT_SEXIT_DONE_STS		BIT(1)
+
+/*
+ * SINIT/MLE Capabilities Field Bit Definitions
+ */
+#define TXT_SINIT_MLE_CAP_RLP_WAKE_GETSEC	0
+#define TXT_SINIT_MLE_CAP_RLP_WAKE_MONITOR	1
+
+/*
+ * OS/MLE Secure Launch Specific Definitions
+ */
+#define TXT_OS_MLE_STRUCT_VERSION	1
+#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
+
+/*
+ * TXT Heap Table Enumeration
+ */
+#define TXT_BIOS_DATA_TABLE		1
+#define TXT_OS_MLE_DATA_TABLE		2
+#define TXT_OS_SINIT_DATA_TABLE		3
+#define TXT_SINIT_MLE_DATA_TABLE	4
+#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
+
+#ifndef __ASSEMBLER__
+
+/*
+ * TXT Heap extended data elements.
+ */
+struct txt_heap_ext_data_element {
+	u32 type;
+	u32 size;
+	/* Data */
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_END			0
+
+struct txt_heap_end_element {
+	u32 type;
+	u32 size;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
+
+struct txt_heap_event_log_element {
+	u64 event_log_phys_addr;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
+
+struct txt_heap_event_log_pointer2_1_element {
+	u64 phys_addr;
+	u32 allocated_event_container_size;
+	u32 first_record_offset;
+	u32 next_record_offset;
+} __packed;
+
+/*
+ * TXT specification defined BIOS data TXT Heap table
+ */
+struct txt_bios_data {
+	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
+	u32 bios_sinit_size;
+	u64 reserved1;
+	u64 reserved2;
+	u32 num_logical_procs;
+	u32 sinit_flags;
+	u32 mle_flags;
+	/* Versions >= 5 with updates in version 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined OS/SINIT TXT Heap table
+ */
+struct txt_os_sinit_data {
+	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
+	u32 flags;
+	u64 mle_ptab;
+	u64 mle_size;
+	u64 mle_hdr_base;
+	u64 vtd_pmr_lo_base;
+	u64 vtd_pmr_lo_size;
+	u64 vtd_pmr_hi_base;
+	u64 vtd_pmr_hi_size;
+	u64 lcp_po_base;
+	u64 lcp_po_size;
+	u32 capabilities;
+	/* Version = 5 */
+	u64 efi_rsdt_ptr;
+	/* Versions >= 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined SINIT/MLE TXT Heap table
+ */
+struct txt_sinit_mle_data {
+	u32 version;             /* Current values are 6 through 9 */
+	/* Versions <= 8 */
+	u8 bios_acm_id[20];
+	u32 edx_senter_flags;
+	u64 mseg_valid;
+	u8 sinit_hash[20];
+	u8 mle_hash[20];
+	u8 stm_hash[20];
+	u8 lcp_policy_hash[20];
+	u32 lcp_policy_control;
+	/* Versions >= 7 */
+	u32 rlp_wakeup_addr;
+	u32 reserved;
+	u32 num_of_sinit_mdrs;
+	u32 sinit_mdrs_table_offset;
+	u32 sinit_vtd_dmar_table_size;
+	u32 sinit_vtd_dmar_table_offset;
+	/* Versions >= 8 */
+	u32 processor_scrtm_status;
+	/* Versions >= 9 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT data reporting structure for memory types
+ */
+struct txt_sinit_memory_descriptor_record {
+	u64 address;
+	u64 length;
+	u8 type;
+	u8 reserved[7];
+} __packed;
+
+/*
+ * TXT data structure used by a responsive local processor (RLP) to start
+ * execution in response to a GETSEC[WAKEUP].
+ */
+struct smx_rlp_mle_join {
+	u32 rlp_gdt_limit;
+	u32 rlp_gdt_base;
+	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
+	u32 rlp_entry_point; /* phys addr */
+} __packed;
+
+/*
+ * TPM event log structures defined in both the TXT specification and
+ * the TCG documentation.
+ */
+#define TPM_EVTLOG_SIGNATURE "TXT Event Container"
+
+struct tpm_event_log_header {
+	char signature[20];
+	char reserved[12];
+	u8 container_ver_major;
+	u8 container_ver_minor;
+	u8 pcr_event_ver_major;
+	u8 pcr_event_ver_minor;
+	u32 container_size;
+	u32 pcr_events_offset;
+	u32 next_event_offset;
+	/* PCREvents[] */
+} __packed;
+
+/*
+ * Functions to extract data from the Intel TXT Heap Memory. The layout
+ * of the heap is as follows:
+ *  +----------------------------+
+ *  | Size Bios Data table (u64) |
+ *  +----------------------------+
+ *  | Bios Data table            |
+ *  +----------------------------+
+ *  | Size OS MLE table (u64)    |
+ *  +----------------------------+
+ *  | OS MLE table               |
+ *  +--------------------------- +
+ *  | Size OS SINIT table (u64)  |
+ *  +----------------------------+
+ *  | OS SINIT table             |
+ *  +----------------------------+
+ *  | Size SINIT MLE table (u64) |
+ *  +----------------------------+
+ *  | SINIT MLE table            |
+ *  +----------------------------+
+ *
+ *  NOTE: the table size fields include the 8 byte size field itself.
+ */
+static inline u64 txt_bios_data_size(void *heap)
+{
+	return *((u64 *)heap);
+}
+
+static inline void *txt_bios_data_start(void *heap)
+{
+	return heap + sizeof(u64);
+}
+
+static inline u64 txt_os_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap)));
+}
+
+static inline void *txt_os_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_os_sinit_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap)));
+}
+
+static inline void *txt_os_sinit_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_sinit_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap) +
+			txt_os_sinit_data_size(heap)));
+}
+
+static inline void *txt_sinit_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) +
+		txt_os_sinit_data_size(heap) + sizeof(u64);
+}
+
+/*
+ * Find the TPM v2 event log element in the TXT heap. This element contains
+ * the information about the size and location of the DRTM event log. Note
+ * this is a TXT specific structure.
+ *
+ * See:
+ *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide - Appendix C.
+ */
+static inline struct txt_heap_event_log_pointer2_1_element*
+txt_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
+{
+	struct txt_heap_ext_data_element *ext_elem;
+
+	/* The extended element array is at the end of this table */
+	ext_elem = (struct txt_heap_ext_data_element *)
+		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
+
+	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
+		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
+			return (struct txt_heap_event_log_pointer2_1_element *)
+				((u8 *)ext_elem + sizeof(struct txt_heap_ext_data_element));
+		}
+		ext_elem = (struct txt_heap_ext_data_element *)
+			    ((u8 *)ext_elem + ext_elem->size);
+	}
+
+	return NULL;
+}
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _ASM_X86_TXT_H */
-- 
2.43.7


