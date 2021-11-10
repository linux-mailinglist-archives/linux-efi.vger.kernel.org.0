Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23B44CBBB
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhKJWLl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:41 -0500
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:8003
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233795AbhKJWLM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPNQ7qTHSXpyH+e/uzTEjBzSxJ8yvg0jTZrEOq5jhiXO58VmrtyjYPp77RBAi0V9f9E7nXy8pW81dp8HMfnhs763F0QBfs9KReZshIkFws8rapZ38DI75XaOe51ouvhY+XlEir+x9pK0qQUU+LfkZYTNaQcq9TZevz7NzB50Y8170AWFlt5gis0tchaWBjmjP2wWNt9C/fLJxgCTXHBwmL3LbtkBzirm3fTxpqVP4nihnVphmYiYYMKnrIX75t+vIsDqDJ3BATlmhAxO9QluT4yerEH1jRQkj/PcyH3sGXbBBLS0UsTG5UJG6YVfkt4GcR5v4DYrDS9qUzb16V8Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCJIBDYyigrvlOKT7j8MYAbFPtHLbhr6NwQVNOQ/5XA=;
 b=jR4MjmYlTi6rQ08H+NEG4KYi5FfN+WdFug++abIQm9+Mto5nigxMffKwLzUs2adHTPUPV0VWgI3nS9rrIgD+gPbpNLrI0yfgx8O+Upq1fp3FVNakPtWVj2Kka97Jlx6zODpCSk6KTkXiXP5o88jfhnlzSNx2wFqxw/ODjbzwWTiw9eAJLdbdoRx9AZRP05vcnbasqTQPK2evZgd3b3VkrTOLiHFOB8sobTt3HySA03sLJUxOW2ZlvoqQekFBbpnWYE+wDkaRKxeyipxKpqxh3wQDysQKJrqGzVXLKbDeeMmxpEadejaK8sQ4BXmiT//eOpcOhO8NEW8xKl9Aypqcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCJIBDYyigrvlOKT7j8MYAbFPtHLbhr6NwQVNOQ/5XA=;
 b=MavS3wjOlvEFwCLzKYod4nLimcUrPb7aTAwFj8Pw2CXbmyqIbK56KGbVjxdvwagGLCLze+9c7xiCey3SJz6vc4fCKHFayVOOw2SLDk9uQ1ljyrl6sMAsyvnfXTdYQ/JbJMtYvonA+S51lzwM0gmItZkiFGdcQAkwwhRQ24DNKKs=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:19 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::4) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:18 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:09 -0600
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
Subject: [PATCH v7 11/45] x86/sev: Check SEV-SNP features support
Date:   Wed, 10 Nov 2021 16:06:57 -0600
Message-ID: <20211110220731.2396491-12-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d288a05-bf2f-42b2-b662-08d9a49699d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2711126838EE6F74D43EE48EE5939@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlxFNJcsnCU/nA6hTbpuEZro2TSRZc1GkIlvbU6cpp/3KmDSmXxPm3yaKQHaNLT+pbItMMJYEBcwEeZS/vasloMPnz4NDrS9Vkw1sqX1Hb30h85kEgdzhnkjIQEp87TSdmU1pfdh1bSOrNs7g1MltDPWdoLLJUXh/E4QSRn42RmVUEe5uvmZ1e5XUVOoAleGRNK5BZCksyCY1ppyFmvwSc2I6k2OiQV8u0+z8vvdBtceESGM5BdZ3uxQJ9zH9oAZMZrC0soQC/VVY4Dr6jTfunAr6JUkFClU9ccBRZFgzn4QT6RTIg9z2qaHp+30Dzqv9JKYj2Op6tEeY6NWRjg8/UWWZa/V/uT3A/Z1VdO3KjdIccZLILiPPg5QvMBZMCvsHuYEp8j1YOduc44F051TRsNhETOVLlOs8W/F65Ny44DRovtZxz4CRDFYwmcnlnvpK+tCehKZJO12RJxoQ1EOvSMC/1l7tuwL5hxtrwDWjEZ/b/SQbLyaoWwTnVZ0XICq1ybKxK6HCFbda1T/fhoVq4qfhOc5/Ub0wLPZXUjEEEjcOmtHletDxUVku4aQr4q03OL837rtVL+Hmy0y7jS52g4jrYEiqMkZxpxHQ2vYzEz+r43NjG4pE+GPdlVLJeQRaM3/BsN8R+bII3+OJrPsC0S48FlA+M8jgU1qsJ4BgLb/yhJySKtT0lfGop2/38fPP1hGndx6fpAzg6YZCkvqGCMteV5rDLDwd/jRdC5u3p9wBYwLNZonXdq35uXiUIm6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(16526019)(2616005)(7416002)(83380400001)(7406005)(8676002)(81166007)(70206006)(36756003)(426003)(4326008)(70586007)(1076003)(8936002)(7696005)(336012)(47076005)(110136005)(2906002)(54906003)(356005)(5660300002)(26005)(316002)(36860700001)(82310400003)(6666004)(44832011)(508600001)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:18.1594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d288a05-bf2f-42b2-b662-08d9a49699d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
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
 arch/x86/boot/compressed/sev.c    | 17 +++++++++++++++--
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/kernel/sev.c             | 12 ++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 78f8502e09b5..e525fa74a551 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,11 +119,24 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
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
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
+	 * the SEV-SNP features.
+	 */
+	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -174,7 +187,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
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
index fb48e4ddd474..80a41e413cb8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -627,12 +627,20 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
  */
-static bool __init sev_es_setup_ghcb(void)
+static bool __init setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
 		return false;
 
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
+	 * the SEV-SNP features.
+	 */
+	if (cc_platform_has(CC_ATTR_SEV_SNP) && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
@@ -1453,7 +1461,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	enum es_result result;
 
 	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+	if (unlikely(!boot_ghcb && !setup_ghcb()))
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-- 
2.25.1

