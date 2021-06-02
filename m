Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66084398BAA
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFBOIS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:08:18 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:45825
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230010AbhFBOHW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et5iR1CJZEMb9Qpp1wnzUNCvJWQgH9zQW9VrHEqSoN4aZIU/kiBZuaJuFtHGJed67Iq6CFs/PiAjcrOUTaEE2PDim2fNG2L94BJspcfatbnekfgoF0cmdXIBVQud4rKcBNAjfdTP1Xx5c/eA65oAEsYL7Xi49rPSjHuz+eSV/ckPAz2bHkN1gvPiK65hBnfODNkIRbrfbEmETyLaDH49dd6OVW9rvWgOes47Q3LaUMzw/DCWLJC3m7iR0MQqPJ381OIcCUPiGqgZnxJiK6JyQdRVegWXC02UeAb6TH39aJXEyX9gyA+EKZSRDHRYYYVOXmunXHs5WtXx3MYii7zvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqleyn+92uLtJZ2DVgVJpIsdTMTbdLECR/8GSyQtQFc=;
 b=GuOslvmpZJwlrZ4cB2aSOt7z7WD/lTaFWOv+kU0kEPV+RwcFmHxsPiDM3Ooa0FRGZpNn/gzr5dHELLibekBNvDYHfp34DgSd4YmRejDCc+ZQQpzqJdFkngyIvzs1m8nb5MVFz+896nrqdDsCHouU0d9kvDzQwMtKzqkC+T0X6I9aJqJmOufN9xWzOnTyT48MICnzIAXOs0pNe05arJ2M+T3OvGvj2AR3cjbb9fUlrDOeT+4t9Au3/qWIdXUtnyICz95c500prRMbQTnhvMpgrejpUDlaXtejh8sln+OmexrBAXP/uYpuzQ8LJqNcyb2CL2S6ngQBcE4lzl8DhWhLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqleyn+92uLtJZ2DVgVJpIsdTMTbdLECR/8GSyQtQFc=;
 b=tCPRIZuScRsYqbf7SoDrFljSJ0SLZk4q4o0T8LvQEUKLQVmXAdfTVUSFW+CkAVxuEYbt2ZctArg3xibbr6wHDOQHplc40mIxKaLHFCbQBdCZsuJpcq8AjXnlQkQXQfygIU0Oa2v7y/CYLtefU43HBRABY+s2mcoiKKVTrIs5Aic=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:10 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:10 +0000
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
Subject: [PATCH Part1 RFC v3 18/22] KVM: SVM: Update the SEV-ES save area mapping
Date:   Wed,  2 Jun 2021 09:04:12 -0500
Message-Id: <20210602140416.23573-19-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a1f731-6dde-4120-d883-08d925cf6e87
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4446CB18536980C234F6E3A6E53D9@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azoIlvM90dIUYYvu9EgjNvJmVAXVh3hums+CkhXa8X+mRw0o8/MZjn0s9k68NTVjR/01lMBePBrbtEzDTtaF3rUTNoTrX7Fhunot1AqeQ5DaCj1cb2G4/0JkmoeCMlXlXBLIvQ7dWa1KCDRXxLs87KpZ+bTAP5lK7ZuPDUeuER30jhLH+oWp2H7MygLCL+8VcCuzGBe7UV8rZf7UBvWYjyRIjPU7NkQliYNcHTLpIMktF/T+e56ouzZX85lsmmpExmbIldwu0yxO/j5VPbY8VpydBu3nLPQbRVhwLmFp9pQeZY1wlGjVkYRFqbf+UFYoFJGljXPALXqce08NPZvCTmMcxe6MSUPpwGAH9AFEjk1NAIWR8LuVkHGVt8YYbjzWKlJkzBuq2BqCBMAKrdLZ4NXBAhlwnYs+sdTGolFZafWYx+vSN0xBi0BYoDuYJGciaGy3lGWXctNBT4uBk2OOfSXOTeXjKgp1GGG76enG4rTbEmW02nNRVKR9CLZ3CQQPh3wx6XwgRmDjwOISwYJO78nyx55mbdqpz/vGjJyep9hAYpRijq+gkV4EZhCM/+8j7YUG6BaeLpOR9WDBYAGbnerJUnTxWfj4KTuZ3tBRrGksBhIzaj+JNQywGlyHJWVRhAsQT2TRkO1aBlQ+O+t4gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(478600001)(8936002)(7416002)(16526019)(44832011)(66476007)(186003)(66946007)(4326008)(8676002)(7696005)(52116002)(1076003)(86362001)(83380400001)(38350700002)(6486002)(15650500001)(316002)(6666004)(5660300002)(54906003)(38100700002)(26005)(66556008)(36756003)(2616005)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PuX2D00Oq5LoPU88p42woyigAKrolJ3K7QdfjsVSzfzRdHaYlMZc1uvEIA35?=
 =?us-ascii?Q?SCYo31fh+aR5C19SAbs9XwxGMjZA0f/ndsTy48w5R0iC5mkLG6MdoUR9fWrp?=
 =?us-ascii?Q?Z2wqB/6HKVwvFiaLu5csIOWgKwyiTmCZC+J8bh/FkELg2HcOzEfekd43xXXw?=
 =?us-ascii?Q?mgNH/sOaBR6armIuP+PzJW+OIElac5Vw01ruYovE2LKARh/+Dsjxmob72iBn?=
 =?us-ascii?Q?ZY2o4TVgS7LDvsUfX+e00uLGBsJ/U2ivWp6QJVzJJj78vHH0kcGo14Gex341?=
 =?us-ascii?Q?c+YWVMiGHla96Nc7uKsGudS2u+zSmDI1GPt6cUIXGEj4PXAGiVNru2UzXO/S?=
 =?us-ascii?Q?LaJ2h2PzgSvOfKfI81mFjLHs38RQ0U4r7Xp84CTmGY3KB6wMsJu5Pymad6xl?=
 =?us-ascii?Q?eT8BjxhfAJVGIzQXo+9XsSH9afg/Yt4L7T1ltONOLQH7aNdnx9q1ZDnnk5fa?=
 =?us-ascii?Q?0zmQCguxfTay4/bwjLlDb0hQqILA01stb+WDM1e8Gvp5ooWKdoyE5+6GJ5nm?=
 =?us-ascii?Q?8pk1/cwQtlf2imK0nwRpxj9ZdLBoouNmdVd0MIWIDih8IyumNdhR4v3nvryd?=
 =?us-ascii?Q?VeYzZYf3GQhS96jbNGt/IMKVsXfFIMjyBNkhnM/Vp7kpgGTYxyIerUYEGl9x?=
 =?us-ascii?Q?Hz6q5Vfud6qEEbx8YCF6n2K/f0EjxPRCMH0GJ2QUBzDMKzZgnAZYQQKVcaRJ?=
 =?us-ascii?Q?YAIjVySZq2TUVO9J7marRtFemdN0urEiYJGy9Mjezf7tYhegYqLULki4zC7m?=
 =?us-ascii?Q?3IYt1PtS6iVxQeFdNIsP6DWDn1R/jHBi01/CfJk1k1qW2KsHKTmMRexKM0eI?=
 =?us-ascii?Q?a/V6TXdDtMyBeGaug3eUTI/0GmH/XgyNeZjE+BcUrJxJqnrchs+UcN6PoJsc?=
 =?us-ascii?Q?0vJKEM0L7WIcC38McuypElFV6SKHdPY+hl4aJmMU9SBnOqDOYCwSuY6Gp8ld?=
 =?us-ascii?Q?RvOiYfKoA3PnQf57oesjTTuRGGLiB+S4Om827BPbTzFdm83De16HoGuXRSYg?=
 =?us-ascii?Q?vBCoKdxzPTaMC9eakSBC9ExhueoH1xW9DqU33AcnwhYpXDpzLYxoXI+t6YsQ?=
 =?us-ascii?Q?Ay+O4HpmpEKuVvcbc9PFmRDtsIEZ3heKuZ+ElUhfMc60W3sLvEiFxx4M7xCF?=
 =?us-ascii?Q?tFOH1f4Pu6++GfB/kj7k4IdSqBpBt0fpz7ZuRYlTFBSjXXpAklcl4FoaHFU9?=
 =?us-ascii?Q?GjmOxeV8spETaEcVTrXKUWuMFY5XF6bmu/qwaRYcNigR+WeQ7NzmWDxMkZPV?=
 =?us-ascii?Q?W266TnXVTIQ8eYbzdFVI0t4H/vTdRR2VoIdM2C71BV/QX6XvKRAyNmf/ji3K?=
 =?us-ascii?Q?5Bik8QNIzDind3IaHJ7wS26m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a1f731-6dde-4120-d883-08d925cf6e87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:10.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lPhjBSrjCY65HT8dC0Uj4XeD1Ah7/jEpdR357tQkuxVbhdK1QmbjcWu0VR4rNKZ3U98000CjkN3LNC4+GXjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

This is the final step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Update the SEV-ES/SEV-SNP save area to match the APM. This save
area will be used for the upcoming SEV-SNP AP Creation NAE event support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 66 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f5edfc552240..b6f358d6b975 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -282,7 +282,13 @@ struct sev_es_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u64 vmpl0_ssp;
+	u64 vmpl1_ssp;
+	u64 vmpl2_ssp;
+	u64 vmpl3_ssp;
+	u64 u_cet;
+	u8 reserved_1[2];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -295,9 +301,19 @@ struct sev_es_save_area {
 	u64 dr6;
 	u64 rflags;
 	u64 rip;
-	u8 reserved_4[88];
+	u64 dr0;
+	u64 dr1;
+	u64 dr2;
+	u64 dr3;
+	u64 dr0_addr_mask;
+	u64 dr1_addr_mask;
+	u64 dr2_addr_mask;
+	u64 dr3_addr_mask;
+	u8 reserved_4[24];
 	u64 rsp;
-	u8 reserved_5[24];
+	u64 s_cet;
+	u64 ssp;
+	u64 isst_addr;
 	u64 rax;
 	u64 star;
 	u64 lstar;
@@ -308,7 +324,7 @@ struct sev_es_save_area {
 	u64 sysenter_esp;
 	u64 sysenter_eip;
 	u64 cr2;
-	u8 reserved_6[32];
+	u8 reserved_5[32];
 	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
@@ -317,12 +333,12 @@ struct sev_es_save_area {
 	u64 last_excp_to;
 	u8 reserved_7[80];
 	u32 pkru;
-	u8 reserved_9[20];
-	u64 reserved_10;	/* rax already available at 0x01f8 */
+	u8 reserved_8[20];
+	u64 reserved_9;		/* rax already available at 0x01f8 */
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
-	u64 reserved_11;	/* rsp already available at 0x01d8 */
+	u64 reserved_10;	/* rsp already available at 0x01d8 */
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
@@ -334,16 +350,34 @@ struct sev_es_save_area {
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u8 reserved_12[16];
-	u64 sw_exit_code;
-	u64 sw_exit_info_1;
-	u64 sw_exit_info_2;
-	u64 sw_scratch;
+	u8 reserved_11[16];
+	u64 guest_exit_info_1;
+	u64 guest_exit_info_2;
+	u64 guest_exit_int_info;
+	u64 guest_nrip;
 	u64 sev_features;
-	u8 reserved_13[48];
+	u64 vintr_ctrl;
+	u64 guest_exit_code;
+	u64 virtual_tom;
+	u64 tlb_id;
+	u64 pcpu_id;
+	u64 event_inj;
 	u64 xcr0;
-	u8 valid_bitmap[16];
-	u64 x87_state_gpa;
+	u8 reserved_12[16];
+
+	/* Floating point area */
+	u64 x87_dp;
+	u32 mxcsr;
+	u16 x87_ftw;
+	u16 x87_fsw;
+	u16 x87_fcw;
+	u16 x87_fop;
+	u16 x87_ds;
+	u16 x87_cs;
+	u64 x87_rip;
+	u8 fpreg_x87[80];
+	u8 fpreg_xmm[256];
+	u8 fpreg_ymm[256];
 } __packed;
 
 struct ghcb_save_area {
@@ -400,7 +434,7 @@ struct ghcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
-- 
2.17.1

