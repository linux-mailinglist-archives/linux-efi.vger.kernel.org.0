Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283403F2F53
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhHTPZK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:10 -0400
Received: from mail-bn1nam07on2078.outbound.protection.outlook.com ([40.107.212.78]:42963
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241033AbhHTPXc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:23:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZawO4tUTlp3ij0V5OdNz+sdkdR4uCLFNykesv57QgtN65SjCdKXn3xhr5x8Hu9x1yg/SkJ0GMv290uoNLOKJ6zNYJx61bCrQn1m7Yt7wU5Jm1Y9bjxgSFT65bwBtnIvYrg0pU6DIpSI7/wTBAZ/dsi0o32w+7NCC8jR7b6BdHavHt2wXp7DilfhjsFMK1U1NHp+pbwFPmtjwa28i3fG8QjC4dkQs8V+jBHA+K3j8efed6fngq5Thl4lgw3G4xSJz7PpegzuCN88/M1fiqAIj19F1ma9U5SbUz/Y1sYPpfZ4Tu8+XeQD9tOvSza6qKOQkqFPu07WZP7xufdn8ZIbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqkMDx0/0vzGlPt+rSYAi+VmVx6/g1a6Y8Sb8px6ZIE=;
 b=Skfyg3IyE+uy0co1feEBSDgyzAVeXfeHx+2KfV90anm+sWe3iJfluc1k/SUtlrVexMVphXH80XiA9zLBOxVAxe8YHGjsytAfGIG4Avx1A809qOBhzhMu4u3L2Vpk005HJOz3DyAU+2VwuF/gXj2K6cyHybBRNVqjvQbrv5j50OPmJL2+hq2xbMgHeYh7OiDiDkothlu0eohA3LHonlZC4JGmairCk2nbn06wJYRxZ+oseH503OHOP6LM5xUn+kMOK9Ukjky/9/Q6/njbwwZdAdswRlvxNzknh0IRo4Mv2uWxYWT+Kdg/bcfvigrqN41M42HW6W150R8uL0o1quNpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqkMDx0/0vzGlPt+rSYAi+VmVx6/g1a6Y8Sb8px6ZIE=;
 b=1LaWG/tEK9oJh82lrXN3wTqhcTuikY+QuBqpKmxCvWVbogCAi1CUvR3KChF9n1co8/xM/3x3RGAuh6slFyHukJWSocXEJCawSa4Kg6vT+4sUO42I65N9GI97xqv55FosfZGLckdP2gni63yzQ0iLwKA6eEDCNBBIygW+WDfrVKQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 15:21:59 +0000
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
Subject: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID in #VC handlers
Date:   Fri, 20 Aug 2021 10:19:27 -0500
Message-Id: <20210820151933.22401-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e001756-f61a-43c5-652f-08d963ee2f08
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45921BC9B6DFBF798F46BB1FE5C19@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: om0rqE0dY4ybpSzTV8RI0KxJhJaNGJoDFV1ldtPoU9q/TNf8D0eq+lNoF7gE9NBy+6sMgrihANCucA5L+zST5IcndpNQt/MtS0dXgD3vWyjc7Ppcxa3eg9eiI03UYefkGeGM1yA8IZXNKqEYNusYVGgstkQbIDxLeOOIJf/1kE7Pde5pPSSUVGu8zOUXhFCA+8oMjA77s9IlbWGa2uCof6qPye7Cm6jOvJfjyqLfLfGEwP7Qh9mjb4SEcr4RHFqUg8MJSWkNgZBGBkaRJE99mk76SgZLS5NsylPwQdL8hq05pfSQtr0oF/054X3YP0JqPGVoUxSFaS2NYbiHL2mL6vs8c1JweBYINPrLf+KGYWyake2bZjejEqsVYwyLpiDub0WX3IRkRtb7fBknNQNCDGDvz23cFkjq0A0z1c/3sxnAH981UUPZJvg9hyHGLKyvJ+6bdnVtJVriQb+fdJIVpjywyxV+9yciiN2zJFWZfv9NdhrLEk8ZplCO4x4zZMawjRrzFMDGQnB105ue/tRjGROlx/lpYavE0nJkMEe6kSC1oqS1WjxJBbcvx1GerhkQvWAXLmK0WNgnSuFVAo9qD4LcYwibg2FUJ8mDvvqKMUdlCtklN14iAo6N393AMJsZ3cOXajLH3VbCD9+GU4qv/6JzQa0C+ST3CmE52RliJdxLjK2s3dUdFDV5bBizb65o9JsUNhnyujOSeWtlF8+47g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66556008)(6486002)(54906003)(66946007)(1076003)(66476007)(316002)(38100700002)(7406005)(7416002)(38350700002)(8676002)(4326008)(956004)(2616005)(8936002)(26005)(36756003)(44832011)(86362001)(186003)(5660300002)(15650500001)(52116002)(83380400001)(30864003)(2906002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmNen83W007xVHgiZFVc0I/os7uMKEGNi6gUcc+EtKN0Gove+EhYNg8LkgNW?=
 =?us-ascii?Q?tXeVJfCtJAG5ojb7F7gs463UlpjoZzLU8XEM6MS+ef78PRaCyVom4uL1dBrO?=
 =?us-ascii?Q?WR2WAEMHSJy61jb0RHphaE+obG0IYD+S+6L6d+tJaFpHhLEeKF6l3POywLT6?=
 =?us-ascii?Q?AZa6NhpC57wLhFpPtPRISuNr+u981DTKYdNP9KtPz6ng0pt6Y2dteq/VpoBi?=
 =?us-ascii?Q?sogFiJNjpM2CId95tDrcI+PgrA5zW5VzKPKHa0RjMSGTJemikYiPPEv5YNr/?=
 =?us-ascii?Q?x6H63O1M9SvDDi8SfUbT2vLoP9FU7P1wnbCbjOU5HHbGbaYl2b+UjPNqobl5?=
 =?us-ascii?Q?q3PiZnY4eajnJXfBrxvKqJ2ZqaqFtYFZabiisgT+/I0Nze+DWSCqDYPjNnIX?=
 =?us-ascii?Q?7J+T9AGhgB7jzsC5ulu/gfeWE4ijSLRRL+GMmcIBIMOuSLSkBJtdOy3eoQ9s?=
 =?us-ascii?Q?FO/G9nYQ05xl3Ayle+LyxP5LptulEMuq7HU/Wn8S0OZeS0WY+QQpcZalJfv6?=
 =?us-ascii?Q?MKCEyTZSEQp+0QTS7HzMD6Hn5vEJG3/5keH42aP4qRSMEZqFypzacRiADD5O?=
 =?us-ascii?Q?8Cl5/bRsMhHvfeK3EXvGs1tNi5QsoFBTiK5nNfHll1XcmimLiez18JDKVMpc?=
 =?us-ascii?Q?1cnFqvOMAd8BtOTcspJujGwVRa3g6sh3P8ATkyOO+BHc8KFir07LscQTeTz+?=
 =?us-ascii?Q?B6hwwJp/2g4wbQTxYk/0M/bV8tLj8gefbjMb3Pg/cnpJhKe4/m8SLG6Fcc0g?=
 =?us-ascii?Q?KYoVNdF0+gA+6FYEhEdm+ot3e/4QDOUNhl+urXz5wxffBAyXxV0mavVm4jvu?=
 =?us-ascii?Q?CuyFmSktLI6gNMX4YDtnaPr+H0S3JZtO5bAgt6CuWRjk54weRAMhf4fIH1lZ?=
 =?us-ascii?Q?lPlaw2MfnlSraWOmlpyNNr6nTGo5NR0sihJYD7i9QzXfI7fPyX2QOnz7/rYz?=
 =?us-ascii?Q?gZGboPUgaktIpz8OXpTDUJf35eZpypYJuvBKuHh9+k6pXrkyp4blZlVCvndo?=
 =?us-ascii?Q?EMlDoAHAO0opab+y1mBVVk6SCP4qUYEiuwncjevy0k2b3XWjvy2GKPp42nhL?=
 =?us-ascii?Q?FIHSPu1PGC86c/fVUDpJuDWVdY0NOO2oh/Eo21GghcvJ5GTjoWwmlkrWw1aY?=
 =?us-ascii?Q?MlbJ/w0E1Cotl6REUe2HLjC/j+o4RdRa/uybSIkKiUlPDQ5LPlxswS4swfsV?=
 =?us-ascii?Q?ktuj7bjNupZ4hlU155tuzfi4Hy1hV47eF50e21CuHcK8HeOb3+AjexL+LxBG?=
 =?us-ascii?Q?ASmdgjNnZdchzpUxfGHpfL0ojWqw+klzPWZL23lsm+/AyCguVLonLAzPogMP?=
 =?us-ascii?Q?ElOuMy6YF8aEsU4W9nXSor7z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e001756-f61a-43c5-652f-08d963ee2f08
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:29.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is/k5DLdvtASTz9WdmnCLd7quiFOVipvEovcyDTO60+G0PNijNOEKQpa+bCsLO5Yk4SZV6h2xvesAfEZON5Fig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This adds support for utilizing the SEV-SNP-validated CPUID table in
the various #VC handler routines used throughout boot/run-time. Mostly
this is handled by re-using the CPUID lookup code introduced earlier
for the boot/compressed kernel, but at various stages of boot some work
needs to be done to ensure the CPUID table is set up and remains
accessible throughout. The following init routines are introduced to
handle this:

sev_snp_cpuid_init():

  This sets up access to the CPUID memory range for the #VC handler
  that gets set up just after entry to startup_64(). Since the code is
  still using an identity mapping, the existing sev_snp_cpuid_init()
  used by boot/compressed is used here as well, but annotated as __init
  so it can be cleaned up later (boot/compressed/sev.c already defines
  away __init when it pulls in shared SEV code). The boot/compressed
  kernel handles any necessary lookup of ConfidentialComputing blob
  from EFI and puts it into boot_params if present, so only boot_params
  needs to be checked.

sev_snp_cpuid_init_virtual():

  This is called when the previous identity mapping  is gone and the
  memory used for the CPUID memory range needs to be mapped into the
  new page table with encryption bit set and accessed via __va().

  Since this path is also entered later by APs to set up their initial
  VC handlers, a function pointer is used to switch them to a handler
  that doesn't attempt to re-initialize the SNP CPUID feature, as at
  that point it will have already been set up.

sev_snp_cpuid_init_remap_early():

  This is called when the previous mapping of CPUID memory range is no
  longer present. early_memremap() is now available, so use that to
  create a new one that can be used until memremap() is available.

sev_snp_cpuid_init_remap():

  This switches away from using early_memremap() to ioremap_encrypted()
  to map CPUID memory range, otherwise the leak detector will complain.
  This mapping is what gets used for the remaining life of the guest.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/include/asm/setup.h    |  5 +-
 arch/x86/include/asm/sev.h      |  6 +++
 arch/x86/kernel/head64.c        | 21 ++++++--
 arch/x86/kernel/head_64.S       |  6 ++-
 arch/x86/kernel/setup.c         |  3 ++
 arch/x86/kernel/sev-shared.c    | 95 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c       |  2 +
 8 files changed, 129 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d083c873..ff0eecee4235 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -63,6 +63,7 @@ extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
 #endif
+extern unsigned long initial_idt_setup;
 
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..12fc52894ad8 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,8 +50,9 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
-extern void startup_64_setup_env(unsigned long physbase);
-extern void early_setup_idt(void);
+extern void startup_64_setup_env(unsigned long physbase, struct boot_params *bp);
+extern void early_setup_idt_common(void *rmode);
+extern void __init early_setup_idt(void *rmode);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 345740aa5559..a5f0a1c3ccbe 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -129,6 +129,9 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 #ifdef __BOOT_COMPRESSED
 bool sev_snp_enabled(void);
+#else
+void sev_snp_cpuid_init_virtual(void);
+void sev_snp_cpuid_init_remap_early(void);
 #endif /* __BOOT_COMPRESSED */
 void sev_snp_cpuid_init(struct boot_params *bp);
 #else
@@ -149,6 +152,9 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
 #ifdef __BOOT_COMPRESSED
 static inline bool sev_snp_enabled { return false; }
+#else
+static inline void sev_snp_cpuid_init_virtual(void) { }
+static inline void sev_snp_cpuid_init_remap_early(void) { }
 #endif /*__BOOT_COMPRESSED */
 #endif
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f1b76a54c84e..4700926deb52 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -576,7 +576,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void startup_64_load_idt(unsigned long physbase, struct boot_params *bp)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
@@ -586,6 +586,7 @@ static void startup_64_load_idt(unsigned long physbase)
 		void *handler;
 
 		/* VMM Communication Exception */
+		sev_snp_cpuid_init(bp); /* used by #VC handler */
 		handler = fixup_pointer(vc_no_ghcb, physbase);
 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
 	}
@@ -594,8 +595,8 @@ static void startup_64_load_idt(unsigned long physbase)
 	native_load_idt(desc);
 }
 
-/* This is used when running on kernel addresses */
-void early_setup_idt(void)
+/* Used for all CPUs */
+void early_setup_idt_common(void *rmode)
 {
 	/* VMM Communication Exception */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
@@ -605,10 +606,20 @@ void early_setup_idt(void)
 	native_load_idt(&bringup_idt_descr);
 }
 
+/* This is used by boot processor when running on kernel addresses */
+void __init early_setup_idt(void *rmode)
+{
+	/* SEV-SNP CPUID setup for use by #VC handler */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		sev_snp_cpuid_init_virtual();
+
+	early_setup_idt_common(rmode);
+}
+
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(unsigned long physbase, struct boot_params *bp)
 {
 	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
 
@@ -634,5 +645,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
 #endif
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt(physbase, bp);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..78f35e446498 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -218,7 +218,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Setup and Load IDT */
 	pushq	%rsi
-	call	early_setup_idt
+	movq	%rsi, %rdi
+	movq	initial_idt_setup(%rip), %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rax
 	popq	%rsi
 
 	/* Check if nx is implemented */
@@ -341,6 +344,7 @@ SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+SYM_DATA(initial_idt_setup,	.quad early_setup_idt)
 
 /*
  * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bff3a784aec5..e81fc19657b7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -48,6 +48,7 @@
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
+#include <asm/sev.h>
 #include <linux/vmalloc.h>
 
 /*
@@ -1075,6 +1076,8 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
+	sev_snp_cpuid_init_remap_early();
+
 	idt_setup_early_pf();
 
 	/*
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 6f70ba293c5e..e257df79830c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -264,7 +264,7 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return 0;
 }
 
-static bool sev_snp_cpuid_active(void)
+static inline bool sev_snp_cpuid_active(void)
 {
 	return sev_snp_cpuid_enabled;
 }
@@ -960,7 +960,7 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
  * indication that SEV-ES is enabled. Subsequent init levels will check for
  * SEV_SNP feature once available to also take SEV MSR value into account.
  */
-void sev_snp_cpuid_init(struct boot_params *bp)
+void __init sev_snp_cpuid_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -995,3 +995,94 @@ void sev_snp_cpuid_init(struct boot_params *bp)
 
 	sev_snp_cpuid_enabled = 1;
 }
+
+#ifndef __BOOT_COMPRESSED
+
+static bool __init early_make_pgtable_enc(unsigned long physaddr)
+{
+	pmdval_t pmd;
+
+	/* early_pmd_flags hasn't been updated with SME bit yet; add it */
+	pmd = (physaddr & PMD_MASK) + early_pmd_flags + sme_get_me_mask();
+
+	return __early_make_pgtable((unsigned long)__va(physaddr), pmd);
+}
+
+/*
+ * This is called when we switch to virtual kernel addresses, before #PF
+ * handler is set up. boot_params have already been parsed at this point,
+ * but CPUID page is no longer identity-mapped so we need to create a
+ * virtual mapping.
+ */
+void __init sev_snp_cpuid_init_virtual(void)
+{
+	/*
+	 * We rely on sev_snp_cpuid_init() to do initial parsing of bootparams
+	 * and initial setup. If that didn't enable the feature then don't try
+	 * to enable it here.
+	 */
+	if (!sev_snp_cpuid_active())
+		return;
+
+	/*
+	 * Either boot_params/EFI advertised the feature even though SNP isn't
+	 * enabled, or something else went wrong. Bail out.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* If feature is enabled, but we can't map CPUID info, we're hosed */
+	if (!early_make_pgtable_enc(sev_snp_cpuid_pa))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = (const struct sev_snp_cpuid_info *)__va(sev_snp_cpuid_pa);
+}
+
+/* Called after early_ioremap_init() */
+void __init sev_snp_cpuid_init_remap_early(void)
+{
+	if (!sev_snp_cpuid_active())
+		return;
+
+	/*
+	 * This really shouldn't be possible at this point.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = early_memremap(sev_snp_cpuid_pa, sev_snp_cpuid_sz);
+}
+
+/* Final switch to run-time mapping */
+static int __init sev_snp_cpuid_init_remap(void)
+{
+	if (!sev_snp_cpuid_active())
+		return 0;
+
+	pr_info("Using SNP CPUID page, %d entries present.\n", cpuid_info->count);
+
+	/*
+	 * This really shouldn't be possible at this point either.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* Clean up earlier mapping. */
+	if (cpuid_info)
+		early_memunmap((void *)cpuid_info, sev_snp_cpuid_sz);
+
+	/*
+	 * We need ioremap_encrypted() to get an encrypted mapping, but this
+	 * is normal RAM so can be accessed directly.
+	 */
+	cpuid_info = (__force void *)ioremap_encrypted(sev_snp_cpuid_pa,
+						       sev_snp_cpuid_sz);
+	if (!cpuid_info)
+		return -EIO;
+
+	return 0;
+}
+
+arch_initcall(sev_snp_cpuid_init_remap);
+
+#endif /* __BOOT_COMPRESSED */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ca78711620e0..02c172ab97de 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1044,6 +1044,8 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
 	initial_stack  = idle->thread.sp;
+	/* don't repeat IDT setup work specific to the BSP */
+	initial_idt_setup = (unsigned long)early_setup_idt_common;
 
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
-- 
2.17.1

