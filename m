Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7304AF9BD
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiBISQI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbiBISOw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C59C094C9C;
        Wed,  9 Feb 2022 10:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu2NnVN6lE6X3q5OHnECQdigGAjmiqgM9PuDV3pUPCrvjzEopNywqTb9nBdBH/VpigfD84c3tXWsQ7WQfusyXLgIwkkT07N1rlFqZlilmvtkJzho4hM0flisUk6c/YmvF60BI6RpdXnZH7Dpfk2cOlWNbKYY8t9BaoMZSZvnLuuKWu7zYinQz/IwdLN4ESH1zhXbaYzkKQcOODZ2UEkVtBHaNAP1vR09GbeRE7lYPzMBbzwyeXqgkfm+KjqZWBSvpNm2a65VkHNbsZRj3w0ZGZArBpRGzxxoxInDZFb5ZU1jWWRQiiwLHqQCY2Mnt+fT4Gny5EjxKmGdrjux/JsATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fi9I656e4S7H65ZCsOcfeus2dxhg7jtErrinnMHud8=;
 b=Ri0Ki+vOLgubHRw+Z5oX+30GAQV9RbtSUaO7DP9vNBo5myAubO9sz3D6TclGdg03dm+80ZR9TSJs8XAWVOGZnvbBjFHPFl1rszevazJFb1IHURQb7qqiyituD7ElizYsK1cQECkWW8msLE7J/GAD23NSYf2EBw+HLCG8K082ooj3ehJssSQuMEON19V+duu1heocNTKaAtXvYO+ebv/K7+hGGofWjCnZ15e8AYO6pQ3PYsenCfwTShk6F/ucnYUvMDdkYJesP88lrFOPlqEg0M6RblrDSjnDISUviqpvPkj5x8EtQkbUthkUu22f35+F21gFgnSHberIV+oR+YplMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fi9I656e4S7H65ZCsOcfeus2dxhg7jtErrinnMHud8=;
 b=SVG7ftNm9k5JnA/gYocRTJpeWMe8XyarA++e+UDmf243eZUyydPmkMvQVlkRqwturesMphPbakzspfqXZsBs5SR9R2db9lL+/l1ya50a1dZI7OycpP4f4+nv1bLh6qFAVMFKdLZeDk2jhEaKZhJ6cgLZb9Xn6XMxkNB7TIVxjXI=
Received: from CO2PR04CA0134.namprd04.prod.outlook.com (2603:10b6:104::12) by
 MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 18:12:38 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::fc) by CO2PR04CA0134.outlook.office365.com
 (2603:10b6:104::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:34 -0600
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
Subject: [PATCH v10 40/45] x86/sev: Provide support for SNP guest request NAEs
Date:   Wed, 9 Feb 2022 12:10:34 -0600
Message-ID: <20220209181039.1262882-41-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 61189f15-3ff3-4a41-6c1c-08d9ebf7c0d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB332714D2025178EE28BC9057E52E9@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Hjw+tEJyQxZkQxTWVTc0HiPUuIQFmIbweAaYsd6hYxrTwvSmWu02qpapeeAefE/KZHO3c3/U+xhjMwHkhPG42cKdAK0WBrOu2je5Xb1msaw8n0O/f85KHDqPBOSVcCosr4EEeUi9qZ08aYZyCGiSr5uAah7fsq+5/5ZuSIhrLID4hdAvoTTLeWFBb6ckF4Qes4WGVzmxvaoED0JrastlXCbwJF4nUGKLUCk/l+SXS+rqTBLnkD4AHBw0JUA6LDOXHsonquQVINKnD8iMUy5j6AHmSqDJz1hIx88uQ4H3YoUOXQyKoruw815X4IEPg1flOI1QAx0aGBKdzH/6zrTAFsJ5LzvNcoEYIY9i5h4pL9oKV5AW/Tf00f3FbyFDW7Ff22Xt3TDDWaB4VHoGVGHsYi8T3epcOlsNGK6CNh04gKWUglJhAH6Ia67oUtsI+obi2v3TWLKRSG5EbRFFZaRhOyjafwC9IaJLU0hd8oAilNqpApSGh5Q7fK3oCCT1NkWw7sjIg+y/7crPI8XvJ0fcDwPRFjf3jF9JG8T6odWb8eOpTjWu3C7f2GjwihlPY23ptmyKtOOCK/I9S93sXMGDQo3ogD+nYshLJgaJJj5gvVQ4jW5d5lHjRcB2YfiNWf1M1j/DbiintToHv9UuC23vA6ii0KQdUydN+9Gn8QJJ+DIsUCM4duUvBf8eO9ABEAsZBXipi6X1Tgk3UC4oNmTbSmejeXg5wxft6o4ntYxaEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(40460700003)(16526019)(26005)(186003)(1076003)(336012)(2616005)(426003)(7696005)(508600001)(82310400004)(70206006)(83380400001)(70586007)(4326008)(47076005)(8676002)(8936002)(81166007)(7406005)(86362001)(356005)(5660300002)(54906003)(7416002)(2906002)(44832011)(110136005)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:37.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61189f15-3ff3-4a41-6c1c-08d9ebf7c0d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 0759af9b1acf..b8357d6ecd47 100644
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
index 7bef422b428f..cafced2237f3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2093,3 +2093,58 @@ static int __init report_cpuid_table(void)
 }
 
 arch_initcall(report_cpuid_table);
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

