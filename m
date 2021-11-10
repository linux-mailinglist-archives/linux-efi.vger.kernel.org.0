Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C221444CBCA
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhKJWLy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:54 -0500
Received: from mail-mw2nam08on2045.outbound.protection.outlook.com ([40.107.101.45]:1332
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233868AbhKJWLY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMEjJlFMvloyDEA8byiJ/U8QxPaD+iiON2SEVtiL9sKBcQmzRtNjwhpEBCezz0KMf/cLMXAzNPKFIiKuJjIlYLOUoiA0CQJnyT1hCLOp1Rsf547DsRUnZw3Z3DdlAC7qq41L+d/qYD3xlumOitezgJ0jDSubL8EYzGrrJeBNf86OWdWE89P7jStP3WswPpOJczWu4i+5Xlmw6GA6KBIwBo5excW2xH6HbP9k4Z65Lk8/NBMH+R8oA6dG0MfNbNx/W+thhT1adyS30iASoAUwD30zbfY10/UI+BWl94f0aTpaMDl255alEFMjjKXrix0M3JrwgQpHpyQMu7fWGlyn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtMpOkRF676PhFS+bmXxTMuMjNw2BUDOlI1IzQBBnqY=;
 b=NObF1ZZvNOL5ibIAIzClSXnMDdGGV6YQC2IfLrLK0umwKmVNRvld1d0huFSZqDsUtIvpZv2JGY7BY8W84wjVyvpZxU1OjvUvA9u24xlwb/x82d5m3oe71KSvkjcMREPYHoUsl4JuwHpBpkUB4eeFTg95qxz9JOAz4MBdfMjK4SuhuAQTe4l4d+Uq2HtOFGSZxvfbe5C5mY44iikJ0x97LauwrWmnLyoRDaDFOPf6Up0kD7mCJa+RnhjwQbCK5Vs02rnDmGq/qiPqe5BqIxC1p2lO+Ed2jOwBbQz/fmUQISfTlP52lO/mCSCBt3CJ3EpnDUy7HGysc8d1veQCljopyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtMpOkRF676PhFS+bmXxTMuMjNw2BUDOlI1IzQBBnqY=;
 b=orWE2hohgRQuyoQIR3fB9q+aiqRiaLfSWnhP5PcgwCbnPHTa2saRcTc/eFBGoU63zYahhbLpK0jGw9KYnwl5C6Zq1UeOZyvFp6sv2SPLp8kT4HxK0cn2aXFK6Eb5KSmE+uaC+vCrHQeBK2Wy0ip5CevXp/IUn1/doLgsD+zlc3M=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 22:08:30 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::d0) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:29 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:27 -0600
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
Subject: [PATCH v7 22/45] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Wed, 10 Nov 2021 16:07:08 -0600
Message-ID: <20211110220731.2396491-23-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a102326-5b7d-4292-b218-08d9a496a0d6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5251791564B4A15F4400D98DE5939@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RXL5Bri+xEIC4QooqLkHFoeWOvOY8zUExZdQDAe8sY82UF1wpPZnJkz+OXOg4MxcCrsfGz2vvi+tQ9LV+iTWNFw6IsUK3RQOoDKBaBQEmemr3sC0I1y6tGfPzOKxNrjeiABDGLWxnsh02aq5k20rI2ztp+yNK/nthmuDVw2zS5ktdpXCwqMgc3yC7rCZsX2vhvYhItxqNN9VuI8hPZyLMobZp2uCwp/orT5n6tQu8cSx6se6puPuZHncRs7PSRuL4n6CnvPGDWIeLfMFzxhB1OII3bxTgEyCVvXRfHTsbpO3Zo0B/cUFnRJv1v/Bluj/yr092y0xZKwEZCmmVfvdFGQLds4aFP72Jj7/tF2OH3mDkRCrTIPGDCwqJqqa3L546wpMVOMW8eJ9ebta+N0ajAt8u9vvofrFy/lFHOzsBr7J5/sdE3Wl92ZOCNyNvyiiwkNp3slWNotNKBuSV14WAle4LHlDfnpsvIxTwuvyRIrovw8Ha/a2f/mwzw9RqXHu29ec0pj1pA9asBDZvtNCptyT/BSu4ZFu6jJv5KxSf6BSAYG7xuR11eCvEK/EI+uyVy6jQuixLuNFc+gSXs28ncNh1GdUvS9KsyRMyquYFhwzi91f+jibuPjCQlXFGH/qwrBD1HjZX+ki1iVTj+7rXeE7jiIXgAWWYrCsH6JufTn/n2xnMeZ/874hWC0RK0Z+G3tsfrSNjh9GDSzvlzbBbp/t7H7ptqKyk8E++ZGBmSI36clGoKoxol4cXrtADvT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(4326008)(1076003)(6666004)(2616005)(83380400001)(356005)(508600001)(110136005)(36860700001)(316002)(426003)(5660300002)(36756003)(7406005)(54906003)(336012)(7416002)(44832011)(86362001)(70206006)(70586007)(16526019)(2906002)(8936002)(186003)(47076005)(82310400003)(26005)(7696005)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:29.9040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a102326-5b7d-4292-b218-08d9a496a0d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

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
index 5847b05d29da..9896c5835e3e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -551,12 +551,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
-	struct vmcb_save_area *save = &svm->vmcb->save;
+	struct sev_es_save_area *save = svm->vmsa;
 
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
@@ -584,14 +592,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	/*
-	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
-	 * the traditional VMSA that is part of the VMCB. Copy the
-	 * traditional VMSA as it has been built so far (in prep
-	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
-	 */
-	memcpy(svm->vmsa, save, sizeof(*save));
-
 	return 0;
 }
 
@@ -2666,7 +2666,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
-	struct vmcb_save_area *hostsa;
+	struct sev_es_save_area *hostsa;
 
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
@@ -2676,7 +2676,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	vmsave(__sme_page_pa(sd->save_area));
 
 	/* XCR0 is restored on VMEXIT, save the current host value */
-	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+	hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
 	/* PKRU is restored on VMEXIT, save the current host value */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e63ac08115cf..a511f6bd65bd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -184,7 +184,7 @@ struct vcpu_svm {
 	} shadow_msr_intercept;
 
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
-- 
2.25.1

