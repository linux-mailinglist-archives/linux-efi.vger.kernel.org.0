Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD9398BE5
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFBOLG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:11:06 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:36984
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230189AbhFBOJF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:09:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obPVcMbXCjg/pNoYhoOye0WS8/W/9fEqHign7yJzQlX8GTOIFQtr1isnz6i6l+cksZVhAgI5pwPPoOCCUfZh7TD6EBPzNkI64SM/xj+tjbv9YCXvo9yQ1zVMbR2Qmsji0J2ev0oWI7e1tMcsDAinKnLA1NZIN51V06vw+DzxXiV0VwzXOCngsu25xQAgRe80appCXDYtsgMibWVTqsvJUiLzO3/0rVTfUcPHScZUyo0JFjv8E+wWmoT2GL+bqFIbfRCojPoZnABVRJf3GuT+l/RuTWE0Q9lcVzcBppfc7YZyogqwGyQZALKwDzBqNuTch7bMyWrR7RD/lFWZmyhe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKjoKdser/R7wzT3MwIkWwXQPiEo3/vdBKENfyjMDVw=;
 b=niJEM2wDBjquNgaNxG8bzv6PHZpMx45X8/AT3wibkV583fwAYIJCPMUzvR9+91UZVzQiqAYBwsXRWwBci6Lk+9ADn2vjf9DtCQtf4gK9lXXI/J4UnOXDVvbWLDD/J1DCvg1C90rCEbhXStzucL/r1fUY9TDeJFK8vQqqtTVjoGQ45cz/YVe0rWkPRQlPSLMyKiKKLV+4xN0DwUnbhUv7fY3F9g2M6/u/ZQpxnAAdeZXvXWxIjtWAeb6yBi+4fjkDBjCVjcl3F3NYw0OK31GrXpDuAFLUb8EMakET7fbJzApDEQ8ZdFqjv3RdOqyPzeSRwsb6u5xzNf0GhJXEPLSqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKjoKdser/R7wzT3MwIkWwXQPiEo3/vdBKENfyjMDVw=;
 b=SzgTim63LD4R6EeN4WDJd22XZMqDeCRp8hcnhh24RisbUNRQZI0qJHcKyoSrmZujh19zoHbql+Cm60BseGB6c1Qu0kfeaT8W54aoRO/+Ay8fdlrYPzgGTr1CCYTCNh0k86zuWmsPNQ553h9nPk1klwwLsjiTbm6vnVf+J+PbN9c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:15 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:14 +0000
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
Subject: [PATCH Part1 RFC v3 19/22] x86/sev-snp: SEV-SNP AP creation support
Date:   Wed,  2 Jun 2021 09:04:13 -0500
Message-Id: <20210602140416.23573-20-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4312be5c-4e8b-4ee3-90f2-08d925cf6f9b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27663B0DC3D1E95764FE9810E53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW0m1BrRPkSWxshatIcURzsJ1HFmYVpEM3HLDrnh44DrprW+Su9jQcKe14mom9pWldVYqqVOxxsUTPW+AI8KDuoz/cIFJxAWnaJP+qqZkHZynSXaxbyUb0BNYXgZyklJ7RvmTKWkRhiT6cH/voLFVanTDibPrckI4fU6i5Q/6AUFJEyhokZ0st4p2cZBr9xe4cCNvcHDIAws7amGsmdK2VxdVg/0MWfd5ysLuEpzVEoCfWcDIS+DRY+/zrY/POZQtntHrAfdl8Y//jof9r5NYD3Dy+nxHFvgpdjTMs0JdORrWnlNWRXPYzSvRV8/ums9mIItuV764rgPbVCRBUEwdMrPh79UzAMWXpHEwb2FxsVNyT+iJpBRlH7igzahLTUxdS6VTN0TWiHc76Cg0hswGlQ7zxqJ1kChBTEFt1FFo23WgkSELtc7eN+ywYSL5TfE6zomvqOimFPBI6GO3QYxyEl+SBjm7WjdZZPCpJJnuOX1c9aEMUndQ040upGhxt7CsEufrImx54jHzDtYIecjpYjNnihLmF0vFLXJEOW4jy7wkbiI7UIxwdIEWEK8xGXh1VS+R7D/Qznahi9z+2FVMG6G7XXwFpSoPr1kBfamaEPSIT1zjOpLVdV4k6Q0XB0a6Ui9lRO4l+LvKERa2NgyXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(66476007)(478600001)(5660300002)(30864003)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AJct5giUYp2c8D2lglFOkKRXId3NI72fKcT9GWgL53XEM3Gw96xxbBP14B/Z?=
 =?us-ascii?Q?yK7FC4eGOR+QRHL7UpaOK2+xvsPByVkwRnseDHI/9os17JYr5xhhm6ko8Gtq?=
 =?us-ascii?Q?1ItL0KqSvTh6Lnuc5ezLuGDbz+k+aMUYGQMMm+Bxq13i3N93ZEQ40A/BK/iq?=
 =?us-ascii?Q?QjZ0BLVhIy3eSyt5sFYeJlUAwqBY1txN7ttoApGcHI19TRF3LEAexpvLIaB0?=
 =?us-ascii?Q?Qmpz5j/+mxcs4sorQLWi1Aa2sSrSC1aPTFUaXzzXJDbEGQbzKcfh3rkkXw6c?=
 =?us-ascii?Q?Na0+uSxNrBxcl5JqldzbiLp9dsmDs/775yCOPDjDIfjIou5givSGsQKczF93?=
 =?us-ascii?Q?ORbKo3GSKyqoe6jFbz99N4/zqZkjklFNlHRgZNlw/8RfqaBva7+uRRKtYeU1?=
 =?us-ascii?Q?ATUQOa6ob9AcheY0XsjlG19NvKbTWBF6tYmMQLwTiZYNTysC4sZ2pa7SlRzr?=
 =?us-ascii?Q?oFEB7g/AhDWYfCAEyj/h2AqT7aWaNhfOfPIVQMM3wsQqYwG4UsvMlmsAImu5?=
 =?us-ascii?Q?uMxvc789fJIZuFpUYKFIWCee5RXgyqD3sfVyM4QwMeqgo525BAcUds2+ON6b?=
 =?us-ascii?Q?qnCZvFUfy/eG1Ze9KebSSyIYC9LH9wVCFHwO6e5MEElUopUuXHTyIvBFwZ6E?=
 =?us-ascii?Q?mYOuheBGNCLCwrzZ46kICws1sSvcBytYJ1ZRB19en+UF0a2lAhUN6xiXYX3V?=
 =?us-ascii?Q?dq3SRd7FEeiliWDuPFwSbrXltYVtdgqaw/b9Cn7sNSBYJGD4Cj9gg5MiJ7Tf?=
 =?us-ascii?Q?tBsSnZL4vs28xdboN+++311Wbu6+E1o7Gujx+jm8zLCqHEYB99IDW3FIUP12?=
 =?us-ascii?Q?U3H2KQS0m+8J/yMZPZw92rbUPFbkbvMPDOuuCBD8QlRVCd1cJb/EyBaiLlL8?=
 =?us-ascii?Q?RA546rnlHmRkb/G1exj1Rhn6DPVpWhWVXsHNSJM7Q0oCdIoHnrKa0Ya3UgKH?=
 =?us-ascii?Q?iiaeUEejAIvM+0vQOzCJT0RSmKg1V5y413fYu1SeZdNr0NERK2q+ltS2z1LS?=
 =?us-ascii?Q?hxHudMYySXEIgwrp30SEJDGYcm+pC8YVM6bgpdb9VWhdGIbq8r3HM1PBW0Ck?=
 =?us-ascii?Q?CZC7LhpaI8UZRMOJE9HUzYdlJU0J+8DeEd1K/bI9urfq8EnHvj9+FTL1mD+k?=
 =?us-ascii?Q?qOcNAcQvz5i7x1726VSE5B3/AeFgusa9KqnNFaaE00JlkJv/keTyoHT5Z/x6?=
 =?us-ascii?Q?9wTqEudDf8CVel0mKezK4ctE3oZhawKeHqUw/qnJNa9xVUIvjusYRGYvZb2T?=
 =?us-ascii?Q?yptPjOT/OeSiOHwz5W47+MunCYqYq4vYZ9cmags3o0GifqKS+3A5pHsNL/BT?=
 =?us-ascii?Q?ebXaz0CTLFdmtF5uLm9AOJtO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4312be5c-4e8b-4ee3-90f2-08d925cf6f9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:14.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzL4latpdybniT0QZcXdRzxFvCxypTpKRjpNCb6CRv7V/zqW4+37FX9MpZioVpfnQN3hVUCblFSwu3JQ4IccCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
AP Creation NAE event. This allows for guest control over the AP register
state rather than trusting the hypervisor with the SEV-ES Jump Table
address.

During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
SEV-SNP is active, will set or override apic->wakeup_secondary_cpu. This
will allow the SEV-SNP AP Creation NAE event method to be used to boot
the APs.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   1 +
 arch/x86/include/asm/sev.h        |  13 ++
 arch/x86/include/uapi/asm/svm.h   |   5 +
 arch/x86/kernel/sev-shared.c      |   5 +
 arch/x86/kernel/sev.c             | 206 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c         |   3 +
 6 files changed, 233 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 86bb185b5ec1..47aa57bf654a 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,7 @@
 	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
 
 /* SNP Page State Change */
 #define GHCB_MSR_PSC_REQ		0x014
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e2141fc28058..640108402ae9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -71,6 +71,13 @@ enum snp_mem_op {
 	MEMORY_SHARED
 };
 
+#define RMPADJUST_VMPL_MAX		3
+#define RMPADJUST_VMPL_MASK		GENMASK(7, 0)
+#define RMPADJUST_VMPL_SHIFT		0
+#define RMPADJUST_PERM_MASK_MASK	GENMASK(7, 0)
+#define RMPADJUST_PERM_MASK_SHIFT	8
+#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -116,6 +123,9 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+
+void snp_setup_wakeup_secondary_cpu(void);
+
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -134,6 +144,9 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+
+static inline void snp_setup_wakeup_secondary_cpu(void) { }
+
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 41573cf44470..c0152186a008 100644
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
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
@@ -217,6 +221,7 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b62226bf51b9..7139c9ba59b2 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -32,6 +32,11 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
+static bool snp_ap_creation_supported(void)
+{
+	return (hv_features & GHCB_HV_FT_SNP_AP_CREATION) == GHCB_HV_FT_SNP_AP_CREATION;
+}
+
 static bool __init sev_snp_check_hypervisor_features(void)
 {
 	if (ghcb_version < 2)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4847ac81cca3..8f7ef35a25ef 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -31,6 +32,7 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #include "sev-internal.h"
 
@@ -106,6 +108,8 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -744,6 +748,208 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, 1);
 }
 
+static int snp_rmpadjust(void *va, unsigned int vmpl, unsigned int perm_mask, bool vmsa)
+{
+	unsigned int attrs;
+	int err;
+
+	attrs = (vmpl & RMPADJUST_VMPL_MASK) << RMPADJUST_VMPL_SHIFT;
+	attrs |= (perm_mask & RMPADJUST_PERM_MASK_MASK) << RMPADJUST_PERM_MASK_SHIFT;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	/* Perform RMPADJUST */
+	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
+		      : "=a" (err)
+		      : "a" (va), "c" (0), "d" (attrs)
+		      : "memory", "cc");
+
+	return err;
+}
+
+static int snp_clear_vmsa(void *vmsa)
+{
+	/*
+	 * Clear the VMSA attribute for the page:
+	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
+	 *		    higher than current level (VMPL0)
+	 *   RDX[15:8] = 0, Target permission mask (not used)
+	 *   RDX[16]   = 0, Not a VMSA page
+	 */
+	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, false);
+}
+
+static int snp_set_vmsa(void *vmsa)
+{
+	/*
+	 * To set the VMSA attribute for the page:
+	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
+	 *		    higher than current level (VMPL0)
+	 *   RDX[15:8] = 0, Target permission mask (not used)
+	 *   RDX[16]   = 1, VMSA page
+	 */
+	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, true);
+}
+
+#define INIT_CS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static int snp_wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa;
+	struct sev_es_save_area *vmsa;
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+	unsigned long flags;
+	u8 sipi_vector;
+	u64 cr4;
+	int cpu;
+	int ret;
+
+	if (!snp_ap_creation_supported())
+		return -ENOTSUPP;
+
+	/* Override start_ip with known SEV-ES/SEV-SNP starting RIP */
+	if (start_ip == real_mode_header->trampoline_start) {
+		start_ip = real_mode_header->sev_es_trampoline_start;
+	} else {
+		WARN_ONCE(1, "unsupported SEV-SNP start_ip: %lx\n", start_ip);
+		return -EINVAL;
+	}
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
+	vmsa = (struct sev_es_save_area *)get_zeroed_page(GFP_KERNEL);
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & ~X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector = (start_ip >> 12);
+	vmsa->cs.base     = sipi_vector << 12;
+	vmsa->cs.limit    = 0xffff;
+	vmsa->cs.attrib   = INIT_CS_ATTRIBS;
+	vmsa->cs.selector = sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip = start_ip & 0xfff;
+
+	/* Set VMSA entries to the INIT values as documented in the APM */
+	vmsa->ds.limit    = 0xffff;
+	vmsa->ds.attrib   = INIT_DS_ATTRIBS;
+	vmsa->es = vmsa->ds;
+	vmsa->fs = vmsa->ds;
+	vmsa->gs = vmsa->ds;
+	vmsa->ss = vmsa->ds;
+
+	vmsa->gdtr.limit    = 0xffff;
+	vmsa->ldtr.limit    = 0xffff;
+	vmsa->ldtr.attrib   = INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit    = 0xffff;
+	vmsa->tr.limit      = 0xffff;
+	vmsa->tr.attrib     = INIT_TR_ATTRIBS;
+
+	vmsa->efer    = 0x1000;			/* Must set SVME bit */
+	vmsa->cr4     = cr4;
+	vmsa->cr0     = 0x60000010;
+	vmsa->dr7     = 0x400;
+	vmsa->dr6     = 0xffff0ff0;
+	vmsa->rflags  = 0x2;
+	vmsa->g_pat   = 0x0007040600070406ULL;
+	vmsa->xcr0    = 0x1;
+	vmsa->mxcsr   = 0x1f80;
+	vmsa->x87_ftw = 0x5555;
+	vmsa->x87_fcw = 0x0040;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl = 0;
+	vmsa->sev_features = sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = snp_set_vmsa(vmsa);
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
+	ghcb = sev_es_get_ghcb(&state);
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
+	sev_es_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		int err = snp_clear_vmsa(vmsa);
+
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
+		int err = snp_clear_vmsa(cur_vmsa);
+
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)cur_vmsa);
+	}
+
+	/* Record the current VMSA page */
+	cur_vmsa = vmsa;
+
+	return ret;
+}
+
+void snp_setup_wakeup_secondary_cpu(void)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	apic->wakeup_secondary_cpu = snp_wakeup_cpu_via_vmgexit;
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0ad5214f598a..973145081818 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1379,6 +1380,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_setup_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.17.1

