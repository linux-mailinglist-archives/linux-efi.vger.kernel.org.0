Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD63F2F3E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbhHTPYD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:24:03 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:40033
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241485AbhHTPW6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw3tmFaLRgme43UF0oViZnMmadDyqnI/osJMom5NQWyV2FI0fXAosJn7Z5f56d0D70Szr3uGWnFUVMblSzTTU7T3GQNxY25wlKuK89g+cKtMucn9nrtFAm8SIPIRieiZWVkMfY+M3/5NVPyqqSnlcHMyhU0eWUV/lXBliwTU+cRe7S7LAquFC5/EtekaWigunIN/m8yo72DQef1GI6j1GOyfsVjMF3B0ZUNaex6TNudjbHtQU4/e3/Fa3PblJdIpkJSlJ4WfscPZABiLMybQ57+EMmHPr4khmVtcTVTRwvxdCZ6z5CkW6e5XnrKuuLwZ7sOjZYAc8eIvT0ueLHSCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkpMle4fHsD+mPHzNCmEuQid6q5e+3TJeFQRncpp600=;
 b=JiLWeseov6fFd9THjV5njnC27TuUCkHMAaM1mJt3mUJ7E9zZtG/ALmvjDCK2NnpOUNxcDRiubF6t0uKWr/GuwYQ9fQugNwsm9Tk39LD2Jbn/rQZ2HXQRLhxGgRHztfbFUTqPtaI52Vg9AWt5omeMH+RsCcS4R2yW1GpZffdWfsCGn8Af9WhNRAXwh9gfJboK/byogianwFdsWeihAW0ZLvp1j9igBBMlUatXyTJNY3EmOjZd97ZJduKsvcP1yUUkC+HWAxBXleboJGEQBT6JVtXEfkARE2cSS860PbJ9Cp8Q4fDCHzqB/TT+voaw16AQrj1uitali0D1tkjLB91UZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkpMle4fHsD+mPHzNCmEuQid6q5e+3TJeFQRncpp600=;
 b=IvMvJVIPwhL0XLcI08f1bzoAUqof4xkp3EiHwoIEB6ovyYDWH6FG4IYNunI5u7LBjoE9Dw8yQfaSkuPR0QGxen99wfSDol2b1ZQoS6siJkyt7uDNBGO3eAMa2Ix86z26d9mTthP2jEgOLGOzKJActTftoofZlX0thAzb84siynw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:13 +0000
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
Subject: [PATCH Part1 v5 20/38] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Fri, 20 Aug 2021 10:19:15 -0500
Message-Id: <20210820151933.22401-21-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94aaf9d3-4594-4309-dd08-08d963ee2553
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446BE95CFB3411A55151658E5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m18X1DiZePzsx4xGP5KWiLE8ACjLXWmDTxfqI611WNaC8IkdlYmMP5UQUaCUisd5BLWQugqxsmhTExhjquEZ+mKZOXnTa36Nv+ams4hYM7wWuZurNeL+ZGRUisHZbtfNfndWP1zjeXmMlij7FU84wuVeGyp6G4LibhuUGAVRJ9UFisk6FGCYBjhBD0t8kI3AGfmaaOYsuRCLI60LRS0AVL5Lj3RiSZIEcyKWOyh1mp9OEXO84kFUEE7cnh47bBdlgtJZ7IZsZVBFN3tsMjV7vOHVQ6TXz5M5giQowMGUNLeRyVguHZOw7FgBpSaPAfMM0hUFQmfFwGmXe1nZmwE0qcsMaVZ9xY8Xz1aHQa3ipx3ZxP2AFNNzzq30P26Iw8dbE7Wr/TLFHjReWsgSUMd4iF9C+Lk+869IQe9u1ydjQ7pjKlDLiWYt0L/dlAvx4DSrj24P6pEP1s+vhBqnyax1dHh6ISwZ7SgB/geDNlK7eKzzNgk0/oBKExlNPry+o4w/8zt2RpRiHOnOx4lh43OW7bAssI26zG207RrsFPBmhn4PTahTjcESlJB7Z3kRmWOS226VQl1+XvfoqbSh7NncJfeGTdv89I9p7UwzCJKmqQ7gTgzmc1PrPbogN9/NfKwuKXiYKYkt15Jp2GJY2A2oy7+BdnD0TnfONZ7xh9Ku2jCy62yDMAYhV9fwXKaqujNWpPUWKb56JH+E3wAJXo61Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SHOFRcAqJxduIXwJxs4/qky8Z+K03BKRXCVlBYQ5La3WBzFtWP/MHLTxKa+m?=
 =?us-ascii?Q?/EttAP1NfadmJMjI8eX2MhGdI+mxdjpaZh2aP/JpPv3PV4HsLgpxYW4T31VL?=
 =?us-ascii?Q?yrquNH0xJuFgxRA9L4coy1QYYI5a5vHqxfIbv3KY9OzzHx9k8FUisz9B8mOo?=
 =?us-ascii?Q?px/Po5xDYL/DLj+bZrHuKYQ3E0TQ/bDlA/FOQgwDeMZmoKeUutMnx2yXgwuM?=
 =?us-ascii?Q?c5Otf4GHgU6h0dA4100pGXbYLCumhqLY7TuJSdPNCr31DjJ79Q4TiGJTjdDp?=
 =?us-ascii?Q?CiBwylQM0XirDKjQaAYFXNjEcmKile0q7kh4b5/Vf3VGk12pUlhDAg3oeoD9?=
 =?us-ascii?Q?OIVT+r4wlrB8SfzfFy+7xtHBNjyP0eYgyJZPfK12ZzmcNQuJc9OCFYh1QwTJ?=
 =?us-ascii?Q?XjpyzMQ70vj66nRUQxen/WxB6ga3wvv26n+PJ7Y4hQofAePtb1n2LZgz/TTL?=
 =?us-ascii?Q?unuDJ0DzKL96kYc9M+0l4KY2aQHVV4H26JVHGz71qVeWTwRaPrCqojhq8wbP?=
 =?us-ascii?Q?tOBchSM2N2CLqfcINQFhGYJmhRVwMTTLA7quRRTaAqGycdQvPd7o5+0XADEY?=
 =?us-ascii?Q?vMjl1qv/z1sD4GddH59MsZkNCDvZ+78dy40FK0eiM6elBkuYfWZYUNKU0sge?=
 =?us-ascii?Q?o16e3M+5JbYYkeR+yDvxXparKFbVJ2bunTNxFrsDtRJEOK1EFfDNtDINvwtC?=
 =?us-ascii?Q?+vqRLEL5GgMba3hmgLB3gAMxNZcSGp/hzUzmfg90jvrPDu5qEhiKjp5Q6tI4?=
 =?us-ascii?Q?p6JwGE5IZckMThMnZPuNOhD19wh5UPCvuy0OPoqKx6zJrwpbSMo4Lzd5rMoE?=
 =?us-ascii?Q?rOVUu4sf4V31G2UVwZt19/hMbwPNh3hsSKSL5v62ZOx2iA/Ofol/n7tZhjfn?=
 =?us-ascii?Q?hUmpv7VqtLeL6/cGiDBlhQoAbpQAdyHLYXwFSmvNRliJ9zs0XTDnCXpfDBGz?=
 =?us-ascii?Q?jKg4v729xyTv+BiXBbtyV/rmBXBfXdAJX2SNu0tahM6cn5kDlWihsQuKZF54?=
 =?us-ascii?Q?D1R11HJiNYOMav8ll1nIouQTV6he1itfkaPnLs/nLnKpAhlBvbQ5S0BeGa9V?=
 =?us-ascii?Q?I1gNqA/CuA6yDxWwRv+fIMDApNEPxK/kSsQBI+xeu7MDtudoOReMKDPO4pJZ?=
 =?us-ascii?Q?O+DCth/fyu/G/Ws/+7A6nAriVlHOyg6M/TSxIXeL4XAJXPUzM6WW+gYEAhMW?=
 =?us-ascii?Q?izfkmOa4ELkadwNRn/gR95GZabYmA/eSSf3X9dHSqs5hoauXpZSHwG0E7HQO?=
 =?us-ascii?Q?//XBnOM53SAxDVWi5O8oQu2i0V7SeGY6wptCdE/HIYADlNME98yOUAKRmKqW?=
 =?us-ascii?Q?1+8gDNKdEkcHX6T4Jvwtsjmd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aaf9d3-4594-4309-dd08-08d963ee2553
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:13.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPi2vbcc5/sTslOlQD9+jmnwS1SByO3NwPZfNcjfrlDY0AdReCcEkLDjtV78dZozO7ZDqbuV70JpJa7wx7Jraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

The initial implementation of the GHCB spec was based on trying to keep
the register state offsets the same relative to the VM save area. However,
the save area for SEV-ES has changed within the hardware causing the
relation between the SEV-ES save area to change relative to the GHCB save
area.

This is the second step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create a GHCB save area that matches the GHCB specification.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 48 +++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index edd4a9fe050f..748fe1c82a2b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -352,9 +352,49 @@ struct sev_es_save_area {
 	u64 x87_state_gpa;
 } __packed;
 
+struct ghcb_save_area {
+	u8 reserved_1[203];
+	u8 cpl;
+	u8 reserved_2[116];
+	u64 xss;
+	u8 reserved_3[24];
+	u64 dr7;
+	u8 reserved_4[16];
+	u64 rip;
+	u8 reserved_5[88];
+	u64 rsp;
+	u8 reserved_6[24];
+	u64 rax;
+	u8 reserved_7[264];
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u8 reserved_8[8];
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_9[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_10[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
+} __packed;
+
 struct ghcb {
-	struct sev_es_save_area save;
-	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
+	struct ghcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct ghcb_save_area)];
 
 	u8 shared_buffer[2032];
 
@@ -365,6 +405,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -372,6 +413,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -442,7 +484,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.17.1

