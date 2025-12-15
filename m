Return-Path: <linux-efi+bounces-5872-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA4CC0470
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 648E8307566A
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68033890E;
	Mon, 15 Dec 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUaxa7ws"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872A330300;
	Mon, 15 Dec 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842137; cv=none; b=i0m1XIGsPIl+T9uac6k/XxBPIZNIWmpYthX6xXhzKbcgOuzAGicNBWVGDoVtIROsfr6l72F/adFiNNZya5nxmvkAX6hEClQU9NayMSd4Wvi6a1XDeIZMcKp+0W2hj1E3YD4YsooptKDRPu7NzHwXHQWMp4h+3StEzLzXrJVDbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842137; c=relaxed/simple;
	bh=bJTd5U+FhsNucN9Z852MD38T9+haZ3NZg84Xh5XA0ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7+bqK9z5Va0TvZskPPVxha7CDN/m4ozW7j0qavK4d9iXWDwE3Y6vcToWzY7Da12sthN9TPaZSlcE+nxkInvWZRMSQgIysngFM75Zhk8ZLLKhhiIKVCdHtJp/nv5NSxZMY9bcitpGMg0O/rlxuc6OkJNaZO245MX8h9BRccrq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUaxa7ws; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCNhs2886214;
	Mon, 15 Dec 2025 23:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sS+vs
	cjGqo/DXtce/iWnxtIttfTP1XZi4+OILH8EuuU=; b=cUaxa7wswHSCIs7ugWRgg
	OZK6Q3uEP31rKtnUOFyRzhiXSJSxcyzwsZefdULPaRMRZKdgQZ/bxXm9E0+6/hWM
	Zvf9eAFOOovlInhABSvoCM/Q1FQAmQhGjIOpqwZW2OtxQc+AP0bGu62A7KhTeyV4
	ByiqmCdYdFV+jpvd7pOKIvJKP8EkTbTPuUy43GDp+VNY4cV5qDACt+R2uflFhlzB
	jDr3T+wOHDZok5d6htnwMID8wLd6f7O8lMhz41IvKaYO1H5STZM118H0qPWjKFEm
	8r0MlCnV9SHOxa/JMuATXGNGifsfAS8p5+lHwGaqBRnk92H/+NDUuxDXeCT6+quz
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u18h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLBRf8022557;
	Mon, 15 Dec 2025 23:40:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNep5g010286;
	Mon, 15 Dec 2025 23:40:51 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkc9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:50 +0000
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
Subject: [PATCH v15 14/28] x86: Secure Launch Resource Table header file
Date: Mon, 15 Dec 2025 15:33:02 -0800
Message-ID: <20251215233316.1076248-15-ross.philipson@oracle.com>
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
X-Proofpoint-GUID: WqCkI0G5AahtBsh5rkWFgsOLKwkOFHuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX/HzZI1sxHARY
 1s5pGY0DSr0vzRxcthvfnAg+nPtkev3fNfiMIyFNtaCJwYiwfdrThTX5Spv0BT0jh4oJFqcdV9b
 1X5tb7RqbWyyQyWjgJenZ/TVXWCmPR+S13aO4/dpyVQs8CNcTsTb4gMoHXavtoYn2J8ZFpSIVnv
 6TNw7H3myJBf21laC5gVzcwj077COuhf3+TzYVASyDoRJCAVXhIduCCRaQXs1rza2CKvZp2+B8e
 kveTwlaC+XE9AZT9Za+NMbhrh67vzPsmhlSu3zw874yde/C7qEQv0UvG8P8xFSuP5RmkcZq8FvZ
 Dcy33fFkDkMt9CHnNQdt2EVpFkvd7ER723S09ByfJLurFfVU6Bqf36vXJ83/vVZAM+7pXnevBX8
 SHQZfkesTdfL9ZG+jN/Ccpjzcc+oahqR8cH3frIaoemex8zXEjs=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409c86 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=oXTKce9TAAAA:20
 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8 a=eVZFrSfukqw1CmHGaWIA:9
 a=E6eXv-vVeS7VqOnxGRGn:22 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: WqCkI0G5AahtBsh5rkWFgsOLKwkOFHuJ

The Secure Launch Specification is an architectural agnostic, software neutral
API/ABI maintained by the TrenchBoot project. Its function is to allow any
compliant boot loader to communicate the pre-launch configuration to any
compliant post-launch kernel. The Secure Launch Resource Table, defined
in the specification, presents the programmatic interface for this API/ABI.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slr_table.h | 308 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)
 create mode 100644 include/linux/slr_table.h

diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
new file mode 100644
index 000000000000..c28bc96d8814
--- /dev/null
+++ b/include/linux/slr_table.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TrenchBoot Secure Launch Resource Table
+ *
+ * The Secure Launch Resource Table (SLRT) is a TrenchBoot project defined
+ * specification to provide a cross-platform interface/ABI between
+ * the Secure Launch components. While most of the table is platform
+ * agnostic, platform or architecture specific entries can be added.
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_TABLE_H
+#define _LINUX_SLR_TABLE_H
+
+/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
+#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* SLR table header values */
+#define SLR_TABLE_MAGIC		0x4452544d
+#define SLR_TABLE_REVISION	1
+
+/* Current revisions for the policy and UEFI config */
+#define SLR_POLICY_REVISION		1
+#define SLR_UEFI_CONFIG_REVISION	1
+
+/* SLR defined architectures */
+#define SLR_INTEL_TXT		1
+#define SLR_AMD_SKINIT		2
+
+/* SLR defined bootloaders */
+#define SLR_BOOTLOADER_INVALID	0
+#define SLR_BOOTLOADER_GRUB	1
+
+/* Log formats */
+#define SLR_DRTM_TPM12_LOG	1
+#define SLR_DRTM_TPM20_LOG	2
+
+/* DRTM Policy Entry Flags */
+#define SLR_POLICY_FLAG_MEASURED	0x1
+#define SLR_POLICY_IMPLICIT_SIZE	0x2
+
+/* Array Lengths */
+#define TPM_EVENT_INFO_LENGTH		32
+#define TXT_VARIABLE_MTRRS_LENGTH	32
+
+/* Tags */
+#define SLR_ENTRY_INVALID	0x0000
+#define SLR_ENTRY_DL_INFO	0x0001
+#define SLR_ENTRY_LOG_INFO	0x0002
+#define SLR_ENTRY_ENTRY_POLICY	0x0003
+#define SLR_ENTRY_INTEL_INFO	0x0004
+#define SLR_ENTRY_AMD_INFO	0x0005
+#define SLR_ENTRY_ARM_INFO	0x0006
+#define SLR_ENTRY_UEFI_INFO	0x0007
+#define SLR_ENTRY_UEFI_CONFIG	0x0008
+#define SLR_ENTRY_END		0xffff
+
+/* Entity Types */
+#define SLR_ET_UNSPECIFIED	0x0000
+#define SLR_ET_SLRT		0x0001
+#define SLR_ET_BOOT_PARAMS	0x0002
+#define SLR_ET_SETUP_DATA	0x0003
+#define SLR_ET_CMDLINE		0x0004
+#define SLR_ET_UEFI_MEMMAP	0x0005
+#define SLR_ET_RAMDISK		0x0006
+#define SLR_ET_TXT_OS2MLE	0x0010
+#define SLR_ET_UNUSED		0xffff
+
+#ifndef __ASSEMBLER__
+
+/*
+ * Primary Secure Launch Resource Table header
+ */
+struct slr_table {
+	u32 magic;
+	u16 revision;
+	u16 architecture;
+	u32 size;
+	u32 max_size;
+	/* table entries */
+} __packed;
+
+/*
+ * Common SLRT entry header
+ */
+struct slr_entry_hdr {
+	u32 tag;
+	u32 size;
+} __packed;
+
+/*
+ * Boot loader context
+ */
+struct slr_bl_context {
+	u16 bootloader;
+	u16 reserved[3];
+	u64 context;
+} __packed;
+
+/*
+ * Dynamic Launch Callback Function type
+ */
+typedef void (*dl_handler_func)(struct slr_bl_context *bl_context);
+
+/*
+ * DRTM Dynamic Launch Configuration
+ */
+struct slr_entry_dl_info {
+	struct slr_entry_hdr hdr;
+	u64 dce_size;
+	u64 dce_base;
+	u64 dlme_size;
+	u64 dlme_base;
+	u64 dlme_entry;
+	struct slr_bl_context bl_context;
+	u64 dl_handler;
+} __packed;
+
+/*
+ * TPM Log Information
+ */
+struct slr_entry_log_info {
+	struct slr_entry_hdr hdr;
+	u16 format;
+	u16 reserved;
+	u32 size;
+	u64 addr;
+} __packed;
+
+/*
+ * DRTM Measurement Entry
+ */
+struct slr_policy_entry {
+	u16 pcr;
+	u16 entity_type;
+	u16 flags;
+	u16 reserved;
+	u64 size;
+	u64 entity;
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+/*
+ * DRTM Measurement Policy
+ */
+struct slr_entry_policy {
+	struct slr_entry_hdr hdr;
+	u16 reserved[2];
+	u16 revision;
+	u16 nr_entries;
+	struct slr_policy_entry policy_entries[];
+} __packed;
+
+/*
+ * Secure Launch defined MTRR saving structures
+ */
+struct slr_txt_mtrr_pair {
+	u64 mtrr_physbase;
+	u64 mtrr_physmask;
+} __packed;
+
+struct slr_txt_mtrr_state {
+	u64 default_mem_type;
+	u64 mtrr_vcnt;
+	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
+} __packed;
+
+/*
+ * Intel TXT Info table
+ */
+struct slr_entry_intel_info {
+	struct slr_entry_hdr hdr;
+	u64 boot_params_addr;
+	u64 txt_heap;
+	u64 saved_misc_enable_msr;
+	struct slr_txt_mtrr_state saved_bsp_mtrrs;
+} __packed;
+
+/*
+ * UEFI config measurement entry
+ */
+struct slr_uefi_cfg_entry {
+	u16 pcr;
+	u16 reserved;
+	u32 size;
+	u64 cfg; /* address or value */
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+/*
+ * UEFI config measurements
+ */
+struct slr_entry_uefi_config {
+	struct slr_entry_hdr hdr;
+	u16 reserved[2];
+	u16 revision;
+	u16 nr_entries;
+	struct slr_uefi_cfg_entry uefi_cfg_entries[];
+} __packed;
+
+/*
+ * The SLRT is laid out as a Tag-Length-Value (TLV) data structure
+ * allowing a flexible number of entries in the table. An instance
+ * of the slr_table structure is present as a header at the beginning.
+ *
+ * The following functions help to manipulate the SLRT structure
+ * and contents.
+ */
+
+/*
+ * Return the address of the end of the SLRT past the final entry.
+ */
+static inline void *slr_end_of_entries(struct slr_table *table)
+{
+	return (void *)table + table->size;
+}
+
+/*
+ * Return the next entry in the SLRT given the current entry passed
+ * to the function. NULL is returned if there are no entries to return.
+ */
+static inline void *
+slr_next_entry(struct slr_table *table,
+	       struct slr_entry_hdr *curr)
+{
+	struct slr_entry_hdr *next = (struct slr_entry_hdr *)((u8 *)curr + curr->size);
+
+	if ((void *)next >= slr_end_of_entries(table))
+		return NULL;
+	if (next->tag == SLR_ENTRY_END)
+		return NULL;
+
+	return next;
+}
+
+/*
+ * Return the next entry with the given tag in the SLRT starting at the
+ * current entry. If entry is NULL, the search begins at the beginning of
+ * table.
+ */
+static inline void *
+slr_next_entry_by_tag(struct slr_table *table,
+		      struct slr_entry_hdr *entry,
+		      u16 tag)
+{
+	if (!entry) /* Start from the beginning */
+		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
+
+	for ( ; ; ) {
+		if (entry->tag == tag)
+			return entry;
+
+		entry = slr_next_entry(table, entry);
+		if (!entry)
+			return NULL;
+	}
+
+	return NULL;
+}
+
+/*
+ * Add an entry to the SLRT. Entries are placed at the end.
+ */
+static inline int
+slr_add_entry(struct slr_table *table,
+	      struct slr_entry_hdr *entry)
+{
+	struct slr_entry_hdr *end;
+
+	if ((table->size + entry->size) > table->max_size)
+		return -1;
+
+	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
+	table->size += entry->size;
+
+	end = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+
+	return 0;
+}
+
+/*
+ * Initialize the SLRT for use. This prepares the meta-data in the SLRT
+ * header section of the table and table end entry.
+ */
+static inline void
+slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
+{
+	struct slr_entry_hdr *end;
+
+	slrt->magic = SLR_TABLE_MAGIC;
+	slrt->revision = SLR_TABLE_REVISION;
+	slrt->architecture = architecture;
+	slrt->size = sizeof(*slrt) + sizeof(*end);
+	slrt->max_size = max_size;
+	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+}
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_TABLE_H */
-- 
2.43.7


