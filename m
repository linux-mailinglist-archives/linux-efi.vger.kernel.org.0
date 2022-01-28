Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0649FEF3
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbiA1RSt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:49 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:25932
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343638AbiA1RSd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POl/iFGNu4ml8FjuFjXoVgG0ZIUsXZaRVx5Ohf6KnM59CgHaCDd20PNXJMEX/zt4NhwYMiBF+y2Yq1lgVedO7brODD31mFY3d0zhpTSabX24ordYtwYTDLGfz+jeAJjY4rHP/W+gpqXISbyuOk9FWD7HAHJj5+vtG/i3yAqRo5VWwrZzZTZXwtPOqpwZveT3Wm1cya1XXYbQV+wCn+PGUSFo5SRbKDhfd+OlN3W3cT94oiiQhcDHbIPpJcrmXU4HfvjCmdxiueHj6DexUP5ixSvTyo1u5v4NQMhWSYDSlu0z5R8rOZ+t9s9vx9iYj9pEk2OIMnyx1DWCmDxlWWOcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeU2V0w6Nz9qgWA1HpE9sJhUD0bvSli5PX0rh34aFqA=;
 b=CXHjQqyubktSujqYWWk/2lNrnd5hWbG+/52DU1zctHTlKFgm0pbZZFWOw4UPCOGg4pzCWt9+2TSGWwyJdSLXGsInCSmUAO66+RxBxYt1HqFBldrcs1eKzAQvssF0FNUQovcu3xCZ4XQYjqJ0gIpMSqj9/wdmEzraCcw9vCshLbCMYht2Qk7Da3d4kbu7LxUuBxHbbVCWlPXoVT9epgIw9NoAHEz9YGajV5aNFpAa3J+qGOSZ90y5gRRoIT8cQtmxQYz0MTBmJ6Mm/K8vQMruMnZ3abFWlnkhAwnbcBXhTmsYJvSnBOZk/xdz+IQsa4cwSWD57sIb8fYbVAcmhDLkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeU2V0w6Nz9qgWA1HpE9sJhUD0bvSli5PX0rh34aFqA=;
 b=0M+Xyezh1Nt9ATmQD+THc/QrbOzRln+C8MMlMQOk07SmUuDe+BmDkpSQUzwlfyfbS4eXyChhuG2hvky1GMrzMCScdpt2QMGWGsNr4U/lUrvtiY4ZtX0ch5+RjhKpghjoH1JbyUEkX+7h7Y0P1x4Yb4E3gSw0IMIdGTEeD9hrM2M=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:18:29 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::bb) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:29 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:26 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 06/43] x86/sev: Detect/setup SEV/SME features earlier in boot
Date:   Fri, 28 Jan 2022 11:17:27 -0600
Message-ID: <20220128171804.569796-7-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c76bc6d9-9f6b-4087-d5e3-08d9e28233d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1273:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1273C92E121A801756CE8BFAE5229@DM5PR12MB1273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfP0+CTVLSeNkHkgRXpr63FFEVdga0LdwJ5UtaCPKZZhDrkw9EFqDtYjZReqD5vsftB1UQqB6tXWm3paTZ2FkGqgGesvECWiWB8Vn5aIWiM+FdEHm8dF2jZTEpVlmaS2rVsjSFkltf+vJ5kf46Nk1GyN7dnI6lVfbyZX8nobAAE4bQJ6dR6pYH4NrJ4UxId3+k7ifgvK7pOahwgX4zMcbtS8v7RpEOJCfy9Zhqfr+C0xnoO1+piNdI+NrxTo/Z5jWFUA0aJkJVkkQ9Z4zzmH/P9g4ez92ObibXJB5hWmGbnJYudEclcEmBw18gBrsPCsNKf6FGjl9RzpyS340KUUbX+OMKqTW5eBSpYvf68S3s8fWyEAt3a6ADjOqTK3lPPwbOOKjs6TpYRHU2m3LyWxxHGP2cQQy0CSHk+FpoUFZvDPvJvIc5l/1xga6q7Qh8UvG+dNpIbVykR7Lqqubxe25knsRLKi0zV8vqMcyg4ToHTKEpIVvvDwrOzjAzUSQ/x2q4z/y+mJmZxJY4IHkn12L2GHoFFBD5xb0TyrsSVb3UdhlS2di90XJuIVic34ouatJP+UhlT1czhHK3A2D7mYn4PXq2bzhd22t1D3bfbJZGDJSXYkNXIgj2zxpDmfzicyxPkEH73NiSUCMmaXNJptvnPhoSnfJk1wKeMXNexl79zDHUO1sXqjmOLjt/xnaw1GhyTLlfXQDKUt5lvDo0UBxzBoTneuUzWo4fEzaFvmMWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(81166007)(356005)(2906002)(426003)(36756003)(83380400001)(36860700001)(336012)(47076005)(70586007)(1076003)(70206006)(26005)(82310400004)(316002)(2616005)(16526019)(7416002)(7406005)(186003)(86362001)(7696005)(508600001)(54906003)(4326008)(8676002)(8936002)(40460700003)(5660300002)(110136005)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:29.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76bc6d9-9f6b-4087-d5e3-08d9e28233d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

sme_enable() handles feature detection for both SEV and SME. Future
patches will also use it for SEV-SNP feature detection/setup, which
will need to be done immediately after the first #VC handler is set up.
Move it now in preparation.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c  |  3 ---
 arch/x86/kernel/head_64.S | 13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de563db9cdcd..66363f51a3ad 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -192,9 +192,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (load_delta & ~PMD_PAGE_MASK)
 		for (;;);
 
-	/* Activate Secure Memory Encryption (SME) if supported and enabled */
-	sme_enable(bp);
-
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c63fc5988cd..9c2c3aff5ee4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -69,6 +69,19 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
+	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
+	 * which needs to be done before any CPUID instructions are executed in
+	 * subsequent code.
+	 */
+	movq	%rsi, %rdi
+	pushq	%rsi
+	call	sme_enable
+	popq	%rsi
+#endif
+
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
 	leaq	.Lon_kernel_cs(%rip), %rax
-- 
2.25.1

