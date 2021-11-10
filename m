Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A707044CBA6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKJWLC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:02 -0500
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:25861
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233607AbhKJWKy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8cceQ5mHQ+CgVRp5FMBOQBjm8eqdBb66dATZefW11uuSF8nvtVxP5BLejDQm8NBafLtzN+opAahxPpQjxzFiQYtS81QbKBFrIzUDFDhsb/KPly0R2IRvA4m37vTC7iXhl3PC8h8zAI7axU1uxrYPUWGDkfSGKj+XzXPMjb5ZeINiYaGVGqfeBbPAU1hufBJKvOTcdItGNgwC7e30DSb5pR+NxwzitLw91cTU05BA97o9M6cAiJlxx4uY+vxLy1aROwRqJD2pMQBEu3dQYa7tm0k9wTBn1iKPnRmCIrDJW35FkUez/+Ux5exdJNXKfV+iaztAVjASfZTJ3sd30Xopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXbWoz2GMth4nfHV5JvqdAl9EMkTXLEX8bTuYP98Zc8=;
 b=dcwP4rG6U/0Z4Xo8KwKVQ2XGjr/e7QkkEoD2j6J3XUQw1zHhHxQwQx2NmipBtNSEiBUrNAQpLRhG6EYkDkIPHtCdHenZd9MmkjkVfcbTz7f/72WfvR78Yp2mtzxMt+A5VXizDWfUJPpuQqxdAUY02naXpQ1fjkx1M1Fr5phAmIUmLLu4FpBdMze/g+e/sN74X9HKXqUv0Mymtv12mdkfNX/aZMDTFpM009orfM8LaAIijQuXea3nXrIrzxGkFuKo7XV4bM1Zn3j1z+m3bX9D0sH3P2+OtVoGg0rpnz6SYXv/MkzPP4g76ShYRuM3hTZVT0aq+VbOIxqns2g4R6Dg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXbWoz2GMth4nfHV5JvqdAl9EMkTXLEX8bTuYP98Zc8=;
 b=HUPW//LMJybB1TPxw/LEJIuvHw8LVPL4ChyeJ7nJ+mnZowbFUy3xM8tnCJh4VUuRxMIEMyCos4FkEvpRihSq5+8loS9/FYkahv4OSbYkYz2uEQJJjiu5cvsegc2azcKL3Bk1THe40QbgkANpxxDcn+bT0CL/zW7+YVPAo9gbV7o=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:08:03 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::f7) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:01 -0600
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
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 06/45] x86/head64: Carve out the guest encryption postprocessing into a helper
Date:   Wed, 10 Nov 2021 16:06:52 -0600
Message-ID: <20211110220731.2396491-7-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: baa26f2f-11b0-4e79-742c-08d9a4969118
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3165EC3EDC0C4445F8B1B088E5939@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4FWnfhKJdtlbJFtxdt6hKPQgOuOJfv/L25G8Lx0RynvJ75ez5Uhoc9Wcc4t5dLHQNAZxQ2a2NfjHBFmTGBB+qjfdEsdV+vPYcWQlScadbr3Zb5iwJD/LVVc8HQ/Uf7MTOLkRztOH3stBEZod9c1DOpkz1ZFjxVp0VhldmNwDcLUDuaYh7WqJgSKHQqNd0nj1lAvq8DLWwx68rvmo4B0rzBovtLMfQfzt1WJ9amZWL1jASJL+Ush9bkGQc7qJL6nFFefoPw/eWQ/CHyl3ML49QirVlkln22s5vyS/JjCk8t3SoBoFjwNYc7jo3sMZx9YxvnbMRWeGNhuGZBrUr/9EVu4Qon2d2+5lQT0hOAFVzlDBTjOUxoAhBcJaQpbkIwdkgQdhr5Cc/kV8bekwQ3BUYLJdPvzwBhEraBiw2SxlnoYtHi8Cr3QxOYbNxHmXznMH1qoeePzYSS/kz5ebCuzDSho94YWoQVmxBKn4Uv2FanpuxiPBO3ARRuvB4XIW21NwB3ode/IK35V2tHaz9qUQZDWArkPRhVoc42C4wSrxlMBal8v0RccUvN79JXK5ns4zzyGfyaH7S6/o+Jj1Vc83JKjWFW+YxZYqkHyNY43EZ5z/M/tXuAunTfq+4LrT7DTekksmmBq0C61NYHWd/0YiETgL6mRCC4OEydE1NIVXANdyoXRL1huy7PHBl/9s9yiUrx7HuM8fxYD4l6SMNISWM5w7avSftnk5yDhO4Cx/znt83Orib/JbubgKT7ccnj8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(70206006)(1076003)(82310400003)(316002)(70586007)(2616005)(6666004)(508600001)(86362001)(426003)(186003)(8676002)(336012)(83380400001)(16526019)(44832011)(5660300002)(36860700001)(2906002)(7696005)(4326008)(36756003)(81166007)(8936002)(54906003)(47076005)(110136005)(7406005)(7416002)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:03.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa26f2f-11b0-4e79-742c-08d9a4969118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve it out so that it is abstracted out of the main boot path. All
other encrypted guest-relevant processing should be placed in there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4eb83ae7ceb8..54bf0603002f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,6 +126,36 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
 /* Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
@@ -135,7 +165,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -273,34 +302,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 *
-	 * This is early code, use an open coded check for SME instead of
-	 * using cc_platform_has(). This eliminates worries about removing
-	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
-	 * function.
-	 */
-	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
+	return sme_postprocess_startup(bp, pmd);
 }
 
 unsigned long __startup_secondary_64(void)
-- 
2.25.1

