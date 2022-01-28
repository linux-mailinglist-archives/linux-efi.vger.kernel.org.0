Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968ED49FF64
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351442AbiA1RVU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:20 -0500
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:55776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350657AbiA1RTa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpCxxFt1xsIXgVJm2xESicGneDFH22tudxwfiLserVZHzvz3qHkEzOQv7YoSUiKjVPdKeWnTxoUboOVsQ6/KmoeWZX9415ga2Rdo9QwYZpvHcubAp3Wdm8mCpAdj9eT4XAl0ZoWpVkah2cKfLqWquZ4XWRLOk2OZGkeySt/XJudWASFUyOEH1Uj9RE6yCVLXgzlPgaLI8vPx341yY/KGSP5/6m7dJgUl5tk5yToClv0wZ2TZXAUdleEz3epP6W7Le93PwdxPuXkhdgz2Li4CYDzLhitQ56QnD4HqHnWya+qNXymFQt/XMYyJL1xgLSaN/bIuR0nCUAlueGFDp5VUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOspZbkvYaCxtinlPiqZX13yEk0rqb8xUc6HQ7urFZo=;
 b=eFOpovY0ZG19ATc1jzadGSfE+O6xvaEnLLlzEN+2wIPOJaPHXY0e4P0UA68BP0xNDnPOEuehqUDVtgHM/yIa4teKsLBR9yFs4eoo0jcfskA6rW9IPJU1tRelQPwP/XIjFIOZ9BUerj9DsdprvgkMhYQCdti/1Z3KrCSpGnAm0R7kO6ekyUUVKFEJhLW5cCGTftmTkzsDBwEWTKw2Aq80Xa9x/VIqsqtLO5tOd4HBT659bsaIi+V3tBSsNFWD0Yyvy/+niTuFF9NQWdq1Fv048C4q6moJiRgtgjm9c0juFtH2ITJRtfA3KCLRmuZH4876PZoV3e0oP3pUvuVZ+Q3bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOspZbkvYaCxtinlPiqZX13yEk0rqb8xUc6HQ7urFZo=;
 b=C0kGe149bHC/+gP8AHScr8DYCr1VYhBi94bla02VsSfZFD7gYAx+RSV6X6bt7KJnpNFUFTBuZhGstHz68W6Kaz1QYM7K9sAp+LfcWPDILiZb7EVgRJ9lWSvYFOp8Uo1qXOgf3nQ2KYhVAtwrXueeYmvRz0uEg9XfnqasIiTDSsI=
Received: from DM5PR11CA0018.namprd11.prod.outlook.com (2603:10b6:3:115::28)
 by BN8PR12MB3460.namprd12.prod.outlook.com (2603:10b6:408:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:19:27 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::8a) by DM5PR11CA0018.outlook.office365.com
 (2603:10b6:3:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:18 -0600
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
Subject: [PATCH v9 37/43] x86/sev: Add SEV-SNP feature detection/setup
Date:   Fri, 28 Jan 2022 11:17:58 -0600
Message-ID: <20220128171804.569796-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0d7524e-cfc7-46fd-266a-08d9e2825691
X-MS-TrafficTypeDiagnostic: BN8PR12MB3460:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34606C0D52C52733F05C3DAAE5229@BN8PR12MB3460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+Xlv3zIbvEvXGXd346xFB2TPcvtH9NamuTjj99PGalJRmnFiejUmubgNCPOC/MjLXXi/Y6YiNZPqCqdnP9k+B1UNHUagf3P3wlY6MOwgm5YdD12lD7TQi9wAg/BL59f496feEhuqgOS9Vj4OOgUY6pURIoigzeYajfCxDKjHg3gVG7vnLcz4HbnVp5/zJZo/KnuKsNucD0PWWwgXhHz1jt/fj0ExFWru2HkKfIRV0396l7UCMMlvicEqaU1LYJWOGXr4BNHaMKuUUNXOWLt8XggWqazZ/Q0SOBVr6cuXV5qVgEG6pNtvs7glEX972p7XlbB2DYtvvKitOIeZcPunypraeY27p4TY9gBnbBUgjNrynAl7qMzq0W27KTb4BsPCgAa24iURGFDO+RYUTyPmA34re12KTFuuECfOkGKdxN5H18eWvMoHYzfFNFGv80OyP0Xj682w2KiNdb4j3k4zl5VG1LHnztUkv6tvYeYrYHtQqIfjKhZMWZ0t6OCeKU86nVQr+IbxKih1XEXwdM5so5dQGTr7BjBeY/n+KECQ0zw3Bm2LP+jgQTZwda0h/609t9apyJL6acbGXc8MmlvaQdTZP23G7SzxfFTEDm68DW3w8xSSTdDul8+k+L8XbIqB3hyNEVy7XU4gLFtMw4zpUM0xCN3ym7lORvIW8iqiapCqmtQsq+zPgSzyKc5/kB+4SATgweajR0xGBWq42D+27N9X+9YPYXQte4j99MRPSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(110136005)(5660300002)(54906003)(82310400004)(6666004)(7696005)(316002)(7406005)(7416002)(4326008)(81166007)(86362001)(8936002)(8676002)(356005)(508600001)(40460700003)(70206006)(70586007)(26005)(47076005)(2616005)(2906002)(16526019)(36860700001)(1076003)(36756003)(83380400001)(186003)(426003)(336012)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:27.4521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d7524e-cfc7-46fd-266a-08d9e2825691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3460
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Initial/preliminary detection of SEV-SNP is done via the Confidential
Computing blob. Check for it prior to the normal SEV/SME feature
initialization, and add some sanity checks to confirm it agrees with
SEV-SNP CPUID/MSR bits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c     | 33 ---------------
 arch/x86/include/asm/sev.h         |  2 +
 arch/x86/kernel/sev-shared.c       | 33 +++++++++++++++
 arch/x86/kernel/sev.c              | 64 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_identity.c |  8 ++++
 5 files changed, 107 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index faf432684870..cde5658e1007 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -364,39 +364,6 @@ static struct cc_blob_sev_info *snp_find_cc_blob_efi(struct boot_params *bp)
 								EFI_CC_BLOB_GUID);
 }
 
-struct cc_setup_data {
-	struct setup_data header;
-	u32 cc_blob_address;
-};
-
-static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
-{
-	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
-
-	while (hdr) {
-		if (hdr->type == SETUP_CC_BLOB)
-			return (struct cc_setup_data *)hdr;
-		hdr = (struct setup_data *)hdr->next;
-	}
-
-	return NULL;
-}
-
-/*
- * Search for a Confidential Computing blob passed in as a setup_data entry
- * via the Linux Boot Protocol.
- */
-static struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp)
-{
-	struct cc_setup_data *sd;
-
-	sd = get_cc_setup_data(bp);
-	if (!sd)
-		return NULL;
-
-	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
-}
-
 /*
  * Initial set up of SEV-SNP relies on information provided by the
  * Confidential Computing blob, which can be passed to the boot kernel
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4e3909042001..219abb4590f2 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -153,6 +153,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
+void snp_abort(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -171,6 +172,7 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
+static inline void snp_abort(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index dea9f7b28620..2bddbfea079b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -928,3 +928,36 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
+{
+	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB)
+			return (struct cc_setup_data *)hdr;
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+static struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd;
+
+	sd = get_cc_setup_data(bp);
+	if (!sd)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c2bc07eb97e9..5c72b21c7e7b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1983,3 +1983,67 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+/*
+ * Initial set up of SEV-SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the kernel
+ * in the following ways, depending on how it is booted:
+ *
+ * - when booted via the boot/decompress kernel:
+ *   - via boot_params
+ *
+ * - when booted directly by firmware/bootloader (e.g. CONFIG_PVH):
+ *   - via a setup_data entry, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static __init struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+		goto found_cc_info;
+	}
+
+	/*
+	 * If kernel was booted directly, without the use of the
+	 * boot/decompression kernel, the CC blob may have been passed via
+	 * setup_data instead.
+	 */
+	cc_info = snp_find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		snp_abort();
+
+	return cc_info;
+}
+
+bool __init snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = snp_find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	/*
+	 * The CC blob will be used later to access the secrets page. Cache
+	 * it here like the boot kernel does.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
+
+void __init snp_abort(void)
+{
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+}
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb403340..2f723e106ed3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -508,8 +509,11 @@ void __init sme_enable(struct boot_params *bp)
 	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
+	bool snp;
 	u64 msr;
 
+	snp = snp_init(bp);
+
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
@@ -541,6 +545,10 @@ void __init sme_enable(struct boot_params *bp)
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
+	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		snp_abort();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		/*
-- 
2.25.1

