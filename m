Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD447049C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhLJPtV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:21 -0500
Received: from mail-bn1nam07on2073.outbound.protection.outlook.com ([40.107.212.73]:36162
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243564AbhLJPsW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYMm2YsMAq2XOMhtAK8SYwvNY0iAEFlxzF6a1PU8gONN6tkDnlTUbRSUMqE2CgZb//NBCJdZKbCbFQQN5fPE7miCt322adnXa4BBqtQee7cKdtblRuGCFoMsSKYRorJeoPdZb331kJ27L37oTj7OKHO4YQ/zK3goOuAXzFAjwFBlAi0eFTYLf3VHjHIsnM3P/qQosltVmAD/nN63V2cD9KcE2cyTDhB9fW6auQXrxSP1fh7fyIcY8QI8+vG6mEfTPx7OPrmLNZe89FlS6dCt07LYevFy+ylascqQexx62ZIFdCNx3sdX+B58fjmPanWZAsyNGw+na/L3J0sa8E7brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYCa3go7t0xvc/VHRtBeReVS+lyilJUGFhqIofxMVGY=;
 b=WmYukEMSX934cpqqF7CKqiyIjcwYjIj/lBr8nOU8jQmT+zkTfuhYH1MPfjXobYxEBUZDDSl/vp4hdkvPP9XvgLmJyTHGlQs8Igzza7oEgeNbCXK8oqiOWcYumBIsmZ8PaqFGZs8QW51GDxG81XNTW5MalZMt9hfI1BI+SCjoh00aUrewFcUSzvb7GrRw8BedYr0lwPW3Pzt7rb13pFvou9AJf3tzO+T6vWrxz33Ns8rqKlHcpaQ4UWjrUNWNsM3VJCcsVDQjfWMch+E2tymjxicRQkk6j6DLZ3kA2LvbSuQvPCopimwtNe+0nVzc2i13UVoWio/hZnXEckkAsX5mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYCa3go7t0xvc/VHRtBeReVS+lyilJUGFhqIofxMVGY=;
 b=OMskLcnGmrjGvRndQ347L2C2fO4QCNwoPtshccgquTS4HIwWRo5TNGjPRlWlrKndxffmfwy4a0tSWreNanoi1JnbLq77ch92oeq5lDW29qg3Eoi3GTNFf9pKdT7PeDYDmcyxzMFpLJfYLS38yV5X+cGDzTlA9largX++F8oNwxQ=
Received: from BN6PR14CA0011.namprd14.prod.outlook.com (2603:10b6:404:79::21)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 15:44:43 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::82) by BN6PR14CA0011.outlook.office365.com
 (2603:10b6:404:79::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:43 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:40 -0600
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
Subject: [PATCH v8 33/40] x86/compressed/64: add identity mapping for Confidential Computing blob
Date:   Fri, 10 Dec 2021 09:43:25 -0600
Message-ID: <20211210154332.11526-34-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51a4816b-28e6-4700-0925-08d9bbf3fc49
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43520DFBD8D19A5DA793C8B7E5719@SA0PR12MB4352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eyFxGLOAMm5wosT8tFgM2yBXSGX9eYCVtTBc/+zUVfJQ12L59Jz6ShcEC0LXdq3x9ULoX2+DfQ+hCHB86j87JOEmEgLQSqhpFHiWPQWV1CH89KvORKudWNExpnJB7TyvrVHn4CghykYmJ8Qg96xxtzrcgfoORptoYUhAqESe2BSpnHJ2niLHjoIJ+DfqoF5N0sR03mLnui0u0O6G6Y8NORgtbQUcy4kW4XOQpFGQm+Aa8d3073Dscd2C3u4LVXo3kwj/5opk2tNG+kwyUPimoYIueP/P9FM2fWFdSYPjnUxiOu5EpxI8ajw18uj1dmHHxnFVbIf63SX0fW8H5K8RFR7S9h03piYP1esaz131mfgcF+iXHLRg0QWgpyzOhX21jW5vRGZrMzzWaeWK7mEaEwmlGzgGKPyo17oZOmbPkbLDgxIGEAul+u525ESQ2krJGMUzFZktM7M9dHVQy9I+17j2EpYl0jDSxo/AkKCW+RR/EdFzGjKQYjssa7UOw1I8i1x8XTDr3XwFRo41a8MxR0XH5/XYOjd+bjloAWFUjEyjVmFLTZGMR4iIGnQcsuhjecd4foznw4RLDmVKn3QnOmDbyxzhQfbmPf2BpS7RtszKDeqrzUHn6F43sH+sdfPZwes6T2o/q7ec5Vzc7iWmvt7X1ACP8Dl0RivbBWLjVW6quvjEUoqI753lY3l2RHSNDvgx5rGcQBTrMg2kTH3RsDTXEUiXR0+sJxMqBUFhwXqg5Kdi5Dx6RzWtjvPj1VRS2IdtHsFf05M6OC1z8t1QOUQyPdgLCd4SeC+3mleuu5fIFQ+j0TOck8xNccvpZfr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2616005)(86362001)(40460700001)(82310400004)(316002)(44832011)(47076005)(8936002)(8676002)(336012)(5660300002)(36860700001)(54906003)(1076003)(110136005)(36756003)(26005)(2906002)(426003)(356005)(70586007)(508600001)(83380400001)(7416002)(7406005)(81166007)(4326008)(6666004)(7696005)(70206006)(16526019)(186003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:43.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a4816b-28e6-4700-0925-08d9bbf3fc49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At
that stage of boot it will be relying on the identity-mapped page table
set up by boot/compressed kernel, so make sure the blob and the CPUID
table it points to are mapped in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h         |  4 ++++
 arch/x86/boot/compressed/sev.c          |  2 +-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index ef77453cc629..2a99b3274ec2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -37,6 +37,8 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#include <asm/sev.h> /* For ConfidentialComputing blob */
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
@@ -106,6 +108,27 @@ static void add_identity_map(unsigned long start, unsigned long end)
 		error("Error: kernel_ident_mapping_init() failed\n");
 }
 
+static void sev_prep_identity_maps(void)
+{
+	/*
+	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * kernel to find the in-memory cpuid table to handle cpuid
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		struct cc_blob_sev_info *cc_info =
+			(void *)(unsigned long)boot_params->cc_blob_address;
+
+		add_identity_map((unsigned long)cc_info,
+				 (unsigned long)cc_info + sizeof(*cc_info));
+		add_identity_map((unsigned long)cc_info->cpuid_phys,
+				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
+	sev_verify_cbit(top_level_pgt);
+}
+
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void *rmode)
 {
@@ -163,8 +186,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps();
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index e9fde1482fbe..4b02bf5c8582 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -127,6 +127,8 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+bool sev_snp_enabled(void);
+
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -136,6 +138,8 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline bool sev_snp_enabled(void) { return false; }
+
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 29dfb34b5907..c2bf99522e5e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -120,7 +120,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
-- 
2.25.1

