Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041F144CBD4
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhKJWMF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:05 -0500
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:20545
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233891AbhKJWLd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPGJQitw9kXLUTHOVkBJtHRBr8FShwSacp2OhhFxt2iPmk79StKie+vbZ7wamLgy3gKyKrvIo1/lxPUqrqFsLgUpr6LJly9cQYGR+UUHi40d0g4ziI3bLbgYy62LBCgOL46+SRz/b5eap9CRVggTvSW9tFvmsRIAdRE60uY0zvywqqmHSTNYHFS3vvPMvJ2nJkpB4tkv7fuesi8WMDhi4iCATJNLYNT+DNl1orN5ttWagwMtr3nb2+oQ/9Amkh9teuXNypvoCtjvgLkX092dugb8psYLDzkyQwWy59YPZH4GsevCxp+UktOFfQ2l5iLBtMsbgBjc6bWUsb4oPO4FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGjTpKzDP7c6ROB4BD0Wz20WdJwwCdbU1Vg7fEMir8A=;
 b=M6FyfruqlPPwkCpsyOZ3neLmtgwKQl3B+02p+5cCrQ9Obtxqcj4LJ4ZBVCbohp3bwqqQRlRxwwJzga9H9/rs71La+8TuP4cHGdfKiJQRx9lJ1fbnH5XGyQkmh21oo28LKTVpPuIPAi14+lP7sReljnXO07u+/AEYLnRBNKafwkJS7Mzncx9ncn+qPa8bxg8g+S0u3Nei+CJU+PcIPkxd6aWz1dYU/4hX3hc6cAn5giNz+Fx6KVsio2id+7hcEfU0KUYGyUFeOFPmVhfwi3UJKQhtfeDyyJeqVBaXdlLTKFd6C1Onjp5W3ylrtRxvl6Pt6+1XrOvZXbOyNuLG8Qo0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGjTpKzDP7c6ROB4BD0Wz20WdJwwCdbU1Vg7fEMir8A=;
 b=l7lmsM34TUWYoG+3Mw5pLEJT7jYTHYko8QHApUmDKoWn2VHSVnYYchyVL7zWgIIs3eppABTOotTCudu0qwffj6s6+SOaf5WhKFDuwj5tLdSISO1KU73qM+HbncdzGIqIHulScVv3xXN5Ocu+KI2Csw+H22ZwrRZRenuovy2mjy0=
Received: from DM3PR08CA0009.namprd08.prod.outlook.com (2603:10b6:0:52::19) by
 BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Wed, 10 Nov 2021 22:08:42 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::6f) by DM3PR08CA0009.outlook.office365.com
 (2603:10b6:0:52::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:41 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:39 -0600
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
Subject: [PATCH v7 29/45] x86/compressed/acpi: move EFI system table lookup to helper
Date:   Wed, 10 Nov 2021 16:07:15 -0600
Message-ID: <20211110220731.2396491-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2277680b-2803-4568-8973-08d9a496a7dc
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5014EBA61B1916A9A555D2A4E5939@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLjwsozlCZ7gHizYjjVmne9Dqmlg02ycBeCi2BaJuXNJ3u/K1+qO60wKBhMFteXMLZy2MhMWJrinI7H6unYtb8LxppGixGJnQfgJAebbY4uPWgCutmGhc3l/WzjCAxLVlYOs3s4ERkJlvB2Y6M1e71r11gwZKQcMZ7YdK97Yx9ukIK3ZrdYeYqTZ/TJR3CElfVah0vMHlMJGsAE1W2jmAVnIsHGtucKgbmStwCmhRsCDuirBdOhG49PqR8/obvLssLu4I07LtTjIl7B2Lgb54WIZ4ezwXGCsoCa7AI4EDre0Ggpj3MyKXlChayBqFMQapa7USin9uR8poeXvErQJTzstq0lMteuQETQ1e6Cuexfd198FUAEaA0cXQjkaYZpZyCCAJ7sJgj69LoGkekfaEdkymwn3WuqmZHbZXjFaj4NgpZiOI+K5PQmHdmTc4MQXoL7xVZHrJW/A1/tFtriWwr5I3PVK5oYEvnVHOnKl7Ryq52G8gY9Kt11X/JHExnvrV1XE+wA54bwIBGsmvGe85wBHdXPvmX+BdmH3KVoWzDp9gnOjNaz3x9qxTM8X5QsunQgPPT0cFF7UGnpg5EQdpmXtFLQVnE8B1D6yQ59egRuo57bkPiKRPq/N4tFnmM9EmsExUNFy+8aGRl6nN1hZ0Hmt9908qoZ2t7HtxVKkG0rNqDoTIZy2Gsl+ZiOK06E/xKgrmK5EhlAqwGPyMTWJAG1l/apiaZKNNu6BhUVQzj5RYRT4hiv140Hc/4xen/Eh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(356005)(7416002)(6666004)(26005)(7406005)(508600001)(8936002)(336012)(8676002)(186003)(54906003)(16526019)(81166007)(5660300002)(110136005)(70206006)(36860700001)(70586007)(36756003)(7696005)(4326008)(44832011)(82310400003)(47076005)(2616005)(86362001)(1076003)(2906002)(426003)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:41.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2277680b-2803-4568-8973-08d9a496a7dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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
 arch/x86/boot/compressed/efi.c    | 71 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h   | 14 ++++++
 4 files changed, 108 insertions(+), 38 deletions(-)
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
index 000000000000..bcf1d5650e26
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,71 @@
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
+ * Given boot_params, retrieve the physical address of EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @sys_tbl_pa:         location to store physical address of system table
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
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

