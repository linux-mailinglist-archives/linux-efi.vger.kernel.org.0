Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9638A3BEF6C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhGGSmd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:42:33 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:27105
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232785AbhGGSla (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crfrcjP0H2V3FOXRs/4AINL6i6x/uJ60HJ+1+kWFHhD5Z1t3XzVavwcK8RY5OK8b6NivLt83pShURGoA+HvxzkfLFhHSNCBoPi4BErhcmncPY0MYIrB7V75x8JJSMM6UoPXvq5J/5H8+P2Vx85mhjh+W3YLKWxF/nleHfMgAJYvbp8qHqslVvkDu3nyXD41HdL2okqEOBoiYhmku84DJy7ESCjUJrHTWqkDQBpPQP0knR4byHLGn48VtiCxDUrfkd+2a+MmQ70hk6FsbeD42hw4Z3yVivUz9F9/LgUUpXhjZbHdfAO6hx5+G2lWLfzMlb29HlNUn463EA0OzZNC7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvpP4vcirFtMs9ICGVRbYBHwDS3HlfuiklBI1T5rs6I=;
 b=fifQuJhjUCO1GnYafySkV8Q/G2/tE+r8ve3GHvNst/ny9TADPTilhMNYXV1WYsklIN0ZHijdZeMA4ohdEQUwef4a1wwW5vqlY6buW+lkZrHFsGTo7RA0ATyY4gpt348lyGopcgUDhWXiJ53BXLJff30+E7FqchTPD67MLlPj+6CIYkWT+eTRH2VMYhM7NQ+9VJr+0GfzaBP28/dvq2Uj4iXhH5tPzvO9a/0fYmutEHi3BVoXPKDIntFzKJrjB9Sage+ovQTT2H+vwkqM/gwbOr1ZOUR6N0TBZNdroX5z41yBgShVkSuceXb2ljMU1OLr9Tk7eFOvdanLwqLLVMe+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvpP4vcirFtMs9ICGVRbYBHwDS3HlfuiklBI1T5rs6I=;
 b=ewBdY0dY90lRxBYtMeqz+8BAkCcnUwG/idiLlLhLJyXs8cCgEqn6SzO2Gy7wWHuMz5/ikY1xUX21qTIGPnCE8mbbgvK2sRpJdURrlgHbiuIYJm40aMq7QnwORu+P0Jdc7q1H4WEmq+j/kKrKvTDdDmqi0k9ojnWCt+hHTV9CxQI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2630.namprd12.prod.outlook.com (2603:10b6:a03:67::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 18:38:39 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:39 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part2 RFC v4 40/40] KVM: SVM: Support SEV-SNP AP Creation NAE event
Date:   Wed,  7 Jul 2021 13:36:16 -0500
Message-Id: <20210707183616.5620-41-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14625f28-3a81-4518-aa8b-08d941766fc2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB263064CEB8C54A7CEEA8C41BE51A9@BYAPR12MB2630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4IcTrbCux5fcfNeEmGe4Cx0AMqcuYfurJdsjWTwqn3vbd/qt1Gbvn/bcgDNNFKCjxzmqjM5xP8CvQtIIXS6UyE11pP9jG4bhkK9MNMeBfoAS0phbPxgqDhGbSUs82x9vp2nXGyHcQhdwrM8Snw4sK5G1j4ryJH05w+I3GZ/yWCmw81w+n9Iz5J/l1sgt7Yj4XF8YePFufgZR+tn29x2Dxec/pKdh/DpAq2g6SPB1k5hMXcv85Ko6IiH32BHPbPE1wxcZd07QyVKmJutBUy+k4UNhB2fRVV3Q6ZZ4U/W4aMYKJBkvYIryYsdKmizxlLQ0pxUgE0cVAf9izjUvFfbrazVtraH+qBZFVvG881DZRLxHyWbmRrfdSYjblrrddg3pPJAhpVZbqhcg9belRBii5NSDg/aflQkmEd71/TJfpRyJ9ze1SJXGvzouRHHee9Y9yovRIbqn/3PYqzdOZltA4qZCBbAIbO6ZBMAFp14Sh7W4h4FxeXzrR40U0oPN2TD6Ahb/WeiB7Lj5gYAwL5pJb4F7/D+y1WzUya5EPToAruM9/0bAzVQ/dy9ljFtWPwDKLFU7B5etlxlJ2H6+8Vu0ZD2Q7qtm/Cm/YpTULd0BYYxIQ3uZqNiEGepuiL//OqEtaYldaAcIj0eCal0eadkY2g76UAOm2Uw8+rYoW7tAxB7fbcFMd0jnRhPGKxm6mzcUB25uaoxhMu3WpwGZvRnuKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(8676002)(4326008)(86362001)(2906002)(5660300002)(7696005)(956004)(316002)(66946007)(52116002)(1076003)(66556008)(6666004)(26005)(66476007)(2616005)(44832011)(186003)(83380400001)(478600001)(54906003)(8936002)(7416002)(6486002)(7406005)(36756003)(38100700002)(38350700002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGLLXU+yOnOXpPLsfvABqzqJHyLMKLr7L11XGrHWkL5PP2byTscsJo/8QBRR?=
 =?us-ascii?Q?RcADwGe8sfqmTDwME3Pb8T/ToQlF7waWwNbCEqHHQr3yf/NByt/411kYMs2y?=
 =?us-ascii?Q?dw9yMfryy71hiIFsMr1Fs9hv5ltswsG00xueBGOAUopNGDegUHtNd+N2YbW5?=
 =?us-ascii?Q?dX5v6KyJYU4Aku5+vuIKiCqmPZtIHVnLJ2/tc+maDs0n1O2uBZgmWfti1onu?=
 =?us-ascii?Q?gYF0fzNpoW+ujuyO9E1mQ5EBbgRaCKLsMFUEMnefjsV6udPXjqmxS7KuZ8Wo?=
 =?us-ascii?Q?fyfo0qu3BtJiZgHVpjn4JFmqqUBbuqK+fEEh7MQE3lixmzBLr4P4v0piVtT0?=
 =?us-ascii?Q?lL2JlCz7cnG11AiFMtz9cRj+odcNDMjCte29xSAipIGybbjATXVXmUxKLHol?=
 =?us-ascii?Q?H+5AdPd7Sp/4LS8Jyc8zm4zqlf2XCiz4RJ2iqHsqR96RGPSRiwzdTVte8lyj?=
 =?us-ascii?Q?YVsIci3AiMhqGJ61ibgfPIyxNS22+9LzlKwOBeiMrq9mFKt2cLIln2/aQIeB?=
 =?us-ascii?Q?ixaHYszsJHq//OjxMYMVzesU7eGbH2e6P7D+B388TzhP+Wg6DuifW0nLFEs4?=
 =?us-ascii?Q?wGfOKRo8GK8ltsg2nEzyilcxg+dna84QdpcDKOjgxeoe8UuNa3TbSbs/nN/C?=
 =?us-ascii?Q?NksPug/0X+zf+ULAKC6G3+5+fLXxCFumU5FK+D6QYNujFGMe0m2a3/WKz4eQ?=
 =?us-ascii?Q?F0gndl4srJ1cojZl7BIdzHrtslSAi6Vvn0VbzImPWrnI/MaszWw3/JIsN5LC?=
 =?us-ascii?Q?/moke79zHNzvdriWLDXRyAOzyYLde7OpnO5pMMWXXsX65aWtL+Ne2YGTBs6D?=
 =?us-ascii?Q?riGqc+z5uu41GfX9g/UV+3CxKRjAxBCBmedaxaSD0PExpcBh+Bq+NsnFxcrU?=
 =?us-ascii?Q?y+W9mLCUzeBrn5XFf4WSkUjEC6A4ACrs351PegCaRWW/XputXApfyaCtVaWv?=
 =?us-ascii?Q?cmd/g4t5ocJAYUqdU7/bcQKeBA77kfq/Z+xWiGm7LdruBaLZNHBHRXplo49O?=
 =?us-ascii?Q?ZcQUKigHEekx1czHb2/nVARFNzm+C7P4b1pOEJHzUIHRNasnAayE2dPx2kw3?=
 =?us-ascii?Q?sX+funsyKK31Ur4ho/TjFGeyf10/baet8uRoDqNEdeMHUQLZRHdzCph4HDvm?=
 =?us-ascii?Q?rD5lvQ2C2yyjNVbM/mX3j4s8Q6kdum/Vj/S3EYDKl9q89EBONv4bbNaeSnIp?=
 =?us-ascii?Q?tiIaImnpy4uPti3xMePAAPymZRQ2oRbLgPiKrP/jHf1YW3avTJhycIKTgwLe?=
 =?us-ascii?Q?FuFRGGbokn3aA0+Wr7u0vLmtfRyPjQHYRxV4/NZGyPI2ZijishwPT/cEy6Lt?=
 =?us-ascii?Q?DS/TpPrcjs/CbgJQQG4ya6OH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14625f28-3a81-4518-aa8b-08d941766fc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:38.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0ZsoLS0KnUi34U7PftgbaHgcfOrGb97QSPAtEI2KKJpCEh142CG4+qqAhWqIPyPayuny2IHyL787cFBgXBodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2630
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Add support for the SEV-SNP AP Creation NAE event. This allows SEV-SNP
guests to create and start APs on their own.

A new event, KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, is created and used
so as to avoid updating the VMSA pointer while the vCPU is running.

For CREATE
  The guest supplies the GPA of the VMSA to be used for the vCPU with the
  specified APIC ID. The GPA is saved in the svm struct of the target
  vCPU, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added to the
  vCPU and then the vCPU is kicked.

For CREATE_ON_INIT:
  The guest supplies the GPA of the VMSA to be used for the vCPU with the
  specified APIC ID the next time an INIT is performed. The GPA is saved
  in the svm struct of the target vCPU.

For DESTROY:
  The guest indicates it wishes to stop the vCPU. The GPA is cleared from
  the svm struct, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added
  to vCPU and then the vCPU is kicked.


The KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event handler will be invoked as
a result of the event or as a result of an INIT. The handler sets the vCPU
to the KVM_MP_STATE_UNINITIALIZED state, so that any errors will leave the
vCPU as not runnable. Any previous VMSA pages that were installed as
part of an SEV-SNP AP Creation NAE event are un-pinned. If a new VMSA is
to be installed, the VMSA guest page is pinned and set as the VMSA in the
vCPU VMCB and the vCPU state is set to KVM_MP_STATE_RUNNABLE. If a new
VMSA is not to be installed, the VMSA is cleared in the vCPU VMCB and the
vCPU state is left as KVM_MP_STATE_UNINITIALIZED to prevent it from being
run.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/include/asm/svm.h      |   3 +
 arch/x86/kvm/svm/sev.c          | 133 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |   7 +-
 arch/x86/kvm/svm/svm.h          |  16 +++-
 arch/x86/kvm/x86.c              |  11 ++-
 6 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 117e2e08d7ed..881e05b3f74e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -91,6 +91,7 @@
 #define KVM_REQ_MSR_FILTER_CHANGED	KVM_ARCH_REQ(29)
 #define KVM_REQ_UPDATE_CPU_DIRTY_LOGGING \
 	KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE	KVM_ARCH_REQ(31)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1402,6 +1403,8 @@ struct kvm_x86_ops {
 
 	int (*handle_rmp_page_fault)(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
 			int level, u64 error_code);
+
+	void (*update_protected_guest_state)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 5e72faa00cf2..6634a952563e 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -220,6 +220,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
 #define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
 #define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)
+#define SVM_SEV_FEATURES_INT_INJ_MODES			\
+	(SVM_SEV_FEATURES_RESTRICTED_INJECTION |	\
+	 SVM_SEV_FEATURES_ALTERNATE_INJECTION)
 
 struct vmcb_seg {
 	u16 selector;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d8ad6dd58c87..95f5d25b4f08 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -582,6 +582,7 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
+	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
 	struct sev_es_save_area *save = svm->vmsa;
 
 	/* Check some debug related fields before encrypting the VMSA */
@@ -625,6 +626,12 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	if (sev_snp_guest(svm->vcpu.kvm))
 		save->sev_features |= SVM_SEV_FEATURES_SNP_ACTIVE;
 
+	/*
+	 * Save the VMSA synced SEV features. For now, they are the same for
+	 * all vCPUs, so just save each time.
+	 */
+	sev->sev_features = save->sev_features;
+
 	return 0;
 }
 
@@ -2682,6 +2689,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		if (!ghcb_sw_scratch_is_valid(ghcb))
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_AP_CREATION:
+		if (!ghcb_rax_is_valid(ghcb))
+			goto vmgexit_err;
+		break;
 	case SVM_VMGEXIT_NMI_COMPLETE:
 	case SVM_VMGEXIT_AP_HLT_LOOP:
 	case SVM_VMGEXIT_AP_JUMP_TABLE:
@@ -3395,6 +3406,121 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 	return ret;
 }
 
+void sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	kvm_pfn_t pfn;
+
+	mutex_lock(&svm->snp_vmsa_mutex);
+
+	vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
+
+	/* Clear use of the VMSA in the sev_es_init_vmcb() path */
+	svm->vmsa_pa = 0;
+
+	/* Clear use of the VMSA from the VMCB */
+	svm->vmcb->control.vmsa_pa = 0;
+
+	/* Un-pin previous VMSA */
+	if (svm->snp_vmsa_pfn) {
+		kvm_release_pfn_dirty(svm->snp_vmsa_pfn);
+		svm->snp_vmsa_pfn = 0;
+	}
+
+	if (svm->snp_vmsa_gpa) {
+		/* Validate that the GPA is page aligned */
+		if (!PAGE_ALIGNED(svm->snp_vmsa_gpa))
+			goto e_unlock;
+
+		/*
+		 * The VMSA is referenced by thy hypervisor physical address,
+		 * so retrieve the PFN and pin it.
+		 */
+		pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(svm->snp_vmsa_gpa));
+		if (is_error_pfn(pfn))
+			goto e_unlock;
+
+		svm->snp_vmsa_pfn = pfn;
+
+		/* Use the new VMSA in the sev_es_init_vmcb() path */
+		svm->vmsa_pa = pfn_to_hpa(pfn);
+		svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
+
+		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	} else {
+		vcpu->arch.pv.pv_unhalted = false;
+		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
+	}
+
+e_unlock:
+	mutex_unlock(&svm->snp_vmsa_mutex);
+}
+
+static void sev_snp_ap_creation(struct vcpu_svm *svm)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm_vcpu *target_vcpu;
+	struct vcpu_svm *target_svm;
+	unsigned int request;
+	unsigned int apic_id;
+	bool kick;
+
+	request = lower_32_bits(svm->vmcb->control.exit_info_1);
+	apic_id = upper_32_bits(svm->vmcb->control.exit_info_1);
+
+	/* Validate the APIC ID */
+	target_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, apic_id);
+	if (!target_vcpu)
+		return;
+
+	target_svm = to_svm(target_vcpu);
+
+	kick = true;
+
+	mutex_lock(&target_svm->snp_vmsa_mutex);
+
+	target_svm->snp_vmsa_gpa = 0;
+	target_svm->snp_vmsa_update_on_init = false;
+
+	/* Interrupt injection mode shouldn't change for AP creation */
+	if (request < SVM_VMGEXIT_AP_DESTROY) {
+		u64 sev_features;
+
+		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
+		sev_features ^= sev->sev_features;
+		if (sev_features & SVM_SEV_FEATURES_INT_INJ_MODES) {
+			vcpu_unimpl(vcpu, "vmgexit: invalid AP injection mode [%#lx] from guest\n",
+				    vcpu->arch.regs[VCPU_REGS_RAX]);
+			goto out;
+		}
+	}
+
+	switch (request) {
+	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
+		kick = false;
+		target_svm->snp_vmsa_update_on_init = true;
+		fallthrough;
+	case SVM_VMGEXIT_AP_CREATE:
+		target_svm->snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		break;
+	case SVM_VMGEXIT_AP_DESTROY:
+		break;
+	default:
+		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
+			    request);
+		break;
+	}
+
+out:
+	mutex_unlock(&target_svm->snp_vmsa_mutex);
+
+	if (kick) {
+		kvm_make_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, target_vcpu);
+		kvm_vcpu_kick(target_vcpu);
+	}
+}
+
 int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3523,6 +3649,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ret = 1;
 		break;
 	}
+	case SVM_VMGEXIT_AP_CREATION:
+		sev_snp_ap_creation(svm);
+
+		ret = 1;
+		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
@@ -3597,6 +3728,8 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
 	set_ghcb_msr(svm, GHCB_MSR_SEV_INFO(GHCB_VERSION_MAX,
 					    GHCB_VERSION_MIN,
 					    sev_enc_bit));
+
+	mutex_init(&svm->snp_vmsa_mutex);
 }
 
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 74bc635c9608..078a569c85a8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1304,7 +1304,10 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	svm->spec_ctrl = 0;
 	svm->virt_spec_ctrl = 0;
 
-	if (!init_event) {
+	if (init_event && svm->snp_vmsa_update_on_init) {
+		svm->snp_vmsa_update_on_init = false;
+		sev_snp_update_protected_guest_state(vcpu);
+	} else {
 		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 				       MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
@@ -4588,6 +4591,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.write_page_begin = sev_snp_write_page_begin,
 
 	.handle_rmp_page_fault = snp_handle_rmp_page_fault,
+
+	.update_protected_guest_state = sev_snp_update_protected_guest_state,
 };
 
 static struct kvm_x86_init_ops svm_init_ops __initdata = {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 285d9b97b4d2..f9d25d944f26 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -60,18 +60,26 @@ struct kvm_sev_info {
 	bool active;		/* SEV enabled guest */
 	bool es_active;		/* SEV-ES enabled guest */
 	bool snp_active;	/* SEV-SNP enabled guest */
+
 	unsigned int asid;	/* ASID used for this guest */
 	unsigned int handle;	/* SEV firmware handle */
 	int fd;			/* SEV device fd */
+
 	unsigned long pages_locked; /* Number of pages locked */
 	struct list_head regions_list;  /* List of registered regions */
+
 	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
+
 	struct kvm *enc_context_owner; /* Owner of copied encryption context */
+
 	struct misc_cg *misc_cg; /* For misc cgroup accounting */
+
 	void *snp_context;      /* SNP guest context page */
 	void *snp_resp_page;	/* SNP guest response page */
 	struct ratelimit_state snp_guest_msg_rs; /* Rate limit the SNP guest message */
 	void *snp_certs_data;
+
+	u64 sev_features;	/* Features set at VMSA creation */
 };
 
 struct kvm_svm {
@@ -192,6 +200,11 @@ struct vcpu_svm {
 	bool guest_state_loaded;
 
 	u64 ghcb_registered_gpa;
+
+	struct mutex snp_vmsa_mutex;
+	gpa_t snp_vmsa_gpa;
+	kvm_pfn_t snp_vmsa_pfn;
+	bool snp_vmsa_update_on_init;	/* SEV-SNP AP Creation on INIT-SIPI */
 };
 
 struct svm_cpu_data {
@@ -555,7 +568,7 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
-#define GHCB_HV_FT_SUPPORTED	GHCB_HV_FT_SNP
+#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
 
 extern unsigned int max_sev_asid;
 
@@ -584,6 +597,7 @@ int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
 void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
 int snp_handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
 			      int level, u64 error_code);
+void sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu);
 
 /* vmenter.S */
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1398b8021982..e9fd59913bc2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9279,6 +9279,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
 			static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
+
+		if (kvm_check_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu)) {
+			kvm_x86_ops.update_protected_guest_state(vcpu);
+			if (vcpu->arch.mp_state != KVM_MP_STATE_RUNNABLE) {
+				r = 1;
+				goto out;
+			}
+		}
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -11236,7 +11244,8 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (!list_empty_careful(&vcpu->async_pf.done))
 		return true;
 
-	if (kvm_apic_has_events(vcpu))
+	if (kvm_apic_has_events(vcpu) ||
+	    kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
 	if (vcpu->arch.pv.pv_unhalted)
-- 
2.17.1

