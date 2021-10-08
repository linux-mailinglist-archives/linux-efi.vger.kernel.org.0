Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D77427001
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhJHSHt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:49 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:45408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240396AbhJHSHc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJQnBytqjjGdPavCtgTtsewJNgueuXmph/MbtCg62A3KzmZTahN8co6LHT11/13F4GxRhYlhtVLF0fkPGWg9lmp+4YPfq4CECyY8Bk/bxdoH4gsGsoV1t0oY5IDevx3ajfbK0jE/JQ+etHLbl8CkVuliE1uo1sEoRWm+ylV1JQlNdD/w6H1Cq/X7CKagqpZZ02b6EpgoeQyGIM3rib30Q/pvIjLkP8VdOBj7QS+/tm2mh8BJYEMbAuQ+n5py2kHy8+NoVVE1cyd+ADBaMtE+YQJGm/pce6TT6obBIpRgmRj6YkcT7in9rV8tv0O5rjD5LwgDd4qj55LwLmA68M9TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7JLW7qyMOtwTvf9nO3DychHihJM9mMSUw4fkrt8pak=;
 b=YIIzVo2v2qr+O6kMzPuX7x51ZDun65bgNzBrBF34UJIVY3j/AGweJVSjLP7qK8oSm3sN9PNjt8qeb8TtHnJZAwrAGBMvaxnOpceHiDGfCjhscugswYAJEVokXIQl1NvthaYSncDBHzAPfqbFqFIGL7JH1bvQ2lM7Tot57/JTOfj6f9BWn0ifAiFmSuUORWEPC2x+laoxnkFbQcxM/rD5+euUziHxbwA68IDfnaZpkVcMy7xqqS4K2sEQXM2yh8aOcHIysRuw0Rl6Oj30sCivybBO3GWnqCwnle/c5+/yQGfoGao5GSP2u5OA+aAR7c26yca0/APXiGA2GELJvE+YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7JLW7qyMOtwTvf9nO3DychHihJM9mMSUw4fkrt8pak=;
 b=f0NlTBHz5A5XYzoy+536hVe5ZCyYTPqPQ9rWYspYgGK5pjiBNzgWOAhFLiOmb40br+ZX/nhEsJy/RMFwQGReJ1MP41jO8mttbYTiyFX2d1AsH6ymAfjNr+1U/T7eAiUJQutB1W8WFZYy+gTo3gRtGXgp/bk8fgr6wyvBmW7vOdw=
Received: from MWHPR01CA0034.prod.exchangelabs.com (2603:10b6:300:101::20) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:33 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::2e) by MWHPR01CA0034.outlook.office365.com
 (2603:10b6:300:101::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:32 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:25 -0500
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
Subject: [PATCH v6 09/42] x86/sev: Check SEV-SNP features support
Date:   Fri, 8 Oct 2021 13:04:20 -0500
Message-ID: <20211008180453.462291-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4ca3b02-8edc-4edd-2689-08d98a863891
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41572519BBFEE52B39F84100E5B29@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVMgLVl8ijagWv2Ct/uOtn9J2GixkcaxybQCCnto+e9TZalYeRSCt7dmn6WnRiUL21HrFmUOUhgYTlc7pAiOtJgHNzZLzO9w9IefHvlTwnhSJmqakIGwHYLTp5BZsAV3k0Pbris8EfnjprWfqYFm1eg6LHnyBluod8q2ET+7YGiXcVpE3iDQgjNYxZPCcHEkRrwlRcGs7O4prC08StOs+PmtMlXBJkVsrQsO+N+jHU0ZDs1jjOJHpOf+zxBmAgMIxLjAo4Oak7ol35Tr2jqHdmFrkvNpDDCUhaCAWn5G2H4F7ewqsrvi+2IqeqU3tTihODE4xNbSqtr3BzzKqLNS5O5bpN8yhuqNABOvt2CrOzS7EO7Uvo5RnuF/yBKheEfQxp2FHCUFZjVg1ZDKxMIgOCNG7xh2yCQlYAdqJFs9weUNC4Ehv+7/P0ZpDyU8oQHakcMGGI0lPQIdGc1HRtwINDN3WsdaAJE9f+KStmCmOXWLLF5Aw2QiYgIToVZzDwgfIzI8VTiijUyTPoG6gL3f6kMLWt8Qhlaeu/1nqqWBg9gowyuh1BDiVq3k+9iODfyzobkvV/rfzK4NR5e1Q+TRF8AT6ljiOq8jTNIVLbaZtVo/KQe45EY3Ikz4pQOwQFVmmzSq2llhv0vg8jdR162iF4AXowxoVCiwgU5NtlA76ZRBQXl/HI/noBQOBBRFlc8rhLZ/G00qCwzdj9iXUw8wEmDE0hk3nM33pZeHzgIS7xUeD915N3MCL2ZtMdahg+yI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(7416002)(4326008)(44832011)(7406005)(70206006)(36860700001)(8936002)(47076005)(110136005)(5660300002)(6666004)(7696005)(316002)(8676002)(36756003)(70586007)(82310400003)(336012)(508600001)(426003)(2616005)(83380400001)(2906002)(26005)(186003)(16526019)(1076003)(356005)(81166007)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:32.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ca3b02-8edc-4edd-2689-08d98a863891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification added the advertisement of features
that are supported by the hypervisor. If hypervisor supports the SEV-SNP
then it must set the SEV-SNP features bit to indicate that the base
SEV-SNP is supported.

Check the SEV-SNP feature while establishing the GHCB, if failed,
terminate the guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 16 ++++++++++++++--
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/kernel/sev.c             |  8 ++++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7760959fe96d..8b0f892c072b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,11 +119,23 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static bool early_setup_sev_es(void)
+static inline bool sev_snp_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
+static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
+	/*
+	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
+	 * features.
+	 */
+	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -174,7 +186,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !do_early_sev_setup())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 891569c07ed7..f80a3cde2086 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -64,6 +64,8 @@
 	/* GHCBData[63:12] */				\
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
@@ -80,6 +82,7 @@
 #define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SNP_UNSUPPORTED		2
 
 /* Linux-specific reason codes (used with reason set 1) */
 #define SEV_TERM_SET_LINUX		1
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 427b1c6d08a8..2290fbcc1844 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -631,12 +631,16 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
  */
-static bool __init sev_es_setup_ghcb(void)
+static bool __init setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
 		return false;
 
+	/* If SNP is active, make sure that hypervisor supports the feature. */
+	if (cc_platform_has(CC_ATTR_SEV_SNP) && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
@@ -1444,7 +1448,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	enum es_result result;
 
 	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+	if (unlikely(!boot_ghcb && !setup_ghcb()))
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-- 
2.25.1

