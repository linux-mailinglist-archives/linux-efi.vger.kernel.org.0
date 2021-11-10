Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94544CB90
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhKJWKs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:10:48 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:38692
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233284AbhKJWKr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nozbnpUROn4gZ/37AMnFvYu55/nqWhIcFC+fh4yPd2YrVM1gjpkS+0LySALsg52T7V+43jll0gwhi6SsAPszjX1h6EYaA/UptmKrHlw9Am6dntMgMW1zBTc6mSTJgTJEEhmCwKm0nJdFBCf6yQ680QnoMuIcc2nOLCLccvi/JZBo4xG0xNHBLfxSojzTr/pX0Lbf/l9jlPMt0HY+1PQdPB1ls60sXxHNKmMRXEZ4IpBkPyadv0lRJE5usL/4Rm4lnATo8nQT1tCJyB4irDddhXXISwZ5VODUWIcuC9ao66xUvgdX6ROH7QuR0PvAy8OVV0bI32H+c8+n9AEPSi6/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1fkiTxS2On6U3DRQu1fnaSOMVFxDjKSKshkXWfevBo=;
 b=UXfrXxh8ZF45PJqAFlzRwsbATZubRG3kZauFkoysMrLHVTXEeyiu3WHBApZ8Ss0GV8AjlXvTLEhcXn2CsprSQaxzzql9cMCea6Lu6GxBMH5BIoS5xrEyExfF4WSgcaM4SBmxBybscoFH9XxgLCL+0uq0ZH3QbljfQtBsrXa0BN5kHwaHT1jB6jBA54CBBpXyyrF2/amx/o+9jubgKeAy2rVAWjPs5E5buchPsqvDWwsofpsaWXgX04hmNls1Xy1olqCkNSQC43FN01gtZPeLRoanXTjmj7VBaWSguY7fl8MdZOvNsKJYfMn+3WZkBW0u1iXpICP2scROmLaUPgvXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1fkiTxS2On6U3DRQu1fnaSOMVFxDjKSKshkXWfevBo=;
 b=qe3dyqehYfvccB5RR8RDfZqJdEzxe2bb8oeKp5/vf71NS5/Nd4zJbHYdpqDPsCUBVONJRhWXiUgW+4QdA/EZTO9BsnCMCvUJ8cz6QsQKxNfTpTMJJ9I0UWsry1DQl7XA2PesxXtgF9pEE5qyaPK6dFTP6rGCpEa4+vQFLHMdWAw=
Received: from DM6PR06CA0030.namprd06.prod.outlook.com (2603:10b6:5:120::43)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:07:55 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::53) by DM6PR06CA0030.outlook.office365.com
 (2603:10b6:5:120::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:07:55 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:52 -0600
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
Subject: [PATCH v7 01/45] x86/compressed/64: detect/setup SEV/SME features earlier in boot
Date:   Wed, 10 Nov 2021 16:06:47 -0600
Message-ID: <20211110220731.2396491-2-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 658b9328-3736-4add-cfec-08d9a4968c29
X-MS-TrafficTypeDiagnostic: CH0PR12MB5252:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5252223579E191E82373022FE5939@CH0PR12MB5252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIuxxmImTCw16B4XDzs8Jq1ilpNaDboHmbLWMDhoZieeuAqtcTgT657FRCi28915jrd4KJ3lOKoZY6rIjCSh2Xb5B0xJkNI1F5zFNDrU06wl5UsVQf3FUz040Sg19cBhh+j25g23G8xZwEO3s7IYchrrL/Q8yw6hZLJicDSzslTVTjWGJDhHwC5SlClGxQgElS1KfZREHgA/MqYj+B9x3VMCtozJZPCuOlF5ji1fx4Fe5HLgxPMbyNA4AOuq26YJ8JAQ/EVH7VpQl/VlxJQR6Di5VT7lJm2phrAo/+bEocaAgR0TbHlcNhHUizj3ciM7uhbl5Dd+TOoxvB+G4l4fSJA+JuxKZUT6EK4EzS54iHpGxk0myNrjQjG/F3K2/iq5Wn8APXRiSP3g9raf04LIgIkuM6cicBrpvGJjRwYduvLPeoZsNMcKweb5E2IegjEF+TZxjQVqg58BJPy0+xbWfma6BnsiaGBD23S0Kd9YIiHkwhZ7GPhNeiGQrZhCdIQB+gulqwrRahrl/bwiO3rh6Sjd2sZSLGyLZsD5ZjLqxkGfzbyFCi9/EtqepLxpKJulaP4roBImobhrWQh9dftdIHs933ActSp8tlrSrW9+9yx7ZsHvkKFrpFkbQ+iTjOZmei8MpB6Ibl2qZvIOXRurM0GW1gpyISSp48gLNYfw2hkZSlMGAXCHqlqnGV0u/hTi+oB9dcZkkHySM5jqo3+swoxkpfpi+RmzYQyHJKWOt1gBURV0UkbqseR5+f+NxPt1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(316002)(426003)(8676002)(7696005)(36860700001)(186003)(47076005)(86362001)(336012)(81166007)(83380400001)(1076003)(44832011)(2616005)(5660300002)(356005)(8936002)(70206006)(82310400003)(16526019)(54906003)(110136005)(6666004)(2906002)(70586007)(7416002)(26005)(508600001)(7406005)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:07:55.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658b9328-3736-4add-cfec-08d9a4968c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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
 arch/x86/boot/compressed/head_64.S     |  8 ++++-
 arch/x86/boot/compressed/mem_encrypt.S | 36 ---------------------
 arch/x86/boot/compressed/misc.h        |  4 +--
 arch/x86/boot/compressed/sev.c         | 45 ++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535cf45b..84a922c27e6b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -447,6 +447,13 @@ SYM_CODE_START(startup_64)
 	call	load_stage1_idt
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
+	call	sev_enable
+	popq	%rsi
+#endif
+
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
@@ -569,7 +576,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * page-table.
  */
 	pushq	%rsi
-	call	set_sev_encryption_mask
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index c1e81a848b2a..311d40f35a4b 100644
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
-	ret
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
index 670e998fe930..c91ad835b78e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -204,3 +204,48 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	else if (result != ES_RETRY)
 		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
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
+	/* Check the SEV MSR whether SEV or SME is enabled */
+	sev_status   = rd_sev_status_msr();
+
+	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
+		error("SEV support indicated by CPUID, but not SEV status MSR.");
+
+	sme_me_mask = 1UL << (ebx & 0x3f);
+}
-- 
2.25.1

