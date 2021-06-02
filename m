Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC160398B8B
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFBOHY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:24 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:45825
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhFBOGy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUMMebSC3B5N41Un1rN3/G7lAF+e2xEwpaIGqQ10ZguOh4UO7advMUfRhJd63m1e4IQOfRUJyHLU31nb1rk+A2QHOOCi3yElP6SyKVjD6XcJ1um7c2g5K9zt/sATLgmGSD+dwIq+sTlmz5TZ+jLt58Lz7nVy26Xw5zdw1oMko7GJGr1CRD6tL7WDSdT77rX0omppvi97S6Depi2HzAIjdq3iza4UNEHTRLA1EUOrxQfLrem6MPQmUNKqwI80BhUeqak9YC9ezKUoJAD+6TyrtPAPmk9STZ+PA6wRWAULf7uztoVG2tHW+u8klg6UUeOtIg+MqrmNLBOqIGryn39lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awnMpOPG0eeizOJVeGcQAnq9ILBGxpAUriKoAFC3lWQ=;
 b=khm+84Y8lNl7RXV1XAjyy5QRsFd0XgmAhvmeuhiQYkRZxZuG4aUT6OZN8BLgadyGZQvyz3TgTpRQVIuWTPyA9O9e8STAx9GI1VjPglsFOuOj2qfTNJiVnnR1M5DkJrIYjO90oTTPVGBGnIrOLFKo8jOQunsq2zci14Lvh+uui1VbYqL4hbZX7KqJ4dQoOzmZVHUre1hOjPd4lldqzs9aiQCQdCWDpmbAoxxOkfyyonaOXvyuIf4ffdAV386KFdQd3QY5Gi//avDr5k5UDJKSEEuxzKBS/1+ZIbnAO4X2IqQFal2r65v6WaLAZuXtyp/xb/2b4b+TjwDQ+Owi1xCuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awnMpOPG0eeizOJVeGcQAnq9ILBGxpAUriKoAFC3lWQ=;
 b=hLT7p4n2ekIYfY6H9VepEOUq+AK5vi1AHoOdzhZElZ4IuPEuyQU7wIWT21e45rwcrP532qTR7K5/OfId34H688eCA9KSQGO4yGjtQH/XxOB9DTGVw9UngAHk0m83mLEiM9Z3toxs/Rl5WczP9mYvXVjLXpHlkkC2z55cQABNqo0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:08 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:08 +0000
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
Subject: [PATCH Part1 RFC v3 17/22] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Wed,  2 Jun 2021 09:04:11 -0500
Message-Id: <20210602140416.23573-18-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b517165-5d82-4e49-7c46-08d925cf6ddf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB444640A583EBFD6DCF0A3760E53D9@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8aqpmOh1Y1s+WFbmvd/VCe19Wlcyrf+wdck0c/PqZfVXlJzKyAJ4wQrC8r+acusxgW3JW0M0Rok9DE91jUjb3PD4h6HEYw4TJKLaP/rrKzzVGlYRW6weSLHE7jtqttQKAWePg54rDxC3+YHZmmUnOCDV9vUT7Lg45E1/YWXy0WgvKqK3VPkDerl/EnmTZw79WkCjojd1w6h1klkCKE6C20ws4YE4Jy+5lf4T2y8uKoAvU4SEhnTIZFQrFbotxm+X/Y3c6MvG5B5ghCZGL09SCt1OFdwG/ll5zabKw3vyhP9Wqx/qcocVoS/vDRqbA8/Qj0bTE11zBBcUlhuwiA24t2AZ3v9gqNSqb+604wjH/dFVJtrCVBNohkotI081O5TO75A3K7XbKqgTvR5itnW3iYjrRBTqIVkRjCUNvVMkeUHW5JxpY4d1TWL7YPnE40LFdtNONvw87K6GehDkXk0V+kTgl9uftjRrvgc0IbfAqOjUTxKCVcsHxkahajA8JzYpx7bU5pC+khaFt6qSfUEJSdPCtxwcW1L4h6KXEbULJyUZQX+0Ginjvk3Xg/5rq2VWofTzwcPr4sYCCvPBq381e27N7j4kUegQPw3xespUuAeoo8a9m7LNuD8t9omAZqD+UAcrErrHChdzuF3z5V1/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(478600001)(8936002)(7416002)(16526019)(44832011)(66476007)(186003)(66946007)(4326008)(8676002)(7696005)(52116002)(1076003)(86362001)(83380400001)(38350700002)(6486002)(316002)(6666004)(5660300002)(54906003)(38100700002)(26005)(66556008)(36756003)(2616005)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VZvm2oS1zVwcvRPgpHZ0XwkDyUYzejJa2uiJ/YhRKKVTSiEre/tSYuUkS3d+?=
 =?us-ascii?Q?baiVuOS+YJNzwL0pALBn/El++z0IQDkm+5f1pE22g0tdLlyfpJGbhkitfxhE?=
 =?us-ascii?Q?pBN571u1pUbRVx/7HtauMBhd/coP1jd2S7fEQdTuA6r0cLqtcW1x+xJnzD8S?=
 =?us-ascii?Q?4VDivh7uAv0DrxuTNXPw32m+Wn+JqgccQb5rbkjz2VLAoO9i1iNMpwqUr2UA?=
 =?us-ascii?Q?fFiQ9mWLcXrIcD7KD+3QktqRx9Z10uF0K6Ehru1sAbRnpL574Z7nzHNo95h+?=
 =?us-ascii?Q?DGFkPCSp5v9xPuKRH9ewM7iscbEDcjsbbp7tj9ZUUJsRdg6+/6EDJbD1K6t7?=
 =?us-ascii?Q?Ld+7fViLPWyV4vdw4OQ/cMkmY2wDBQArGhwuO+JKF15CgC+sgNol4NHuSvWq?=
 =?us-ascii?Q?cCUZVs/UVvGoLSHAQt/hxdpYN6hmRbM0C9y05Zt2zBNxVKb1zE6xggbPjYKg?=
 =?us-ascii?Q?leq3BwZVymEd8b0x9xnzCZ57OFLfJ2CdzrouRnrZ4ivWXPjW5vH3GgyS/g6P?=
 =?us-ascii?Q?2eR2FywgJf0IgCogpP7BNk6yHNSFmkQXWfRBVObDHPg67e93uqTERDzEkCds?=
 =?us-ascii?Q?ksf+YBinL4d07gxsvYrI17oFIlrBsOM8N8HXMABNh1gXfr8duAtEMZIKP+A1?=
 =?us-ascii?Q?I4bZgQZFqcOG/k1MuR6lTHpr+OWm5jXPWTaC/0afV7/7IzBGpC1TN0Q1too5?=
 =?us-ascii?Q?5e2zqFX3MB6p3f4otp9mGW3DXj7NZgqJEZGMzziasTdmvOUvwZNvClapOxcp?=
 =?us-ascii?Q?WJ1w/F3khoOj8lIEyZKMG0U+4lQE6EIZP+wT6jHgRmh9gaaQgzo5n+5Eba/v?=
 =?us-ascii?Q?O1dgL8gQoN0XqxsR52KOBTUyyrVmsxa3JVbJzB51KnkWOEnvBeVTCnB+umnS?=
 =?us-ascii?Q?pxsN3biQ0BfOOfXhKIim6cBMEEH40V7/J5p2d89zb75uCGfa/zojAYxLJ3Ly?=
 =?us-ascii?Q?Mea2eb4ns+8Y6T2Aov4Zh9rk8GePMso3d17xdIJ1ywukJswsfZXwMshzshih?=
 =?us-ascii?Q?n7Aw9yk/FRbJii3QsjhvH9BvtbwdeIyYHh2N3KM0FofRFB5Jhd0mAxEOYLXS?=
 =?us-ascii?Q?/AAutzGXTWWVL1X/IQL3ySYf0HmK5RhJqtFt853/pzYiE7g63CqfQkEfyZVD?=
 =?us-ascii?Q?nb3KeHsFkDlvhJBdP07uQye1BLAjojOsOr9WWQsxV26vB9mogGeIdoKq2CBg?=
 =?us-ascii?Q?MoAsiitEj+pNnXBLKCY5LvC1U6FCwhZD/813b7pQqj4ePcVjg9sg4XSWfnbW?=
 =?us-ascii?Q?kEah8DtC3OH3pRakYft/LVZSchLkT/cBSDW4k28Npag2Z0hXLbiG0SnVCsZu?=
 =?us-ascii?Q?RDbHPhh6J8hLELchg7Cur9gy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b517165-5d82-4e49-7c46-08d925cf6ddf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:08.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NnJhp2TN06lMN0xBvP/MwjyFVX85u5vTieZSP8ndXHxwCGWQ4+W2nYCcZHsLyaYzvgbDiPY64kqz38Zf7puHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
index 482fb20104da..f5edfc552240 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -346,9 +346,49 @@ struct sev_es_save_area {
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
 
@@ -359,6 +399,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -366,6 +407,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -437,7 +479,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.17.1

