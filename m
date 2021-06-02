Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A367398BCF
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFBOK3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:10:29 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:31207
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231529AbhFBOI3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHBMIfZ7b+J6vPpQONmUiJAbGrbGKT8pdC9vKzd6WDHMmKbuQ5rF03Gcb1CKCcLxbqiVvdQmAO+qGuIFUldkNjs7OTvTtuqT44gVmSW+MJ5VL1ZUOaOiYq0REqK4/eXA3cvXpUoD8mrqLH5mFdalAcQqdU8b16UIx9ABq5+vnRxlwGov3fofvNM0LIIhzPCQcz8LPKFNEHCGVNCMEgUz8RiQCwI2XN593GqZfRUIDaAMzAoAkVCi5h8GudC8L4OpKlegzteDyIOoKytbSnbPlRsBqImRHqExLGd0gk3tYPE2d/JYW1c48GPp+3XOWBusWI8UGz6KxSqfQjbCc0Ezow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpr8HedjMpRPb5H7udsPXlQjZGB9oUNH9lc1hgmCrpM=;
 b=WMmx/IYXoAVedUMazZNqrTmTQVV7X/OAe8Lu/q2xlg8aqDAT5a/uhex/OPbeW1RRWjU6svpucgogY5jG+i10ZbYht7qTYkZKO0747/y0qSxgBArraGpCuYGP0zWSjeHdSn/GvB1MY9h/BKkg9uHhdSbKri8iFQUD9DQ61D7lhgk5sSlc3XLoSdBDiRKLZ8+1OeDg9gVKLzUTOrRUrTO/C9Gm7Q3nQ49F18Pxq4DgTiV6u2FnQf+B6DXHlpT5IJ+IDUsPX9RLDoLNR8qPcYqyDxZw4g/zoJG4fUzrp27unn8qUZgXWkD+apE+3nSXbDVbFmjXVweDUUynLF+r2z+8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpr8HedjMpRPb5H7udsPXlQjZGB9oUNH9lc1hgmCrpM=;
 b=iuZovo532ABiAU2+3zr/Kmy6V4LKff/KfsANcMssLyydhiqgfaAXG2nHkh/ej1xsBaRScuWlT5kwdFzj6fh2fvF8fGgw0c0rChOxmYuOWG3qoTGSxo9kfT7ih5Tx4cG18xXx3jXk9ryOxJGm5+whElH1OOKlYOFhB5c+2QOUFzo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:05:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:04 +0000
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
Subject: [PATCH Part1 RFC v3 16/22] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Wed,  2 Jun 2021 09:04:10 -0500
Message-Id: <20210602140416.23573-17-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae15e75f-5293-4e6c-5450-08d925cf6b86
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45123560EAB2A26C427F3D95E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bsqa5w+wMXrMF0lXtIqUv8zH13VKM3gc+xoMK0sVUkJwkRptKCQvPTP8sypqPF4z7tp8c7CDz4iUwADMHDOhvMXWRJJcAJDbZ6G9Qd7/+XU677XSYxbF5r5kvwSLHQ+2kRO2djSmp1o4lFySrAYUJpgXGp+qokFyaz9jEH/dMEi5Oz5Nck58isT9oUJZ3rdXzstiQvIM1s27I97z194i7zBU7JVb1vWUheVJehpgCyIrAZe9uD/oS2fV6t9LfjoVAf+Yly6lVzv7aKy9jmsWgtIjJjNmpWRrSxtCvVcSOz9s62aAMEuvrLpMJZo32R3g+c11RiZ5Vn5MLdT2vs3ZjKTx4hTtXssifv/ClLRPxcoKZKUbweCcUKHRYPrCk3aSIT65HTk+H6cm42j3lba7KAy95AmRxlxwMAwA3KUWVKYAXhx18emQDEw2Chv1YHYgy15DntiQ14wkFOOK1Xnta0mc8gfY5YBlfJAA+613lTBCax+StU7YRU4JlQjqrpzM+k1jm/fiNUchzYiD34rtcxk+D11fty14CZ/ssT7uPyT1Gbn8xdqCH/FJPjrImb26O41dkmmxWKCYXubnRBA2Tk/vNoSUV7wAmbR7ovw3OrZVn4b0mfnS/cHSFSJqf125rHh/dyxIQPqP4RNP+uED8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?daKOspSpvUq1XmPQodoYcQuE8yQqiJfn6yDrOiabv029p95ZIRLDg+33xMKl?=
 =?us-ascii?Q?rMDTzmSJravq/G+58jCI7Sf2SnBgW/xNZEQGIqX6gli4sCX0BWXW7ZQz/wpA?=
 =?us-ascii?Q?M4+72N1BMPY+a7Q0qMFE3VnazeeTjaFecIjAZrFfugdrXL3MaL6CpL4Bei5u?=
 =?us-ascii?Q?t7m4iEK5LVPTmHpEE7olWmeQ1Mg7+mvSzgZgqHCBaQxkz3bOtUnIeFkVGSvn?=
 =?us-ascii?Q?uhR7oXx/GVzViHQfMjqKUcBnv2s44nfqsGGHpVqD1eQDannQNIUA51qCREa3?=
 =?us-ascii?Q?yb8tqcn+zMjQu/pIb1SdgSaf7C8KOST2ZPsTNj8hcgQn4vt08ylE6hMCiDLY?=
 =?us-ascii?Q?KKMdDlV/e5OMwq5fZz/wpUMCpV+l5MZehekr0jdTD1ri3gRyACtNwIQomvCA?=
 =?us-ascii?Q?wA4a+7S1e+o7oX0cq0nvsG/0YJC0D0IE9dA1dnnjoGnPwXa+j9l6b11R9rZj?=
 =?us-ascii?Q?/XqOZe0Etq2e7gWGQEmj7QOb/JZL3PxNx8IFARPEMrzfXGkT+35kz2s4CkOI?=
 =?us-ascii?Q?HVeV5SfYFzwgz03MNlmGnSvO1v2pvpV7LmQZfEmT+ir5MA/pbgPl8UcFI/q9?=
 =?us-ascii?Q?GohaSi5ebdzORx+uzu07mHZqVe8RmG5I9Ss9XOBPHTXQEv4wMQYm17FB6Hz3?=
 =?us-ascii?Q?O0WPkSYgs8IK06TAqrKc4fnvOHS040Kuwy1ZeFBe2glnJmLwgv+7DvYu7fRl?=
 =?us-ascii?Q?26WGU5HyHI0del/JVrFcti6TMHaCPlmRNH+WnPtzQV+kA4SWKq0h9znUd1hT?=
 =?us-ascii?Q?5OAJk7Dr2KWU5sq2JTSAwRkGW4DEhUQSUa15rBV8BYlNMdOSNjtvnPFKeA8N?=
 =?us-ascii?Q?F2Cr+pUkp2uQgwnDQoHit1/mA9Jt61OsEUN/2OzYxfQq1H5GYA4Pa/++q+p3?=
 =?us-ascii?Q?MWQL5RP0z70NDODTAPP3BqhZTtdlBzRyabpJdsr4ZD5fAfmU/Eb5TjeL5BvO?=
 =?us-ascii?Q?eRU0IFtmtD4Z4xm2/mK+QHJSER7jzpZ/9mWUH49oT1gR84ImN/Rr4/DWVSo0?=
 =?us-ascii?Q?7ffen/R+YlCA4Adyxs+PqzrE7dUumy3p33dq8Ci5w8WGs2OPT8otjDPPRTx5?=
 =?us-ascii?Q?1GSyuMiSWAAL2zUBsYv+0zZ9/OPrHPTqhFOniJ14t3195DshEmVqRPAvPc7i?=
 =?us-ascii?Q?sO2gJCwLz80MwqJdXJigd8KfgonH4dXK50VlJr3gYP5U5u9ipoQdPp5gDtyb?=
 =?us-ascii?Q?Vaq/HAv8JgrIht1F/XYbYRf/EOEkGvycre9PovwOzelYD9VvRHKZMMsRs9eu?=
 =?us-ascii?Q?dkrYLc6v/YP/65lvS9x3S9RfWeZGjAbqeTX2yf53NNn2aRyEGgIqCsCOAG4F?=
 =?us-ascii?Q?cP/ALr9jol1hw4g3qlDnid1D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae15e75f-5293-4e6c-5450-08d925cf6b86
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:04.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqZ8wMYqc8+moxJI2Lq0ecVzDmCXTflSjmLAZHGMwwS06AZHXkFwFumh+OlMCSHHYZQHH6ypAcrth8q0F8jS+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
different from the save area of a non SEV-ES/SEV-SNP guest.

This is the first step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
save area definition where needed.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 83 +++++++++++++++++++++++++++++---------
 arch/x86/kvm/svm/sev.c     | 24 +++++------
 arch/x86/kvm/svm/svm.h     |  2 +-
 3 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index fb38fae3d5ab..482fb20104da 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -219,6 +219,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -235,8 +236,58 @@ struct vmcb_save_area {
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
+	u8 reserved_3[112];
+	u64 cr4;
+	u64 cr3;
+	u64 cr0;
+	u64 dr7;
+	u64 dr6;
+	u64 rflags;
+	u64 rip;
+	u8 reserved_4[88];
+	u64 rsp;
+	u64 s_cet;
+	u64 ssp;
+	u64 isst_addr;
+	u64 rax;
+	u64 star;
+	u64 lstar;
+	u64 cstar;
+	u64 sfmask;
+	u64 kernel_gs_base;
+	u64 sysenter_cs;
+	u64 sysenter_esp;
+	u64 sysenter_eip;
+	u64 cr2;
+	u8 reserved_5[32];
+	u64 g_pat;
+	u64 dbgctl;
+	u64 br_from;
+	u64 br_to;
+	u64 last_excp_from;
+	u64 last_excp_to;
+	u8 reserved_6[72];
+	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+} __packed;
+
+/* Save area definition for SEV-ES and SEV-SNP guests */
+struct sev_es_save_area {
+	struct vmcb_seg es;
+	struct vmcb_seg cs;
+	struct vmcb_seg ss;
+	struct vmcb_seg ds;
+	struct vmcb_seg fs;
+	struct vmcb_seg gs;
+	struct vmcb_seg gdtr;
+	struct vmcb_seg ldtr;
+	struct vmcb_seg idtr;
+	struct vmcb_seg tr;
+	u8 reserved_1[43];
+	u8 cpl;
+	u8 reserved_2[4];
+	u64 efer;
 	u8 reserved_3[104];
-	u64 xss;		/* Valid for SEV-ES only */
+	u64 xss;
 	u64 cr4;
 	u64 cr3;
 	u64 cr0;
@@ -264,22 +315,14 @@ struct vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-
-	/*
-	 * The following part of the save area is valid only for
-	 * SEV-ES guests when referenced through the GHCB or for
-	 * saving to the host save area.
-	 */
-	u8 reserved_7[72];
-	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
-	u8 reserved_7b[4];
+	u8 reserved_7[80];
 	u32 pkru;
-	u8 reserved_7a[20];
-	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u8 reserved_9[20];
+	u64 reserved_10;	/* rax already available at 0x01f8 */
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
-	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 reserved_11;	/* rsp already available at 0x01d8 */
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
@@ -291,21 +334,21 @@ struct vmcb_save_area {
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u8 reserved_10[16];
+	u8 reserved_12[16];
 	u64 sw_exit_code;
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
 	u64 sev_features;
-	u8 reserved_11[48];
+	u8 reserved_13[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
 } __packed;
 
 struct ghcb {
-	struct vmcb_save_area save;
-	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+	struct sev_es_save_area save;
+	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
 
 	u8 shared_buffer[2032];
 
@@ -315,13 +358,15 @@ struct ghcb {
 } __packed;
 
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
@@ -392,7 +437,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5bc887e9a986..d93a1c368b61 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -542,12 +542,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
-	struct vmcb_save_area *save = &svm->vmcb->save;
+	struct sev_es_save_area *save = svm->vmsa;
 
 	/* Check some debug related fields before encrypting the VMSA */
-	if (svm->vcpu.guest_debug || (save->dr7 & ~DR7_FIXED_1))
+	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
 
+	/*
+	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
+	 * the traditional VMSA that is part of the VMCB. Copy the
+	 * traditional VMSA as it has been built so far (in prep
+	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
+	 */
+	memcpy(save, &svm->vmcb->save, sizeof(svm->vmcb->save));
+
 	/* Sync registgers */
 	save->rax = svm->vcpu.arch.regs[VCPU_REGS_RAX];
 	save->rbx = svm->vcpu.arch.regs[VCPU_REGS_RBX];
@@ -574,14 +582,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->pkru = svm->vcpu.arch.pkru;
 	save->xss  = svm->vcpu.arch.ia32_xss;
 
-	/*
-	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
-	 * the traditional VMSA that is part of the VMCB. Copy the
-	 * traditional VMSA as it has been built so far (in prep
-	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
-	 */
-	memcpy(svm->vmsa, save, sizeof(*save));
-
 	return 0;
 }
 
@@ -2598,7 +2598,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
-	struct vmcb_save_area *hostsa;
+	struct sev_es_save_area *hostsa;
 
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
@@ -2608,7 +2608,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	vmsave(__sme_page_pa(sd->save_area));
 
 	/* XCR0 is restored on VMEXIT, save the current host value */
-	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+	hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
 	/* PKRU is restored on VMEXIT, save the current host value */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2c9ece618b29..0b89aee51b74 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -170,7 +170,7 @@ struct vcpu_svm {
 	} shadow_msr_intercept;
 
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
-- 
2.17.1

