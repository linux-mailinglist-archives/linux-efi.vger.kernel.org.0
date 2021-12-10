Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE74704D3
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbhLJPup (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:45 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:37217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234244AbhLJPri (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3vGiaDwMqpFwlVh/62jCojTr2rm/lhhC8At4Osxex0rgyXWxvKtk5q+Nfii/sTZSQnc7Pp0/I4Ar0E7RLVRjqkLexeaiedjxKCed6XPThl5gJeYoxtSCT8HCAUZJC9YAj1Lx6n5wRhHLTWLf37ut/D854VT57O5si6RGIJbeqMlwNWTWjOJYqr+tvYXFnMFHSFgCn45GOcNBm/6Tt+gJEa4eAPOEAoX+bnGxsxjO1AvKRGH5Ewvzm5vosobX/YC+6sQ+gBs9AyhMWIv4HHjYniYM9ULEkavdUwmRIgqoH7GsJXy3/LlXT9CiCXFWVhTdspFlSEUYHVYnpWSXoPv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eycTia3MoNP1VfJXOqw4wwKMqsWgwb1lF4vrO6g2G6Y=;
 b=bD+Yc+2nSYGYPbIMTNe/ziCcSJoZcy0A5DVxNAwFNPJ+HJdSwnR66gSXJv2m3tXTa0mE1by503M3KB+HvfExFBw19HkQkfm+nVq10EmelCKaOvEuSybPV//ElWL8cC9bidhq+0xvYW3+VbexUGi0jA1CraAaoKcUFIHlNK/47WSE15BT45ND/M+PmSYFuhZmR0X8QXkvPz7yCaqsRBCeCKgjHoRr1F5WFqFy7WmdDrHIW6A63aqBrsBW68XuLpjWmIKvqXhe3DGNxrdYUctA435MFgbVCrWrI/9H+TbH7q2UsnYQut663b4fVNjkQZei9iO5H6euK5f06TYzI1GbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eycTia3MoNP1VfJXOqw4wwKMqsWgwb1lF4vrO6g2G6Y=;
 b=IcyWvMiZ3/IA+zqeEpdgJcHb81NufNNX+7a/b2AM7WPS9FvQJnnSdf/T5SD5MX2j3PZBAr9CWe8Hm6wFHh5wfiqMDq+Eq55cAi7jl0cEk08AXrlQ8jZt/ui8/4jJzgdALwiIIirtAi7hPtUjuHYAKvu5cuafHfjjwkV3SmORyKg=
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 15:44:00 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::92) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:00 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:56 -0600
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
Subject: [PATCH v8 06/40] x86/sev: Check SEV-SNP features support
Date:   Fri, 10 Dec 2021 09:42:58 -0600
Message-ID: <20211210154332.11526-7-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1271eb9-d6a6-462c-79bd-08d9bbf3e296
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0034CC770FD913BAE5D091F8E5719@BN6PR1201MB0034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b1sc8U5lrom19G4KdLmdOgumo3t/y7NtUYjJI46syceRI0K7CyJUTaknWjL0Fg3CCi4GhXrS1Nj462UMGB5K+Zi/0DAw7IvQm4YBOtEmWDGwuXB9h9mjwzTr44nmloEG+Rb8SBEozq2LCQFa9/lBe5DW3vCoSSQm/rnzJmJUF8n/akJsBaatdJ/2ISLwmt28Bt/7W17dYjTACmN1xTGQM7yanNy5Gnj2rkCugpWx61nfKFur/eNQR/W8H8VqTDPUmrePHnvwCZg/0q8Qf+6WhVX1PqYMGdcSRQdlfgScCPqMXVA74jRkyXAKCWcm2xeGP3SClSxHN5WACxh6esgZL1f0BTp2To5/uHolLG8U994Cak8XUnjM4jEsUmalMnJNn9S+WCQx03HK2zURq7jI8/nzIhLQ+1r2/NnrNfibwHP+iH0i35iijhYDEoraxNsrHRYU207lrKrb1stVe/YuCvh+SfMUQ7kwg0BbkOPcE6PeDfT1VfD7i/BVQJ1tmENuwhZUDWx2xAFsxzZjzO0ahxlqCSKY7FXtb8050inPALjcx5gxA2fFUqZIRAAlpUJ0vq2MAsAD3Kbz+40n/jkK2JimiNdnzhOc/PMy6QpqJi7J3SRE9VloeEk8Mvg063G9ohI56QQlgoo7cZE6EGbF3nvZpzAqi8g2x35isCJy/aR4KioHagLBX02z8z+zIagKSlmAr9T/PMd7cTOwVdZD8c2FbVijHuYD/wGA6U1rQjE2j619U7vjhcGLrx1ZKq7E7WnbZM+6yfb+wQolSuiRG7gevJq6fQ7tzylcN/gp9lLghi2Is1A7zrrlBML0k8o
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(36860700001)(8676002)(81166007)(8936002)(508600001)(426003)(4326008)(7696005)(2906002)(336012)(16526019)(356005)(82310400004)(44832011)(110136005)(1076003)(5660300002)(86362001)(70586007)(2616005)(70206006)(83380400001)(26005)(40460700001)(7416002)(36756003)(7406005)(316002)(47076005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:00.1501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1271eb9-d6a6-462c-79bd-08d9bbf3e296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification added the advertisement of features
that are supported by the hypervisor. If hypervisor supports the SEV-SNP
then it must set the SEV-SNP features bit to indicate that the base
SEV-SNP is supported.

Check the SEV-SNP feature while establishing the GHCB, if failed,
terminate the guest.

Version 2 of GHCB specification adds several new NAEs, most of them are
optional except the hypervisor feature. Now that hypervisor feature NAE
is implemented, so bump the GHCB maximum support protocol version.

While at it, move the GHCB protocol negotitation check from VC exception
handler to sev_enable() so that all feature detection happens before
the first VC exception.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 21 ++++++++++++++++-----
 arch/x86/include/asm/sev-common.h |  6 ++++++
 arch/x86/include/asm/sev.h        |  2 +-
 arch/x86/include/uapi/asm/svm.h   |  2 ++
 arch/x86/kernel/sev-shared.c      | 20 ++++++++++++++++++++
 arch/x86/kernel/sev.c             | 16 ++++++++++++++++
 6 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0b6cc6402ac1..a0708f359a46 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,11 +119,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static bool early_setup_sev_es(void)
+static bool early_setup_ghcb(void)
 {
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
-
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -174,7 +171,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !early_setup_ghcb())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
@@ -247,5 +244,19 @@ void sev_enable(struct boot_params *bp)
 	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
 		return;
 
+	/* Negotiate the GHCB protocol version */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		if (!sev_es_negotiate_protocol())
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
+
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
+	 * the SEV-SNP features.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 94f0ea574049..6f037c29a46e 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,6 +60,11 @@
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
+#define GHCB_MSR_HV_FT_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
@@ -77,6 +82,7 @@
 #define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SNP_UNSUPPORTED		2
 
 /* Linux-specific reason codes (used with reason set 1) */
 #define SEV_TERM_SET_LINUX		1
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9b9c190e8c3b..17b75f6ee11a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,7 @@
 #include <asm/sev-common.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
-#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index efa969325ede..b0ad00f4c1e1 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
@@ -218,6 +219,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 91105f5a02a8..4a876e684f67 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -48,6 +48,26 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+/*
+ * The hypervisor features are available from GHCB version 2 onward.
+ */
+static u64 get_hv_features(void)
+{
+	u64 val;
+
+	if (ghcb_version < 2)
+		return 0;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return 0;
+
+	return GHCB_MSR_HV_FT_RESP_VAL(val);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 19ad09712902..a0cada8398a4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -43,6 +43,10 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 sev_hv_features;
+
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -766,6 +770,18 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
+	 * the SEV-SNP features.
+	 */
+	if (cc_platform_has(CC_ATTR_SEV_SNP)) {
+		sev_hv_features = get_hv_features();
+
+		if (!(sev_hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	}
+
 	/* Enable SEV-ES special handling */
 	static_branch_enable(&sev_es_enable_key);
 
-- 
2.25.1

