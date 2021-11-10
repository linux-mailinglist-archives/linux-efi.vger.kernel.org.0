Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43244CBBF
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhKJWLm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:42 -0500
Received: from mail-dm3nam07on2080.outbound.protection.outlook.com ([40.107.95.80]:28512
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233802AbhKJWLN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb5UvLRaVbDQXQptQ1h2hn4aGMC8/xifx11k5YWkurDkBHntan29Hr4i8r9fjBHiHR9Fiz03+8YAZHUx+oBtB6J4gRXEJsJhQ7gSDueYYHp+MyKYeE9dCUDLElVtoR534iAoJaEJljvV5V3CPogvuuDP2hyUkCvGedcy+uaTg4SkttfIuUiciq1YIsa4OMgYFmNYzwa5G0hrn/UdqHLgaMBrAZ+iT3JyWU2JZWDviaMpx9R3IDT0R5Im2QrDbaIqxcan2HxD+5q0aH5idfIzDw7GDwoITNqU8pFEJgDV+5WVDtRkLEDPhj40ECMqS02ecQ7XOYomsAjAc2LnfACzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWNaIs6wkE6XhN0jXGOZpYZWT/w2U9+9DrzCn9IjEm4=;
 b=K8hYKL6MXnIeb/eAQEYpnp62XYWZYt9LU4qAuGnFwGB7/SibHVJjJMNrHff11WNt8dVEC0hxROe7Ibc0SN9HKX0ba16Fksz2bL3fUdxAlAIkcyzAx0v2WgwRjLcissTVaKJuthmXfcnx/3pGisFs9yX62OxM+RvAZLwUDzNeBL1oXaWWCPFa6N0F8oWp/GsHE0pL5vGlsGytzwL0gp4QWBelYu4gOwd1oBy6bWeX+C9Ld7RrcnIKhOLMtrgeOtbtuCR9ySp/3adRoNbZBg12tfg6HU8h78j+bGFH63rPw2PQfG9wQJjwrrrKXMJqT74+p8rB3AsSifL53PD5f/Eqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWNaIs6wkE6XhN0jXGOZpYZWT/w2U9+9DrzCn9IjEm4=;
 b=B+1rYk0CuuTZV3DGV0wwRYqs3BCRvzdjCf81nvPu3xRR0RlCY0n3DZOY26EnEOG0HazCENQegLOweNetUK4SG/0murd+mmnIuYgocGiUUwSYI7gopCd2YMJGmjrwGLKLd0e4sYnFE1F0vRqTNW6+I1WDnnqze07JGZ4dWM6mUlc=
Received: from DM3PR08CA0008.namprd08.prod.outlook.com (2603:10b6:0:52::18) by
 DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Wed, 10 Nov 2021 22:08:23 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::42) by DM3PR08CA0008.outlook.office365.com
 (2603:10b6:0:52::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 10 Nov 2021 22:08:23 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:20 -0600
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
Subject: [PATCH v7 18/45] x86/kernel: Make the bss.decrypted section shared in RMP table
Date:   Wed, 10 Nov 2021 16:07:04 -0600
Message-ID: <20211110220731.2396491-19-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9022146e-93b4-4edf-53e6-08d9a4969cff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4108:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41083697D4910A3E0C030FE7E5939@DM6PR12MB4108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ak/IOGZNrRf6bajD9bEfySjzsomens/ytYECO9/x8tFGtCJm2P8nO7v6p8a9WK+fMzjWZAICupCcTnK5zryD+JuNxIL0HCiiOTfuVaMdknd7pCcrCFohQgS81xM5Hg+xgN7AoiKsGTxKSPrEdgNFvUOVZn08TLMLstlqcKjrAyeAN87yG8zUWOy17y2aMOoSGdQmHgUf7E3DLtbusxLnMYFlWkG1Uv7EZlIpjsdVAYo4mGiqBph/GJjCihbz7vpwABFslcGgAb74PV/xw5xk6YLUMqqHRFIIj/iEcO4cTKLkGpBWnrjvFAylBAyrL4n+skBL69PLAllf9UErVrjf8fl8xSfPrq9Bh9Bq9bE6dinJM51wUOuykTtdcH7RjJDHBoV02SLoLK1fs0MjLjR4f6CoDiEMj9xGsKuO9Y4TgaeY1kHbRA0TtJaj9gXG5aqSnUmHZcmW7R3vYyVjE/02EQdh8GM9m0HcYr8wE+MTsMklIphkfX9WyiBDJI8XuYTkYdQzDE0eBGgjJ79rFgJ9BiXif/jcugyb1dS3x+15CWNKxXYVnVjSgDpSK/8UE7NdZDwUU/Rfd4ssncDA2nKJ8YThpuqbspG152TRs5idTuP72ZupZqsslzyyrUXPpgwEcUjFpULE6vnCc97U5WnkEfcDU5Dc8ZTvHF/Za9bTrIIK0XyAonMd3wuUCR8J71uEpv43/1DgMm03+W7pjR7BqGyCW/XMXe7EmR7EpjDhYZdjpGmBngj5F5gTtuj7aFju
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(8936002)(7696005)(316002)(83380400001)(44832011)(47076005)(356005)(70206006)(81166007)(86362001)(1076003)(426003)(7416002)(508600001)(7406005)(2616005)(8676002)(110136005)(16526019)(336012)(36860700001)(5660300002)(2906002)(6666004)(54906003)(186003)(70586007)(26005)(36756003)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:23.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9022146e-93b4-4edf-53e6-08d9a4969cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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
index 968105cec364..ca8536404ed3 100644
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

