Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF64D09BA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiCGVg6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbiCGVg2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:28 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987B88B13;
        Mon,  7 Mar 2022 13:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL1O0JbXUfKHw/9bRKs0qKu3oDNQ/1RtPh7c/C9Y5/uFpFs0c/fqeEJsyyvQFJUNaAAiNq2EGKrIjsLKeTVsTI9MUYDqCTDM+FTboDyJOEpMcpBrHRWwGTpi18ybZPD4YAzDbLVJg8KOVlalKJFUU0IK4kRsj8/U2umruBnvW5rHZqyE5ui+o0CX7h5ATfb9/hg5M5EWFrhSaAGSKQsfa0tXjUsPXJhaczn33m49irmnrbglbw2N/yMDpMjc9CcQg4UA3DUh5r1UHfuXMNq6tNKTM4Id9vx075VHFeNKIK0skASFUktZYRib62BpQ3VaR5PJAaqSc9FQrfmb+usPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw4Dxy+VsWZLyerTWYMAsDC0yjmiPAW8pTtX9HntsIs=;
 b=jKj63/5bJpz87LEiRWhsqHB/8s3c7OZCkSwZrfdC98Fsh3pLwr+FwD0sHhRQu7oGSUVMfShFXOT4YFBGwgAR/oZhwvFFxpHjBfrNBVt8PErIJrEsX4BVTktrEIA1w5zFnes5u8kodsN+prV6bbjSyf2JYL7BXnTLHiOQOZVbnoTTFJbhLTshKOTo2XmZEw2u0zxloIVCmLaaDiNj6I70zHPQovQ6K9aeqMa8oNzVyTscrQgpGiRxTzb341pGdghoQwSlb6kvpM9TPGb2wq3ghi9X5+qUuo1XanXUTDlbGwXGikHmGN0kCa8VdKyuY4gyiqeU/6Y3PKTEDR2II3zEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw4Dxy+VsWZLyerTWYMAsDC0yjmiPAW8pTtX9HntsIs=;
 b=uZvo8vZ7TOOsJLH53AC7vrGPv5ArjEAwhFADk4oHSSZ73M9vxrWa0v0Gi++XmMbKWvtn5M572ZTAg32E5mbCQqdvGV5aKGx/MCsdDXNhTHWSCkvsrIXoFwT9WYqqaWTYFhuTeN4Ga1JPJt+mG5L0j24Eqqu+gH4ZrWS4eW6y4/o=
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:00 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::94) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:00 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:57 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 23/46] x86/head/64: Re-enable stack protection
Date:   Mon, 7 Mar 2022 15:33:33 -0600
Message-ID: <20220307213356.2797205-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed9d8c91-9c8b-4073-c4a0-08da00825560
X-MS-TrafficTypeDiagnostic: MN2PR12MB3117:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB311783E4F5AD7C83BD93E439E5089@MN2PR12MB3117.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAXic2TkWsbm2xJ/SlMMqj1LJqrQPLDtJX9a0AOgunA5yBLeHOUDYk80IX42YI6VulPD3XClXVPRNO52mWmStSqi8tW5SrI6+7vylc7xlBs5zgMdsyDSK+pkO3ZAL4vOTXy18DsMKO2vPJDNApKBkg962cijtUOi3/v1Hivrt2l8jG+A5C/qpSmSCvrzYZRkbtf4DoQwl3r7BkenfW40HgGEIEqYbCkVIk2prB1cIw/zES6IKqxwxogchGS48oOWJoUt2lOPFSoHmk7cMgw5UfZudjZomlMKIJDy1ouJewIAumqTf4SMhWxx4XjSTEh3T65+kX2jIPNi4eszeJKvxnD+MypaDVwYpX8h5J4SY7egGMcnF0KMcpIUC1vKOC037zHODQNqktA6OyQ5SAGtZd7AIAeYcWKy92Ev292cL6j0oL91p5EKGKgbV5PjOQWJXnokqTBaKTgt3N+TrlX/ZsIQIPi3Va/i0WUp/IvhWcd/9cxpVEjOibx4n5vTPzKz3hmi5AfismnDHdrl5UKAQ3cLaCf8qdQ7uQJ0WVf04NO/LDNB9ZWmFt2eHdwgw3YVSHFUISSJSVBQErAhA28IAeR8LN8xppns0u+aCKNzokGMkrjZ0o3DKlbG88zOhgI8c09FmZ1tQ2GbtfA5P7gctqnAuCrsFxet2z/UG7ahIp3ZGqgrb3M1b2OOP1bChrGkMkE4KIxx4Yzzu+pj7qpu0Ffg0ftTVvyV5FqQiKFMKoA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(7406005)(54906003)(8676002)(5660300002)(110136005)(8936002)(2616005)(186003)(316002)(16526019)(1076003)(81166007)(356005)(26005)(36756003)(7416002)(70586007)(70206006)(508600001)(6666004)(82310400004)(36860700001)(44832011)(47076005)(4326008)(86362001)(83380400001)(336012)(2906002)(426003)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:00.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9d8c91-9c8b-4073-c4a0-08da00825560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Due to commit 103a4908ad4d ("x86/head/64: Disable stack protection for
head$(BITS).o"), kernel/head{32,64}.c are compiled with
-fno-stack-protector to allow a call to set_bringup_idt_handler(), which
would otherwise have stack protection enabled with
CONFIG_STACKPROTECTOR_STRONG.

While sufficient for that case, there may still be issues with calls to
any external functions that were compiled with stack protection enabled
that in-turn make stack-protected calls, or if the exception handlers
set up by set_bringup_idt_handler() make calls to stack-protected
functions.

Subsequent patches for SEV-SNP CPUID validation support will introduce
both such cases. Attempting to disable stack protection for everything
in scope to address that is prohibitive since much of the code, like
SEV-ES #VC handler, is shared code that remains in use after boot and
could benefit from having stack protection enabled. Attempting to inline
calls is brittle and can quickly balloon out to library/helper code
where that's not really an option.

Instead, re-enable stack protection for head32.c/head64.c, and make the
appropriate changes to ensure the segment used for the stack canary is
initialized in advance of any stack-protected C calls.

For head64.c:

- The BSP will enter from startup_64() and call into C code
  (startup_64_setup_env()) shortly after setting up the stack, which
  may result in calls to stack-protected code. Set up %gs early to allow
  for this safely.
- APs will enter from secondary_startup_64*(), and %gs will be set up
  soon after. There is one call to C code prior to %gs being setup
  (__startup_secondary_64()), but it is only to fetch 'sme_me_mask'
  global, so just load 'sme_me_mask' directly instead, and remove the
  now-unused __startup_secondary_64() function.

For head32.c:

- BSPs/APs will set %fs to __BOOT_DS prior to any C calls. In recent
  kernels, the compiler is configured to access the stack canary at
  %fs:__stack_chk_guard [1], which overlaps with the initial per-cpu
  '__stack_chk_guard' variable in the initial/"master" .data..percpu
  area. This is sufficient to allow access to the canary for use
  during initial startup, so no changes are needed there.

[1] commit 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")

Suggested-by: Joerg Roedel <jroedel@suse.de> #for 64-bit %gs set up
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/setup.h |  1 -
 arch/x86/kernel/Makefile     |  2 --
 arch/x86/kernel/head64.c     |  9 ---------
 arch/x86/kernel/head_64.S    | 24 +++++++++++++++++++++---
 4 files changed, 21 insertions(+), 15 deletions(-)

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
index 6462e3dd98f4..ff4da5784d63 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -46,8 +46,6 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_head$(BITS).o	+= -fno-stack-protector
-
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 656d2f3e2cf0..c185f4831498 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -318,15 +318,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
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

