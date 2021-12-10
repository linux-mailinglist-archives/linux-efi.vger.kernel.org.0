Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F2470455
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbhLJPsH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:07 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:16865
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243259AbhLJPrs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiUADrIFkt4slGsQRB0csXG5MzD83egwDNf52zxEyExVKELTUb+5/kkMsZp4QG33Zh483qVJae3NMVG/gnDkfS2Lc8zGrs11/xu4ZVqG2CExHNWzn6x/oftXJOZwOvYVHrIFjbSfhQObgFo+JypCD/xpdfTUzTgpxxpBWM0lQdEmppcoUEqHenh/gWUXq2pEcsM+s0S5gv0WO2QTGkDYi7H5Fjq3jwJ069DWcQzFTtYYIgM5iasRHqO42QqbsrJ/7DeCB7zFrcpgS/WJsLmPIjJjlYNTKF+kA2lC2gDvABXDAzjNJGT/8yCS9poHnZ827DnpJkIwEAxlsyHLC37UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtjfL4s8vZ5FqoYg8EBbLRUmpM+gIH47DtwABtAqTBU=;
 b=ckt2WoJ911x26wOSKXNnUd4atthhzLxt8ZpGAQoFgB/DnG/iYQitX1iV8GV8f6afp0eRz39RR+YjJv8/Yts/yYCVPak5+KIv51+H9FbizRSzoso67gUSZqppPwPo2uVv0mV3YnCrTBfE3lyrLi4Y2+4VXuwKifcpo80NnlKo7bNI6LY2hzXI4y2jxxDSOTm2Zjyw/jtxS848BnRkXHZO9KB2p0JjPLupqcfAgRbf/zI89aUJ0YpTEOVIhOl7dH2I9PDteu6LSwKTozIZ1RyA8RLD02rFxslrw7ShfDWTTn8taWN95jC1PL8CaGK/4pbtm+vKX7w9PlgUv0vZ5o1kBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtjfL4s8vZ5FqoYg8EBbLRUmpM+gIH47DtwABtAqTBU=;
 b=yz+DI0ZTHNaHeuDzfrvxvXlV4rXM1M4zwJQpJSWRidgdSq4HS1PfZZkFAgNSuR+bA2c51Ak9KVKvv71yyi55LtnUi0niXajH/gnM03Uuxur5v2XipgjUZsdDibfi4rMmJWFydKJjxIWnz8ibFYGTlvSAyRHqQIEfZ0qbRFdxtLw=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 15:44:09 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::91) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:09 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:07 -0600
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
Subject: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Fri, 10 Dec 2021 09:43:05 -0600
Message-ID: <20211210154332.11526-14-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a36c80fd-f940-423d-494a-08d9bbf3e841
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52241485DB2E9B37ADD96F55E5719@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iehdvsel287q/EvLtmlBHuVU3sFmbzdMlP7A0Rjr1qk/YOyf5n++me2kryIDgcL908sCblC3o+C78a9hTa+0z9xvc6SoZ9lwdUAWwr7smSukPzb1zlDT7PlRRrqWwy80r9Vmxg2R+b5JlMkPGOsomfTBBX+xNrl6qbz0kH+FU+sorUHZxOVrRYXN/JecPKHGMpk3fojnotuqmd2HdAXcSQzRg7YG09To3uHm3Cmfjylgz9jd7RdePsq+9PteN/K7bwHeKkPTuosMYy8G4d2dKnhu6f/d6C67hudm53VcXI/czrcwUkfP/y7H9qMsvwscjiLarjr1AFIQw8mtGhw3BAorm+sGGgu0Sf+3n85I+CfZfPHdwpIb96n6eW+58+GNUoDt6VHPTDEQYLqy1DGruOdhO+YRoVcG62qfTshHpUEOw+4PoQasNLxgTqwz4OvG02mTo9s9Wg7hUuXp1KxXGzeYfegNygSOOB6+unXLFX16/5amKh2FIkcdb2fUqFjZCCtA6qcJtzQaqnBvMdlBI8OMtxG+VUAZLCIWN8nFe1TRkq7XDC5biGJVjcvNV7b51iL0E+ddQo9sJHHC6Mx9qaTdu72UNWBAOPmLt1kqqIXPr56M6ZcByPNOLgjLEeeFA7UThdm+m4sG9MxafGIBKYd18ppXYT/Se5JOBCc0yExvb6dHymApWZzEFbPo0/PcklOVPvFmTxtrsXUPAWGrHOvaBoNS+hgw+VYHzpT+LLdVCPzBugZaJ/szr8SdrSTRrtS+a7NZNKz0waB+KbudAVdlrLM2ovjygdkEBLhRR4QC3fWnCEtFzg/FeK5zXEKZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(8676002)(8936002)(4326008)(16526019)(508600001)(5660300002)(44832011)(7696005)(36756003)(426003)(36860700001)(54906003)(110136005)(356005)(336012)(2906002)(81166007)(7416002)(7406005)(316002)(1076003)(2616005)(70586007)(47076005)(82310400004)(86362001)(70206006)(186003)(40460700001)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:09.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36c80fd-f940-423d-494a-08d9bbf3e841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The encryption attribute for the bss.decrypted region is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state need to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fa02402dcb9b..72c5082a3ba4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,14 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * When SEV-SNP is active then transition the page to shared in the RMP
+			 * table so that it is consistent with the page table attribute change.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
-- 
2.25.1

