Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9746E3BEF4A
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhGGSlg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:36 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:61729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232288AbhGGSlL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ0UvpIEgK+KUBzXfFsexh4XJTSnnnMOhin4vqCZAMX2W27h55VhbXGkxpF8OnBvVJBdLuhgzShYha5gJ2M/rvNYS1DvNqlI76A/vKVuNaD4hkxGI0c/tXA8PTzdrply9tMTC4z96KI+V0akjpadoyu1jDtfjouiDnYhm+cSnrqX+YCae9m/nSByHvBwm/SBS6k62LwUam2IniqVtTfh80+GvUhPvhbxJMyDOqqemMPLZ+95RWL9OwBFlozqq6z6BRFv3iBbpt73g9aSNz+ENMiTn/yP3RZ2EN01wsqkr8Do/SMqx4o3lbW0NQe3YxwJxjCCJTXYSbEyM6WCKg/i+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amc345V0ABYnWmTuzWs5XId5+/6yv4cUgrvfJJyi0mk=;
 b=gmfTqPpep1MbWnMxfDONR9rF80Rg6wmCFHXpzKJDpQLvcfCAT/gFuWrOVBCzIHU52E7fCNGpwnAjxGM1er3S+6wNFvzimZe0jp+btq3Dn0dalv1nCc8VkyH+4nuJ0OEUizDojHHlqCEMwj++5GnJQkNHvrhffk8jxG51uqFQFQTRyWhZAKLqhuO2lI3ZetoEzQ2wY7qN1q8eMAx5hyfeVD8ICf0hLqgKXCRMInockOefkaWKEjVZ5iU620BNw7OQyRw1hxedW1WlZVGrrtLqjEztsJR1DSJlpjTYi3qSZx5+u7yXfy7bylBUFK0J/ZsHxSBkG6AMI0NV7URWS9cErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amc345V0ABYnWmTuzWs5XId5+/6yv4cUgrvfJJyi0mk=;
 b=PTDd0ZhuY/95PzdzIVq9nv4p4GdpDSSSNOQpC/XLFc3x5c+L/be82UmSAgvgHje2Ky45rdk9seisRlnG+fuRmiCSJjF8lCrv8d/rm1xn+jqeFi57pSL9FZWnEEVfVCas0bSln82EF04ldgrWDUzypGnD2LAyZ1jxNjkzYcxNmoc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4641.namprd12.prod.outlook.com (2603:10b6:a03:1f7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 18:38:28 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:28 +0000
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
Subject: [PATCH Part2 RFC v4 36/40] KVM: X86: Export the kvm_zap_gfn_range() for the SNP use
Date:   Wed,  7 Jul 2021 13:36:12 -0500
Message-Id: <20210707183616.5620-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1993c423-fe2d-4c34-2f38-08d94176694d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB46416E746DE367D5093CDAFFE51A9@BY5PR12MB4641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWV9HZpRL11qWkTJf0NURWXsmlzgnb2hapqy79E30fWYobyqD+ipxSPcRH/rHEsg4Yvtfj42iN19FDIsyzPPdvRToyZrqnu9ireq4iPXtRR/IxjM97VnGYCEOJgKusfozfGm6ktmCLRn2r5S2xdu+0CsA6NfM5z6CSQZKt1FV4Zws35SZTdlgFfxBk4+ZCW5LMrR+z4UL9kBtHIYK29VYimxn0H/Zhc0RGhDmr5hq9zOLjjVhaHAq3Mmia1GYwCV47GTJnD+hjzPSuYNQVhSMHstdMGb0h8uFTchcvD46zRsp3UDjVaaUY2Z8gBDc4OJtoQZzIjAoKZfF/ampV1PjreunP//DU8WV9WG9QbqzgmDKOka95DesAaCIM/CqZIXLLzwp2rFIBWJlbvfrkxOb17kIAU240a6Epcs1aksHCbYoszI5wN05ANlNqEC3zu+Fa7f8qZsxoDLZXpWFSbsQ/U1oUk4PGhS/TcIBZpt+2S4gcSoJMbA2GyNde4CSudBObCJXM1GvC33Ov6mgEN/EGaMv3qfOQ2I4z9Tb/JmrrLiRPido2EvaZUfCDXrw1xSYE3j/RUK2k4axM9s/VCzjDCYWZgGk6QC16QHdp8c6Ve8W/LmJBdt6PbYFerrry5qLWuYIEvNe48hr7OtJtFWr41mgy2bJg+Iv7M8yCMuH/iyCPOu1EV/MZgXCxVoW0p7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(66946007)(66556008)(478600001)(66476007)(36756003)(38100700002)(186003)(6486002)(86362001)(6666004)(2906002)(26005)(5660300002)(38350700002)(2616005)(44832011)(7416002)(4326008)(8676002)(83380400001)(956004)(54906003)(52116002)(7696005)(316002)(8936002)(7406005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3s63r7kfqobN2PJ5vDTyHGuJb3iZ8nfWDTUI5sUuAUbc5UjpWU2HrDKoQR4?=
 =?us-ascii?Q?CsHeqZoY0C4Iy+g/re4s3o6XkwAYKQhkHnbLVtVtAb5D5q9p1hgoZZ+sMZqs?=
 =?us-ascii?Q?x3NTeReXoEpmkVFdlH0cCWnBB/bHUWMDnXYH803OysDPKqGZlNzGgLnPcuYM?=
 =?us-ascii?Q?QHJovxJWJQVntiVlPsjQwnuesDe4yYNsgJz1xXnfafzg6Y64oW2xG0ozRC8X?=
 =?us-ascii?Q?hV0Sr0urK07zEe8bNJfTazc8CksV1BDmrLjmROV+4xxdve4oTnbH+r6NcOkL?=
 =?us-ascii?Q?fB5KlEfCFbyU3MYtIR2d/l1RrD/xnCjEgUJymxJEJvi2jI5hDxkPyENuKms/?=
 =?us-ascii?Q?TQ4fEJBXRCfgEZBPJ1oVIpssFviH/N2oBVens/PL1NT1qguT1ud0vr10GPEP?=
 =?us-ascii?Q?EAyIiYu0Dj101L8EkwJyDj8UWDfda6H3AE6c8EWnyWEIeRA5/iGg6pQa/iVi?=
 =?us-ascii?Q?QFf74HCkzPkmaMUkb3+ChL0DXjHFEPDxTzkXB1TAK3yji0/TkJ1hB1REj+xH?=
 =?us-ascii?Q?17FNCazX9hsIG+81ctAVar1K2fMaRcPjokIPR1IZm1tod5mAKxg3WujJQ+u8?=
 =?us-ascii?Q?JkDr1DAgQHglqr37MyfLQ1huUJHLun3g4jex/pZc8N1g8mTYlaWLw3Lj/ejv?=
 =?us-ascii?Q?dpBglWREBxHtWbkjzxsnGegOFKS0ReAsueFggAYiHo4ZklhwkIM/wpkHj4uv?=
 =?us-ascii?Q?U/wI+rAq8kznYxXygBolYKB4dEID2tqhxAxoQAOVrzGCVD7lTPMVWalOuoTA?=
 =?us-ascii?Q?0GrWZwIOxqhs79UeepKCK2QZD9mb9fzVw3vVsoHHNhrV1NAdZBykxTHWbtbh?=
 =?us-ascii?Q?9kKr35UcF4ZkKOlk4oOdIjZFpHI74u/QKDUuluO9cyIwlYi71XhXLF7dw6y2?=
 =?us-ascii?Q?W5P4Te21LtEZOAD6qMKCBsaMD/vDT6qFQXma5/v4/MX9SLsGF54Y/yzT6hhi?=
 =?us-ascii?Q?Ym4U9qkgHwFozzjGIXuu+2EJEdrYSrK2iq/TFRsEI33S9CMWtxRYYFr4XZLB?=
 =?us-ascii?Q?IqpfyXAIxIoaRr4rb2ocYBE8Xo0zDg7Fi1D9NdLoIQaleuFWRx/0mUBWuTNj?=
 =?us-ascii?Q?GEqga/hW716vQ0feUa8BkrLftkT+YUo5db82KK0SjekFU1SzN+2sf7Zfsnxc?=
 =?us-ascii?Q?P7miUVOG7dc00pvQP/gqeJRfOcOYTUCEARGnv2GHI5+9gBkBW4jL3sLihdZf?=
 =?us-ascii?Q?/2jB4KLF3l0jGS63OuTcPEmxx5YprQNDcQdSYGZM0LF308iP9ZqKh8yY8Tz/?=
 =?us-ascii?Q?W7k5/rPHlMoqozupi1zbmtCwEfqDrnsefA2cDI1G/Ph+XD2Uuy27lSC8qk6P?=
 =?us-ascii?Q?S+ilArBxAmhiKC9Ht4Ow+/9t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993c423-fe2d-4c34-2f38-08d94176694d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:28.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A/9C9tw84rWRL6GLQTVv6bn4a6SD1aziYGBBWVFfOi4J+tpPeP0pGOa+PgJOC9RKqZ8+3flKj4tgzV2yKxBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4641
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While resolving the RMP page fault, we may run into cases where the page
level between the RMP entry and TDP does not match and the 2M RMP entry
must be split into 4K RMP entries. Or a 2M TDP page need to be broken
into multiple of 4K pages.

To keep the RMP and TDP page level in sync, we will zap the gfn range
after splitting the pages in the RMP entry. The zap should force the
TDP to gets rebuilt with the new page level.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/mmu.h              | 2 --
 arch/x86/kvm/mmu/mmu.c          | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 678992e9966a..46323af09995 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1490,6 +1490,8 @@ void kvm_mmu_zap_all(struct kvm *kvm);
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 unsigned long kvm_mmu_calculate_default_mmu_pages(struct kvm *kvm);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
+void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
+
 
 int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3);
 bool pdptrs_changed(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 147e76ab1536..eec62011bb2e 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -228,8 +228,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	return -(u32)fault & errcode;
 }
 
-void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
-
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_post_init_vm(struct kvm *kvm);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4abc0dc49d55..e60f54455cdc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5657,6 +5657,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 
 	return need_tlb_flush;
 }
+EXPORT_SYMBOL_GPL(kvm_zap_gfn_range);
 
 void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot)
-- 
2.17.1

