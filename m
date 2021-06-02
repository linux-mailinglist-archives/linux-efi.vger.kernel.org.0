Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8452398B76
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFBOGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:33 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230219AbhFBOG3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ0p3vcgw7BRLNDeadcEFJxzSRyJDMgiUX9F+qtQlyIuaGnyxq7ObdzV5nsjCRnTDKXONapQRVKomJVHh1qa5xQmUNZeDnPcUMfeOAwoE8YIWO+cGBYMiAbhJygg0GW5UFgoBI8pFCcGQZFjpVbaEXQm9ToQiVACigo2nFU0EahWxzEmak0YlZNBQsQi6xiKg8wPMc4swCoLLxJShHw+vioXsKpmjQBM7yduQw/199VN2s2nnfZ4ZTwgeWEHuCRMz1t/yK5TvSbcqeSW7euQj52AR7pJy58youGsganFQFBhGReTIvCoaYQecd4vRou/iwk6w1p79pqtXlEQj1/19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDAAxGKf2HHTkKuHK7BAQsc3Qdl2XkZXTIouZzepTdM=;
 b=fnFu0G5y7zoEsb41oSKAG451UkMvmTZOw8b4kMa39qsMEGObMIIEkHLE5GVUjiEsC7MSc6pz6EKeCnMrazA67O9Ufjg/VobtOI8+NQlFndcs/fXeiYEE3KRo83nsVgLcAYRouRpHakuNDjfLHT12EGivkJ/rrkBLHiiMTmoY5K42RWQjEFUmtH0AafQrrtuAAQUPSMvWIU4TomXuJZM6vruBL+LUes15geYarcCW3Co1fuvKUaLlIof0Ag2C7BvpOF/Syh13zb8Yv9r/bjoyIheplp2oL8x5rJKUijhg2n7icsYe4SMLgw0ilC3VonWWQMlaT4tNxYLJGMb8JogUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDAAxGKf2HHTkKuHK7BAQsc3Qdl2XkZXTIouZzepTdM=;
 b=ua/rneLf40NjYU73eO7zxbW2zv4iJGdOtcD7mVrcO/quQWfYTaValpGcq3nfQbVSupW2GVwd/szr+GvvXARGamGKU8ADnQHad8H1I/5PW+8AiA5U16AO/ODCV03qvs/82ezNrM9mzCuGxp00zGN97RkoAmln3V0EuPVsfrMVlUs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:44 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:44 +0000
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
Subject: [PATCH Part1 RFC v3 04/22] x86/mm: Add sev_feature_enabled() helper
Date:   Wed,  2 Jun 2021 09:03:58 -0500
Message-Id: <20210602140416.23573-5-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9df45f8-bd74-4bd9-89f6-08d925cf5faf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45129628AF0FDCC957B10896E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4qCUcga+1tm5RIcQH19v9or1lxTOh2BVJq4Obmb2116FrM5PQm/SQwXjKB3UKEqP0JBaIdwJlaCVBd41e05L7Vs0c1Vbk/SmW9cPDUKdO6f1jPL6mlQZAUeM+quN6sWfMPF520pr22MvcvyN2cg0vL/PPV/U6BqpRMk1DDQ3Kixyn872LRbomsHn07QnEdOYLPAodAkqJXOLHH/kvrXLxzWscqt5nlxqkxTN6jslfW7oxuZ+7UNwiK5IooWBl5XC07wQpEYj34EgYai//kvuXrYnm01xYDisAwvQqwp2dHoVK+KgWV91D2OZ/3mnAHt2a36PC+Eo94HSNrJVToVma9apijlrSwN6fud+qHQLjNeMbH0KvjFu3FuRzt/R5a7lUdWh6iwYbTE6AwuZPqBp3oVgK7siLyhDw1B+WC3igE86ugq0t7qZR//c7JKHQwGCXFiZf72MJDBiS3NIRTFgsG4ljCUf6pFGX/pUZe3g6kH6lCYgRnMnQaHcq+cq3S6KFjnhkWXPtYdTTmsExAj6STV3nUJA3/McDtvPU9inxznmxdgt32KXJqDT1dbq96zJt/KXhBQq8uX4azGoXnG12qpvQbFddmaxmb6mTLGyCTNbU+rjG0GM2y6ZNUDCt2ApstPRKwEfLyWr/Pq6SAIeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sQmOus0PIkuB+UUfBy3b5b4U/fKErMpKFPgXiATbmAiziausYTNHITNm33eH?=
 =?us-ascii?Q?hGKybDdp4hhyFiePYlbsd68PGYVZlYznCPAgpzSPx5xgyM+3qBqev6S5F/dh?=
 =?us-ascii?Q?V3O0vKM9wH3tIMgdn1jUSRaKxO42hHE3niyRgWQIXpxTOkR32VCBTixmiDfB?=
 =?us-ascii?Q?OseAMONJ9bgDdkuPTmNulg4MfFzGIAMlq8f0segOkGbtWcj/jcJ+5iIUEw3+?=
 =?us-ascii?Q?9qrV3baU0T/riYBtMuyyeDdC6eq90UNhYdGeF+GfSZFyjieIC8KeXx/27ZRJ?=
 =?us-ascii?Q?qsFy0gRQ9vMkf7bK2lwF/IPkelSI6Kwy5BEoykNSYqJnu3Uvoif0/1itCtP8?=
 =?us-ascii?Q?GKaSSTtlvt+IIz9oCaJqZ9v1ODMyaU3QT//n6wUYdzuMJwSQh6KCSQsmfbbq?=
 =?us-ascii?Q?+oMU7TQMi6lLp66RxDdlqG/Zgt+z8CmCg7pEU03Nx5KDHai9bDWd7KwRgEBx?=
 =?us-ascii?Q?mlF/x7ISncKgyDBQNSEfX16KMgj4GbQMhdBM4P96whUQ3I138w4dTcF5swSH?=
 =?us-ascii?Q?WWBI+5dA7YO7Bbl8rkbU3nmqUrgORNZfCaKnk65yqnkYddynmAJrTfXtlpje?=
 =?us-ascii?Q?/698U7s9p7f8t/N6TZdtECnOF8RTtjYOncqu0W4J1iI6a6qni3fOi09WBAbu?=
 =?us-ascii?Q?hVm1yYGq2uZ1EA+C8GlKvuxusComeLZHCuAPqqddXKGeIUE3/dke7LZBi7I/?=
 =?us-ascii?Q?CJXIl3D5PownzliZyMrvql4jzRIFaD/kw78psfqmzLFQ+aFNkuGp/L3Udd2A?=
 =?us-ascii?Q?hadjBlvVhui8ZlkpGlJDMFdL7ZIWXPtCJcU39tq0jL8rrWFaQPug0fhQ9kT4?=
 =?us-ascii?Q?W7CD4fEu88c2SKCnItFaW9uPffcIZCupGO/BBJSVgmrwzqpOauJyTM5x5+Pb?=
 =?us-ascii?Q?CsWIj1Q5PnaKZdeBfsNXx1iAttgnGoJMXgabBa01RKKfdekYDqCgtAhPS0aA?=
 =?us-ascii?Q?N1FnVpNMUEDDOuqrE48bNeMk7ahyKBLktMs5KFihW8DC9WBPB0V7mZlpMBGl?=
 =?us-ascii?Q?8rF3Xyu6nPqNdGkVKzVL3NRSG6xFlTC9Gsz+/RE9ssnNpPr7csl9U+RTTBbI?=
 =?us-ascii?Q?E7pV4jk651Ldhsn0JL+B9yGTv2444wcliboZLzUrXjjsjEfq3hEA3OH3yqZ+?=
 =?us-ascii?Q?JrGHj+7j0X5U456wkTlnY7thn/Jji3t2k6Urg0/KjDAFTuvAXpQCFfUjCfZ7?=
 =?us-ascii?Q?vLkjG6dr0wUAxP0ch34pvnlMpzVJ4RX1yEO8gnIjBDuPRPi8bK5EfuFjc0ev?=
 =?us-ascii?Q?rGNt9XMd9XFzrQn2/w85HnP3ZJw3bF4Bio55faUih2Ns2h191fksXx9kcsJl?=
 =?us-ascii?Q?tZcFEeUOPGP+1NLEOsyh4MYv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9df45f8-bd74-4bd9-89f6-08d925cf5faf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:44.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWwtlS5vwExEVvI3ord/e1blSOBoaqF/6JTb00W7keg0+BOFR9HlP/5BdLFN8EOWpduhMCP6YDwmcy/NjLPz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The sev_feature_enabled() helper can be used by the guest to query whether
the SNP - Secure Nested Paging feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  9 +++++++++
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/mm/mem_encrypt.c          | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..bcc00d0d7c20 100644
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
 
@@ -78,6 +85,7 @@ static inline void sev_es_init_vc_handling(void) { }
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
+static inline bool sev_snp_active(void) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
@@ -85,6 +93,7 @@ static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
+static bool sev_feature_enabled(unsigned int feature_type) { return false; }
 
 #define __bss_decrypted
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 211ba3375ee9..69ce50fa3565 100644
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

