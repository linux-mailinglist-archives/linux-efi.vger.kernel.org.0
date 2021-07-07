Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33383BEF7E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhGGSnI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:08 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:56449
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232340AbhGGSlx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFumP1RjUnhfX5Y1WfckdzGrd0NbWkFIw3VHa1Ztre5Ryz6oE2mEUY3ZRWOsBtSHJcWNrXsoSr0xwYYFhHDKzxgJqBqU/c3E8Ew8dm9D5ClZKLI9MFZTQpQ1/Os2522Jxq1nSHhsNtoJcc+s/Z4fpJMj3v2ITOgotafEdS8pfWi3wngZRH1/WY0CzMzlGr4tzPiy2H2fyKdqVoebf4TmgoYWbfYrWiW+2oWf6Jj/++U3n2ya960717Dz6DvmnwyxErklYbjhkpnwEAZfzC0ee1TZmTL+xfrkrWp+ICR7mIW9Y1RlwelTgtcLuaM22iG22qGoJgCYhPtgZ9fKyp7deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rLLGjT9B5NJsMhmPvDEbyl8wrGLVL2iEsxuwHt15ns=;
 b=MitkA16CAsHnJzKpcpTTDDOJHmLKOmlQC9Wr/lnWhZ2EgUSTiiQMKdt4PEF6j/kRmRgleJu82f4XGXH4d30KRHYd225bYROQ/7ZzctPljbnjsknYl+VPj6T0BWnRCkEXlo6W4VU8hzSxOt9rfE+7nOkC4HTbrlbtM7LDQ+B3+KounAzCXvGguu/nvVn7+s3jhoNt1LEwvHbZN+gGwKN3bg0+IviFQn+dR+yVH+HToWeCvbGgHg4TieXbf0VTVrffbu8gR2Vl3AcJ1TRQkQEi4sZ8M6KYZ34Qm3zUY7p1Jju6qsNumb7vNgT/vWDywHWQv0t7KX7cy4s1DS9T/3RdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rLLGjT9B5NJsMhmPvDEbyl8wrGLVL2iEsxuwHt15ns=;
 b=MYK2g2Bm3NJVnXeIwhHPUsUBMkmF/KI6C1L3+YYReppctUArS4ypyWJwxACw7IOezfepGTGpEECUdg9LUFdE15XBpqB3E3FfApwux6qRnngu9HWlqC2uMd56hxwSjlF583xXkO4d1gypxZp++pQB4t0+skddGCW7bcNJr5d6kVY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:31 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:31 +0000
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
Subject: [PATCH Part2 RFC v4 37/40] KVM: SVM: Add support to handle the RMP nested page fault
Date:   Wed,  7 Jul 2021 13:36:13 -0500
Message-Id: <20210707183616.5620-38-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6d771e-20ab-4777-c57e-08d941766b20
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40999053583EAA2124A3BE7CE51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaQZjpznnY5WjWu5rkb6+FuVp+fk/H3Aer694jvasd+4RephKfq0ZD7/jfTTPX3K/PQfQPdjSOQwXNRxjZx/5/av8QfCLpip/qdvdf7Bt2M4VMrUE30PzY2BxmTw/dRE9VpkClgfnxmF19O64af0Liil5z6aEZ3fBZs/sQY1SqOuwVGYX2IFb+MwC0erd9Daha3qCioFNA3FVo6bhX1ICLC1MR3ePOZWMII+gG1h2CbQ6ccSYN/8rqgb6wug992xXR7qz7LxEorR4gUNkUo9SioLeF3cNa8kn6Doc7w3NSAwKCW3OMonyuH7hkMF7CydT3xCE/fjQSsrT4uigXrSpOYDupJDXvO0P3lvenf95NyAGWwIuYpbI3PcGpsmEQ+LJa2q5rnuVSzyHbDNWgXRloBwo8xE9eUttl/g9M4qahAPt9rSzImW1UAm+L1OIl9Vjwy6aFpYiWhu8DOvPrS/u7QOwa61ljj6+bB8D8UbI+D0wu/zF/qumkAzG8vn2mGgBBwNgD22yFqKMP/CEp4n+718OySnAKYVEvorX6YD5DRsN0zMSpDJDsTM+tJcRCE9nwPfYcnxPyuA1c3m5MrLGWIP30MKTco+obr0nk0asWETPh+EE2LXu2s+EWIFVTf0WLDIKCt0TNPdEQ8sYd/BYk+Oq4HQhRVIKcLLLsjzsHXrM6DwVZwAImtJoyUyntZrOlpnq/GWU33EdsKu59DGhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNNEFHQwNGbopXXnLxK3mLA2oqKDhGUo19dskVgGuhg8aMpS6oBAUkf74GFe?=
 =?us-ascii?Q?MW8b5/M6vlGQbQyJ2AP8Re494HeZVU3ZcJbXi871BjHPRu7amlJQ96GN4unM?=
 =?us-ascii?Q?jdU1G70ZV4GtUFA3b9x+8if3lSr1bwe3+U0RcsZQr5xgAi0nd15qs5HJRw7X?=
 =?us-ascii?Q?LR9HkNiQRdG1LUc9m9ZbCZkWQ2XhSLta/bIWlCWhUsYkG4w6hUITaYYPnzBe?=
 =?us-ascii?Q?st+kHm1TVJFNVLLPLqvYl4t/RkddpePtPkr+jy+tlNzWZB8PgYuEBEq0uU8L?=
 =?us-ascii?Q?Z8emCnxMaEXrFtC4YMZfkqjGTa+pQCdqvKQ47vYBpM5/UL2nN/1NeR1UY1eu?=
 =?us-ascii?Q?fLwsLz6DfHsA4Gcwn/H8eAnqBOnYd9VTL0Ne2UKasPLjJPcibogSmemuB9++?=
 =?us-ascii?Q?RaM0JsI87T2W/4dUyZPrwXc4CtC8IJ7FvK+BpD0Jgm/tEJGkvk00f8ijeOZV?=
 =?us-ascii?Q?SO3JJ+Jt2IEGrNFWYlM3sKkOf92UZIdjR3+6VDxtcKbf8NCQ3TWnpC7z8dYz?=
 =?us-ascii?Q?n1MTG8v1QGyZOJGfDZM3FvVrqzpn1dHUmD2KiXAZQSTuLVuuOAELcPb2Q/r0?=
 =?us-ascii?Q?M+NCPtiEWGHgm5nykpDe16TICnfNTnNzoG9mMXZtDmla2h8r+NHkgPA+40RG?=
 =?us-ascii?Q?mzmyeIklyIQiHmGFrcegF2wg805e8d2J7YyR1elynPfol5WSgt+IL9D6T/Kn?=
 =?us-ascii?Q?6ie1/11eUHhL/0aEKgwtkCnfp0/Sw/dkJeRuOKXERGV7avsVzeDaSWLXTjsn?=
 =?us-ascii?Q?Y4XGAzlg2uQQu14XENv6txNXs9uj9b9njNBZKsQkN2LKveu2jt6F2G8iLnRG?=
 =?us-ascii?Q?2qYardrnR24ELN1hJDt4okot1QMjJ1Cb5N62bdyAH7S+fOBIDs6KwfoOFP1Y?=
 =?us-ascii?Q?T4maZiatIDjSK0C+2OrkPegn9QZiddpI3Znhamm7vRFsQo9z4tFKwZRKkvvb?=
 =?us-ascii?Q?AwSjz6uviLtl8VCdgNTa+RLhmnQuGyci+kRRWAoSzDz9EJTthQ6X21HU698U?=
 =?us-ascii?Q?SLWQVWWXuQoXqG84nJuXf5gbcO12I4SDzzjQ2yd7nYALckTXFChOhBg36cOE?=
 =?us-ascii?Q?Bbfxy60CcwwBRwn7muBVi0fW6ghjHS2GhfKDocaFav9luyV4ssL5qO8R6iX5?=
 =?us-ascii?Q?KnVbYatgclLliQd/B6Bd0zOIeFmrpHvS0ad9UsF11D8Vyv8LVOjnM49YsKWC?=
 =?us-ascii?Q?ie9YbjAcahiLaOkJOdnG3XIlnUg8baKMxPha2Um5v8cWnxqjyMq4XaExTOSd?=
 =?us-ascii?Q?+lo3IrQcaUR5JdLQ7uUOEryrAfwvB1UKu6Y6UabVD7ugc2s4KPSngBITkGMK?=
 =?us-ascii?Q?Ve9Rc6hlaMqvb/csdqTkBEby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d771e-20ab-4777-c57e-08d941766b20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:31.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yu/udkMVKRK3rZqBhYcyKwnMzZXDjqiX5UykuYUka9FfZUxxFKRPSnPzCX8x4gRnxGCYIDregesHbpxJNJnnWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Follow the recommendation from APM2 section 15.36.10 and 15.36.11 to
resolve the RMP violation encountered during the NPT table walk.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++
 arch/x86/kvm/mmu/mmu.c          | 20 ++++++++++++
 arch/x86/kvm/svm/sev.c          | 57 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/svm/svm.h          |  2 ++
 5 files changed, 84 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46323af09995..117e2e08d7ed 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1399,6 +1399,9 @@ struct kvm_x86_ops {
 
 	void (*write_page_begin)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
 	void (*write_page_end)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
+
+	int (*handle_rmp_page_fault)(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
+			int level, u64 error_code);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e60f54455cdc..b6a676ba1862 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5096,6 +5096,18 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
+static int handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
+{
+	kvm_pfn_t pfn;
+	int level;
+
+	if (unlikely(!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &level)))
+		return RET_PF_RETRY;
+
+	kvm_x86_ops.handle_rmp_page_fault(vcpu, gpa, pfn, level, error_code);
+	return RET_PF_RETRY;
+}
+
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len)
 {
@@ -5112,6 +5124,14 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 			goto emulate;
 	}
 
+	if (unlikely(error_code & PFERR_GUEST_RMP_MASK)) {
+		r = handle_rmp_page_fault(vcpu, cr2_or_gpa, error_code);
+		if (r == RET_PF_RETRY)
+			return 1;
+		else
+			return r;
+	}
+
 	if (r == RET_PF_INVALID) {
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa,
 					  lower_32_bits(error_code), false);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 839cf321c6dd..53a60edc810e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3519,3 +3519,60 @@ void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn
 		BUG_ON(rc != 0);
 	}
 }
+
+int snp_handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
+			      int level, u64 error_code)
+{
+	struct rmpentry *e;
+	int rlevel, rc = 0;
+	bool private;
+	gfn_t gfn;
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rlevel);
+	if (!e)
+		return 1;
+
+	private = !!(error_code & PFERR_GUEST_ENC_MASK);
+
+	/*
+	 * See APM section 15.36.11 on how to handle the RMP fault for the large pages.
+	 *
+	 *  npt	     rmp    access      action
+	 *  --------------------------------------------------
+	 *  4k       2M     C=1       psmash
+	 *  x        x      C=1       if page is not private then add a new RMP entry
+	 *  x        x      C=0       if page is private then make it shared
+	 *  2M       4k     C=x       zap
+	 */
+	if ((error_code & PFERR_GUEST_SIZEM_MASK) ||
+	    ((level == PG_LEVEL_4K) && (rlevel == PG_LEVEL_2M) && private)) {
+		rc = snp_rmptable_psmash(vcpu, pfn);
+		goto zap_gfn;
+	}
+
+	/*
+	 * If it's a private access, and the page is not assigned in the RMP table, create a
+	 * new private RMP entry.
+	 */
+	if (!rmpentry_assigned(e) && private) {
+		rc = snp_make_page_private(vcpu, gpa, pfn, PG_LEVEL_4K);
+		goto zap_gfn;
+	}
+
+	/*
+	 * If it's a shared access, then make the page shared in the RMP table.
+	 */
+	if (rmpentry_assigned(e) && !private)
+		rc = snp_make_page_shared(vcpu, gpa, pfn, PG_LEVEL_4K);
+
+zap_gfn:
+	/*
+	 * Now that we have updated the RMP pagesize, zap the existing rmaps for
+	 * large entry ranges so that nested page table gets rebuilt with the updated RMP
+	 * pagesize.
+	 */
+	gfn = gpa_to_gfn(gpa) & ~(KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) - 1);
+	kvm_zap_gfn_range(vcpu->kvm, gfn, gfn + 512);
+
+	return 0;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4ff6fc86dd18..32e35d396508 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4579,6 +4579,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.get_tdp_max_page_level = sev_get_tdp_max_page_level,
 
 	.write_page_begin = sev_snp_write_page_begin,
+
+	.handle_rmp_page_fault = snp_handle_rmp_page_fault,
 };
 
 static struct kvm_x86_init_ops svm_init_ops __initdata = {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e0276ad8a1ae..ccdaaa4e1fb1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -577,6 +577,8 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
 int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
 void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
+int snp_handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
+			      int level, u64 error_code);
 
 /* vmenter.S */
 
-- 
2.17.1

