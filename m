Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58949FF20
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiA1RT4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:56 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:28961
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350702AbiA1RS4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TePdPM6KHLF2kSAMkxgv2nEn0O4PPkRkqeqpCXSJOLBz98wld9cPb5UZtEhmQI7zjPBEQXrbR34FLwrX2unMNAfWn4tVjm8GziiAO449cQ7jdQF3G4jA+qMh15vhh6rNBilOWN2QJciW4OK0Noi0n/3BjhIsayveZvVWrPYjDwZc88azubFmCqWtbsRA2j6ShP0JgfCxpl2OvD9ETPI6pfkfbsRtyioE0MSBbyVAw+8fAHD7Vx84uvkSysw2YGXi+q32w5b3W3YZRJjyVw5MLkxPomvRJZ82c224fGCUpZc41aPnW/mOxd/UBUl7R8oYKWgadegRuExffhpjoydfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dThjTR3l5CFQ3oUuPuINeCmFPgww2232zuNFsrkSW9c=;
 b=DjZss1EBwumMDL9Fkr6bxnbZlj1VGoGENpl5+sImkMaoIfmpjnflxjGtDoRIxBqtzOkyG/DOx20ecxQYmi3kagZWlYu7yRNPKVL1/au0tfUCCyxoozXD3mRfr8+Jdln8jSC08/+EULODwGoC1fbyPejG0v2bYSyQ2vOVUXt3dl2IiSzV217AC7RMtArjGEnIeHfr8ENLPebwxES3LmGRsdDG41b7WLIzDnHDxLq+mPgoW2hYYt87xZDodbHJ3gpL8TaUgwKMm/xd08/KbqYmDgxfB7YjlCiQ4tmbzIpqKFexqO4bnjAuT1QCI4LPAZp98/+izbP0L747Mo2c3cH0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dThjTR3l5CFQ3oUuPuINeCmFPgww2232zuNFsrkSW9c=;
 b=CpuhmcSW+Gfu6qBjI2zjsS/UkXjLPrbYhQevqK+0VQnCHxnsh6FbOqFJYNsIwLNdxTRGHrcBQkgbacdsy7PqvqH5Ui2ocaQRchUx8/XnClVYVPLo1am5LI0yhgUaK852LK0evJiMxyG/uCeYdIBHyLuSj/qSkmjg8d2hKsHp6h0=
Received: from DM5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:3:13f::33)
 by DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 17:18:54 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::36) by DM5PR17CA0071.outlook.office365.com
 (2603:10b6:3:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:53 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:51 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 21/43] x86/head/64: Re-enable stack protection
Date:   Fri, 28 Jan 2022 11:17:42 -0600
Message-ID: <20220128171804.569796-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16b803be-c31b-41f3-f4ac-08d9e2824297
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0075A55BA1E7918862DF74CAE5229@DM5PR1201MB0075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Met73V/DL8BXn396y0DAItvVVY1oAwUX9qrt3aQ2z8D9hyCQ3qV9rtQQz2fly4TEHc7Z8up9wzm+AvvzLLSnZyoTE+4QckcsFZUsDLiH1L7N280qksPx1mTIzKmJCcjIEGln+rAZ45MbfPrlbfKHxFZyQx0W1NaZ+4zE7MLNy1uEJaTL1gI1zdUR4vTcsQa1VBXRYibXtDetw9ttKynPaSqw+ih92E2nk0D0RSnn09OEa0E7V5ZgLnKkmhiWwCmgcfPGRJq3pyK0HMGhisUJx+4zAQnLyOoa2jRtznzbUTm/i9QqMPjAyUPSync2gQzCLKYQj+uZfDemDxv2DEGo6qtpUv2cXVWgpRMzlybjGiCe0Dtc2kuM/6KZhrmsuEpI78bUJvJXgpDR7M8Ghfkmqeenzv0c0ytExdrDj9iFRGbvgNw5KmbFVKvhAnpJanMQtks8VA8iIsI23dgMVkMiT6feRSgK+Y6sCGiQaxjJZL88qx1/X1iSTteitB7oUg74q+2P1gFwR3ShvT55Y2o0lrrxAxQ1d0yOKiaKn7pf6opD5GtKvmDKeBG8F4/P2dxGCiioQ0yvZEHnBwYgPNkQIFTLG96U0HUroGl3KR6UsLWVcAGyrV8c1T/6CvyaFrRbqc8wHedbssQH8DmwsnQbvGOovYVocgJIaK1gNL8YpjB4tTBof/BrG2eUjWnky5wNVFvN8R5mgf08Xzc1C15u56XVwohLbBr6a98lOWUfy17HW6jClWnfUKwMV0tvmv9YWtuq4ahNPH4drJlhTmqMdCY0Iv1W+rus+n0AsXakspmbSD4hyy2sPNmiwAmIl+1S
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700004)(336012)(6666004)(5660300002)(8676002)(7406005)(4326008)(44832011)(2906002)(47076005)(36756003)(81166007)(186003)(36860700001)(70206006)(16526019)(86362001)(356005)(1076003)(426003)(70586007)(7696005)(82310400004)(7416002)(2616005)(54906003)(8936002)(110136005)(26005)(40460700003)(508600001)(316002)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:53.9422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b803be-c31b-41f3-f4ac-08d9e2824297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Due to the following commit:

  103a4908ad4d ("x86/head/64: Disable stack protection for head$(BITS).o")

kernel/head{32,64}.c are compiled with -fno-stack-protector to allow a
call to set_bringup_idt_handler(), which would otherwise have stack
protection enabled with CONFIG_STACKPROTECTOR_STRONG. While sufficient
for that case, there may still be issues with calls to any external
functions that were compiled with stack protection enabled that in-turn
make stack-protected calls, or if the exception handlers set up by
set_bringup_idt_handler() make calls to stack-protected functions.

Subsequent patches for SEV-SNP CPUID validation support will introduce
both such cases. Attempting to disable stack protection for everything
in scope to address that is prohibitive since much of the code, like
SEV-ES #VC handler, is shared code that remains in use after boot and
could benefit from having stack protection enabled. Attempting to inline
calls is brittle and can quickly balloon out to library/helper code
where that's not really an option.

Instead, re-enable stack protection for head32.c/head64.c and make the
appropriate changes to ensure the segment used for the stack canary is
initialized in advance of any stack-protected C calls.

for head64.c:

- The BSP will enter from startup_64() and call into C code
  (startup_64_setup_env()) shortly after setting up the stack, which
  may result in calls to stack-protected code. Set up %gs early to allow
  for this safely.
- APs will enter from secondary_startup_64*(), and %gs will be set up
  soon after. There is one call to C code prior to %gs being setup
  (__startup_secondary_64()), but it is only to fetch 'sme_me_mask'
  global, so just load 'sme_me_mask' directly instead, and remove the
  now-unused __startup_secondary_64() function.

for head32.c:

- BSPs/APs will set %fs to __BOOT_DS prior to any C calls. In recent
  kernels, the compiler is configured to access the stack canary at
  %fs:__stack_chk_guard [1], which overlaps with the initial per-cpu
  '__stack_chk_guard' variable in the initial/"master" .data..percpu
  area. This is sufficient to allow access to the canary for use
  during initial startup, so no changes are needed there.

[1] 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")

Suggested-by: Joerg Roedel <jroedel@suse.de> #for 64-bit %gs set up
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/setup.h |  1 -
 arch/x86/kernel/Makefile     |  1 -
 arch/x86/kernel/head64.c     |  9 ---------
 arch/x86/kernel/head_64.S    | 24 +++++++++++++++++++++---
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..72ede9159951 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,7 +49,6 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee28a39..bd45e5ee6fe3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,7 +48,6 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1239bc104cda..c80952dded32 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -319,15 +319,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	return sme_postprocess_startup(bp, pmd);
 }
 
-unsigned long __startup_secondary_64(void)
-{
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
-}
-
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
 {
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c2c3aff5ee4..9e84263bcb94 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -65,6 +65,22 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
+
+	/*
+	 * initial_gs points to initial fixed_percpu_data struct with storage for
+	 * the stack protector canary. Global pointer fixups are needed at this
+	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
+	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	movq	initial_gs(%rip), %rax
+	movq	$_text, %rdx
+	subq	%rdx, %rax
+	addq	%rdi, %rax
+	movq	%rax, %rdx
+	shrq	$32,  %rdx
+	wrmsr
+
 	pushq	%rsi
 	call	startup_64_setup_env
 	popq	%rsi
@@ -145,9 +161,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
-	pushq	%rsi
-	call	__startup_secondary_64
-	popq	%rsi
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	movq	sme_me_mask, %rax
+#else
+	xorq	%rax, %rax
+#endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
-- 
2.25.1

