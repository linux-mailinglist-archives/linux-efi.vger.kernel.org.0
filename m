Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16B4C3282
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiBXQ7Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiBXQ7D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC562126;
        Thu, 24 Feb 2022 08:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwxkBs3dGxPSU1g24P3wKds6FxjW3oAwFfoICj6HNdDYO62199Tz/R5YpaRKrtdwc/3aHeCfz0Z9x57bJeTVPwEgggParG1l4WrQgF5yU5EcOZaz+eXMu0buPl2RXxplTttAvNdUdfNk3jEVPfQZ13Rydd8hwfNmck5MVaX7FeFrihAszIqTc1QLFSlfv046eAEdP377M87hg0Y/FNmnVeVJOQojTk2TxiIPnpoQNE4CTcKWepr4Otr3Kj2MkOP2NzGOrtLCYZdObkIIVy+IpRYrNmdq3UgWZ8uF5NZ0X0B6QzZKlmvUZx6R1DTwQUahVhEAxMf80J883nsjrckjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntl5F5XU60OWCFaYtPlwYC+9J/gONwjzf4p6mWBsqy8=;
 b=gRfAr3zClTJjVjgulSTDXeKJwfGXQRA/wf1M5gzj3QHsGPcf67aKSDp9t6RuVcjv1TcOe6s3aRbn3VL0FluPKO/U5MsexeOAeJVun1Lec41EoGSZbJbRjfwsE/dE/4DmQEgqUWjq3/PXWBV4lrL/zpKMlraYWEF/SxCNkOWtBzY3p10Tyy1nMcTGWPh8nlAIPXohYROSGZwOxFwh0dRyIpymYQWyZiudWO39BolrVxtmQqkXSPjWrUIBHM31/mkypQiezNoCMfasfRAbTc0kIn8UdhiVT7RNNZygAuaLUd1gUhIqqIaWelQpTuMZ3pPmTh8Ujkg8dq6joqBPyTYViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntl5F5XU60OWCFaYtPlwYC+9J/gONwjzf4p6mWBsqy8=;
 b=q0YRTK9Pdzc8XTSUFuqkIgjvW+TWqmn5i3XZvCA93rFLrj5ywH2JU/p3Reed2uOeqEuTLjzs7e2djUNLFv5U41i6AMeLdTWS8v2ddifOLc6ZUOk90bWw2pQTuoCWRpGmgBGCCEG7YvQQx2Rikxn4NtLXFSpVAkQ/ytJNJPIV+Ig=
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 16:58:08 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::95) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:05 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v11 08/45] x86/sev: Detect/setup SEV/SME features earlier in boot
Date:   Thu, 24 Feb 2022 10:55:48 -0600
Message-ID: <20220224165625.2175020-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8683fcd9-b274-4606-6900-08d9f7b6d53b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512CB2060881252CB372E69E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3dpg9TwmV2vb3IHw+3AUjZfbn3VoRjUxM2eSP0MUcGsI6qawtzdVf31sZ6pgISmhaMWZerUMe5qvTkktklU1Iz1Bi2ZqTQ7C76lbNmNexvORGrMfXkLHpVzIOhE+vHoHbrt3M4OjcYD4hABEe6VN1+L3GjIE5j8R5QhX5D+vugWoJFnZDrlcaJKOER5kjFiWb9iN6jL1IvNho/FP31ydfZ1qEEFc+6cvmRdtrmTiuqjw9NKpt+caSW1D0ekGLZcokSdywzz/noc/zIrpNuNv//6qB2+w/vnNtn1FWDDbTZdT2PkaaL5RoZMBKY4bsaCldrIKo1Wl2X9vPq0Ksy6K6t+OcG5hsLiqwTgVauoopA+rQCjsEdVU7uGDGTWdq9L61CR6b3jxkqDRSUkPblmtqqg6+OL3JjXHQYm69HKpJcmlKlqOTxTiea4QfN8rciRViRy7VLFHlCZ05R9eza/T0JyHQb5ECFNGw0UtuiVXrrqd0e1vtKSiiUU5737yP8ZwfYZ2+hWssYc4AwztwDjhWzLVO4DIfvQs1B3m4BYIiHgH2NlZUF1jILPSwOsDpSABTpxs5JaE+82Mlhl2qT9y3bVoJqnzHT1x3sCkNQZWucQavrSd+vwCDK0X2SbttSVL+lzFCF/dP7zKIKRB4Pd2KG425ZKk4WUw+LbE+sECgLonnR6ot6zKJwMh37MvWNmxZQWc644vkSp1VrntuSLIozq1fe/AWfmImeRh+jGP28=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(70206006)(186003)(83380400001)(16526019)(2616005)(1076003)(70586007)(336012)(426003)(47076005)(82310400004)(26005)(36860700001)(86362001)(8676002)(5660300002)(316002)(110136005)(508600001)(4326008)(2906002)(40460700003)(7696005)(6666004)(44832011)(8936002)(7416002)(7406005)(81166007)(54906003)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:08.2091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8683fcd9-b274-4606-6900-08d9f7b6d53b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
index 4f5ecbbaae77..cbc285ddc4ac 100644
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

