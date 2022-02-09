Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7D4AF913
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiBISL4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiBISLo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAEC05CB87;
        Wed,  9 Feb 2022 10:11:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBi4+1tKVbprAtoS6hXl04pke9sQozg+kufc7DKfmU8vCwlTADSd3tcgySH6YeIhPQthB8ZYFOiWu3/TQ5i3v9uAazyYln42GS7T91wmjhz2w+2ui5vh5jkAmdWVpR0gfWWJqfYPBytYZdeawnaJtfCNeBvHWRjhoyjFpzf+FbZ+/fjMc7DqhAfVrgYED2CkCmBpvO18aP0Mgg40yrBzAPp2jtnvzrqd1mPA4steYQkDYBZiVH2eqJlHwAgDlRIGHIaooCC9Lpqg+6HjZhU54TPoafNFlsAu7bc4Rui04WbObxBRnqQm5lC0X2qNJwROLreQRYc2a3EwLuMvUHtivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjspq0KmVxt+BnonFrm4wiPQCcnhu3CXxLRk8rvCcac=;
 b=d+clHe+MrMIoLj2y2KI598n89vq839TOSt98UQ1etWmfdS+eEQW8edlcj/Td4imekk6MZnZYtHlN1/UpsP8xKeWeAsQFaKv2ZIY2+RIsWxoGP2so0UN7cSPUyqTvGCtJ40pNs+nYi8f+PBqdkcXAXPzqWJ7h5Zmq++2/yJ0mqguw1LN2rkLp2W7aQUXqn9XZ35gO6GdV0rXUBq09TgmCthZaYtBdHiKLspuSTItoBiw9FP6mm6MeXX8P1DsYUuQ38NizxCiXSv8AXsvRv2u8mD4nXXAOWWMpxdbch7qxMIxS7MPzqIxlZ2T4merLTFZgB8bCBMzHziuXpSyh5JIwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjspq0KmVxt+BnonFrm4wiPQCcnhu3CXxLRk8rvCcac=;
 b=msiueeq2oOaBf3kcww1c/ZbgbQfZFqgze1C/X9msGOobH+dewM6roehCOISHm3WERNvYaWNUu4vHMDW5JpJApSbyGRf5fFaba6fvL0n2/1bWXdgrSPc/NTIOTCnZofww4bUVdJkEOtnTzGFjyDkqVi3vL90Or6Bhlrg/uHx0B5U=
Received: from BN6PR2001CA0017.namprd20.prod.outlook.com
 (2603:10b6:404:b4::27) by BYAPR12MB2630.namprd12.prod.outlook.com
 (2603:10b6:a03:67::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:43 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::96) by BN6PR2001CA0017.outlook.office365.com
 (2603:10b6:404:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:42 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:39 -0600
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
Subject: [PATCH v10 09/45] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Wed, 9 Feb 2022 12:10:03 -0600
Message-ID: <20220209181039.1262882-10-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 257cf51e-f053-401e-e200-08d9ebf79ffd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2630:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB263022411E30F1CEED416DF1E52E9@BYAPR12MB2630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hyppt7xTh9wDJDX/6aGsJ5jsxtSiS1TTx8Q7MTBjZA5jBb7Aln0t7nn8S1Ms8tBAm3B6Uynu0i2auD+v8YFGODsTGjOA0pJzfDHlYhyrQIMRioVkInEtN8/R92jgzJs5xS6jOK2UCb2jMQes34S9OrGWJxAYNCSBP3cq3zN281geC4qAPjDrIRvf6X7DPlY2jjkV7KEvSZelESYdNJU1BV3esyXoPimm/7o6PTgdSrv05uY6QIkR+Wn/c6DUUJ47nQKxr4eMqXkMGLHik/NML/qWJEd3vadpQL/T4XmxNG+GP92L+IQ79tdYDazZN4/VoU4JQWGat6BIawuWcpsoLSgpsMxlaMfxXzM+bNNGbepsvaQJi1GH3OXnesL5GmlJ99IAZhyRoEkhPJ7KQQ+znrg/CJRqF+nLEd7jP74dMw547ObPWfMCZxph37mjDIThr0/DpyfFU5gabyUYMRCntqsVGx+Q/vwUBWTA/9rUbKOtuPO3s/UW8PpBbeW3d1T05lECAY9RwdQaK82Dfk5omKsYHoSCHCjB2gdUK23lGYzf4/ZAu58b6ys2mPtXdYWpd6TNiYa8XmbEK+Wq7zBwJlnlc0DjohN8oZxhUBhRzb4S2sJEK8BTnTAIKBP93Z06o8Sgcn09wlEBSMEpdBPqqfIGlmN4nXLloIf44LOTwkGQ7qHiW93mwmZK2J9L57kVl6l+fL5UDhzk3j8rna1FVQnZAtgVrC0gUr//9F49YbU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(47076005)(336012)(7406005)(508600001)(426003)(44832011)(5660300002)(7416002)(81166007)(86362001)(356005)(82310400004)(1076003)(110136005)(54906003)(16526019)(36860700001)(6666004)(7696005)(186003)(8676002)(2616005)(2906002)(26005)(8936002)(4326008)(40460700003)(36756003)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:42.2676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257cf51e-f053-401e-e200-08d9ebf79ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CC_ATTR_GUEST_SEV_SNP can be used by the guest to query whether the
SNP (Secure Nested Paging) feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/kernel/cc_platform.c    | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3faf0f97edb1..0b3b4dcf55a7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -481,8 +481,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 6a6ffcd978f6..b9d1361d112b 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -59,6 +59,8 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
 			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
 
+	case CC_ATTR_GUEST_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..f85868c031c6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -62,6 +62,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index efd8205282da..d08dd65b5c43 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -72,6 +72,14 @@ enum cc_attr {
 	 * Examples include TDX guest & SEV.
 	 */
 	CC_ATTR_GUEST_UNROLL_STRING_IO,
+
+	/**
+	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP features.
+	 */
+	CC_ATTR_GUEST_SEV_SNP,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

