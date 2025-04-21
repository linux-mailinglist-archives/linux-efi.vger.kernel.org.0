Return-Path: <linux-efi+bounces-3377-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BEEA95437
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240C93AE24C
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333C1E501C;
	Mon, 21 Apr 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAG1fyYH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B61E521F;
	Mon, 21 Apr 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253287; cv=none; b=cvwAfBjTKa0jmGiYfb6z/qXfaWFDsTUVEmEhn5kktEAoiLwRXHbIZ9lrTCI1w0oYEqxNiVu9EvCvsw+CoYeVUV+agcwB/GzyGcvP2SdkMsqnUQYp37XMsj2G8K8IDv02gxgloHB8LOmYEbcVrY+7R34hNzur/kT2Mm8QGBlsuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253287; c=relaxed/simple;
	bh=zi0iwWjDhDxLwymtidNLys445dX7E5i0L9adBTLpUS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYkh5AIEQWthNnLx+oCSxraaWzQWkejKtPKEQaYlrDjeY+66NONZ+2GutfYURU+sMVeop2g9hu0zK0OnpwcT2qxEuT1CUuhWz8de6FD/wJ3QsQuqXRXHw5nb0USRvEy3E7NooQRcsEKoIOvO1LxIECzT+NS90h+XxiqBnIkcBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EAG1fyYH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAldt010749;
	Mon, 21 Apr 2025 16:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Wf/zw
	DSRa+s66twKEfsvEt3FS+Y3A46LxJSoYgYB5cE=; b=EAG1fyYHaBgsidaIJy0WF
	b60bi1adwv6S0qanlKClOGHvN2ap/53JMVRZTRxsUapnPeXXzumFBbnFCg0LOtSe
	ToZ7I9qEcenhYV8egOHYqXmzy3fkn/uNkVX9PG8QVQKwqk/3mrCXZokhqlOy6S1p
	E4Wde1i9s9IZOfMr9jfDLMYVp9ufX0i8GObczUWbOyaUZm6bXkPZo+ul25NUZGv4
	vs7gD9s+Ad1K0PgP0z9Xow2tbLBIlWfdg2ESOusMz0nyK7hgClvmoIKkYJJkN6sk
	B01HKYZY8qTu/on/6RUMGaEY6J1+bQOdnjqs8x2M7jCQgUDv/cWp4RwhXNETmK+R
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46428c2uja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:34:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LEq9kd002971;
	Mon, 21 Apr 2025 16:34:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46429881sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGYBFm031381;
	Mon, 21 Apr 2025 16:34:12 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46429881pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:11 +0000
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
Subject: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
Date: Mon, 21 Apr 2025 09:26:56 -0700
Message-Id: <20250421162712.77452-4-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250421162712.77452-1-ross.philipson@oracle.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_08,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-ORIG-GUID: o2b2J0v-2MVYQCj2VZ_GlX1FQqrj7ENm
X-Proofpoint-GUID: o2b2J0v-2MVYQCj2VZ_GlX1FQqrj7ENm

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


