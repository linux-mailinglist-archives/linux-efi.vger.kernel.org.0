Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5149FEEF
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbiA1RSr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:47 -0500
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:4800
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343573AbiA1RSe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4pqSq/ejyB0EFyuNeFJnrLXyBXXbQrmdR6lPG20xe7KiQL5r1B4BhuY+60PKAHG7nXec8IEsop5JH1lTvzB3yiY5XK70frZv0aoyGgafrAXhmGDhXxAj3kaf2QgCn0qvu3OxZuY5Rb1uCxRlMHxsjDNt8PB9u6sCA19CIpY4eVgy5jTwURyqIPR8HC92Jl/Hpz3vanyZLfzCl4TarT0XFAeihWqy9JugRGhfhBucHwTnWszGlkUMGAhUtKBQ/kqpN2NkX7yFkBs/hCjX9OvNY3qn0Zwo2wep6/b1V4xsyYDkJcXr+NVF1z0PwQR+110UTnjYK9TS5B8818MelxgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVBr7GSCg486v3WhDrSAby+ndq89spKkQbDPh5I7Rnc=;
 b=IABesnbK77mqFuR/IMo+M0FHY/5bS82q9lWsvL3Y99xjhAXtEmb4MhNMoR8HCUWT791KsmLKLrDJOtM78Z/9hFhvLFMAX3YdRnOyNH01/JTbIAsW9zmDJ+EiUKRWx28r5fJeZ4lrpC1qrJmuqVlbVsF71NTqHkOx+Mwa8Ftl84WQGLMAJ39oJOA6AtH4MPDpqat7pGyaPyCHjZLn49vRfURv8eMv3yjA6FBOEdpGwv/qNdwhO1uA/O3tbxJuvH7AQo6JPGS579y33emJMoytsRH3gNemEm4g2AzcjdPO5YDH7cP+xqijAdbKUw2kz3gFmlW4H9apXCVjjXYGeES61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVBr7GSCg486v3WhDrSAby+ndq89spKkQbDPh5I7Rnc=;
 b=4DNbH8wQr5a3xmszPxoVO9WRPX70WOEJKFACZsXZO2YgIfq9NY/GHI4ychr+nsC+maRCgyOqf1Cej4CH9sEpO7Pp6GIuW0AnWcUrM5etmvM1/kWwMgpSfXhnghF6zIGvJJ2TM+hG4CWunyqkskeShyDh7Rv4/LY0/wO2JUlLwp8=
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by CY4PR12MB1317.namprd12.prod.outlook.com (2603:10b6:903:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 17:18:31 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::58) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:30 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:28 -0600
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
Subject: [PATCH v9 07/43] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Fri, 28 Jan 2022 11:17:28 -0600
Message-ID: <20220128171804.569796-8-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e88482e2-4cae-4b70-c100-08d9e28234cb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1317:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1317674A2DF1E63AA7164E9CE5229@CY4PR12MB1317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJCyecQuIRlL9bLaMD/DEwPWJ9rCuVZZAkXqR0u++hEIleVmRFl1d17J3+lKNtoC/rU+My7m3BgO7UXbCGAT23yr0Coz6+/s9YnOvalVzdyjuXOlmmHFBY7OBgzzovkt4Dw46MGgTsqhk26Wo07YOgsWK2e+B60mZrl3Fm8ly1AsLEBRNE1aIDjBsnvBel3BcyeCEl6HS+K2BoKQKXZdab3PWj1BhdvsorRyskPX82dUwJEc34uuPrXCW/2hjBFdUdP1XuByvYFRZXknQRrYw8RkjoFRBWbM68QZqEUxH6eUUFlYe6d6qtpCPfvwPTDTDiNBGUCjSXTH9zhvXofilWUuudb6ZecBlz0pJwhEcmMs6M4tdOqpqRFoD9DUk1If8NJac7uWVVvCT4KsaDDRV411JhWvF2XZkLSXDVqDTzWpQObQOIiQ+phXr9eoIyC2ehBkVOIYHXQFZWKbUx1Rnw8pePHDqoDKJEEG8u8Uxd79tZe9zl8rtCc6DV0k698oDeD4o2t1QJVH/K/GI+Sgz1dXPMwouR1YoWPrhZT9lN/VAUPA4dAcC86rS1g+c9vzABmQUpp/wrSpa6wm2w2lOGWaVoZFXJW/Era6pjouCA417aXoV2tU2Beyw6NAVRnnNT07MsezDaEZCQ/kNJMLceHtGPFODClddxiTCmitbNZCy2sy36uMW+QxQGeWANgtVqeRp3MHPOlDrzxHAhCer5bXm2/G3vf+wwDyJi8tNfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(356005)(70206006)(82310400004)(2616005)(1076003)(7696005)(81166007)(86362001)(16526019)(2906002)(186003)(508600001)(26005)(70586007)(5660300002)(36756003)(336012)(40460700003)(44832011)(36860700001)(47076005)(426003)(110136005)(54906003)(316002)(7406005)(7416002)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:30.7936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88482e2-4cae-4b70-c100-08d9e28234cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1317
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CC_ATTR_GUEST_SEV_SNP can be used by the guest to query whether the SNP -
Secure Nested Paging feature is active.

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

