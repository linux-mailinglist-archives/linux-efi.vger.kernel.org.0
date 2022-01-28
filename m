Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5B49FF59
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351363AbiA1RUy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:54 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:44440
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350622AbiA1RTU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQeGzGxxoQ4dawLqxMwwmrNXxE5E2jK+5JX0TRcVPYigEIixGd8eG2TQ9ikohQJ7LqbfoL1vy+S2Ij0k+JUg0hKIr5EQtiHrmlqo2y7b5FnR1z3nRay3yHuNSxK94ZxFWHuEolrRLAGqsmPFXY3NCT9bTxUXm3GByYcOznNIOc/5saJ5OxRNZTfZ8JauPj5q93XS6gAs/+/xXiCp4OFfneoGzpzzpni5qLP+CUVtQCE+CWHuuft42C8d1rjSMzTi+hBxbAK8iIJrsz7BPnje6ki8dcca2LITYYHz1iAFaEyavPCl7DF0AlTsEIVZ0hPOznUMfRI1hd4YHO/vWVxblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXbncc2YhaHDwILaLJQdp5ocDxn4Gj2R9+bUHTYTh0k=;
 b=RRyX9xR4VCRTDQGsBQKGhsInSDzC1ESiofCvY+VuPGeFY+MVDyqGcNHvW860+GKvBU3XRRf5LgcZwTph1mhrfOFxejIU2rZjj4onTL7cELvSs2ovjQFl75TkNvvnwWOcmer8s2277IR9TRVOYLKkuv0gcbT9I+3Gagvq54ZlQ05Bj1Lt4E5w1wtKAGssne2PY71bm9O5PNXnmXbwCKUL80ZAtTAb7jmKWJhKz0r2vAHMZN+myDmZSv/IAh0bgtK2+W9rKgqFZd/0xZ8BA+jt/BSQHBTMZBcm6yKkE3glxR2Y0oWXWFfX8z4SYmTW1kEBKAUeNdZB63WgNHRBRY7T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXbncc2YhaHDwILaLJQdp5ocDxn4Gj2R9+bUHTYTh0k=;
 b=TttVY18GP1GVCK6q1/WgVCtgARc94VdrqOMWq4H0mD7LqKdWeol655JR3yAww799+znHLesYr/KzVz8LMDx8i7rmV9537nsBv89xCfpadxKCaNg/NzZWOHVm4js6ERQTFBFyOVbcVsoLog+zHAoCQR3y8uYqFD2lB2G4B5JstSk=
Received: from DM5PR11CA0002.namprd11.prod.outlook.com (2603:10b6:3:115::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:19:18 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::b9) by DM5PR11CA0002.outlook.office365.com
 (2603:10b6:3:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:18 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:13 -0600
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
Subject: [PATCH v9 34/43] x86/compressed: Use firmware-validated CPUID leaves for SEV-SNP guests
Date:   Fri, 28 Jan 2022 11:17:55 -0600
Message-ID: <20220128171804.569796-35-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2cbaaea-a62a-4b97-43d0-08d9e2825161
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499C175090B916334A9EA82E5229@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z7nRSwjfCvLVpw+o62GYrH1v9yKaozyRPx0PoS2MVM7Bl6CiPUm+LgrzgsgjvvCzAa3EWZ1E0y6V0tOrNU2ZObB9T2PssS7wQ9eKANYnm1z97ry45CdyMtbdmzLVw3qOtuQUewePvRS5cncoffLaxNdGDdlQtTNrp1rDHwiCbkO8ZRe7lJom0btM6l75z/Lq/CkRsJk5wzKntEoftAfcNv5vIuqciy9BWkVLXsTjiaRI452ODOMIgitZJhiyyPhOO0kY1cLupTCEyg5sMATjisUf4K0HEDQnL+OY4YmqS4uMimyhTUeB2FIc6FjWTfmt2hDSVRw0KBY27cuCDxF75AoWkx+Og8vttvNL7Y4pd2HIkHPu9cLkzm6cvgQTlwX2WMu3AnIxEDvZOoQbHgLD3IlOjGlo3BeKAbD+JaZA6EZ05c78Yrj7PakWxg5hifnLF6XoGA6cDMFvHCjGzJ1GuyM9h3dq791QmILMmn9T+JeT/1UJrOM1rEQnmVabWFKmhEaDGD/oLRHihn5tIo8Sa0Pew8GKqXjchNkY7EvsqQrFPcHGsh+xMyJxO6AmXnXM03/TDBJKpQhI8Ayldw45By4VQ445ScEggePzo9ehL9izs0B5IzJ1gSJJ8S9TXMH2WEA2rxCZWdPIO3V2uGQB96DaAeUVW/r1nbW1ASpu95HfqHcX2HoLjCfkTQuSIGxZrCyq2AAOwNshKIm/CsBiDdggy0KfhDFBLNi23YTCG4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(186003)(356005)(508600001)(316002)(7696005)(110136005)(81166007)(54906003)(8936002)(8676002)(15650500001)(7406005)(70206006)(36860700001)(4326008)(70586007)(82310400004)(83380400001)(40460700003)(44832011)(86362001)(5660300002)(426003)(2616005)(47076005)(16526019)(7416002)(2906002)(36756003)(1076003)(336012)(6666004)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:18.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cbaaea-a62a-4b97-43d0-08d9e2825161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets'
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the boot kernel either through an EFI config table entry,
or via a setup_data structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
boot kernel will use when servicing cpuid instructions via a #VC CPUID
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 04cabff015ba..e1596bfc13e6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -426,6 +426,43 @@ static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+/*
+ * Initialize the kernel's copy of the SEV-SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SEV-SNP CPUID table used by firmware
+ * would be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+static void snp_setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_info_fw = (const struct snp_cpuid_info *)cc_info->cpuid_phys;
+	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_info = snp_cpuid_info_get_ptr();
+	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
+
+	/* Initialize CPUID ranges for range-checking. */
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in == 0x0)
+			cpuid_std_range_max = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			cpuid_hyp_range_max = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			cpuid_ext_range_max = fn->eax;
+	}
+}
+
 bool snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -437,6 +474,15 @@ bool snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	/*
+	 * If a SEV-SNP-specific Confidential Computing blob is present, then
+	 * firmware/bootloader have indicated SEV-SNP support. Verifying this
+	 * involves CPUID checks which will be more reliable if the SEV-SNP
+	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
+	 * more details.
+	 */
+	snp_setup_cpuid_table(cc_info);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
-- 
2.25.1

