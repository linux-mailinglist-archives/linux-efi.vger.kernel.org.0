Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98223BEF3E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhGGSlZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:25 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:38977
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232152AbhGGSlG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePpb+ZIhEtGtI8N/Zemcfs2SVldFIci3mUNoYeKfRfVFsmZRPSzEUFtzfks5ZDObonacOfk9AZ74tMdOlQBasYz8BVYTy7n0LazG5YWQYV8dsKXIIiDmIDRwZo8M9X5cTYz/H34LrzGbp7p17CDs5vL0hvv+G5dLn8PL4dIUg0jGTZWnfMcied9SnkuDk29sDuKwZBZDjRMGdWd+TbymVeCwlNopL0Vc4vXEUe2tpZiJZcT3F2DF3My/hbOSm1s6+hjW+U0CXv1z9Yr5m1xu5A4jrISRJSyN+5AyFj6DxE5FGy2RNl5Y0Um27AVBf4MBrVugMOL9ngSfNzagW1ygdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXWvmF41owDiMt6To+AsmIAEf1i35/5Hhllt7y5Df9I=;
 b=PXr0OHUz3f1sTvYReBY6zN6tUIDLQIhni73qlQOKrpctr3Gfg188zw/RPtBfXRZnMQlCacBAQja4j4M9J54puGn2ZKcxL8W+xc1je6nXyetmElLRCZNj1mRJ4xw6/vWQPTdDPYIMHBKD4Thz7Pv1ZionjbjacKH0jRJ1oLMQ3Z6gdvxQwEi0+CfX00XDcFICjNVUq52oB/a9U4ndPdLBisWSbBSevolbUvZDGq99i8mAsvl9XEItYEIjz9cgWQaR5/CUol5M2OwxaDGdSFrgMfy0/sltGlXynr1GJkZDSYbOK/NIQL2MG24zlXqNrFpW5MqyhXF4AiF32KGW1pdUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXWvmF41owDiMt6To+AsmIAEf1i35/5Hhllt7y5Df9I=;
 b=LjMzqX99omKL/VjiapJLTX0wq0moyRRqWqEtzMek3ZPbcL2je3os/r5fcltmaENLChXDxcK3OMaJbxn3C9pBJcQvsY7vVAwhqJnUFeLyUGDGASqSmcOHFRfxRQoxRpFcb0sYIOTy9X/krcouVlBfsh45UUpsCZuivebjh3iPivE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:46 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:46 +0000
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
Subject: [PATCH Part2 RFC v4 20/40] KVM: SVM: Make AVIC backing, VMSA and VMCB memory allocation SNP safe
Date:   Wed,  7 Jul 2021 13:35:56 -0500
Message-Id: <20210707183616.5620-21-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51666fa9-a60d-4849-30cc-08d9417650b1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808395486E9D080DE3375C8E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T30FqQQlFzbXvkBK+4gnKtkTDUN4+Azj91gBxkW69538tNqnfsHKfWVFYteKk4aJ7ZMzK7zY+/IF60vT5e0jGSzb4BK+ZokM4wdR+Zm2XzSoSNtyOjyZyqsENBt+3MEFba3D6XykehWFMc3WR1BsXWFP95p/pA614yGBm+DC68QFy4X9dcRB+rBrvY1K1cOfmFvEKd+TaQc2qTLdC0CruL4wlc+thgO9sK949/gdZ6x+ZAVROjhhC0UAHI8mtTtEH6LZtX7cvmgwGbZLsE45MOFIute3NfgEEC2Zy8I18iLUUD+SyO6HF5Sidr1EdqS93M3yXkoCpuSi0/mVC++MfaW3+MjknY53+Ob0dGSLRKt2coSoviD2mK/6+NXkb19uPWNN3MMBQ0Bct3zQJ9MywCKa2cROF/wmALHSB+aWzE5ogj9s2hhrx5QJHzEuXuBduz7IhXSd/2yQk8iVvUNrUMPozVOmFHG+6NfpDhQB0Q4zYBtXySIEJD0yg/40+0jMbB5udI374dGJyzeBBwVRQPgN/eYYVe0XXolR4RvxPwWIWgZXgLO8d4R8uu72SWNKSkhhOmmpSmZtnfyYEiQw2r6HxLh741gSDJNTz3kBxeGrrzZN6A98ciI4ZBW5rwKgIvH0pEbPcDJ/CW9vu9P1VR/cRU3ApuTpTxwXJE83+NlDGbXj1YMChTmENhVGSGD2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjWK7Gc7Uh/8Wjw/WPI/xSG3oIJsTAVUXHeXjhgtvtP4ZI/JWgQsY0u/S1oS?=
 =?us-ascii?Q?YcniHgaNmGCJ5q39jr77Xw+KKFguMEXcmm6ncqJY6qD3wBR8lOf3vXIGvVfs?=
 =?us-ascii?Q?zpAEtrVyDu30odsXr3eBIWpMwMrKHgwLtVtGTWBphZo1JNQi0duZ4lUuhrjt?=
 =?us-ascii?Q?xs0zVYd1C69bUKBE8hM08AVgVg3SA4Ki+HsQvkG56KVKWxq/g9bDoF/PVdN9?=
 =?us-ascii?Q?X2/a2m3wDm7aUvtQW30FsW70SeumSlKVU+SOfYyrfCMcvE0SkuLa2VjgdZgI?=
 =?us-ascii?Q?1O8TBwxatcWEcOjSXxRHz8h4bTw9autmnGpz/apm1/uF640J5ADUzej1VbxM?=
 =?us-ascii?Q?nn9KRklZNPYuNa/2q1kvokzyo694WaWG2+6t9xkThvbPL42I+Rq4FDQRtNna?=
 =?us-ascii?Q?3VeQIysvERVeZ3zH4P/j9w1zI7Ap3bbyuMPR73pwmogrgzsoCL0aInD+vLCW?=
 =?us-ascii?Q?m0kyB88ek2t0lF9zdvryyx5J+wlBmRQ4cHmUDrgfR2s0vsNuDf4oMHsRlvve?=
 =?us-ascii?Q?Qjvj4PTM9jmxdkE+RiJ8bVBZnYTgD6YrznwBY1ITq9fQRDltt0gJqsCmutiL?=
 =?us-ascii?Q?pg9ReWm9EKwV3hFRNzvDBVl+qvSpNnZquk5CIr69H4FLfo4OSC/vS/eIaXuA?=
 =?us-ascii?Q?tPPTxzaxZI75GtNKEv8jtPttGDLFtc6g5doUY4tdkjNk9ZzTaPUnmJOMCnjt?=
 =?us-ascii?Q?2ELhtU8Azvq7mmx9EtMhXDNsUU1tfjgcignvylV2tEoiD7L/6ytP/vNDv1Ns?=
 =?us-ascii?Q?T2ZZaEWmBcm2Xhz+1ZTtio07p7b+ELaaKfN5QV+rnwkgLPTyHhRd8/IXphbe?=
 =?us-ascii?Q?3u0g3g/itP5GReKcqOEWI/7kjhP37r0RoYY4Uy7oKFmWgJsncxcmwx0rjmoH?=
 =?us-ascii?Q?qhOZBfrnvGG1nswIZzmr4WDdk8LIMaaI3+NCwo76cncFzLHQ12to0zR8ZEP1?=
 =?us-ascii?Q?9p8JVnd3qyW00jtWhoMEzqiqdz2XjpRfeZZzA0El6Y1r/uxfMArY8LhHRi8T?=
 =?us-ascii?Q?F9NZ0eQQZt7DY9BgBm+9Hs0onRmBNfBVDyOXcXab+WWQR4PbntHuakQbRsmY?=
 =?us-ascii?Q?6b54XM30rCBGv0rLPh4X0Z5PrQljsr4gFSO7DET0TrQg+jHM/fdqSSq0AvGL?=
 =?us-ascii?Q?iG1Rk0rm6ZSIWhN1LHV+vG1p340ghuX7ZDqwR8zI9i16ps9pl8E7SYEFB9sA?=
 =?us-ascii?Q?B2Cwt31guNIciMbNf/lft5Pf64juSlQT5P5MecpwlBijo5aYoEY4O+ptP5eq?=
 =?us-ascii?Q?UaOd3MiZzYwK1VS7s+tNuotzWhh0z6vjfzTtQMT7krnVKdadAMtzsWeLMEz/?=
 =?us-ascii?Q?EcvvcZWmtI5whyUJcqB3hkPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51666fa9-a60d-4849-30cc-08d9417650b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:46.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK12bbGH/idR2NNhvFAousdZjWXnqzoYdyqDD4clr+18TRK7BDRQoLBD5BU483jfBaXq3kmUCtslbQQv27L4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When SEV-SNP is globally enabled on a system, the VMRUN instruction
performs additional security checks on AVIC backing, VMSA, and VMCB page.
On a successful VMRUN, these pages are marked "in-use" by the
hardware in the RMP entry, and any attempt to modify the RMP entry for
these pages will result in page-fault (RMP violation check).

While performing the RMP check, hardware will try to create a 2MB TLB
entry for the large page accesses. When it does this, it first reads
the RMP for the base of 2MB region and verifies that all this memory is
safe. If AVIC backing, VMSA, and VMCB memory happen to be the base of
2MB region, then RMP check will fail because of the "in-use" marking for
the base entry of this 2MB region.

e.g.

1. A VMCB was allocated on 2MB-aligned address.
2. The VMRUN instruction marks this RMP entry as "in-use".
3. Another process allocated some other page of memory that happened to be
   within the same 2MB region.
4. That process tried to write its page using physmap.

If the physmap entry in step #4 uses a large (1G/2M) page, then the
hardware will attempt to create a 2M TLB entry. The hardware will find
that the "in-use" bit is set in the RMP entry (because it was a
VMCB page) and will cause an RMP violation check.

See APM2 section 15.36.12 for more information on VMRUN checks when
SEV-SNP is globally active.

A generic allocator can return a page which are 2M aligned and will not
be safe to be used when SEV-SNP is globally enabled. Add a
snp_safe_alloc_page() helper that can be used for allocating the
SNP safe memory. The helper allocated 2 pages and splits them into order-1
allocation. It frees one page and keeps one of the page which is not
2M aligned.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/lapic.c            |  5 ++++-
 arch/x86/kvm/svm/sev.c          | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          | 16 ++++++++++++++--
 arch/x86/kvm/svm/svm.h          |  1 +
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55efbacfc244..188110ab2c02 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1383,6 +1383,7 @@ struct kvm_x86_ops {
 	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
 
 	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
+	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index c0ebef560bd1..d4c77f66d7d5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2441,7 +2441,10 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 
 	vcpu->arch.apic = apic;
 
-	apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (kvm_x86_ops.alloc_apic_backing_page)
+		apic->regs = kvm_x86_ops.alloc_apic_backing_page(vcpu);
+	else
+		apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 	if (!apic->regs) {
 		printk(KERN_ERR "malloc apic regs error for vcpu %x\n",
 		       vcpu->vcpu_id);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b8505710c36b..411ed72f63af 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2692,3 +2692,30 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 		break;
 	}
 }
+
+struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
+{
+	unsigned long pfn;
+	struct page *p;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+
+	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	if (!p)
+		return NULL;
+
+	/* split the page order */
+	split_page(p, 1);
+
+	/* Find a non-2M aligned page */
+	pfn = page_to_pfn(p);
+	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
+		pfn++;
+		__free_page(p);
+	} else {
+		__free_page(pfn_to_page(pfn + 1));
+	}
+
+	return pfn_to_page(pfn);
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2acf187a3100..a7adf6ca1713 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1336,7 +1336,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	svm = to_svm(vcpu);
 
 	err = -ENOMEM;
-	vmcb01_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	vmcb01_page = snp_safe_alloc_page(vcpu);
 	if (!vmcb01_page)
 		goto out;
 
@@ -1345,7 +1345,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 		 * SEV-ES guests require a separate VMSA page used to contain
 		 * the encrypted register state of the guest.
 		 */
-		vmsa_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		vmsa_page = snp_safe_alloc_page(vcpu);
 		if (!vmsa_page)
 			goto error_free_vmcb_page;
 
@@ -4439,6 +4439,16 @@ static int svm_vm_init(struct kvm *kvm)
 	return 0;
 }
 
+static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
+{
+	struct page *page = snp_safe_alloc_page(vcpu);
+
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.hardware_unsetup = svm_hardware_teardown,
 	.hardware_enable = svm_hardware_enable,
@@ -4564,6 +4574,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.complete_emulated_msr = svm_complete_emulated_msr,
 
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
+
+	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 };
 
 static struct kvm_x86_init_ops svm_init_ops __initdata = {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5f874168551b..1175edb02d33 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -554,6 +554,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
+struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
 
 /* vmenter.S */
 
-- 
2.17.1

