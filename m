Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFC3F2F4C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbhHTPZI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:08 -0400
Received: from mail-dm3nam07on2084.outbound.protection.outlook.com ([40.107.95.84]:16576
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241138AbhHTPXd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqyAtshYbmi7T+x/SbYBtYY2C2e0V2kA3oc5StZGUzOUa8Q5TFWYhScyfCqoS8uff3ciXjI/wqJRIxw+qIHQVVWgzhZIr8iEfqtFp8h4AqK3BRXloAw03G2vJYgshVMpBgPolrFhOhMAD7hZj4LraFxELWzyK4SJmtpqvmMAXqnDwTK6rRfWMgfj9jf3XiKiqidIDtuG/PN6DgtzPSEmhjqmmy9moLCJEbMI+p2Zx45ghaHDfPCE9Yt5JKEcncxb7KBvbboxw5lDnET7YxxwDQRjaBCAgUT0gjrCWiZyGWzV2E1VWG8gPG9C0FzxcqR9wvTMXUJXDZLK84w1La+zqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdF8q6VgRdbV2LwEZioEQ3Z8CB40ZABdJHS8hah9rwk=;
 b=coqUL0OpMF4iJHhHpCa5Hk9QQrgVyWwGwnZsDaIRhrC9rhnv3nTUVXKMlH5hyzWFVgiw+SHNzNdv4hnXJRt6P8CiFk6p2lAKxh/g4SagAlHH18LGVmJGStpKC7Ru5dAMv1d44g99dI3bBmkYP+rOu+qZbb4XNBuFN/HMoseQhTHPbs9M7bIzz7QO/5VqZt5/b4brQiHm6iCrPQ+eQozwEcs3xqbAlyOVD20zuea+FXJIqArZMIeY0qFxy2CgArkZb6bb+suCUEX6rKFp5u2ZkKf8oxUikuOLmv9Bb57HvyO2ulojT42lRfUh6cvP+UUU1xDc5U3mB5vnC+/VbKQdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdF8q6VgRdbV2LwEZioEQ3Z8CB40ZABdJHS8hah9rwk=;
 b=gGgNGWLG8PF4tKkOCrkO00BqQ+0ly4tMIejyUZeGIXI0B3kQc0/yiJXKH/D2uTj5FBjKEfQ9M1sAUzf5HqRs7thDQWS1FFCUqXjZqI9I+oZ3WcTxwCA2xsqYyRkp22Ae/TYVi1My1KqRBdFnp25/LrMUASvnXETuBWMbBLFCifY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:14 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:14 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 21/38] KVM: SVM: Update the SEV-ES save area mapping
Date:   Fri, 20 Aug 2021 10:19:16 -0500
Message-Id: <20210820151933.22401-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c95f397-8919-4ade-0939-08d963ee263d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446A71927AFF2F98BE03DCFE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/5bz6kCVimcW3YTTPpm3g1h1plGJF90Af2n2rdYLwMOIxGMr1GKPxv7yiKylG4SuCnlhpW+2evHBaBvkxpQy65mV4Q4xd0dIuQ+oIXWyvkQFZGF073wG3w0JlMHhmJB5msk/Oe3a1n/Y9JJAdotPr6bmFIzcg/RAaw9K0u6afCFkiLArPvUE+SM7YJGjwHYOXAgoT4HXbVf2NBaVTeHzhz2n8jSbysElYOdWKORRXxYJapcXFF8tZ++DAuBAVbgVr787s02INHskA29Z+aARB0ba+8L24u89wBkB5yoLfL8IaDQPZwrDxrWl13PPPDWOoSHCHODy1KQX5xcccxmTKtrCIY5BcMDvhnkIzcb+VHMnCPKUkGlm4CNegvCubV1OkHX351f3czsFsfYBtq1pi/UtSCXUNIEmoGYXsJuzX9o4/sWluukx0xYiHjWLTawk6gtUTXp+/N52es3eB74troZlmV6IHc4K5/3z1W6xbm2PeF6SdocdPckAYBvoeL3L26a//3LbhGqDF+qoaEU3EZLTGbfCd3VOcwt0X7k9xMsSIjDj7KamTW7KAtXeb5JG9MZqfFyrWir9CcJpeAIinfnLVfxb5a005iWjEQWNZ1wcC2gXawqWh6RKAs6nI5kOHSbi3e8E+YC2YiKd2ODwOXpZhPaz/DF0BSsK6RKfri+7WtokBgFWnS88cGf43zZVgS+5XnHBDCxqG3LnL9Xfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(15650500001)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FXOLvxhGqVxBElcDxHVuIphjZye7E/EWnVLv6JpAxtFPsLYiVzepP4RypfQ?=
 =?us-ascii?Q?GRsYzx2qI4mMWVj85B1pUnrbsC7OKp2GwE3NX5BEzhcIlPE9xcAqwg8u+xa6?=
 =?us-ascii?Q?quZBepjv5uXxLhHJ7SmCrycO0AEK6raBZTeGF+ce7f7aKICUHX+kJT/inQ4Y?=
 =?us-ascii?Q?hTkVV6+X2zbqFYkLulu7hY1Z44VZXd0xOEn9ZXeBb2NuktpX13Vb6S6glWcP?=
 =?us-ascii?Q?Y3CjognbhQDb4rJbWqgZkcp2MWtl44GIMmZRlhftkgE27H76yeE3gheEx8oY?=
 =?us-ascii?Q?RN46kmLJHlOcUuBdV5e9syhCs61Ub6bRKxP4kKNE+NH4dm82Qu0Dgpep/Ig1?=
 =?us-ascii?Q?g5wZYAt3F8PgkVFxDnxExNVLRGpp6Z2yWsJPlQAA7azkWNJ3Mtwx/8vlYPm9?=
 =?us-ascii?Q?LG+yMm81ZURNmQgYT/g521Zg+v13Cp82qI0eTp+cPVOG2tG38aPnU2BQowHm?=
 =?us-ascii?Q?BALZzDR9OotEmXqJNUXVeABdbac+pQA3SpXs89H0GO21L+IxguSQwI6WXbut?=
 =?us-ascii?Q?7QiblqB7WmZ868FeCTOu7N2f4cmtNzM7WE+WqNRDKSs6n/gL/sw71mCELkLO?=
 =?us-ascii?Q?AydfurZ6gH6wcgOS2yJB9b8crsEa08eFflWHzXofKkryrY2GkErG6sXFOilF?=
 =?us-ascii?Q?xQdaB6lNV1QO5NoZWRJdiL2blk4w8TsozJnqiUQLYEqfiHuCuzFSEiNe2dJa?=
 =?us-ascii?Q?WgDoL22icTwWZl/6/Z1XyesRAPRVYlEHtDeNozZuaszJAvWO9nFNrtQwLeiG?=
 =?us-ascii?Q?Uq+Yz2Eqdh9w0XccP4Xce72wiX6yparNtfmiyz4D30At/izNghzxpgIv5XQo?=
 =?us-ascii?Q?4hz+YWy35tN1Mkozu/+UM74zjhUMSAqdhOJ/13VnSpxK2hbuAACRERVI7OmI?=
 =?us-ascii?Q?nHLLbidU27YIx40UO5HTA3kKef3+LtlReBuSKv3Ererhwm8Z3bFqiBwhMemK?=
 =?us-ascii?Q?tDEwWxYs/0sXwtt388glMRDbowGbkdnAdSqkRTld7hd1Bo66Cba46JGzNRTb?=
 =?us-ascii?Q?2S1vYPQrfZ6PZVQkvX/B94Pjg95tuWKIcyr77AkAWOe6yDabOWrOBrIUJhcc?=
 =?us-ascii?Q?rTD4gcJWLXFHThLw+hbg7amlZvBRnw8y7BX0GH7for+OlmXHVTL/5+1j0Udd?=
 =?us-ascii?Q?9jy2L3LmqbHa0B9ojob+arJgPX22ZMFoBBAiERpdiHrQ1C46yKX4TbA6RtHy?=
 =?us-ascii?Q?91XS16kuBzAAmgvBQTsJoX72U4Ny124t24dO+OmyRMvVp2UYHOYVNX0osulQ?=
 =?us-ascii?Q?zPq/LxHyMjoQImleyRivq9ennE1po+0i5LSL793ail1pZw8YLh5tsWGTrBxc?=
 =?us-ascii?Q?YUhoAQOBxCvZsgpKTqWRu1aX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c95f397-8919-4ade-0939-08d963ee263d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:14.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d62xoTtOu42FjijsElMdcr8L7VYsXbkPr6KT7DoP2gfuL/g0dz2dyzMMnXikDfZFCjmQ0EZ59qg4ln1rtijkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
index 748fe1c82a2b..44a3f920f886 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -288,7 +288,13 @@ struct sev_es_save_area {
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
@@ -301,9 +307,19 @@ struct sev_es_save_area {
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
@@ -314,7 +330,7 @@ struct sev_es_save_area {
 	u64 sysenter_esp;
 	u64 sysenter_eip;
 	u64 cr2;
-	u8 reserved_6[32];
+	u8 reserved_5[32];
 	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
@@ -323,12 +339,12 @@ struct sev_es_save_area {
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
@@ -340,16 +356,34 @@ struct sev_es_save_area {
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
@@ -406,7 +440,7 @@ struct ghcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
-- 
2.17.1

