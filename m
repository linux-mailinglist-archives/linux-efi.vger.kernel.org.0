Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164464AF96B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiBISNz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiBISNK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD2C03CA49;
        Wed,  9 Feb 2022 10:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH8wL8HzM72Uz3aLXOqK++XjqNl4eormWl/8jCk4hD3QwvQtg+kK9ZdQ98HmUT2zJ/ImqWyUYesOJwpUPr6bJPjjNMB/VK7KM0+4w+9ZYF8y45+/aBJLoiuPaAtn4zjMoUrpVSIurrVcnSvema1zAGsWvUbL2WzoSXpDs6sG2P4I/B6kDVr8QZqWlO/MXQmoAevz1ZJX1L7LUZmmgO059LDUPiU/FDy1HlLni0W5sPHB2AyZBTbYzbTd9B2aGSeqFwkZOqoOdBku49h7hGtOeIyxrQ70Y1LcaFDwb1VGd9+gkcFeW/RjaOZU5ubA014Av/GMCzqqe8xbdWlJ7Mx1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T29/2TaTjE6y2w/cbm8PhGEi49TMVSH6O9SJYjUyJsI=;
 b=BTXr+HEEpO9A+n2oRY59Iqncni6p+8Q/DauJQgoGHDV5RsEmYzSNoA6vHexcO2o/eWI9xEIMVQLtC6i34TTre7afHO7yk8dgoRWcPwDAQStX9AuZglQ2jq3n1VYsFZpMKgg0L7iIq7MbaRM8S6sVq7OPzjDt21vdez0sO4dpgi5R/M6UUPNqewYCsTN5B8FEBDWq0FMtWy8AOl/974iSjWorw8gm2j/EIqeeOC2zNemKYyFFWnOW6JjjgZvOP/AaGx0zCi63U/+A8Kizg9QflcGvlDhhvxVeKjnxM/RmEiJOQzyz150cXjig2kqHRa32mnJEh2FZyZL6ciVLCO9Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T29/2TaTjE6y2w/cbm8PhGEi49TMVSH6O9SJYjUyJsI=;
 b=S/Mtj5IvmgqmTM/UjlyppD32FgZMT2OogqjoN3bxRMWptXJuUXfqORfcxAkHQysEMsL3pSoBAS/UGLjjuy/XxYRTIK1tV8CzioCyoBz0VBVAV7Zv5h2r/Xuq5HGa1zIUGw9WhSmPQZGtQ7EI7rfdkV5+vXtu218T4mG/0ZEdVa4=
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:12:09 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::83) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:06 -0600
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
Subject: [PATCH v10 24/45] x86/compressed/acpi: Move EFI detection to helper
Date:   Wed, 9 Feb 2022 12:10:18 -0600
Message-ID: <20220209181039.1262882-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f28645b-14d1-4f53-89a4-08d9ebf7afbd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2844CF46EF59EDC14EAC3029E52E9@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbQHzV0k2wJpm+2bDuqDBuaPK3u+5wfmFMIhRXsSafKhO6knRZvIJVp6YUu6SfDAVSuyvkKUAx9B5CW+62McgHbzt7nZ6foJf937NwSSaSD/KV/1XBeerse0ztlQOgT0to7NTixEb6+IVAnpFBLbEruB2IM5uu8pMgI1oi5o0GjYYh6ySvhVf83Eb67B61fqkJcbHvkh7gJYYU0WBqf26z1iwfvWUWeba+k2Hz73GivVFLyBIeAn2qVtUMMdcNXP94c6Uvmu5SwreCRptXqLujHYmg6Uf7GNll6g4rtYBrAPQ/dN+0vSE4mNyyztSfKoDyzf07JrYchZ8owGU0QBe+PyWtAvORYz8itoXmfa6ksdn7CP6zjCkdvF6ENCKTmjjnZsoEuCdMriUiXK5CquizS/acNgNeZxd0QQSPFoLJuofJR4tqsPLLA1OWuNpKY2W6r8+WS2Uutb+eMOpq+eQXT+31//zXgDvgLqDQQzN+mvLcqzNwzGVqojeVhLp6bc3pfdVxTAizfj+36cWF2tmgoVNA4kjZPRohqez8oyhp7QM+DyFlW+viS7VgDFq/jT4h+7o9QK3d4Vdz401eer/2zXe/Lj76+QHL1+SEjnepHWa8VOn+FlN4djg3ZyeN5mzWlQwJZcuFq1oNS2qfhcrRyNQtKow1Dg5D4onU9lysU+w6VmhRV1j18KE9oeUnG4aF4SSgDZfrXicQhniQyfsyAVEIxf/2fpB+a29UR7wh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7416002)(44832011)(5660300002)(7406005)(4326008)(8676002)(70586007)(8936002)(70206006)(82310400004)(2906002)(36756003)(83380400001)(36860700001)(47076005)(40460700003)(86362001)(356005)(508600001)(81166007)(186003)(336012)(426003)(110136005)(54906003)(16526019)(316002)(6666004)(2616005)(7696005)(26005)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:08.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f28645b-14d1-4f53-89a4-08d9ebf7afbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 000000000000..bad0ce3e2ef6
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
+ * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
+ *
+ * @bp:         pointer to boot_params
+ *
+ * Return: EFI_TYPE_{32,64} for valid EFI environments, EFI_TYPE_NONE otherwise.
+ */
+enum efi_type efi_get_type(struct boot_params *bp)
+{
+	struct efi_info *ei;
+	enum efi_type et;
+	const char *sig;
+
+	ei = &bp->efi_info;
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
index 01cc13c12059..fede1afa39e9 100644
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
+enum efi_type efi_get_type(struct boot_params *bp);
+#else
+static inline enum efi_type efi_get_type(struct boot_params *bp)
+{
+	return EFI_TYPE_NONE;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

