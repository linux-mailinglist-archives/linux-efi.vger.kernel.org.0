Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3225B3F2EC5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbhHTPV3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:29 -0400
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com ([40.107.100.46]:11233
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241033AbhHTPV2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpOyTL2h5pKL+gwbPR3HlIrwheuX3DiQt1HXG8lJuVNGgps/c+I1FvKfpncksNmqdpBLXSCXW29QiO5gjMbOGZm7jAhZhrdFB1+Ej9L11Fy1smrV8aa4Ea0Shsar6kdp553E5xwUCZCl4c+IgyJsfjnqvT0dZwMT8oJUVTPFz94DGssrvJa8iUZZaxiKZEghPXal7YGY6fEXsWanAnNv8abjBtz3PlfLHvyUTdxgn6/KT70g98djzd92LgJZTjokEN9nO6flfaFRXMj75SdkzhSIE8y2u/jDr/lNYycbD+qArATzA661VNT3gKjw+9y0mkvw0UlFwwSaqD/onjTnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v6YTZghRoGRa9/aIt1C8yPC0VleEhMBpxR81rxlubY=;
 b=hFt4YouKzbFmTcAJNON0tnBWc5AsABxt0MQk8R11n0/y4uZSzWYWKP+e8ywmIZLvLtWiz6i/TfaExwnc+VUIWLlQ1Pw3+80VC7BQjEQRVKSd79RHX3VK9kx4+jPg3qsxp9FLX9qOg+rgvLUVCMjsOa0a7mnUMVoYjfihkDrlcgqDsLvIuJ1tpJB/eIAnd1ujXH+XR3BPX/8EzSzRo7igE33mgwPH3kH+9Wy2wa8AXp2JlSB2+uWsMeVEPNck8B3Vo0yovvpDZhWymFIMRx+UsPvQQhmUlpKVKCISFoit2o3IUIMJr4zkre9PTF1mMjcVHeD75Q3bLDK0xn9cariPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v6YTZghRoGRa9/aIt1C8yPC0VleEhMBpxR81rxlubY=;
 b=Y4GD926acpATchg5YrnOubsljyfzx2MkzBif5ZA0NfxBdqwBMTV9bR8c1QA2uexNlpjICCYL3/W6RFC+xWz1/O9+5rYnmmKDjSkPwCYYfEKj4cHK2f+FBgXA3x7lG4t//znNFGOMtFRfGVSKcS5SCaARnmJEQJLYUFw1V9wD2cw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:47 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:47 +0000
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
Subject: [PATCH Part1 v5 01/38] x86/mm: Add sev_feature_enabled() helper
Date:   Fri, 20 Aug 2021 10:18:56 -0500
Message-Id: <20210820151933.22401-2-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25db4fad-6bca-49c2-a950-08d963ee1607
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455799B3F27E574673DE96F3E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hM7Yxs+PWpiAsD19GZbjEbLOyHjklluJzWAxupwT0dg7hVyz5wI2V5EPUN6ZC82E4X8xpXSV575KdsuPBEhzYa2QxvT2bwuAFDQgJEXixiY/jHFTTTx1XWZUmptgqe8xWK4BMg1aLyojudVONv28NM24AhDrE5Q1avuB2UOjuC1hIyTjnw1pT372BkP5mLDVaDUwsn1gX2yy0GgQNtJKpmlN3IEIRXlZ7Sp2WQCMSIno/Y/Eu1gEWAQJSy1bRFjENWTFWwTTRaUm3UlplOnRsutM8WYauOPZ7zV1jSziy54HWLe5ffuurWQDlwAwjeoQmOK+8u59F+dek+EnDxdOf8vCVMg78nHSX5otxoxT5G2lJfzi3KrBe+Uq/xn0qk2SD9doEuQLrC44qxFoQ/IOwUkvvGAloFMBCfDFo0uPQjJZhEZg6H0ssy78sbif9CaIOz0Rg4FiRyzsiRalAsvTK+VrSZ8R7rso/0MnLilDQSO4CcHUz/ThKsnzVPAqEd9qsv0oyHECQC9zbF5437cW7pS5NE7kRCI2pTsB3S8mUjIM0Dr0bFCe3wRsQE3TKcZe4HEWbVyVdehm7uDQV+apILX/lv9HEBqhVcJqKibNzABCyvTm/UJwW4bg7Wb0cC22xmR8dZAWmDeKbaU49fEUWZwOwAuO8qwDD+n8xxzR9/mAIqf68plN/XR7aorgPQt3Uc02aVRlQgAeCMEYx3k8eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(6666004)(36756003)(186003)(316002)(8936002)(2906002)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcUs3C9GbJ0AqEKRIToY5HojnFdKs4mgK2mjfuL2ZKCk0Sq5F8pfnpbXvc87?=
 =?us-ascii?Q?OvVowYXczJ7GcYrZB9SHb/TabG7ZDqXTQwAU43thJI8F+Ot3IWlHRWeUPAwX?=
 =?us-ascii?Q?jlAe0CXZ+eWZlUZGU5VP09y5JvpUskG5bHGJ2fm2BapwrVLrf9d3Naja6Xqf?=
 =?us-ascii?Q?9yoRCow9bKtha2VTZObrJLO9uYJKGTsHb8Q2OWbubSXNhC1Ubo7fnVkeCljQ?=
 =?us-ascii?Q?tw1DCyMxw3jGj5hdI9hHrPtqzttbRkn3ys+Hz6nnzzR3PniIr5ZAwmu1rw6B?=
 =?us-ascii?Q?kaojAyBNWAkgJowUzM6bWUCM+ICH0OjFfLFB0Zrh03fOBEmVvCWMheJFVelI?=
 =?us-ascii?Q?CSbkbG56R3lYnPxEZMWO65rrehrePT0OTv7D6l5xLI0ycTyj1fbp9gk2dOYc?=
 =?us-ascii?Q?6nAjOzjWm9esf/BlquzQW3C73moEYA9cCP7W+oMkRuA0mkD0+3NE2bXiy8/F?=
 =?us-ascii?Q?B82BODz95OaaLl2ZGTlnSrlvMEOLkvXyqsYwQJUUGtIltix6vscfOLCqJrdc?=
 =?us-ascii?Q?oYXN8RGj8R49PPLWef2/su8uk+erqK1Zr0vJp9+fEs9Px4hjsZSZKyl20IVz?=
 =?us-ascii?Q?KxCBlzgKLtn2LVowQnZK4KowpvJj1KHsi/ZkIbrB9D5zvDXa/+YxNg8MJjHY?=
 =?us-ascii?Q?CacOfbTAQHsjjIKNrUHqg4rW7l9Gzup2V9rwBdjuIGo3Rd99DFKy0ElPsbzL?=
 =?us-ascii?Q?H7VV18OuJ8CtAPH9E/gngZAI9LtOOc+I3UHIGPrVd2LEqRh/zQXNtRj+CpKa?=
 =?us-ascii?Q?NRUQHhhlGr3EHYRwQgzHziZQwG9OLr4yqFCmVNQusMt8WkvyCKmS2CiOPl4C?=
 =?us-ascii?Q?5IpUEJ/7bW5zK5nKkb4kF17+cBJj1dPsj/UYExsZmm5lEojwFldP+wEt+DS9?=
 =?us-ascii?Q?kOB0r+v057z48eavIVd9rE4byVUDVd5kamNhaM8tuEd29rbEM8gWQ43tQAxu?=
 =?us-ascii?Q?WhnPgssiCY2uHoNTx8tI6vX/EE96eaaZCsxCZSKGCfxtVp2pvdahapCW4dfA?=
 =?us-ascii?Q?LsdFpu+FeVvpAPC5EQlg+3Fmvjzx/oLvUj07RiREV9X8tWf4m8A8BekxPHlH?=
 =?us-ascii?Q?B7bII5k329G5pY20iNxUPbOt30Mdr0tcElyGlC2xR3z6QJmOXvLp2kdhYQ+S?=
 =?us-ascii?Q?oiAL82FOHlCmY+x7megyAmjzDX4YaanRGmE7aeOqndeJykl4IULyyUgLJuuu?=
 =?us-ascii?Q?enVwvt5hB/0Z+kOSbV/J+2HlXz+q425VtD/wA3yFV3SZpc0nacy0GWBX18K5?=
 =?us-ascii?Q?QOhSGOlVW0y3Tx060wYCnaY5Y3HEcHYLGs7d3ed2TNPrFC2h6ixjLcmhabrD?=
 =?us-ascii?Q?lMiM1Ncm0yYAX4y8W4VmKJA+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25db4fad-6bca-49c2-a950-08d963ee1607
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:47.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkgCljRyTDMREW5mifhBbB7XnQHU4WyHPaV7YtLCpHV2Bme/z5LHNwh8pmwRbFJe6h7ibM+1P+ecPYcqQDtUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The sev_feature_enabled() helper can be used by the guest to query whether
the SNP - Secure Nested Paging feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  8 ++++++++
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/mm/mem_encrypt.c          | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..df14291d65de 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -16,6 +16,12 @@
 
 #include <asm/bootparam.h>
 
+enum sev_feature_type {
+	SEV,
+	SEV_ES,
+	SEV_SNP
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u64 sme_me_mask;
@@ -53,6 +59,7 @@ void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
+bool sev_feature_enabled(unsigned int feature_type);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -85,6 +92,7 @@ static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
+static bool sev_feature_enabled(unsigned int feature_type) { return false; }
 
 #define __bss_decrypted
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..37589da0282e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -481,8 +481,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..63e7799a9a86 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -389,6 +389,16 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
+bool sev_feature_enabled(unsigned int type)
+{
+	switch (type) {
+	case SEV: return sev_status & MSR_AMD64_SEV_ENABLED;
+	case SEV_ES: return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+	case SEV_SNP: return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+	default: return false;
+	}
+}
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
@@ -461,6 +471,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (sev_es_active())
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (sev_feature_enabled(SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
-- 
2.17.1

