Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436E4C32CC
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiBXRA0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiBXQ7f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9505674A;
        Thu, 24 Feb 2022 08:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTsmC6i4ogC3Ty3TKUaDuw3FXRbdDbrbp4TfLApu/4RZAvYd7MYtocZkM5XZB4DvwvcQZJF+ofOIT7eJLQ95JpM3rM4br6GCPb5tKZaZ+HvH3hZcFGq+OWI/cP4Alk2rRQfh5/mAKT0EA4SoYrVP6qO/4VXwKiBtlcCwiRaSY8AIdA4A3TJFaFzffYPvSNjlYV70y9HULiJFYBYVhQThBdAJdY6tlKkcKuQWZX1WA+DI2yO0u+2vcwQ/QEQF/HNAVPbNBry6DS9ifZyOxPOntyH4b+vyxNg+XaRvIaaJqrdpd8eQ34ADYQoWZXxplP/Rw7u03x9pFQjmPRwyg7PH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fjby3ZULIjruvsd7FOdrUKJk+dLEcfVzhSung1Dsq4=;
 b=jlA8x3DucsGSbPhVL6TRSprRhYUI/gTcBLvXwJ/UicPaT5gzfcf+P3+ZeJWshTltwm8wiXDlGm6fSRlQeNH9ods1MAWSENPKDpGk54PZU6T4jniyOtksn8ujhQt2oZev2nhkRnplBDm4GasmI9qWNfi70SogfxYSzz2WLrF7IUkUB4TfW84c44EGO7kfKG73o/0obnimHa4fb8q6uylkze6pNWgvdQfgWDdnRbIq0gA+XeVm1DNpixRo4JXxQ6gpLf9eaz8LzdwPwHOeS/E7BO5/t86JGY8e2z9zNyyz1WBeeKuttmivhqE8qi04tLBrNdSx915uACtMfIhu0zpchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fjby3ZULIjruvsd7FOdrUKJk+dLEcfVzhSung1Dsq4=;
 b=d9CD2KVz5IXa4oJVhk4+hVC39XmGJWwMNBY5uLHUjMPMhTaUf4D2h2e3dKSHLxDkzQrqDWmsNvaSJFbfXBZtajYULR1Z9B9h2/UHxeAwDvaU8dAWfqoexeyg+X6J91JYlHPdSqVINbI3v7msz1QAQYpB+dpUkkfnUrYxhBWcPBc=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 16:58:37 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::d8) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:25 -0600
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
Subject: [PATCH v11 19/45] x86/kernel: Make the .bss..decrypted section shared in RMP table
Date:   Thu, 24 Feb 2022 10:55:59 -0600
Message-ID: <20220224165625.2175020-20-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b196bce-1c6a-4e3d-413e-08d9f7b6e66c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB19265900E8B03B46FC3CEA57E53D9@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnRIvGimaCoQVf6n+aDkHlXA2VCNFqOvfOq7UiqNUVyoFqoUxctkuJ++xLRfExkoGy/AdQmqC3yomBcBOHQbyMJZNOlwRy3ArHwGJkgl+0bq4AhS+Z3I/wqAmsl1jsxyAPd+WWxlh4Vh1Yln/46b0T1or2b9Y8UH4UfZ4vXspVgwcGXmkYEQyhwJdnlS6vxZrp03EFGtvtNtcx23TZNR4kS5IBoCB+v9ZA51GKYlzMIZGhXSGSiDuj2oVdh5zWNXKSaflB3gf0OdA29POC2UwXzkKlX0ITEeRtFUlsEOvrb7mZzkiGTsgy69SwSv/e8M8nwOpQj83OGqLNAY/2a+WZE4bO/59adSwBW2z5BTWKU9XIcZQiuUqqQDLZx+zf9SuqE8mUwEqW7mclLr91EebkFLF8vwUPPG1L8Bz2/qsyu72iKsqqGONu1jDsP/jpv1//Wp3RbJMC7Ia0oS55J/0ES9vaavLPVMkbIcmH9/wfxnBMZHRr7o5Qc5mPsR1zgjqqmAy18R2zzQzhzjm/vxakyDXi8nLlql1sqy+22Y2cALeQp6UGH5o1Sgyplzajvgf7RX7ARCDCSLiuWybyv+KC1ptXlca6sFjN/WW8TbXxaynFiqbZfysM5osr47F2PiAU4+bHR5IdWlG1KFThcBBGT8ipZyy3iXGPJR1CEU/PfOmNY0LrUHf8PLBqkLgBAZbfWbttYD/bsuOVRCPWtQ+x4xWsxGPTDHp5cyewUh3EUO5CAweYpWG8FF5gKenKqXjwdDZulnPt9d4YkcLPQ1oYoDEoM0n4hQNckQTnAoreM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(36860700001)(44832011)(83380400001)(7696005)(7406005)(40460700003)(7416002)(336012)(2906002)(110136005)(6666004)(426003)(8936002)(47076005)(54906003)(36756003)(16526019)(2616005)(4326008)(81166007)(26005)(82310400004)(316002)(1076003)(86362001)(356005)(186003)(8676002)(508600001)(70206006)(70586007)(142923001)(101420200003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:37.0504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b196bce-1c6a-4e3d-413e-08d9f7b6e66c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the .bss..decrypted section is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 83514b9827e6..656d2f3e2cf0 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.25.1

