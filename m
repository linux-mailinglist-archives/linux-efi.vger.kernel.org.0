Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6A470439
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbhLJPrk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:40 -0500
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:3265
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239715AbhLJPre (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOACnoudNPW3Vdh0foK2Ytcn3Ku9d6Ufok9MpxWlaN88qQBGbEY2xNrZvFOOVa2JpX8cgTwtRnsQV7MCbL9sDQbU3CWRk8KejtSSRB/I9JCCVbbyvWbIs5QrDDfrva6a3BjviVUcBDL4sr7Dxo0Yd4X7t0Qz88wT9ZJUyIMpb/JFy1QL9cO6CpWn9U5k94XgLEgzdnPJG/YJfUq4gqffNdXo7gBMESb0QhRlgPG1pBA/5croxEkeQzakxmRVM6cLiETRp9YPKq+oyOBdY2XBAvfsrFjf2detDXCex+e45MC7FLzi2/NR6aS5Kdx7qaqKb9UPjNfa+k6yWnrcZWMT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiwxEHZQaymCaPdZPIbv8O+NxpKeKi5A0nmjfokqrXA=;
 b=TCSGzpVX5vxEBqzP3BF6RqO9jW86gmANy6IXGj08ANtcZajpiY6lifZ3EnVhpO8fp44T7VbQGXw0hHcpgXgG0XerrlzDAs+G+J5qILS8TrsNPjD3gL5dY7hKah4cdxop2BRwC+jKt1PmdKDrv5nCIL0OxQPB4vQYOlV1AFc+p7Huh1pEj4G9atulJSw+siJ8oGXEton9wPsXEEY38Va67psDz+HD31teJTucBWz1Tc9nh7S5idk8hXcrv1uCJfZ0V3YZiYzMo9bdapaVgHttf7/9MqWXE9j0HKoGefrz/Bv9bGSMCgwLgZnKJYCK7CiQw+FRmEqxDiIzoV2N/HKSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiwxEHZQaymCaPdZPIbv8O+NxpKeKi5A0nmjfokqrXA=;
 b=PEH5nAMr8ihOnLsrXRqQXvpswj5GSdABTILIRZbb8IvtNH9gHRhRi6ItgMbAv1+CvlR4NfhBkkcuW8DzEl8t/PzP2RGreWrojF+e2fn6x/5nJonYHhHLQvhsjfxHt61/0jb8UbTfE5AJneYqxVQjLprVAPCoVkJdSNFdAjyZhxk=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by BN8PR12MB3076.namprd12.prod.outlook.com (2603:10b6:408:61::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:43:54 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::af) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:43:54 +0000
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
 2021 09:43:51 -0600
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
Subject: [PATCH v8 03/40] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Fri, 10 Dec 2021 09:42:55 -0600
Message-ID: <20211210154332.11526-4-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7fa4fe63-c563-4dbb-68bf-08d9bbf3ded8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3076:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30763EFC7904EBEA2DE7AD22E5719@BN8PR12MB3076.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6se1WYbegJEAxpklannMc+Ic1RBu36oGa9gnf7bISiBQXrYTzBi/2KGcemmaH9pre9MAB8EhoP8s+0RIKJAs8qDFB0p38dZZsAHij6AF51xU81WS3doJ6MBOGbHOeDn+2jwxDZh68X6vWkcffcJQ30bu9kbLuFP6mSAx1Xa1zwucwHOPT9Ncx4aPNGdaGxI1ozSv4K8wYsJX+RKmAaSY7CHJIjRjMs1X01hoigez611ozhihlEoFJTZk8cR3N9iXWiijldiE7N2/5aVVddO1pCznLHhDseUVyUEuA7WPjD4e4dKwD0OVa3U4Kz3BVqx1+6Ljqq5tIqXFD4oGRDoWn+gIwAz96S0Fkmn3jLxf7ajhmAWdHi9UA2lVL0hUZU9CddwDtAjgTfK85o79SCChDqoDQl37RbT0L41wyGQzhnvVHdDkk1U0FyMdT0HJwGtTiG0c8pQjDx+Y1NuH96eGtMen1uom8UfHTQxY+WOP3px4fAB9KMUXetawdm7PJHTeNwJjGNlWZNNVpWIiJ/hS6LrjsMB3AJ62zHjfbKJK7ysVBRZwrAeqkWKuLXxOZrOPyzcOn/uTHE7Ak6U3dUOj+FHjnjR0i0aR+m4CIPHYzVCQXL8/nEmlUdlhTk5XSsek5Cri5NGlHZQQeKZGmG7ovdxzpECVatW0R5Wxdux8LyTZRErYFPS1iKd7ulR6d0rnSueQM89YZAiVTQgPvMNC5SvmpO4Vx2NueULVVCCWqqG69R17i2hPD/VM9OO6jpXyJmfxo04kNIy5QLCK+PI3tewdnsEc7Mq2Vv7zdrxaEpeiR/YEOmFUGI85gS6bJlY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7416002)(44832011)(86362001)(2616005)(7406005)(70586007)(82310400004)(81166007)(356005)(426003)(40460700001)(36756003)(316002)(47076005)(5660300002)(110136005)(8676002)(8936002)(26005)(70206006)(7696005)(508600001)(36860700001)(16526019)(336012)(54906003)(1076003)(186003)(2906002)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:43:53.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa4fe63-c563-4dbb-68bf-08d9bbf3ded8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3076
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
index 35487305d8af..3ba801ff6afc 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -487,6 +487,10 @@ static void print_mem_encrypt_feature_info(void)
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

