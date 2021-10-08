Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B4427035
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhJHSIg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:36 -0400
Received: from mail-bn8nam08on2042.outbound.protection.outlook.com ([40.107.100.42]:23064
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241389AbhJHSH6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be+/vwOsK8n6U/+vpBHVadhikf2C14576AHAQ3XNkKrN7PkTHAjLquWEqwNdqlTd34rv72vioijDwOSZgwzJjq44l4zzhRhLO8CNgJkXBFB/6PtJjkQBjmPTOKX51XTMZon7GWUcuhwi8x8JFXvfJBLAqxFsuRx5bFN9fqs5AK1c10TTp15euEw/DSxJEvSWv7RF8SglnR4czzpFZgSxS4gOemrZUdNWQleetbQ/J/P9Fq8ovxnJkQyzy963cfaJ0FAXJeXAoKdb33sQwCUxE7pOGgo/QclZKY79fnEUMTiNLDvCkLGnLi8qMgTS/ffuBLKT/kV6Snm8YxYbftMO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPXzH3Bsug6WGB8FMnXlcHfENVqw+RdwULEDA/GB1ps=;
 b=iadus4afvxzQaUFo+mCCMuWJRfkhiXyyU016yVNUncm+cJyR4Ru9/waH/sJgg662CrAXIQB6i+twFyX+mteqAx3dVb4xbd+Xj2hpW80YjqNC1Vv6A5kCrij0G/cFhoEpn7gPNf++T+BA4P9uoy4QpdUQAjM1cjjYXOrNLXh6XqzO7rTAGbj+mhHXeBJFogEIkIPSgN2qVZ5eawbRSLctDKLUi+WrEFc7os8qoeFG8D9eRsBfRWtHwcAqivZ21TpZZPKqdCMj0m9P27YttNW/0EnScstYsK9I/k2nqvhiNKqOS13DARqZ86TyY94McCPXco9DP18x7Yd1MUTTbOViWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPXzH3Bsug6WGB8FMnXlcHfENVqw+RdwULEDA/GB1ps=;
 b=wbkkstahliTIsguueeZcku7kEM8kie7eoMTQPp0d7ppA7xME7NTNQEgsv/F3I4xXTqov4znscMBblmWYMnC+XlKj016CX6EzIJw5fQtvncLrmpqoXKaVKFWhI51cq5NfVsXd8tYQO6CtXDiBYQCzqeXf6YXOhsufX/4d451T1co=
Received: from MWHPR21CA0066.namprd21.prod.outlook.com (2603:10b6:300:db::28)
 by MWHPR1201MB0029.namprd12.prod.outlook.com (2603:10b6:301:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:05:55 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::cb) by MWHPR21CA0066.outlook.office365.com
 (2603:10b6:300:db::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:55 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:53 -0500
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
Subject: [PATCH v6 25/42] x86/head: re-enable stack protection for 32/64-bit builds
Date:   Fri, 8 Oct 2021 13:04:36 -0500
Message-ID: <20211008180453.462291-26-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97eac712-136a-4258-f03a-08d98a864638
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0029:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0029334DD302A4462CD3B6CDE5B29@MWHPR1201MB0029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yYNTAUPxEnf4Yfy58jvNAxFpltNZdb7yqdrLANEfd2FSbWSp+sf1YMT3adLm56ass/qjOKvojwcbRY3dSJ5dEHBT2YBZXuwMr/MHp1dCwtVDjmzS9EhLw/+awIU7KdF3ci1rvtL7rXDKYajksqrADDyIUE48c7/aO3idDJj9H89CNx6Kqq4grzaNBA6TymA2X8yrQoY8gbx62Id8Km0ji1tunZNft6e6wvNG255NEBq5Z2l0z9/XEYtQsgiACiqYqnC5zYlPjanBOj6lxGyHcHRczvX+wkNz65ZEzAfKzlewJ1ydiriOvlbNgbVQ934iRoLmTVXSeMXg0hD0Q834e8YOPWJMxSvbVVj/UR9FOZXfleRDRHGdSR9CFI8LE7wFSk4K3NG+ZdcLyjTJJHBIUxUP+/QeT9QEcNCZngrOreEwn3hlFGnvww1o/S2h/Ox1Zx6ol8fqUVKJW1/MFQO59ywOFNPe66trpzcr/4t+p8wxsvlPwpN+mbF842ojl4Z9AcEefLLqp+R+De0kIlW1PpJPRPUhikPC9DmupEcmeUhhiGgyyihR1LsRpkTJAM+t/dtRs3Zav9s4SrTwoOMKTimYELGeCEzm3DgH6jnRuX0WQ7XV9G5PEEzjNE3rgHdjwMP1OJKWSuR/uoiHYpGTNQrgcr8gGypxNtNhApWCmzqMrNBb0oaMg8L1HuQWBTphJVVRBFpdxO/+Zu4wRM39AbOVFBfNbCpKWuN/Tscj7whX77HtokGWsy68UApedxC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(70206006)(70586007)(16526019)(186003)(47076005)(6666004)(316002)(2906002)(4326008)(8676002)(26005)(82310400003)(54906003)(508600001)(7416002)(7406005)(36860700001)(5660300002)(83380400001)(44832011)(1076003)(426003)(7696005)(356005)(81166007)(110136005)(86362001)(36756003)(336012)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:55.6484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eac712-136a-4258-f03a-08d98a864638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0029
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
index d8b3ebd2bb85..7074ebf2b47b 100644
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
@@ -133,6 +149,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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

