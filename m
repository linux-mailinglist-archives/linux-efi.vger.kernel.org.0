Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8244CBD1
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhKJWL6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:58 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:54435
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233723AbhKJWLa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGfbx8sAvYiQpLm73cJWkwtibJ9cHmgyEK6C19KEgJD8RlOr6p/j5IGe+/xbig6LXU62Ee6+dvEN8Atev7u4qyQaIgh/1ipGYuZCuPID/I+DTeR9g5GDGGgXr596xuLucjC8IiHnSFJUdlI+pe80IgD17445snlxlk5299o6fsUNJbvSGviiVKPdTg8ogz15midthJaKJhDu432E8DLzLa+srdXtN7uTzFpWrg6wlbU/YOdoJGA5wgLW/moQpHsoXy3b0fZaXdW+eDOWKdxn5yTmwE11HP7hR+fDWAOtH9UCzTfjaq6unXEgrhxL+/6XaRcL542/SZSN6jsa2TsOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPXzH3Bsug6WGB8FMnXlcHfENVqw+RdwULEDA/GB1ps=;
 b=i+wV9pZch5jPBbpTZvpeTxhjZ1dn5cx9lpZz2JOETJa+F4l9zVj+NRZRHOhNy8pjRl7wE9IePIbRu6sjJd975w1Zx/qKEeVB7qompkw4ogiSLRo1L0Md4RWsk6YIvmW0Q0yQTE6dimPkz4/dE6NrqlKJzNosl2W51Ue79ENgRhZ4bDq/IXM6QNmAy+3B0FWW8GQO5TJbXz6eMog3aebxYmn6g4Pe83RS4twK02hzc2XZtWPjJAZOobATT91RyefKhy57KB4fOQwJWU2tFRm8eZD47qbHtfaYmojfI8GBlsO09r8oD39FzFqOmnNP3mEccWlBzyiA3vD5IBbyL2HU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPXzH3Bsug6WGB8FMnXlcHfENVqw+RdwULEDA/GB1ps=;
 b=hsHhfk6dqzbqBS0ggbQ0+m6E6mdCkV4PFUD2VxEDN+pexEoHRDvYg1dNg/k07oswj6BR4cNjdO8yw2AtRmkEwZApolggA/6VJYYtnoQPk7mYjeyXBOjNsgIQsz/Jab1F2e+AdPAjDYu17vDlBUl+Edh5+h+uEm77cp4aUpJi7ss=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 22:08:37 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::71) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:36 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:34 -0600
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
Subject: [PATCH v7 26/45] x86/head: re-enable stack protection for 32/64-bit builds
Date:   Wed, 10 Nov 2021 16:07:12 -0600
Message-ID: <20211110220731.2396491-27-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13dd56e-051f-4778-3fac-08d9a496a4f3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1260:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1260425842EB8B82A15C44C8E5939@DM5PR12MB1260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVMGpNGsu+qJXTz9Q4sFG40e2yZnhu4bY1TQpyQmpJQy8TTbqSqi6rrY7oqf9EQH9yyokndVrj2IHpLwFqpxDALH2PCbuDJg+a7N8lptr0SvuGgljuLlDhHVFCpjGFvo3yztPStFgsHBJi/ZOKvq5uMgWnMrbTETkAuhvWgEuwV0f5XVkCNfoFF61oswI0pQZqhyjR/i9e9YxoIt4H+TfqfdGAii2fRtvCLzVCyXKKMh++l+IlRncsSnzvv0CDViomzaxLvr84RRsGbInuz5KUuLkNP6qzKj/SBen+wavVCPXU0/t+CikueD2oKATO4p36e18rP7VVaEs5K6hi7ctN30lZrGdzDXcK1Batyla6n6CSFk04VZkGBSrmpRM9p1eyW9oSD4aulHSjtaSZfR0vM9r03Ln4FHh/yvqinViIPAfWSxxrWAc2moeWyI3bUo0w3qqGI/7msLv743UuYvwMpsKXjDlU8b6csSve4g+Z0+9pmgD3yd7IyLdpXmsSI/hq+ov+7TY1MiW0IJGgeJnE86PTmUFfVLJVESfhSq7bn11KBfk0kMPeDcxHFFlHrJXbusKOLIeWZY3FoQGVclXYVvUrdB4mEXMHbas9H269UWAGpYkBGx7uPhdC9b40/k424yslYfB6nVUeCrFVNqpz0QYdSHaomCsYeTBhW6R2EElkZzQhsOvSlka/BeDJEyYMW63XjjKmEO//igjR7Ha6urzlGWOVYJb3VWNwjYiJkws/mSFzWS6mbxSbPfhyjQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(82310400003)(86362001)(2906002)(44832011)(508600001)(70586007)(7406005)(7416002)(110136005)(6666004)(54906003)(36756003)(316002)(47076005)(356005)(426003)(186003)(36860700001)(81166007)(26005)(2616005)(7696005)(4326008)(336012)(5660300002)(83380400001)(8676002)(16526019)(70206006)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:36.8230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13dd56e-051f-4778-3fac-08d9a496a4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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

