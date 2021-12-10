Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3804704B7
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhLJPuE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:04 -0500
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:8237
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239945AbhLJPsa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHWtHuktj8LgWMSZhvoHsi7yRId07Qxo4cbtoNOOImqogVJSAgdj2OSIPRez+BfKDw7rQ6rkGiEbYwGTuxQdF4bYrMU6CGFs0LBbbUmpD/k+1hrr2LL7hslpemCGicwOexgGWNdftIpgclaOVHmGpO5GU0pYGfpeP9jg5nUg7TmHlgePQTCLPaaIBRfVaLOI2p1+g0eDvkOdRJhpBj8IjOFp13TWbfyj8cyQyWFrvNgga5IuP25KmN6YKhWzWb7K6ye3naA+FFhWyCkCsrwJL17K+8SnilZ2ZfsKT4Ay+OJclhzNbthjD/ncWvH9AKFfVBTEAk0Cl4cSlWOev0opVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sm8PipPFsMk1ZLIm74pTY9C3DOqh0tE3RDepga6Qzc=;
 b=NM/Cd00Bi4Z0bQD4giR2iONpqxasjrk/AhZHMNocw0vqQN1L2Iy2/B/LcqWpNS4p1fbxCKM0Y0SP+N2bM4g3QcRUdsrsW7tgm8BidsXTCi0+1a1Z1Mb7rjKu6S7hsZqWmsUokjztV1utlvlr7dRhiTsFxzARUEcdwzm4gE+7CALNhtQHnEDH+uueQbP9jK7RUky9b16XA8UjUtNeuT43LOZQ/sl6flGoOJ+fzAvzKlF2FTGgmAAHk3yeuZLYXhGJfCnqcOrlDSj0crKz25xG2C8POdA7uUTW7XOq0qXmnI2BvXfzYMQw/zIhnYjRsIyIOtkUrd4Fw/wOMJuLUYyEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sm8PipPFsMk1ZLIm74pTY9C3DOqh0tE3RDepga6Qzc=;
 b=mKuRkmtlfBwOb02/kmFaCk8r89TsftQUzFj1WlyVZ+3kl0S+0YmE8gfrue4KHEVXYPkZLX9mJtmdTycE/Pw6XAelbuElAVyG9vcfWeZ+rDeh0c6P7JTXHFSdp4ASxeYQljVFsRr/ZxbA53IuAbc2WO98AMBZjJsbFSCEaZLjd98=
Received: from BN6PR19CA0059.namprd19.prod.outlook.com (2603:10b6:404:e3::21)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:48 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::db) by BN6PR19CA0059.outlook.office365.com
 (2603:10b6:404:e3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:47 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:45 -0600
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
Subject: [PATCH v8 36/40] x86/sev: Provide support for SNP guest request NAEs
Date:   Fri, 10 Dec 2021 09:43:28 -0600
Message-ID: <20211210154332.11526-37-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d4fdff5-bb4f-45cb-596c-08d9bbf3fe9f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4950:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB495062B320B95EB2CDB02721E5719@BY5PR12MB4950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUSDyyUz4IWsM9It/qi6KDxsSwKVqjgmoqyxxz7DJ3H4iIVVcBXWdLGrV0EJqb58blbAPncVLxgDs8a05GSKJ0XXKoLnD44ydsazE/yqlkk5le/8h8r3RPeWIm5DM/qBPfUVXYecp6zrTf4FLfPvAsNnR0ChhPb7HdJbo8oKOsqDsZr6sYmSmFgSuR4cOmjnJ95hwhA6Iz9TYi09t6kbXyTTu9Zu02kxPq42QcX126hDez/ur0i/DCoN5F0UcfLBnp5Ra/he1C1YLRnwqG0Y1FuasNmfeLsHvpIuoAK7TCkLMG8v1FVZXD3L40hxYgVeU1hBdI2JFPORuvb4N1ruAovDMiJgXwBh6E9UlgWTAuq1l/DUMwbgZ6IVaazMAU9YQNtp++xADp0TINxqoppnUDs380kb3A+qVlGApABLppAGPxMoC89MaRUSr+N2jT6Qyrg6cj9zVz677vlzBKJf0fC9z51PFFtnbgfP89mHnZMG8RBBjhWdZtbkR4ExYz0e0y/QNBSlAwZRr7aexsGZUibTtojjB4H807Uifa2IsTypT+H0NSJIEftknDSNNH9AF54qQ+jfTINZrRhGiWleWKQ2OpEtcyCacqS30xM0fVsKFT3nKvou8e4Vp3XWSUNlE8D8F0mnHkNs//9Zig+cDr7SLBNWBTkVexCR6p/uJx0XbyoMH2czFtS9Fx3Fiuc7yC0SRmRj5lyZaG4+bS4lUDYXXnL/jxt1jOWyuObr3hj6TEyixSEFZXSb2jePQFdWSKouD4juki8Q1LXkoymblH1YXaUCvYYekYsTKbIosR/xNJmN/3t3FkL8ACXK/tY6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(110136005)(36860700001)(86362001)(83380400001)(2906002)(70586007)(36756003)(186003)(7696005)(6666004)(26005)(8676002)(4326008)(426003)(82310400004)(2616005)(7406005)(44832011)(1076003)(40460700001)(16526019)(316002)(54906003)(356005)(508600001)(81166007)(8936002)(70206006)(7416002)(47076005)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:47.2470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4fdff5-bb4f-45cb-596c-08d9bbf3fe9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
with the PSP.

While at it, add a snp_issue_guest_request() helper that can be used by
driver or other subsystem to issue the request to PSP.

See SEV-SNP and GHCB spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  3 ++
 arch/x86/include/asm/sev.h        | 14 +++++++++
 arch/x86/include/uapi/asm/svm.h   |  4 +++
 arch/x86/kernel/sev.c             | 51 +++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 673e6778194b..346600724b84 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,6 +128,9 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
+/* Guest message request error code */
+#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 76a208fd451b..a47fa0f2547e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -81,6 +81,14 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
+/* SNP Guest message request */
+struct snp_req_data {
+	unsigned long req_gpa;
+	unsigned long resp_gpa;
+	unsigned long data_gpa;
+	unsigned int data_npages;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -148,6 +156,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -167,6 +176,11 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
+					  unsigned long *fw_err)
+{
+	return -ENOTTY;
+}
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 8b4c57baec52..5b8bc2b65a5e 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,8 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
+#define SVM_VMGEXIT_EXT_GUEST_REQUEST		0x80000012
 #define SVM_VMGEXIT_AP_CREATION			0x80000013
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
@@ -225,6 +227,8 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_GUEST_REQUEST,		"vmgexit_guest_request" }, \
+	{ SVM_VMGEXIT_EXT_GUEST_REQUEST,	"vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70e18b98bb68..289f93e1ab80 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2051,3 +2051,54 @@ static int __init snp_cpuid_check_status(void)
 }
 
 arch_initcall(snp_cpuid_check_status);
+
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return -ENODEV;
+
+	/* __sev_get_ghcb() need to run with IRQs disabled because it using per-cpu GHCB */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb) {
+		ret = -EIO;
+		goto e_restore_irq;
+	}
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+		ghcb_set_rax(ghcb, input->data_gpa);
+		ghcb_set_rbx(ghcb, input->data_npages);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, true, NULL, exit_code, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	if (ghcb->save.sw_exit_info_2) {
+		/* Number of expected pages are returned in RBX */
+		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+			input->data_npages = ghcb_get_rbx(ghcb);
+
+		if (fw_err)
+			*fw_err = ghcb->save.sw_exit_info_2;
+
+		ret = -EIO;
+	}
+
+e_put:
+	__sev_put_ghcb(&state);
+e_restore_irq:
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_guest_request);
-- 
2.25.1

