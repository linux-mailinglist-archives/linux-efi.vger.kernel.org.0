Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318DA4AF94D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiBISMz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiBISMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F34C050CDB;
        Wed,  9 Feb 2022 10:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdoUimfVPtUJyvhgHEMODpEQOeusnjbzl4j3E/mk5z5bsiS0+7lMWwTVuzoJoo51UZlvPR6VzakUTv3x7GSRXxrDtulZIf/DmgErv8Q2Zz5sO/dw8Ko/FqhrcsEeiJb1btDR+xD2cFPNpAwYuNxgqGQL5ns+/MYlSlzk1d8QYx2j9MLY4YdO7ex4BrUCr5Mzb4sxZezOG5ACyFUvuknGrW7ybCuEdyjFMqP1aC2FsprMeLDrts7OAa2OnEm97tIAIueui7BFK9sG/UAS7NSpHc/eYsxmMV/cBmGjPf0i2LzBA8NU6QfWc85Ptv/TwdNZcYDAmB6n2MoQ4PlX6i8KIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYEFd5SZqARollFkWwFFp4AQ6u7WJFaK5fjHK1gVJxI=;
 b=Aud/ZiZK2KyQjgN7AG+h0LzPdYeGz7IC47JC96W1Zwb/N2hOt/GHwVnPMRPmnfgczfqQ1T1qcTqszYSHpf+tM3oV0x+KXL3vYIFBLSR30jBWfUZy9NWxlJqf4vE7vvuo61/X0Racb4mxDCmETTBnpnUu5Ik4FKky4UsQOi97Wshfw62mldCj67wL1rDrOucAcHBbUytfgvLJM0Zf057b/DOibxiU8YOY3Msw13ts9KAgj9+YvZQtUHrFQqxqRqKKGniilZwU8uzRH8ZwqYxXtrJ852whJqw3B+D+5+arNum7idCSvxvmGPdRnQaUUtiWUwh4W8a9caWsuGMvXR+XEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEFd5SZqARollFkWwFFp4AQ6u7WJFaK5fjHK1gVJxI=;
 b=15cd8cHE+z9T8xySTF08HStwcOwH1MpszC2Qjm/SpmuJ4uZHr4+lYn+Y5L8sTWpnxaSuRKqRC9TQuUitL6VuXYdW7RYFVUpRkvii9K+5a/TiDhaw65HPqxnacIRsiSKcoV/XYD8ZpZXpWdnDXIojv0fZqAL4lQzwPxEcDSsrZC8=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:52 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::9) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:52 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:48 -0600
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
Subject: [PATCH v10 14/45] x86/sev: Check the vmpl level
Date:   Wed, 9 Feb 2022 12:10:08 -0600
Message-ID: <20220209181039.1262882-15-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa2cdf34-341f-4992-1ccb-08d9ebf7a5f1
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB292861C092CF91208E686BBBE52E9@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/7sdj51j4YgBrB8xcauMKcne+G8/XOs2s8ro2HurSwglAj4h03kSsguGSQEkuJcpmH3VfdBIwdYz8WM2GbiF3nwRF+QTqgLgLaoqS2/ISHpRWWNc3iSN3jgZDgEiOE+3xNXTRlcNGIaW32h7AoKnvVe75qsJOiYiIUxY0n0KXjBjIq5XQ7iWi1GHXDULOnPp1UIKR4ku7MLoibmp/FFSTbsO1k8S4jB4i7Skm2a0aQlNGa/BJ9S1DUI2ZZ8xc4aq2vcbtynE75XDrNBa9TlhUb72y7PBfEUtgso8GNmiqoopg2nfhtqt/PER+sWrzqCEI/QDTflljSPYu51heROOo+wqAaxsMI0fcBCmhtAehhvr+yTUWGTlmTnnF9SCcO3SNUTwgzUs4Zs5ZtkrmREELhu8iaXv9DA2PiM2MHCioVYG6dsTmgGgEKbZ0aCNXPmhMzkiSru2CorgU78Yq+ChDS4w+46SHcOR8OqWdUk/gmZN+d3VtMbqBWx8qZi28rEjocCCbb/q8CcPymUp5+CVyrLPE8mlvrM1MLhOtSjqfuCgAtlLNJHg4aND4GZiJJydkz/h/r3FmmNu69oi03FEpV8PeEKddxafRNY4r+Di5nAJmVqNwzKLiGr1YqE3H7yRyPaEe2Y6e7mgouXdL7m/q218vIpx9Xz+lSSzgRW1HkyI7V98JK+cKMxAJGQmJG6yWdXFgkBI6t5Ls8VmG8hc9slnu05g/9Rvbgbmsrcp+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7416002)(4326008)(426003)(82310400004)(6666004)(356005)(70586007)(316002)(8676002)(81166007)(54906003)(8936002)(70206006)(5660300002)(86362001)(40460700003)(2906002)(508600001)(44832011)(2616005)(7406005)(336012)(26005)(186003)(7696005)(47076005)(83380400001)(110136005)(36860700001)(1076003)(16526019)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:52.2346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2cdf34-341f-4992-1ccb-08d9ebf7a5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP architecture
allows a guest VM to divide its address space into four levels. The level
can be used to provide the hardware isolated abstraction layers with a VM.
The VMPL0 is the highest privilege, and VMPL3 is the least privilege.
Certain operations must be done by the VMPL0 software, such as:

* Validate or invalidate memory range (PVALIDATE instruction)
* Allocate VMSA page (RMPADJUST instruction when VMSA=1)

The initial SEV-SNP support requires that the guest kernel is running on
VMPL0. Add a check to make sure that kernel is running at VMPL0 before
continuing the boot. There is no easy method to query the current VMPL
level, so use the RMPADJUST instruction to determine whether the guest is
running at the VMPL0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 28 ++++++++++++++++++++++++++--
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5b389310be87..84e7d45afa9e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -199,6 +199,26 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
+static void enforce_vmpl0(void)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+	 * GHCB page. If the guest is not running at VMPL0, this will fail.
+	 *
+	 * If the guest is running at VMPL0, it will succeed. Even if that operation
+	 * modifies permission bits, it is still ok to do currently because Linux
+	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
+	 * changing is a don't-care.
+	 */
+	attrs = 1;
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -242,8 +262,12 @@ void sev_enable(struct boot_params *bp)
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features.
 	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		enforce_vmpl0();
+	}
 
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6f037c29a46e..7ac5842e32b6 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -89,6 +89,7 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4ee98976aed8..e37451849165 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -63,6 +63,9 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -90,6 +93,18 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
+{
+	int rc;
+
+	/* "rmpadjust" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF3,0x0F,0x01,0xFE\n\t"
+		     : "=a"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(attrs)
+		     : "memory", "cc");
+
+	return rc;
+}
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 {
 	bool no_rmpupdate;
@@ -114,6 +129,7 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 #endif
 
 #endif
-- 
2.25.1

