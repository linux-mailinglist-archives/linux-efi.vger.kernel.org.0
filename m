Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886C84AF91E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiBISLo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiBISLk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44996C05CB88;
        Wed,  9 Feb 2022 10:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHnqEaYRfxhnhmrPsAhmp2WGjDQOZqnqjNbQI9X9dcpibPRsNWBGUbyQoML+RxWM0uUZ4NqrCpJH6y62rgSuDgeeVqUQa8/ZVJLvVkGm2yvcvdMyPqPm9YIPGN7fzykj2RrJmmMQjHXPUuYl4xrUbVA8NG6E/fcyPxNreHiTeHFqmcR0aGdrWQv8fdPDQB4tGciudNFsTnDmf79FS28zr1FT3y7fWTCoEQ7psSzH9BlY9rurXn67UlwWAm5w4dvZnj277xs7sE9W2nXMnqIrj2t8d01sMmp4trVRIhzGqcX+lbnBHx4ELowplLnuFH0Rc26ICBODye6JULbveMgoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za5TeV7uFgXdJIpp8R18s3v7VK9jY1eP0jI27ay+MSU=;
 b=doSfGf9pRy575Wuw9Dk2KKLsXB3VUx578I2Ub5sXowoG8GCSDfTEZo17bE2gcu0Fn7Scn4eIga9jw4YD7+0gkS8C1E1dZGDYyxvsZyKaX/pKFAJOPiJGG3ipHiQ5MPosgnO+Ymygm8ZRiEw6Wlbb8JVz7g+XS3xTdCUcfEfIiaSLXY9MwiM6f5cvrRny0p9LXPueUx4fsQswMyz4k19f8rP9E7AX/n/FsaQo5gq2ExgD+ubPwWXb+lYiasJJlfRIhQyQbxkUadQ5f2ObcYHPzpDClISHmvHkUYMneJ17I9zKthM2pRH4igwujEpAAE61PYenUGWvmG3PB7KSP+zIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za5TeV7uFgXdJIpp8R18s3v7VK9jY1eP0jI27ay+MSU=;
 b=GN6Np6ESMiNZNDYlnwkdOk+9Yo2CWkl97qcGK/y235t0VhGfm0bVAsEGpQiNrz0wjHVGXyugDeBpFZTXXIookXmeHvS8LnxvF4dWpKclj7kGRTJLbE55hhl943WAs5/BZai5FjJDQuxWybBfoca7/4nY/Y8XBXAwshnbTtUSgIA=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by CY4PR1201MB2534.namprd12.prod.outlook.com (2603:10b6:903:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:39 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::6d) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:36 -0600
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
Subject: [PATCH v10 07/45] x86/compressed/64: Detect/setup SEV/SME features earlier in boot
Date:   Wed, 9 Feb 2022 12:10:01 -0600
Message-ID: <20220209181039.1262882-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1bd3c4-5706-4b7d-92e7-08d9ebf79e52
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2534:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25340D3CA60A67E169E38775E52E9@CY4PR1201MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/qDLZWMC/WhlsFsyVmhIiT8cYdrCRmcOneM9Gd5QgB3XFuIcleudHzkD956GOl07U+EQ3Ox0rf0na3mYQHU4VTQ5dfD60v+VZQfFzArfeG4LA+VAhBYiaVI3MEtt3m4IyuOHAKOdP3huzfQJfn9oQVIaPt6pSu2DMTqCzn1Hlxi/X95zu1LSvDVZoIgRLcsBkvZKTG+SGKLjWvIvsyZRs4HyNNqgm46Ri8EmtwAZ3OS34M/+2MfFEy5Tg2OWt+o4f4YZ0OfmVm5ZI19duSnBJRiL2e/ztAsRIqrHO9q5+cbR9hhh/fK25T+iROpyI+B7QvP9u3tQdozYM2F5O0qppEDxq8PIFscIuHWXnoJyiwkmcXnNZrEPSiZG/e7hFdzZdF93po/XkUoHYEz/vey/hsJ4uLxNIMLt42WpE0ds2WFmFtFNACUG7qX5oYSEKsye4u9ZZwIp0322hJHQ5vXpQXC/MsXe7KJCUzNtDb4hA27rFRP86wQyJR4Zhxmd43xTBL9ZWncgGCYbjJj0XNfC1qAoYhbbsh+TPCYkiTaH0CkyWY9g8Ws4ekmHUrnnXniq7cDpCuiLusB+Y8F+Yuv8MmngruX95BQOMjbWmMNdguLkoEyOTf57c69ijlVwueA4jJ//zOJlLac1zNFz/L7PPYI4zFnmh1/sWsTmtAdMnQWn1iwND8IyBZUFMLmjFa/LkL5NPxhuO2Q6Ylg3JRLgrvUPX4Xpb0syPZT/kFxIWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(7406005)(86362001)(356005)(110136005)(54906003)(426003)(7416002)(5660300002)(40460700003)(336012)(4326008)(44832011)(81166007)(16526019)(26005)(47076005)(82310400004)(8676002)(186003)(316002)(70586007)(6666004)(1076003)(83380400001)(2616005)(8936002)(508600001)(2906002)(70206006)(7696005)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:39.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1bd3c4-5706-4b7d-92e7-08d9ebf79e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2534
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

