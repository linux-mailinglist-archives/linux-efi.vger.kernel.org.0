Return-Path: <linux-efi+bounces-3112-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EFA75304
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F403AF64C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A21F5847;
	Fri, 28 Mar 2025 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7QNXrKI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632A1F3FF8;
	Fri, 28 Mar 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203619; cv=none; b=Vceefi3URaoAHrMwSK7JHYPJSzie1QZM94EGV0F8owP9lE7CI58x23I/KlRezJEr7GWlzlhaSuJ+oxudCjaJiRJsVEbL3hq6MED+0Qf0R6EeivmgG+jMN9cGEsZQR/dIPMFHZPKD5qRECuyQfKPLcuk9QO18UMlpRb31O4iaHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203619; c=relaxed/simple;
	bh=LoNTzxwNf84i84cFZmYdp2Aaz33gXdEKx0Z+vPQafOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKlVMWK3QkU2b5fwPsHJ7RI614+j6DsYW9LJgkJokilBKJexW8hoO4OvafUasnG7PUSkcpCC2nvUFh2YWFJ/oNAdQdtkL26QIofteEPG/Hos1x4FoaNSQIUNAighudG8bmlQ7cgirW9NQYoUjabO+++qxaZhesdePNipIwpOVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7QNXrKI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWHkn001770;
	Fri, 28 Mar 2025 23:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ukIYH
	xCSiI2jbz299M4rvW1gcM+5iFojxtwxbipXNko=; b=Y7QNXrKIDYTFVgyZIWgy+
	JEj1NSX3ZctvvjPlXo0C/hRFQviSHBRE+yWm03BXNwzb1hZRnKbGJIe7W2trMyWX
	ANbOqGV9jekIDLwGBTFA8zuA5WpOlKSRAIL8Ytarf5funZclSRhFCUZaBiF0o42X
	MNxmJTtggQ1qHQQuiIWLhLuZ7fq5PdqnacURU740Vk9fmZbcwPLMhtyJWKFiRPzb
	DBglOBRlL2Zf/Kl/izDTx3h3FoGhB/fGc0xETfXl1+CFuvCBIAyCKglZ0Y2P4wnd
	gZnojwBZld6SQD+ZUGC4OjtYkkXW6iPySeItg/1ic3fO2NZx+klpY/GzrhJn7lUw
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5mfvjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:13:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SLVJrY015911;
	Fri, 28 Mar 2025 23:13:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj96whug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52SND4nf030655;
	Fri, 28 Mar 2025 23:13:04 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj96whta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:04 +0000
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
Subject: [PATCH v13 10/19] x86: Secure Launch kernel late boot stub
Date: Fri, 28 Mar 2025 16:08:05 -0700
Message-Id: <20250328230814.2210230-11-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280156
X-Proofpoint-GUID: Ub4PVyFzI4h4zYXChSq9-dvkbUWtfiFs
X-Proofpoint-ORIG-GUID: Ub4PVyFzI4h4zYXChSq9-dvkbUWtfiFs

The routine slaunch_setup() is called out of the x86 specific setup_arch()
routine during early kernel boot. After determining what platform is
present, various operations specific to that platform occur. This
includes finalizing setting for the platform late launch and verifying
that memory protections are in place.

Intel VT-d/IOMMU hardware provides special registers called Protected
Memory Regions (PMRs) that allow all memory to be protected from
DMA during a TXT DRTM launch. This coverage is validated during the
late setup process to ensure DMA protection is in place prior to
the IOMMUs being initialized and configured by the mainline kernel.
See the Intel Trusted Execution Technology - Measured Launch Environment
Developer's Guide for more details.

In addition this routine reserves key memory regions used by Secure Launch
(e.g. the TXT heap, AP startup block etc) as well as fetching values needed
later from the TXT heap and SLRT.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/setup.c    |   3 +
 arch/x86/kernel/slaunch.c  | 524 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c |   4 +
 4 files changed, 532 insertions(+)
 create mode 100644 arch/x86/kernel/slaunch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 84cfa179802c..a7ca7ca16174 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c7164a8de983..9bfa11ee46d6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
+#include <linux/slaunch.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
@@ -1000,6 +1001,8 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
+	slaunch_setup_txt();
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
new file mode 100644
index 000000000000..94fe5e494034
--- /dev/null
+++ b/arch/x86/kernel/slaunch.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup and finalization support.
+ *
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+#include <asm/e820/api.h>
+#include <asm/setup.h>
+#include <asm/realmode.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+static u32 sl_flags __ro_after_init;
+static struct sl_ap_wake_info ap_wake_info __ro_after_init;
+static u64 evtlog_addr __ro_after_init;
+static u32 evtlog_size __ro_after_init;
+static u64 vtd_pmr_lo_size __ro_after_init;
+
+/* This should be plenty of room */
+static u8 txt_dmar[PAGE_SIZE] __aligned(16);
+
+/*
+ * Get the Secure Launch flags that indicate what kind of launch is being done.
+ * E.g. a TXT launch is in progress or no Secure Launch is happening.
+ */
+u32 slaunch_get_flags(void)
+{
+	return sl_flags;
+}
+
+/*
+ * Return the AP wakeup information used in the SMP boot code to start up
+ * the APs that are parked using MONITOR/MWAIT.
+ */
+struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
+{
+	return &ap_wake_info;
+}
+
+/*
+ * On Intel platforms, TXT passes a safe copy of the DMAR ACPI table to the
+ * DRTM. The DRTM is supposed to use this instead of the one found in the
+ * ACPI tables.
+ */
+struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
+{
+	/* The DMAR is only stashed and provided via TXT on Intel systems */
+	if (memcmp(txt_dmar, "DMAR", 4))
+		return dmar;
+
+	return (struct acpi_table_header *)(txt_dmar);
+}
+
+/*
+ * If running within a TXT established DRTM, this is the proper way to reset
+ * the system if a failure occurs or a security issue is found.
+ */
+void __noreturn slaunch_txt_reset(void __iomem *txt,
+				  const char *msg, u64 error)
+{
+	u64 one = 1, val;
+
+	pr_err("%s", msg);
+
+	/*
+	 * This performs a TXT reset with a sticky error code. The reads of
+	 * TXT_CR_E2STS act as barriers.
+	 */
+	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(error));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(one));
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+/*
+ * The TXT heap is too big to map all at once with early_ioremap
+ * so it is done a table at a time.
+ */
+static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
+					     u32 bytes)
+{
+	u64 base, size, offset = 0;
+	void *heap;
+	int i;
+
+	if (type > TXT_SINIT_TABLE_MAX)
+		slaunch_txt_reset(txt, "Error invalid table type for early heap walk\n",
+				  SL_ERROR_HEAP_WALK);
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* Iterate over heap tables looking for table of "type" */
+	for (i = 0; i < type; i++) {
+		base += offset;
+		heap = early_memremap(base, sizeof(u64));
+		if (!heap)
+			slaunch_txt_reset(txt, "Error early_memremap of heap for heap walk\n",
+					  SL_ERROR_HEAP_MAP);
+
+		offset = *((u64 *)heap);
+
+		/*
+		 * After the first iteration, any offset of zero is invalid and
+		 * implies the TXT heap is corrupted.
+		 */
+		if (!offset)
+			slaunch_txt_reset(txt, "Error invalid 0 offset in heap walk\n",
+					  SL_ERROR_HEAP_ZERO_OFFSET);
+
+		early_memunmap(heap, sizeof(u64));
+	}
+
+	/* Skip the size field at the head of each table */
+	base += sizeof(u64);
+	heap = early_memremap(base, bytes);
+	if (!heap)
+		slaunch_txt_reset(txt, "Error early_memremap of heap section\n",
+				  SL_ERROR_HEAP_MAP);
+
+	return heap;
+}
+
+static void __init txt_early_put_heap_table(void *addr, unsigned long size)
+{
+	early_memunmap(addr, size);
+}
+
+/*
+ * TXT uses a special set of VTd registers to protect all of memory from DMA
+ * until the IOMMU can be programmed to protect memory. There is the low
+ * memory PMR that can protect all memory up to 4G. The high memory PRM can
+ * be setup to protect all memory beyond 4Gb. Validate that these values cover
+ * what is expected.
+ */
+static void __init slaunch_verify_pmrs(void __iomem *txt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	u32 field_offset, err = 0;
+	const char *errmsg = "";
+	unsigned long last_pfn;
+
+	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
+	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
+						 field_offset);
+
+	/* Save a copy */
+	vtd_pmr_lo_size = os_sinit_data->vtd_pmr_lo_size;
+
+	last_pfn = e820__end_of_ram_pfn();
+
+	/*
+	 * First make sure the hi PMR covers all memory above 4G. In the
+	 * unlikely case where there is < 4G on the system, the hi PMR will
+	 * not be set.
+	 */
+	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
+		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
+			err = SL_ERROR_HI_PMR_BASE;
+			errmsg =  "Error hi PMR base\n";
+			goto out;
+		}
+
+		if (PFN_PHYS(last_pfn) > os_sinit_data->vtd_pmr_hi_base +
+		    os_sinit_data->vtd_pmr_hi_size) {
+			err = SL_ERROR_HI_PMR_SIZE;
+			errmsg = "Error hi PMR size\n";
+			goto out;
+		}
+	}
+
+	/*
+	 * Lo PMR base should always be 0. This was already checked in
+	 * early stub.
+	 */
+
+	/*
+	 * Check that if the kernel was loaded below 4G, that it is protected
+	 * by the lo PMR. Note this is the decompressed kernel. The ACM would
+	 * have ensured the compressed kernel (the MLE image) was protected.
+	 */
+	if (__pa_symbol(_end) < 0x100000000ULL && __pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size) {
+		err = SL_ERROR_LO_PMR_MLE;
+		errmsg = "Error lo PMR does not cover MLE kernel\n";
+	}
+
+	/*
+	 * Other regions of interest like boot param, AP wake block, cmdline
+	 * already checked for PMR coverage in the early stub code.
+	 */
+
+out:
+	txt_early_put_heap_table(os_sinit_data, field_offset);
+
+	if (err)
+		slaunch_txt_reset(txt, errmsg, err);
+}
+
+static void __init slaunch_txt_reserve_range(u64 base, u64 size)
+{
+	int type;
+
+	type = e820__get_entry_type(base, base + size - 1);
+	if (type == E820_TYPE_RAM) {
+		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
+		memblock_reserve(base, size);
+	}
+}
+
+/*
+ * For Intel, certain regions of memory must be marked as reserved by putting
+ * them on the memblock reserved list if they are not already e820 reserved.
+ * This includes:
+ *  - The TXT HEAP
+ *  - The ACM area
+ *  - The TXT private register bank
+ *  - The MDR list sent to the MLE by the ACM (see TXT specification)
+ *  (Normally the above are properly reserved by firmware but if it was not
+ *  done, reserve them now)
+ *  - The AP wake block
+ *  - TPM log external to the TXT heap
+ *
+ * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
+ * the low PMR must be reserved too.
+ */
+static void __init slaunch_txt_reserve(void __iomem *txt)
+{
+	struct txt_sinit_memory_descriptor_record *mdr;
+	struct txt_sinit_mle_data *sinit_mle_data;
+	u64 base, size, heap_base, heap_size;
+	u32 mdrnum, mdroffset, mdrslen;
+	u32 field_offset, i;
+	void *mdrs;
+
+	base = TXT_PRIV_CONFIG_REGS_BASE;
+	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
+	slaunch_txt_reserve_range(base, size);
+
+	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
+	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
+	slaunch_txt_reserve_range(heap_base, heap_size);
+
+	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
+	slaunch_txt_reserve_range(base, size);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				sinit_vtd_dmar_table_size);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
+	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!mdrnum)
+		goto nomdr;
+
+	mdrslen = mdrnum * sizeof(*mdr);
+
+	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					mdroffset + mdrslen - 8);
+
+	mdr = mdrs + mdroffset - 8;
+
+	for (i = 0; i < mdrnum; i++, mdr++) {
+		/* Spec says some entries can have length 0, ignore them */
+		if (mdr->type > 0 && mdr->length > 0)
+			slaunch_txt_reserve_range(mdr->address, mdr->length);
+	}
+
+	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
+
+nomdr:
+	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
+				  ap_wake_info.ap_wake_block_size);
+
+	/*
+	 * Earlier checks ensured that the event log was properly situated
+	 * either inside the TXT heap or outside. This is a check to see if the
+	 * event log needs to be reserved. If it is in the TXT heap, it is
+	 * already reserved.
+	 */
+	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
+		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
+
+	for (i = 0; i < e820_table->nr_entries; i++) {
+		base = e820_table->entries[i].addr;
+		size = e820_table->entries[i].size;
+		if (base >= vtd_pmr_lo_size && base < 0x100000000ULL)
+			slaunch_txt_reserve_range(base, size);
+		else if (base < vtd_pmr_lo_size && base + size > vtd_pmr_lo_size)
+			slaunch_txt_reserve_range(vtd_pmr_lo_size,
+						  base + size - vtd_pmr_lo_size);
+	}
+}
+
+/*
+ * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
+ * It is stored in the TXT heap. Fetch it from there and make it available
+ * to the IOMMU driver.
+ */
+static void __init slaunch_copy_dmar_table(void __iomem *txt)
+{
+	struct txt_sinit_mle_data *sinit_mle_data;
+	u32 field_offset, dmar_size, dmar_offset;
+	void *dmar;
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				processor_scrtm_status);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
+	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!dmar_size || !dmar_offset)
+		slaunch_txt_reset(txt, "Error invalid DMAR table values\n",
+				  SL_ERROR_HEAP_INVALID_DMAR);
+
+	if (unlikely(dmar_size > PAGE_SIZE))
+		slaunch_txt_reset(txt, "Error DMAR too big to store\n",
+				  SL_ERROR_HEAP_DMAR_SIZE);
+
+	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					dmar_offset + dmar_size - 8);
+	if (!dmar)
+		slaunch_txt_reset(txt, "Error early_ioremap of DMAR\n",
+				  SL_ERROR_HEAP_DMAR_MAP);
+
+	memcpy(txt_dmar, dmar + dmar_offset - 8, dmar_size);
+
+	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
+}
+
+/*
+ * The location of the safe AP wake code block is stored in the TXT heap.
+ * Fetch needed values here in the early init code for later use in SMP
+ * startup.
+ *
+ * Also get the TPM event log values are in the SLRT and have to be fetched.
+ * They will be put on the memblock reserve list later.
+ */
+static void __init slaunch_fetch_values(void __iomem *txt)
+{
+	struct txt_os_mle_data *os_mle_data;
+	struct slr_entry_log_info *log_info;
+	u8 *jmp_offset, *stacks_offset;
+	struct slr_table *slrt;
+	u32 size;
+
+	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
+					       sizeof(*os_mle_data));
+
+	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
+	ap_wake_info.ap_wake_block_size = os_mle_data->ap_wake_block_size;
+
+	jmp_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_JMP_OFFSET;
+	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
+
+	stacks_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_STACKS_OFFSET;
+	ap_wake_info.ap_stacks_offset = *((u32 *)stacks_offset);
+
+	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, sizeof(*slrt));
+	if (!slrt)
+		slaunch_txt_reset(txt, "Error early_memremap of SLRT failed\n",
+				  SL_ERROR_SLRT_MAP);
+
+	size = slrt->size;
+	early_memunmap(slrt, sizeof(*slrt));
+
+	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, size);
+	if (!slrt)
+		slaunch_txt_reset(txt, "Error early_memremap of SLRT failed\n",
+				  SL_ERROR_SLRT_MAP);
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+
+	if (!log_info)
+		slaunch_txt_reset(txt, "SLRT missing logging info entry\n",
+				  SL_ERROR_SLRT_MISSING_ENTRY);
+
+	evtlog_addr = log_info->addr;
+	evtlog_size = log_info->size;
+
+	early_memunmap(slrt, size);
+
+	txt_early_put_heap_table(os_mle_data, sizeof(*os_mle_data));
+}
+
+/*
+ * Called to fix the long jump address for the waiting APs to vector to
+ * the correct startup location in the Secure Launch stub in the rmpiggy.
+ */
+void __init slaunch_fixup_jump_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_info("TXT AP startup vector address updated\n");
+}
+
+/*
+ * Intel TXT specific late stub setup and validation called from within
+ * x86 specific setup_arch().
+ */
+void __init slaunch_setup_txt(void)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *txt;
+
+	if (!boot_cpu_has(X86_FEATURE_SMX))
+		return;
+
+	/*
+	 * If booted through secure launch entry point, the loadflags
+	 * option will be set.
+	 */
+	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
+		return;
+
+	/*
+	 * See if SENTER was done by reading the status register in the
+	 * public space. If the public register space cannot be read, TXT may
+	 * be disabled.
+	 */
+	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt)
+		panic("Error early_ioremap in TXT setup failed\n");
+
+	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	/* SENTER should have been done */
+	if (!(val & TXT_SENTER_DONE_STS))
+		panic("Error TXT.STS SENTER_DONE not set\n");
+
+	/* SEXIT should have been cleared */
+	if (val & TXT_SEXIT_DONE_STS)
+		panic("Error TXT.STS SEXIT_DONE set\n");
+
+	/* Now we want to use the private register space */
+	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt) {
+		/* This is really bad, no where to go from here */
+		panic("Error early_ioremap of TXT priv registers\n");
+	}
+
+	/*
+	 * Try to read the Intel VID from the TXT private registers to see if
+	 * TXT measured launch happened properly and the private space is
+	 * available.
+	 */
+	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
+	if ((val & 0xffff) != 0x8086) {
+		/*
+		 * Can't do a proper TXT reset since it appears something is
+		 * wrong even though SENTER happened and it should be in SMX
+		 * mode.
+		 */
+		panic("Invalid TXT vendor ID, not in SMX mode\n");
+	}
+
+	/* Set flags so subsequent code knows the status of the launch */
+	sl_flags |= (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT);
+
+	/*
+	 * Reading the proper DIDVID from the private register space means we
+	 * are in SMX mode and private registers are open for read/write.
+	 */
+
+	/* On Intel, have to handle TPM localities via TXT */
+	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+
+	slaunch_fetch_values(txt);
+
+	slaunch_verify_pmrs(txt);
+
+	slaunch_txt_reserve(txt);
+
+	slaunch_copy_dmar_table(txt);
+
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	pr_info("Intel TXT setup complete\n");
+}
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e540092d664d..aad13f455160 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 
 #include "iommu.h"
@@ -661,6 +662,9 @@ parse_dmar_table(void)
 	 */
 	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
 
+	/* If Secure Launch is active, it has similar logic */
+	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
+
 	dmar = (struct acpi_table_dmar *)dmar_tbl;
 	if (!dmar)
 		return -ENODEV;
-- 
2.39.3


