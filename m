Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A43BEF87
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhGGSn3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:29 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:29166
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233130AbhGGSmY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:42:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB8kHWuLA5GrWhAtML0FI9gf2+Xai8+EPMQl5ua5UfDQoGmWnQWtOquf0fIOWR1vNoXZe54X43+ll7m7WUvoo+Ct3PUqCcqTbeBOhS4bMfa5utZWOdVKqxM+SHP29nKMyQa1ke3XWlfznGH+ZQIiUeIMDmv3E0ai8sZ9cgJDyqZpTg37fQXkhofyFsIm1/VpI7NCuQowthx/juDbnKMEpaeKOss7cXpQoVohEqMeFQPmsdQSfRY+Ke8Aj7k0gWUfpss4PfP9N+yC0KjA6O+aZveb9vZViBeLGeihLrxnXtdHGkUJcAMt+gx6uFCOKgK9aUNcSFoMQuPcszwWVEtngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E88dLljcEoInol4BSI+UEs2JzY7RMrQQ2fETJg7CEVw=;
 b=eupSaV+GewEzFBr3NRSkYRDRNBj2rad98wththfglleAOzfAA9K8PmSU5tmlNTBbsAgkR6P5M5JYp/izln7haEdacgaUZ3d73S09ZOLXDK89kAPzzRmckMechIYCu8wsXiru50P2aFhiGyC7292kNfIyHTNSdZBOROdDh4GkNW4r1l3kRkgpFJZX7sNUs2fle9JefSrS/8LVetEWvHM42+tGwpHJ/eNj96zpEMe2tRO9nBkRVu0PvnA1okOn0jv0jhJCbQBVUY5OWgXqO7yuIYGBLyvLO5F68gkqSbAtuOFoK2CrA+EWiu5MklLAh3+K9lUua/THQyduJYQz4J3lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E88dLljcEoInol4BSI+UEs2JzY7RMrQQ2fETJg7CEVw=;
 b=IDB+DeEh/MYTjrACVH9ReJcaTrLAhxtlM5ShcfU/1KVUiFYQHfdlZ9MWnT9h85jQEvqlJTEZpb2KL6uzjs0kGQvsaExC6r4rUyrAJnyCRllpA0wpuGttZ/pdneyMI2p1G6SKZH/+B7RMumKFAFV488LNy66PSVzcaOL/eRR0H+w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:33 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:33 +0000
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
Subject: [PATCH Part2 RFC v4 38/40] KVM: SVM: Provide support for SNP_GUEST_REQUEST NAE event
Date:   Wed,  7 Jul 2021 13:36:14 -0500
Message-Id: <20210707183616.5620-39-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9157387-8875-4aad-fb97-08d941766cb5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4099D9A098F781E0EEB939A8E51A9@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ql5zDCNkW7fcwzvCSqO83Kp9Ii4GaDRxRjE4/vzksIxn2OMli2sXD8mfmhCIzV/z1dPNSpJygamBPnoMl6udTq3UGiTuAWrOGPLR4JhVht9jHL1SBkxh8Vx7Oxx4aAK52w6aA1e8tIvT/1t8RP8fb/LTejkYWw+u0Yd7fGInyuTEp+5HbJxaTlnJNhTmPG3Ue9KaU8WEn1jUWoqVPZJF3zAwPFSsTYjv2vvqFjXLAGoDT5U8AtmckwnPzJ8HOaJQL8/nUPlV0s0PhuamAdYkRbkf3pfs7MX/O4mgmTo8OVOP9MGMH7waxq2e/PTnI5K/VsSZXByhs82LhKb/gzEYV/LJCwaR55ol+52iJzToUKvS2wSEC8yHsrupP9rofa1BRvhQbSX5yoqyOndghs43JNUeRwcGhQqSBxTidia8l2qMRcV8lPJN+ilSOfWsULEzTpair9TK1LQqVMGQqOmHvz4bPF0XImME8ATkqdTNzn0s5pFDLco52Xm506mETopO4lRU6oyJh4kTA4KLMZRbs5avUZDRirWNv+0yYF6EXPff67zvwKiTQwZdIxlJSz4KC5J9uCae4VgWZ8AiYqrxMJz8ZI9Tx5ZvO06KJJRvLEr9D+Ebgly6f9JzSj1kOauX6RqGnyLHLVTLEoZHjrz+em+SpDRMze0lq1HJEgrBjd1Lga34ulOjNVFDEC3Ql/HI52Uq1e3HF5zz0xNFYKghYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(7696005)(54906003)(2906002)(36756003)(52116002)(8676002)(7406005)(7416002)(6666004)(30864003)(38100700002)(38350700002)(4326008)(316002)(66946007)(1076003)(44832011)(6486002)(26005)(2616005)(5660300002)(478600001)(186003)(86362001)(956004)(8936002)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9bjHp5IRYkSgi8laCEsHw9E/P9dY1pQU5VxD/MnH9IkCoA6cRlGkIp2i6B+?=
 =?us-ascii?Q?/O9UcCZwkX9yYbrCm0AUqwJHc9Lxl63OvnngKhfVI1SSvCFoOE7fyQFcENJo?=
 =?us-ascii?Q?mi/pQEialaR9MCyfHi0bfDN6R8d/AYdJwoxlgoQ8GrV/lmDTu85svtkDFr1Z?=
 =?us-ascii?Q?4/gztA3vsXdNKrA1BikNsGP2JbyYrsUEF614abak2Wzsb7XO0lEiRGZgf5pe?=
 =?us-ascii?Q?IFk841t7k1ZdNTRMqSMQTnouzysiUG80IEzLEbg76OaFdA7G6cIagMzxVOMx?=
 =?us-ascii?Q?ozzDE60YOzEL2lbkUWuCOKgwAv/kTtXrU7ddanwWstyGTxD8khlnJul4WAqw?=
 =?us-ascii?Q?JLWdv+UjoQNDWagYpCe7fd3qyqRFYSoh+xWvBxiB53CadZD9PRAZ3q24ozhC?=
 =?us-ascii?Q?BbKATpNZ7yXR2Tns3g32OA44PeAvxa4pi8BZFeGJL2sFI/7d+hyFiE3KMHax?=
 =?us-ascii?Q?qvuKFVjoLYhJtBLif24rYA2g77+zITauBkdnGn/nURWaGpkyYckqQf+qsK6I?=
 =?us-ascii?Q?7DuvV+W++akes+u6zl24zHcKiIEwwKrjJ3GYpHP37DOGQeyy57mTNdq8LrDD?=
 =?us-ascii?Q?d2rmiyRl+LjYC8EqK3YXn0QPMToB9KbRCWwlonHGtN8kOxM4vFIsOQdf5HmC?=
 =?us-ascii?Q?Mbiuea4mevcJyQvtZqwX1o8HGhYlYk7YSu/RINYpKrzlx6cBXuY8sHqSKaaD?=
 =?us-ascii?Q?i8vs9p+ZDltl63Z6gm5fFPWnpi+5ZuB0gbn4FO2d5+SBALBcxaU436X3mw0g?=
 =?us-ascii?Q?TFYo/CHX7Jn+ekTmXXwCk60dWMGbqo0V9kq+sOw911IikANtFVikAQVuSbak?=
 =?us-ascii?Q?hMCBqiiKZxmP8LpHo1cVaEvGJwq56V+KZx7vsblkpqsMsj52rJuhtWNEVaM+?=
 =?us-ascii?Q?ZHzNo8PtAtOigzmmKk5YcO5GlKMuivs+G5/QvfDnyio1/AY9W4LpTODp90yU?=
 =?us-ascii?Q?NdJgaQavkvCx8M/C8JBwF4v7n2r47HKfOWjg9bdkW7g0ZYpZXNpUlrHh1rf5?=
 =?us-ascii?Q?UMZIVS1NvInYBLII3uxodafpOOILARTMvCbet7IQOI8wgEvVAkWl1eOw1kBS?=
 =?us-ascii?Q?Bl+94cUarI4RWdCmvtvxla8WgZnB1I7/UP0kzkBzlzy2fkiH1+JSu5Jnbdv8?=
 =?us-ascii?Q?+o0SVxD8hXL+AWRirDjsIt5iDkXHkIoEOi2RpVxrsKi83ODtP5MDJdbVbMrf?=
 =?us-ascii?Q?o0xeTq7NZc9BMIQXSFP4HdXMsc3dr/RL9f+RJ21nXp3KIvtGXlzOt34q/NDW?=
 =?us-ascii?Q?GsBbuC3heytWutLLZKG5XYey9DHQ04xnnF0WoefZcc5+1MYPjBEj5a8Ag1hq?=
 =?us-ascii?Q?JfU0o+CrW8i8odCXuMIfyK9r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9157387-8875-4aad-fb97-08d941766cb5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:33.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwl1Um3ZIGmSgHhcJAO5pF607lJ+0+GbWLVdMfua7F7PuicbPRGagdHLcQ1jYNF8dfKPH7LBSXv9StLYpMOL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification added the support two SNP Guest Request
Message NAE event. The events allows for an SEV-SNP guest to make request
to the SEV-SNP firmware through hypervisor using the SNP_GUEST_REQUEST
API define in the SEV-SNP firmware specification.

The SNP_GUEST_REQUEST requires two unique pages, one page for the request
and one page for the response. The response page need to be in the firmware
state. The GHCB specification says that both the pages need to be in the
hypervisor state but before executing the SEV-SNP command the response page
need to be in the firmware state.

The SNP_EXT_GUEST_REQUEST is similar to SNP_GUEST_REQUEST with the
difference of an additional certificate blob that can be passed through
the SNP_SET_CONFIG ioctl defined in the CCP driver. The CCP driver exposes
snp_guest_ext_guest_request() that is used by the KVM to get the both
report and additional data at once.

In order to minimize the page state transition during the command handling,
pre-allocate a firmware page on guest creation. Use the pre-allocated
firmware page to complete the command execution and copy the result in the
guest response page.

Ratelimit the handling of SNP_GUEST_REQUEST NAE to avoid the possibility
of a guest creating a denial of service attack aginst the SNP firmware.

Now that KVM supports all the VMGEXIT NAEs required for the base SEV-SNP
feature, set the hypervisor feature to advertise it.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm/sev.c | 223 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h |   6 +-
 2 files changed, 225 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 53a60edc810e..4cb4c1d7e444 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -18,6 +18,8 @@
 #include <linux/processor.h>
 #include <linux/trace_events.h>
 #include <linux/sev.h>
+#include <linux/kvm_host.h>
+#include <linux/sev-guest.h>
 #include <asm/fpu/internal.h>
 
 #include <asm/trapnr.h>
@@ -1534,6 +1536,7 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct sev_data_snp_gctx_create data = {};
 	void *context;
 	int rc;
@@ -1543,14 +1546,24 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!context)
 		return NULL;
 
-	data.gctx_paddr = __psp_pa(context);
-	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
-	if (rc) {
+	/* Allocate a firmware buffer used during the guest command handling. */
+	sev->snp_resp_page = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
+	if (!sev->snp_resp_page) {
 		snp_free_firmware_page(context);
 		return NULL;
 	}
 
+	data.gctx_paddr = __psp_pa(context);
+	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
+	if (rc)
+		goto e_free;
+
 	return context;
+
+e_free:
+	snp_free_firmware_page(context);
+	snp_free_firmware_page(sev->snp_resp_page);
+	return NULL;
 }
 
 static int snp_bind_asid(struct kvm *kvm, int *error)
@@ -1618,6 +1631,12 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (rc)
 		goto e_free_context;
 
+	/* Used for rate limiting SNP guest message request, use the default settings */
+	ratelimit_default_init(&sev->snp_guest_msg_rs);
+
+	/* Allocate memory used for the certs data in SNP guest request */
+	sev->snp_certs_data = kmalloc(SEV_FW_BLOB_MAX_SIZE, GFP_KERNEL_ACCOUNT);
+
 	return 0;
 
 e_free_context:
@@ -2218,6 +2237,9 @@ static int snp_decommission_context(struct kvm *kvm)
 	snp_free_firmware_page(sev->snp_context);
 	sev->snp_context = NULL;
 
+	/* Free the response page. */
+	snp_free_firmware_page(sev->snp_resp_page);
+
 	return 0;
 }
 
@@ -2268,6 +2290,9 @@ void sev_vm_destroy(struct kvm *kvm)
 		sev_unbind_asid(kvm, sev->handle);
 	}
 
+
+	kfree(sev->snp_certs_data);
+
 	sev_asid_free(sev);
 }
 
@@ -2663,6 +2688,8 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 	case SVM_VMGEXIT_HV_FT:
 	case SVM_VMGEXIT_PSC:
+	case SVM_VMGEXIT_GUEST_REQUEST:
+	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		break;
 	default:
 		goto vmgexit_err;
@@ -3053,6 +3080,181 @@ static unsigned long snp_handle_psc(struct vcpu_svm *svm, struct ghcb *ghcb)
 	return rc ? map_to_psc_vmgexit_code(rc) : 0;
 }
 
+static int snp_build_guest_buf(struct vcpu_svm *svm, struct sev_data_snp_guest_request *data,
+			       gpa_t req_gpa, gpa_t resp_gpa)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	kvm_pfn_t req_pfn, resp_pfn;
+	struct kvm_sev_info *sev;
+
+	if (!IS_ALIGNED(req_gpa, PAGE_SIZE) || !IS_ALIGNED(resp_gpa, PAGE_SIZE)) {
+		pr_err_ratelimited("svm: guest request (%#llx) or response (%#llx) is not page aligned\n",
+			req_gpa, resp_gpa);
+		return -EINVAL;
+	}
+
+	req_pfn = gfn_to_pfn(kvm, gpa_to_gfn(req_gpa));
+	if (is_error_noslot_pfn(req_pfn)) {
+		pr_err_ratelimited("svm: guest request invalid gpa=%#llx\n", req_gpa);
+		return -EINVAL;
+	}
+
+	resp_pfn = gfn_to_pfn(kvm, gpa_to_gfn(resp_gpa));
+	if (is_error_noslot_pfn(resp_pfn)) {
+		pr_err_ratelimited("svm: guest response invalid gpa=%#llx\n", resp_gpa);
+		return -EINVAL;
+	}
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	data->gctx_paddr = __psp_pa(sev->snp_context);
+	data->req_paddr = __sme_set(req_pfn << PAGE_SHIFT);
+	data->res_paddr = __psp_pa(sev->snp_resp_page);
+
+	return 0;
+}
+
+static void snp_handle_guest_request(struct vcpu_svm *svm, struct ghcb *ghcb,
+				     gpa_t req_gpa, gpa_t resp_gpa)
+{
+	struct sev_data_snp_guest_request data = {};
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sev_info *sev;
+	int rc, err = 0;
+
+	if (!sev_snp_guest(vcpu->kvm)) {
+		rc = -ENODEV;
+		goto e_fail;
+	}
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
+		pr_info_ratelimited("svm: too many guest message requests\n");
+		rc = -EAGAIN;
+		goto e_fail;
+	}
+
+	rc = snp_build_guest_buf(svm, &data, req_gpa, resp_gpa);
+	if (rc)
+		goto e_fail;
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	mutex_lock(&kvm->lock);
+
+	rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &err);
+	if (rc) {
+		mutex_unlock(&kvm->lock);
+
+		/* If we have a firmware error code then use it. */
+		if (err)
+			rc = err;
+
+		goto e_fail;
+	}
+
+	/* Copy the response after the firmware returns success. */
+	rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);
+
+	mutex_unlock(&kvm->lock);
+
+e_fail:
+	ghcb_set_sw_exit_info_2(ghcb, rc);
+}
+
+static void snp_handle_ext_guest_request(struct vcpu_svm *svm, struct ghcb *ghcb,
+					 gpa_t req_gpa, gpa_t resp_gpa)
+{
+	struct sev_data_snp_guest_request req = {};
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long data_npages;
+	struct kvm_sev_info *sev;
+	unsigned long err;
+	u64 data_gpa;
+	int rc;
+
+	if (!sev_snp_guest(vcpu->kvm)) {
+		rc = -ENODEV;
+		goto e_fail;
+	}
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
+		pr_info_ratelimited("svm: too many guest message requests\n");
+		rc = -EAGAIN;
+		goto e_fail;
+	}
+
+	if (!sev->snp_certs_data) {
+		pr_err("svm: certs data memory is not allocated\n");
+		rc = -EFAULT;
+		goto e_fail;
+	}
+
+	data_gpa = ghcb_get_rax(ghcb);
+	data_npages = ghcb_get_rbx(ghcb);
+
+	if (!IS_ALIGNED(data_gpa, PAGE_SIZE)) {
+		pr_err_ratelimited("svm: certs data GPA is not page aligned (%#llx)\n", data_gpa);
+		rc = -EINVAL;
+		goto e_fail;
+	}
+
+	/* Verify that requested blob will fit in our intermediate buffer */
+	if ((data_npages << PAGE_SHIFT) > SEV_FW_BLOB_MAX_SIZE) {
+		rc = -EINVAL;
+		goto e_fail;
+	}
+
+	rc = snp_build_guest_buf(svm, &req, req_gpa, resp_gpa);
+	if (rc)
+		goto e_fail;
+
+	mutex_lock(&kvm->lock);
+	rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
+					 &data_npages, &err);
+	if (rc) {
+		mutex_unlock(&kvm->lock);
+
+		/*
+		 * If buffer length is small then return the expected
+		 * length in rbx.
+		 */
+		if (err == SNP_GUEST_REQ_INVALID_LEN) {
+			vcpu->arch.regs[VCPU_REGS_RBX] = data_npages;
+			ghcb_set_sw_exit_info_2(ghcb, err);
+			return;
+		}
+
+		/* If we have a firmware error code then use it. */
+		if (err)
+			rc = (int)err;
+
+		goto e_fail;
+	}
+
+	/* Copy the response after the firmware returns success. */
+	rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);
+
+	mutex_unlock(&kvm->lock);
+
+	if (rc)
+		goto e_fail;
+
+	/* Copy the certificate blob in the guest memory */
+	if (data_npages &&
+	    kvm_write_guest(kvm, data_gpa, sev->snp_certs_data, data_npages << PAGE_SHIFT))
+		rc = -EFAULT;
+
+e_fail:
+	ghcb_set_sw_exit_info_2(ghcb, rc);
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3306,6 +3508,21 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ghcb_set_sw_exit_info_2(ghcb, rc);
 		break;
 	}
+	case SVM_VMGEXIT_GUEST_REQUEST: {
+		snp_handle_guest_request(svm, ghcb, control->exit_info_1, control->exit_info_2);
+
+		ret = 1;
+		break;
+	}
+	case SVM_VMGEXIT_EXT_GUEST_REQUEST: {
+		snp_handle_ext_guest_request(svm,
+					     ghcb,
+					     control->exit_info_1,
+					     control->exit_info_2);
+
+		ret = 1;
+		break;
+	}
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ccdaaa4e1fb1..9fcfc0a51737 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/bits.h>
+#include <linux/ratelimit.h>
 
 #include <asm/svm.h>
 #include <asm/sev-common.h>
@@ -68,6 +69,9 @@ struct kvm_sev_info {
 	struct kvm *enc_context_owner; /* Owner of copied encryption context */
 	struct misc_cg *misc_cg; /* For misc cgroup accounting */
 	void *snp_context;      /* SNP guest context page */
+	void *snp_resp_page;	/* SNP guest response page */
+	struct ratelimit_state snp_guest_msg_rs; /* Rate limit the SNP guest message */
+	void *snp_certs_data;
 };
 
 struct kvm_svm {
@@ -550,7 +554,7 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
-#define GHCB_HV_FT_SUPPORTED	0
+#define GHCB_HV_FT_SUPPORTED	GHCB_HV_FT_SNP
 
 extern unsigned int max_sev_asid;
 
-- 
2.17.1

