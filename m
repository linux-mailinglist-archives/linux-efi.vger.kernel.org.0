Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0E3BEF30
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhGGSlR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:17 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:36832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232460AbhGGSk4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx5AJOj89jJQrfrz15SXQdRWS2IX/vFKkBxO0PXfozRLn5FklH9JQidEfYK4MIDt4MMb3YYeMi6wrhLm5uTIawhFcjzV3E9skC8w4/in4+U1JR+jFzaVzshI0AB7f08McpHVZaywAQnWrzUQtU0J7KW3TqiVf3k0YgkCruTBvgP+qgdthXEjb8IRN5TwJgVEd5u8PxmDl8q73Wlzm5DX96N1uJTb1R2fIVwwkjT1OnqaHGhqRsmRs8INyCEOTrXdglQKuN7zjIBAiT5vUER7CcJUIDrduhRwMI9cN9R3oYBLkRH7IJXtEei4j4XSSPRHmc+cQZxE6xNm5LH59UiL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVy7UHYHmjBJjZ7Yp20CGnjTrh5VaC01HKwed8xthz0=;
 b=AoCA/6Wtj4st9D5nbScyQ5eAXWBzGdB+xs6xdfMMn4MZHIsa8Po0rKcCkLIamZEfE6GpZJAyh53pjkDjte68FVJsNJcKjaqOdY7Ru76oo5UE637F9lB9cLl1EM8bDIslQtTOYNb5XTuUw81Q7Ebe5TRyZaxJX1PhjzZClWHr9run+sRbo/ZZ5D5hfmqRf3jwXLbudH1Yo4Vt8Rm/u2jPZDZqcgScgXwPP/F0Kh/J7YA7lO0o6Pxx3PTzlX9Hmhvl7hntm4U52FRqAcUCynnDBASnd1V2t7GSC/kaMBGNEVRFnoiYyL339yw7UO73oSrMWdk2LOJrf1Yoy0M+ih11uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVy7UHYHmjBJjZ7Yp20CGnjTrh5VaC01HKwed8xthz0=;
 b=0+6JYILSf5O4nQ1u0p/msmjhZyWX/FiqIwtnpytGGORvg6bJfysaH2mMNMmt9/LBAtEnzYokHn0eIJ9+PoFnHU3Rda3vpZjHF4/REti8h+hvBVYbv+Vq8cCgKhdkY6h64ugenYu7ttt121htv7OCQhcgoTOttQc+5Z3/jQeS90I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:02 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:02 +0000
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
Subject: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_FINISH command
Date:   Wed,  7 Jul 2021 13:36:02 -0500
Message-Id: <20210707183616.5620-27-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c7432f4-40a0-40b2-a04c-08d9417659de
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB408289C3E3AEBC21A4EB5384E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIVyiPl8MaoJrLi5YdZlAe+Bb0nuOaAlFcE2FuIky1u2Ks66E6gRnckj51gNtPz0hNjwsT+8Xc1xA7Bt+U0iO1D3UvFg+4ik1sIvsxhylaubrApAbWAA57t2hc4r6BRS8ld4uYJdfHcOHBHXpBYnXy+Gt0K+rzHgvCVzsufj+n5AdP4O/VY4DlQ/8KKp5emji0ud3SVUj+s/13ZwFNGPlhENj87zcIbJ8BA0jar+JQzf9aVZCCMAq9lp4zEm9BLLsB0TFbbrPCD0a8v3NeONHeECz+vqHtfWRxpIUcWbW0MOYpqqjCVkkmqcT8SuH5RiMDeh6A1CGLQ8qT/iB7VxyHYs/g518gq58ueIVpAsR/8RtSKDrzF97WLAy3OkliKI7ggk2BlzaWxFEVRw8kJAbDfclfyEdDSOxlKioNvEeG8+T1Qhi/rxGOQSqJoL6Q8eQIB/wsg2RslZ7Z34MdDah5i5eQ7AE94/MfK3cyLuCAiheIkoN9gJEOc2pTB+pQBBkWp6TOp49wwXc4xwuByrwWg/vRbVQmHEkCAvNXSPCHneEInQF1MuWq52KW2gztRQflkSquk+G2jMSLlQs3uazZwZp1YNTUj3zP2HvTOcA5ZspfWRoa2CIu7PqmjH0jE0OzQX4Ib5ECOD8wfgVJegx/UvJGIwSbJxP3rgMq7NjDYczvoEqDUXQW1eFszziFhH87tiPQ0DpOUus5TxMBA6zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ri/fH+bAUKa8w2qz/p+bxk+MJ92bkfMIh6U9rdVMsJNmT1zKJpk+k8p7Arx/?=
 =?us-ascii?Q?ZKFk2bcWxl5Gg9oh+oVwE7eEXm4cBSobdWhiOLxqEviVlz81MMw6cOsdnWNj?=
 =?us-ascii?Q?+h8srw/6jfm3mbp8Blwst8wTnXldOeVPs6a6SacPfRaWWDmQBUZrb3Bnbrvl?=
 =?us-ascii?Q?+2NGRpbOLiz11EyCK448XuCZm4yneGI5Wt6Lz0oBLktg8arEHfWusoc/UAiz?=
 =?us-ascii?Q?ricJv6Z+rT8/8hh27sxByDqZ3ArvOafh9774ewlAxDDyEa4BnmAopPpnSeax?=
 =?us-ascii?Q?RlRurMxJeK0cJmGBrLmxrBTAZ2qo0huuGh8LmUQAyMtd2Z6f0MJFXOy21Uuz?=
 =?us-ascii?Q?BD/tMCVDIwQAsHPyuw35QMzDsQ9UKyUfBW3DeWrR39Ia7DTUqaSyI4QoVRJy?=
 =?us-ascii?Q?/2ey9Q+MGGtb8jxxw/Pg1A2U5RYdkwazD3C8ppyg9MjIoLExIKNFuZpUH52X?=
 =?us-ascii?Q?9B8LNpPA5aJ0qnnZdIypEzxcWOu+XzoZCUzy1HtojvTAqg1aPUfF3Un4yicW?=
 =?us-ascii?Q?kSIH71mco0RPtdDiyGij1cfgLNFZ4iiVua9xV5BWCvorof+8NFQd7rmDBSb6?=
 =?us-ascii?Q?I9jG0IuXM9LRdqXXyU/gTKUto6pEbz9MrMQElf2q4KpvxbVnQ//Lfcoj1+r0?=
 =?us-ascii?Q?3W51Tg+I73kC4LD2bbJ4WoPFFADEEWsx3GhEZgZ06oR5Lbf4+/kiwmX+08Dr?=
 =?us-ascii?Q?4tUub9OrgIzRFuSPmMa3S7vAWDH46V/rkzVOq/mulP6bcJlR8CPi8k2t/M4T?=
 =?us-ascii?Q?Qhl9lPNsLISLiS+aG0f9IIYoU0FRK5kcUatHktA1SKJZ+a93VaI0q1D2OPMa?=
 =?us-ascii?Q?DUqwk98efyRxtNHWIsKNmE+mUTgUeTmvDZApjhKU1n3kmhWmGE1w8Ug3HCkP?=
 =?us-ascii?Q?zDQYy3YhYrknPHlrMwgY6nRe9YV9jEngdt7N/OeMnu1k6hRyFx8ByxWVfyro?=
 =?us-ascii?Q?CJSk1BUfV6/mu9vvLM2KwHLcnXM/7XeL+C6DwUsVcFsTRkQrR13LeJbXkt0y?=
 =?us-ascii?Q?TzTk4y1V8BaGeGI0vkOznxUernYMim6Cu0Yr4KM7YC3qgti11j6dmZVbk+iZ?=
 =?us-ascii?Q?lDgadQLBVrkCwxjrLxlgJ89zXlr4m4mnNEK5kUtFsMV112/81VyKUG3Z3Wgu?=
 =?us-ascii?Q?Vge+xpyE45ZxEZEA/t/RhYJQSX6Plh8RTbFH0uj9kysb3MzQK6/UZf5l9Yqg?=
 =?us-ascii?Q?v5+WUg/53l6JLVMyWf02lmjSFd1QU5h094IOnwmNI5ThnY51pSzfoJGIZ4R5?=
 =?us-ascii?Q?W1PSZtV1c2wL3bcEgNlD7wdYYnVyKg0vn+jD83Prv7buB1v1OlvxI1aghszG?=
 =?us-ascii?Q?lk29HpXj/6JMvRQGrZn4DHzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7432f4-40a0-40b2-a04c-08d9417659de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:02.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKpPk0YWgPeTOpI4RqIDj+FzRZpCY7666KAySqgwWRKiuF3BpqeJk7Rdx9L6lhiGvAh96KIvctXvZJlYLeRRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KVM_SEV_SNP_LAUNCH_FINISH finalize the cryptographic digest and stores
it as the measurement of the guest at launch.

While finalizing the launch flow, it also issues the LAUNCH_UPDATE command
to encrypt the VMSA pages.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../virt/kvm/amd-memory-encryption.rst        |  22 +++
 arch/x86/kvm/svm/sev.c                        | 125 ++++++++++++++++++
 include/uapi/linux/kvm.h                      |  13 ++
 3 files changed, 160 insertions(+)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 60ace54438c3..a3d863e88869 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -495,6 +495,28 @@ Returns: 0 on success, -negative on error
 See the SEV-SNP spec for further details on how to build the VMPL permission
 mask and page type.
 
+21. KVM_SNP_LAUNCH_FINISH
+-------------------------
+
+After completion of the SNP guest launch flow, the KVM_SNP_LAUNCH_FINISH command can be
+issued to make the guest ready for the execution.
+
+Parameters (in): struct kvm_sev_snp_launch_finish
+
+Returns: 0 on success, -negative on error
+
+::
+
+        struct kvm_sev_snp_launch_finish {
+                __u64 id_block_uaddr;
+                __u64 id_auth_uaddr;
+                __u8 id_block_en;
+                __u8 auth_key_en;
+                __u8 host_data[32];
+        };
+
+
+See SEV-SNP specification for further details on launch finish input parameters.
 
 References
 ==========
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4468995dd209..3f8824c9a5dc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1763,6 +1763,111 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_launch_update data = {};
+	int i, ret;
+
+	data.gctx_paddr = __psp_pa(sev->snp_context);
+	data.page_type = SNP_PAGE_TYPE_VMSA;
+
+	for (i = 0; i < kvm->created_vcpus; i++) {
+		struct vcpu_svm *svm = to_svm(kvm->vcpus[i]);
+		struct rmpupdate e = {};
+
+		/* Perform some pre-encryption checks against the VMSA */
+		ret = sev_es_sync_vmsa(svm);
+		if (ret)
+			return ret;
+
+		/* Transition the VMSA page to a firmware state. */
+		e.assigned = 1;
+		e.immutable = 1;
+		e.asid = sev->asid;
+		e.gpa = -1;
+		e.pagesize = RMP_PG_SIZE_4K;
+		ret = rmpupdate(virt_to_page(svm->vmsa), &e);
+		if (ret)
+			return ret;
+
+		/* Issue the SNP command to encrypt the VMSA */
+		data.address = __sme_pa(svm->vmsa);
+		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
+				      &data, &argp->error);
+		if (ret) {
+			snp_page_reclaim(virt_to_page(svm->vmsa), RMP_PG_SIZE_4K);
+			return ret;
+		}
+
+		svm->vcpu.arch.guest_state_protected = true;
+	}
+
+	return 0;
+}
+
+static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_launch_finish *data;
+	void *id_block = NULL, *id_auth = NULL;
+	struct kvm_sev_snp_launch_finish params;
+	int ret;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	/* Measure all vCPUs using LAUNCH_UPDATE before we finalize the launch flow. */
+	ret = snp_launch_update_vmsa(kvm, argp);
+	if (ret)
+		return ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL_ACCOUNT);
+	if (!data)
+		return -ENOMEM;
+
+	if (params.id_block_en) {
+		id_block = psp_copy_user_blob(params.id_block_uaddr, KVM_SEV_SNP_ID_BLOCK_SIZE);
+		if (IS_ERR(id_block)) {
+			ret = PTR_ERR(id_block);
+			goto e_free;
+		}
+
+		data->id_block_en = 1;
+		data->id_block_paddr = __sme_pa(id_block);
+	}
+
+	if (params.auth_key_en) {
+		id_auth = psp_copy_user_blob(params.id_auth_uaddr, KVM_SEV_SNP_ID_AUTH_SIZE);
+		if (IS_ERR(id_auth)) {
+			ret = PTR_ERR(id_auth);
+			goto e_free_id_block;
+		}
+
+		data->auth_key_en = 1;
+		data->id_auth_paddr = __sme_pa(id_auth);
+	}
+
+	data->gctx_paddr = __psp_pa(sev->snp_context);
+	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_LAUNCH_FINISH, data, &argp->error);
+
+	kfree(id_auth);
+
+e_free_id_block:
+	kfree(id_block);
+
+e_free:
+	kfree(data);
+
+	return ret;
+}
+
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -1858,6 +1963,9 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_UPDATE:
 		r = snp_launch_update(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_LAUNCH_FINISH:
+		r = snp_launch_finish(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -2346,8 +2454,25 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.guest_state_protected)
 		sev_flush_guest_memory(svm, svm->vmsa, PAGE_SIZE);
+
+	/*
+	 * If its an SNP guest, then VMSA was added in the RMP entry as a guest owned page.
+	 * Transition the page to hyperivosr state before releasing it back to the system.
+	 */
+	if (sev_snp_guest(vcpu->kvm)) {
+		struct rmpupdate e = {};
+		int rc;
+
+		rc = rmpupdate(virt_to_page(svm->vmsa), &e);
+		if (rc) {
+			pr_err("Failed to release SNP guest VMSA page (rc %d), leaking it\n", rc);
+			goto skip_vmsa_free;
+		}
+	}
+
 	__free_page(virt_to_page(svm->vmsa));
 
+skip_vmsa_free:
 	if (svm->ghcb_sa_free)
 		kfree(svm->ghcb_sa);
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c9b453fb31d4..fb3f6e1defd9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1682,6 +1682,7 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_INIT = 256,
 	KVM_SEV_SNP_LAUNCH_START,
 	KVM_SEV_SNP_LAUNCH_UPDATE,
+	KVM_SEV_SNP_LAUNCH_FINISH,
 
 	KVM_SEV_NR_MAX,
 };
@@ -1808,6 +1809,18 @@ struct kvm_sev_snp_launch_update {
 	__u8 vmpl1_perms;
 };
 
+#define KVM_SEV_SNP_ID_BLOCK_SIZE	96
+#define KVM_SEV_SNP_ID_AUTH_SIZE	4096
+#define KVM_SEV_SNP_FINISH_DATA_SIZE	32
+
+struct kvm_sev_snp_launch_finish {
+	__u64 id_block_uaddr;
+	__u64 id_auth_uaddr;
+	__u8 id_block_en;
+	__u8 auth_key_en;
+	__u8 host_data[KVM_SEV_SNP_FINISH_DATA_SIZE];
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.17.1

