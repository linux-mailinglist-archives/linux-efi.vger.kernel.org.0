Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631BC4C3287
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiBXRAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBXQ7n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A662122;
        Thu, 24 Feb 2022 08:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7imuvM3XmCq5AfqWdtpyL22zr7Afkh3x9/djbdr7VZtV+6ToMVkIu4btcWt3W5VsVe0CD3qrQxZxfd2Nm5WXE8WCLCCvLQvYNNjWb72qxmTFG8srHcD3LRpTfPnpROsv7HAWDpdw7oMaLnDEimuwL5DrDhgLR5eLYkN67qtNSNDh2+uf8HdQNUO+E4KFJXUnhp4RocOemiskQ0/ofEoVVJRUoAS9zpN/UJ2SuXuBKYzUGzpzsriqHg1WvfKEMripQz64S8xfYab2RCxh+Xxf4VFv6TSY1McU0rb9U5yH4AIDJtHDRIp8FTLLlQjjxiFS9aHv065AOjFmdYT3FzIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw4Dxy+VsWZLyerTWYMAsDC0yjmiPAW8pTtX9HntsIs=;
 b=Q8f/pKlV94Rf1F7GiKZ7Vj5bW66pflDoPxu6X4Ze41xEkbMsNp3+CPEDHd12h/kj8MteB/RgK7HaXMPafJq6bqvsZtxooGA7egsXsWTFKSDFVR1ImWoBEGFI8evMnjaOKW/d2dJ+ByxtdowTOO+7fjTOBnD7BBD+GMjhZlXjN3Fg6dwjqz5C1RIVJITOu6s+19PHaTtFInmW6ALd2DWLXTaYCID2Z8WdH5tXR4n0gF6GKbnqwfcSW6G2qY3+QbYtyFloXbI998XsHmosfBU5peFlfkYx5y3ZcKocw4FRgy8EaPsaOhKBaP7xQZ79j9ynSuoRoNIPV1o19kD5of8B6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw4Dxy+VsWZLyerTWYMAsDC0yjmiPAW8pTtX9HntsIs=;
 b=SDm/+FNUpNjTyTronyGp0oP8Ys6Yh8WY29eCYrRHBUhtIeAgCHGFmbeDSb7DMZY9UbpR87Jyn4tQw2FFZnkojY0AusQHne11mzFXSbKk/bRM4rokNTCBBDAba9mD4jnkkILIfNSHbadtjyssyL5N9z8+AppFDOrUBGFyY+2UOq0=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 MN2PR12MB3486.namprd12.prod.outlook.com (2603:10b6:208:c6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Thu, 24 Feb 2022 16:58:38 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::90) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:38 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:32 -0600
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
Subject: [PATCH v11 23/45] x86/head/64: Re-enable stack protection
Date:   Thu, 24 Feb 2022 10:56:03 -0600
Message-ID: <20220224165625.2175020-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f86550-6b24-4e4f-c84a-08d9f7b6e767
X-MS-TrafficTypeDiagnostic: MN2PR12MB3486:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3486B0695FAC2DC9AB38DEB0E53D9@MN2PR12MB3486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD+hi1dm+HD4e3IMnkrGVCBrgwMvRqw3Nii5NXNgWzlRGNndBNFVKSZz7tm1ukN+55NKp70eBTludFCzcEaH0CEk+g4y5qWWDyJmtACz9iHsWfBXjtAYkBYiUAw7uSbbOSwAJtImDKKliPaJfuUkZMNGlAF3BxoTW+Sopfi5JPQnGKX2SYYD8/UeKBi5D7OfWWUIFzCAogz8zmq1toZZe0ce6YTTNFPljw0UJPhlLo8hYmfTkqGfV7WsjxLJRjI36WS/vPAQiYv+P1/lMf6QZDiW5UxBoGFAtRVJJ5X5QHcbH+DGuOS8zgU1sBfexDCclfYN22GH7FwPLr8qeOY0HGjpoTwrtMfaZW6CVS5lmmwLgT0darTSqjuNOwkZefB+roUR9381lWlFJfr/itubem/uI4A+mIx3Jz/Lva/tjpKUWz3m0mMVUsQGaXuiIQ7f56S4uIkV8TEUDdc/0CpEDV/CZADb18F6iaVQvNeKblCPLfn8Z1XKqsrzlSiw/tijfzH8h47AFbfZFlIkYnvyrzaQ2O2fAVRVotWIadPFk5CGejtSjT5oCZFgxwz7Ni2PgNo+NwQjR2QVDvZJiheHaPz0rQW5mx0HnkQCwChzfmh7FHFiII4eIr11xbkQKMvvmDLeFVgnyIh3ZPXe6bkWWFCY95uRmtoX9Ps0qA++8IRcEKB1vuUL9DYFtFmNnPiLx3gn8bLkR9LEE6AS3VbI5oyVVTFZJWVTcAEgYdF4ros=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(186003)(26005)(47076005)(1076003)(426003)(336012)(2906002)(7696005)(81166007)(16526019)(2616005)(44832011)(356005)(36756003)(6666004)(7406005)(5660300002)(110136005)(82310400004)(70586007)(70206006)(508600001)(86362001)(54906003)(40460700003)(83380400001)(316002)(4326008)(7416002)(8936002)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:38.6989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f86550-6b24-4e4f-c84a-08d9f7b6e767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3486
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

