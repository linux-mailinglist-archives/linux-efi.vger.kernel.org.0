Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361049FEE1
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiA1RSj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:39 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:36512
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343610AbiA1RSa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J49tgDM2EyN93L6GasMP+0pGd30uluiBvjpGBw5Qv/iaXnjFSDi/hsvFzxqubg8849znUGwn5vRuspHe20it9ug9pBuaTt9BofFVCw7+YzNG+TSNmqQxCp5Sm+ilAO0R2UNpB0qMPTIPJLCN6kR4ToE9TlH2kH6GbVB1NqM1uVANBH5OvZFX0/TEgpD+vE4sTqscyCy4Md5jcBUOHm/jbXjsRE1ugSe20oNz9FehoZff9EAuxGKgvhjh0HChGlKobfWrPXQygEIIP+rgQrBbWbrJXprauFOrVqjh/tVbtGcMOa9oF0LI5s7eSWVv0lNSMr17BnzUR/CvpoRZMd9UNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZMB4XV9tGrCsoPR/3gZ3Dz37cRgbmswFPz8yV3n+c=;
 b=GhgGOH3g8C+neYWZnVyCSTmp/ijaCGrLLYFWU9zs8O0ERCWKMsrtHeVy3Jd6XN10wmA0uR1arbHH4NAHDl7tin1WYF6/2QRtqBHu9nCcA9fmFBCmphnkquXxoykIPiT81EbDg8St7rtfFrAnjm/2drAwS3mHuCby/ykwbTb9XsY194Y/myxgyMRzxDK7Q9pxOy5q1XpkGyyHLAiI1f1DiJNySJWOfOc5pDOZKLqhQwXy74abp4PKcBF3u/6M+edMllqexR97yAGPuuyqH6OcYCM8QXQdErca/GAKp2/x49NMb/6JF6qN18EDhVQUIm0DkZRAAYu8w+Sje0KyDRfq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZMB4XV9tGrCsoPR/3gZ3Dz37cRgbmswFPz8yV3n+c=;
 b=hnAGiOXGik0SAspyL68DWsSnoCF4SCKgpNdIeGnk8dyHvU3PUIHYwkF22+Q8zxnzotf3jGzIj7eX7zfQ7YBGn1BrM+h3NFmboJMe0XQarIKWZNdx4IbeWjQHQgakgYnHvcceI42NqRNHk4EfVe1wA9bmG4kTP1MvKJgWw0noYmk=
Received: from DM6PR07CA0122.namprd07.prod.outlook.com (2603:10b6:5:330::18)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:18:27 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::36) by DM6PR07CA0122.outlook.office365.com
 (2603:10b6:5:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:25 -0600
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
Subject: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME features earlier in boot
Date:   Fri, 28 Jan 2022 11:17:26 -0600
Message-ID: <20220128171804.569796-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78ba70a9-7367-4f81-88a8-08d9e28232d0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2560D8BD84EE19C1226C0ED3E5229@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ykR3D5RuXp5Bvdu6FwC8AdfZMKA07m3nYlmMScU9GCRcGJ8ah0SC/aads4ekpgoU3jBGVZD05Hat4IhuabmZOe9SdRYP02RAmyRKufdN96ImIvONSpkJtbMhlbGq0yufMWEgPfOo8r0Gu/bR1k8cCtvLLwAKXvYY83lXRRF9Ncah/O6PhguPRoig3dd1tmupDxPAtMzsS3mEg5+hbLK+cRdg42mJCUwE20yW+IkJb3LMXd4T+Y02o/tOQNChfpRCG2Dw7L1JT1b2S5jLC8Yvj2CyPh4yGetGJDUkCWeAZ4Yugfg43CaPuc6g+e0jjRGR7PkO8KcyQXZhbobo/B/NViDT/BcePz7TClkaunsLHm0nFTMKuZe0SgynrvJcdatmR9EvsTPwPTVW3EgNro3BzTMIoIY7cRu5ZXLOPXH+a1nbQ0IeyRib/KCq8iIUIhrFYRMx6q0PEiAqYYGLZ876DeXQ4KSblAFyhbxfL7gNSbWcn/PE5u/PSS0oEhdArM9vqx0yQVqE5SjFan8cX9j6afN+Ry3YvgxJghDelDEWNmKFGm9DjD1Tv4RRgXt4f7NJMUO1YtU/dljw08GSSHGik5/noSBjsedD+M2ZpqvPblqKou6J68rB7jlW0TrD4YivE1jtWqsu//5KXuDcUCh14ptugtLmXywb/aapF/jk5h/sr/zSCfypxBGC7DPYTs3byM1fvbEejycnIIpiXM/bU3iFLnilzRnRcBSAkhmSEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(508600001)(8676002)(36860700001)(70206006)(70586007)(16526019)(7406005)(4326008)(186003)(26005)(316002)(1076003)(2616005)(7416002)(82310400004)(356005)(44832011)(81166007)(86362001)(54906003)(47076005)(336012)(40460700003)(426003)(110136005)(83380400001)(2906002)(36756003)(5660300002)(7696005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:27.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ba70a9-7367-4f81-88a8-08d9e28232d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

With upcoming SEV-SNP support, SEV-related features need to be
initialized earlier in boot, at the same point the initial #VC handler
is set up, so that the SEV-SNP CPUID table can be utilized during the
initial feature checks. Also, SEV-SNP feature detection will rely on
EFI helper functions to scan the EFI config table for the Confidential
Computing blob, and so would need to be implemented at least partially
in C.

Currently set_sev_encryption_mask() is used to initialize the
sev_status and sme_me_mask globals that advertise what SEV/SME features
are available in a guest. Rename it to sev_enable() to better reflect
that (SME is only enabled in the case of SEV guests in the
boot/compressed kernel), and move it to just after the stage1 #VC
handler is set up so that it can be used to initialize SEV-SNP as well
in future patches.

While at it, re-implement it as C code so that all SEV feature
detection can be better consolidated with upcoming SEV-SNP feature
detection, which will also be in C.

The 32-bit entry path remains unchanged, as it never relied on the
set_sev_encryption_mask() initialization to begin with, possibly due to
the normal rva() helper for accessing globals only being usable by code
in .head.text. Either way, 32-bit entry for SEV-SNP would likely only
be supported for non-EFI boot paths, and so wouldn't rely on existing
EFI helper functions, and so could be handled by a separate/simpler
32-bit initializer in the future if needed.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/head_64.S     | 32 +++++++++++--------
 arch/x86/boot/compressed/mem_encrypt.S | 36 ---------------------
 arch/x86/boot/compressed/misc.h        |  4 +--
 arch/x86/boot/compressed/sev.c         | 44 ++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fd9441f40457..49064a9f96e2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -191,9 +191,8 @@ SYM_FUNC_START(startup_32)
 	/*
 	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
 	 * will do a check. The sev_status memory will be fully initialized
-	 * with the contents of MSR_AMD_SEV_STATUS later in
-	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
-	 * is active.
+	 * with the contents of MSR_AMD_SEV_STATUS later via sev_enable(). For
+	 * now it is sufficient to know that SEV is active.
 	 */
 	movl	$1, rva(sev_status)(%ebp)
 1:
@@ -447,6 +446,23 @@ SYM_CODE_START(startup_64)
 	call	load_stage1_idt
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Now that the stage1 interrupt handlers are set up, #VC exceptions from
+	 * CPUID instructions can be properly handled for SEV-ES guests.
+	 *
+	 * For SEV-SNP, the CPUID table also needs to be set up in advance of any
+	 * CPUID instructions being issued, so go ahead and do that now via
+	 * sev_enable(), which will also handle the rest of the SEV-related
+	 * detection/setup to ensure that has been done in advance of any dependent
+	 * code.
+	 */
+	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
+	call	sev_enable
+	popq	%rsi
+#endif
+
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
@@ -559,17 +575,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
-/*
- * If running as an SEV guest, the encryption mask is required in the
- * page-table setup code below. When the guest also has SEV-ES enabled
- * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
- * handler can't map its GHCB because the page-table is not set up yet.
- * So set up the encryption mask here while still on the stage1 #VC
- * handler. Then load stage2 IDT and switch to the kernel's own
- * page-table.
- */
 	pushq	%rsi
-	call	set_sev_encryption_mask
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a63424d13627..a73e4d783cae 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -187,42 +187,6 @@ SYM_CODE_END(startup32_vc_handler)
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
-SYM_FUNC_START(set_sev_encryption_mask)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	push	%rbp
-	push	%rdx
-
-	movq	%rsp, %rbp		/* Save current stack pointer */
-
-	call	get_sev_encryption_bit	/* Get the encryption bit position */
-	testl	%eax, %eax
-	jz	.Lno_sev_mask
-
-	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
-
-	/*
-	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
-	 * get_sev_encryption_bit() because this function is 32-bit code and
-	 * shared between 64-bit and 32-bit boot path.
-	 */
-	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
-	rdmsr
-
-	/* Store MSR value in sev_status */
-	shlq	$32, %rdx
-	orq	%rdx, %rax
-	movq	%rax, sev_status(%rip)
-
-.Lno_sev_mask:
-	movq	%rbp, %rsp		/* Restore original stack pointer */
-
-	pop	%rdx
-	pop	%rbp
-#endif
-
-	xor	%rax, %rax
-	RET
-SYM_FUNC_END(set_sev_encryption_mask)
 
 	.data
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16ed360b6692..23e0e395084a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,12 +120,12 @@ static inline void console_init(void)
 { }
 #endif
 
-void set_sev_encryption_mask(void);
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+void sev_enable(struct boot_params *bp);
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 #else
+static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..c88d7e17a71a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -204,3 +204,47 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	else if (result != ES_RETRY)
 		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
+
+static inline u64 rd_sev_status_msr(void)
+{
+	unsigned long low, high;
+
+	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
+			"c" (MSR_AMD64_SEV));
+
+	return ((high << 32) | low);
+}
+
+void sev_enable(struct boot_params *bp)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
+	/* Set the SME mask if this is an SEV guest. */
+	sev_status = rd_sev_status_msr();
+	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
+		return;
+
+	sme_me_mask = BIT_ULL(ebx & 0x3f);
+}
-- 
2.25.1

