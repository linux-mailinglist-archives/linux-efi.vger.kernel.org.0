Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29153BEE29
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhGGSTf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:35 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231612AbhGGSTV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlmiLKHXbqrZBwsy3oHqBXLNUypX3wbEJHCovvSIFvWjf4fi3ufrNzCceA2Wzo5sSdmuUGO5S1Cgs7KMfDbtZdHFR9gNX3EuclD5ZRQbeM3FcEvHXdhlhhyS6aOllA5qQT1fEp7Qj0HzwB68CblPVj4qc5VwniweS0z+lI7w3zeCs7WuN3gfAir5MlXkuCFsDFhiWfo8jn7DaG0z3caJCdHC6F7GsReBhxm+6H5+qsC6p9kTYISz3f7k8hYzTbiO0umScOCIHIOorukMrnCR555pU78hoGtrYfVj7EnsG3z70eH3SnBcLLE4klRPheHUE+6iCZ/UFvID5qCtp3nBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBt8/TPmDL1A3YsvTSKCK8gVuH33bPFiojteShvsYIs=;
 b=oHiIlk1N5+8I42QkBW+36XUSoZX/f1f95MX4ff8ZhdspuDPc645fdMh3w5nKnqMpaQWnvRET5yyojVc8ETbETpbijmVIp08QN838O+pl6Oy50ITkLG2cbPOrF/yIxtWuV2dd0dCjX63Goz+h+9JOY3hG5NEfvuMqqVEsBk3w74TefX+P9F2pqB9LWwmouzOak10sxK4VZyoA0yuhCbn9ULd+jKFQk5Z8jp49S1pzaWrxAfH7W8PvIjdSqYFW3Fhh+l0rbaImvdRgLc1CqagRMGTmYCtUygOBVFGCl4/GKgBRtdPrc9fgGpSrKskdo+CyIoqbjJysvx061LcmfkvAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBt8/TPmDL1A3YsvTSKCK8gVuH33bPFiojteShvsYIs=;
 b=3o2BsnyCm83F1JLQAVX5jAVACu6AkmMBeEMPMYljUVX1OknDtnGMFDFcl7O/yBl5FO+qFmPNIGirGulmpb69a8milc3WZa29iRjH5Sx0LJNC8A44b2RUFlyKnQq3c+6TDpIGSK09I5/7H1V2gleLiariX3yzfURvldkp53ZslFI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:16 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:15 +0000
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
Subject: [PATCH Part1 RFC v4 19/36] KVM: SVM: Update the SEV-ES save area mapping
Date:   Wed,  7 Jul 2021 13:14:49 -0500
Message-Id: <20210707181506.30489-20-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f7626f0-7dc4-426f-1441-08d941734f36
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016577D898B0F444ABC487CE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xppIfKs2pOnKfOktzBjj1xJSEnGuPnYKzrLx4DYqBgYbz4T4qmrSQ/fhNmDtfrvQHMkUEY6I8ZpdqNzER9rWcwQEf+IIs1OxwNaY9LA9hxl4Znokhm6oBwTc4YOr8+/0yWzt9Pwgooa7iqmrzLSLZI01MwE3EQeOmhSNfVhdaZi6qeCM6yzmPPHhco/0JhK2mq8m2sx5IVBf0T1uv5EyNurrHBHzNNTCBx7q/o+Fiotr3kYMWlP/vZ+tlnFi6PusnyIqW6UgRiE31G1Dap0gGHsypyejIuPWbXHQmPvNsECrRb0uA1HWE5cXQVdm5u8rl1yNGwKr2uMq4zxXnvWw0TUy/QBN9FXLY/KWSxY0+AD8H7Q9FqreyV4A169By36p27Yu9tsLR1ai3+dKkYXlhNHbSwAsXxBUwj5BfwuiDOfhvazKDUE0mLzz6PKkD0nkcR9vospQUIpaKzLPDHuAyKRKrc3LW2z/BxcVDlCJZ5sxcyAegRxo1sjFlQUnAXB9k5knTa77lSm2G9l1/1FpRsSb19BYzD8a6mqZd1AU/561vrI6KRl8VRQumMwa8FpiJtbJeLCgzibZ04YmxgBV40aB8RXIeoHxwHbYMHYfChEMFOlHmflE/WqUt8KUGY5h41pym8tagle2dzmylPzJm2PAZVP7rMa5MkWORDxMsgQUQsO61O8lgik+CgAVJZa2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(15650500001)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjuuH2n2QqJtX/wL5NuM/FbuX46iOMvf7bmWRwU0ymJtTOMazz/i7oR4MR46?=
 =?us-ascii?Q?L+RWiudxttra4dy8LtAHybAl+8mbzAw8l0ZsG/o4YvWZmtSpFa7Mg+jCuf80?=
 =?us-ascii?Q?A6pi8lug9ybeOOjeoRs2Boc+jhOEnR0vR5vtEWIqtQp97AInuDzhKfvWu2fK?=
 =?us-ascii?Q?gWHxQRT84EA5TPtVReBeJ6o1yCktuPoN+rTvZT3SDEuaLPR8HBPXQJERvIlr?=
 =?us-ascii?Q?R5919ijrNiQmLnNMQ3UKMwRx9i/pd2m0iMP8hGzbHnXJ7ldJlwn3feDV93N7?=
 =?us-ascii?Q?+f4KYITHWHPdntDRfwfQAirVfOovkqqVtpqj02Hw9W1xrMmQOkG9N8ObXPiM?=
 =?us-ascii?Q?AgoCGTNSqhOOQNIY4gQCRWx7s6WptAYfzs1kFsfNG5z/mzrvhDpEfmnfnGPR?=
 =?us-ascii?Q?YVAesUup5By8X/6dLqaFxIuz7jiPJaYHomMcAmo6JVjgWnq34z95m/prnx3U?=
 =?us-ascii?Q?4B2rIb4xpz/LNarTX6U4vB9M9XrNkthz1vBpqk9Ga6UQrmdKOsbIVr/99qZ4?=
 =?us-ascii?Q?kOEEACikr7WLIIRvpgT8hGE3DvK7bZnJRbcqvL5lHQvkbJ93Jqv2Ea0DJn5n?=
 =?us-ascii?Q?rNvftPcn4/x6L0msUUXSjo0BgW0YlfOkzhgDXIv42Avn9H+y1MuLozHq0JEu?=
 =?us-ascii?Q?1g5xHFIvz663yWhDYw7JoSAiiZEV+eeXA+g5LNJF9ThJuwlpKKoUpz7p4jip?=
 =?us-ascii?Q?iuk+mAx/sYwg9XOy5s9WWxHODO4HfX1FjCtKs3Wrv+LySnmxvrOY4aUUdwEY?=
 =?us-ascii?Q?izVuSEJVqWI3y7aFddWDj+l3MjoDym12o0BZ9iT1sxeYESZlqF+m244ZEXpk?=
 =?us-ascii?Q?pDO0EYJndqOAYpl0F22oLcbe3kuavqoMtN2VD8UfIB3nEQbLRTTWAXYp0wxW?=
 =?us-ascii?Q?r88caDNvph2TaA5dNtzF0EmNOpLObRxvCA9YxOXN06UAdV0HYhnvOq2qqbCZ?=
 =?us-ascii?Q?qDm90TYhSEA9FRVrc4257rreFBhw5iN+VWD5mqQMGM4t1iprWP7LbcTCRhWa?=
 =?us-ascii?Q?Rri2kGzD7xYn1zF+1wAQ+zrVkn4e9Ojxsj3oKye/HKFTeszLAcHWtNlzRYkk?=
 =?us-ascii?Q?iy/ppKHZqMelgv+hp5ffKzkgquEWb+ag6dxpnAhIiSTfk3CkJFQ16EcZ4yo4?=
 =?us-ascii?Q?AbM25RJcK2KPKQ+rZz5uupmIf+s4VBCR0L5pHVCe2EQCasGCrOE0cQouBfnZ?=
 =?us-ascii?Q?gIMoFv1X6IcaBJbIfRzGQcDj+qyeAi0Acr+tf1wFqbltrctJgH1xBQmtudYL?=
 =?us-ascii?Q?TeL75t7c9y6auAoUEsu0K2Z8r28l+s698wa2Wski4InKJXBpx4GZq44d5M7w?=
 =?us-ascii?Q?sA8LycBN+GO47O7sQrXjsdIq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7626f0-7dc4-426f-1441-08d941734f36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:15.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cgIoGoN1kIUd02ou6hr2S0erUi/bG7vjBgIecEhZ7SkT6+H265v9j38rvSCyApa+ccEQwTEBmzZYnGwdQqFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
index f679018685b6..5e72faa00cf2 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -291,7 +291,13 @@ struct sev_es_save_area {
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
@@ -304,9 +310,19 @@ struct sev_es_save_area {
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
@@ -317,7 +333,7 @@ struct sev_es_save_area {
 	u64 sysenter_esp;
 	u64 sysenter_eip;
 	u64 cr2;
-	u8 reserved_6[32];
+	u8 reserved_5[32];
 	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
@@ -326,12 +342,12 @@ struct sev_es_save_area {
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
@@ -343,16 +359,34 @@ struct sev_es_save_area {
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
@@ -409,7 +443,7 @@ struct ghcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
-- 
2.17.1

