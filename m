Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FDA470435
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhLJPrc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:32 -0500
Received: from mail-sn1anam02on2051.outbound.protection.outlook.com ([40.107.96.51]:48029
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234244AbhLJPrb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+XJjBWli9UcdI8VbAnQ1aQKvLRuNloDfrKVGCT9M6IXizrBIpEj4VnXewMkAlamDIdBhuiUjR04MEEf9mq00R5IRiPI/+Lq4JaHc7n5z9Mhd9TgVSefGxceUaSjUs+QBbRtL9nLItvVTK1lBd/S9t1Lzz9azwh/8z2pXVqKYgG+Ax9deefMiHCLqMyFcC7QVpt4XeakqBAiW8/ywLX1JVnkw1U03FOcTqM+BHeuuTrXUm9bBmSQ3vQAUS2N/bk9WzC0JxLvHWYPAvrU4tLD7PAjJ/YRI81m3ObbNbBCRcCFl6yXhBZYNa8TsY6jjY6ok3gZINtRws4gU4VVs+BDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fICH46yyunjCi6WuB7jbd0yWtj+6u+zz7txMrYyzXUI=;
 b=lJROKj+gw5jnfCMEro8k4VEiy9852ocguzWU1jTTBK8NeRakj+NnDm8K4hBDqTKNB1zZ/4M9qN53J6TVCBE1xlJr15xYnfu/OhS5d/uCQ11hsHuzUk64CBNwmPkavm/5gJVmM97NYkFk2jBTqPFY7gVKaHUK+qInlbBxZx3BE+J3ojNLagdM7WPNyFzVi1+2lW5AnLTg7UOZ3wcZFRfSnQApyTP0u7sC8tXYFBNuBgpSRbUQkFUex9We8yKnDghQT5W2vNH8XP4Zn4F03sV0N+XHHrCOlDNUHry41C+FErZEokiH6zNFdKsgKXSAPOxyZ69OXtbXDZ05M6H1+Y5rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fICH46yyunjCi6WuB7jbd0yWtj+6u+zz7txMrYyzXUI=;
 b=pzzwcY+5sJb5n8tq2E54KQwLuki5yOhyyWBoVfNb9o1Nl6Vk3MDvw1Q+dMxCoiSxUC/0XDEamTDguDRg2oyJKX9dczyDzWKvaxU+G1FGF62F9pAYK4aFxkMOS7//nrB3NReVEckjizJyiin4skiFdbSCtZg27VUfkgw66b/v8Ec=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:43:53 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::13) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:43:53 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:50 -0600
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
Subject: [PATCH v8 02/40] x86/sev: detect/setup SEV/SME features earlier in boot
Date:   Fri, 10 Dec 2021 09:42:54 -0600
Message-ID: <20211210154332.11526-3-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3d43492-4cfc-4071-a949-08d9bbf3dea8
X-MS-TrafficTypeDiagnostic: BL0PR12MB4756:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4756EE111232958F0C967E00E5719@BL0PR12MB4756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxgfgUvhdLJGnoS/kmO0falfCKIBYH6JfGQEozPykliZ3fmRVMjjJv631BggWnxE0w09l3I6nJgAng/AyPF41kB+XsVFie++isvpuDLli322g7GSgsY+tA1zjd10TfKTezEFSHVpEAK+kZZ6mQ3xQ08CvuAaIYof05Sab6URDW2gQB/ZRXZofV0yX7ijSEnDDi8GA1aBEQAg0oZYww578oAQTMAbJeGVbUsh71Bg4n0yIGWgqrLOPKisxVwTZMjAh/wqfkicdhvgW6G5YiSC9rwhsRQvHwjxkczWZho1V5mK8sLYnFh6lppwZABDBqoIL4a32L6KCGFXziQ+EaLwo3Ej9m7QM0ZAO9nsh22lCKbD7ReP3bzIR2afYsjNODxlScChkULmshLa3LtPcH4npCZj5LOnPkJP66Ty09zMHKMQUKDhpF6thlw7laypkmswlHqPHwML00lagV8/Qa7CofuU7S2BDMqgPE+yG1Y202RL3BI0CiGh/qk+s3mlsTPgXFim3+2MC+PWbiQvM6j+UdhETwZBYcSLyMf1WPfiKhNhBNvPQ8mHGktf/xCehR8MzEUD8UrvPPx+VpJTPeAbEoa5MhQpEF28DIvJkKzuxgoHChuvMoGsX9WymGer+HUKA3Ltg5TWgtYuqpZDrj7ho9nUVk22U+wKyEn6Vb+EYsJfr3IIDqWzGepHCkUlEKwyx8ukySKS9nXf2YUJ8IfwXL1PCajbCqIstNxiwPYbrOnCvO0JvSLzsr2fIRxQJsLKaV6ChSU+7cTfrfwpqiynjaE737MVdOCp0+By88rVPD9aRMR0yjZ/kRdZolSIo1B+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(4326008)(47076005)(86362001)(44832011)(1076003)(8676002)(7416002)(8936002)(81166007)(83380400001)(36756003)(5660300002)(36860700001)(7406005)(356005)(70206006)(316002)(70586007)(110136005)(82310400004)(54906003)(2906002)(508600001)(40460700001)(2616005)(426003)(336012)(16526019)(186003)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:43:53.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d43492-4cfc-4071-a949-08d9bbf3dea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

sme_enable() handles feature detection for both SEV and SME. Future
patches will also use it for SEV-SNP feature detection/setup, which
will need to be done immediately after the first #VC handler is set up.
Move it now in preparation.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c  |  3 ---
 arch/x86/kernel/head_64.S | 13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 3be9dd213dad..b01f64e8389b 100644
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
index d8b3ebd2bb85..99de8fd461e8 100644
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

