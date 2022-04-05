Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05114F540C
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377026AbiDFEFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573230AbiDESa2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 14:30:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C756325C2;
        Tue,  5 Apr 2022 11:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4JcdFsEFAUisViN1/OsQ/awlkZ33sxcSmJxfxo73KDG2KHXvKyfQAI6WqBMGGTeYIHbd52kuKauHEeplUMp5kFGU3wVcCvJIVFkE27v77mQB13p6OkGSqqko++v8ogkSrxPErrSijedfAeOOyfFsw+ks3kCWht/G/VGnBWwR8JEnKYKAbXykUXD8wopP4z96It3Xxtn87oPgi8npWzNln/D39pdkbl3+kKRipiRMK6/ZR9U1KvNgrBAJP0mt2tbCJR6t7o+4q4v9IHvaCg/Lsk3dd0hx6tbbU0xE45aQfOUMl4IAotV3Pxy3tMXilkGWyfJjfYtUl1l+a5wzc0YuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVxiQWdA/+y1jdfHCZL9sICHf0Z28UIfsZdRfAZlh9U=;
 b=Va+2Qlbo/IwryPkE2G6snovgm/v/XHeKfiFsy1tnbv8vTzEBrvNDWf8LLbcOdOKoeSt0QY58k9sGAS9FtyO4mO+IErPLFo4gHivT1diQeijPCkej+d9ARt1PklINITUQQLg7ej1uSyLjDFfqg/KzRqslnz30rsvHsDWhdkSc0KwmmTtkQsy8x0N6OOPjZNsRMv3dtE4vplNnziVR2Ja0nkH9tG7Cfj9ARCbpdZAy5C83u7u2UpaZkhVspxcO1MFszni3dtZthmf+EN+KrgMyqJ8N2HBj3G3af8aU6POuAkN6dJ49lhthjqKviQH9pbfAEHw/k0sL4fpEq9R45XDRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVxiQWdA/+y1jdfHCZL9sICHf0Z28UIfsZdRfAZlh9U=;
 b=H6AddttlJcBriGG9IAsbUGSxN/zq9hHzGCdvekkTW2RZxpFugEDvPJiT6CJ4t0e6ebjUNk5ssPuQ2k2yj9nKbFtPllVnw2EEs4Kb+mCOMBcNyn2vCPI0IDlLAnibV+ShKkMq2e1FG4RKuV+kj/0ejmsUaxEqPMvQycoLB2hRcLs=
Received: from BN6PR11CA0072.namprd11.prod.outlook.com (2603:10b6:404:f7::34)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:28:25 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::6a) by BN6PR11CA0072.outlook.office365.com
 (2603:10b6:404:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 18:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 18:28:25 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 13:28:23 -0500
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 2.1/46] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Tue, 5 Apr 2022 13:27:43 -0500
Message-ID: <20220405182743.308853-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-3-brijesh.singh@amd.com>
References: <20220307213356.2797205-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85d25259-9114-429b-81b6-08da173212c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28098EC4C6E525F165388EABE5E49@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66JyBK9iR3ZHHbuIWrXhWT3KitXHv/kzAmrKEjTjph+ZShghBf38aFz5GZiTzbtPTF7JMeYfqwDxygcl0ClE+9p3vxdCbHuaQ04CxCkBcc0l1YLL85WATRk/4wD3apoa6mvnGE8J7MlHwiiIfjAqbchNk6WfVwPO1nx3IUl1EUnnxusVG3fQU4f+bx59qtcg1dxW/8DyeRSR0e9GoVS9c29V/5yYulJLtZinIC1iBZVhPlDY4dzaVZIztfpOWoiqs2lZm3rx7ugQc1crpbKYRutHzvOuSCrGLMbmMmuoyhOZze17hQsQv28/z1sr7fDS/nrhwmdZ9VOI3LFDl4Tb1Y3r/MdTdG8zIM+u61oX+jCR0pC5s11GhIMA/tRBC6YPoEUNYkvFIMfqw3Z2iEqUX9Nr7W+6arlO4PINmWiB0MPIgBk+lfSTy4juMpOGmmitLlRIKdqJ8yAf5Omy5+VbiY8jil9Dtf8dJqk1DsTPAMIIhgXsZ+1KrjM8SPTB4W2UjGdbuv1M+1eKJ6lc0d3btzcnAvMWfqclJYng0h+tiXr/ABxqmX0PAntb02lejgA2iMmkjoH6+3h9fw6Pikjl9R1SkXpOohi6frn0Ib5GllhZicfAjF1ogOnua1okbzKWno5cRiZfv1AWUpPKBXDxX0YtlAxFMvBQWZofAgdKHZnjRURMVEcFcJOBkDr1sZs5WnJCVnOzTF89fE7EE66DUBBFrvm0llr78c5QKT6TrLU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(6666004)(2616005)(40460700003)(83380400001)(2906002)(336012)(426003)(26005)(16526019)(110136005)(54906003)(186003)(86362001)(316002)(1076003)(8676002)(70586007)(36860700001)(70206006)(82310400005)(8936002)(356005)(44832011)(4326008)(7406005)(7416002)(36756003)(5660300002)(47076005)(508600001)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:28:25.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d25259-9114-429b-81b6-08da173212c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---

Hi Paolo,

Now there is a conflict when applying this patch on 5.18-rc1. Please
use the updated patch when merging the first four patches from the
series.

thanks

 arch/x86/include/asm/svm.h | 87 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/svm/sev.c     | 22 +++++-----
 arch/x86/kvm/svm/svm.c     |  4 +-
 arch/x86/kvm/svm/svm.h     |  4 +-
 4 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f2d01f351e95..788a43f99080 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -271,6 +271,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -287,8 +288,58 @@ struct vmcb_save_area {
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
@@ -316,22 +367,14 @@ struct vmcb_save_area {
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
@@ -343,23 +386,25 @@ struct vmcb_save_area {
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
 } __packed;
 
+#define GHCB_SHARED_BUF_SIZE	2032
+
 struct ghcb {
-	struct vmcb_save_area save;
-	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+	struct sev_es_save_area save;
+	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
 
-	u8 shared_buffer[2032];
+	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
 
 	u8 reserved_1[10];
 	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
@@ -367,13 +412,15 @@ struct ghcb {
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
@@ -443,7 +490,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75fa6dd268f0..6e18ec1839f0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -559,12 +559,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
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
@@ -592,14 +600,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
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
 
@@ -2932,7 +2932,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 					    sev_enc_bit));
 }
 
-void sev_es_prepare_switch_to_guest(struct vmcb_save_area *hostsa)
+void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa)
 {
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 81cb518170a8..6ff595f74e3a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1270,8 +1270,8 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 */
 	vmsave(__sme_page_pa(sd->save_area));
 	if (sev_es_guest(vcpu->kvm)) {
-		struct vmcb_save_area *hostsa;
-		hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+		struct sev_es_save_area *hostsa;
+		hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 
 		sev_es_prepare_switch_to_guest(hostsa);
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f77a7d2d39dd..cc857deaee5e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -181,7 +181,7 @@ struct svm_nested_state {
 
 struct vcpu_sev_es_state {
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
@@ -620,7 +620,7 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
 void sev_es_init_vmcb(struct vcpu_svm *svm);
 void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
-void sev_es_prepare_switch_to_guest(struct vmcb_save_area *hostsa);
+void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 
 /* vmenter.S */
-- 
2.25.1

