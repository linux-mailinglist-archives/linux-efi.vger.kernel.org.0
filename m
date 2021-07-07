Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22573BEF2E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhGGSlQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:16 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:37344
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232444AbhGGSkz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqQh0vxJoEqd2O/3T+5Wuas6dPToCITcIAcEme3yBEapOh+PFB9R/q2XzWUXoyalvxTbE7oAXoUAeGYlcf3abByzhH8nbQJPJcYaeCQT+dTF6sdOD+aO/r/nnE37b8qKoYMsiVNZ0dHiI8oRPezweztpLjGp4jdde1gWwAIlsR33MXZy5bAjSMS7U85MPrJWCC0G8vikAlAm8ZRl2xvUXnkinzXmGbvxMaNFm3bPnTvWt06rHxFKPQiLVVgqwqRr68zQu4iVzXzJiBJTT1j7S6cGxgphY2q6urKEqUMkXebMv+VakTiULXIqSAtBQaYx9iZO+oRb3XQOziHVffVnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9HF8EefmBPOBEPFGyuE838rmv+SJdOR/O9nh43Cs4Q=;
 b=IE0CJgKrc2gAIDbduJ69+pSSAIyFSbS8f8yYARq/KwUwCE/Hs4epntM0LeSmYMCpl5GNQdcY+J8a7rL3ui5AIC6PNkePPPDtCEra4AM9loyo32OonEK9br3SdUI4s0m4t8TmvmxR/le6mGbMSRK9MHj0oc6S1fX8jILEU0JNoHxpvzPRo8PLCUGyrmGnWSgNAmWjRnCk5D0mnYxpCXcyYAZhX77TJMPSl7wFCNiBLMmyKPO4tPFqOK6Z9kBueQqF1N4zl3zxime+qyvXkQGLgJcFUq4zq7LUttQSZaeMSwvP+gIsUfZOwt7p32Fddx5POBGt0A8ZgvXXds0R7uaBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9HF8EefmBPOBEPFGyuE838rmv+SJdOR/O9nh43Cs4Q=;
 b=YX3gy25chit+6qdM/HQMboV+HEgy8hNHHmhIkcwwXZmVq6b/RGt5HsCwoq+gKRgJAVvxUO/u7a4dWuSf3q05nXY9xPP5q4U4eizShl4YnEofXnLkfXFrNoavvrJCtevMV+K7DhOzjbpwZ4qP6YLIpRc7wlR75ke8y/47CJJCS+w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:37:59 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:59 +0000
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
Subject: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when SEV-SNP VM terminates
Date:   Wed,  7 Jul 2021 13:36:01 -0500
Message-Id: <20210707183616.5620-26-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eeb9e32-e9b6-4e8c-7a48-08d941765855
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40825B037BC5204E5FF6C1F7E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmOlNFOy3xAtyQ+eIOZdQxHBmH0szu7xAPgDPX9vv2g+3NOjoU8Avhqsj9pVbjTSwhQtPVToZfEAdUj7nVXYy/EjE34JGuR0iJyS5QUY6gehKuSo6IG3PeEMIvyQCFlua/qDO31KcyZozQBUayVWr1VwMMFhPcnc4mw9Wql70Ga3elbukKMjt4vnsWxQ1ROEOnUFfVQyzW+J7t+yr2evn4YKI8CoHA7w7lmBtTdEegrP97DkOz+NDbEwBNv4+evMA4VAOuAi9nbW81XZLTIr91zqYG0S6AJx4V/eCMJ2EFygmbmlAVinFlw7IvXNdwz35N0MeBBAV4XY8xlinydx4PMCtr7Kmm0AEis0KeXOtE/0ziSKhKzUMmegLmar/6+G5oQtJv3B4SV/lreiVDKt3PYFAu252OwcjbyDd3gONuPIsCnsehzKzgp99rrXneyhcGA5xCNFh6Ib72AOnII354ut1hlYcacikcJjFlKx7htg9FOioYDxaRIQzyVZdic2loxPvEkDoq+dy5DqjZoXkA6hMaOaRy6oBMuB3zf4w+WhymXsPFXcVSwwQhOaHiCxcEgrVEWpu9vRid9owPquOdT4KkbGvZ2tKMCe5vOGm0w2rnBGDe2sLScdVfpYJcICZOTtmZjioarpcYy/rBBx5UqJ5qZgEa+XPP7T4cWxZWYqMBKA6Y8SeQWkMNKQwSH6bEVUtCLiYLrWr/Xne/HV3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BjxZlqJ3biYhDtGJyM2MIwuT/8aBy+7IMpkyzcMVZQ6J2//+tphHhq5GOknu?=
 =?us-ascii?Q?qFUJWVvqITgx+BD9Mmv/Mg+GmT14QRq4XorDHehghJaDYPfqn1D1R1tNQdEC?=
 =?us-ascii?Q?1Au8ZjM2w0njAhDYTxa+XV6riccLz2CoL7+QP9M/i9MJDL+0ZHOJk9r8hC/4?=
 =?us-ascii?Q?UMgNe7W/lOCFBEDUgaarVbea2q8EUsy6Rr4fAzlZ9r23r+1vt2TRIj+w9LpB?=
 =?us-ascii?Q?IduVxZWkL6l38FS9v7Sbs429ikfuvmAyUg/jJAHZdByaGpDtUpu/vOQpvBWy?=
 =?us-ascii?Q?o/5fKY/rM6s65mEygOi05ZvGeHvV5mpy1x9kC4sQW1v90xick2mWN925e1kv?=
 =?us-ascii?Q?4AS+adbqKLeDQVvbm+mUhTk4by1sYPaocJghOApSDJ3NKjC3KdsusgiYGgzb?=
 =?us-ascii?Q?Ozf+tN7OjaUS/E7fG/V1T0ewh8CTniKno7OBBHcwYcAaqYsieBv8/LUm2p3j?=
 =?us-ascii?Q?3yU2W/CnpESXD/tVzddRS+vEwxvg2XT4UI9dKSOghJriuCQUanmAqgEXFSjF?=
 =?us-ascii?Q?E21PAZ9JCKWIvXtuvicx1bAx/uXM0jZT90BRU1gd0vyGOFVB+fEbnkjgF2KR?=
 =?us-ascii?Q?eUQWvdIABy9Mf/zNkED7egC+Mw9Vs3lBu4XkxewjUxGpbBWziv5SY84hIZ96?=
 =?us-ascii?Q?l+9Vjs8DRd+/KSctK3s1dZkK+QuQ24UU87hLNrYbMgl6GtsFvLhp8nCl7UyQ?=
 =?us-ascii?Q?8OPHxc3hzN6jFwzGh0nepcXTB9fNj/sg72fWgLhEMXBUU5pi8NK37lRuPcB3?=
 =?us-ascii?Q?KJF2IZngfHKnYroxyxltF+nbSPFb1XXzWRZZ7lQ2C2UCpZn4gMNJ846z8vif?=
 =?us-ascii?Q?BGmyRPmZsbeZBxa83Apxv8eNW/a3vzATsDW88tRD1GQ/tFIrPXCz14FhsFFD?=
 =?us-ascii?Q?85xyZqOIlHnfqGUZZsI0a9G8nJLY8UWtLtI9KGZM4JCvYtr1IUotlHrlCK2H?=
 =?us-ascii?Q?uSge8AiGkIOHhJxTxVY5GhT20TUAbYGOS6h2Z5K93+dRFkSQxQME6aTZrn2V?=
 =?us-ascii?Q?pIsXJDUBkUQ5r3WJpeHsHUC4BeijjDISOLCf3EdHsvotm2+Shz8d5ZkWKxLK?=
 =?us-ascii?Q?4M4yY/jDnV53DGxgqAhmgTzJvlJgdgaykR4CG9/zo1v3SChbCaifJdzZdiIu?=
 =?us-ascii?Q?bcJ5GiYqyIRCaTi2MBQsNzL3QzDfx/y0YXLgb+SD3OftXhyDJD0uCOg1ow/T?=
 =?us-ascii?Q?634lXxAUV6GE/3svDVsKH4fFoVsLoYzvt7VTb9HpL7I39YVEFP6PX02mmURA?=
 =?us-ascii?Q?0AinhIKdG2TLXqSOc+B1bxuKSEMDwX5EalPjZwR7ECVFOCEI1HF1g6WB3H4G?=
 =?us-ascii?Q?cz4sxvEnN50liY8M8Yus966W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeb9e32-e9b6-4e8c-7a48-08d941765855
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:59.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA7LasvH4IJ0unvnb5GvYdea2Gfzmu3gkRYLxnn9vjAnw0Ig8rfaS4e80Uvg//A0Jkipy0tNzcmvcNsoIN1hyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The guest pages of the SEV-SNP VM maybe added as a private page in the
RMP entry (assigned bit is set). The guest private pages must be
transitioned to the hypervisor state before its freed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm/sev.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1f0635ac9ff9..4468995dd209 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1940,6 +1940,45 @@ find_enc_region(struct kvm *kvm, struct kvm_enc_region *range)
 static void __unregister_enc_region_locked(struct kvm *kvm,
 					   struct enc_region *region)
 {
+	struct rmpupdate val = {};
+	unsigned long i, pfn;
+	struct rmpentry *e;
+	int level, rc;
+
+	/*
+	 * The guest memory pages are assigned in the RMP table. Unassign it
+	 * before releasing the memory.
+	 */
+	if (sev_snp_guest(kvm)) {
+		for (i = 0; i < region->npages; i++) {
+			pfn = page_to_pfn(region->pages[i]);
+
+			if (need_resched())
+				schedule();
+
+			e = snp_lookup_page_in_rmptable(region->pages[i], &level);
+			if (unlikely(!e))
+				continue;
+
+			/* If its not a guest assigned page then skip it. */
+			if (!rmpentry_assigned(e))
+				continue;
+
+			/* Is the page part of a 2MB RMP entry? */
+			if (level == PG_LEVEL_2M) {
+				val.pagesize = RMP_PG_SIZE_2M;
+				pfn &= ~(KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) - 1);
+			} else {
+				val.pagesize = RMP_PG_SIZE_4K;
+			}
+
+			/* Transition the page to hypervisor owned. */
+			rc = rmpupdate(pfn_to_page(pfn), &val);
+			if (rc)
+				pr_err("Failed to release pfn 0x%lx ret=%d\n", pfn, rc);
+		}
+	}
+
 	sev_unpin_memory(kvm, region->pages, region->npages);
 	list_del(&region->list);
 	kfree(region);
-- 
2.17.1

