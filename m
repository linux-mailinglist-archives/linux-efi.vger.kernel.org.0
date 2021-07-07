Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549173BEDE0
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGGSS2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:28 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:20064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231440AbhGGSSX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqxEOjLLFJ0nxma/ApIQAVG757LCr68GfpjpkIdDOXfs8SSoiWbm34JC7eKsG+ePwbgeJuJnVXQI4HYcrfyVW5rbc+MsL4w/XM1Rrn0Seny1xrhkFaBxdWevCA9zX0k6n/Yb98J7/4RnxM3QxpmZqj6lDZ6C54va8V+GBcyNFFfSCxD8OIwmzmIyWhOs1fIl1T2/zds9aRsFXp2LZCjzaClw8quT30diFiWS3FqA7WMkMo9xbpfvHtMtvf58miwDkn6mLOF15ej1jntpGOyVbM/5shwFzTyyJLvEZ2ot7zPf8eNz3YjDESMBnQTHPnzMKWpQxC7yfDztqypdDHxD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chVykgN7bZcIuvfIEO5C/ybi4gNYMSU5TQGwpDsi530=;
 b=kCrFp106JMgVcyldsLANks+s3z7UH/rvPDeMy11jbI1CaLrRvHlOyvhlxFvRkCxP3EqSr25cR5V58DHnjfInlFyQHGarr2rVkqntKoWsKoFtcQpj409aqacX7Lk+g/zU4ESkwOhhXszOwW4xTunmA9kNQvm+ydI37xN6bKKXcX0+Uvr67/T2ZhSJTjSMlxxDoXJDz4RzotK4WPMhznDkMDOb4KTVX0dm4cAxn2ejA5TCwQhO1tsStVx2IYcgcQxHjwjcY0ZO0J9huuAze1m63kkBtlODuWpA6fDfSrwtSF9v9PbuvKjYv+g0JUG6QPM16ueq3RfGiUfd8HjCzoSaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chVykgN7bZcIuvfIEO5C/ybi4gNYMSU5TQGwpDsi530=;
 b=kCdwlzgcrYyrqjAA4mCSt8sMdBpADkDdCQ0mqBQySLgEe/z0v1VieEQFlm+plnIEfLqx9G1hhsTb0wM+UkuRV/svT6rxaQVnCLw3hZeKaHV8BVhbyj3fCCYZPoH1ImCwIPvd/T8bO1GgdpZ9fNYn2uDLAURVAsb+l/SfmMK4i/4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:36 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:36 +0000
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
Subject: [PATCH Part1 RFC v4 04/36] x86/mm: Add sev_feature_enabled() helper
Date:   Wed,  7 Jul 2021 13:14:34 -0500
Message-Id: <20210707181506.30489-5-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9a7a80-2fd8-4038-a3d6-08d941733786
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644F18221B986BC7E8129F0E51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vL7jpgjaCQiSQjw33IB0m62v+iMoxlxMxb1qjzXbe/ccun64EGdcs6U9fUn5tE/O7sgCQ9U6tzlUX3lrRbMA6laGONLbBaIvnC/JGF7iDf5ZrmFQZN/dKiXEzFYt2sB3l81lSmGvw/aEWM/lkXPn2iUGUzAapEoYaM8vEnH0qf1F6TAXkY9nf9dMDDSjEJBmPPlVVBDc2XcalpN7dVz+z3s2OFUSAhuvCcTQJWy21tX5rypqZIUaOsoVogwA+O1UpcVwaysjRZo8fY48EQ13b4woQHA3hdxgoxuhvqxskYjqEqIb30cLbcIonB0v6MFL6m9nJn0L957rOkqGJ+LUcUZCg6vIWHDlsGkVt+Tf2Gz6xIyyqshT7OuIiqJHXhgRzOhMZOH8Q458zVA2+243JijtfUOIbZSiIMhTs41a3kmyq7bScv0lP0j6vyI46jN6smsNsVWbv84iIKzesZSrcZjTLhgb+JgFWsQC+nWnV/XixC9UnnbS8PhT90PIdZ8EM/NIpguJHfEWLZNB/rms3rmpxtWDvsMET4Mpks03QuLKBBePDtFUNlAiGHUpoyVon1jQg2PxujltczCLOwwksLoSQTzc7nqridVg41qANrgFcPIeFxKdv+1nC0hZr3GVdt3fRrsOyefvkf2ajJR9plRs3JCUQ5HMJ/z5pHc/HDhG3GXSDxvkvPoqeK8YsG+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(2906002)(1076003)(4326008)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxrjAMQHzds+IZhsfdFM9KBi+LCxGWeo51qFQgjzP+Pq6cyeBYUh1sjdbE+9?=
 =?us-ascii?Q?ogSXD2xL8bBSpfGQ7yeskOFoKTHn/65KTkwjn9dIwixGYuYJpdGnzdwnlLTx?=
 =?us-ascii?Q?C2YP2po9nMtr3wRqCRYCvGHXlmwXY/ofVy4YfSwH/FBtO0K3D3Cj1YeJhFBi?=
 =?us-ascii?Q?YLr94VExfPr0zLGcvCGotLvKmAe8a9Apq9TBNWlp/ieEfJ18bvRSBQJrYyom?=
 =?us-ascii?Q?8nbKDW8IYsOQjLtZT7dYW0u7cnoeJZtUMnVGEr1QRd78S6Uwh2gP22o+wsPo?=
 =?us-ascii?Q?ej+riC3fuev9bL46Pqgcde9mBsutN7Uf9bB4ZVVVY687OsoAhRAT+9zp9jAR?=
 =?us-ascii?Q?rxjwsfly/4QrpO9BVoFFnB2HCZp0knXLu7eVoxLMZv1vpa6re6xhtidiDrQ+?=
 =?us-ascii?Q?ML+x+ciQ8GfkVoJR3qciWIjE5f3WE/KXdjGUcQ+adL79lu1VBA4ZNWl6ytSO?=
 =?us-ascii?Q?Vw7Av9OXP7RIP98Vdg2P4AvLWcHcUiJRcXshnQe/bDobYJu3j7zSB5NimWKj?=
 =?us-ascii?Q?bF9xgEvG5acEySYjBM68aNcSW5n9U2m9S2gM5t2loERl2Nh3zSjxpa6wsqrf?=
 =?us-ascii?Q?3t8TGIOrvzkn1yWPR39Yh2XpX/7kgVmw1ueW118IucYFEfjhO+nHDOtpZES4?=
 =?us-ascii?Q?d2/2WnQE0AW/ylGoYu3iNY3wzp3c2UvGp5++pZkC+QHuTebLpkKbNGIi/gOm?=
 =?us-ascii?Q?LedLhifdK6JJFexTQZoUC8fZk0CKTPbClekzcV4Icqk5o06A2au8lcldMRGz?=
 =?us-ascii?Q?i3azelViuWnwU/OjYnCwc9VmlUfexIEIMTPrFFYoOPRSM8TFes7WFi+SaTiR?=
 =?us-ascii?Q?oyLQ5KBZCuapUJZX5eKL06C0R9Au5GHrYhCP9fSx/cvJdaZKS+0hlYIVxmW3?=
 =?us-ascii?Q?y6o+g1La25wQjf2gcBMGamON9iqTX4nA6uWPnRQ1lAIlCcMe5yuNDeKG96W0?=
 =?us-ascii?Q?Dsruy9PG68Oy/Vu+Vdy2dgYgHfEq1W5c1IkQAOgjUfJgO1NCh1SE5z758Cap?=
 =?us-ascii?Q?igU2NgNDCVA7fM1fihZbdm+C6nutrGLhqhrjVmv0TrGWvH++cPPMeBEo34uX?=
 =?us-ascii?Q?O0i2ICXsWsSQGtyt+0xVfEdJ1dk1vPBjmr8SF0AWgyYfqIdchQzH3aVFuaTu?=
 =?us-ascii?Q?uEsSTfjbY5hdOiTe1o5VHa93Wanf+cg6ne3nM2R4Da19ZwR0dS5WGN1FjeM0?=
 =?us-ascii?Q?v3duvjWcHWLckCbsHeI2KxhGXpypnJlSEorBaYBdtu3hSLmJDQD7PmFgsZQH?=
 =?us-ascii?Q?fSNia3yA+3+Pmoxoi+WGj8d/pMPka07TJg2pMrAovxUz1a0plh0iPWCphoGH?=
 =?us-ascii?Q?0JD7EGKdmZ5AA1lfssw9K58+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a7a80-2fd8-4038-a3d6-08d941733786
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:35.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bX1NihS9hXEggFpTR94wrRk6HNEfJOsZqKUl0TKH0yvCzMPxXhYnHPvpdd63M31qCTsls4qIVLHYKew5FFCQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
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
index 8cc2fd308f65..fb857f2e72cb 100644
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
@@ -54,6 +60,7 @@ void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
+bool sev_feature_enabled(unsigned int feature_type);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -87,6 +94,7 @@ static inline int __init
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

