Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A94D0995
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiCGVf4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbiCGVfn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1EE70CEC;
        Mon,  7 Mar 2022 13:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwpJH0D+GG/PHZX9l3FwB9g631oqDTF76C0HlRfrSieTTx8QTpoDSVRM0sZQsTipAeCJ25YWWYnvqT5GZQhO/E1xfERksP9USmDbbAie+pePlz8t5RlOZYd4uJxsbnQSX/aBAUAUToUISRyvPgmkysICrMXR6ErtQnidHrGshTGM98yQvezpwaPZZ4ixMAHVbO1uWwgrtcdqry71Ymw2PTW62zW10wxClnj6UXTyc1LMhyeMHgmhJo776c4CcyablqOryU3PfSzeHzSRruyuDp9PRj9rpGtq9LFjVKNdbaJlASMO3C7cruYZFZ0wwq5z/O614rQ41zgElI+hk1YFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ccvjm4i+niQVLhQjVWbKycD0kl0lY/pUSFg17Jwxg=;
 b=kRCcIueoaPodMCF5D89C6O5dFBlGM923xMOjQwLUVN+1aalJgFgahMw+EoRHY6B4JD5L7IJTXLWD9zYmffyjvpNrmQR1evtFFZw1woOzo/JPS/Ox9weHZJS3I+nxJp1ZutJI7mXrAe1ZrT+f8Mqzx6SeL8qwMXoHaLEeJWM+xZY9UmDMXl8q3/s5uYE++aj1L45zvUFRhjlmxy7tb34L1u4GlI7/EePdWX2ywhNbmaMym2UswGvRhzDvpC+2bRPS/dUyZdEN09UUsRC4yREc4mA34/V3uRqvc35GwlRpN2FPV14BvilTEvGLuKat0cvag+IlQ8TXAliMWG4mL/8mHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ccvjm4i+niQVLhQjVWbKycD0kl0lY/pUSFg17Jwxg=;
 b=0VdBIBAcvLEKP8VInzdoYXn7+aTCZGav4Jnhn7cpagfnpacZOT95B5e9gJaeCZ2TmoseBtZlZtdrj/dTIDL598S3YGCkVpgOH1PFv/T9NPlNOlUDG4qdsFh6MCgsoKSfZIfpNaz3T+mEA2qPIyohBukA8lWwwhZkU+etPxtCANE=
Received: from BN6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:404:121::25)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:39 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::19) by BN6PR18CA0015.outlook.office365.com
 (2603:10b6:404:121::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:38 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:32 -0600
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
Subject: [PATCH v12 09/46] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Mon, 7 Mar 2022 15:33:19 -0600
Message-ID: <20220307213356.2797205-10-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8aa8f56a-1457-428d-abaf-08da0082489f
X-MS-TrafficTypeDiagnostic: MN0PR12MB5763:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB57636F9871428F0FB444F422E5089@MN0PR12MB5763.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGWg9PUnbg9xa9OjB5R1rnsyc9DTftLwVkVyt9qp6wsKpGPDTbALncQ4Qu8Jkgmri+QimEDctdCFT6HW5v+FDjOfsobXW57l1BvQNoXNgH531MJdiDEZ8qTRXXyM7clXWDftFJgAc5CsbY0uGRS5jqHlXu9ulfDrEAihVEeFrhLJp4iWl0KfLPyi5dl02Av2FjN7n5sOjlG10+MRhvjo90eWUugMOgWDtQStahGSJTCvFN0Z/oGY5JyVRj/vrUnQewcxokzjXdUn8pw4wmmDExP3jfEMOUIaPNR89cI1XXa7frMrvsbQ7Dkx/WTx9YCkkWAPQbrWN51gMRnFgS/AtmHhYzYrjc8X6Gm1FyNCHB7Rjhms49vSf+r0AmtRIcxSuFbngpC40Zr06eLogQeyx+P8NnHKCIU7/sFeS8hAz7mJta8SuMRW34M9VQxMkgq1L0J2Xp6nbipngmDp4lEq2j07at7w+tXarfN8RVx7t9n7JI/XDGRLVWr4xGKaMq1D9Sp8+AABiTrQk7wV7e7kf/1p34BVgJnVB7q+o7pA3EVTwMpxP9jZSXMb3vLcwSE3mn+nzzmZTCrm8Wq6wr+ZQbdJnwrRdd+fSnuL3ftaevRg93V/0grFVydhL15LbvIc26akxUM4T0SgZ/cnoMUdomTbWT44VMKBc5DoFY0fOd2W83s0HMAbvXjq1WTFNbbWhdwBusQjBiNkuf3LgEHYVO/kp6sRsceOax/PEaUw+Ks=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(356005)(508600001)(70206006)(2616005)(16526019)(70586007)(4326008)(86362001)(8936002)(6666004)(426003)(1076003)(47076005)(336012)(186003)(40460700003)(26005)(36756003)(7696005)(7416002)(5660300002)(7406005)(81166007)(316002)(110136005)(54906003)(44832011)(82310400004)(2906002)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:38.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8f56a-1457-428d-abaf-08da0082489f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
 arch/x86/coco/core.c             | 3 +++
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index fc1365dd927e..dafd4881ce29 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -57,6 +57,9 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
 			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
 
+	case CC_ATTR_GUEST_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a142cab6882e..1315531e66ef 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -484,8 +484,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
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

