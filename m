Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936AF3BEE41
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhGGST5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:57 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:45792
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232069AbhGGST2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQrcE6+663OXwP4Hy29ozvoecWLsP3tvt+2LQcreOkq6dFXaO5ino7MUZ4eaJd6DQ54mpMtae1419o335QeGG5UnDyQVyMKP+LpcPyZ7fI4P9TJdL4l2Fv7PjRLD9ENcqV83zKfoHQCJJghDKm18jDyKLsLzxa1U0pnCDGPKdtNv5DtIiYbUKEkhTSGdDXE5THaqn679J5PqZhdRH2KMVLG11+QKTWyTMlfO+c4ADxk3xMyliQACjFDg+xhGApDTQN3awTRg+3VWbnzhoa9TKxLXky0nLt1AqxNgP1rhUhWzAmglLoYJPuQ3OBNDtOCzAxnla2NLmIB+OG5bpk0XCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5Bj4ChvzX1GEpzBwT4c6XJS0kWfJq1wmxQJV3kjYSM=;
 b=K2olZqbOhvaSxR1wk1GPiy50ohrbvthJ2OIGcyhKf6Tp3wJxAOBMW4lLgny+DaD0BCd11gXIW3374R09e/iGiW9aphwXUvNONXRfO/Ytuu7fmZ/s/90xn+ThrlWRdF8bigksjXla0a4YzEhunSqD/ygBkNRbPtkhfZpXjOMqmJF3vudQcSH+ndXuQmnpvi9Ynmcj1/PkJKAtkQHoh1I0snz69uMq0qwfe1ZfpB2yGBMgszFZyWz49ssq8gEpoAUljwsQCk4XgrOvxQ0r0M6kRl1Nxf1dOrMKHRaQ4ARDG9PnWxOoHfHVPUltfoUyeXOQPSua6/V9zKf8zPh7VP1u2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5Bj4ChvzX1GEpzBwT4c6XJS0kWfJq1wmxQJV3kjYSM=;
 b=OMNIb6eifOxlspazNc4/zb8Jyi1EDv2GH7Jj7VkH6h7FTq2qXGMma7vUbCV2JUmnpIQBey9ETYU6qJlYv1NGgoZ5BpwWoo9GGv1kPQaHVEHTZQzqlxW2zMnETr4iwnFnEp0AUz1hpI+VX65e8DhzXKngeK0AeAT8ZDaxCnRroYQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:36 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:35 +0000
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
Subject: [PATCH Part1 RFC v4 26/36] x86/compressed/64: enable SEV-SNP-validated CPUID in #VC handler
Date:   Wed,  7 Jul 2021 13:14:56 -0500
Message-Id: <20210707181506.30489-27-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb525b83-f1d6-40c2-8775-08d941735acc
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683E79A2E0480B4269F32E3E51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCjjQyzPr/RJjHQbQVx5YViGWvg3rV9e+fv6lZ1sFuY4Mc5UO9sM1Mutwi74AVseBwi0Qm1l00p6Z/2/0hm7s6OFemr8xPOaXbCIs3d6y7K46WifdZqSJIIN2QiLyOpvQ1Ji982B+hF7XwNiI1OoPK/+fFYxtki8rCLUmqBWXJkLZoFOK+D3nSyywEoi4Wnlo50Or/0WrQTmelIBnzzzwwATx5MbyC4sOiKlHPnRH4aCPaNAsgtLYv1IcYFG0q4RaYYmgE6pOBD9wiGH7U7N/JBWJuAllttg+i7IyoSRkYYZ1Q4DZVA5gywCcAOEQ2AQLk2I5isiAtGyBVfTVvMF5lU0GN01QEd/3IZ1j096fDm2QMSTtCpES1VOY+rrljyjL3x4u7X3PGxmbMBFVsLlYpQR90WSfxZ6Vkd8gaZBgrObvV7u+IuqUtfq4MHJLo4vQ67F6HTfs9BNkFg/ZXLk35zHoqW8s6/Qll7ksyQUjkzLMwqVYpLTkFACgD7lk5np/1qjcg92aXRwyk/hI+ABpTtpNTu+DY01zdP+Lxw37fMR7FyHlMr1n2OrO7G583RwOFPIJ7o7+Rd8Oqcz6jvSKzTHkCm+IZLO+iylNiNo+HYygS1r1RZTscFpECcSLA8W7M6kIYVgGhRu5lN5HB0dU4JXP1BTgzhjIYt78kEPSpuY8Rm93j0U2vIG1NTPLMUhxN90ULNxi4U+z9Ls/PMvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(15650500001)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(30864003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oxs6JPJcVCIfo5/cQ+nx59dp7j3SV0zgOVY3OvoraIFY9dKMHcblMADGzFMf?=
 =?us-ascii?Q?f30jEcOjTEjqwh1JbtyeqCFauKh3hI/V2og0r2gLbPUPfF7IHMWNXQ03TwIO?=
 =?us-ascii?Q?h9JadOYk8He9SYYaB+FzzEUb/r1u8mameo3keGmDJyOe7QOq8qVHCbIUxi0I?=
 =?us-ascii?Q?aZhiHlq58CW/4nSN2mJnkRXiVSIS4SHOLlQ+I3UoVtbHqOo5vSNvXS1k07IT?=
 =?us-ascii?Q?roKyZRBC+iFURCQLkGoBf/oEZmg2XH8hwx1Amg0W5I7Q5xIWLMqZJe4esKOc?=
 =?us-ascii?Q?vDFFP+dgre5NFeDnI+VkCegtx+xAkUb7JMz2YP7Y9SDd/xjiVibCijbHht2E?=
 =?us-ascii?Q?URJD80F9BLVmFp13OXhI+rjRmi9BZJj1eh1nErdkTGcOE6WVamBaTAByEZD4?=
 =?us-ascii?Q?awL8/E2ZUBh5z247w4Q308wxL1PJpt5XKQNDq10li2hAJp2EWtxH3jrcQXoA?=
 =?us-ascii?Q?/azj3hdnhmJmF0qBQsVFy0Jb9/d0gsYTwhtrzPACM/FzN09bZhhJyqpd4YDl?=
 =?us-ascii?Q?0Gc+HA99wNSN/N/jmBiySouVqp5Qj+IxLaanJcBGXIj3f9TwIviWc47KUnLi?=
 =?us-ascii?Q?iSjNTwTuHdINCPOP1h33hdoZL5chvaMEdjqjss73r9CTtqerxl9PA8TQo2Wh?=
 =?us-ascii?Q?AEAsFQaGNUKIRjtxNmGLf9THrHXbP8BvBdIezcIhlPL+aZO6J90w76Vte+6L?=
 =?us-ascii?Q?dJHcpLWG+NeP8gTJ1T5NvOtt3EMOgNQkd79uTyi8fWQhMa2lS5LRm7FgXmk5?=
 =?us-ascii?Q?I0Z9ko8uMAKuGuq+nLc9PLq0GcJmaTk45bV2G1IFlkt+LcJE7mBn0mMQ/Bad?=
 =?us-ascii?Q?CVjqzDwNTc+Hs6ZpRIV7msTAtLm8tWsef21jKaogkvPCezaaXa+Ot0uTUHDp?=
 =?us-ascii?Q?B3Mpgoe16zLMRA0vIrkqfiQ+94k5sKmq2aQ5mz5GphazzGAx8cAS6WM2K6b2?=
 =?us-ascii?Q?dpF2DF1FW9ZgUzQUWeaVt3B4/bBN0xJXrR5pVJoNp+U7uzg60Adtm7vLRSgB?=
 =?us-ascii?Q?bc6zteSz3ZyBpx9FS08Ap5UTRoawp51ZkoJeR3mYytcEjNFe601kRsG8Hx3B?=
 =?us-ascii?Q?1rRyFGQ59EP7iL/9H6YzhqTDE71tXaV5cZH1aCc9WWuWYO6XAsvhfW3z2TAw?=
 =?us-ascii?Q?cqym4PKqFz1VYnLAnfXuIzzOgYuPQn+vSORKvC2dd5ZZGIprJLeHpTt9bslR?=
 =?us-ascii?Q?fneNBV3CzXRBDloaXtssXXyT5q7PJF5zBuKkvsuFD8MnIzirBeNPk2dXM4Hq?=
 =?us-ascii?Q?dX+gZUg1emaQLnTQZnkU96xmLTCcfjbGdFuzi0nWgLNDhO/Px8ZxVxm5klEv?=
 =?us-ascii?Q?ritNT3ntKwXxF7AXO8qAd/gw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb525b83-f1d6-40c2-8775-08d941735acc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:35.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1fwLJJImytyH5UohE/b0xPiSdnbmoOawm8tdZP6Moe8Y5javAyqaO96aRw/MXXJdWf7xk5twPt2gB4y19ueRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
for which early handlers are currently set up to handle. In the case
of SEV-SNP, guests can use a special location in guest memory address
space that has been pre-populated with firmware-validated CPUID
information to look up the relevant CPUID values rather than
requesting them from hypervisor via a VMGEXIT.

Determine the location of the CPUID memory address in advance of any
CPUID instructions/exceptions and, when available, use it to handle
the CPUID lookup.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/efi-config-table.c |  44 +++
 arch/x86/boot/compressed/head_64.S          |   1 +
 arch/x86/boot/compressed/idt_64.c           |   7 +-
 arch/x86/boot/compressed/misc.h             |  10 +
 arch/x86/boot/compressed/sev.c              |   3 +
 arch/x86/include/asm/sev-common.h           |   2 +
 arch/x86/include/asm/sev.h                  |   3 +
 arch/x86/kernel/sev-shared.c                | 322 ++++++++++++++++++++
 arch/x86/kernel/sev.c                       |   4 +
 9 files changed, 394 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/efi-config-table.c b/arch/x86/boot/compressed/efi-config-table.c
index d1a34aa7cefd..678fc4236030 100644
--- a/arch/x86/boot/compressed/efi-config-table.c
+++ b/arch/x86/boot/compressed/efi-config-table.c
@@ -178,3 +178,47 @@ efi_bp_get_conf_table(struct boot_params *boot_params,
 
 	return 0;
 }
+
+/*
+ * Given boot_params, locate EFI system/config table from it and search for
+ * physical for the vendor table associated with GUID.
+ *
+ * @boot_params:       pointer to boot_params
+ * @guid:              GUID of vendor table
+ * @vendor_table_pa:   location to store physical address of vendor table
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int
+efi_bp_find_vendor_table(struct boot_params *boot_params, efi_guid_t guid,
+			 unsigned long *vendor_table_pa)
+{
+	unsigned long conf_table_pa = 0;
+	unsigned int conf_table_len = 0;
+	unsigned int i;
+	bool efi_64;
+	int ret;
+
+	ret = efi_bp_get_conf_table(boot_params, &conf_table_pa,
+				    &conf_table_len, &efi_64);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < conf_table_len; i++) {
+		unsigned long vendor_table_pa_tmp;
+		efi_guid_t vendor_table_guid;
+		int ret;
+
+		if (get_vendor_table((void *)conf_table_pa, i,
+				     &vendor_table_pa_tmp,
+				     &vendor_table_guid, efi_64))
+			return -EINVAL;
+
+		if (!efi_guidcmp(guid, vendor_table_guid)) {
+			*vendor_table_pa = vendor_table_pa_tmp;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a2347ded77ea..1c1658693fc9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -441,6 +441,7 @@ SYM_CODE_START(startup_64)
 .Lon_kernel_cs:
 
 	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
 	call	load_stage1_idt
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567d663a..1f6511a6625d 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -3,6 +3,7 @@
 #include <asm/segment.h>
 #include <asm/trapnr.h>
 #include "misc.h"
+#include <asm/sev.h>
 
 static void set_idt_entry(int vector, void (*handler)(void))
 {
@@ -28,13 +29,15 @@ static void load_boot_idt(const struct desc_ptr *dtr)
 }
 
 /* Setup IDT before kernel jumping to  .Lrelocated */
-void load_stage1_idt(void)
+void load_stage1_idt(void *rmode)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		sev_snp_cpuid_init(rmode);
 		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
+	}
 
 	load_boot_idt(&boot_idt_desc);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 522baf8ff04a..74c3cf3b982c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -193,6 +193,10 @@ int efi_bp_get_conf_table(struct boot_params *boot_params,
 			  unsigned long *conf_table_pa,
 			  unsigned int *conf_table_len,
 			  bool *is_efi_64);
+
+int efi_bp_find_vendor_table(struct boot_params *boot_params, efi_guid_t guid,
+			     unsigned long *vendor_table_pa);
+
 #else
 static inline int
 efi_foreach_conf_entry(void *conf_table, unsigned int conf_table_len,
@@ -222,6 +226,12 @@ efi_bp_get_conf_table(struct boot_params *boot_params,
 {
 	return -ENOENT;
 }
+
+int efi_bp_find_vendor_table(struct boot_params *boot_params, efi_guid_t guid,
+			     unsigned long *vendor_table_pa);
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d4cbadf80838..13a6ce74f320 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,9 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid-indexed.h>
+#include <linux/efi.h>
+#include <linux/log2.h>
 
 #include "error.h"
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 5da5f5147623..e14d24f0950c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -132,5 +132,7 @@ struct __packed snp_psc_desc {
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
+#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
+#define GHCB_TERM_CPUID_HYP		5	/* CPUID failure during hypervisor fallback */
 
 #endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e41bd55dba5d..e403bd1fcb23 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -127,6 +128,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 
+void sev_snp_cpuid_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -143,6 +145,7 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 
+static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 4884de256a49..5e0e8e208a8c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,25 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+struct sev_snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 unused;
+	u64 unused2;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u64 reserved;
+} __packed;
+
+struct sev_snp_cpuid_info {
+	u32 count;
+	u32 reserved1;
+	u64 reserved2;
+	struct sev_snp_cpuid_fn fn[0];
+} __packed;
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -26,6 +45,15 @@ static u16 ghcb_version __section(".data..ro_after_init");
 /* Bitmap of SEV features supported by the hypervisor */
 u64 sev_hv_features __section(".data..ro_after_init") = 0;
 
+/*
+ * These are also stored in .data section to avoid the need to re-parse
+ * boot_params and re-determine CPUID memory range when .bss is cleared.
+ */
+static int sev_snp_cpuid_enabled __section(".data");
+static unsigned long sev_snp_cpuid_pa __section(".data");
+static unsigned long sev_snp_cpuid_sz __section(".data");
+static const struct sev_snp_cpuid_info *cpuid_info __section(".data");
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -236,6 +264,171 @@ static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return 0;
 }
 
+static bool sev_snp_cpuid_active(void)
+{
+	return sev_snp_cpuid_enabled;
+}
+
+static int sev_snp_cpuid_xsave_size(u64 xfeatures_en, u32 base_size,
+				    u32 *xsave_size, bool compacted)
+{
+	u64 xfeatures_found = 0;
+	int i;
+
+	*xsave_size = base_size;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (!(fn->eax_in == 0xd && fn->ecx_in > 1 && fn->ecx_in < 64))
+			continue;
+		if (!(xfeatures_en & (1UL << fn->ecx_in)))
+			continue;
+		if (xfeatures_found & (1UL << fn->ecx_in))
+			continue;
+
+		xfeatures_found |= (1UL << fn->ecx_in);
+		if (compacted)
+			*xsave_size += fn->eax;
+		else
+			*xsave_size = max(*xsave_size, fn->eax + fn->ebx);
+	}
+
+	/*
+	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
+	 * entries in the CPUID table were not present. This is not a valid
+	 * state to be in.
+	 */
+	if (xfeatures_found != (xfeatures_en & ~3ULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sev_snp_cpuid_hyp(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			      u32 *ecx, u32 *edx)
+{
+	/*
+	 * Currently MSR protocol is sufficient to handle fallback cases, but
+	 * should that change make sure we terminate rather than grabbing random
+	 * values. Handling can be added in future to use GHCB-page protocol for
+	 * cases that occur late enough in boot that GHCB page is available
+	 */
+	if (cpuid_function_is_indexed(func) && subfunc != 0)
+		sev_es_terminate(1, GHCB_TERM_CPUID_HYP);
+
+	if (sev_es_cpuid_msr_proto(func, 0, eax, ebx, ecx, edx))
+		sev_es_terminate(1, GHCB_TERM_CPUID_HYP);
+}
+
+/*
+ * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
+ * treated as fatal by caller since we cannot fall back to hypervisor to fetch
+ * the values for security reasons (outside of the specific cases handled here)
+ */
+static int sev_snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
+			 u32 *edx)
+{
+	bool found = false;
+	int i;
+
+	if (!sev_snp_cpuid_active())
+		return -EOPNOTSUPP;
+
+	if (!cpuid_info)
+		return -EIO;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in != func)
+			continue;
+
+		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
+			continue;
+
+		*eax = fn->eax;
+		*ebx = fn->ebx;
+		*ecx = fn->ecx;
+		*edx = fn->edx;
+		found = true;
+
+		break;
+	}
+
+	if (!found) {
+		*eax = *ebx = *ecx = *edx = 0;
+		goto out;
+	}
+
+	if (func == 0x1) {
+		u32 ebx2, edx2;
+
+		sev_snp_cpuid_hyp(func, subfunc, NULL, &ebx2, NULL, &edx2);
+		/* initial APIC ID */
+		*ebx = (*ebx & 0x00FFFFFF) | (ebx2 & 0xFF000000);
+		/* APIC enabled bit */
+		*edx = (*edx & ~BIT_ULL(9)) | (edx2 & BIT_ULL(9));
+
+		/* OSXSAVE enabled bit */
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			*ecx |= BIT_ULL(27);
+	} else if (func == 0x7) {
+		/* OSPKE enabled bit */
+		*ecx &= ~BIT_ULL(4);
+		if (native_read_cr4() & X86_CR4_PKE)
+			*ecx |= BIT_ULL(4);
+	} else if (func == 0xB) {
+		/* extended APIC ID */
+		sev_snp_cpuid_hyp(func, 0, NULL, NULL, NULL, edx);
+	} else if (func == 0xd && (subfunc == 0x0 || subfunc == 0x1)) {
+		bool compacted = false;
+		u64 xcr0 = 1, xss = 0;
+		u32 xsave_size;
+
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (subfunc == 1) {
+			/* boot/compressed doesn't set XSS so 0 is fine there */
+#ifndef __BOOT_COMPRESSED
+			if (*eax & 0x8) /* XSAVES */
+				if (boot_cpu_has(X86_FEATURE_XSAVES))
+					rdmsrl(MSR_IA32_XSS, xss);
+#endif
+			/*
+			 * The PPR and APM aren't clear on what size should be
+			 * encoded in 0xD:0x1:EBX when compaction is not enabled
+			 * by either XSAVEC or XSAVES since SNP-capable hardware
+			 * has the entries fixed as 1. KVM sets it to 0 in this
+			 * case, but to avoid this becoming an issue it's safer
+			 * to simply treat this as unsupported or SNP guests.
+			 */
+			if (!(*eax & 0xA)) /* (XSAVEC|XSAVES) */
+				return -EINVAL;
+
+			compacted = true;
+		}
+
+		if (sev_snp_cpuid_xsave_size(xcr0 | xss, *ebx, &xsave_size,
+					     compacted))
+			return -EINVAL;
+
+		*ebx = xsave_size;
+	} else if (func == 0x8000001E) {
+		u32 ebx2, ecx2;
+
+		/* extended APIC ID */
+		sev_snp_cpuid_hyp(func, subfunc, eax, &ebx2, &ecx2, NULL);
+		/* compute ID */
+		*ebx = (*ebx & 0xFFFFFFF00) | (ebx2 & 0x000000FF);
+		/* node ID */
+		*ecx = (*ecx & 0xFFFFFFF00) | (ecx2 & 0x000000FF);
+	}
+
+out:
+	return 0;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -244,15 +437,25 @@ static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	u32 eax, ebx, ecx, edx;
+	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	ret = sev_snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
+	if (ret == 0)
+		goto out;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
 	if (sev_es_cpuid_msr_proto(fn, 0, &eax, &ebx, &ecx, &edx))
 		goto fail;
 
+out:
 	regs->ax = eax;
 	regs->bx = ebx;
 	regs->cx = ecx;
@@ -552,6 +755,19 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 	struct pt_regs *regs = ctxt->regs;
 	u32 cr4 = native_read_cr4();
 	enum es_result ret;
+	u32 eax, ebx, ecx, edx;
+	int cpuid_ret;
+
+	cpuid_ret = sev_snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
+	if (cpuid_ret == 0) {
+		regs->ax = eax;
+		regs->bx = ebx;
+		regs->cx = ecx;
+		regs->dx = edx;
+		return ES_OK;
+	}
+	if (cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
 
 	ghcb_set_rax(ghcb, regs->ax);
 	ghcb_set_rcx(ghcb, regs->cx);
@@ -603,3 +819,109 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+#ifdef BOOT_COMPRESSED
+static struct setup_data *get_cc_setup_data(struct boot_params *bp)
+{
+	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB)
+			return hdr;
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * For boot/compressed kernel:
+ *
+ *   1) Search for CC blob in the following order/precedence:
+ *      - via linux boot protocol / setup_data entry
+ *      - via EFI configuration table
+ *   2) Return a pointer to the CC blob, NULL otherwise.
+ */
+static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info = NULL;
+	struct setup_data_cc {
+		struct setup_data header;
+		u32 cc_blob_address;
+	} *sd;
+
+	/* Try to get CC blob via setup_data */
+	sd = (struct setup_data_cc *)get_cc_setup_data(bp);
+	if (sd) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+		goto out_verify;
+	}
+
+	/* CC blob isn't in setup_data, see if it's in the EFI config table */
+	(void)efi_bp_find_vendor_table(bp, EFI_CC_BLOB_GUID,
+				       (unsigned long *)&cc_info);
+
+out_verify:
+	/* CC blob should be either valid or not present. Fail otherwise. */
+	if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+#else
+/*
+ * Probing for CC blob for run-time kernel will be enabled in a subsequent
+ * patch. For now we need to stub this out.
+ */
+static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
+{
+	return NULL;
+}
+#endif
+
+/*
+ * Initial set up of CPUID table when running identity-mapped.
+ *
+ * NOTE: Since SEV_SNP feature partly relies on CPUID checks that can't
+ * happen until we access CPUID page, we skip the check and hope the
+ * bootloader is providing sane values. Current code relies on all CPUID
+ * page lookups originating from #VC handler, which at least provides
+ * indication that SEV-ES is enabled. Subsequent init levels will check for
+ * SEV_SNP feature once available to also take SEV MSR value into account.
+ */
+void sev_snp_cpuid_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cc_info = sev_snp_probe_cc_blob(bp);
+
+	if (!cc_info)
+		return;
+
+	sev_snp_cpuid_pa = cc_info->cpuid_phys;
+	sev_snp_cpuid_sz = cc_info->cpuid_len;
+
+	/*
+	 * These should always be valid values for SNP, even if guest isn't
+	 * actually configured to use the CPUID table.
+	 */
+	if (!sev_snp_cpuid_pa || sev_snp_cpuid_sz < PAGE_SIZE)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = (const struct sev_snp_cpuid_info *)sev_snp_cpuid_pa;
+
+	/*
+	 * We should be able to trust the 'count' value in the CPUID table
+	 * area, but ensure it agrees with CC blob value to be safe.
+	 */
+	if (sev_snp_cpuid_sz < (sizeof(struct sev_snp_cpuid_info) +
+				sizeof(struct sev_snp_cpuid_fn) *
+				cpuid_info->count))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	if (cpuid_info->count > 0)
+		sev_snp_cpuid_enabled = 1;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 59e0dd04cb02..04ef5e79fa12 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/log2.h>
+#include <linux/efi.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -32,6 +34,8 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
+#include <asm/efi.h>
+#include <asm/cpuid-indexed.h>
 
 #include "sev-internal.h"
 
-- 
2.17.1

