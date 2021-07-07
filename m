Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C643BEF39
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhGGSlW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:22 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:56449
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232650AbhGGSlD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2P8y68her4iiVyZSQVAwUcnHqTe82EBzQCLNBvr65wLReScNgFnx8Nf4jSxoY75E7XiOHDGHt8U3wmkQK38n6jdhmjHryeb8fq7HT6TwG0felNYh7IR+98vTEg1LaZ93IkdTnzw0vAEzzqaCbQQEv2Vd6vmFYuy0OcjU5LEYarBLDvl/29CGiIrjgoS23slK9c0UBnJXUpvxwlnDBn439X0Aw3KR4MXLabp5s66v7OlfxWOTeg4hlSTLXBOU2vR6nZ8AishTBtNEvZnBApTmWzlpQywRzvH/1ZvFdwL18eoUHjaegb4VDZrg2GNAv4wRxXevNhHZAlOUnjsnxWHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy11knPYsrGP2DMI5bbBN/Qbj/rYf+mI8hBeoLJFHrM=;
 b=QcGJ3LIVVaVWcPVvbSczP8IJxiq7Auf+mPQN390vUdMrMLg1jO3giNRG4Hr32J3U2TtQpp/VMqXne9BLrUHcuwHhWWsQ8mgGjTxfKPdbsyUP1mMblsSFb4nIHkkQi8PsJv6hvgKV9anQx9XRkWUlgT/ub2nGPMeISYPFvlnF8x/pbCyHO+ezHSvHptf5eg0lhXrY+RKlsQSzRFHGhRwlAWAcIZDgECnHj25KM0t9M4Hq9ZvT9yLKfFXIJbSIqGMT1rqQk4OZTab7RZDElMdiqjP4pqVtARf0yKkSeThwG3aEXqlY6UT3K4h1J+g3tx7CjPNe88t7WuPLh7t83E+ItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy11knPYsrGP2DMI5bbBN/Qbj/rYf+mI8hBeoLJFHrM=;
 b=y9mOV1DKmqJuNmWs1XsaGanDTqonk/1xglE5mUf4zXuxaXYTg221pblnsCDwJLEQiOHUVF5CLAkeQsk3jPlycNU8sWUcu0agNIvP3yQcVz1qpsjFDKGmBrySZC2htucDZMoFpFExjYhSI2uFywcXDi3iSeJNO6VVqQGJknsoeQA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:20 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:20 +0000
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
Subject: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR based Page State Change VMGEXIT
Date:   Wed,  7 Jul 2021 13:36:09 -0500
Message-Id: <20210707183616.5620-34-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7882f190-9599-4ea1-59bd-08d9417664c2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40995A2564633DDF995DFAECE51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxYV9Br8oLWngGvvjm8IGssd08j04PaJSmwY3UXU+3KNzmXSGiduJpLWNZM4Uf8iaswOeeGyYArYYP1Hr4qLn7vG0jI39hmWVxKNPS/GEGJ4+mjkdy6PNthLoLRub0+KIJi9K18lOGn9bN8WOvBg/1y9uoBp2l32HsEI3pTygnC+a7buEZZfOrDihXmrUtHtgkF8lM9ww3O9RvUpTtue3fDnTLEyzPLM+fsxDObxaXNeNF/z3svqwA94QpsCMZp9AuvRpNamIbo5DJp3a4gQkWvlIm2POAX+NWMqJ4zLZDcbUM71qC5pI9V138MzIDzHo7y0QBRP7oXXzGgR2K/veg3dZiNPalG8fXLI2VLR1Unp74t5mGziZETkKvSPf3aAfSiojV+OYJGkVB8MTBbMshvECn4w1hfSh1kgA9diF0KmUbY0Dn4KnnQbOVk2+zeIz5b1v+IlGZsGRRjC5ztvwgpw/fj46BCJhEoDULb568/01yvg6dQKhftpa8H3bGyJyrs3wIyAAWWG67aEhcrun18qgrd1AOLGGQwxALRRblyFG9I+3ymeUtgwTr9mXi8alklMqfva5LdaQQ8zQoHtOrc4iTP6GowVZ0igb24wmjn0v2KrgBOJThHz8fZfM5EMAxRLPhP+WVXNXT60TKDnVrSA6/RrJkHeCu/iMWnE46DLAj0daHObG1cMfYnKMow6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0QBYEkoSZ2Y5wk+vKjA2C6GM28fyHEU/rIOXRU+w5h6SNRVXmh8l9ftxfff?=
 =?us-ascii?Q?K3crgcqpKqGBCQmXmWbXENoTisnbDVk4XUmle1l6d28+1TOXWxe8SUwAFcic?=
 =?us-ascii?Q?B7aNQuVGhdTlt3mzYy56UfjcwBfokaLPF+fpJG4g8DL1huNKuy3IAtmDYvyk?=
 =?us-ascii?Q?VwdI5aI+JSVUIel1bMG8ZTf9Xg/ZtJ6CRCtlwcteW0o0J6AE2RCl1hlhFYe8?=
 =?us-ascii?Q?/OQ8sMeWBQQ99CwKWUgp4ufcijR5xpJFzm4puDBf28NzIWwSms55s0OwrGNV?=
 =?us-ascii?Q?/3KwwUjBu2VSxshH14Wzd3xgMm20KsZwDYVkJ0AQhdVSqiTejsSRKMoC+14P?=
 =?us-ascii?Q?eG1wPUg0jNkUA88/B+cLNFJ8J5Pf81MExPQ6P4P9FkAskd3WC17cz1byT0jm?=
 =?us-ascii?Q?IQ8VFjmJ3XyDKtgIeuTRWRAH6Te+L5gZQF+/pjJOkmwkrXUNPrrib36G3baq?=
 =?us-ascii?Q?SziK4JqEnwwvjBc9E0T8oYyA/1UeXq35fmfQP3/oqHIbfTDIhIWoWmfG/CnL?=
 =?us-ascii?Q?Il8D5W8Il1ERkfLhDwuJ/8KR8d1HSrbAphEqYrUMMO+UzbMW0m0E3XWz+NNV?=
 =?us-ascii?Q?zH2o/+Stfy7pdVZXmv1pTPZkAdUIVJGqyX3Sm3mdYqGhPss3wAN2M74UI5gP?=
 =?us-ascii?Q?AhnRu5dtNCcV+7zncuXdLN6b3dRORCi7recGJ1u1OXrANwCj6rRSWm97O3yA?=
 =?us-ascii?Q?NjXH7Mtv2X+3631+AM9iuzxxZhAHLYTEf2EbEi9Azf3VqeCUVPo+oCaJvndd?=
 =?us-ascii?Q?2x8tEfHc9nZW277JI9B4c65MqouQh5NsGOgMjLdapkFd2a+EIc90+WBjMDaH?=
 =?us-ascii?Q?M2zdWHcov0AMAHfmkqoB/ZBrwpc056t9YY7OoHNPgFXRlW9Gzu9YSjGdDqS1?=
 =?us-ascii?Q?g7+sbYhg6OLFg1SrgtG+mmn+03XjJewbkJwFTDhgBMMLnOtpWuKFOaaW7601?=
 =?us-ascii?Q?wHLVbLenjHhcEz2hfwotcEIorVG4GR5YJIGGw0Ka5MoRslLB4iZsPIXyLJa6?=
 =?us-ascii?Q?I0dPa56PA4YtMGaDzbSgffI9qV+tXioe03wvwxPrNx+bKPdifyd8aWjOjc4C?=
 =?us-ascii?Q?ysxYrOpJRbRKV0I1bIZVVSIUEDdX345VvIwjlVC2Tcqa/5JiXwouYnKsFjaT?=
 =?us-ascii?Q?1ozS7xhMvdTfGC4nfMCWFKPsIJVCzQX771lmTA7WZOLOpH2mTrtzJ1TC9TxR?=
 =?us-ascii?Q?5KCtYyc9Hs+mP8j/xnpAHl+LB7sauLcjBqGOYiSsT9DkiTMGDyJ9TkDW4nox?=
 =?us-ascii?Q?Yl83i6Dq3csZzmOA1bZzNqxDxvrvYEgTKrGpB8MteEoqWv8JjzsBEPMrFPMO?=
 =?us-ascii?Q?Crzwi5GM9vKfxQacY/Hzz9JW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7882f190-9599-4ea1-59bd-08d9417664c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:20.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5LKdKcU0CnDb2l+dcKVyJS5u5oCqoe6Gn8lO7zSh9Dg7jqmQu62ZjkN6C68pSuRUfZhQeOK5amxgy19U2r4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SEV-SNP VMs can ask the hypervisor to change the page state in the RMP
table to be private or shared using the Page State Change MSR protocol
as defined in the GHCB specification.

Before changing the page state in the RMP entry, we lookup the page in
the TDP to make sure that there is a valid mapping for it. If the mapping
exist then try to find a workable page level between the TDP and RMP for
the page. If the page is not mapped in the TDP, then create a fault such
that it gets mapped before we change the page state in the RMP entry.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   3 +
 arch/x86/kvm/svm/sev.c            | 141 ++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6990d5a9d73c..2561413cb316 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -81,6 +81,9 @@
 
 #define GHCB_MSR_PSC_RESP		0x015
 #define GHCB_MSR_PSC_ERROR_POS		32
+#define GHCB_MSR_PSC_ERROR_MASK		GENMASK_ULL(31, 0)
+#define GHCB_MSR_PSC_RSVD_POS		12
+#define GHCB_MSR_PSC_RSVD_MASK		GENMASK_ULL(19, 0)
 #define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
 
 /* GHCB Hypervisor Feature Request */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3af5d1ad41bf..68d275b2a660 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -28,6 +28,7 @@
 #include "svm_ops.h"
 #include "cpuid.h"
 #include "trace.h"
+#include "mmu.h"
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
@@ -2843,6 +2844,127 @@ static void set_ghcb_msr(struct vcpu_svm *svm, u64 value)
 	svm->vmcb->control.ghcb_gpa = value;
 }
 
+static int snp_rmptable_psmash(struct kvm_vcpu *vcpu, kvm_pfn_t pfn)
+{
+	pfn = pfn & ~(KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) - 1);
+
+	return psmash(pfn_to_page(pfn));
+}
+
+static int snp_make_page_shared(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn, int level)
+{
+	struct rmpupdate val;
+	int rc, rmp_level;
+	struct rmpentry *e;
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
+	if (!e)
+		return -EINVAL;
+
+	if (!rmpentry_assigned(e))
+		return 0;
+
+	/* Log if the entry is validated */
+	if (rmpentry_validated(e))
+		pr_warn_ratelimited("Remove RMP entry for a validated gpa 0x%llx\n", gpa);
+
+	/*
+	 * Is the page part of an existing 2M RMP entry ? Split the 2MB into multiple
+	 * of 4K-page before making the memory shared.
+	 */
+	if ((level == PG_LEVEL_4K) && (rmp_level == PG_LEVEL_2M)) {
+		rc = snp_rmptable_psmash(vcpu, pfn);
+		if (rc)
+			return rc;
+	}
+
+	memset(&val, 0, sizeof(val));
+	val.pagesize = X86_TO_RMP_PG_LEVEL(level);
+	return rmpupdate(pfn_to_page(pfn), &val);
+}
+
+static int snp_make_page_private(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn, int level)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
+	struct rmpupdate val;
+	struct rmpentry *e;
+	int rmp_level;
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
+	if (!e)
+		return -EINVAL;
+
+	/* Log if the entry is validated */
+	if (rmpentry_validated(e))
+		pr_warn_ratelimited("Asked to make a pre-validated gpa %llx private\n", gpa);
+
+	memset(&val, 0, sizeof(val));
+	val.gpa = gpa;
+	val.asid = sev->asid;
+	val.pagesize = X86_TO_RMP_PG_LEVEL(level);
+	val.assigned = true;
+
+	return rmpupdate(pfn_to_page(pfn), &val);
+}
+
+static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int rc, tdp_level;
+	kvm_pfn_t pfn;
+	gpa_t gpa_end;
+
+	gpa_end = gpa + page_level_size(level);
+
+	while (gpa < gpa_end) {
+		/*
+		 * Get the pfn and level for the gpa from the nested page table.
+		 *
+		 * If the TDP walk failed, then its safe to say that we don't have a valid
+		 * mapping for the gpa in the nested page table. Create a fault to map the
+		 * page is nested page table.
+		 */
+		if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level)) {
+			pfn = kvm_mmu_map_tdp_page(vcpu, gpa, PFERR_USER_MASK, level);
+			if (is_error_noslot_pfn(pfn))
+				goto out;
+
+			if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level))
+				goto out;
+		}
+
+		/* Adjust the level so that we don't go higher than the backing page level */
+		level = min_t(size_t, level, tdp_level);
+
+		write_lock(&kvm->mmu_lock);
+
+		switch (op) {
+		case SNP_PAGE_STATE_SHARED:
+			rc = snp_make_page_shared(vcpu, gpa, pfn, level);
+			break;
+		case SNP_PAGE_STATE_PRIVATE:
+			rc = snp_make_page_private(vcpu, gpa, pfn, level);
+			break;
+		default:
+			rc = -EINVAL;
+			break;
+		}
+
+		write_unlock(&kvm->mmu_lock);
+
+		if (rc) {
+			pr_err_ratelimited("Error op %d gpa %llx pfn %llx level %d rc %d\n",
+					   op, gpa, pfn, level, rc);
+			goto out;
+		}
+
+		gpa = gpa + page_level_size(level);
+	}
+
+out:
+	return rc;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -2941,6 +3063,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 				  GHCB_MSR_INFO_POS);
 		break;
 	}
+	case GHCB_MSR_PSC_REQ: {
+		gfn_t gfn;
+		int ret;
+		u8 op;
+
+		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_GFN_MASK, GHCB_MSR_PSC_GFN_POS);
+		op = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_OP_MASK, GHCB_MSR_PSC_OP_POS);
+
+		ret = __snp_handle_psc(vcpu, op, gfn_to_gpa(gfn), PG_LEVEL_4K);
+
+		/* If failed to change the state then spec requires to return all F's */
+		if (ret)
+			ret = -1;
+
+		set_ghcb_msr_bits(svm, ret, GHCB_MSR_PSC_ERROR_MASK, GHCB_MSR_PSC_ERROR_POS);
+		set_ghcb_msr_bits(svm, 0, GHCB_MSR_PSC_RSVD_MASK, GHCB_MSR_PSC_RSVD_POS);
+		set_ghcb_msr_bits(svm, GHCB_MSR_PSC_RESP, GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
+		break;
+	}
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
 
-- 
2.17.1

