Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E64D0997
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245724AbiCGVgY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbiCGVfz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3B6F480;
        Mon,  7 Mar 2022 13:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQWpkeF59d1rimAWmpOeZT8FMLbWMBVqJpRE62vQeqQVf0nOvPvYcTCv4xtKWnjQ8142mwoMOgZZWqFDRDxR2XSIfl6XlquG9wIBVu6YdixdWmomksDeTTkca3/965+KrYRD2nIDyllvHGMEhexcOH4c2w2rycArbFzZZE0cv7YWwekQWEfyYPU5eWhLP5P4qEbtVwNQMnIz7u3qT7LqfrDfmw1qEg5zYX+cHCS94QKn+/NPIJ6ctHUAFejCTTXhgVjE2fVFVLdPqNpWJV/i00uULWpvwW5UZy6LvgjCZ6Lu9rwyPkpCD86rQTxVBL+jvXYtf6iGoaYNbuSaHIxUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=XbliVTiW5YoBJ+dTALf0Q8t6Fz+6lY00mhRYM+AfXUMbLtph24iMsyad81EQe2dHGzT/cX28fLt0Nje6L7CEOqsbwCla0cNcjmxxG0kFmepoixVmQ2dFLuQpgb+ma+GiR/okO8P2IHraooXkjbpXmDxN+PKgOrAG/ythk/CvmckEJuRQ3nCIrS2oRd0m0AWnqO5crl5isb3uAtjOhdjqoztyfGLJfYwozFK0mtbXgX2EoDZqUN0MnpKrJM8ngQzBZBct+Idt3xAdx2Q1IEjTe8LkJcAS4hGcc83iW3oBVUDNTpTU2iGSbxahkiSDaP5bFofFuYkpXb8WsxhKKkwEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=EAWjic+DpXYSoFFBBxD1xNXaghRzkAPNxougEcSNwZoff1XBhzBs+Tga8jEPK/z4W/YoZFzJ8KyVz7nE1jsyZ+ndIxPWAUOktLCxBsyHpw0yoBHtGlEyUHXC5qZKt/zznuXmZ9NRGaq8L7LTwRHIk7kh2t0H/VGXE0YTY+WgpaM=
Received: from BN6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:404:121::26)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 21:34:40 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::8d) by BN6PR18CA0016.outlook.office365.com
 (2603:10b6:404:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:38 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 12/46] x86/sev: Check SEV-SNP features support
Date:   Mon, 7 Mar 2022 15:33:22 -0600
Message-ID: <20220307213356.2797205-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee2c9265-fdf7-43cc-b18c-08da0082496c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355F2EF32425F9EFB9095A1E5089@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL2M6ADq9C919mD5iogVQ+mNN09phyoVO3uG9WcmPHSEvMofZB96aGGPKZZKQF9/mJqiSb4oYZWCj+hlcp0LhWgnb43H+huSbhYss1eNTvLnHIFNGZkK37hyEHv9Pgb9FZk3iHGAQSgdccc25v+QLs5MWK3rwuspdv6AZJCaysEvFA/CznRxBt5algV41BNaowhsPRGoebVxFCzMIWLfawKIg9rLqAVQ+NV5MrwOH+EMgcJVm2+YqmyJkJX9HVkBr6tMovoLRRies2NiT5N7oUihW41PDb40JhKWBwIjZe8J8a0WQf5xVO9sVIb9o1mdCwYa3orOd5JVePsKksuKKP8Ft4I6Cgk/4FRTxjL6sPM6gc9D9SJSTg5JRVO45ZZ6+WSctA1oBE4aQ4QcKoBloopXHjngCJgZP6q/m0WGzbDmlfRR820JSpvcoGIAsHPQnYDOiLOaAx+4FicklIwzU+yJECaSwvtEvrFseVedROgvbU7TlLPrCEUNJCPMWuBcI5iKBpTBp7ikVKZ0iidqUTVRvNqHbp7xlYvFSOwcVGHT0ykFUX29khvFATVmyGsEhbJEBFoqtk6jJODe4cgjTS/KDs6RVmASIQtpgVyg4u0RcqNiQqoQvCQ7uXUi1xRIfRGWPNDbp/qUTIls8FL5X9VMYZpytaLATVNPrK/0/UMCrt5qSnl6HtMFxDcnPV0JVYngQ9qq8a+MRebbBUh83WyE7iVKj9kO3bzOIhQkApY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(44832011)(70586007)(356005)(7406005)(7696005)(6666004)(36756003)(83380400001)(2906002)(47076005)(36860700001)(86362001)(1076003)(70206006)(8676002)(4326008)(5660300002)(82310400004)(54906003)(316002)(110136005)(81166007)(2616005)(40460700003)(508600001)(16526019)(336012)(26005)(186003)(7416002)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:40.3173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c9265-fdf7-43cc-b18c-08da0082496c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

While at it, move the GHCB protocol negotiation check from VC exception
handler to sev_enable() so that all feature detection happens before
the first VC exception.

While at it, document why GHCB page cannot be setup from the
load_stage2_idt().

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/idt_64.c | 18 +++++++++++++++++-
 arch/x86/boot/compressed/sev.c    | 20 +++++++++++++++-----
 arch/x86/include/asm/sev-common.h |  6 ++++++
 arch/x86/include/asm/sev.h        |  2 +-
 arch/x86/include/uapi/asm/svm.h   |  2 ++
 arch/x86/kernel/sev-shared.c      | 20 ++++++++++++++++++++
 arch/x86/kernel/sev.c             | 14 ++++++++++++++
 7 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567d663a..6debb816e83d 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -39,7 +39,23 @@ void load_stage1_idt(void)
 	load_boot_idt(&boot_idt_desc);
 }
 
-/* Setup IDT after kernel jumping to  .Lrelocated */
+/*
+ * Setup IDT after kernel jumping to  .Lrelocated.
+ *
+ * initialize_identity_maps() needs a #PF handler to be setup
+ * in order to be able to fault-in identity mapping ranges; see
+ * do_boot_page_fault().
+ *
+ * This #PF handler setup needs to happen in load_stage2_idt() where the
+ * IDT is loaded and there the #VC IDT entry gets setup too.
+ *
+ * In order to be able to handle #VCs, one needs a GHCB which
+ * gets setup with an already set up pagetable, which is done in
+ * initialize_identity_maps(). And there's the catch 22: the boot #VC
+ * handler do_boot_stage2_vc() needs to call early_setup_ghcb() itself
+ * (and, especially set_page_decrypted()) because the SEV-ES setup code
+ * cannot initialize a GHCB as there's no #PF handler yet...
+ */
 void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 56e941d5e092..5b389310be87 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,11 +116,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
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
 
@@ -171,7 +168,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !early_setup_ghcb())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
@@ -235,5 +232,18 @@ void sev_enable(struct boot_params *bp)
 	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
 		return;
 
+	/* Negotiate the GHCB protocol version. */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
+		if (!sev_es_negotiate_protocol())
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
+	}
+
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
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
index 19ad09712902..cb20fb0c608e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 sev_hv_features __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -766,6 +769,17 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
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

