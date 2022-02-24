Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849424C32A1
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiBXQ7y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBXQ7R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E056E560;
        Thu, 24 Feb 2022 08:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doa6r/TzjAuSJge53xA1oQynrGMTHMn1QDVNnkok3fIrc2XslzmV2OxiHKo32mTzk9wQx3PqeBW9KUjH+zaqasYCKif39ByRArtOWuhxEw3OubP5jMA0wszSpYAIJ8cvz9g/Ws76lou2JrdrCGDZ/bKQ7xarHV4WSodUlJV7fX69fztx3jX3UomxmOArEbhcVbtcc/yPuKquB5mUqJkNlBGFrET7s9i1TtaSWPTyUjBx/rI4D3uLvlO8uW+Rw7QuOZ/BRtl0CksIrjIqXdpPD8hDLgW7uWqVXVX7hRodoWfWLXkxrb51P8oCQb+LHkHDLL30jePLZN3PKos/BFgBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=dRjeiur1kvTQrFIcIQL/Uhc6dfSR0hsIYs2TaSUgDy3XnP8OD6Yc5F7leemBbbMGytflQC9XgqgGVHVHBX1jvDZpWcnjjVA3XjUBSsOUi6zdiIaM+RSevUiGhrfN7BiZsi8eqbepjALOLN3kCTU+sI8YQpOv6nyvnbe5fFtcL/LTbCDz80K/XoqkSJ/20+s+ypQjyexJHBkj9u4h9Y0W4JbyAnM9przGpjsEQu7E3YGzraR9d70x4w+S2f2tU+/7AFuS+mX/sd7HZMfO7kwD5i18yi4sAGuhJY1wvt581PzNpro1BU2qnk+Y9LQXHB6m4KzSx7gaIHNczn+T/ttCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=weQnPcPtjG8J1whQFaeYG+HQ6YqwBQ1wdx3BamCt4Ze715269eaatzKiKZf6Ilvyne9qyCmSk6nLG09/4hrRLxnTkA/t3d/2Vwv97XTpg3yGLzbCRUQY0bBy+V+qc9hDCnuuM2OWV0onckh5laWxRSP0FR5NA4YtrR9ItDIp+T0=
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:58:24 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::2d) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:12 -0600
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
Subject: [PATCH v11 12/45] x86/sev: Check SEV-SNP features support
Date:   Thu, 24 Feb 2022 10:55:52 -0600
Message-ID: <20220224165625.2175020-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b52a125b-71d6-4168-9478-08d9f7b6dec4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3728B1BAEE1CC364438B3320E53D9@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFILWTKMuT8hqP0ImtMGK3U388NPtBLgPKd0v3JeWD4fy/1lWHSxW8tnuCHPe/ZwI2Q6gxjPIxcqxrvfsNNDgDSd/lu4Y8hbB38vxydpC8yOl6mU3wKYG40gzJA4IpW3UCGW8rJKlvTWcrcgf/JIy1c6QWiNo5lLWfT/27THu30VpUEQ7Q5tNDgsqiPrQVccMgDQyDiEM5la7saHDvAAsPYYAzasPXSDqbrfS08bKCF4M6R20LxJ09QGrocfsjfygF7pzV91X6buyjE2KQtepUsNseylmX+4zbV2F6Y51T8hNiVF+NhVD3McuRF0H3GPSeFPlQYQbiRNF+Y/D0oli3za2k4eU8WLRkz7vH1kG9dpQjpngSeVOVdYBcVgRZe75dJSZcG6hxwh+4B4SY9z+OaodKE9XiQojvCfeUNrYruFYHVQfG2mEC0nVRFwnCUwdbN9z4db/gfFlC4AMAwNv1tApZOFeUfG1RqsvSqv0pBrDA/AN7rlmXzqMW4V9JJtnIAkaFsReAPTSuFgHImqNoS7X66quHhO8+/H3f+pZGcwrGvvC+c9r7LUsPFIQxxhLcNWdbkNxpTsEHKSbpYdVzjC0LgdWZPfGl3TXDXwNkMOt0zdXOY6Q/o5FKIOnrzGsL3+3rb+qjU81ulBkT+TtqgwF9HaIT+IaRSsUkQD7Dd1/jOx1UGPTJJ8H2wIbi3FuQq539Q8RMBn2iSnUjsooPsoXOE9pvU+p/BEqNDU0j8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7416002)(7406005)(36756003)(8936002)(83380400001)(508600001)(5660300002)(81166007)(40460700003)(356005)(44832011)(16526019)(2616005)(1076003)(54906003)(86362001)(186003)(336012)(70586007)(47076005)(26005)(426003)(70206006)(36860700001)(110136005)(316002)(4326008)(2906002)(6666004)(82310400004)(8676002)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:24.2075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52a125b-71d6-4168-9478-08d9f7b6dec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
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

