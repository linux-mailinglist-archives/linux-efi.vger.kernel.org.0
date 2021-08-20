Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55C33F2F36
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbhHTPX6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:58 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:58049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241186AbhHTPW5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvEV7HzaUsRxg8pfpmF55N/zpjobESF0svWsvLMZK2jxH/gKsy0h12Q6heqzO2OoBEoLmTmQlptQPbhZvJknbi2lOwXTCX6IidEBo8Lp5QNe0VOJsLfxfChkSMbmFpBHnKMtHXnEzpzpkyApuEncQ55pI+QOgdGD7VhzISMKyVK2Ugii/Lkk98L7VKRLhmoentSBPp6IIXJLJ9oDQbTiIrZcKpDCc76Cp563BndsBOTFkAP4dZucosb/l5uxUy/soMWtduCNMwdaTTV82Uryd1DjmfukG0TpYqLLq/JKXeCX/CrAtebMHa2EviO+QppNYH0oO9YG2qlizGklIe8yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EVt/1JeCs8OLIQsVuz3ghO70ddglJpwqdBb+sZrmaE=;
 b=SiecYie/dOno+qIJa8FFe3X1B7/klw/XUKE1358R4ys6pqL3ZNxidblG9qll09M4povEWPsBc8wf0wSklTLu79aIHoqwHwIii9crxQCcxw8IUOSZik7XA4ggT3DbUhvDCtXhmpAHuesmDO9SjT6RAUQHh/qjs8Y+/VBE3GgLQlkOKBOsjC0sT2F0Xwju4/uQ4li0HkOyO498C+zAIV6Gl2z2QmmjL0t2nXysT0IQF27eghhOVflmv7TtiLZ2kU9IYx9JNT4K73HXhsOwsUEB2E+ESTOe7980XkOO08gfqEDLE4e40QymtgB0+hdzpfY8f+6ZPZRyVMN4HLijzD3JNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EVt/1JeCs8OLIQsVuz3ghO70ddglJpwqdBb+sZrmaE=;
 b=PpM5di1FVd06KG23oqVdZFm3feA3Q+g6BpmRKUWwSYJ5kkxpdeqdpog/7MOVI8Olr1LmP1xwdgU/DNbWY4Lu8fdNb0YBLu2KDbwwtTsHoodwrwZ2s9Ft+bBZ4vawUzVM/lHxd2XsBmwzayoG4lbuo+DIcNp0SjvfMWqgOhL0epA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:11 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:11 +0000
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
Subject: [PATCH Part1 v5 19/38] KVM: SVM: Create a separate mapping for the SEV-ES save area
Date:   Fri, 20 Aug 2021 10:19:14 -0500
Message-Id: <20210820151933.22401-20-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a616cd50-686d-44ca-d928-08d963ee2495
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446FCB20C26F03E9A2D9CDCE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CF1eMt4i1v+TOEQcNoXnCF4wb9AQ0KyQ+8g6AUf6zWkte1yLWPjSe6TxfS5O3lWaMDsXIrQ7/ibTxnXDVhhBMMaxgehSL75ic63uMzky3O6gTBVcYEAhvHpVpnh2cDbZ5KDuy2wAn935Xqo9Qptcp9jAGcJ95NXnGma2XoT1XwkNZ5VZywVbWy7OUVVl6R5wTqbz5Lk5YKXaTlmbc0j+axLlGHrTCr6s+X9J9p5DQAUUKlcFJGJL+Biai5ET5oUaYS9fyq9FtSEtKKJhrF2MsfHaTi9UDQHaYN5LcTAzoVrsF4QA/bf0etw8R892m7xZ13bTO/1GCEnGit3wNN+FtPJqUXUE/O+mvZLhk5k2i7jJs7lXE63PB90hwu+8T3HK67N1JXpvmxuvpn7aCh1bmJPiPX04KhlIp4z1WKDHNzm0i/0/Ql0+SzNOewidMzpFGxZ7xZwQKcRRP5iXP2XkfK25Ggz31E4+IoqujiK/JXDCqWK5G8QVsX7qk/C5Aa09OwGmGyOEQUjaWxgkcppp1QJXlMYBdLhF/PAtCl3ALXJwtv0Ho0rf76x+5/uX4wcdcqzWBPYKskth+ZE09R7bUmSnUejBzC+j/7ji8TxXt+1TxDNCHjY22GqL8gHaPN1wydLTV6Ywve4LC2lxKDoTEv13zrSYHxS0gf0wqHaaHD/ppUolZUpVSPxa1topA+kNpFelwZHiGn//YiDVAFaVwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4Db464Vmb0cDFKVJuylpdjxKYYlxCRyMlFfjmuIg7NYkU387hiyOQ+DNh2O?=
 =?us-ascii?Q?aFn0iOSzQktzPpxE7w99sLnQmkNuw9SYOlpTr5oyS/MObhIYu9rXWuFl2S4P?=
 =?us-ascii?Q?H4LPit4xb7F9MwlQWoYAxTGF4khdLDZTST5l+nBQq2XmaeCYe9YI9Vs2cHce?=
 =?us-ascii?Q?WXntDXah7W4C1CCTHVQ0FpC8u3KVMAqiQHSbWSKsuCKRRXENpoNg+l7cF/w4?=
 =?us-ascii?Q?qolsn/tdPX+pne+F0ITsIVLJcqfqfZBwzog1u60zyfz5wtrMZKoiC6XU816Z?=
 =?us-ascii?Q?Eg5q9czEuJ8KZ0t0/j+TXJn/100AR6sYNxPW1g5FKPF5G9wTm6o6Aw1rHE+q?=
 =?us-ascii?Q?JChScx9eJWsfPshXrgSugpEMPx9i7I4NoGoB4o6eR/YIfmi40TxVjzHU5ALz?=
 =?us-ascii?Q?U0H5vm9CyBXPUM0/pqAHOD3tJ+kq/+cAGPDQ+4rS97dOmanKXTpFljNMooxn?=
 =?us-ascii?Q?u0bq7wRhAVKANIUrc91Y0CqkxsFF/WsduBAJ42AnKtP7JFgH8gaQ7yYu9Mpw?=
 =?us-ascii?Q?JtG7TAVG36LeCIjvdr9+x6tniOTub/7hO2LygB3PpHPRqLpDd6+eTwyzIFM+?=
 =?us-ascii?Q?5EJ+hUgMsB9teryhQ/BEQ4pUtB4ByHVOQ6YHZeJYU78flAG6MAm6JYfKzaor?=
 =?us-ascii?Q?MLr2goWPJSPgyAay1txqiRdREL/Bmrbrxjjd1xf9ENKevewJ6xFh+UdgZb7O?=
 =?us-ascii?Q?uKGp6oz0BUkgb2Gcih8zAgsuNdLVZRQaR9TeXIeWOC9+jElZG+O389goU+kH?=
 =?us-ascii?Q?I1eRKaHLO4mSvYPLInw77tG3cQ6Hig85T9PY1JA00X2bIXUuMUgx6WWZ+fCG?=
 =?us-ascii?Q?FcIqUsGVG+pqaoFRWVe+VQO6C76raIAb4R1z9hzuIEdmhfvf6cV2xnztaCbz?=
 =?us-ascii?Q?ZxEFzDuwvhdQW1ifDDsy6zMsc941ZqzikUOgp9JVhhEAcpOv24Pm88SrOJRO?=
 =?us-ascii?Q?AHddyPIgfZBYUeYiUKoyRLltXd2+/A6eEG36zvC+ohbJkEERVTx/cny1VBu5?=
 =?us-ascii?Q?HndLGTFbKa7FC8nQP/QBuOMI4eZdgfufF0iRrtM5Bih/vZVd6skOsSK0eonm?=
 =?us-ascii?Q?sDsDFsHiVTJWsIOBaE9IsRxcacK4qfbiUV9ibQEaJN0F2hxFLQQtjVLY5mV9?=
 =?us-ascii?Q?udPXAH2lh+RDVMOXAablW3FaCGI+5RcdOpQoyKAF0kquGBHBxuVZ9WjJjMCg?=
 =?us-ascii?Q?f0Qmz0rzMWfkuxxxAX/HsT5mjl07zvBsiIF8VfcKk8FdrifnAg1GKNUVAdx2?=
 =?us-ascii?Q?QngduR+AOVfydYWK9zlf9NwknuDaM8cM74MIRgHsDtyCby5k5ALPI/fgMfQy?=
 =?us-ascii?Q?5lzOvZ87fiyz9ZcC+qQQBGGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a616cd50-686d-44ca-d928-08d963ee2495
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:11.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTds/uPXAJhCRKuCYRjWBXUY0miSWOYiAqX5vAfA9tXYsEWjD6HxEOMFQ80ds+GqreuQytRsi2gXvPh/W7RoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
index 5ac691c27dcc..edd4a9fe050f 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -225,6 +225,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -241,8 +242,58 @@ struct vmcb_save_area {
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
@@ -270,22 +321,14 @@ struct vmcb_save_area {
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
@@ -297,21 +340,21 @@ struct vmcb_save_area {
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
 
@@ -321,13 +364,15 @@ struct ghcb {
 } __packed;
 
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
@@ -397,7 +442,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6710d9ee2e4b..6ce9bafe768c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -553,12 +553,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
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
@@ -585,14 +593,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
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
 
@@ -2609,7 +2609,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
-	struct vmcb_save_area *hostsa;
+	struct sev_es_save_area *hostsa;
 
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
@@ -2619,7 +2619,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	vmsave(__sme_page_pa(sd->save_area));
 
 	/* XCR0 is restored on VMEXIT, save the current host value */
-	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+	hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
 	/* PKRU is restored on VMEXIT, save the current host value */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index bd0fe94c2920..8f4cdb98d8ee 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -184,7 +184,7 @@ struct vcpu_svm {
 	} shadow_msr_intercept;
 
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
-- 
2.17.1

