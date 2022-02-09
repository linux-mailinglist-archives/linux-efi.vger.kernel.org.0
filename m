Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3E4AF91C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiBISMl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiBISMZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:25 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6DC05CB9E;
        Wed,  9 Feb 2022 10:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeQhV2tKOiIA4pI15Sn4N2+RM5y3h+puAEjeBISPEtU6VVEG0b39k76fG67og/7/mtR5jaU9QsmUA4R4zvs37PSi4biAqF5Thf88yMvBM2GDI9FVeBvYqwMcn6oaURgCJwXUghR/FzSNpDRNL47ekpH/m7dPHDb2loRCgwVWuafGzHrWrYl153F1eySdGEiy+KkBxje6Pr60xXrEn16+1yHOqYF4E4brzQEE1eHjygpCoSpOkIEtjxyv+rVcpzhWJlA63EN34yrFbN2VqP0RTCqM+9A1eXRjnllxKqf1Qgq5+GovR0Wrm+oL/i8QeDVXWqEJzvAL6z6YuWoEQ4U8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=I0nm5GmQg2aklspTpCBBY2kkloEEF3WPBMWosa+ss9+AzXtWUbAKFVYu49bDu7Mj9wXYlopFzhR1zu9yFdQ3FqO7pbsJA6IDGwvMzkRKemJrfI4+078EmILMoQbiA0Zl7O6OxVrE5smW3Mk6joNw4DBlAZzNT6MYOj02zutKlT7Avb0KipjqPf5OC+y7KPTXrU6IfZ/2x8zptiht7O74u4Vp+7CXKjhbQR7q+zsqel9RfnS9M5nzMUC0wH+PV5Z43RrlHIX2mR2W32qaX54tEx2uQUS0+Xhd703n2RPqgzw4tKbWLujBMvAhAPoRN0PxvWhvPq2JvJehQ1r1/fiFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mfPnCvtEvdQKXq67Q45nwbNtXP/YwlpQqqTAsjWnBI=;
 b=kf55CUDfRnpWlfx6070yEY9Ifd3mC8IFU1BXeNChLr1Xz0RfdEgyocH0hjrCgEAxE2Wejq8N9L+7iSTchk6Ju9mks11WubzEeAK7uZiimw+xtqZyr7qseG2H4/6tCbCTd/pC7Sw1wj95Vpi9QJtvMm5hpjKZWqIw4S15mFh5C6E=
Received: from BN0PR04CA0140.namprd04.prod.outlook.com (2603:10b6:408:ed::25)
 by BY5PR12MB4642.namprd12.prod.outlook.com (2603:10b6:a03:1f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:48 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::f) by BN0PR04CA0140.outlook.office365.com
 (2603:10b6:408:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:47 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:45 -0600
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
Subject: [PATCH v10 12/45] x86/sev: Check SEV-SNP features support
Date:   Wed, 9 Feb 2022 12:10:06 -0600
Message-ID: <20220209181039.1262882-13-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 826d94b3-8e50-47bc-0322-08d9ebf7a33f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4642:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB46429B393C4D2F88F39031E5E52E9@BY5PR12MB4642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCYEwgXDq/EJ9gc81mkZLOAMsyN6zThPgg7rUHkIciXb0hjnseHy75AlY/mTlgCVk/nISol0pli0ZTrS6Njd8mg0IXbOPMQN3THoV7RiatHY9Qz4zlMQtu9XqxIgLU4BDhzeQ5cvLxnVQdUNlhUJ6CZXxgVl9FiqwoWLSbR3dLYBIADe0R6zcuzy/iJ8pe6Q24gey5ExgkWuYg/Ks9rMdSLJR6acA2FuMZ6UV2oiBS1rLL1PCcL33S0TgN7WbhSvNSd6surskgQChcxEdBJaIL7WRLC3OgRK6rD2PH9wuPm5XrRX+U+z3ebdmWy69XwKRa7YzTRiqmO9vhBpm7wQD9TfTELrgednN9r8GwNsEgcfXMyb8M8103g/66Cqacy4YaX7y7HZkNN/Qbsb8UcZvplHsgYROyQyu2mtPCf3QFbcPKMp8RQzLEuOL76M2qzBRvhR7cHBFPtkmTO5Q94bmNUzxsFYbM516YrPBhjj1+fezNF8YTQyGdMgEWs4GP0mFXW5rltIAehyVcASqRmSo8mkAw/L5BxgFqmgD6KlE/Qu+gKh9KHGayn3XfvVKK3V2NkNwACiPCaBxAxn1wrGN5TVbjVSlQ1mTM82OUwu4Ol4jS4DIVvuEuxGfcOh7cOAlSHPlRYBqaK/UK6SOqNTAzDV7e/MZrhKzsJbkIdWshTj+A9WqouJonA5ivaS9fJFMc2ydz2Plhsgrl2SinOfq+zEUL2SosLbeVpOI8WxRxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(508600001)(7696005)(40460700003)(54906003)(316002)(356005)(16526019)(26005)(8936002)(110136005)(83380400001)(5660300002)(7416002)(7406005)(86362001)(44832011)(36756003)(4326008)(81166007)(82310400004)(70586007)(70206006)(426003)(6666004)(1076003)(8676002)(336012)(47076005)(2906002)(2616005)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:47.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826d94b3-8e50-47bc-0322-08d9ebf7a33f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4642
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

