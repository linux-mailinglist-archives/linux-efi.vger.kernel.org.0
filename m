Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC049FF2B
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiA1RUE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:04 -0500
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:38977
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243561AbiA1RTB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwATZ23NvmeKeVbwN6aQgre9rrqgeQGB4yyODXz0eVVx9y0rv8uTf9tZVPzvt1IumzWETHm/XeAqJtDmuFeGhM+5sT1RsCoecxGQYkFcR6wEpA/DcCXsh7pybGFoNk7mH6JI1d6ORMqYdHbENT9loN5+3xUnQOXK40Swnm9jIz7Afct3n6BrHISobsysyjizBux7QckyOrwtwrixwLFBbKe/cYgiLr6kXAHH1ejvDoM5Sb/BZROmLupoNgMM3r3LgSKlcWrGY7mKk3SRUx7sfxWUChHkKDSx+I+vLsNy5t2m/OGkzHUxFsdaEo3Fpp07dbUH94TUq3r8/2tFy0RVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hmZ4nQ27yELsJZKrLciCefjsyTur7sFuWO1cM5I/nk=;
 b=knnMpPmAmyZ6QX5DxwSJLVRAuZgYVZjPkxYncXYN0M+WOSXGiVpIQJoehc7eTK7PVv4DuXbDqV3Co9AizLDmsNwgUuJItkL1jDT0bNJHEv/fzCSHXQzVVNr1222lXFolTpXR1WGGh3oCt1sr8AYy1lp9GfBUQUHeFFFkv5kDhoUf91rEbGlIrGqjFnyk4fyYAgyNMvjZlUgxGZloUDB5h84fOWVwHjtyk4dpOAs5r+S61ud30aV+FqqVqjvi753bOhcNhgDN8ZB8Lvn+zevtP1orr0HChYpWGJxJWCuUmAnwRtgzk5dN3qP283wx0zKWQSCRhAmKiJN8KOc2bbiGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hmZ4nQ27yELsJZKrLciCefjsyTur7sFuWO1cM5I/nk=;
 b=ZXw4nHw0laBELOugLKCoHu+lwzkWPS8ZOaryknMcpE4Pk1orjM+fDW26tQ85YnwYVoBBxh2DAZMMM0tCr7pnDf7a/BvG4AlkIT3H477PflxYWyJkZj9XxiSvTJusegrKS/L7ZePrF8wbodAf1W9sn3q+26tRMmeRe91YvxMHoII=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:18:59 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::21) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:56 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 24/43] x86/compressed/acpi: Move EFI detection to helper
Date:   Fri, 28 Jan 2022 11:17:45 -0600
Message-ID: <20220128171804.569796-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33558b64-1d33-4b4c-f16d-08d9e28245a1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB414632C1534E74A775F55C3AE5229@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0uUDBCaw1G6YtUL3XQ8TYCEXR8qMCQGwUxIuZvaqTQl1quqX33qkjeuoqGqQ2Dzm7p4Tni/F2xewAURURqZDce16Kq+eQeJQwXZ5sp3iAEI+7zNzr9/8NHkQNlkMLQdAfoIkgQQotzW4YivHMwqooATXBiGwDascobEDlFFjO9g+AFiV0Xoy1IEa4PSTI4fHpf/zbDgBHkkLsBMeb8xuirihG9iFxaGCkfMkj8zko7VdXxCMGXsXErI2Mlk0rzt5xdOUjD1cgqlTzzgfgRjru9aVsiZtEszchZoz1ET/CnhL299oL8nHVzSkMnFGXhimhJWtELSKGt4cLY2B2qmt5qD/klTSOqzYDqCep42kS1lXgMq/op7AlneRg530FCerIbQVH/2JDPp1p9nPiXMyAXzWKdF2Ac6NKx9239k00reiO1wvTifSo2DpmaSP3XgTQCmrI5RbOX5P1MSP2qS5HzDM2NQ9OVbZRJeH5k3CygKrLsEmKWbApJm16WZlQsZJCNNxXYYlDubNCTZkb5vXi/f+Bh06mY2otg6odgHbgTsDJSltbDjjrDp4kqjMLNEeoLN8a3gpduNdaEXSY3rRSM5QC/ls4W2LZu5FTgJbTLF3AokglfYPYygWbdgBqXKVyykCjC7Hp9X2YGQ2+tJllgKng3wXrG7xDgKEXgV+zTox2S7A/4vBPOs3K+qzAz3PEasWMBUX34zt7h9sze/YW06N93uarxOOiIFzkgAObE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(2616005)(70586007)(1076003)(82310400004)(70206006)(26005)(54906003)(508600001)(40460700003)(110136005)(5660300002)(4326008)(8676002)(8936002)(6666004)(186003)(16526019)(7416002)(7406005)(7696005)(86362001)(81166007)(2906002)(356005)(44832011)(47076005)(336012)(36860700001)(426003)(36756003)(83380400001)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:59.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33558b64-1d33-4b4c-f16d-08d9e28245a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related
code into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/acpi.c   | 28 +++++++----------
 arch/x86/boot/compressed/efi.c    | 50 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h   | 16 ++++++++++
 4 files changed, 77 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6115274fe10f..e69c3d2e0628 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -103,6 +103,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..db6c561920f0 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -87,7 +87,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
 	struct efi_info *ei;
-	char *sig;
+	enum efi_type et;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,10 +98,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
-		debug_putstr("Wrong kexec EFI loader signature.\n");
+	et = efi_get_type(boot_params);
+	if (et != EFI_TYPE_64) {
+		debug_putstr("Unexpected kexec EFI environment (expected 64-bit EFI).\n");
 		return 0;
 	}
 
@@ -122,29 +121,22 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
+	enum efi_type et;
 	bool efi_64;
-	char *sig;
-
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
 
-	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_64)
 		efi_64 = true;
-	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+	else if (et == EFI_TYPE_32)
 		efi_64 = false;
-	} else {
-		debug_putstr("Wrong EFI loader signature.\n");
+	else
 		return 0;
-	}
 
 	/* Get systab from boot params. */
+	ei = &boot_params->efi_info;
 #ifdef CONFIG_X86_64
 	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
 #else
-	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
-		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
-		return 0;
-	}
 	systab = ei->efi_systab;
 #endif
 	if (!systab)
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
new file mode 100644
index 000000000000..daa73efdc7a5
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for early access to EFI configuration table.
+ *
+ * Originally derived from arch/x86/boot/compressed/acpi.c
+ */
+
+#include "misc.h"
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+/**
+ * efi_get_type - Given boot_params, determine the type of EFI environment.
+ *
+ * @boot_params:        pointer to boot_params
+ *
+ * Return: EFI_TYPE_{32,64} for valid EFI environments, EFI_TYPE_NONE otherwise.
+ */
+enum efi_type efi_get_type(struct boot_params *boot_params)
+{
+	struct efi_info *ei;
+	enum efi_type et;
+	const char *sig;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		et = EFI_TYPE_64;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		et = EFI_TYPE_32;
+	} else {
+		debug_putstr("No EFI environment detected.\n");
+		et = EFI_TYPE_NONE;
+	}
+
+#ifndef CONFIG_X86_64
+	/*
+	 * Existing callers like acpi.c treat this case as an indicator to
+	 * fall-through to non-EFI, rather than an error, so maintain that
+	 * functionality here as well.
+	 */
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("EFI system table is located above 4GB and cannot be accessed.\n");
+		et = EFI_TYPE_NONE;
+	}
+#endif
+
+	return et;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 01cc13c12059..a26244c0fe01 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -176,4 +176,20 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+enum efi_type {
+	EFI_TYPE_64,
+	EFI_TYPE_32,
+	EFI_TYPE_NONE,
+};
+
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+enum efi_type efi_get_type(struct boot_params *boot_params);
+#else
+static inline enum efi_type efi_get_type(struct boot_params *boot_params)
+{
+	return EFI_TYPE_NONE;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

