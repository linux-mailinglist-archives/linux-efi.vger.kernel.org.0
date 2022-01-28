Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2772949FF70
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiA1RVb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:31 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:22912
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350911AbiA1RTc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG9H2fnpqM/Tx5tC3cs+/rHz+j8MjN4acpAfP6BtEnRJ0ybYJ6r/L5REFTDAIy7M79F+awj0IANxzToa3GXA74LzNxzq7bFxtxdaxUKI4QLzYG88232CQp2TWQ9mVFvC515lGsci9bsHelnxO3Xr7xIY99X5YdF7q+q61VpbDvcqK8TtmWX/U1LdVnIaoZ6iFU9hcEbBWNNRqZl5JmQLr5lZA1u/xxIgI1iIpw4M42Tgmi/a2SsGsPYZVVANZTmgLebdECLS8AKjGdasv8ok0BRhvKo3pK6ybZRs6AR07CjcSn13PFzxYko6hUxQTIXsdZOcLnd18suP0r/zzegvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9lmBFV+LdyZZnJLR+jUMbIFZFn93xT8HQNRgtu4i/E=;
 b=Kz+SGq6TeW/Kbo1fQVATV0iqRD/DYcFHPFHywWfY43nAVk4qe1bIlj2SA3MCdybARqzTWICNxAaaR6eXD3LWRrQdoF4oq8lhQ67oAprBS7MewnkqpcltPWN1ClNPUaTX80+rwo53GnU+iz8nArFUR5GnYh9FREDQIXaihFIpjClA4vsibbWQAtnEAFhq3o0Q1f0skU5Lha4FRyn/DouO2MiyAgNoo4GOn45IG1wsWeqenE+z4j/0rkx41knXCblq7dX/H2aeRkRcrhbh1g+acDz6uK9rPP4Iqqm0VT3uPun4DSlZ+RCmkTBUu2DuIOpsJiopj6Gjdkq7LuhbSg/iQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9lmBFV+LdyZZnJLR+jUMbIFZFn93xT8HQNRgtu4i/E=;
 b=DyxnnEDVNXD6cUb45frx87HqIWLQhNC6Lj1W00t0Xqhd49xsqYQ2r24WiLg8UL43OGRJ3lzr2azg7TVSqd2R9G+2W5ae0n8JCgVRQ9Pysyj9EKqrf++V2ATrCPezzjzn2SttDSWF8Sr4d7EnnSsRwSi6yt5oSaGMMS2QxfyemWQ=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Fri, 28 Jan 2022 17:19:28 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::65) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:28 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:21 -0600
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
Subject: [PATCH v9 39/43] x86/sev: Provide support for SNP guest request NAEs
Date:   Fri, 28 Jan 2022 11:18:00 -0600
Message-ID: <20220128171804.569796-40-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d9028c-5320-479d-76f4-08d9e282570c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798B4D75B265D98C273885FE5229@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ur/7MiYSyQu3/mp2OfU4iMyDfORLmO2Itei5YfsJ1vQ9FZAXSLfvTNCliewsSC1B6S9dS/5+6pAbD7z7Efd7kET2K/2002GCfW1ZvDYj7ZkXowth6XpNwxoudbIAJgdjq9zLkJeJH8VWWt+tRzEo1hZ7y7ap/5WZAsMYKkD9FPjOo+Q6vyGx/rX6nw/mHrjo+gUXwIFY9DTs/a2ZUz3/1QJT6YZFWkF2l1Su+7CMji9DbM8psycOvqGT2kqljQTOOSVP1QXz26+7f9W5kPIoKLAPnvJmSe8CRfBLnYKssF8xDWvt8wmHjysH68+5qR/d7U+p11tqYuo2Gied1diyCWqMxYsMD/0sC6WYtjMr2dDUylh1OU26/wVIszJvVRNKhQY7Ndi8++M3oAVi2bHzPaFVOlclcIkGXAVd855OTMTFE2iAM9amC4EXcR6JN6tnAZ+E5kfXGYn86V5oaDaj/b2A+WVYEDrhxrkYE+FEsTzrY1zOHbUDphahHeaCpv7tvTH+zTOLmxIAxLXwFM0oH9Ud+lidwyt6ZjY9M7eVUZ0JusNQ9GbX609kzKJDefJ0QrGw4+f1yeKD3uZ12NK3XKTbF8FCOT9kXOccDdVziEVWQAwONEHzODeo6jGox42mzIia2FwPi9tRN5tLXDNJ93xZQNLBkN08SA7xG3ZyE3kWl3yEy27WzVbDZ7QRztxBv8iUmX4z7KLHGM8GH6JnI7CX9rclwr5pIiFZYoq9MSY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(16526019)(2906002)(6666004)(36860700001)(186003)(26005)(2616005)(81166007)(47076005)(1076003)(316002)(110136005)(54906003)(508600001)(36756003)(336012)(426003)(82310400004)(7416002)(7406005)(40460700003)(356005)(70586007)(70206006)(8676002)(4326008)(8936002)(7696005)(5660300002)(86362001)(44832011)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:28.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d9028c-5320-479d-76f4-08d9e282570c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
with the PSP.

While at it, add a snp_issue_guest_request() helper that will be used by
driver or other subsystem to issue the request to PSP.

See SEV-SNP firmware and GHCB spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  3 ++
 arch/x86/include/asm/sev.h        | 14 ++++++++
 arch/x86/include/uapi/asm/svm.h   |  4 +++
 arch/x86/kernel/sev.c             | 55 +++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index cd769984e929..442614879dad 100644
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
index 219abb4590f2..9830ee1d6ef0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -87,6 +87,14 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
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
@@ -154,6 +162,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -173,6 +182,11 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
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
index cb97200bfda7..1d3ac83226fc 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2122,3 +2122,58 @@ static int __init snp_check_cpuid_table(void)
 }
 
 arch_initcall(snp_check_cpuid_table);
+
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+{
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	/*
+	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
+	 * a per-CPU GHCB.
+	 */
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
+	ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
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

