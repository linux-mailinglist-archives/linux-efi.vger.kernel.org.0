Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827283BEE47
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhGGSUA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:00 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:41568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231561AbhGGST3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3aCogLOrDSFO/VJ5dsJflzLW4TcYfFTZM9vK3Br9jXY+iozJQMiR4Qb+MsNhryQPt5IA2fwvE8z1YNbnKxW0FNS2/kWw34yTT8NL6ESMFIFPutZ1rZCZJN1jMwumzSrCTmx1vunh8CsmS8ID3znDysaH2E++ik82aBVQnqUiJwe3S6FI/Dj6E0tN9yf89uEuBqgxct8HP3bAoeRzpwCGkYaPwta5G2kTS5J3cVfJ/wRd2yizw30LHMJQKl56MvZ02Vw0XAD4+tLMbSy0pflycy/Fd48n3DAO9lKOkm2GqDkWUJrKpUiV6odqPcuVmED0S1E2lkztDiXK337RQJizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRNoZAyYG2JApB2JG/n/p1ihVwaJ2xs/ineeq3NkLBc=;
 b=cHx0VjGsV3WK2cf9VKtEyjKd7Twdr26PHp1xhDeH2XzUQEG1Mp+L59gt89i+KWjDEiV01Y1g+4VR6yiQQiclKKon+xjUlaN+89l6PpEucs9NJEreYMwIofy1TPAfHMFapLVDgP7dIMLFzeAgK+xmBFcN3MKAK7TFmq+bTO0mDiKrLo8RvHyYo1u4dMXWTPv40tVMA0APECN85ZWM6QGHu18sS7Gs9pHzQHA8BPknOwlAttyfMGsMB4+kRaSTz7aLS+YFOjoeqNXHuEFbamcKl4PiAHfo0C3zP4V/GoClDfKZDDRuve2mtfxiBY3Unv6mkO0Skq3MTV2rUF3+VBZUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRNoZAyYG2JApB2JG/n/p1ihVwaJ2xs/ineeq3NkLBc=;
 b=5JjKiRrlwd5L11sQAzsFqwVZHHastVUIRXg7tc8lFWyJsKr86MJTiolUkFpfrcBIfrBlkuLeuWBAlBewsxF6ZJ/bk4V6yw3GFMDVZGUxYUZFKqUmLKfNTUqO6KKDwkV4I54syNmVcozsVgRT86tM2a383UF1Kow+svrHjBQBLgM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:20 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:20 +0000
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
Subject: [PATCH Part1 RFC v4 20/36] x86/sev: Use SEV-SNP AP creation to start secondary CPUs
Date:   Wed,  7 Jul 2021 13:14:50 -0500
Message-Id: <20210707181506.30489-21-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf782e5-16d4-4b2d-c9cf-08d9417351b0
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016F2B12D003D6F6ADE209AE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1LaVBZYobolj7X9sz8FK8ibPTOhakR9GQoZXZt1lpDFx5QsZTVU/WS8FESMBu3QY0CXB6R8uQ28bZXV3z6EeRqMOqqpSlw5Zj+C50YlpN4f56TF+/fNWOxINLApZP2R9rnJBwyUrNRtP28DqgpMdHgFUWgMSiscYlh3g98MZElrlL/maBQSFEGfairRteZLomFCgbOeN4VWMBConJ0O5nBGjWXMQdODFGjMoObq3+XOPOu5MM/VcsBbN9lLJ/SxDu8XuZ6MyHMhiw1wqjNc0S4GDkJw4n7FAV7Hb/MGkqub9Mp6MFX2vCvXcFv24l45asO1GoUms/hRtfet8AJnkZ+gOtv02jYPFjGhxkkHedc9K0BF5lXZKWTgHESTjc5MToGA/WODjiq+wg0YrgNZXYshi+nC+RetrDirA5PQOEWlK8gQ4LKckKNcgU33H8MZ0DC21SBekkrVy4YkGtzZAvUvdyfMjkqGNa7PxydeWH57n4myX0nrOjXVcOz74doVNEU0fXAzlk43UwXUpoHG0ElW4DGdsZyVL/fWbvH8QwQ/3VTOOHIWRPN/oeZtjcbvN5RZsYq9ddQQ0bXP7q1jNiCZ91UoRXBIk0dMPERgIK8jAyEmLxCT+K+F6+7p6xrIuxYSAWInNTVhqa15DSrlvtEdmU6SS9tDwUaRMzl53pRuI0ICtrQn1Mrkd5KjNWzZxjLV8pEWQ/MIcF9WLr435Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlKeBJMb8jGBrVHNKLJmyMwW99ycvs0oQ5LQOKT1ApOsn3mEuqmi4eQG2Cp1?=
 =?us-ascii?Q?9F1QFdV13opomKJrT/nCZ4XYroiSPd/OnzquY0PZvmUWksAoHYYwXjGSu1MW?=
 =?us-ascii?Q?oMnjW8k59Udgaq+j84k6arzFBuUDCQZ/kyTUSJvog2xDwpIIf/yBKIXyUXuy?=
 =?us-ascii?Q?9/8bpajEWTsfT+chJ3XBp7H09vu2fH0/s0WiudZtj5KNy7VqqDkiKVlZvwud?=
 =?us-ascii?Q?KosYqmzDAIE/zSmwhRmXvFFKxeaa4UX7lndHYFVDGSk/GrKyyxPnoJ14yRC/?=
 =?us-ascii?Q?rPZwY+qXz6A5x3FV4j5S1QH/caADEe9jFEfBXc2ZRiB/MpDPp3v2v0Rwfc7N?=
 =?us-ascii?Q?TYM4qpM8O8AWHtCxomEJKKQx60j/hcKixaaV0NXi5RSzuFCcaJaQdnclBd5w?=
 =?us-ascii?Q?PYpSRUYUZ6ntg7L1NUPbMi/ih3PDOmrmANU16eBUcHDA5mYONXOssrsaE4me?=
 =?us-ascii?Q?EDtNmBNSJpnRZ+xdzaVbG4n7CLB0/Bkxl3rGbj2JZcw2mSkid/ONkucCbDl6?=
 =?us-ascii?Q?hwSDFmrr0UT6bjzr2hp1jDO7NkYl84rdriQob/NWmgHD1Elr1hz8CNV61cLx?=
 =?us-ascii?Q?6m54PcySRFjfdYbIkcnoMjpPlpLkkVzbq64tR5RoCdPcCaR06el6JAcx8TGt?=
 =?us-ascii?Q?+G/7gYv8riyTQSeT9NyeltJHLPobnrSZ7GgEvVZBdMsnVuV/5woannIZd2WG?=
 =?us-ascii?Q?QJMCluokccDlu4SnJ2tlTgCjTsELNj8TutfNkjD8QAdgVyUanrJYCkCBBGwz?=
 =?us-ascii?Q?Fxv11tXHyCN74rPqdRD1sIEcQG5saP+HLTmmMlWUwdkcSkuaOE8v26JJQDAh?=
 =?us-ascii?Q?6qb7F3g4yMa4w4lbtN70A3aeXWrXUmnB1NHiLirVbXmuo9p9iMYvfuWVU/yc?=
 =?us-ascii?Q?MRkw+PnTkG8nrOSMLXskl6uXgk27Zd656NQ768Z2AwPZAySLkEGTtv9MePm0?=
 =?us-ascii?Q?pmdXeWOgGcP4Cteb0M+K8iePLW+5152jAkk1jLWjKc8tNyR9KGIP/T7df13i?=
 =?us-ascii?Q?X8InthSho5qUUhy/m5TGurDRmP+YtsUkQVUbSqIdqLYtL9sV7K8rn3IhkGdk?=
 =?us-ascii?Q?98k1gUEuuzT5hTwFdh3+MTbulH560+SvLM6E0hzkShO2X+VRFC/8Vvdp55lo?=
 =?us-ascii?Q?8If083fSp2vljnrm+0VenKa4K0ZZyeBKE/td/pv3FT0OqMSjiGh+9b4LawYw?=
 =?us-ascii?Q?keQsGABihQK9XfDWXb0VGyIPKiSEVZKO3umQJ4MjPTpQmToDcio7KBgxC1Zr?=
 =?us-ascii?Q?LGw8rgkQpMwzcZZ8dJHgDLPeH7d5/6GziCeaWluhGqw03ZMAdw2WyTSoqlpF?=
 =?us-ascii?Q?009j9BuIlhhw5hmaAH6ALu4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf782e5-16d4-4b2d-c9cf-08d9417351b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:19.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHRKfw2+Dkjdi11KsHyr0bnwL8bDrjAYbaA0UuuLoSympg24veucoP7FolYU2H0Rwl9nkfc0MLm75VCURj2zSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
AP Creation NAE event. This allows for guest control over the AP register
state rather than trusting the hypervisor with the SEV-ES Jump Table
address.

During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
SEV-SNP is active, will set/override apic->wakeup_secondary_cpu. This
will allow the SEV-SNP AP Creation NAE event method to be used to boot
the APs. As a result of installing the override when SEV-SNP is active,
this method of starting the APs becomes the required method. The override
function will fail to start the AP if the hypervisor does not have
support for AP creation.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   1 +
 arch/x86/include/asm/sev.h        |   6 +
 arch/x86/include/uapi/asm/svm.h   |   5 +
 arch/x86/kernel/sev.c             | 205 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c         |   3 +
 5 files changed, 220 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 2277c8085b13..5da5f5147623 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -85,6 +85,7 @@
 	(((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK))
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
 
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2385651c810e..f68c9e2c3851 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -65,6 +65,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
+#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -111,6 +113,8 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+void snp_set_wakeup_secondary_cpu(void);
+
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -125,6 +129,8 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_wakeup_secondary_cpu(void) { }
+
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index f7f65febff70..997918f0a89a 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,10 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_AP_CREATION			0x80000013
+#define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
+#define SVM_VMGEXIT_AP_CREATE			1
+#define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HYPERVISOR_FEATURES		0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -218,6 +222,7 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 5fef7fc46282..59e0dd04cb02 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -30,6 +31,7 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #include "sev-internal.h"
 
@@ -108,6 +110,8 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 /* Bitmap of SEV features supported by the hypervisor */
 EXPORT_SYMBOL(sev_hv_features);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -854,6 +858,207 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, 1);
 }
 
+static int vmsa_rmpadjust(void *va, bool vmsa)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * The RMPADJUST instruction is used to set or clear the VMSA bit for
+	 * a page. A change to the VMSA bit is only performed when running
+	 * at VMPL0 and is ignored at other VMPL levels. If too low of a target
+	 * VMPL level is specified, the instruction can succeed without changing
+	 * the VMSA bit should the kernel not be in VMPL0. Using a target VMPL
+	 * level of 1 will return a FAIL_PERMISSION error if the kernel is not
+	 * at VMPL0, thus ensuring that the VMSA bit has been properly set when
+	 * no error is returned.
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	/* Instruction mnemonic supported in binutils versions v2.36 and later */
+	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
+		      : "=a" (err)
+		      : "a" (va), "c" (RMP_PG_SIZE_4K), "d" (attrs)
+		      : "memory", "cc");
+
+	return err;
+}
+
+#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
+#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int cpu, err, ret;
+	u8 sipi_vector;
+	u64 cr4;
+
+	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Verify the desired start IP against the known trampoline start IP
+	 * to catch any future new trampolines that may be introduced that
+	 * would require a new protected guest entry point.
+	 */
+	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
+		      "unsupported SEV-SNP start_ip: %lx\n", start_ip))
+		return -EINVAL;
+
+	/* Override start_ip with known protected guest start IP */
+	start_ip = real_mode_header->sev_es_trampoline_start;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	cur_vmsa = per_cpu(snp_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)get_zeroed_page(GFP_KERNEL);
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & ~X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= 0xffff;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set VMSA entries to the INIT values as documented in the APM */
+	vmsa->ds.limit		= 0xffff;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= 0xffff;
+	vmsa->ldtr.limit	= 0xffff;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= 0xffff;
+	vmsa->tr.limit		= 0xffff;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->efer		= 0x1000;	/* Must set SVME bit */
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= 0x60000010;
+	vmsa->dr7		= 0x400;
+	vmsa->dr6		= 0xffff0ff0;
+	vmsa->rflags		= 0x2;
+	vmsa->g_pat		= 0x0007040600070406ULL;
+	vmsa->xcr0		= 0x1;
+	vmsa->mxcsr		= 0x1f80;
+	vmsa->x87_ftw		= 0x5555;
+	vmsa->x87_fcw		= 0x0040;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl		= 0;
+	vmsa->sev_features	= sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = vmsa_rmpadjust(vmsa, true);
+	if (ret) {
+		pr_err("set VMSA page failed (%u)\n", ret);
+		free_page((unsigned long)vmsa);
+
+		return -EINVAL;
+	}
+
+	/* Issue VMGEXIT AP Creation NAE event */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_alert("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		err = vmsa_rmpadjust(vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)vmsa);
+
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa) {
+		err = vmsa_rmpadjust(cur_vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)cur_vmsa);
+	}
+
+	/* Record the current VMSA page */
+	per_cpu(snp_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void snp_set_wakeup_secondary_cpu(void)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	/*
+	 * Always set this override if SEV-SNP is enabled. This makes it the
+	 * required method to start APs under SEV-SNP. If the hypervisor does
+	 * not support AP creation, then no APs will be started.
+	 */
+	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9320285a5e29..4fc07006f7f8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1377,6 +1378,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_set_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.17.1

