Return-Path: <linux-efi+bounces-5865-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDEBCC04E5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 01:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4273D3029231
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B103328E9;
	Mon, 15 Dec 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i86jvf2U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70752330309;
	Mon, 15 Dec 2025 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842126; cv=none; b=fc/z3/BpRGVN/Y3Ep3O750t0kNr55Ex+Y9awOpDJIDVLjJ31oWPmsWBLysEMMNaX6Uv8LE1Jnh9rADTKXq0Ai9i6eutHngkXisPa8IBppRmd/4bVbocXFpq9y6TPImlWxocD9RyY9ZoT5o2RRFO5hS20uu34GPQ+TcuO+nFkVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842126; c=relaxed/simple;
	bh=iukmIdtqj455El9wf+P5zFFCPbgDZS1szPUhUJB/ukA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tye13SnrgLMTizs0m69IhBlyYgem14hDfeFFHsImwQveTmUAoOeQM6ucO2PXvzdd5HQcDn6Nd3flM2Grqn/i/RF+p1xr2BMMJa+nPxqYhX7K00IzyUCruOuBfqlGpIySbXc5GaEX/zz0yI2IM4nbFL+lUdKhSfllcO/SM0bOKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i86jvf2U; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCJ5A2796331;
	Mon, 15 Dec 2025 23:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=LzPaW
	Is09l1FjdUXdMTgBuC2HpGHRvaZKFI6HlefLt4=; b=i86jvf2U3jTv2Na6Go96C
	+1e295EgBFuGufwEbaoDvn7/zp4o60f7glIVDx635k75jqYauioL1TD9rtPYopR3
	pAq0BLc2Dn0arhU1v3RkoIu8Nzo8YKgAKP5PIORxbgMoiEcaQiJlcq72eWIWJPd+
	hbsCAUURi/SB0/Pbu1KDU6/yIiAGGEqFXer2xSBHA9LXzUukj3B7F6+QZVnv8dKS
	L42+C8Hv8C+hh+sgKpCx07NBcRqB5r25vY5DqNQ3Sx6hHym6055SWqd2bcvsq1nL
	aRdQwhG4Yn3kums7bOOkBZlgzxBJf3jRjzxkIQonYTt6NsQywkEguQjmeV3J+KVZ
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja318q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMwHiZ006074;
	Mon, 15 Dec 2025 23:40:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeQWv023729;
	Mon, 15 Dec 2025 23:40:54 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:53 +0000
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
Subject: [PATCH v15 15/28] x86: Secure Launch main header file
Date: Mon, 15 Dec 2025 15:33:03 -0800
Message-ID: <20251215233316.1076248-16-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=69409c87 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=MVmTxNXeJTXQ7vw_5JEA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXy6FScxnWw2cP
 VL0fTh14Oj1sT+V6frZnmYj/3NqYU2U+2+7vSpUTPpJct5uOQS4RcY182xQxNnY+REdxSYblJ+O
 ORQ+sxlDV9VbZK9hM5Z19LC6bBVAx8sfYLGCtQy7M6FGZiYw+M+uNpvh40VOk28w5Qr2w0NNzda
 znzpXaCuHEG/NoONIYpIYintOvviV5kjTt/zaOdA4tICMIOc7qtrOocLHS56sp0nQmRAPkXbqUz
 jIhlWAOa6zAnsRuFK5ULkM96XaL728Ddp5dKiHkdzYdRAEbuJ2bK2I+Z4y3JDLILKb4DBY97ApH
 TEVJKepyhPmPrldjU8q1ia6iYpuHsyCZordSxAqQ+Li1RnjA7GTW78e+JNpkImYBGvPIOnK2unQ
 T1De9AONxgi2UJ8I8V9WyOfZu24klweZ89We58xZGq3aNrbP4zA=
X-Proofpoint-ORIG-GUID: ths9wL6ZKxMuZCADgIFa8pRhv3XJ1LQr
X-Proofpoint-GUID: ths9wL6ZKxMuZCADgIFa8pRhv3XJ1LQr

Introduce the main Secure Launch header file. This header file
contains the platform neutral feature definitions. This includes:
 - Secure Launch error codes
 - DRTM TPM event logging definitions and helper functions
 - Other feature specific structures and definitions

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slaunch.h | 251 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)
 create mode 100644 include/linux/slaunch.h

diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
new file mode 100644
index 000000000000..330492fcdd8c
--- /dev/null
+++ b/include/linux/slaunch.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Main Secure Launch header file.
+ *
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLAUNCH_H
+#define _LINUX_SLAUNCH_H
+
+#include <asm/txt.h>
+
+/*
+ * Secure Launch Defined State Flags
+ */
+#define SL_FLAG_ACTIVE		0x00000001
+#define SL_FLAG_ARCH_TXT	0x00000002
+
+/*
+ * Secure Launch CPU Type
+ */
+#define SL_CPU_INTEL	1
+
+#define __SL32_CS	0x0008
+#define __SL32_DS	0x0010
+
+/*
+ * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Appendix I - ACM Error Codes
+ */
+#define SL_ERROR_GENERIC		0xc0008001
+#define SL_ERROR_TPM_INIT		0xc0008002
+#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
+#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
+#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
+#define SL_ERROR_TPM_EXTEND		0xc0008006
+#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
+#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
+#define SL_ERROR_MTRR_INV_BASE		0xc0008009
+#define SL_ERROR_MTRR_INV_MASK		0xc000800a
+#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
+#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
+#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
+#define SL_ERROR_HEAP_WALK		0xc000800e
+#define SL_ERROR_HEAP_MAP		0xc000800f
+#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
+#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
+#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
+#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
+#define SL_ERROR_HI_PMR_BASE		0xc0008014
+#define SL_ERROR_HI_PMR_SIZE		0xc0008015
+#define SL_ERROR_LO_PMR_BASE		0xc0008016
+#define SL_ERROR_LO_PMR_MLE		0xc0008017
+#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
+#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
+#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
+#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
+#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
+#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
+#define SL_ERROR_EVENTLOG_MAP		0xc000801e
+#define SL_ERROR_TPM_INVALID_ALGS	0xc000801f
+#define SL_ERROR_TPM_EVENT_COUNT	0xc0008020
+#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
+#define SL_ERROR_INVALID_SLRT		0xc0008022
+#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
+#define SL_ERROR_SLRT_MAP		0xc0008024
+
+/*
+ * Secure Launch Defined Limits
+ */
+#define SL_MAX_CPUS		512
+#define SL_BOOT_STACK_SIZE	128
+
+/*
+ * Secure Launch event log entry type. The TXT specification defines the
+ * base event value as 0x400 for DRTM values.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Appendix F - TPM Event Log
+ */
+#define SL_EVTYPE_BASE			0x400
+#define SL_EVTYPE_SECURE_LAUNCH		(SL_EVTYPE_BASE + 0x102)
+
+/*
+ * MLE scratch area offsets within TXT OS-MLE SL defined portion of the heap.
+ */
+#define SL_SCRATCH_AP_EBX		0
+#define SL_SCRATCH_AP_JMP_OFFSET	4
+#define SL_SCRATCH_AP_STACKS_OFFSET	8
+
+#ifndef __ASSEMBLER__
+
+#include <linux/io.h>
+#include <linux/tpm_eventlog.h>
+
+/*
+ * Secure Launch AP stack and monitor block
+ */
+struct sl_ap_stack_and_monitor {
+	u32 monitor;
+	u32 cache_pad[15];
+	u32 stack_pad[15];
+	u32 apicid;
+} __packed;
+
+/*
+ * Secure Launch AP wakeup information fetched in SMP boot code.
+ */
+struct sl_ap_wake_info {
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u32 ap_jmp_offset;
+	u32 ap_stacks_offset;
+};
+
+/*
+ * Secure Launch defined OS/MLE TXT Heap table
+ *
+ * This table is defined at the top level by the TXT specification
+ * but the format of this structure is implementation specific.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Appendix C - Intel TXT Heap Memory
+ */
+struct txt_os_mle_data {
+	u32 version;
+	u32 reserved;
+	u64 slrt;
+	u64 txt_info;
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u8 mle_scratch[64];
+} __packed;
+
+#ifdef CONFIG_SECURE_LAUNCH
+
+/*
+ * TPM event logging functions.
+ */
+
+/*
+ * Log a TPM v1 formatted event to the given DRTM event log.
+ */
+static inline int tpm_log_event(void *evtlog_base, u32 evtlog_size,
+				u32 event_size, void *event)
+{
+	struct tpm_event_log_header *evtlog =
+		(struct tpm_event_log_header *)evtlog_base;
+
+	if (memcmp(evtlog->signature, TPM_EVTLOG_SIGNATURE,
+		   sizeof(TPM_EVTLOG_SIGNATURE)))
+		return -EINVAL;
+
+	if (evtlog->container_size > evtlog_size)
+		return -EINVAL;
+
+	if (evtlog->next_event_offset + event_size > evtlog->container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
+	evtlog->next_event_offset += event_size;
+
+	return 0;
+}
+
+/*
+ * Log a TPM v2 formatted event to the given DRTM event log.
+ */
+static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
+				 void *evtlog_base, u32 evtlog_size,
+				 u32 event_size, void *event)
+{
+	struct tcg_pcr_event *header =
+		(struct tcg_pcr_event *)evtlog_base;
+
+	/* Has to be at least big enough for the signature */
+	if (header->event_size < sizeof(TCG_SPECID_SIG))
+		return -EINVAL;
+
+	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
+		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return -EINVAL;
+
+	if (elem->allocated_event_container_size > evtlog_size)
+		return -EINVAL;
+
+	if (elem->next_record_offset + event_size >
+	    elem->allocated_event_container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
+	elem->next_record_offset += event_size;
+
+	return 0;
+}
+
+/*
+ * External functions available in mainline kernel.
+ */
+void slaunch_setup(void);
+void slaunch_fixup_ap_wake_vector(void);
+u32 slaunch_get_flags(void);
+struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
+struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
+void __noreturn slaunch_reset(void *ctx, const char *msg, u64 error);
+void slaunch_finalize(int do_sexit);
+
+static inline bool slaunch_is_txt_launch(void)
+{
+	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
+
+	return (slaunch_get_flags() & mask) == mask;
+}
+
+#else
+
+static inline void slaunch_setup(void)
+{
+}
+
+static inline void slaunch_fixup_ap_wake_vector(void)
+{
+}
+
+static inline u32 slaunch_get_flags(void)
+{
+	return 0;
+}
+
+static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
+{
+	return dmar;
+}
+
+static inline void slaunch_finalize(int do_sexit)
+{
+}
+
+static inline bool slaunch_is_txt_launch(void)
+{
+	return false;
+}
+
+#endif /* !CONFIG_SECURE_LAUNCH */
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLAUNCH_H */
-- 
2.43.7


