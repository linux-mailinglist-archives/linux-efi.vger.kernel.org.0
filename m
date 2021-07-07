Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715933BEF58
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhGGSlx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:53 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:56449
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232677AbhGGSlT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjRGiXntA/XOU+5rQCUZIpqu5znVbUWkwuQ4f+mv4TADridpP7G8Q7uqdL8rdFg7w3OitAQfFOOV96yhIl8h/caFh8Km2/g7kOTqRd5mQmgEJL0ers535QXKnt+4rqN1hiOijRK9a3u0tZNI1iQjrzU0zYvGiRd/2OKcMJCJrpZkJ5uNMv635hO+2b0d5cqFPbo9042Ve8EvM0KCEUq/0RmRp7j0RnYKxEpgQs1xu6vnDzl7lKKfcOON/FUVQiaN1axbzhav+OQ/auH02nODQdLoGMBP/6I465sirbDRzO0Q35xXj7bLV9+82vYVEFeJJxQ5NApLsKC4lObe8lMelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJj5jPD74nDpJoqnPsMYl3ojhYLfc9Nfwyw1cqhHEdI=;
 b=MZPaRXsbPLi6nlfjX52sZ/VGPitk98ATsYT0vANkVoOpf6ncJS65bwRBWJq0DFLQCCkhJ1ygp6jEfOBjzSrHIus1kEHJXpYsBdnVQUXgqG1AIMtYXaLxhriEIJ36hyLOUtsk2365taXmVzmDrFupQkkfrcm0Pf8Z4J5EYPwn4R1+NgmBui7+LykLFDUeoMxVBhW5JukJqvzeCk8BXaChyo6C3V1xRC3l0tRYs+HPcfmRHfwyRdF7/sAlnkN6Z8FBB8PBZD2T3Au38RvWHrHTE2rr8eWLeWSIAHCrY+uFQC7qM0zQeaW4PZ6TGegwMUA9ghukILFvRjGaDqpDMN4BRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJj5jPD74nDpJoqnPsMYl3ojhYLfc9Nfwyw1cqhHEdI=;
 b=Yhxb2q7JgVA/F+q+G8TziZOWhwkNqasMvMbvqhSCTtmB9n7JHm0eHV8VBjqfct4CeSd7qy/E0Jp4uRPu4RUDWAd4jANL2Ce2T8rfWw5XhRwQlGpr7FBeKcV4YiWQhWMMWxZem1C0UHTipfLTTF9Z97j7qtIGZhU0IMK1wj8MKTQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:23 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:23 +0000
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
Subject: [PATCH Part2 RFC v4 34/40] KVM: SVM: Add support to handle Page State Change VMGEXIT
Date:   Wed,  7 Jul 2021 13:36:10 -0500
Message-Id: <20210707183616.5620-35-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc0db028-ba27-4225-2105-08d941766641
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4099710F8D2AE616A58CF839E51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5cQsK2FtkqmSbrT6g1x4BksBiZ+L5FSdNoGznuWUTPo3puFfjER8jAefyhaNnYbAAV+cwJuqe4cYE9krw247zdquMszhos1oACFSWFY+6lI1h7C/ep2LfJ5nNDXZ/y7xaqVkLmhp8auglfzpGNxSg7Yx2gLj1Q483TyfYea9X3SgDRST2+ncwg6atNhXm+RnEQ2pbfcuH2H5jDeZvL7GbroC81otSZUoeFbEXxgoADcM+s7YyiRQ4jdOiv8Pe2SjXSol38QEHxydYNYoluyv5acL+vuD03Ng+ode9fjat/+kmC1mma9M26p1hsLSVIA4bmjO4zEJXLu5TNAbeQsckYFHZ9aqEu0U+/XP6XI1kzpzbxAE0giY0WywlgrYsIe6WirB05Lp/bjRSUS8ltukieRtW/ag0DzDVuVW1ZtEfF7sBqrYhr76+ks9UBdmhRQhpNTfixXHoFaTsiyPPunAg5tC4MV5X16Y0sMMMaMXf20pu/mQkICkVIcWpetEFvNPtEukhyX9hCpC/DLnZ82vuShUnz81wDWM31g915LTmStGEJWNcaXIqmvrQ3DxrpqSNyoS/s6jsF5hmVFtcxnjR8Sl0A4TJrlWmEqBO4THOxhowvv/OHf9B+U0DcYL+XJZq5Nxhwlvo8uMK8jcs/ZUwtnCUWppOxBO1pNRwjuzTraTKJzD5qVSBpgwmKKAP2vZf4vpz+30BVvGzGTY/1dHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJyTGOJOlJczZ/ExPIJmPuthOIdBHynzzEsH7TMz5AVb7m2H+3UvTrG3sJeN?=
 =?us-ascii?Q?ZHJglNA0q1AZd2G2t3++/JSvbQdg7odaPrdF1SIIpn4dJDdvJKdk1U8vIpfo?=
 =?us-ascii?Q?sJarTlukiMrOrtjj3q3ncA5dCICVxct0VEsVfPz3bgzQMS3/ozeP/72jCTa+?=
 =?us-ascii?Q?2tPaXnsbAB2DlA9LHt67CkmLFNjwc9wFGZY/vKtcfI7sHw7za3cRjaQp0P6l?=
 =?us-ascii?Q?Wjww3B1DnpfDv+snWkCrPoXsE4uNu3YpiEcRuJxH1IJ6z1yfARMNh3wIALfC?=
 =?us-ascii?Q?nm7fb+r4XlviMf1hDWftdqMgrG2wjPYuRpza5ou0eoRZ9L8UIEX1LIk7g1Yt?=
 =?us-ascii?Q?wLpTlBwOuszLmWWQUUtWITt8nVjKS8A2Shznx5s7P01MQ8wHR6hAeQII+K4u?=
 =?us-ascii?Q?uHPjHXXi8v5d0SrtyZIxbUbeS2/jbw3b4edSg3fUOdsxdw86hYaVtgxEM94D?=
 =?us-ascii?Q?N7hVd+JRN9mJp8uyVFNuIpZD8l+/svFpVgvwoJSVqn3KzFMLYycbSVtqk9e7?=
 =?us-ascii?Q?0P+0WK4mShvo1rA3OOjCxRcM2W2Bg6vGCxJy+EzHQekxhIcZcN3KcS0nLmLF?=
 =?us-ascii?Q?8svyyYxQDrmOZfj7ZdNCBThpzhwiuBvJEKEMn7l4eOfqIFLPUkoX5PFRuqPp?=
 =?us-ascii?Q?fewL6YcX4P4X24BWP/Bazys2DmLy1Psht8yhdV4rRVVGTi3JrAKWXiktkuQS?=
 =?us-ascii?Q?/KhwbNf9hGHRzeV0hZKw21JisRoz52OY+DuojDub2dx/RS0veGekv65TcPFl?=
 =?us-ascii?Q?HnLKz3BDiBxPP1WwZYajJrSnPpflFCxTIkB4CChYBcwqA/dCunL7ps8Vx8wE?=
 =?us-ascii?Q?0IrbgEdH0QE2IjdxCzF3jebeF/JUT4lbJ+13qLY2gcD6dnoTC8iAfBlJp8nn?=
 =?us-ascii?Q?HYhh18GGKwIeLpe/BbBqw/x9eD09kBjjI461WdhzfMhP9dg9n3DPXw6UXxCM?=
 =?us-ascii?Q?Ok2DkWKZ/jIiYQQD+eOoVqLzLP6yX7uieCqJ9Q9eDlsFTRbQk9BOGVKZJ72C?=
 =?us-ascii?Q?5yUuv6tSYxTX/pMEywd8jSISqn1TrDPReMyKw9vPqhbLp8k14iw1iqVGEF9l?=
 =?us-ascii?Q?fn4YaJweLCMt5zGjNDtlsjaiZ3ow/aNd9rzLobk7SFruVBkmDcmuHKtbLipa?=
 =?us-ascii?Q?4T62ikbjaqLPmWx7svHo6fjxA2mHiWR5e1at/nuFL/p8Y17XufmIblbaEV/8?=
 =?us-ascii?Q?4SUqqqc1YZ/2X+6oHI28czA4JSAIOWkan5CgcQgpQz3eVV4pPgCUglKS1Dsc?=
 =?us-ascii?Q?qgMQs+PeSKrVmYD0Qv9qN7fBO6BIDTE8VxNqFC3eWwJ+rb0U+5UdUiTLmssh?=
 =?us-ascii?Q?8AoAZI+En29hj3AJTPm2INxY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0db028-ba27-4225-2105-08d941766641
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:22.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqumNALa1YjRHbRyHaFbg9iCcrW0XEB/M+2U42MbpADZ7rnDAK30CJl0yvkgjjk9k2Y1qeKt8wjDCywkitBpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SEV-SNP VMs can ask the hypervisor to change the page state in the RMP
table to be private or shared using the Page State Change NAE event
as defined in the GHCB specification section 4.1.6.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  7 +++
 arch/x86/kvm/svm/sev.c            | 80 ++++++++++++++++++++++++++++++-
 include/linux/sev.h               |  3 ++
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 2561413cb316..a02175752f2d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -101,6 +101,13 @@
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
 
+/* The page state change hdr structure in not valid */
+#define PSC_INVALID_HDR			1
+/* The hdr.cur_entry or hdr.end_entry is not valid */
+#define PSC_INVALID_ENTRY		2
+/* Page state change encountered undefined error */
+#define PSC_UNDEF_ERR			3
+
 struct __packed psc_hdr {
 	u16 cur_entry;
 	u16 end_entry;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 68d275b2a660..0155d9b3127d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2662,6 +2662,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_AP_JUMP_TABLE:
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 	case SVM_VMGEXIT_HV_FT:
+	case SVM_VMGEXIT_PSC:
 		break;
 	default:
 		goto vmgexit_err;
@@ -2910,7 +2911,8 @@ static int snp_make_page_private(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn
 static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
 {
 	struct kvm *kvm = vcpu->kvm;
-	int rc, tdp_level;
+	int rc = PSC_UNDEF_ERR;
+	int tdp_level;
 	kvm_pfn_t pfn;
 	gpa_t gpa_end;
 
@@ -2945,8 +2947,11 @@ static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
 		case SNP_PAGE_STATE_PRIVATE:
 			rc = snp_make_page_private(vcpu, gpa, pfn, level);
 			break;
+		case SNP_PAGE_STATE_PSMASH:
+		case SNP_PAGE_STATE_UNSMASH:
+			/* TODO: Add support to handle it */
 		default:
-			rc = -EINVAL;
+			rc = PSC_INVALID_ENTRY;
 			break;
 		}
 
@@ -2965,6 +2970,68 @@ static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
 	return rc;
 }
 
+static inline unsigned long map_to_psc_vmgexit_code(int rc)
+{
+	switch (rc) {
+	case PSC_INVALID_HDR:
+		return ((1ul << 32) | 1);
+	case PSC_INVALID_ENTRY:
+		return ((1ul << 32) | 2);
+	case RMPUPDATE_FAIL_OVERLAP:
+		return ((3ul << 32) | 2);
+	default: return (4ul << 32);
+	}
+}
+
+static unsigned long snp_handle_psc(struct vcpu_svm *svm, struct ghcb *ghcb)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	int level, op, rc = PSC_UNDEF_ERR;
+	struct snp_psc_desc *info;
+	struct psc_entry *entry;
+	gpa_t gpa;
+
+	if (!sev_snp_guest(vcpu->kvm))
+		goto out;
+
+	if (!setup_vmgexit_scratch(svm, true, sizeof(ghcb->save.sw_scratch))) {
+		pr_err("vmgexit: scratch area is not setup.\n");
+		rc = PSC_INVALID_HDR;
+		goto out;
+	}
+
+	info = (struct snp_psc_desc *)svm->ghcb_sa;
+	entry = &info->entries[info->hdr.cur_entry];
+
+	if ((info->hdr.cur_entry >= VMGEXIT_PSC_MAX_ENTRY) ||
+	    (info->hdr.end_entry >= VMGEXIT_PSC_MAX_ENTRY) ||
+	    (info->hdr.cur_entry > info->hdr.end_entry)) {
+		rc = PSC_INVALID_ENTRY;
+		goto out;
+	}
+
+	while (info->hdr.cur_entry <= info->hdr.end_entry) {
+		entry = &info->entries[info->hdr.cur_entry];
+		gpa = gfn_to_gpa(entry->gfn);
+		level = RMP_TO_X86_PG_LEVEL(entry->pagesize);
+		op = entry->operation;
+
+		if (!IS_ALIGNED(gpa, page_level_size(level))) {
+			rc = PSC_INVALID_ENTRY;
+			goto out;
+		}
+
+		rc = __snp_handle_psc(vcpu, op, gpa, level);
+		if (rc)
+			goto out;
+
+		info->hdr.cur_entry++;
+	}
+
+out:
+	return rc ? map_to_psc_vmgexit_code(rc) : 0;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3209,6 +3276,15 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ret = 1;
 		break;
 	}
+	case SVM_VMGEXIT_PSC: {
+		unsigned long rc;
+
+		ret = 1;
+
+		rc = snp_handle_psc(svm, ghcb);
+		ghcb_set_sw_exit_info_2(ghcb, rc);
+		break;
+	}
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
diff --git a/include/linux/sev.h b/include/linux/sev.h
index 82e804a2ee0d..d96900b52aa5 100644
--- a/include/linux/sev.h
+++ b/include/linux/sev.h
@@ -57,6 +57,9 @@ struct rmpupdate {
  */
 #define FAIL_INUSE              3
 
+/* RMUPDATE detected 4K page and 2MB page overlap. */
+#define RMPUPDATE_FAIL_OVERLAP	7
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level);
 int psmash(struct page *page);
-- 
2.17.1

