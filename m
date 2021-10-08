Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E62427061
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhJHSJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:46 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:15072
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242913AbhJHSIV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVXqJGgBFFEzCLtXpqaSZoIiaCwUY8HfKYuEtsKh79Wie5qmprH9roc1mSXyE9hGmYh9LUAp0stHn3ZOfPmkxSlg9g0D858RHtbtOZQjRA0KAVy9RjT55nKJIXc4ZeD98fFOsn4Vruilt+ppbf+omXy+KahXqV8tI+JiC6XhJBYyuiDWQ7TwIfAMoSDZdSp+78uO2409FZn7GiJVZKbFwVsbUQKvZfpBWXdyVX9VmqEAX38ZrEdjIygRH7HW9u24op5uIvfgsoYW9kGIpWIsk++59aAr5t8QZsFQtwdr32zoeNPh0q2uEjUvqoq1nzMEEikWMZIuLUwD5/bsvj7BQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJTsnK/YjSww+NhZeBaa3LqBwpkYwEJtkuF6/CdOqtw=;
 b=d1rA2dB00DKPgqDqQzpaf3eMqOqioHOnRpjB9384OId9EYwFqVNDS52abP+T9fjsj0K0i3CP50vo+wnOZtlGjZMiC8Tdr/h9wUIiDgdTqgc4q5mcPWqqsDTARdatPrXSTA5DvOyXm+Gyn8da5Uo4ukWEqV6kzyX5I37XgtF8knamPRPEg3M0bTc5aR6Jw9kfCuegf8oRg3wxGT0rQn0yWOKaiC/1wGJz2ZIs1qTe5K2W8eVazHeSNP3SLWqeVaqc9r6+dCBLzUAb0go6oOfq/QBZHu5S2MuVD5YQBFEJeoiBK47+BPVC8gU6U3bvEx7h1SLK5z85DEAgd6/z6YGrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJTsnK/YjSww+NhZeBaa3LqBwpkYwEJtkuF6/CdOqtw=;
 b=TnRfDhD1aCY+uU3ONstxnR+wjDHWq6/Z7RhwVII/P0MFFdbAlairydDthbE2hznBeo079VuDaCaCEu0d7rQAsvVpVDNmoOreUM0W0UQoBj5j+VhIwVbnKRGDmKD5bFNBqnEjFOM4URmAu4vjDMOc2NH7wawEI24zQIRuEI+Lhbw=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:06:21 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::7c) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:21 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:15 -0500
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
Subject: [PATCH v6 38/42] x86/sev: Provide support for SNP guest request NAEs
Date:   Fri, 8 Oct 2021 13:04:49 -0500
Message-ID: <20211008180453.462291-39-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 172569e1-1cff-4b0e-ce06-08d98a865587
X-MS-TrafficTypeDiagnostic: BY5PR12MB4950:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4950C0A8750E572D4BB6065FE5B29@BY5PR12MB4950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DUiwlXxKFSDSep/x9qP3UyGZzHr1PO4gOzDgefoMPsUDBucTR+OZre3K3p5Qb7ZyN4hDGzfm/paywao+3GxLQC03VdMx6CwgvwpruEFZlGc2YjAR109JsP/Jf6XVimkFBKdK52cAoxBS1SaCL+5S/4xpHyYrEMgagahkBxkuhP+VrtRQ3Pj2aeOQ7BuaKxZg2V0xvYaDUuF9TZBQcKaGRPHO9RaWcFH+BG2pvHivqBgoks0nUdMnxWJR/XelLFY8+j2TehGOD7+sDDC9akHi9QjAb81jBq6n7HG7/T53FlNPCFiVIJUQSvQFTSEs/hPv2xbIA/2v/ctGWGQk7dOR71yvbVJRyjt7ylSwp692NPMJZj9wv9VDw7GwQCAsapb7pbLGh7d6ABWQFUfqUIO4/fgazJl/Z8H/90WJMipD4S9ZvlnfBkRhSrOuOVFS1cgRRHcpHBAUqnTjPuGj4DE0TLByGb3FE0knwULjw9z8+FL+02qDX6yUnUAMZszwZPV9G+PoTBXWtb9nxZxo/LQ8sNAzc+bUpyK5LM4fGpw8zW+6WNWzU6oCTQOyeqKRu0N6ybH7K5kltU69Znw3OKQUXrmZmPIVDxRD4489XSjbUea9fnS5EkmU/BZ0jfRWUH/oHYEygllOy/e5lPeXs/TzfaOYbcy6+0xI/5774QrxBmjeEbKtXrjsSlYsYV8Ll3HGXdhIJqQ44vxJ2mIICUUHGhk0nka79DNTUHRIOxDmaZKm6j0yX8J6yZCOahVdAG+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(54906003)(316002)(8936002)(7696005)(82310400003)(2906002)(7416002)(7406005)(36860700001)(110136005)(83380400001)(47076005)(2616005)(16526019)(186003)(70586007)(26005)(6666004)(356005)(4326008)(86362001)(336012)(5660300002)(36756003)(8676002)(44832011)(426003)(508600001)(1076003)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:21.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172569e1-1cff-4b0e-ce06-08d98a865587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
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
 arch/x86/include/asm/sev.h        | 13 ++++++++
 arch/x86/include/uapi/asm/svm.h   |  4 +++
 arch/x86/kernel/sev.c             | 50 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 45c535eb75f1..cf66600b1c68 100644
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
index 1c58060b48b7..4ea8e2f73d37 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -80,6 +80,14 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
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
@@ -129,6 +137,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 void snp_cpuid_init_startup(struct boot_params *bp, unsigned long physaddr);
 void snp_cpuid_init(void);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -146,6 +155,10 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline void snp_cpuid_startup(struct boot_params *bp, unsigned long physbase) { }
 static inline void snp_cpuid_init(void) { }
+static int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
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
index 1e6152fe27ba..c29a78f868ed 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2121,3 +2121,53 @@ static int __init snp_cpuid_check_status(void)
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
+	ret = sev_es_ghcb_hv_call(ghcb, NULL, exit_code, input->req_gpa, input->resp_gpa);
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

