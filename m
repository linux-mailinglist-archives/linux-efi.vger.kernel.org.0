Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E992D3BEE11
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhGGSTV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:21 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231863AbhGGSTJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqi+4F38wKxPmVlHnk/mbvHMZ5MaVpDVvIVxYljwfem1PBn242xAnuT7SmGNUDF7x5QC7Icw37txpJAZFCQZV5BYX2WZiD4WnH8/qefDHAvC8OHYsvvW8BAikm/X2Ko1mdA4GVAasPxC77soOUn7cG4lsjyr0eO32tum7ZCl267rN/cSxlEEao76IxkART/sbX0ueH6XAh+MDCrQv5jZmM6bv3bDR0kzCJ0to8JR1eg25dTT8+k0j2w1CKIKqIMFNm4eJqBppRUFlay//FM2DPRfcQplom01G5l3j4fmRzJpvHoUKsa/BVlJuarLV7UliWwwrNvVNPhBpjF2GxJF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar10hDCValtNRg7sDPldEtmq+v3w1Dk8txZ2Tu9WD4s=;
 b=PtLWSG9Pq92WMR6pwX0Xe2ifvRtqiO8VXfYhK7BUupDRS4CrGiZObtullOZlu3NZmIAzO8miPRi+p/OZl2b6i5I/hn6hReGyXub7I/lBBlfkfyzd2vJqfadE7pwYadcG+OmY9nBD47l4JDgNZfaGBNhiYTnhKmhrPy8SimeHCHnpricD1uLIe8W1RcFqqraT4wv4bcmo6WKOcQ54iKbrv22CjBiJHRlFPcGL1FO+aqMa5cgDx2hGw/wVbHiq6jANTb+I04o4deoY/L22tkImrla+KxsgC+0+zFB4dcQfFKzNheWPKzAioQqMF6YWxEZ8Me7ttsZl4ebFfOGuyKq8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar10hDCValtNRg7sDPldEtmq+v3w1Dk8txZ2Tu9WD4s=;
 b=Tweh1vGcz7sAmywdfrDqxTfvD8qbxAnUAbUDaWe7Ueu7wdlVvjjtMeGQ0iyA3G3wRFimFaHYyRZiHezLZLCRC+2lUismYzd+nG5zzReGqg9hBNe8CDRIyeGfC7XWw6oBeO6YwN/+XspvH7T8guWcTdcjMssnJMzZlTZ8fRFX2ZQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:11 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:10 +0000
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
Subject: [PATCH Part1 RFC v4 17/36] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Wed,  7 Jul 2021 13:14:47 -0500
Message-Id: <20210707181506.30489-18-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388a9173-a906-4d7c-7102-08d941734c30
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016463A9C9611EE21FF130EE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYplID/TrRuUAQhOwFguZAKBzy+d8zWgxU8tP/mFjfDrn6U90op6eO5WQium0NXGcwVfgA3aegvGfbvxGmZU83+bt2n6GG5Bc2poeBrLBP3lG7o/9uCrQ+QJxfAD4H5iMadQlm3z9BBRRcKzauYHKDYLkcTvhE2PtJ5THhZdE/me+Q/TIZmsnDYWrDj2kVHhXs0bXRvYImHEXnocJdqflZIuUH5Fo3JMu8mKxoUYnfFPnw0qFvHvdKqkNJDBM+fBlostKqQGc16SPIlS0AvAR7x7II1lm/VEjs31F4hlu3uweF554iELuoEGhTcIeSgvkQhehG82QdUOFruTQuIcWQKl+3++3M1OjcwcCRM0zYSdpZjZkTToIqUvPPBrgS6bWt0S3Dp1Kz4q4J8IDBH684s9XOJJdyFfNnSeZUbx8NkShbXfcJ2x8wLjRD0ADN984iIIWnr9OcYMNMGc1+3BXq78snvYYSRRUPi9jOzUIqeUN625mS67f/KTnEkPA/uwPNlYlJPSw3kt6VzQwrkm0YSxuwI/qm3QIMIEWuqgo6eXmJKwBTTz03QrorKWOmAnSagG8YoskJZ6MbPA7gLC5x7VyE/nmLdQiNzIjra4HDo8rtUP/61T0sO1PoqxVU/Sg3jODLrLHYdjpE4Z67Lxh2Ehso+xx8Uec99Nr5QQ9aPyiChx4iez6rvZGRRPo9FzyFDGJa3Xgq8j6UBpgl4HMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6R5MeQIrPiqyGUEA0NJUWXOU3jVKirkDq2Ha9f2sNJw/1jJGBJjXKVDG7vfN?=
 =?us-ascii?Q?brezxd08c61pMbkBAAn7wi/WLhyYaSNcqSKKGEqUbZHZXKLopx5KsIAprHiA?=
 =?us-ascii?Q?kkVyL6XKzefuX3H14X06pexCzpIJ5LiRuhyv9D142CTVhEGzPi5I5EoQvnlo?=
 =?us-ascii?Q?o6ZlBX+7sOlKGlU0Yxg+5yBklBuWqaJ3A6EBSqYYXupMRlAOpskUoqd+kfkQ?=
 =?us-ascii?Q?NgMvT6D27zYP5ZdfAPZ//Kfl7xoeYPV320THeODNyWwF8B7qsCJikwkVkvkB?=
 =?us-ascii?Q?ToOabjw9tUwucelPmVXPQGZAcxIC60iuxDPvIvXF+hcoBtrhv46dRBnuUmA5?=
 =?us-ascii?Q?rGVP4Nfghy5k+qMRWrL3QpFPiKxbKHaH6gThcvtMtICdJs2uxYwMyv/MuzkD?=
 =?us-ascii?Q?wU2AsRCNIwTtQp/rI8f6/kMrYLuyexFFu+HEywEwEzApUQ7ODnTvmdhA5/5P?=
 =?us-ascii?Q?NcHKLVgxeJRYS1vUQNwfX0hanV68gxYa0ENQwboESCCaHER2RtA7DScqrYlW?=
 =?us-ascii?Q?bbf2QjEmjgT0cpepajzE9dwS4jrFBorCzdIFvCvQp5fW5RayFyD3sjOX4FDZ?=
 =?us-ascii?Q?G+lHP7eLG+OVYmqWBS/x39aj0oLwlIswHHanxnG8HhqJ5eMb8GvoW9aKdRye?=
 =?us-ascii?Q?+2gON7u7CcK0oHyk26rA7euxBnFHVmqdNno22rv7TnWgmRH4vhm7rBXhUBFI?=
 =?us-ascii?Q?EVdHIwtSGAnXplb/swA7mh0kJWZPp5E32qC2OgMWi76VSy184pF1CT/a840q?=
 =?us-ascii?Q?J8hLVeU1OxsV6Ck36eDhMrjZypSq0Peoh6mivQljPh3Vt8VArLlooaC0A0Yr?=
 =?us-ascii?Q?QewaZA1B19I1dU6xKe5h4wcKvmick70GX4d2Qk1Tod+/CkEgKL38DbyQJIt6?=
 =?us-ascii?Q?MANH/SarvRdH45PqwDkaC/2W+t6k0MFyiq8fAX44D8rSESRIM80VmNxO5ZDf?=
 =?us-ascii?Q?fcLXWGktGsgLrqn/SC+G3hFx9AcPSfK3RVKu6os5pwAPebU+KahBgBQ97rC2?=
 =?us-ascii?Q?G2no3h4/Ua6myxW0g4SaiysuCprrYPHUP1Jn84X9LFsr1Pxuo+wi+wdHV7Fx?=
 =?us-ascii?Q?gSvdpUlOTTK+hji2NtwtnqJkCjYegiKkG8TTFdH2Pjv7lZga/J4mHcj8+LfW?=
 =?us-ascii?Q?TttjDsdvlq1k9iEDe0xCCrt0lJbkfGFjv2/SzxrVeoRI0V6ucT59IF0BmK8z?=
 =?us-ascii?Q?FKhY9EPn1M51ESNVijvGl/wkHJRxUdgyLITbKzQFeFpEOwVohxxnjyo8L8li?=
 =?us-ascii?Q?0aViBUQNqJH4xWBugwW0WhpjVpBR1pixtBMmBW3nbX9fww2OXDUg4UHwiZlC?=
 =?us-ascii?Q?jKWcGULF5pIaEwTp4TaBb7Ml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388a9173-a906-4d7c-7102-08d941734c30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:10.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ij8C1759YO+I+RlnX/eG4kIfRtmiQ4IhJl1DaclJug1haROuU3v/zmZAjr0df8MVyHSGNehDfhZ8DBANQq2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
index ff614cdcf628..a7fa24ec8ddf 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -228,6 +228,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -244,8 +245,58 @@ struct vmcb_save_area {
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
@@ -273,22 +324,14 @@ struct vmcb_save_area {
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
@@ -300,21 +343,21 @@ struct vmcb_save_area {
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
 
@@ -324,13 +367,15 @@ struct ghcb {
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
@@ -401,7 +446,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8d36f0c73071..751a4604a51d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -552,12 +552,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
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
@@ -584,14 +592,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
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
 
@@ -2606,7 +2606,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
-	struct vmcb_save_area *hostsa;
+	struct sev_es_save_area *hostsa;
 
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
@@ -2616,7 +2616,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	vmsave(__sme_page_pa(sd->save_area));
 
 	/* XCR0 is restored on VMEXIT, save the current host value */
-	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+	hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
 	/* PKRU is restored on VMEXIT, save the current host value */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2908c6ab5bb4..bb64b7f1b433 100644
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

