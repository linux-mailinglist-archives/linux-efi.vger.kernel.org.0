Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666EF3F2F44
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhHTPYx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:24:53 -0400
Received: from mail-bn1nam07on2073.outbound.protection.outlook.com ([40.107.212.73]:11243
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241492AbhHTPXN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ZsPhGu/yduXLGZh4e3UviWjIwusEKsqf19Vfk4bgyt0VXn57y1/BbBpLzV6I5iNctejKO4pLkoQuefUqZy3DD9vFomiZHLswI9a/RmQRkoB+bPX0hIWocdatbfxDQ0jD0F3y5iTImwb5UdERLW2QikQnXyzJzWyPveX8IDbrioWrYrJ1nXqfLFBNuKd1Z6g93ni1ewZ+ymlztdgIv+pUDBEuOrcOLJ+2XPGxQly524da1aDWhVUZ82DYJuMAxXGGaO3v1d0VSo6boGU4eE5vy/4dQq6RnWFR6pPST9bx4Fy5xjmciaO4ld/EPylgAM2ocpXCq93tT41KRhed5cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJcUNVlui0PHuiBwQIVI8DOA68ENcPTaKmWVAZOdWzI=;
 b=eUyub166iVWGjMYn4LVZd/7wiD/4hXO4A/Ke9071VZswjGvZDWTLNym331kA6nLMc1AEritjx5f4Ikj1QIWNI2Pi2eXXTp5Ii2D1c5lrjedfXUvfiSptzyeNvP/7b99kcAFonN/d9yRFIlRhpLeP/wELw2wqBWioQs9GqFYNljXGrF3xjpIG3XZQLWkY6e87rCfiySllFp/GGj7L702IjMxizjSSKQSoeaA1uOwIRLK1JS7X4g5MmduyTNl0eS2vU70uwy+1yOn2oQuvbL4Uc1ygDK4jSt8Fqi+KFBcYQHSgH731ZKqxZr5bY7icwVYcvGdMqAukpIgnwX1uvXswqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJcUNVlui0PHuiBwQIVI8DOA68ENcPTaKmWVAZOdWzI=;
 b=HeKZP3K8oRVsDiPupyO9EyIUgMcPWZzbBekA9YzATauX38NNkcjNPOXVRsYmy6hg1qlqq97xSldn2EqY5/b3ReD6HCxg+R7NoK3CF363dtyJ9JUdlJ70EbJ9Y7nBXGaJxI0cpTx3/Kxgfhjrm2h7xje2C4i487znq1SiLn6WWvI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 15:21:58 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:58 +0000
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
Subject: [PATCH Part1 v5 31/38] x86/compressed/64: add identity mapping for Confidential Computing blob
Date:   Fri, 20 Aug 2021 10:19:26 -0500
Message-Id: <20210820151933.22401-32-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5148727-bc2d-4958-a297-08d963ee2e47
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592F6F7376D331CBFB5C9C3E5C19@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acvn+3OuHEMfTGo6eD+UlUJf59Dpm2jRXtadfZKicqYXKvmGsjIAJOrXOjYN1sMEqOfTpY26EE5l+AVX4qh8LS259N346TpQ04sYXIK+Adzs0YUjdKYGm8ntCGfBHoUXp3z7IZxj0u2eL+Ebfv78CXNXJ58R1crBVjvZxqufWS4TX26Y+BxkcGmcFSsGaxlLk7o0oBdX01LPwFtfQyFXyWl/7O9vfhI3Jip4cv2Z8jIs8oLuqg+psjidj7rzR1MazxW9b7M/gFUlXBVj8i0q0QVLGH3Ktf3972bUdAlIUUNFZNupYgxv1uWxXdiLHtOrn14r6vooEN0K/yZL4UnzeBsg/JJEFCcK9Tilietzvk3t9KfauDSUk/UKOeVnwER4K8TzUz9QlOsBACR04Z+M6UywjtIFFvtFWIgYowJzvSN+7kuqRHlJ+AMgYbPY9/TeaEnAvLCUfiFPxWLdhQePoqJK7jVq0OpALoiz9IYBb5kPcv/dSNINM2vXRoCxGVUr/LEvZ2aSxKHxFiEHAP/plmBgiXFPt196+LVasBzRMHNcFJ7Eny0b+7nxaJLI4/A3OV6JRykTSeOwfxNo0kEqd0fxJKA3KTpzVapWNj09CRbASmyVQdmVWd/+3zSRlTZ3XwI5LbiIK4Bmf72L4GwfpKVlNJS7df67oG0QcqUGWuD5HAV/LQXrgw1sMMxQabwj8vOmd/6jt0+FK9fEzmV1hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66556008)(6486002)(54906003)(66946007)(1076003)(66476007)(316002)(38100700002)(7406005)(7416002)(38350700002)(8676002)(4326008)(956004)(2616005)(8936002)(26005)(36756003)(44832011)(86362001)(186003)(5660300002)(52116002)(83380400001)(2906002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uZVRoR8VS+T/QrT3D9ljSbiTp5XXkKgR4HQqwQ/ekkN/8mbvHhf5gSyofbW?=
 =?us-ascii?Q?lifANB2NWJbWR2lv97wjcLJxTVHfX7gWEYP8/welVITUK/LZM3G+oljkK3RN?=
 =?us-ascii?Q?E4mF7QY4oUrfUYTliB2sozqhJVjVCr3JK39yTp1LQ61oq6HzKOv8dyTmD9kh?=
 =?us-ascii?Q?m3wmh1Y5ikpb4ADpkL9aRr54ReaJ9otM6i5ZLly7xecZpx1UYCmRuYBoO+a0?=
 =?us-ascii?Q?6ou6OZorzPnuYUGbEDRqpuhQ0tTQCTDzhxbjUqjIa9iXjSGV9eLugqrziOJL?=
 =?us-ascii?Q?ZZcJIXcYPK2Jk2ZcEffbapcw+7RXu0OBb/UaR+m+sGedEEkq9I3SpoKGr+UD?=
 =?us-ascii?Q?nZxF94/Y0soDOtN3mEWG06BHb0+r8G13j4Lry+eUMF85OY0wpyHlJuZWuJrK?=
 =?us-ascii?Q?vD+Dg7D+l00x9qNM3Sr3ji0bfwSb2xkbgmv8BqU13+hDOLsyNYtBTWF7pLbe?=
 =?us-ascii?Q?KTpxLiykZTJQL/6VLd+z33IXW9hTui5g7Xivgg9ggE9NepNy3cwiuQlWUVJ2?=
 =?us-ascii?Q?r4Fl4Yz1liC0iHnA8ZsfJrNw6IFY4/Zce1yIdm5mP+mBk0bYP/W5gsfW4U6e?=
 =?us-ascii?Q?E6HzvopoMcwsjY5O9NJZQcnRftCIFktmLjUdtAJNcbtZRuM7Qh2mBmwjSPw5?=
 =?us-ascii?Q?O1f2v1sSlAG7LPs6erKu9/7RjnxiDjGNddyYDdZA+GllXTdO2UEMEh3hUubP?=
 =?us-ascii?Q?7/NlRKhBkU74bZ70h1UNPyvM3Y9PCWi1sFRcaF2rsiW+hZ8zOeNkCBICBKbj?=
 =?us-ascii?Q?KR8910FVrImeJb+G7/q5zVQdz5Dc6edhRUhQexoEwD7fmh6k8kAfSDrV1Bgz?=
 =?us-ascii?Q?xGFqX2WGIsjjfkwGPtzIJURipbPzO75KU/Hbdg2KmquGYc46wXjLWAQmAccB?=
 =?us-ascii?Q?K4+RbQEYLB8ssmEb60hMbxzHYDhcnoCjTSU6Ax608x1EbNQGpYhM2HzeQYYQ?=
 =?us-ascii?Q?quEWz9WsRF3mHFsGb+tIdrfUCpsRRQMluUNF/EiXJ025diJgs/RkgoxoJyJ6?=
 =?us-ascii?Q?ymtrIqh7FQCOlcqy8LGzBNWkyPQ10BL9XuabtBrCX2aoGusqFs6xQyb3b0RP?=
 =?us-ascii?Q?KS/jpkhmjeuWSq0LqicqWzsCQsQyky3u83/qBiStDlt8XbVQJ4H1bfuKU9/p?=
 =?us-ascii?Q?psR7cvk/zIRf+UrKlY5/g5yoeqgmV6BcKhn2yyGSmow1k6MgbvHXkBnDWFWa?=
 =?us-ascii?Q?8WMzr77rjkK+3tZFLNGXx21tpJ3I/UxFBkdEcpu542VNdPAFqSvPvdYrrESP?=
 =?us-ascii?Q?eIqzZZD7pcp8mHtnEEiDYJ2G42/oXsNAPXwgdvLzPex/LtseMaW1LJEl0gOl?=
 =?us-ascii?Q?yE8qAlL3d+qafNMVJpMtlkvn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5148727-bc2d-4958-a297-08d963ee2e47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:28.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRdM5PCCzWOQrDO+4j9/nA+CDoDbwQjWXXvKj2RCLpxklLm/jck35oXVWftc8pAjSLBm35Z+9lZMBB9wSyjf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At that
stage of boot it will be relying on the identity-mapped page table set
up by boot/compressed kernel, so make sure we have both of them mapped
in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 ++++++++++++++++++
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/sev.h              |  6 ++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 3cf7a7575f5c..54374e0f0257 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -37,6 +37,9 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#define __BOOT_COMPRESSED
+#include <asm/sev.h> /* For sev_snp_active() + ConfidentialComputing blob */
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
@@ -163,6 +166,21 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	/*
+	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * kernel to find CPUID memory to handle cpuid instructions. Make sure
+	 * an identity-mapping exists so they can be accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		struct cc_blob_sev_info *cc_info =
+			(void *)(unsigned long)boot_params->cc_blob_address;
+
+		add_identity_map((unsigned long)cc_info,
+				 (unsigned long)cc_info + sizeof(*cc_info));
+		add_identity_map((unsigned long)cc_info->cpuid_phys,
+				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
 	/* Load the new page-table. */
 	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 910bf5cf010e..d1ecba457350 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -123,7 +123,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	unsigned long low, high;
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c73931548346..345740aa5559 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -127,6 +127,9 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+#ifdef __BOOT_COMPRESSED
+bool sev_snp_enabled(void);
+#endif /* __BOOT_COMPRESSED */
 void sev_snp_cpuid_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
@@ -144,6 +147,9 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
+#ifdef __BOOT_COMPRESSED
+static inline bool sev_snp_enabled { return false; }
+#endif /*__BOOT_COMPRESSED */
 #endif
 
 #endif
-- 
2.17.1

