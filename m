Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63B63BEECA
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhGGSjn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:39:43 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231565AbhGGSjm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEeKLRJ6ZCj0bdjEgzizA/qwGAsfm5ls0Y2V3VRRsgQAuWgbwRHDxgfOI0WI8nLmjxgPisQEoe4lOgTxWkTYLOl22YlR8hnFg3d49UL4JNV1YGWC7MXEsg1MwZmjZ4201EwXWRJ3nh8GzLx9Q+pblDiSXGi1zuXx8d0rcREP0HeUvQp+q7obca4Ens68hCuzs688udRfllvgpg+SBMtX1gS1RTL37DS6+v1nbA371GKtoH10wXYfVv+9bzc0LitfPUS2ZSIqbMUbbZJg6tczVeJ6M+N+Twdnd/p9V14d73RBJWDG8p2Yq356zGt1nRnuZHejRNcCnE6cf2huYBnksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXH5HW/KDCpVT6Zv52rR3hjU8bSJ936r5BK0xZPlpxE=;
 b=l/qskc52+p0U9hdG/RfM6Nq1whyBSNMWx4bqBrqtBeRoz42pLtBa5qoUByp418Ze+NbkOGd2CeaKesED1cBpTbfvsCLskWjMACPL3iXWkWn4DC7KTTBzPRdVu7tRv4yinBeYDgZe773hJxXSaFQzuvMUbK1Sg+acim7hj/w0L9CbgBCDocEcRJA0QsA6+36ZE0UyXHlY/JNViT6qGSa9682CjuqAQ6RK9XmRhXsc8QPjakbq7RqecATwKnlzSpDcVhZUxiR+CyvuvzGemDGFYsREEbH1MZh6u9Y0Mj/pgZ6wrViRtb9VIRg5M/YnkgfNZpc/5ORIbUI4Q+mjdUC/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXH5HW/KDCpVT6Zv52rR3hjU8bSJ936r5BK0xZPlpxE=;
 b=akWiQuAyn1ehZmnmLfzJQxmO/i0O4+lv4MuZSwrGvvyS8afNkxE0gH1lQgGC2GwLZAOnDp8vaBIPtMURawlp1RPVh9ShEOi9wZfEyOse7TcnstV55+AJYIQDwOHVrln8fngq9esNOZG/RLYG/B1PxXPMsC48sRW4qgcHAXBMiqg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:36:57 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:36:56 +0000
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
Subject: [PATCH Part2 RFC v4 01/40] KVM: SVM: Add support to handle AP reset MSR protocol
Date:   Wed,  7 Jul 2021 13:35:37 -0500
Message-Id: <20210707183616.5620-2-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:36:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e3a0a5-f6e6-492d-2795-08d9417632f6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35258C45D450F24EBD3F36D4E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhmTUG8sifLX6Uf6tu7GJoobwBrL033T5zI9wKp39l3i6TUgoxy4DW8vYQuZiDxsodm30IT39sjrBhpGA0HHOaIgxAeOSMtmYaNYkkhJmAQ4Key/+eMvYTjITBO+D7TnnRi5Ft7D/slZ3Z8nLPlutIC5U+QttD0qPOcfg1jN3urjhCBy6WcJJ1b14hasf2EPAghw/9HA77QW3f4C2tlq6Vpkg0L9c3ZaQFscF7XX5QWgE6nEwABv1ZIpLSbdeMAmieY5LrOGjY+WBpq9AApu+pMSBGrc6niqsuZutnVJYQA//mbi/BLfaguI66hX+c9efinY4PsKnz0EYDicLUfFsWV8y11djqtQxfagzRDaYel9f+GY2k5ENxuQIEj37i/tzzo+wOGMrS0NtoHAt2S8DEKiX6TZL8hUblyHB309Fl33Sq7AUNZUWSo7SvYkAg+rg2KqSF3WpOZLWHtWCF4GZkPVHPQS4HjETEi/FPvWL8+gBQmG8PLPy3o2c0lP+dOLAFbnsaDvj5y1vJS8Mk8hZKgAY4UZ6f+ctQe36nFIEiS/hZzMsvOPvWhuq0gzsVv644RtuqdOuG0RN/pegePWKUQlktv33mLssSy60XSbibITxcolz8xwzE+qsvWncmxz7BpUeVcpFEaoqsRfZ1iXJcMTJOXb6J6sNZK7qrcKfB16M1GUypCMDsO6Dvy98t4zMkbjy4PETAJG33EDcF7/8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWHZNBW7IIUjrrv8iMjy4gLbCXIoIDUBxulk6A+Wsyn/2ty+N2Leu3uRxCW+?=
 =?us-ascii?Q?wzDZ/scNfRa7d1NPMZfBWGUiG59HiPcsOJXpFu7ZEGvAQYea77vyDzV6ilVK?=
 =?us-ascii?Q?lEu2Fx4PX1oeLuggXM5ogUOiGvIoCvO4Qb5YbRoqcPkHwZ2t6uGt38kAqhbj?=
 =?us-ascii?Q?9gJQfEb5k37LYy5ZaasyYcowfuchy8q7eBljc42BxEitM+ot0GaGfN2bmJzS?=
 =?us-ascii?Q?ykRJgl/gF4TeruH/oFZNEb4aBLzSh/wRhHOJCQn2KgAA9QrVhOai0qSMxvFj?=
 =?us-ascii?Q?g+TsQcXaeq1JgkshrLEq37bjuiq42uGQvczb41vIOO7VGqc9nNZxk0WCIDzN?=
 =?us-ascii?Q?v7I+Fo22bPwXfDEYyLfPknxRfAtjU4xxPcSDRvHnr835/Sa+f8wz55V26KbD?=
 =?us-ascii?Q?2+6tseDQkBELmu8/bBZtaJNCu5Ti0uuIaLcedhSMXO98LpjiZcx05ysLPvVk?=
 =?us-ascii?Q?1/Hcrpa0qOmKhSHxAj+a39tluhA2ZQkZFL+h49gOMoYmpSN6wWMfwh0qkuOo?=
 =?us-ascii?Q?d43G6rxpUn+7n+x4GkIj2oftSmj+DsjL5CqNhV6vpToRHCeJL6B9QhjZYceG?=
 =?us-ascii?Q?yOAX4GQT4PLvF2K6UPyrNx7DfALP/T3bFH3KIW4FuXXQ8IXgW6Hka1Jfaq5z?=
 =?us-ascii?Q?l/LzSINsBRniqv5MRTw3EBMJd1QlYvtwbATxVkrHbgQUkJb1WeXIluOz47MU?=
 =?us-ascii?Q?W5az39GRKwqxNhL8ZG5LcCsID837iXfwvJONXZXorp79l4P0xryGy3IVkogN?=
 =?us-ascii?Q?TfIRKZVWVAEjvozSM+CUQef/sH8waopu/voM+jGyoXCrf3r4XYLyW4ylHBsv?=
 =?us-ascii?Q?SL+f7vlU9i3gYu/fjeCRtPSqtr5GcT6Ym6YhlS1GT7PsqMqlOWiWpksX2khZ?=
 =?us-ascii?Q?26p0gYw3HwqDd8C63ikttnS3P+KwjD6Ha14EKiQ9PK7p8Uuu1bND+nGmLdlF?=
 =?us-ascii?Q?HnJDVpbXQ0jLXmSix7RZxCt8Y70CxnILYgSf0MDiaoipz7P82r9QYuckcDQ9?=
 =?us-ascii?Q?6uRdZFo4S4sVQFbWIkbCrJZ27Se5pKiYlYJybLmfNVR8I1S2LmQP5NuFxScq?=
 =?us-ascii?Q?J7H4uH7YGM5YzjYKCvpjsEYjpnsrwqxEwbNWved+2vy1iKYUVqmTYGJY38Gk?=
 =?us-ascii?Q?Jk4MTy090NWMI0sPq5o1JTgTte2atgPpY8QhVg79k9A/R0fuZY3AOAI41xjU?=
 =?us-ascii?Q?u03aHv7xVHdOeBTIdFnTOG0S/w/njWaA5v6sjBklH21V4H/2L9859pgHsOIR?=
 =?us-ascii?Q?XNPZymaUsH+IQT+Q/6EpS1u1/+Xg5Fc9jK+Ope8I60FiBk5YF1961NelsZQC?=
 =?us-ascii?Q?FsyIVSzlgIFXebngK846QBz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e3a0a5-f6e6-492d-2795-08d9417632f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:36:56.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj3qTCrFc7wBePwhIAcNHLNlhzSnOcLe/uNvXtn9NHEbmGmbdOj9bnxQ5rrqfeI0AnSWJPPvLhKfhjmLG07EJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Add support for AP Reset Hold being invoked using the GHCB MSR protocol,
available in version 2 of the GHCB specification.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  6 ++++
 arch/x86/kvm/svm/sev.c            | 56 ++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h            |  1 +
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index e14d24f0950c..466baa9cd0f5 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -45,6 +45,12 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* AP Reset Hold */
+#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_RESULT_POS	12
+#define GHCB_MSR_AP_RESET_HOLD_RESULT_MASK	GENMASK_ULL(51, 0)
+
 /* GHCB GPA Register */
 #define GHCB_MSR_GPA_REG_REQ		0x012
 #define GHCB_MSR_GPA_REG_VALUE_POS	12
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d93a1c368b61..7d0b98dbe523 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -57,6 +57,10 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 #define sev_es_enabled false
 #endif /* CONFIG_KVM_AMD_SEV */
 
+#define AP_RESET_HOLD_NONE		0
+#define AP_RESET_HOLD_NAE_EVENT		1
+#define AP_RESET_HOLD_MSR_PROTO		2
+
 static u8 sev_enc_bit;
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
@@ -2199,6 +2203,9 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 
 void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 {
+	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
+	svm->ap_reset_hold_type = AP_RESET_HOLD_NONE;
+
 	if (!svm->ghcb)
 		return;
 
@@ -2404,6 +2411,22 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 				  GHCB_MSR_INFO_POS);
 		break;
 	}
+	case GHCB_MSR_AP_RESET_HOLD_REQ:
+		svm->ap_reset_hold_type = AP_RESET_HOLD_MSR_PROTO;
+		ret = kvm_emulate_ap_reset_hold(&svm->vcpu);
+
+		/*
+		 * Preset the result to a non-SIPI return and then only set
+		 * the result to non-zero when delivering a SIPI.
+		 */
+		set_ghcb_msr_bits(svm, 0,
+				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
+				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
+
+		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
+				  GHCB_MSR_INFO_MASK,
+				  GHCB_MSR_INFO_POS);
+		break;
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
 
@@ -2491,6 +2514,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_IRET);
 		break;
 	case SVM_VMGEXIT_AP_HLT_LOOP:
+		svm->ap_reset_hold_type = AP_RESET_HOLD_NAE_EVENT;
 		ret = kvm_emulate_ap_reset_hold(vcpu);
 		break;
 	case SVM_VMGEXIT_AP_JUMP_TABLE: {
@@ -2628,13 +2652,29 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 		return;
 	}
 
-	/*
-	 * Subsequent SIPI: Return from an AP Reset Hold VMGEXIT, where
-	 * the guest will set the CS and RIP. Set SW_EXIT_INFO_2 to a
-	 * non-zero value.
-	 */
-	if (!svm->ghcb)
-		return;
+	/* Subsequent SIPI */
+	switch (svm->ap_reset_hold_type) {
+	case AP_RESET_HOLD_NAE_EVENT:
+		/*
+		 * Return from an AP Reset Hold VMGEXIT, where the guest will
+		 * set the CS and RIP. Set SW_EXIT_INFO_2 to a non-zero value.
+		 */
+		ghcb_set_sw_exit_info_2(svm->ghcb, 1);
+		break;
+	case AP_RESET_HOLD_MSR_PROTO:
+		/*
+		 * Return from an AP Reset Hold VMGEXIT, where the guest will
+		 * set the CS and RIP. Set GHCB data field to a non-zero value.
+		 */
+		set_ghcb_msr_bits(svm, 1,
+				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
+				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
 
-	ghcb_set_sw_exit_info_2(svm->ghcb, 1);
+		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
+				  GHCB_MSR_INFO_MASK,
+				  GHCB_MSR_INFO_POS);
+		break;
+	default:
+		break;
+	}
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0b89aee51b74..ad12ca26b2d8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -174,6 +174,7 @@ struct vcpu_svm {
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
+	unsigned int ap_reset_hold_type;
 
 	/* SEV-ES scratch area support */
 	void *ghcb_sa;
-- 
2.17.1

