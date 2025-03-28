Return-Path: <linux-efi+bounces-3103-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2EA752D5
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 00:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A351316E3AF
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB21F4167;
	Fri, 28 Mar 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWACLas/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA891F09BB;
	Fri, 28 Mar 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203550; cv=none; b=EtlZIN8wGfiezbvnkUe9xEevEGBDxE92KNWcFBaoflcEkOugXh1HczIVRuRe4pFJExLmKoSDVo6Jz4cTBQrt4FfURSyvx053+cQoESI4feO2R0Ca9FdQLDbcUQmqp0q2r3+nYcbgLHD1TuFIba4ym9PPvJhuDfLKPFXjL7xzC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203550; c=relaxed/simple;
	bh=zi0iwWjDhDxLwymtidNLys445dX7E5i0L9adBTLpUS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGQo5KZhHKWjyNz/FTwtFn60lvl/mT5qbyQEgPVBBs+GXCjYKGQgg4OlzhtPSvDtHFgXnis46VmjaIaZiTNOYx66Tr+jGkbjBedenty7JCjqHZIH3qi4yph7+z8osOFlZJtDcj/H4HZ7QXfNUudBB1ggec3A+qOOab8UPxED5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BWACLas/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWB53006347;
	Fri, 28 Mar 2025 23:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Wf/zw
	DSRa+s66twKEfsvEt3FS+Y3A46LxJSoYgYB5cE=; b=BWACLas/G/lM1PpGifE/S
	QuT2niNgVc8YHayeRVK8JbH6kozvOyQU2G0X5NkH5tYwIsGAR7FrGrGray0BHDlM
	2z/xqCZI62V9KOxhgAYdJa+jyCcI/FM6lMGZLHnT55pMSb0P3nGzMCPXkcRul5MA
	ZBGnszYOZ3hTzx2NlTF74BUSMFKUmlP1IpFfIheBWUfV7n3DCyDu/rXxriAZ7X01
	kv65zt+7i94z+tbwHrXfMih6VEJpmZqP3nHN9RffcUkIUx6ws5KsBzSt8yv41hXN
	0/gFT6ubncChxztkq2IeIzZvQ3wqm0rJkH56eMN4aBLxiblvo5RHBpQEdCocrvKE
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd6fnsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:12:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SM17Cs008231;
	Fri, 28 Mar 2025 23:11:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj701jbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:11:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52SNBwcS023875;
	Fri, 28 Mar 2025 23:11:58 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj701j9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:11:58 +0000
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
Subject: [PATCH v13 03/19] x86: Secure Launch Resource Table header file
Date: Fri, 28 Mar 2025 16:07:58 -0700
Message-Id: <20250328230814.2210230-4-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280156
X-Proofpoint-ORIG-GUID: yovK40XEQ4sXaaVh6WcX9J-u3axZSssU
X-Proofpoint-GUID: yovK40XEQ4sXaaVh6WcX9J-u3axZSssU

The Secure Launch Specification is an architectural agnostic, software neutral
API/ABI maintainted by the TrenchBoot project. It's function is to allow any
compliant boot loader to communicate the pre-launch configuration to any
compliant post-launch kernel. This API/ABI is referred to as the Secure Launch
Resource Table by the specification.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slr_table.h | 308 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)
 create mode 100644 include/linux/slr_table.h

diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
new file mode 100644
index 000000000000..fea666250033
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
+#ifndef __ASSEMBLY__
+
+/*
+ * Primary Secure Launch Resource Table Header
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
+ * Common SLRT Table Header
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
+ * currenty entry. If entry is NULL, the search begins at the beginning of
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
+	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+
+	return 0;
+}
+
+/*
+ * Initialize the SLRT for use. This prepares the meta-data in the SLRT
+ * header section and the table end marker entry.
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
+#endif /* !__ASSEMBLY */
+
+#endif /* _LINUX_SLR_TABLE_H */
-- 
2.39.3


