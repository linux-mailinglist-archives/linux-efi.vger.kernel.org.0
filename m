Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182E3BEF46
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhGGSl3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:29 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232561AbhGGSlI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYh1qB9T30AVgyc9Joli+jvdGDBeCzTmnO6zmTwfGgVv6TpPt20XrGAk0vSa4N6GVujkMjHX5q3e2mxVb84vLCk7NeZwbum4DCg15Ik1SW93pBHOmEhzBHRDkV+H3llsLJjMOqzegFCpVvwWnZOuYdFcOfLcaTkrvgnRvoJfw7d4Y4BmaMWUZt1CD1j+Y7pq1PyHx4w+vwtQm3cIavE7UHD9awGjfxTkCUaOxVTUUKfFVUCqzR5vzEDkIgVP+Y2Ccw4cXyEPhlGD5R2iEb8gxMi7tmDcndOnsf43d+akJxB/i2q2vwNN2hy54yFyfR47V6vP/Ari0R89DHq77fjgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvMlsfQpaPzh8sw3rRnK68ziGc8ZpmAC5O4Vs8R5wkI=;
 b=QWamKBXYJ50yy3QAHeyO3cBQLgT36VBWNwwdvdZDGbMxX752mVS+h7SZCEY+5Hflpc2ER0lhHYAwp3pjlN15TT6j3E5LGiwSAsqFh9ddPnAttd3MT+u/X9p8oAokFiVK1J7lzXZSWJXuAB4ZhAMhtJKGBQVecggJOr7EZo6viQQDspPXoj2GgnTCYlaQZp1O4foi3/yrlov/093SMZf53hTdniZjq6uCv9n3JCOFQhDl14XaOwX1h1ltTq30qegKmVI6QkTDY+9ZPTpCWcvNNFc1PxXAj/kIB7mrd7/Gj61LCqt1XDwO8A9Oxnaa8p3wWFhFAEMySJWnKxYrWH+UQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvMlsfQpaPzh8sw3rRnK68ziGc8ZpmAC5O4Vs8R5wkI=;
 b=dLg/FHAp5HMPsFrKEidYahhCX5oZVONOqMYArg4Ibs4i9dsOmngX/VzoCu/pr15Qw2EiIeUMPcVPdI5N0t5PEzulDAXHbkz1qrtfKK58HRCisradhSROYW7fmtpMc1FQxYiHzi/Xp3YaxOEfnzNdnc6JeCnlzjSPgjNaF3UJ7IQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:49 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:49 +0000
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
Subject: [PATCH Part2 RFC v4 21/40] KVM: SVM: Add initial SEV-SNP support
Date:   Wed,  7 Jul 2021 13:35:57 -0500
Message-Id: <20210707183616.5620-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58fbef8-e9e1-4020-0309-08d94176524e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28085A5C81EBE4E70C115294E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3bcZLGf2BKkJO26MZswVZ9Y5cZxnG0Awn0oC41QBW0HcSs914Y3Izr//eKRPGMW2Xbrb4JexwPfhpzvGGiPjXg0+OGV930JaX6nebycfbRul1WAz22OtbIgEAQMD+YcGVRp6r6eZZgfb2axm2Af9fzgXg6KZg5NmCaJXEEFO9JnetXsHBforsopDkB/fHXXJCEKUriUBceB1rDc2t98g+qSXtwjgG0KPBZ4F8jFKb72/Uc5LxGI+nBKRsWvplooSJcixuowCpNvMOBsucN70at87GbqrgyObtsjf1o3oSrpYbqyFnSfWgJczkGAlRX9S8MvE+cy1Tg8GtiFxjVlm8qGO+1Fuq5IP39fEcf2rUGDCoxzp7F7S3M477iOAc4Y/RKO0EAmtwcr9cG5TWKLJtmpq0UVymvgGXN6WZej7T9gfWsq4dzb89Lyoy0scoJQYnQ9+6zEqYAVe/G9YvkDVU23sQuyak8WPWldHO+V1Xrxwqa/fzP/G97Eyks8zUMxcCiIFv8ddVKU1rDjlrTRInBkM8w/RB8H/6HMuSuGNX0mPP/Y64scuef4MDOmwQR7n35+9e5MwPOcyls9S+MafgoyB34lTZqD/caDt7MZXt8hkQbhHZ/hUcbc0rfTisqLy/4aoX/GU3HxoyY+taRjWrm1U2tPK20PFBif38/sZx/MuZnru18y0vQIlfbw3WsoVpIzhaunRjUE2Cc9SxvP5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybNbZ9y8q2514GWmHMcbeCmMLNO94l76QiUOMWMtX8UZyCZ5LbLM6gvLTixI?=
 =?us-ascii?Q?hLkmkgIKxRxnHPU2xwt33l3+ZVZkzRmkdb+bB4UjVYrjMKO+grp4W+VtbzfC?=
 =?us-ascii?Q?5dFMUcNnAp5N+uiqFUauQrIRd1bS7S7MFUchN6xULl1UQULynWUVxqHNpBAR?=
 =?us-ascii?Q?+cTA9Ge2qrCPPJlZxw31CZmUCplkElJmIiQn1Qo5jVF2WWRUpGAxlgDTVudy?=
 =?us-ascii?Q?klQ+pSVAmTRHg8yyiKUM/iYaCH50cTyUQId9cDZlIYLr1I8A1AK2Sok3sp4S?=
 =?us-ascii?Q?9MK1dl9vBo0wQZGaDkYL1+lXlX5nTQSUfNmiIZhtCG+YGf6sf8ImcsVg2zPk?=
 =?us-ascii?Q?yzCBzjMoCsrohxHYvu29mYN3b21aN2SMk83AZeyqZgN4wF6obT2+hzaNWd/m?=
 =?us-ascii?Q?3afIMOys6FLw4Lf9YjgyyakFOUyn7LOzAYV1Fmlcr7+XkqgG31LtbyH8dIHU?=
 =?us-ascii?Q?6655y1sVw/yp/tyqVhwexdLQ08VwrAYYjQoRUelY0SCKi2+dpkIKo3cUYPye?=
 =?us-ascii?Q?It4yMd33ZgtIN84mwbbm4Lh2t956wleyADqEHquK2dsXSKnEvBY1OegaP+dn?=
 =?us-ascii?Q?I853jSx/ewshXZ4HVdgcpt6+/mHUXuZ5P09oN2thdkhVAANQvifh1eAomqBw?=
 =?us-ascii?Q?Djj38Cv63NsULY5ejzlOi5i8wg6CTo3WSKS9rCFY2g9IuJ8wUb7648V7GEZl?=
 =?us-ascii?Q?sPWARLbvBAktl9W6iqRx/WEdI63FxUJ5/1m3yrR5bcJrmHpxbeqrP6SO+12d?=
 =?us-ascii?Q?QD000i3J8uSPh9Jg0I9ubJ0YmgI2gK6pdKiUakY1cXBYoRz8bkexxRIhPTgT?=
 =?us-ascii?Q?qBtvBXE8kdymd//38wogBOir3zdSGDKIpOlB06m9fxKE6bIBvjBdrB4SIywW?=
 =?us-ascii?Q?6iMpcujCKsPN+c2EtPiMYuU8RE0iR70REqw4EWDVjjA1jRKKLMaamnpbAc/9?=
 =?us-ascii?Q?cHeGC6RSLQZ4prJdEdsZJAzTop9mTlXpJ+wU4gcMqQYfSAb5u7XKWJAxX8Kp?=
 =?us-ascii?Q?ATwki7RHOJ+r9N1PwSt5VM6VNr5QgaQiPzpiZDlSwxDzlQsi5UmLt9to0Nsu?=
 =?us-ascii?Q?Z/gbFg1lDS5rAMkIfTUsjgNKKXlaE253ejQP1F8djqUW12fYqCNlm1JOups0?=
 =?us-ascii?Q?kRRV+0cjFrU0oGrqsxzl5an0PCI95kHZn+ovB5Hwse5PFc8GlQW916x7vZsS?=
 =?us-ascii?Q?FLXKMt2Jo2/T1dhukHuMMyQlwCngHubsnrTZeOl+ypsdGviK6gorxRTNsnfi?=
 =?us-ascii?Q?UobpihwAe4F3KvCCekn9rY9T2jK/nR7U6hTtjbtylaF2rhpr3ryzUH1sQvX0?=
 =?us-ascii?Q?y3UCvRM9iHXuk2CtYWElO/KD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58fbef8-e9e1-4020-0309-08d94176524e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:49.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulrQwVYovN6ZCEjIJO+bzWhnauyQNgsq0jNT6HK+KUc9ZhnhgPzAea7Z6G2msYBFquM4d2wZ/cYWs4+EM+L/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The next generation of SEV is called SEV-SNP (Secure Nested Paging).
SEV-SNP builds upon existing SEV and SEV-ES functionality  while adding new
hardware based security protection. SEV-SNP adds strong memory encryption
integrity protection to help prevent malicious hypervisor-based attacks
such as data replay, memory re-mapping, and more, to create an isolated
execution environment.

The SNP feature can be enabled in the KVM by passing the sev-snp module
parameter.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm/sev.c | 18 ++++++++++++++++++
 arch/x86/kvm/svm/svm.h | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 411ed72f63af..abca2b9dee83 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -52,9 +52,14 @@ module_param_named(sev, sev_enabled, bool, 0444);
 /* enable/disable SEV-ES support */
 static bool sev_es_enabled = true;
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
+
+/* enable/disable SEV-SNP support */
+static bool sev_snp_enabled = true;
+module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 #else
 #define sev_enabled false
 #define sev_es_enabled false
+#define sev_snp_enabled  false
 #endif /* CONFIG_KVM_AMD_SEV */
 
 #define AP_RESET_HOLD_NONE		0
@@ -1825,6 +1830,7 @@ void __init sev_hardware_setup(void)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
+	bool sev_snp_supported = false;
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
@@ -1888,9 +1894,21 @@ void __init sev_hardware_setup(void)
 	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
 	sev_es_supported = true;
 
+	/* SEV-SNP support requested? */
+	if (!sev_snp_enabled)
+		goto out;
+
+	/* Is SEV-SNP enabled? */
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		goto out;
+
+	pr_info("SEV-SNP supported: %u ASIDs\n", min_sev_asid - 1);
+	sev_snp_supported = true;
+
 out:
 	sev_enabled = sev_supported;
 	sev_es_enabled = sev_es_supported;
+	sev_snp_enabled = sev_snp_supported;
 #endif
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1175edb02d33..b9ea99f8579e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -58,6 +58,7 @@ enum {
 struct kvm_sev_info {
 	bool active;		/* SEV enabled guest */
 	bool es_active;		/* SEV-ES enabled guest */
+	bool snp_active;	/* SEV-SNP enabled guest */
 	unsigned int asid;	/* ASID used for this guest */
 	unsigned int handle;	/* SEV firmware handle */
 	int fd;			/* SEV device fd */
@@ -232,6 +233,17 @@ static inline bool sev_es_guest(struct kvm *kvm)
 #endif
 }
 
+static inline bool sev_snp_guest(struct kvm *kvm)
+{
+#ifdef CONFIG_KVM_AMD_SEV
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+
+	return sev_es_guest(kvm) && sev->snp_active;
+#else
+	return false;
+#endif
+}
+
 static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
 {
 	vmcb->control.clean = 0;
-- 
2.17.1

