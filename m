Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B324D097A
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbiCGVfp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245590AbiCGVfm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71070046;
        Mon,  7 Mar 2022 13:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsCX2gJypXK+YNHzLLko2hsSVVxP0f+vPw+/JGT8luqawZyAyh8zGuWoG74UROMU0YfGd4NA+N2WQsJFREWQTAK/nrdeLk5/yOkPDK79PQlm4Nl9dQRLhixC309N2bYa3OIgo0VlgsIET/+1O4rszSxvy2o0QNaYRnU0gb5HRb64f8X07kQOTJk572/HN4cYJmnAAaBXN6tXGsutKTY1K9Y6u+i8hRXpXSqdD3jdpvHS6lshesDYXu94UT6Q06OtPUOwJie5Y5Uga69yjxUUuQuKjIbE9p7+2SLE8KIXk/pF+ylhMbsA2+P29iD1bCA6DQUsbSLMwqlv5oE8B1PMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za5TeV7uFgXdJIpp8R18s3v7VK9jY1eP0jI27ay+MSU=;
 b=L+yw+LpoMUwF5PgD0QDyLz6oZ+cy4YFDZdFn3ooADq4MK693FPu4O33GrTXc0c9QKFJwtzUU8dVPWIj1nkK3Z0lBLrs0ILKeVX2E4AxcqvJiCOI8qWleeY5P/LXffdHdHZI367vTFLUBO9OJ6lKSIoitmdDUBZQCvVqKI9iMZQ9I4VVBe7Zoe5SpJycYtSV6Pel73ZumfbW0WamAT104dCpVdf0praE7YTtUmVD0I8YCfy7Uc7vTABcw08DlbWUThvtwiU1OMYv1JQ8jeGrnUmckr5GNHgWCpKLnBzZCwpxCUkb1xH4ETlNm3QJZRkbIXxfeKUDKGAxVl/U0bj6rGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za5TeV7uFgXdJIpp8R18s3v7VK9jY1eP0jI27ay+MSU=;
 b=pfeBU1/Sg38Org0A6NRhYAd9SjBBa3G3wQJRcXgG/Ck+bsFGERse2nXkYRBuu+aB8CfZutPrx2DkZp53SPDVf5zxgcvSzmxywycjlTL9eopL6LkdjKRCtwZUWjeynT/beQ7fBvTMbXoQb7+KZO28sJkP63ac1u9tjquwiOFoOsE=
Received: from BN6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:404:121::26)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:38 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::a8) by BN6PR18CA0016.outlook.office365.com
 (2603:10b6:404:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:29 -0600
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
Subject: [PATCH v12 07/46] x86/compressed/64: Detect/setup SEV/SME features earlier in boot
Date:   Mon, 7 Mar 2022 15:33:17 -0600
Message-ID: <20220307213356.2797205-8-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78223179-6686-44c2-7ac1-08da00824809
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5306D7102E5D630C473790D2E5089@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPqfvlVXdgwOsuJRBbr/OEPdq8X0+xguFOd/G2D2BzspyQ5m2zJiDdbqbJE5CgrgJurIaO62fIB2Wy6BACKFLUpDT+CNUJlvICb71mJzti8cFUiO2HqbibJhyCGfTjHorUMjYjWphxjEiUoC1/xLxwuon8WQHoCeXS4O9g3RJF5G+ZW1wP+LiW57zv7Z7HHza6/jBax+dUFyFY6r9n6c/U727Wl4/IuvL9IUpCAuuvrguQw4mUoXSWZjIyVT0ADVNNOnh0yhNaFDo2jxRXj2UCAr5iiADAmC7KFtO1GTv8qa+dfh//xTFJcNWoYkwHXmU4z3NzVypyBtjheBXBt2WA7lc9nXOvPgKu4iIsh/RzJ6W9mWxuA/GiRoLsO4qvYPTPSUNH4+CmWKfySOVAkW6VY3BMGEtufwM8BH62FuJhN1IP9PX1hXOsPxXQMegZS2kXkrVv0lS2hbgSc+ljH3pmOkbteCBpLd/mEBLNgxyUYELtF7ngfug3f4l7ZL3XulesGGiIFPo8Oxit84YKMPDvuM8lnGa1IWeqJuLzAknL+RVhEdXeUkmPVBUIrcLWlajmH5av2+bBqsK9Bne2MKLyADLXVgGDhyNpgnIjny7xjXMk6KN24HIRZNCk9st42SdhrO9+HlNG1uS8xZfvaaP2YsZgRV2c9Hef+wCInme0uUg+fVnr/B0WLj1nIdCaYhF3oMu0wGY7v6ogz+ExNuN3vwJQ/vt64I1076dWAfkpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(36756003)(7696005)(2616005)(83380400001)(2906002)(7406005)(7416002)(5660300002)(40460700003)(316002)(26005)(54906003)(82310400004)(8936002)(81166007)(70206006)(70586007)(44832011)(336012)(426003)(356005)(86362001)(186003)(1076003)(6666004)(16526019)(8676002)(4326008)(110136005)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:37.9894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78223179-6686-44c2-7ac1-08da00824809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
 arch/x86/boot/compressed/head_64.S     | 37 +++++++++++++++-----------
 arch/x86/boot/compressed/mem_encrypt.S | 36 -------------------------
 arch/x86/boot/compressed/misc.h        |  4 +--
 arch/x86/boot/compressed/sev.c         | 36 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fd9441f40457..4cd83afb9531 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -189,11 +189,11 @@ SYM_FUNC_START(startup_32)
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
 	bts	%eax, %edx	/* Set encryption mask for page tables */
 	/*
-	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
-	 * will do a check. The sev_status memory will be fully initialized
-	 * with the contents of MSR_AMD_SEV_STATUS later in
-	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
-	 * is active.
+	 * Set MSR_AMD64_SEV_ENABLED_BIT in sev_status so that
+	 * startup32_check_sev_cbit() will do a check. sev_enable() will
+	 * initialize sev_status with all the bits reported by
+	 * MSR_AMD_SEV_STATUS later, but only MSR_AMD64_SEV_ENABLED_BIT
+	 * needs to be set for now.
 	 */
 	movl	$1, rva(sev_status)(%ebp)
 1:
@@ -447,6 +447,23 @@ SYM_CODE_START(startup_64)
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
@@ -559,17 +576,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
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
index 4e82101b7d13..27ccd5a5ff60 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -201,3 +201,39 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	else if (result != ES_RETRY)
 		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
+
+void sev_enable(struct boot_params *bp)
+{
+	unsigned int eax, ebx, ecx, edx;
+	struct msr m;
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
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	sev_status = m.q;
+	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
+		return;
+
+	sme_me_mask = BIT_ULL(ebx & 0x3f);
+}
-- 
2.25.1

