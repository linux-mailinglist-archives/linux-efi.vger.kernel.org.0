Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1047046C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbhLJPse (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:34 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:60673
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243449AbhLJPsG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8RgnC9MwBfJ3mLYm5bnmAGltfq+IbSdL1a1XvmWvX8rBDTqGqwAvVqA6BgOnO2umesXK3ewqgVRKGb6CTEp7U3KjXHi6LXPF549imGofNzHpp02vuNeQYmVzQln9HFirOAuhyO9RhewFGfYr4n9YISIWQ1WeEwhlLSCyFuI/q4XWPKhYd5dcIo9tGMowdnthlOTodLSrs8UseRJaeTj+l1TBPIej/3hcWGLUiGosxZy401wXkv0IEzIaj/PyPKArYVgQ5r6zaijj2moKqPns5BtNIL8dd//f3N0PkOPs4F4+ylNYgcyrrBTWDzYG2TMIulLRLNtp2TadONcUdZwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udJHbfhNYdbudFlGCE1JbrCJFnaRlmXH6nwbqoBPIqM=;
 b=F5Inwy704v7Yc+Nfar6gENyNLdxT/maVulB1FNZl8TEFVtLGt8QsN8MVDqLkBy81L/1pi22H9o6znQY8hmMaBJqqFQPaXYdwGaV04puO6SjPuvkzz4iSqq+2Wj3Q0ehCevt4BhYW3jsYknKAz9Ag96SjjyFkEPhePPrcpf1smKU44Pj0hDn26dwwVhO0CyaSs4uQTO61sW037IPvhpclmd3iId0mTAZSBFSxY8nEvYD7nB1Uq7Wg1Wlhin5TNjONOcilCE3LrDA9hV+1oqBN7hmEPNhG06IZLW3ooMqvaQPbfP6PxT5cl1BW94M0U1NSGLsXQCSnLOLOg23VorOsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udJHbfhNYdbudFlGCE1JbrCJFnaRlmXH6nwbqoBPIqM=;
 b=vHB9xyLgKXE6mSoCfAip6SBbSYEJzAX9fEayH0Y5kuzDkZcpLYAlEjz7PiG0Jjbpum86ZQk+NHj4wd9H97pz05hgcGcFvqUhoeJSCB8qXqe1XLEdX7vIeyr3LfDEnxHa3YIM/OEhmPE6yby5boJEfImxqZ6Z3EElwcEBlxVEfuo=
Received: from BN6PR2001CA0027.namprd20.prod.outlook.com
 (2603:10b6:405:16::13) by MWHPR1201MB0189.namprd12.prod.outlook.com
 (2603:10b6:301:59::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:44:28 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::8e) by BN6PR2001CA0027.outlook.office365.com
 (2603:10b6:405:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:25 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v8 24/40] x86/compressed/acpi: move EFI system table lookup to helper
Date:   Fri, 10 Dec 2021 09:43:16 -0600
Message-ID: <20211210154332.11526-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b9dffb-972a-403b-47fd-08d9bbf3f318
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB018995C6B5B2A6212336FB95E5719@MWHPR1201MB0189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boOcn1HMMcQF83FzGRunxDHoFStQXoNbIsTkzXLUb3xpaxYJEuXh4Nta4GvEInCUhqp6Fu8UsmYt4lhoW68/uoXQC+5qgQyWGWhxcMJRCAfgNmuQd6AIVvPavuNbV+sq2h507d0sec/45XfMKhc9MOyC68JKGxy+AJDV8Ue5YUbrexVsKDIWr6nOeLLsCCErdUAyo7g1oFl8+qLayX+3nMMHuCrhnNERPr00M04bqSypWHI7Td6KFBzblvlgrMiRautn4dW3k17WfzUXny2Iro5e7avLtp8OvmFO//VDtoApBr4IIT8B2DfSXkBpIyfroOqMBCk22rgE91uNDIjyS5telRPxoi7v5pSkfbWa+u9Lls4FYwLl0xtMi8b5xfh6FQofDrhBis8ZgrTkPs+hynTBbIYJaqJB/g9Pa/r6Jx2dsY+FQitR4bGJsK5B7h4HskjBV7BbItBowG3Gck4qdeNylWyIuJK7UGPn/fIVkO26PKdRE0bC4HRrkZ526kMDW4nqzhZz1J7piPIFcZ/zFWti+KA+c5Wdb8H7qkqaj1mOB6AgQqgR696KEoVb3mRXj/M68OhfjdxOzC9LeTWNmdgY9exbFrUHnAm56QiFN4UOCI5pZRFUzYGbMMQMy345euq0ESXan0VCbELrXcLdAfn+XprigTA7nIuR2dfbDdY7mLf1oACMOQiRUhfc4Lg/ogtm3yNULCVe1rt2L1EDtnglLYwbt5VcmramXBv0Rtp+tbdlcCel3mOuTu9d84O3E/Xe2GwqPdck52Ap6KZj7liSNW8D50LlYd2gAqDmVeoFAgjtwx3W5exrUmlnk/fy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(508600001)(4326008)(83380400001)(36860700001)(336012)(426003)(7696005)(47076005)(5660300002)(70206006)(44832011)(8676002)(70586007)(2616005)(8936002)(110136005)(6666004)(36756003)(54906003)(186003)(2906002)(1076003)(86362001)(26005)(40460700001)(7406005)(356005)(81166007)(7416002)(316002)(16526019)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:27.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b9dffb-972a-403b-47fd-08d9bbf3f318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0189
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/acpi.c   | 60 ++++++++++----------------
 arch/x86/boot/compressed/efi.c    | 72 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h   | 14 ++++++
 4 files changed, 109 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..d364192c2367 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,6 +100,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..9e784bd7b2e6 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -86,8 +86,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 {
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
-	struct efi_info *ei;
-	char *sig;
+	bool efi_64;
+	int ret;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,18 +98,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	/* Get systab from boot params. */
+	ret = efi_get_system_table(boot_params, (unsigned long *)&systab, &efi_64);
+	if (ret)
+		error("EFI system table not found in kexec boot_params.");
+
+	if (!efi_64) {
 		debug_putstr("Wrong kexec EFI loader signature.\n");
 		return 0;
 	}
 
-	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
-	if (!systab)
-		error("EFI system table not found in kexec boot_params.");
-
 	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
 }
 #else
@@ -119,45 +117,31 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
+	unsigned long systab_tbl_pa, config_tables;
 	unsigned int nr_tables;
-	struct efi_info *ei;
 	bool efi_64;
-	char *sig;
-
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-
-	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
-		efi_64 = true;
-	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
-		efi_64 = false;
-	} else {
-		debug_putstr("Wrong EFI loader signature.\n");
-		return 0;
-	}
+	int ret;
 
-	/* Get systab from boot params. */
-#ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
-#else
-	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
-		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
+	/*
+	 * This function is called even for non-EFI BIOSes, and callers expect
+	 * failure to locate the EFI system table to result in 0 being returned
+	 * as indication that EFI is not available, rather than outright
+	 * failure/abort.
+	 */
+	ret = efi_get_system_table(boot_params, &systab_tbl_pa, &efi_64);
+	if (ret == -EOPNOTSUPP)
 		return 0;
-	}
-	systab = ei->efi_systab;
-#endif
-	if (!systab)
-		error("EFI system table not found.");
+	if (ret)
+		error("EFI support advertised, but unable to locate system table.");
 
 	/* Handle EFI bitness properly */
 	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_tbl_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
 	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_tbl_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
new file mode 100644
index 000000000000..1c626d28f07e
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for early access to EFI configuration table
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Michael Roth <michael.roth@amd.com>
+ */
+
+#include "misc.h"
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+/**
+ * efi_get_system_table - Given boot_params, retrieve the physical address of
+ *                        EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @sys_tbl_pa:         location to store physical address of system table
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
+ *
+ * Note: Existing callers like ACPI will call this unconditionally even for
+ * non-EFI BIOSes. In such cases, those callers may treat cases where
+ * bootparams doesn't indicate that a valid EFI system table is available as
+ * non-fatal errors to allow fall-through to non-EFI alternatives. This
+ * class of errors are reported as EOPNOTSUPP and should be kept in sync with
+ * callers who check for that specific error.
+ */
+int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl_pa,
+			 bool *is_efi_64)
+{
+	unsigned long sys_tbl;
+	struct efi_info *ei;
+	bool efi_64;
+	char *sig;
+
+	if (!sys_tbl_pa || !is_efi_64)
+		return -EINVAL;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		efi_64 = true;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		efi_64 = false;
+	} else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Get systab from boot params. */
+#ifdef CONFIG_X86_64
+	sys_tbl = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("Error: EFI system table located above 4GB.\n");
+		return -EOPNOTSUPP;
+	}
+	sys_tbl = ei->efi_systab;
+#endif
+	if (!sys_tbl) {
+		debug_putstr("EFI system table not found.");
+		return -ENOENT;
+	}
+
+	*sys_tbl_pa = sys_tbl;
+	*is_efi_64 = efi_64;
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 01cc13c12059..165640f64b71 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,6 +23,7 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -176,4 +177,17 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+int efi_get_system_table(struct boot_params *boot_params,
+			 unsigned long *sys_tbl_pa, bool *is_efi_64);
+#else
+static inline int
+efi_get_system_table(struct boot_params *boot_params,
+		     unsigned long *sys_tbl_pa, bool *is_efi_64)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

