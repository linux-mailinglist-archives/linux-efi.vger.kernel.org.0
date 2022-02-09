Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180E4AF957
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiBISNL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiBISMs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D43C050CFA;
        Wed,  9 Feb 2022 10:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJUoYYfq3WXvmPScd7bPWs1Zcwqaozv0apfxJSlm9RUSrc8rLFZKaTSMY5ef+A2uXEpfSO/GnraMTyHqUrZv0iDdnFCgAAp7iGzSfguOxz97uWdx/NSgNMaGq8HZ38oFCWhiVV5VETufYP36GpyM1sFRjbh8xS2m6st1RXU4WfTxD155THCrT1oer+EfhlURsD3NKZmdp0mBHVAqo+G8NmiI2y2OzEjGkxCLV8IkwOWPblIp3xmjWomhd1J7PbLopkNm0IZ7C1EQ46G0VmZDmzBNY5d9UtG6K+4cQ0WhFSPCNXX00YnDF7T7k1Bgl4cTubIRF5d0nnllHCQEcKKqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJDbgmyl7Mk+Z1FP3B8zp1SRBSbLMd0Ea1CcshJFIgY=;
 b=emXsKIJNGmi5PRjyQJMBp/JANxLWE3h2BddzD4+reCXAtBBAX1tWyhpf0bYFQmIE3nMCQQIbBGYcF505TGzAOfax3Oq+UpE3782IU7CNMPTni46YrxvsK4I9BWsHOOTj02QCehrNpXHUekbHD9jsZl5zZMaws0RPT8AhLqaGfiPcQavKeeHN4qTsF5Sg7Nc7fo2vFqlCBQe+k+9qhwiSrmFPDUX9n9bz/dcd80775IsyGw8qAEjMhvFrJOjtq0Te1oOVlRhrXpG9J8kEgeNc0quP7dDlDACSWiWuqS2qW60cUxq9hbGVYaJ2nMnVd6Bn1580zdYVBPlT8eUjSpYQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJDbgmyl7Mk+Z1FP3B8zp1SRBSbLMd0Ea1CcshJFIgY=;
 b=r7dXM5aFCMoTFrJCrc2aCQNYoitJ3LUdux4EHNckB9f3D6pTxs0nrVWXYISXNEBmmGs/ELoJQNkN+QxqHlgfXsCopiEuQy+nE8Pfvw2AWci8GhZ7XjgvX8arswWlPxz9oQTtoAxN//erV6glGXufcyuHdstsWssnoY2pXkCCplM=
Received: from BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::26)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:11:59 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::60) by BN9P223CA0021.outlook.office365.com
 (2603:10b6:408:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:57 -0600
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
Subject: [PATCH v10 19/45] x86/kernel: Make the .bss..decrypted section shared in RMP table
Date:   Wed, 9 Feb 2022 12:10:13 -0600
Message-ID: <20220209181039.1262882-20-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55768403-7b78-4e7d-be13-08d9ebf7aa62
X-MS-TrafficTypeDiagnostic: DM6PR12MB3372:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB337270656C73B41D590FF5B2E52E9@DM6PR12MB3372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7QOBrkJwk0TiKcngRHd5dhzwBjwN/l4j3C8F4XPux4ITIlW4rAv2kbwix3Hm7uhx8SRJXJi4UvKO114mRSOZsN3fVxNMUnpEl5mkt1QAmKWRKRTLpiIgrDiLJrJd10Syxy8uUfN+wf61BADr/e/S+y99MwGqIAMBxhQSihzAnb6MWtcdg7IbDCqRRQjKLMzQMQeGddJcE5fDjCGKD7r3O8OZNK6d2dA5YnecfvTIXUTSXH7MAh2qaTDFtWLLbG/aqwXwG2QPQI2nScZ6+rsoq7AAAKcAQ6VpE93QEzY3AiotmJQWvR6cBok4C+Ovp8TJVSeQXQGpKq7BG0FzuEImS+Cb/9aM/4YBSn+Pv/F5bpAPPt/Q+XkTfELa86MIH1Gb8qr+DDt2j7pgOPzgAKSwWO71ABAs4E4nEr8fBmntlXWPNCP487f6QrZIGoPML2wN80XGs2NDvy35v/SirCYaLdGeQ7tZUQNXhS5yPDw3JrG7IHlaL+P9W91HhNgeW2moKUO0p+z0e+UcvmlXcU0TrfvbrVPmyIpo1GhDnG40RD+Yqy+qU02bbCvISaGBTXaCh76dqPL0UMEeX3GZ4F2U0o+Qp9bVeSLepwQb2hhDLj+abUAfzuJKFGvmRX8fTlcNXPXca09gG2NtD0eVRwuDgMKQrCFLSL+jLNVy9ORdxGwTEIB9TJwf60lRDskj0NXc7pksBcJpdPtMA9Gtv+IUZ1Gr6gZq27sZLdsxyxuILkJEYvrgftN/aEYSQ1qseZMJGruTRSPw7bnqVDGXa2wUamzslmxyXH5C33h525bbBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(356005)(40460700003)(7416002)(336012)(110136005)(426003)(5660300002)(81166007)(7406005)(508600001)(26005)(316002)(47076005)(2616005)(16526019)(186003)(1076003)(7696005)(36756003)(36860700001)(70206006)(54906003)(4326008)(8676002)(8936002)(70586007)(83380400001)(86362001)(2906002)(82310400004)(6666004)(142923001)(101420200003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:59.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55768403-7b78-4e7d-be13-08d9ebf7aa62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
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
index 8075e91cff2b..4a24b121a2ba 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,20 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
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

