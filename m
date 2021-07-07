Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E463BEECE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGGSjr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:39:47 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231670AbhGGSjn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ5V3MX7+MR2HPWj4L3zGOqBA+b6teNM87bJx05oTj8VX8q+NcRi2LtE/INdQDT0m1PwZl4tvLQ4SqNcIb3SsasJSQFgcHt50Dd3nttjIr1CJUBOMRGIwRcTgtMne9eO/XSsWuC0H97QNGYOU78zCQNG9MPzB0P5NK2Bm1Z/MdbSl92NMupoV3NbYWaskg7MCsdUlHG/XB4wx3JAd/H9G/iHTR1ion6OJ7tg1Ltr3kD4rAkzwKG6Vv0HD3jcfW85Z6x81NHOrDSvwzdqwVokWNqbcgWlgZF6//AxOQw+qexFSDZofcy/nzY30F18whff0MZMAgR0zupCW7RJMHe7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcfW5RnL2xfDX03o7CevgyT9Wwml7cWXy4izqIutYl0=;
 b=nTB6DmsELeZdjE1CyyEW3Ng69Yn3YgOc4gCG2i0EXELuX0BlE0tJUuf6/58mZ7xYprcmQzQ6oOIHj9DBM/o3msvELaYg5f3FZ3T8jkIxxmG56QVMWOyjOwr445lNSq6UUdIJX3XaS50S9QHbXR744d3V4u5/pTXIu3cYdR95yBtxODXIMgDcl0LQQvdRy+Av1GsuAzWMPTt5zTrf8V85yUYCIhDBKETqiZ04EfTdNp83yhBS9nPWCrb1+NkC8Xl9cYHeUPMcHJga1xI610OiQx48GdiOQb9Zvu3WYAAQRg/azdHkopR6Uu/thGaLENauvaWY6p6CP/NLshE2UxrICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcfW5RnL2xfDX03o7CevgyT9Wwml7cWXy4izqIutYl0=;
 b=LpqPesczGUi/TWL6E97oLujqUhbcAxWxohwctNOprOlQUzfF1/KQr0gVuMGAYSWVdy4/xCFmtYAKB4o64s62lKZo4zlD9nwdlrwM0f/bt5dxlSg9YE6MdBAQ93HaTOb5d9bgUGFeojqftyJ2qFl1zxAV6fxeH+lYXTAK2WfvN2c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:36:59 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:36:59 +0000
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
Subject: [PATCH Part2 RFC v4 02/40] KVM: SVM: Provide the Hypervisor Feature support VMGEXIT
Date:   Wed,  7 Jul 2021 13:35:38 -0500
Message-Id: <20210707183616.5620-3-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:36:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e401ae86-0c08-443d-5681-08d94176347b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB352533A7DBDD11009195B0F4E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io8S5KyXAugiTrSu9cU5ToJrFdsV1U6/lB9FfCXESPVnI0jkzP6oWXm9JEz13EffgXPciBSuR2Ntz903UEHfevwInkZdkdm1HaI283RugSnlgiYtkkZZGpSafHFJ06GhosaHS2pU4nDyS1OG6fJuY2gPx2W1HgzpwOv3sVugB3x87Fyczn4GS78YpBZrgpBYttgIVY/Jaayo2rkV9VwqiqTC8/b0fpwda873qO9ULMoNq8aih/uUVhZOJESfyfBUo1YAv4R/HFqUa32f9fB07/Q/D407ReuNkgTfaZb4n0aEOoIRot8H+oOiIe9Num32bdjz8M0Bl6oJgwDqZu3UbhExl5BbIT08V6DODbJMwebeadbp2HMIQAtyevmPXpk2VpeW4aGy7NNG1WjuzrWQKreSIj2fgbhPKiWVY9d6fgdzdI7powAlobOwscEVDbqIKqFuxNkJmP1ax1x67AVSlXXvl29xX4LyTOxEa4AXQakH9MTfjVN7lwAToMm5S7AFsLVQu2N/groMxEiRhXXhxr58hcgOhIcnRbxFQgYyOh8aegHjNyjWusoG4zGwkezVhYpoekZoaeu9eWSzVxa8jZLG9NRZQgFHSjj31CVhUEq+ENXh5+mZCl0YMn9FXEiB6aB8yi0NYAvzYjbp2/zS731ut4aUKBU+orvkth77qckcZpczWB5uWFY/yzQ2uRyWrZYA9tmLscZu3ezyn7ayRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRaclPHhRUUs6BqvQVPW5ttvNXwXVuc0bgJPaj8HowFaIDnUh9yG+HovX9YM?=
 =?us-ascii?Q?4gXUZffnZfRXCoWBH//ewcqWYoTt1XiXQdk7F3/vAPApdWwHlupkp7oFmUzw?=
 =?us-ascii?Q?MZBJOH0zjEaEq+Xn+WAEiHLYVf1qW/InNGi0bZ4Mqut6I4dd7Y9NfcxQK7YM?=
 =?us-ascii?Q?Jw2vtF36RQlv2PrYkZgf0Z9lTiW34Zu3n/AqzyaT/o6gRA2dBnx4ROsfEAzg?=
 =?us-ascii?Q?fWVaDT6Xa3Qnp9yxD7WV5kpdxb929uM25KS8lILsmf7pshvW9mehr23mbiRZ?=
 =?us-ascii?Q?LG+gNy7FbVraBdnOg+9R/hA9ktgb715c+7VUetBIVgRm4e3jhLD1YhJITGvO?=
 =?us-ascii?Q?QkBVEfLdHcvXCO72kNhPOQ8JuuuQYw6n78BC7UX7+2/3t12B09l/v01Lcxh9?=
 =?us-ascii?Q?3/JgQvWL43/8MCOSVK/QyyvvM73bYK9pxgSqdl5Oms2MvH9sT0IIzEExyOuA?=
 =?us-ascii?Q?s0uU74wB282Iwa+EyQZsG/XZBodj/53uT4PX25m87Ci5i6IviC4MnhXlEAvt?=
 =?us-ascii?Q?00ocKIqra03G6u7XVAJ1a9L/scZoNdVe55ZxiIJcvIhjLEyEmVsi1clWWz1Q?=
 =?us-ascii?Q?qJQoLcvgxfS26G0nKzVsftL8NhFu5NbWPbxn2PyLbln4g5s7AMQPnjK6O2BZ?=
 =?us-ascii?Q?jHXXDPlOpaj8rynvY9mMdZEoUSBDCsEaGYTxDCtw23LnwsgZPu4AWW3hL5y2?=
 =?us-ascii?Q?UI6ZvOd2m6s304kpzYWwL6008bRYT3BeQ+YLdRz40vtgBhzDf3elsUTqJeRd?=
 =?us-ascii?Q?cfuf9vsqcF3itSy/Hdsim7uicwSTH0eBDDwDbimP+qhoYToR3iyaemn2aCCe?=
 =?us-ascii?Q?GsoIXPrOsu8mk4Vg7IGeeKglW/5qX6sgmmp8EsqIfdkF6ah+kkE7q5Cwdskv?=
 =?us-ascii?Q?na6ECmTdKwb1Jts4HjOsi3gySmOPug3dyY4mv1gdb4CPcuFlHMdwy18q7b3C?=
 =?us-ascii?Q?xnUDSi7rkUpALjpqchcwvJdPmn23TKtTFBelCukOyU8ek4HUCPJv/qaznUrA?=
 =?us-ascii?Q?n+XE579LvIwOrmFGxwgSrFSnlBdO7ahe0+GQIWD1+Z4VUC1TX5OovOYAS12d?=
 =?us-ascii?Q?GltRF5bsa4AYJmiQjplKviVeRshDdRRsJTlJJfpecP8E2Gt33NJGEYj4GLc5?=
 =?us-ascii?Q?Rbcdahqmh0P/pwfQusHJlhf55eQ0l7d8OI+V+PI8HvsFY/WvBN2VPISBdun5?=
 =?us-ascii?Q?mui1y1X1edbg6OZA0D8K4DdBg8vSLHc+6H4tlxX3kiDXC7jSAcAf0TQ1UE51?=
 =?us-ascii?Q?VT6B6mPJzppRylNIwvvDBteDPFjn5DDMml2BURmtWsAW8zZaIQngjJ3Sk+IG?=
 =?us-ascii?Q?gm1bLuaisv7cYDgwO5/I0q3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e401ae86-0c08-443d-5681-08d94176347b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:36:59.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enXIXR8fe5/3lpHnBK7d5xf4zJlsPkW2ioKhAaAzVfAYt32/o/gM/ThsE164hCGtxzKEqGJymO+yZGa24G83wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification introduced advertisement of features
that are supported by the Hypervisor.

Now that KVM supports version 2 of the GHCB specification, bump the
maximum supported protocol version.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  4 ++--
 arch/x86/kvm/svm/sev.c          | 14 ++++++++++++++
 arch/x86/kvm/svm/svm.h          |  3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 9aaf0ab386ef..ba4137abf012 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -115,7 +115,7 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
-#define SVM_VMGEXIT_HYPERVISOR_FEATURES		0x8000fffd
+#define SVM_VMGEXIT_HV_FT			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
@@ -227,7 +227,7 @@
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST,	"vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
-	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \
+	{ SVM_VMGEXIT_HV_FT,      "vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7d0b98dbe523..b8505710c36b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2173,6 +2173,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_AP_HLT_LOOP:
 	case SVM_VMGEXIT_AP_JUMP_TABLE:
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
+	case SVM_VMGEXIT_HV_FT:
 		break;
 	default:
 		goto vmgexit_err;
@@ -2427,6 +2428,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 				  GHCB_MSR_INFO_MASK,
 				  GHCB_MSR_INFO_POS);
 		break;
+	case GHCB_MSR_HV_FT_REQ: {
+		set_ghcb_msr_bits(svm, GHCB_HV_FT_SUPPORTED,
+				GHCB_MSR_HV_FT_MASK, GHCB_MSR_HV_FT_POS);
+		set_ghcb_msr_bits(svm, GHCB_MSR_HV_FT_RESP,
+				GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
+		break;
+	}
 	case GHCB_MSR_TERM_REQ: {
 		u64 reason_set, reason_code;
 
@@ -2542,6 +2550,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ret = 1;
 		break;
 	}
+	case SVM_VMGEXIT_HV_FT: {
+		ghcb_set_sw_exit_info_2(ghcb, GHCB_HV_FT_SUPPORTED);
+
+		ret = 1;
+		break;
+	}
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ad12ca26b2d8..5f874168551b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -527,9 +527,10 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-#define GHCB_VERSION_MAX	1ULL
+#define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
+#define GHCB_HV_FT_SUPPORTED	0
 
 extern unsigned int max_sev_asid;
 
-- 
2.17.1

