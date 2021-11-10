Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374EB44CC15
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhKJWNZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:25 -0500
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:61729
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234022AbhKJWLs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLrgNgBYl9LOvNiy6ZrfjKIbUgkHli4iVym5i+4BRVMtfHakX9v0i8skGUIRsZwTkJXue+38uBVXceS0QWa0QF/CfPfBVINaR1xhGGtPgL1rkCKl83lIvlq0UAVUzpyEIiyhnKeBtX7Bu3tsMCXtkYFD7dj+hirAVYu8U7lutVkiUU9AOqEHY4xo6P6F8+zVnuQl/UKDTwoqvGWy/u/Y/drcnNabw6AxxYW24SpXAW6XdPZSZL8nwlNCljsXXNQGccMpR0QJdprvO+rRUw/znokI0afgvkNPPnxnNoO1YQIzScZE19X1rAbe2l/gunsZO6HE+i0ZdZFKiXJG7IxLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82su5Dmrce8hPjU1UBJUXmtPGA+4iefGfZMDjKzFveo=;
 b=FEVC7IxR8Rbmq6DNgtPakpUcqN8d0Xi1sOaVbdwk0aX9ZeW/pUdFM8cmyrpZaDXv2hm20yNM7JY+5+C3x07hK6PKLGeDpHb0gKrEMP+u1JoN00zSPEwgACT8nt4F9aeYG6r7LNVRXrGu5UFPqH/RX1aGnuRyaYLtL1Ep+VHvcJ1SD8v2y2El9GSaiMVPN8L9T9JrET79VU0qIAALhHnIHvwq5Kf8u8xJycxefk5t5ZzJmEcGRRgtWDaxBq0CQ6TSAVdb3Sq9zjy5rTZDM40ygdPUB9s8QxEKAAR52ZQ7gvNb31G5o9J3R4Fa6oypfuExn/FfvHS0twIhyZShV8tzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82su5Dmrce8hPjU1UBJUXmtPGA+4iefGfZMDjKzFveo=;
 b=bLRqEwm6gcA9FhwPA1pzke/GsIDk8DSalBacO5POlGMLq+mg2UwOLQxpDCLX7V60Bo4Bh8/yUkO31rC8voAulaTga7OdSUlOy+ymeeTwK5jvGGJDVUGXNeKjstlp8t9lpJFEoa5AwK+5UxHoHd8jRZYvbhiR7L4Jn8c5fM+Ajo4=
Received: from DM5PR21CA0011.namprd21.prod.outlook.com (2603:10b6:3:ac::21) by
 DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Wed, 10 Nov 2021 22:08:59 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::ab) by DM5PR21CA0011.outlook.office365.com
 (2603:10b6:3:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.4 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:54 -0600
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
Subject: [PATCH v7 38/45] x86/compressed/64: add identity mapping for Confidential Computing blob
Date:   Wed, 10 Nov 2021 16:07:24 -0600
Message-ID: <20211110220731.2396491-39-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f259b202-e125-484e-1a51-08d9a496b244
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4973273C2634CAAF4454D181E5939@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ilo+NzNUFcFUWPuc5FFIK2qH7k40WHSKMT6glyXOADS3jbvnkzc21Q9fWkSui21yH9Tpy2f1e+sElhcS9DxZoSWomWITtTPhwdP5eCHEOD+0kLUms8onm4JR/m8HI0tIaCccXsNeTvi+A/wDYjeqPOPAURRJEnzoW67kwWh5cWexwe1Z4FakVbtIdHCkg8OUsTkzdEcbZIX8k/6ucVX6DTxmIN3FfbE7ezfdljEm66syeFPXasoQYBP3Ke2TZd0hFNcy0aGOyfA2UzfxxjfTlZ4R5Wep+Wed2exN8Mx+a33lvH/yhObrndxZehfwc/IBmKGUZm2YC1BKFVSTCPplhDfIzDwQa0yLHGXhJMkAdL9shqfIwXi9Ldv3UCZbMq6Jy6HaG07B3rnlMN82R3JUjnSbteSZCuQa1TjjMRqdiWaKUXV9j08iNepZAuFUlsuDqv0A77Do3DRw0pk2xu0FOcCFHTGOZK+e53atkud8FprC371Ldoqpn+KFSXEIRVXYOc7S48XCAJ7JIsU2+gphNy+JmHXAuYJiTMxaq/9mFmT7/F1ULy/40M0Sf4QAWlCtabdUQ3pXPyJmitHMKpdFTDQXJ5ta7qDsOwaNeJ62KvqqR1d3FFH60/hOEUlQOe4t1JrhVn6YMtHLk762SL1bxHwpf3es8JR0IeVRkaApkmtIL59whDk6IBEPDO/Zt8YOlQpmUFPJ9ynq9GsSQkdqI1SP+7il1xBZO0APBeOjW9nTv/8ml3Pf6tQRFXYSNX0m
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(7696005)(4326008)(44832011)(5660300002)(36860700001)(7406005)(7416002)(110136005)(356005)(8936002)(36756003)(81166007)(54906003)(47076005)(6666004)(1076003)(82310400003)(70206006)(26005)(316002)(70586007)(2616005)(186003)(336012)(8676002)(426003)(86362001)(16526019)(83380400001)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:59.1683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f259b202-e125-484e-1a51-08d9a496b244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
index 3cf7a7575f5c..10ecbc53f8bc 100644
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
 
+void sev_prep_identity_maps(void)
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
index bb2e884467db..61abcb885f5c 100644
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
index d109ec982961..d24ea53f997f 100644
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

