Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF85470473
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhLJPsj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:39 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:4641
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243399AbhLJPsC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S32E245YPXpEhOg1j/weYkanIV9bHIMNz5h50SRkQXMlQlFSacn/XUwrKRj/l4HPvW2yCDc5dLp7OojtALAGqa8Xdq4c3pfALHTEYTZDicsR/+A2OVwUBydgUuT5afjPAW9oeAZkX+zJDBZBwphghEfdyrinA55AnnGLp4Jx9wo9OtQSaBOpd2k+z0s8Nu1GW6H/tHdO1DKCAl+eQv1qiqFhHUOAhXkq/Yrm9uZtJCto200LwFF2MuYPnVTFDU6H4Q18iTkbHB2j+qBgo5j8WJgGX/eVlPt6KCn/5iyvIU3KxjWpqoI4Nd5JciVhoxj626LlTQXzwkta6nFDKv+Rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jzk2otq6YX9U9yWJcceZWRm/4NrtjRWYT/pKkmy3zw=;
 b=icyGA/Olf5Exakj/AkzwAXvS6M/DymecRq/SAk6YsuBuIlNdyUw36uUlNsCvzrSkDeNYUFcridZV6AobRkPDN3Em9DGCReRKACZIYq2QGL3yB0WxtoE6KO5CT8GwTZgvodh3kvtYiD5JGX7P1HynZa3RB95FTbmz8fBHXz1lS5I30x7u7SKaMmPqOtK63W+VMgic/tFXtTaWQ6Twsqw+/JZ83yAtldAUElxbPBz+Vd+zeit+NTQlsn4A4dinXSgrZx6+jFwjsP1pRYIfpD2i8Z13Co0vQXts8i0d4dq73vav3vBoM85RfUWgbOY+pomudEpyBcIuy8KafKKj4rXNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jzk2otq6YX9U9yWJcceZWRm/4NrtjRWYT/pKkmy3zw=;
 b=kJlKjvsuLlfNbnXgwuU/I7uuCg6mSYojVagzUnApvkff3B4EpNRhP4UWECcKDM8nVu7reVgY54WCxLTb99AIOEJpOirpGVt/FKVizJsuyEfzqbkl3W6A+/ZsgVR69MgxIPUlWsyOuAAifrd8q7N4YHOnttZLInRcD+aiT/vIGXo=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:44:23 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::c3) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:23 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:20 -0600
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
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v8 21/40] x86/head: re-enable stack protection for 32/64-bit builds
Date:   Fri, 10 Dec 2021 09:43:13 -0600
Message-ID: <20211210154332.11526-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c2e1d2-bbcc-4ac1-9fef-08d9bbf3f04f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3269:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3269656E3F69270C551AAB2BE5719@BYAPR12MB3269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwmYQxR5CgRI2cW2CzREM4ICCsO3m5d3I+9MuMmEYBNfjT66xlDWo51KoxJGA1c7UbQdH4Me0E2NzTuLInO0cC8BcpWgxhrDRVm/HcLv7RSU4Iyt0qD62bfhoxAUFlyN12HfSCRbJPpYOiYNs3RqeafuvZ1GkEg4AuuxgMKvv3Scqt+tZ13fLtUyy/nMvuMe/Qn+yF3OE0BYqiRdzUwYRMq2y2E6OxNFdtsd/NwQWD+9ciBqjf4lcwtU7h2+DTrkfe7a5UbtYldLdZB1WdMh6cGlipgwqDzdQBijZhx9VIX4HRHCyW9Ux6Gje+eu67N1yycBGRf5qUzHkFUOpxxtH/CXjha7HMlTN5J8wkzxIDk/jnitLGSJBFJLJI1vdKPTLcjlokrgjNlfZjZWaweK6z3DU+cBzLW+vFNyJAvrT4FZ2biDJwm7Yx52pzJEe2Qb+ar9fwif1lGk2NKhJHAH7eX5aOfp4VJgguiR7VPG1vPYOOqQbn7KKOnHkM+acSHCMUwc1vUb8dcSW5nJCwZGzojBf23PlR8/Wwuo3pLExy2C+NXu4m4rpcw8zPf9n8QvSBjfVjz7+inM8J9Yhx/0808/CcLnV/oSyN9t0dMDvt6+feE+em6YvfpehQ7L29W+JO8JAjs03iqlBTuYPdQjd7J6QztH3jh7NZWw8skfWOIlxFZDGMCEIrA9i57EyZvFN2tcnkuxfacEaANuxYzL/JtdXv6gzRutZWXPfjlTHjPMNOr8C5vlLRbwhh2Ht9C/f4qzLt4AjPrKdaQVeCUuFDHWeI+xbpoMUYryaoCnX1mFLfHSUaTcQZwyOJuENFUt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(81166007)(316002)(44832011)(426003)(336012)(83380400001)(54906003)(6666004)(2906002)(36860700001)(7416002)(110136005)(16526019)(186003)(26005)(70206006)(7406005)(7696005)(82310400004)(508600001)(70586007)(8676002)(86362001)(4326008)(40460700001)(5660300002)(1076003)(36756003)(2616005)(8936002)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:23.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c2e1d2-bbcc-4ac1-9fef-08d9bbf3f04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
to allow a call to set_bringup_idt_handler(), which would otherwise
have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
sufficient for that case, there may still be issues with calls to any
external functions that were compiled with stack protection enabled that
in-turn make stack-protected calls, or if the exception handlers set up
by set_bringup_idt_handler() make calls to stack-protected functions.
As part of 103a4908ad4d, stack protection was also disabled for
kernel/head32.c as a precaution.

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

- The BSP will enter from startup_64 and call into C code
  (startup_64_setup_env) shortly after setting up the stack, which may
  result in calls to stack-protected code. Set up %gs early to allow
  for this safely.
- APs will enter from secondary_startup_64*, and %gs will be set up
  soon after. There is one call to C code prior to this
  (__startup_secondary_64), but it is only to fetch sme_me_mask, and
  unlikely to be stack-protected, so leave things as they are, but add
  a note about this in case things change in the future.

for head32.c:

- BSPs/APs will set %fs to __BOOT_DS prior to any C calls. In recent
  kernels, the compiler is configured to access the stack canary at
  %fs:__stack_chk_guard, which overlaps with the initial per-cpu
  __stack_chk_guard variable in the initial/'master' .data..percpu
  area. This is sufficient to allow access to the canary for use
  during initial startup, so no changes are needed there.

Suggested-by: Joerg Roedel <jroedel@suse.de> #for 64-bit %gs set up
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/Makefile  |  1 -
 arch/x86/kernel/head_64.S | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..4df8c8f7d2ac 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,7 +48,6 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 99de8fd461e8..9f8a7e48aca7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -65,6 +65,22 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
+
+	/*
+	 * initial_gs points to initial fixed_per_cpu struct with storage for
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
@@ -146,6 +162,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
 	pushq	%rsi
+	/*
+	 * NOTE: %gs at this point is a stale data segment left over from the
+	 * real-mode trampoline, so the default stack protector canary location
+	 * at %gs:40 does not yet coincide with the expected fixed_per_cpu struct
+	 * that contains storage for the stack canary. So take care not to add
+	 * anything to the C functions in this path that would result in stack
+	 * protected C code being generated.
+	 */
 	call	__startup_secondary_64
 	popq	%rsi
 
-- 
2.25.1

