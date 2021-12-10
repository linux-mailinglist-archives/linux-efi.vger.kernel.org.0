Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC3470453
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbhLJPsE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:04 -0500
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:17170
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236428AbhLJPry (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4dCycoy51H9s6/n/KoYWEUD4c8eQDMD2fqmPsyLDhgPvsXypiXp/fLt+WaMtsxCtcSVBp1nYyvwE0w1QlsBe8wIp77J7tF+0g91I1zym5Rz0UnXhiPb2/tpqRNR27rrS33KR9ti+SVn/mKFIaLkJTI2q4w//m+FiOhEgwoJ95zrS9k3x5sKLFj/0T0Nng8yk83CV4dEAbWUwo22393JV0lWZ/y1xKyl95LhyKG4nkRJ8J/I0qPUUptSK2ZeyuCuVc/F7ecVz3KwO5Uu/wQvK3ZHqN4A4tjv0zfb8x1RYBC/7tb6Ku5+OKyRNtj9bmeJsYryFD1uq6KCxgywzY9mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCaNz2OB4eemonVJ6txrT5EVsvo/ufQ4CZeYTczufds=;
 b=A9I6mEhKNhwTIo230/A8EOj/IDt1YN5/sGk8SXjx/Cz4h2yGmQcCtYtHk53mBePg+zofyHgdSnjJ8q5PP5cK65nPoIaaNcli2vL+ta9CasRLpFCSG6Q039oKHs97todIR7J9odefBVF9ThdiGJgUuV8HWjFukJxoCokH6EzmPvlG5tH5CS33BS8nFuTfAhEcY2eX8Ki067lslEbqn1HkdTGpJhca4GBxMRDZGHO7Vk32c6QzJogatx6w1BEJ6Vc0Ouq9IxZEd1GXRUV2T/tdITUI39yxnIKOHznYrXzNYOhdTppa4NSHgErYtJRpsOH2uxAL/7WwxYx1Z9P7UeF+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCaNz2OB4eemonVJ6txrT5EVsvo/ufQ4CZeYTczufds=;
 b=BlkAQtFRrS3xsUxN0wb5YoE/yhoN0U4aXCSTrvzGjzVHvYpazfvo4L6U8NWjWSjXp4O+jsZZTiIx0OSQgo3yerj6tR65TUGQSIC3VarTSVtCis2qn8LP9IO3jPjnPtakdFlp34I/NY3FADejndL9w8tmYQX+iIlMlILtZ3339+M=
Received: from BN6PR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:405:4c::28) by BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:44:17 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::35) by BN6PR1201CA0018.outlook.office365.com
 (2603:10b6:405:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:16 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:14 -0600
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
Subject: [PATCH v8 17/40] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Fri, 10 Dec 2021 09:43:09 -0600
Message-ID: <20211210154332.11526-18-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbe724f7-c2aa-4585-6c03-08d9bbf3ec81
X-MS-TrafficTypeDiagnostic: BYAPR12MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3560037F7D568C743482E863E5719@BYAPR12MB3560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ke5EpTn9DPVhpz4VBUV5seMGCGwvTHDxr7ghEdSIK7qJ/W+VzP6khyAt3UObwa9Yx+NdocljHz774+8sZtNx8C5hiKEJo1X3A1FTJn5PCD1PQUnxPDzhFy4njYPuikDfffjzNHOFv/dFHck1Q8ljYS2xOrfPsMYLcTBmKOjlJBEznWUks2PHAJw8vm/U8UFCrGpJTtvKtDaaPbttBmPzju91QIg9244E+k8Hu5bm77l9EOBviwt095ulzVHnemZFCun7xHJQXn2WzXHQhK0bQY0+wQg14ecnplezryCpbrEZqgjfMySeVhGIh0TC/FDcQAm1tliQwH/QyO12wPjnO5DLaHYx3EfVNxSGK2SaQjTlhEtC3OdBd6B/3cT4d1rIXqgPGzUwRix/t0/DYt8q7Ca3tLdGejyZ/UrH65FDwpQjGCS2+daYh/vZsWIIta+Q1ipRfSGftC5XZCJVi0D3j9b/merSLzr0F+PWAccjg04WSIFnFXPCf4xGxhHUvWIkKgz1w2gBxTDslXCk8JoGvy+FFIJ4nMCLGIWZ2SvoFBh418Np8kzJg4uqSx3PlYu046EG5ctyuBxhY0JyDsa7i6Y2ddwVyuZAPCaAk24ghx1dn2KNAwiiajg+/2UR4W9m5HgZ3BUIa21iDHi5xKlFaQAiYvSnTQrDFW+opQwDzBk4yc/eDa911+ZA8dKeRZsKy6tRhyWnFKeacmNy9Pheno1J9+8xSQ5xBCS/nvuWdAvFPEbRKyD2SFaYMypKWoW1TuZU7Jxf96TNeLVW6KztoGwB2H7b6a10UkWzqzaRDjwsl4yRNoF0Gp96o9B4OTNP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(44832011)(2616005)(36860700001)(356005)(82310400004)(4326008)(26005)(6666004)(508600001)(40460700001)(70206006)(47076005)(426003)(70586007)(8676002)(316002)(83380400001)(7696005)(2906002)(86362001)(186003)(5660300002)(110136005)(81166007)(7406005)(16526019)(1076003)(36756003)(8936002)(54906003)(7416002)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:16.8050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe724f7-c2aa-4585-6c03-08d9bbf3ec81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
different from the save area of a non SEV-ES/SEV-SNP guest.

This is the first step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
save area definition where needed.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 83 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/svm/sev.c     | 24 +++++------
 arch/x86/kvm/svm/svm.h     |  2 +-
 3 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index c3fad5172584..3ce2e575a2de 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -227,6 +227,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -243,8 +244,58 @@ struct vmcb_save_area {
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
+	u8 reserved_3[112];
+	u64 cr4;
+	u64 cr3;
+	u64 cr0;
+	u64 dr7;
+	u64 dr6;
+	u64 rflags;
+	u64 rip;
+	u8 reserved_4[88];
+	u64 rsp;
+	u64 s_cet;
+	u64 ssp;
+	u64 isst_addr;
+	u64 rax;
+	u64 star;
+	u64 lstar;
+	u64 cstar;
+	u64 sfmask;
+	u64 kernel_gs_base;
+	u64 sysenter_cs;
+	u64 sysenter_esp;
+	u64 sysenter_eip;
+	u64 cr2;
+	u8 reserved_5[32];
+	u64 g_pat;
+	u64 dbgctl;
+	u64 br_from;
+	u64 br_to;
+	u64 last_excp_from;
+	u64 last_excp_to;
+	u8 reserved_6[72];
+	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+} __packed;
+
+/* Save area definition for SEV-ES and SEV-SNP guests */
+struct sev_es_save_area {
+	struct vmcb_seg es;
+	struct vmcb_seg cs;
+	struct vmcb_seg ss;
+	struct vmcb_seg ds;
+	struct vmcb_seg fs;
+	struct vmcb_seg gs;
+	struct vmcb_seg gdtr;
+	struct vmcb_seg ldtr;
+	struct vmcb_seg idtr;
+	struct vmcb_seg tr;
+	u8 reserved_1[43];
+	u8 cpl;
+	u8 reserved_2[4];
+	u64 efer;
 	u8 reserved_3[104];
-	u64 xss;		/* Valid for SEV-ES only */
+	u64 xss;
 	u64 cr4;
 	u64 cr3;
 	u64 cr0;
@@ -272,22 +323,14 @@ struct vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-
-	/*
-	 * The following part of the save area is valid only for
-	 * SEV-ES guests when referenced through the GHCB or for
-	 * saving to the host save area.
-	 */
-	u8 reserved_7[72];
-	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
-	u8 reserved_7b[4];
+	u8 reserved_7[80];
 	u32 pkru;
-	u8 reserved_7a[20];
-	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u8 reserved_9[20];
+	u64 reserved_10;	/* rax already available at 0x01f8 */
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
-	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 reserved_11;	/* rsp already available at 0x01d8 */
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
@@ -299,13 +342,13 @@ struct vmcb_save_area {
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u8 reserved_10[16];
+	u8 reserved_12[16];
 	u64 sw_exit_code;
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
 	u64 sev_features;
-	u8 reserved_11[48];
+	u8 reserved_13[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
@@ -314,8 +357,8 @@ struct vmcb_save_area {
 #define GHCB_SHARED_BUF_SIZE	2032
 
 struct ghcb {
-	struct vmcb_save_area save;
-	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+	struct sev_es_save_area save;
+	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
 
 	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
 
@@ -325,13 +368,15 @@ struct ghcb {
 } __packed;
 
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
@@ -401,7 +446,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7656a2c5662a..63334af988af 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -558,12 +558,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
-	struct vmcb_save_area *save = &svm->vmcb->save;
+	struct sev_es_save_area *save = svm->sev_es.vmsa;
 
 	/* Check some debug related fields before encrypting the VMSA */
-	if (svm->vcpu.guest_debug || (save->dr7 & ~DR7_FIXED_1))
+	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
 
+	/*
+	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
+	 * the traditional VMSA that is part of the VMCB. Copy the
+	 * traditional VMSA as it has been built so far (in prep
+	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
+	 */
+	memcpy(save, &svm->vmcb->save, sizeof(svm->vmcb->save));
+
 	/* Sync registgers */
 	save->rax = svm->vcpu.arch.regs[VCPU_REGS_RAX];
 	save->rbx = svm->vcpu.arch.regs[VCPU_REGS_RBX];
@@ -591,14 +599,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	/*
-	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
-	 * the traditional VMSA that is part of the VMCB. Copy the
-	 * traditional VMSA as it has been built so far (in prep
-	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
-	 */
-	memcpy(svm->sev_es.vmsa, save, sizeof(*save));
-
 	return 0;
 }
 
@@ -2904,7 +2904,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
-	struct vmcb_save_area *hostsa;
+	struct sev_es_save_area *hostsa;
 
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
@@ -2914,7 +2914,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	vmsave(__sme_page_pa(sd->save_area));
 
 	/* XCR0 is restored on VMEXIT, save the current host value */
-	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+	hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
 	/* PKRU is restored on VMEXIT, save the current host value */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1c7306c370fa..cecfcdb1a1b3 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -127,7 +127,7 @@ struct svm_nested_state {
 
 struct vcpu_sev_es_state {
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
-- 
2.25.1

