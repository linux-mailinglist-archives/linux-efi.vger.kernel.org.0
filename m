Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE63BEF6E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhGGSmq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:42:46 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:37344
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232561AbhGGSlh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byWHx28KF/MwQS2lzhcHcf7wXX1njhOXUq51yO+djqdNOO+l3bHoBSdbzGTnprHmRsMrtyoE73pbNPuNv8YqGiJwTI7x33Joi6D5Ts57R5DsE0dk1yzIuDWCBpYDn/XuPyVH42ufTznx6emsGaSStSDplbmd/CG1KKw4jVwXqheZ2HkMiGLFJ8vHpxkLfYteyfiwpnVeqIx6uESBm7ISeEh5pEctsg959Ilc2FGlxwQVRNZ1JRR24+FgfRD3RbnAXllXbcDab9g0d5d0zAtKwRiZoLNsPpBLCYa+DqBOuikSF8llU8gYTj1wMYQfQJUfU37YTJl2TR/M6+TxIgdcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T/72aP4MqlEHsa4nqhnFTAbPsOy6kaWC23U4dSfW6o=;
 b=Ae94N5Ha0PoL0cl4678CmUdF+Zl/cMI7E5nBDMtv8friHWsWteSr1rcJl6gXciMY1OND0IhFxdN/r/5iM6cAUIZ1jtv0WfulMTXGxmpo2ug0wDWVlAFlWfPoFWNWB5xpZhXqVk5QnAvDElXBdhD2xJGwIQaQxYlV9BtcYnu6VneSedkQH5ELFfJxyC2IpQsw7DBWRzsSDc8rjgVmHuFgI8+JJ7/ujhNMZWxr6QjmR5ZTo4Qdne1p7F70srhKWXmsuE7e/GkqhIdXvX0gmP7GPTc6EsMConOJXl/7uI56xg4huUSsa7HO4VfftvRMI8VGcQOuaLNWRFf5sW+KP9KsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T/72aP4MqlEHsa4nqhnFTAbPsOy6kaWC23U4dSfW6o=;
 b=orZWCpITDUwK/uXl8L5SK9TY8NJ9eSQ/Des9BYPBaHfG7wxf9KPrvq8BwF1cFWlAcTWS2k0/LC5TqiiXV/tIWXZ0AbabVf2WumN/tyXjyYJoSSsT9I/e4XOs7TCzV2YpbTQ0nNTeLfplsTWCDIB3SrC3HTuOlwRrPo78lLgRi1g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:09 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:09 +0000
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
Subject: [PATCH Part2 RFC v4 29/40] KVM: X86: Introduce kvm_mmu_get_tdp_walk() for SEV-SNP use
Date:   Wed,  7 Jul 2021 13:36:05 -0500
Message-Id: <20210707183616.5620-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b954004-e147-483c-3065-08d941765e7e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082CB9447BC5DBCF44F3B3EE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OblGolyj9MYfqvVY2rQ8XyqZsibntK86CPGLz7/16Jb9/QtoJU66c8O78FkDDoLAnKK6k+4U5NoHDBksd4mklVu2LXr4GysKeBSv45Ucb3viDfIiyycibh68HI77es02fZCCBJ14acFj7wDpQ0QYRmIIhmeJ/0x9YVEzfFecsOUdxqYk2+/l0uyhKuog1dr8x3cBgLw6qpYIBpaoEaNSzOJGiOC6O/4CltNTJTsV7lDETBAFXUEOvIXJQcyof7LphhFFqp1BYmaaZz80PS1fTtKjdfigVqdM786JTj5RV2n1kfImRUAg94um0tVALam7awFpAuZYWBw+GMWv8YmmR5ElQUKOgwoYzOaxDG64QdYKSInZ8/k3uUe9mjlVTXzP1j4t6yHjM4tRLQ1BsH5kRPDnIs+SOpsR5UG/EkzSkXh6An4pPb7VVMJ2bhi49y/vfFq+76kmk+G95zO6GWT1BRgjB5jgPH23jXHktIYMFwPwqb5JowsSXu17i19/Gl6V7HXEzYINWB8B6UMNEXGuzdZNxuXYLdmobKg7rlo9vCKE11KV/ozISOK5i4YMAUCEP3qmcxXGwrlF6pSRigqaZNfgT/31v0QoR3/q3ZvTG/dTtqBnQivWM2PNbm7FJAZlyLz4WJE+N54XCtt4Lp7XJGN+NWdPojsnLC/7vVG7SdmXVYW30wsfpepf+R1DJ9Yd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9uXyLaodR4/upCiPlm2v+s3aajiFJDWItVgbLvy3w6ZL6B6Wo1gwX4+M53id?=
 =?us-ascii?Q?6zWCQ2oqyfmB04TcdACC8vKaAGRglgtg+wKWEIv67X42iX0ZIWtGjMWqkePf?=
 =?us-ascii?Q?eHYu0jANvX5XU8T2bF8J5JU5cNjSp+j5iggoVlFsXeip5VEoND8S4WCAxIGa?=
 =?us-ascii?Q?PRmGcboODTZfgin+QkVdzFPXCVnBILThbrxz2uHmPgZyYKKHOX4wZtBI+5Gv?=
 =?us-ascii?Q?LwFFiDr2pBXtAZlTmMooZPDrICAMQ6HIG/zcSaIvxolIAo3xnS/8XjmBy935?=
 =?us-ascii?Q?rhvDE5pIWQhcESEs4hse2yhcp2HTypP8uZFSf3HPJUI/kGnAdQTlEK2BenmU?=
 =?us-ascii?Q?d5tY/lVCC+Xvia5q6jDwXQxtQMdwew909VGCyggDNMzbhuBmbXqCyd34noJh?=
 =?us-ascii?Q?cfjQ94D22cmi/iRMjrEF/7DrTTKeWIjF8GEsHSw/gC3ZbZcEYc13zsY1/6bZ?=
 =?us-ascii?Q?r6VsfXDRJOgo7tLhcJWtPdD40WnUf1eK6CN4rqASVj+aZOv4L9I1CUk+i4EJ?=
 =?us-ascii?Q?BFKq5fGffu7GbGtOKkMGy5LYXosyoDTYc0/ZJY4EzKXTihfhoBi6/GJhlOtY?=
 =?us-ascii?Q?uEKFy7VIM7p9/iH01YZLi/G1urksfXhhp5l5uiNWJUI6xPH459KxhADzivCT?=
 =?us-ascii?Q?2hChsXf3aoHEBaaKqd9+5utzPXktB+F8fiN95XMzPaUbuRIP24IHQrJJ5sWM?=
 =?us-ascii?Q?0DoWD45isocqFW9LH6g1Cjzm+7Ekilzf/FAeHq/anNsCiKw2HIunVm/uA6Bj?=
 =?us-ascii?Q?hhw8awe9JZydyZjhiNWoHRAY1jWT85qgXqZ1HowW9pn5FO7M3FGY+prnYfo/?=
 =?us-ascii?Q?XELDRVrbLDRarplCeGjUtSSnLE48RvXR02Z3Qil4WbA/LRj/D0WOvOCs8MPU?=
 =?us-ascii?Q?GWKk5DZAEpq0i8hGU9WEWYHGPblGfSDtv5w01O6RWDJorhJ5+7mUqa9CChPd?=
 =?us-ascii?Q?M67S9oA0UMmWpzNO1nbYAFLTPNgT/fkS+R0JQps+4bLzwXRFRuaULGrULJg0?=
 =?us-ascii?Q?bAJZhH+5eKBIgLehbHcFSTxMKH6KQ8OKFBc0XbfQkm2N8MGGqPK9I8dgesaT?=
 =?us-ascii?Q?b1mJ5uO/Br7gg08N62XZB1OpSwgeuf4lPCqyY3y2bx/gHvU4fH7jg+NLltS5?=
 =?us-ascii?Q?K9phKYSMZxlR/B8pY+GGKpMVIjXA3I+2tyUNRnzewnzhwiwudm5cqjqAyiyS?=
 =?us-ascii?Q?YUo03NTaYiUOYIp1f8b1gU0I9lDMR1sEHlfC2VL6bXHjqKRKNneIz+6pkjRo?=
 =?us-ascii?Q?3t51lRjb60l3H5M+hInRhf4VCXD4zjC3SUs+/xPz8rFJ8p0ievsV2gwXqwLf?=
 =?us-ascii?Q?SvG//BsIa+7keDPd99ZzWEMw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b954004-e147-483c-3065-08d941765e7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:09.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIuDWTmWb+ZEe2pWKZQQg9rWiCWaSWZc4EX67Ywbo2krQTIwIE0Ok7VrqbK5zdWJrIh4U5R1cZPvuflvHkNFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP VMs may call the page state change VMGEXIT to add the GPA
as private or shared in the RMP table. The page state change VMGEXIT
will contain the RMP page level to be used in the RMP entry. If the
page level between the TDP and RMP does not match then, it will result
in nested-page-fault (RMP violation).

The SEV-SNP VMGEXIT handler will use the kvm_mmu_get_tdp_walk() to get
the current page-level in the TDP for the given GPA and calculate a
workable page level. If a GPA is mapped as a 4K-page in the TDP, but
the guest requested to add the GPA as a 2M in the RMP entry then the
2M request will be broken into 4K-pages to keep the RMP and TDP
page-levels in sync.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/mmu.h     |  1 +
 arch/x86/kvm/mmu/mmu.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 005ce139c97d..147e76ab1536 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -115,6 +115,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		       bool prefault);
 
 int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code, int max_level);
+bool kvm_mmu_get_tdp_walk(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t *pfn, int *level);
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 					u32 err, bool prefault)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index df8923fb664f..4abc0dc49d55 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3862,6 +3862,35 @@ int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code, int m
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_map_tdp_page);
 
+bool kvm_mmu_get_tdp_walk(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t *pfn, int *level)
+{
+	u64 sptes[PT64_ROOT_MAX_LEVEL + 1];
+	int leaf, root;
+
+	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
+		leaf = kvm_tdp_mmu_get_walk(vcpu, gpa, sptes, &root);
+	else
+		leaf = get_walk(vcpu, gpa, sptes, &root);
+
+	if (unlikely(leaf < 0))
+		return false;
+
+	/* Check if the leaf SPTE is present */
+	if (!is_shadow_present_pte(sptes[leaf]))
+		return false;
+
+	*pfn = spte_to_pfn(sptes[leaf]);
+	if (leaf > PG_LEVEL_4K) {
+		u64 page_mask = KVM_PAGES_PER_HPAGE(leaf) - KVM_PAGES_PER_HPAGE(leaf - 1);
+		*pfn |= (gpa_to_gfn(gpa) & page_mask);
+	}
+
+	*level = leaf;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_get_tdp_walk);
+
 static void nonpaging_init_context(struct kvm_vcpu *vcpu,
 				   struct kvm_mmu *context)
 {
-- 
2.17.1

