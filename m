Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED744CB9C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhKJWKy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:10:54 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:53344
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233583AbhKJWKw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/UAy+gH7Hik48QgsVWLehEl9JN6Ie9edmuW9usrU72aaDYQZJUGpz1Gs736s4DSApHv5fSLEF+zrZt41VBcbrQHrdsrwGAEhwhRMWmnjDVbPVN2IipN/TChbXphk8+aa3rQC9bHpgW0LPUyoBJnwOrrqTM2XUSwdZeVtP1QuAx6B/tpLhsvgIeFVtn5nj0rLiScL5v0xgcaL7rvTIjku7Bztepph9xOQcUw7UV8YYc/JX0FpGG5lkUQWJ+PdqSdA5mQWCTacLepBWP59ao/4pGne+6xz510wo0ExijgCOMjdT5qRunSLURtck00IBZU8eYQ0wDrFkiJpkChhGNysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq9t4YmQ9YsNimluYFWz/MO7L/HToWtsrIkrClq+MLM=;
 b=hLnKANCi6Nx85CEJpilsy4QbmSB6XOdkQmc7NkfZGOVUeAr2C9onoF3mnJtt/AvniczJKnIVeko2KaPJAP9Rb2Io7jMhX/PCO0cMmVUVi6DNL6FdKd7LQKURDYU5R88uMWb5Ei6A6Y+sEOxleStH3uFNIxsOXmeLvvU4lKtwVVmCl5ZUPpzoA4x0gvKysPM/8BCD9jXjE/hCchoflHyVV5q8M+Hsdt9vRQQwV1Qa9GzKmRMjjLbjfLsiax50APMppK7VNKI07vPLVTDvNxL31ZmDxy2NNmtGJTdYhisuK74Pyi7n5j5Ny5uhiGwgBUOfrwSKGtSTKzHOgdsXbSjegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq9t4YmQ9YsNimluYFWz/MO7L/HToWtsrIkrClq+MLM=;
 b=uuAFi0d0i0yTmUY1P9n9eFz0PhrStI+tbmE8e84iDF2jzxDwgYRE7kem6kZqhi/ptmOnypBSzJanWRhsgN0YWTFJau6h2LRronRR247xz0GjNSBSGeP2DhdyNHez/6eu08d74g9uSw8tBGuBUHWarN59AXxKYBMuTQEOtXrWigA=
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by CH2PR12MB4647.namprd12.prod.outlook.com (2603:10b6:610:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:07:59 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::5d) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:07:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:56 -0600
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
Subject: [PATCH v7 03/45] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Wed, 10 Nov 2021 16:06:49 -0600
Message-ID: <20211110220731.2396491-4-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7025285a-63de-431a-09d6-08d9a4968e69
X-MS-TrafficTypeDiagnostic: CH2PR12MB4647:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4647D2143E935C3D21771B0FE5939@CH2PR12MB4647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GhGpGp3/AdCm9kgyazvJnw/udboCDjh5Ekn2kEeKuxmc1pfpoSLoPQpqBM71gcwmLChk952kterA35ADWbkVvoNAlXUiqCpsCE1cr+VHn2cJWnINPVNRv+guFDk3MJIaC18a5nJviXdtoeUClWtRs4j/4IwtUKSq5y3Mq97BnJY5NczDIsmkeV2Q8OBPsCV+BvwMe+/dQHcsCsuuEi3x1h4yETLBlt3lJjUJBMVYIcRx7AsYfAGRHkJEaRiecJYrTgPNf4E5BxoqaVwgrs3P5wZ2SERs532I1V4zw03KdWyn9yMJsMTWuIgVf/nqw3mjqbBMEcvwoyS1bmkAytY9AJJqYUElHuMub0XZlYRu1eyCcoRclqzOVFmuhJGeDE3ib6/usl8CTUSxUAeS6h198Cht5YxQ/9jLcz3Kp5GySb5iY4kSXbUBdz4wYTF22xyE2kRg2TYNQXlDk1YmVaj9/cAacNSLGYBqFFfa3CkgC8O10EMgWOC94fXqut+T9qJtHsONgiWBKPkmPMeGiqsNkksb+0xzKi5fIw9gIDYY2jsBJ0G8jwtfwVjNZdkhGXZ+PdicIkzKauAnMnGTlleXRhb3bVv7odUI8fqtVRoNuN45eawBVPemEnU5QRswRAhtM3lRGr+te9q+iMuX/LLKPJoEeA5dk2q8Atos2qSEViGG03VS5LkSWUFIqvoYg0KHYlTrg7Z19RYfyDWxYol5j5IvL5XBab4RRlCvAZK+BXgRiHeQy4Yjpb+34MxvrlU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(44832011)(508600001)(47076005)(8936002)(7696005)(356005)(2616005)(70206006)(26005)(4326008)(6666004)(1076003)(8676002)(316002)(110136005)(54906003)(86362001)(16526019)(82310400003)(36756003)(70586007)(426003)(336012)(5660300002)(2906002)(7416002)(81166007)(186003)(7406005)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:07:58.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7025285a-63de-431a-09d6-08d9a4968e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4647
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CC_ATTR_SEV_SNP can be used by the guest to query whether the SNP -
Secure Nested Paging feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/kernel/cc_platform.c    | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01e2650b9585..98a64b230447 100644
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
index 03bb2f343ddb..e05310f5ec2f 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -50,6 +50,8 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 23d54b810f08..534c2c82fbec 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -433,6 +433,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (cc_platform_has(CC_ATTR_SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index a075b70b9a70..ef5e2209c9b8 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,14 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP features.
+	 */
+	CC_ATTR_SEV_SNP = 0x100,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

