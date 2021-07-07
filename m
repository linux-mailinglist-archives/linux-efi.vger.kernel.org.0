Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECD3BEF8D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhGGSni (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:43:38 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:37344
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhGGSmq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km18oHqUkVTcDwKRubpu0YhZIXSz18TYxTWIxOpUciiLc/oUlSQ7/hHlcDNPKlmjlURffHhSjU2Q9/4vnL/XczNlp4SBIT4OJb1/WWx7LSTkv3KHpfD9hqd5u5xfS560RSbrpuay3btpH/nmXcH7KrkG3GgAFfSgQkOnKC+HI1ObCYtx/80zudOZMh3bHK/uSl3qtGLdvTbLZzu9iHXOK+/UgovPiqtpJUqsKLfEfZ1eIdFbUt1WxqLRrItwCUqbPgHlf40T5FZthO8JXRVEWg9ffP3JsEvr6rtLIiSgIKLLunjX9bmy0KT9R5W8f927IS89eIpOiZsjtRfI+WnJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdl7aOBdMpR18Zp4zcTsIMnX3jFTL8xbBzRQjsJpukM=;
 b=Xkr8p3ni8pvUP0/xT+UK5s16qRIwWPO5kYIgiSwboNLgaW5LO4mk5NyjcJrmGDC4MK5LLz0pRmhdZWIUlNbs3w3qzr6l8AgV538876mnTNB6G3o7eS7YzhZBOqD5HDvRhwSJI2lL/exisw8XoFDQNnqeWNUnqO6gEnbkLi6Y8+jkn9iYhQU5Icn2Q/9w5R2cUWfA/hDjuKMZDlmFDBVSpS25pnPplXRghxXv80oqy/mnuj2x9HDt4zZCjMe0T6PXdAulGKJlRT8I6vgk9oLrkBO6QUiMB+tzkCflxgOXlvVnBLi+dFwzl1YnT1hXwwLa9rmscGIwZgqFBZCkksHxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdl7aOBdMpR18Zp4zcTsIMnX3jFTL8xbBzRQjsJpukM=;
 b=10QpnsfJz2LAFRlbFNRzm4ESeUgXFRxHxvQFeTqwX97gGKCtIX5WGaKIYmlCbno7DPZ4jj1+n2KKz5QlPO9ptxPbvl7PB2i9d8aXzlGBaMu4clfF2lejU0dfwcR4tBFNsxREgrevpp1FelOq4BP1SQ6MjckHKRLghh4W2iuoM/c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:38:17 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:38:17 +0000
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
Subject: [PATCH Part2 RFC v4 32/40] KVM: SVM: Add support to handle GHCB GPA register VMGEXIT
Date:   Wed,  7 Jul 2021 13:36:08 -0500
Message-Id: <20210707183616.5620-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:38:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d458a8-a810-4e55-4dfe-08d941766336
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082466F1A85F1BC6FC10A6AE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0roKO/JiVGjjxzTN1xcE0d41npDonjeqaQeip0iQGIJOny+9sAagexBG+ZD/4JcKNLcwuwX2zzMDdSOiO9XA6DQ4nNuOGzU/YiV21jVyU9Dz9aOuVJWU2UYn9WG6z/n3C5WxlZANkVj2QOk1zISfU0QCVoaL5pkQNQydTis24vXhwV2IHD/zlTLZs9EUpRMKFZkQDrmfyKmLWfmHWOK92PkSpPdvb1XWCYUaRTuC6cSP0GT0A8ywR62ABs4F3rrp8fyZIOjDiVBCESC4S5xjabiTaP+5+7cuZwWeY7KCu6y95R6sV7X9BftS7H5sHPpkDsAofHmSCtW947WbV6zD4TJj8Vt+EZzMSYT2hcRTaeOjLVjXYFcr2a296AHfQS0YRKcgcx2WbuSXlpg+YX3vPmeRjxwGVl7M5HWUfCbHUuIEYIAr3FaRUUlXXYGqqbCErxPAeMnxz/zkprI0r1uxTyeGpCk8GDxJLDdrN6SiEK2Ocwwm56LzLJELk1olmgpvmd9Xupnuk5udAcYhJ3b5FKyNvplqkqX1IuIsxLH/FMHOcg6KhmK86Wm4LgrZWc+STQmear5Kj64272puFK6orubcTV0hhRktk2Y38uTMm81+33su2K54aPFc1WIviZBldcgJePZh0BUlBhQv48s5oIqcrqkvKN910CVt7uX60KFmEVi1fceRwMKDU4hG11/aBr6jZK9iRvDMDSf8d9VfXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8Aue2UvHtYZEXTlPFhFs3TU06hrLKrs9DCUtldLh6PlCP0mbCDSbvYT2uz8?=
 =?us-ascii?Q?+0anNwkgC+NdKl4unWWH3eDrLEYfsJoGtKx4457kimlbggL8X1SsLPUvQ3BX?=
 =?us-ascii?Q?PmciOhF8D3Z4xqRzUor1pXYt+fFYUfHOQLLWKSLNTfDoZ97P+FAY0hdDZuYZ?=
 =?us-ascii?Q?ItX3oStv2azcMrTyvconL+w5Srda7Q2iq1zbFrsruXSfeHOGMDjiJC7GheDS?=
 =?us-ascii?Q?OtOqsla+uPZ9myQaITggXTY7cWSEhnAZNpuZjTokxmVGrLxu716/XG6v7ang?=
 =?us-ascii?Q?lGwKjsXrrQd2s2CJS9A09GtGGk9mc63uhUSfFx/t+13jKuHWPERnQk+gevo6?=
 =?us-ascii?Q?bZ3SAfH11NNFQpd2xehARgnd+s31O1grqjpb9Vpkvc4+lWfeyVQJaNPHwTyM?=
 =?us-ascii?Q?z+iX1aCSan4dK0xs3sJWmUzwCWadYhbzAqCp07VqKRbqs/vd4IoEmNA3sr9i?=
 =?us-ascii?Q?gqfMAXZwtTIpK8waJIq4pN9pXku7nHOj3iJjR1fnjPHf5u44W3UbChRPj+RY?=
 =?us-ascii?Q?X1TF2G7OHvISpUckIp1iNTfmdAnHxheZHloSlNA0MU+1Jvn+jPnJQUFJRear?=
 =?us-ascii?Q?Qwr/SPXF8efmbFQ8eHqBjSnLddYFcAvO+TMtB0/ciCfqbCb4rMWJGpNGavWH?=
 =?us-ascii?Q?n+Dg/s6dqzJ8LIzQRG8Fk92KXpBxWwdwQmvKsOAjK/GJ5zSbV7OQTL4oRp+C?=
 =?us-ascii?Q?f1pYmk8M6M8bdaQ6GcESDLWNgXT5knqVQ69o5UTf+EJsC0bQdQfgGcw3vbPP?=
 =?us-ascii?Q?GUwiK0SeLvcyrvEz4gYkTwi+8GkAz/z99ZJCFJeFlEivH+9HpUcjh6e6INGx?=
 =?us-ascii?Q?PirbPxdobsEvq0XUbCKl006Z1IK+7qa6CSOuMO4cMUS9FDBzibox5T+dpq10?=
 =?us-ascii?Q?ZIHSPVsh+SWK9laECN4Byon5GcLwEcAmxTHZOpqGSy3NLi7TG/2cLuyQ+4ST?=
 =?us-ascii?Q?F4Cr6mz1YdwkdD9ytNSJsnKF3GxBRD2aTwWbeqvVtqnOJ+1aSvqaNvjPRztM?=
 =?us-ascii?Q?aT8vCMg5WFS79kJtmpR/JAOIRakCT/OAJrwU9Vv8dyNFHtiDoRU+paVQXdFD?=
 =?us-ascii?Q?jB1q0kvj633L9C57Ood7KFmrarKyoq27mRQNGOXVyc2vHdgE8dJhqpoo1tlS?=
 =?us-ascii?Q?KCv//PoumOnd6PJhDzPNQWubH3ryNMJmPcHshKUrX4YUai1r2y98zSVhH2d4?=
 =?us-ascii?Q?CgsdlzSnn5Ae31Mm6yTwoCisoTRoRERlO8gzGRKpH7HMkGO3WKPEz+NapW+/?=
 =?us-ascii?Q?Wpk8L41ZpgiL3XIvvCcC+UQWRLqShDY51CYe9AVt9e33lFVChXD6Y3k8SU7E?=
 =?us-ascii?Q?Aj2PHDVM4KXoBaHYmQeGf841?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d458a8-a810-4e55-4dfe-08d941766336
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:38:17.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So5b7NmaljOsj1ScaB1HQ8OpoTRWdkecF5ZwYdQjdbXIghnQqaD6Hv3TU/iBK/8Suddg9KGYZfBUr1EPSzvZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SEV-SNP guests are required to perform a GHCB GPA registration (see
section 2.5.2 in GHCB specification). Before using a GHCB GPA for a vCPU
the first time, a guest must register the vCPU GHCB GPA. If hypervisor
can work with the guest requested GPA then it must respond back with the
same GPA otherwise return -1.

On VMEXIT, Verify that GHCB GPA matches with the registered value. If a
mismatch is detected then abort the guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  2 ++
 arch/x86/kvm/svm/sev.c            | 25 +++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h            |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 466baa9cd0f5..6990d5a9d73c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,8 +60,10 @@
 	GHCB_MSR_GPA_REG_REQ)
 
 #define GHCB_MSR_GPA_REG_RESP		0x013
+#define GHCB_MSR_GPA_REG_ERROR		GENMASK_ULL(51, 0)
 #define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
 
+
 /* SNP Page State Change */
 #define GHCB_MSR_PSC_REQ		0x014
 #define SNP_PAGE_STATE_PRIVATE		1
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fd2d00ad80b7..3af5d1ad41bf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2922,6 +2922,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 				GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
 		break;
 	}
+	case GHCB_MSR_GPA_REG_REQ: {
+		kvm_pfn_t pfn;
+		u64 gfn;
+
+		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_GFN_MASK,
+					GHCB_MSR_GPA_REG_VALUE_POS);
+
+		pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
+		if (is_error_noslot_pfn(pfn))
+			gfn = GHCB_MSR_GPA_REG_ERROR;
+		else
+			svm->ghcb_registered_gpa = gfn_to_gpa(gfn);
+
+		set_ghcb_msr_bits(svm, gfn, GHCB_MSR_GPA_REG_GFN_MASK,
+				  GHCB_MSR_GPA_REG_VALUE_POS);
+		set_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_RESP, GHCB_MSR_INFO_MASK,
+				  GHCB_MSR_INFO_POS);
+		break;
+	}
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
 
@@ -2970,6 +2989,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
+	/* SEV-SNP guest requires that the GHCB GPA must be registered */
+	if (sev_snp_guest(svm->vcpu.kvm) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
+		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
+		return -EINVAL;
+	}
+
 	svm->ghcb = svm->ghcb_map.hva;
 	ghcb = svm->ghcb_map.hva;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 32abcbd774d0..af4cce39b30f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -185,6 +185,8 @@ struct vcpu_svm {
 	bool ghcb_sa_free;
 
 	bool guest_state_loaded;
+
+	u64 ghcb_registered_gpa;
 };
 
 struct svm_cpu_data {
@@ -245,6 +247,11 @@ static inline bool sev_snp_guest(struct kvm *kvm)
 #endif
 }
 
+static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
+{
+	return svm->ghcb_registered_gpa == val;
+}
+
 static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
 {
 	vmcb->control.clean = 0;
-- 
2.17.1

