Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACB398BDD
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhFBOKn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:10:43 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:11521
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231592AbhFBOIr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za0m6XsvNnD/BCOL9N9htjIPrLoIFo2USlNCob8eSjYmZZeRhAb3aUBLNPIO+Bi4IfO4U1KNFnIHdbOvX3D3GBYjxxC5NYzRlrLIfRhtwFRCiYzRedVYXlvt4N5vFvWz1w64Ewdd2A0z3XCZ6mXJcWWIn458HnC8jcDHe432XYM3TonLUUKKc4wA/vh9bNOqDe7HKj6RKxJyUhAvXeFjzjybeGqIIg4LfVFf1qxM2TDX/waGgQ9hsyZV/whqnFj8+H4A0s4LIYyMaDQpWXllhF+hyc7GB4Vr1FveN98MVcJcB/YIAi7ikTmI8/R1oTivHH4L19Mz0Gywb1sSUJbMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMrjUnVepEzQT2zCxLV5ivalIMMuIKD/RxguuBq3Wvo=;
 b=VpgisA8gTUAraDQMXtTVznhVmYUAcwy8TiqjBWoNzZa/ks3wZ8nl1O5X0PBLUCe0iTXyrlUrl/8nOmedgqFCRe8LGO+VutcR6UV7vy2TmHLWo/7kil3e+rfVNDESGSR4Ts+384Y5xrkiiOy7IqwvmS3t6a92nMWHBRPRTIQheJSVP4qiiQbxIeJgImKZc7wA2oOu4OsjUIkwyl4M2cgJmqOu3ODMYBTv6SU0fcQUYj3T/A+JMrbX5pAWIUZbWA3rET6DLdSekgTXA1ZT5BVEQUK6n1U86SQZh77625sk0kKkh9xczip97xc1wipPSa/P7A16LKG1kga8xCGFUW6jQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMrjUnVepEzQT2zCxLV5ivalIMMuIKD/RxguuBq3Wvo=;
 b=w75EpsAqZ0C70bsO/iNX7eWcZC0rjkZWCdv04x15hsXfp6oWaI+Czy4jTcWbP7TOQZbrO6+RbIbWsH53OkDPa1xW/knk5y29Sgw2GkSq61yYJgnq/s/mCf8eJQM8vt/6UEb067QVtcFdI6JbXdEkv/8DwZyzdx8Cm/g3QOcQpIM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:03 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:03 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 15/22] KVM: SVM: define new SEV_FEATURES field in the VMCB Save State Area
Date:   Wed,  2 Jun 2021 09:04:09 -0500
Message-Id: <20210602140416.23573-16-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9dfabd-203d-45aa-6817-08d925cf6ae9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766E9D470489D7A66AE4F30E53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TQ4ipZZcMe/6rvxR9N6WxhlGqJCeGP4znfa6gqgblP1+GAfHJlGz0OFbJPwnxYoVSUTNR6IfnxQf5ZatXnqWsxBP4ejlmcaaV+8f2NyHHib+O6GkRHdlcYEHfJf5WYY4DP4otEp9pibUzJ+HM/ozijX8d60xp7a8OgV2EOrwKCd6ApBV/C0osItnIe54f+NaE9EDEj+ofBr5SaIaD6nPw4Rch50GXSHfIlyMIyLgL6TI2PUoHucwgFyloa/PAKps1kAk6QSjw2AeiFguQgvcLZdRMB72kUTNEX0echjYsW7AS6JQAO8IYRuzeyi/+1jAQoDYhkKWbIOvH3wjHYqeP39obk5zyYfrfcHT3buMDjou+36dBRZGmFDZkz1aXPmYX7M0jMcgzc4x8LqOYms/W2H7JYyDnsafEzOSA6g0HjBB5bS3QN+JRKLGo8e345agczQhCruNUXxxYBVDn1RcqbKqEdQOg0I+5UVB+2njbHoSuEwzWN5k1nQkdFBwRb2y+BoM6OmX+ESTpLkLzxFpGuZ4eGb9s2cP21eLVcUNtnB2U6yd8jWfBP+zoWSEjYv7kA/QlOmOGXH86o4SKPp7jmT9Fj+Pts8ICiKARGWv9ufoczM2i1LB1cVQg7qDycU/69VYl7+p+osSxdbvGu9nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(66476007)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qk12zGRFENXpjs47Ada8bsZNuwgohbUZXmnot5Wmpjq9jgfNZss1kwM6cyvi?=
 =?us-ascii?Q?CvaGDcJ2dW0cZmqXVAWz9cb0z77OgHNDrl9mNGFtdjqap+hy7sr9+TKLssk+?=
 =?us-ascii?Q?UuWyD7ezNc8dGLT5l2dEZs2z7gME0lkVKgz5uc3NtKNGjwicl/pvbNag1wgq?=
 =?us-ascii?Q?+cR8trOcVATrIjZwSuj3swGFbeCF51nTFnZGoyU7Z1Brc6n8mzoIbAggl/nR?=
 =?us-ascii?Q?OorTVv+dCPAxTiiWSVU0MLTsQ/EKi764g1jUfxsjvJTmYu8OdIIBmdT8MV9W?=
 =?us-ascii?Q?Ji6Xtur3FjyVz2wnZ39mZgBNTTt/O+tgx+x8XkqZ192rAT+yTSlXHFvBa3jX?=
 =?us-ascii?Q?3cx0mThjFa9zhwCBf6t1BK19ek4RgdeiCsvdbTifxUnvgCnWmK6kKpjzNP8I?=
 =?us-ascii?Q?lU/zeGcbR/R2jFm64tLt9+a5yRVrxSp7+24xq8ztTYk4E9FkPDhE0I5b8YY0?=
 =?us-ascii?Q?ffRfHuhJow0XJF6iMov9m/74kjCb9bmagfujDXwzkPV056brgwiMWZt4w717?=
 =?us-ascii?Q?CFCdokS3IlETCT+GiFF8emUVX2pDxP/49KtS2j5FUT0fXtiD3Z6ylEUCpB28?=
 =?us-ascii?Q?s5uPgcbvDwVB+uEL9hY4B5mI5bz1WEUpJ54mHJZbQeEztfb6dEk7ZwAkmeVZ?=
 =?us-ascii?Q?Y3UvzR0uf8syZlHI5sO0U9GvCVRNbUkIAM/9dFbzE8YF1AqgVR2vOitzY5p2?=
 =?us-ascii?Q?jRXd4ZLZTdgXiARKAQ/E7l/gn5zAQscYJzdvbCjD6/wxULK4saKceVK9aYsJ?=
 =?us-ascii?Q?HgRz5OPiC1xOZhpmQKJ059CPWWVszGb1hv0jFtcwXE2LkRWnDGU2UQMKl/L3?=
 =?us-ascii?Q?5hgXGHG47ca4BFjF2pp4N3BL9M2jcTBC6tFoDM707M3SAVM6e8eIx1ft7E2j?=
 =?us-ascii?Q?o/c/JhrUKt1wNPUSh5DW/Z+hmPYqOd/8JJFM/TZtlFVd5pOzyYOmeE9o80Rp?=
 =?us-ascii?Q?eFSd7ln1S5+2Xf5Dzj8uWm+vdAyyn9NsfivIH93RV+165Q+OXqYA9aVDp7FY?=
 =?us-ascii?Q?pZ/C4GgvdA7+sGNuLqHpaO4E7blpMWlEZSncJROWZqGVRhhuodBHhPr/9b5a?=
 =?us-ascii?Q?L48+NHa7cqbP5tsVFAOH9q1Zrxc3DR+HhL/QoVS1CK+W32ekcZ2G02BlyeCW?=
 =?us-ascii?Q?RCeQPxdM+XT/eVZM6Dh27GPQ5Pgd+ha29m1dEQ0kE4cswVqIpPNYHnD3NMY5?=
 =?us-ascii?Q?vB9IXw50KWBbxYmIUDW5AliWbA94k0PkVb2HChisWo5LoH3pMORSIWGiChPw?=
 =?us-ascii?Q?+p6zAxy4lRs31kKLd9W8moFuRjs5TK7yISEhQG+n9D3yejCfHwbr5nM9N9VU?=
 =?us-ascii?Q?QNQoyqGTNPVbz1LmIZ4u8/tr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9dfabd-203d-45aa-6817-08d925cf6ae9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:03.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQKw0yaHqu4kj2FC+exsyaRmCV5APxjWXhEP7wGHtQZZ5yTHXlp/T2CYmoTbGgRY709TOf2EY9ZeCOlIkVWkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hypervisor uses the SEV_FEATURES field (offset 3B0h) in the Save State
Area to control the SEV-SNP guest features such as SNPActive, vTOM,
ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
the SEV_STATUS MSR.

While at it, update the dump_vmcb() to log the VMPL level.

See APM2 Table 15-34 and B-4 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 6 ++++--
 arch/x86/kvm/svm/svm.c     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 772e60efe243..fb38fae3d5ab 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -230,7 +230,8 @@ struct vmcb_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u8 reserved_1[42];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -295,7 +296,8 @@ struct vmcb_save_area {
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
-	u8 reserved_11[56];
+	u64 sev_features;
+	u8 reserved_11[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 05eca131eaf2..2acf187a3100 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3186,8 +3186,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "tr:",
 	       save01->tr.selector, save01->tr.attrib,
 	       save01->tr.limit, save01->tr.base);
-	pr_err("cpl:            %d                efer:         %016llx\n",
-		save->cpl, save->efer);
+	pr_err("vmpl: %d   cpl:  %d               efer:          %016llx\n",
+		save->vmpl, save->cpl, save->efer);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "cr0:", save->cr0, "cr2:", save->cr2);
 	pr_err("%-15s %016llx %-13s %016llx\n",
-- 
2.17.1

