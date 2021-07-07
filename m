Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD513BEED5
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhGGSjx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:39:53 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231707AbhGGSjw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmbC87ZEi42Z8Eq7t72mATAriP0Y/tNqWOzVthT6rDEJusq/1BrjYt8wenptXJ8XbS+fw+odXIfgLPk4lHJs9YK+zuVDID8/I7kGvyR71rmLvWrS3ue4zEKmDo0PAVvRJFHHWS3nSvLXCYiRE6eX7E1c310MCuzShfV+RSxQRVuqqV/Z+M7TZQ7idItOapIB3/YVrAM0INtI26sMFUPPDADyoat2fPLHcqu8U4+QsHe4mSMZ2gA+lLFS1T5JUdAATfjhwQEhtkXYWh1pFjA8fyohBRRGQrM9E+5tdLI40p66WIPfGwrrh7Sdwyk923TlSJMYQWTkuX9r7wBtw5ndZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZA3qq6/fQ/B9fJFEkpHVyEHN2iiVab2qlr67taoOUw=;
 b=OhPyi5L5PJ0F5LuuI5i2/sOxHLq2Kb1xsZ1EZJzmPWu+ovwYoq6vhPkYo6MG0CIev+228iMdcpAwLf9QLBShYeDxIj/H7vrTzMBw4KDruBDEMeSK8ZZcNQ1PyBFp5oteMtuDYO9vI4wO+qTbrj6Y5dtET7EYeZu1zr++0dEsRmQt4dsCgrIFuA3by9vqoEPt1KD0WGYShRUfIxoy5hQz7D+HCGQsl4ozoznUlpECXC9fSv/v3pa+LnPUOfVjudQM3sUC/ThmYn576B7S4CY9ePUwQCHfAs3ItIWO3gcsh4ucFaJhf2Kd4qo6Csp+tMDGyYpFX1JN2f2KbB2abEgCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZA3qq6/fQ/B9fJFEkpHVyEHN2iiVab2qlr67taoOUw=;
 b=J4hLfRjtHnEApOoGV2DXStu2b6Q/ZxrbgIrHY9F8aY++pYF9BrV2PPwqeDIUAuOsnZx2xhbvN+S40zEF4FXGHs7Eqql8rnsL9uTZH8doO6FswpfCiCEc5yuTdCXHbuQQhUpRlitPNtF9E42rHMwSUCLfoZk4XObipAcOV+WDZg0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:37:04 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:04 +0000
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
Subject: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP initialization support
Date:   Wed,  7 Jul 2021 13:35:40 -0500
Message-Id: <20210707183616.5620-5-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80af87d5-9166-4382-f472-08d941763794
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB352599F1E8375AFF9BBB1128E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LatUTmlD3dra7Q92MrjN5HLPHkR7usI1VyrEo0+hYjVltH/6CyV9boNJKpwttdhz3qff1dEWqWZ/dCc6P20sIhr6mCDIXQ3iiwJvVSxVnhBZKutqXfEjrRJz8TKBI2PAdccXsk4x6Sua80b4riKBtsIRUzM2mBl1Cvf4K2Wttr34OTh/c5oK0kyRf3QpuYXI0AF9H4OT2/i/VTpHqRMNZY2CTlIaYiCuMRyAVO/PI6gyjPmw45yjtXNBngpYXwF/U5UlUadNZIv05jJRRmDtRzBbtGASOPfZtD3BczdSDyK1YVEZ4Y96hrBEc0mJfU87PH/2DwXWi+MyZ1XF+Lgq2X7MMroSrEm9yB+2D5SLp+dDTk3yD5m/vG5o4lG85vrwju9PiZOxl7BtZpVk0PdQZR0nRFUI9kf761UlQloIQ4xFLvmmfoZN6uiEZ1rBuIUyhbLGCkunpRXrDl9dfs6HwYLtK8M4J/5XYUeSDJGMG3xX3UtTlLwvFxAzLbBQ5V+JTqO7JHe/AgvZYAxUS6fZpOoQObTzylV/LlsHx9QFEuwDnyRlg688mHm5dzKukqPD8h1TfFBPFBgDi/NTR+nyAqQ4HpWQ7piSv+gUvRzst7LUhV3TdrHt717JLqSUcVYR6JtU9bWhF8Nfj76PKSc8cozv6eXSLTnT1hh780QJtom7zKWbdb5iORGdUa02THqDBp2ZQcMd6gtjyNosYixLxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCozQilHdFop85ZJlFLYvGgWlwTfPgVEytaMIx+u9oy7r0arEhoimAEg9ZHy?=
 =?us-ascii?Q?sn7h/AD1e1g1xERZyhH7cOIj925UTlBmf1yreO47vjy/SlNGmg6ax3A5ymN7?=
 =?us-ascii?Q?45mvAlRfgW/yKdaqZmfWWO89o6C7L8ySC3v5nog7USfZJ+E4RlgCsu75Ilp1?=
 =?us-ascii?Q?seZvZFCgq6t3D25HoIxVzY4by4bnX0m0Qp7lGtSNEpSELnTgFTOPrd5GJvxj?=
 =?us-ascii?Q?28G+3ocWMnQPOLB8HFPLpu+7I8AKOrfASfS27YlrZebMO8v6qWHkCN+pxigO?=
 =?us-ascii?Q?dgvuLrXl9z6S86M6Yno/mR5o+sutitnSDQgjOAIQa/hsRRzo/9TbRdg7WpD7?=
 =?us-ascii?Q?fY54gONvoZcnORYm84bQFa36X1Glz1FdCF/euXTf7JEiBDrfLWAc3LD+WJgG?=
 =?us-ascii?Q?OD++rT22RrmxLGkE7Q0nA6E4wS3BwkAsjnvMixn7MJdKLFd1obdz8Ky5LjFF?=
 =?us-ascii?Q?SVwR+9Ipr15jqaPrGZo5roOk3mYRdFQeTU5ZnRTz2t0ltcDsw8jQC9zTnOdt?=
 =?us-ascii?Q?1Do3MLxC4I1ODOVHf+ljq1nCXeMx2IrWEwkLmOam4ErB2wl7jWI7aCEDJPYY?=
 =?us-ascii?Q?IlWeQUSH6CAhEnCN+1Jb8sJzMWndLpU7pJvvvzMk9Q0yxvIS6Pq09GpXLJRP?=
 =?us-ascii?Q?aLb1vfZPDcnb9z/CdkK8Ki1kVzzpS/GEZAX5PoDxzIzW7jNXwHp/SxaBiFyj?=
 =?us-ascii?Q?tPC/PJimayHxjmGsgkHIUuzeKQPNNaPMXlyJM8xtWAnWsB2Sw9ugoCsqu0Jh?=
 =?us-ascii?Q?dleUJlehK2WU184iwOvOQrGxrt/ghi/715GwIiPpqDtGOqws8rUfFVzpGnk0?=
 =?us-ascii?Q?3DtLnPz4Ubnze3iu7r0SHSXxIR9xpzfRYsFVN4+GFV9FKTACEG7L4h8myFzn?=
 =?us-ascii?Q?0QsL9lrC/4/4W3lf1lzQSiqzWh8Ecymqd00UEWoe4GVWMUkq3rQ8NP4uGPdk?=
 =?us-ascii?Q?xQTItcBs+6eKmF22etfYTVXeDTmWXkLqg/ERFHThGPX/dRiAII2YR+dIQggE?=
 =?us-ascii?Q?A8GUeXo1l8fQIRHFHy65+H2gn4EKyVD8QWyW4y4T1n9HTIaXxABV9f9H/h+M?=
 =?us-ascii?Q?HcNNLnlcMtaCb7dRYRjO2t50Jwnahye4+8CEHdXCiUOtC2xrQitK/hgiTbzw?=
 =?us-ascii?Q?TBhQlULY24rhJmExxfPRXO+Q3KmUZotWbFU6Df//+WHC5Cfpwmtt6/gdVyQb?=
 =?us-ascii?Q?s7+n6tQjTFSlmEEu5rX05hirGTSC66qvUixGPzyYOT7opxFT6xCnXreXtZP9?=
 =?us-ascii?Q?LDYoSgcwE46c5ia7Hr8Q/KczH4sflML7I0vUtwsXJvpoNNVBqP4oR+sSIFJY?=
 =?us-ascii?Q?9cREaJVIO/XzE+zZys1nrPwL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80af87d5-9166-4382-f472-08d941763794
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:04.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiLiuYt9Eo2KrBPVaQqNEchS1bhUEjNKHomRX5rAioVdKa6r7133OGfiXAm2PPDbpqDt63kyR0ZqOUcpQFWdJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory integrity guarantees of SEV-SNP are enforced through a new
structure called the Reverse Map Table (RMP). The RMP is a single data
structure shared across the system that contains one entry for every 4K
page of DRAM that may be used by SEV-SNP VMs. The goal of RMP is to
track the owner of each page of memory. Pages of memory can be owned by
the hypervisor, owned by a specific VM or owned by the AMD-SP. See APM2
section 15.36.3 for more detail on RMP.

The RMP table is used to enforce access control to memory. The table itself
is not directly writable by the software. New CPU instructions (RMPUPDATE,
PVALIDATE, RMPADJUST) are used to manipulate the RMP entries.

Based on the platform configuration, the BIOS reserves the memory used
for the RMP table. The start and end address of the RMP table must be
queried by reading the RMP_BASE and RMP_END MSRs. If the RMP_BASE and
RMP_END are not set then disable the SEV-SNP feature.

The SEV-SNP feature is enabled only after the RMP table is successfully
initialized.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/msr-index.h         |   6 +
 arch/x86/kernel/sev.c                    | 143 +++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index b7dd944dc867..0d5c8d08185c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -68,6 +68,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+# define DISABLE_SEV_SNP	0
+#else
+# define DISABLE_SEV_SNP	(1 << (X86_FEATURE_SEV_SNP & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -91,7 +97,7 @@
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
-#define DISABLED_MASK19	0
+#define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 69ce50fa3565..e8d45929010a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -485,6 +485,8 @@
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
+#define MSR_AMD64_RMP_BASE		0xc0010132
+#define MSR_AMD64_RMP_END		0xc0010133
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
@@ -542,6 +544,10 @@
 #define MSR_AMD64_SYSCFG		0xc0010010
 #define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT	23
 #define MSR_AMD64_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_AMD64_SYSCFG_SNP_EN_BIT		24
+#define MSR_AMD64_SYSCFG_SNP_EN		BIT_ULL(MSR_AMD64_SYSCFG_SNP_EN_BIT)
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT	25
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN	BIT_ULL(MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT)
 #define MSR_K8_INT_PENDING_MSG		0xc0010055
 /* C1E active bits in int pending message */
 #define K8_INTP_C1E_ACTIVE_MASK		0x18000000
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index aa7e37631447..f9d813d498fa 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -24,6 +24,8 @@
 #include <linux/sev-guest.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -40,11 +42,14 @@
 #include <asm/efi.h>
 #include <asm/cpuid-indexed.h>
 #include <asm/setup.h>
+#include <asm/iommu.h>
 
 #include "sev-internal.h"
 
 #define DR7_RESET_VALUE        0x400
 
+#define RMPTABLE_ENTRIES_OFFSET        0x4000
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -56,6 +61,9 @@ static struct ghcb __initdata *boot_ghcb;
 
 static u64 snp_secrets_phys;
 
+static unsigned long rmptable_start __ro_after_init;
+static unsigned long rmptable_end __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -2176,3 +2184,138 @@ static int __init add_snp_guest_request(void)
 	return 0;
 }
 device_initcall(add_snp_guest_request);
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"SEV-SNP: " fmt
+
+static int __snp_enable(unsigned int cpu)
+{
+	u64 val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return 0;
+
+	rdmsrl(MSR_AMD64_SYSCFG, val);
+
+	val |= MSR_AMD64_SYSCFG_SNP_EN;
+	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;
+
+	wrmsrl(MSR_AMD64_SYSCFG, val);
+
+	return 0;
+}
+
+static __init void snp_enable(void *arg)
+{
+	__snp_enable(smp_processor_id());
+}
+
+static bool get_rmptable_info(u64 *start, u64 *len)
+{
+	u64 calc_rmp_sz, rmp_sz, rmp_base, rmp_end, nr_pages;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!rmp_base || !rmp_end) {
+		pr_info("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	rmp_sz = rmp_end - rmp_base + 1;
+
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the full system RAM. The reserved memory should also cover the
+	 * RMP table itself.
+	 *
+	 * See PPR section 2.1.5.2 for more information on memory requirement.
+	 */
+	nr_pages = totalram_pages();
+	calc_rmp_sz = (((rmp_sz >> PAGE_SHIFT) + nr_pages) << 4) + RMPTABLE_ENTRIES_OFFSET;
+
+	if (calc_rmp_sz > rmp_sz) {
+		pr_info("Memory reserved for the RMP table does not cover the full system "
+			"RAM (expected 0x%llx got 0x%llx)\n", calc_rmp_sz, rmp_sz);
+		return false;
+	}
+
+	*start = rmp_base;
+	*len = rmp_sz;
+
+	pr_info("RMP table physical address 0x%016llx - 0x%016llx\n", rmp_base, rmp_end);
+
+	return true;
+}
+
+static __init int __snp_rmptable_init(void)
+{
+	u64 rmp_base, sz;
+	void *start;
+	u64 val;
+
+	if (!get_rmptable_info(&rmp_base, &sz))
+		return 1;
+
+	start = memremap(rmp_base, sz, MEMREMAP_WB);
+	if (!start) {
+		pr_err("Failed to map RMP table 0x%llx+0x%llx\n", rmp_base, sz);
+		return 1;
+	}
+
+	/*
+	 * Check if SEV-SNP is already enabled, this can happen if we are coming from
+	 * kexec boot.
+	 */
+	rdmsrl(MSR_AMD64_SYSCFG, val);
+	if (val & MSR_AMD64_SYSCFG_SNP_EN)
+		goto skip_enable;
+
+	/* Initialize the RMP table to zero */
+	memset(start, 0, sz);
+
+	/* Flush the caches to ensure that data is written before SNP is enabled. */
+	wbinvd_on_all_cpus();
+
+	/* Enable SNP on all CPUs. */
+	on_each_cpu(snp_enable, NULL, 1);
+
+skip_enable:
+	rmptable_start = (unsigned long)start;
+	rmptable_end = rmptable_start + sz;
+
+	return 0;
+}
+
+static int __init snp_rmptable_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SEV_SNP))
+		return 0;
+
+	/*
+	 * The SEV-SNP support requires that IOMMU must be enabled, and is not
+	 * configured in the passthrough mode.
+	 */
+	if (no_iommu || iommu_default_passthrough()) {
+		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+		pr_err("IOMMU is either disabled or configured in passthrough mode.\n");
+		return 0;
+	}
+
+	if (__snp_rmptable_init()) {
+		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+		return 1;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
+
+	return 0;
+}
+
+/*
+ * This must be called after the PCI subsystem. This is because before enabling
+ * the SNP feature we need to ensure that IOMMU is not configured in the
+ * passthrough mode. The iommu_default_passthrough() is used for checking the
+ * passthough state, and it is available after subsys_initcall().
+ */
+fs_initcall(snp_rmptable_init);
-- 
2.17.1

