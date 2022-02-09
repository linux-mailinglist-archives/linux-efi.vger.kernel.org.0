Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982794AF98D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiBISOR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiBISNK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C4C03C184;
        Wed,  9 Feb 2022 10:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1dt8XcFqJTqSE5ke8avTQdk3Y0c+mGFm1eubNYKyHiaq0j3JFk8YQMxyL5v/laSpgZ7aoKng+KekQ6umfrK9j2WO2J5XyhVw+167BqgyADRhE1G2iKqEdqe6Q92Y2FL6Kj7d/YJqYJe3KLCDh2QyuHKfi+k0Q1yywgebDrraVqqSBr0nyZmc/+BZE4MBetDOfhWNy91AYbGxI/4SPiZBhwPxytjuIbCvS7vZj5XgTQ9iSz0HJP9I+XjElMl0EZsU9pj9SpWgk2mjUt35adBVwhGx5bE9JOt0XY26ZCxBVf1wwd1Oq0cA/HHFSV9j5DgnkN9BFVASQcZdKJP2Oec4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=IekRO4VZ6LvJAXT9zCiYFF7rPbxymfm59LbrFCVy7wWFJcbhN1lG/BO2+MJXxErKSEzLGPanI2+ya0n8BjYULsGl/+374qedsXPiejGlTA85ghJ1oFeEpjmKqO4VpO4JWrH07wio9NQr2sFYsWB0qVAwUn6Dxle6KlFippCL4g4tWiYJ0ckzmqBTePfUWXcZwegYDn8kcaQoozSMITkQ+6/rJYjKpyLEKLb16Y0exjbDtATnyCmZqBZN1dk1A5O3z6YdLecBhWgqNINz/qRvd2hvSzpXoqanyTTticIpkwPlQ8hutnbIsEplzuL8G9XbkVG+l/68ZUQzi/mpwvd/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=T5IJdhmaBQlSdQ6eVFFy9JfxzDPyrOxCQgDxY9QCGG9aaI8cMbYyj1PPd8hyRJMsCv/du5GqlBIahSv9eJ2N52o33BxAJ3qvr1p5ntX8BwUfxNKATYBPfedXjwg38AQxBWm3454pcGsQ2AGHUA7QQFLGV0qmFhL4QECdL+Egnhg=
Received: from BN9PR03CA0698.namprd03.prod.outlook.com (2603:10b6:408:ef::13)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 18:12:10 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::43) by BN9PR03CA0698.outlook.office365.com
 (2603:10b6:408:ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:10 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:08 -0600
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
Subject: [PATCH v10 25/45] x86/compressed/acpi: Move EFI system table lookup to helper
Date:   Wed, 9 Feb 2022 12:10:19 -0600
Message-ID: <20220209181039.1262882-26-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee1cc060-8251-4570-3b22-08d9ebf7b0d2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB43061E15820B89A84990DAA6E52E9@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZ9BXL5EaDeRY0MDfmHIIjGFqv5p6bB4Gc10I5UjUFO+ej5S9Hb7a1+ZTd7b+emXLSYpur3Mx1Q7Ccj5kOA5gzWOgat4mwXAaCebR3lUMDs3zKLf26Ixz//F2uC6aD+SrGaMfhSWqFBDe1bpdc4u9KoOAwm6GBQErreieWZRte9rcXNIbVCGYRvMUVcWQHsIyd9v4sFXXJ4U9lKyfW0mmQaqrgtkhXYtfT7y3Ig6d3WaDt0FAraILMEigZiuCykOM427NbJR8F9zuY9oPyesWFm0KjVUKpEpniXIzc8EHc2aHI7bUBk0u+nvyGgig1HClVZt+EKKGp0MoVAxWaDc0A9rdhWGRY0dejfU4pWQmn2d1EILRJ58klTE+ffKHrhShC9j+bfuYtEYt2uNTSOSLpxdlY6vmHL/KTwNiYKlwcVXmPByogUv/z5iU4Dz+3X6e7MSz73GfqBwMekPjEGt1n8vGZBmGusRjq6NMyV8/a7COycJp8ny/QS88wKb7irL0fHEJGmwcHy8frEVSJcPA6YkQH2fGmo6NBiFWqqkmiQVQBPcTERmlqIDmylBk/3UgW3tmEEd8IsvDKaSIzxclOSjND3rSGSPenFUxdQwuPiNWFwpZl8kph59G4Kv89SD3FAVBEq+ShE2/cdrPRnPCoWRNCUL+Imy/AvutWqy5HjDMj8/EUhg4eox50LrwPqrpsFIVSWzL8Cht+S1oCEQyAC1eFOuDCNoM3mSwsXpQYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(6666004)(7696005)(40460700003)(508600001)(1076003)(82310400004)(86362001)(356005)(36860700001)(186003)(47076005)(26005)(5660300002)(2616005)(8936002)(83380400001)(110136005)(54906003)(36756003)(316002)(4326008)(7406005)(2906002)(7416002)(44832011)(336012)(70586007)(8676002)(426003)(16526019)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:10.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1cc060-8251-4570-3b22-08d9ebf7b0d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related
code into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/acpi.c | 21 +++++++--------------
 arch/x86/boot/compressed/efi.c  | 29 +++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  6 ++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index db6c561920f0..58a3d3f3e305 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -105,7 +105,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	}
 
 	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	systab = (efi_system_table_64_t *)efi_get_system_table(boot_params);
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
@@ -118,9 +118,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
+	unsigned long systab_pa, config_tables;
 	unsigned int nr_tables;
-	struct efi_info *ei;
 	enum efi_type et;
 	bool efi_64;
 
@@ -132,24 +131,18 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	else
 		return 0;
 
-	/* Get systab from boot params. */
-	ei = &boot_params->efi_info;
-#ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
-#else
-	systab = ei->efi_systab;
-#endif
-	if (!systab)
-		error("EFI system table not found.");
+	systab_pa = efi_get_system_table(boot_params);
+	if (!systab_pa)
+		error("EFI support advertised, but unable to locate system table.");
 
 	/* Handle EFI bitness properly */
 	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
 	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index bad0ce3e2ef6..72a81ba1f87b 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -48,3 +48,32 @@ enum efi_type efi_get_type(struct boot_params *bp)
 
 	return et;
 }
+
+/**
+ * efi_get_system_table - Given a pointer to boot_params, retrieve the physical address
+ *                        of the EFI system table.
+ *
+ * @bp:         pointer to boot_params
+ *
+ * Return: EFI system table address on success. On error, return 0.
+ */
+unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	unsigned long sys_tbl_pa;
+	struct efi_info *ei;
+	enum efi_type et;
+
+	/* Get systab from boot params. */
+	ei = &bp->efi_info;
+#ifdef CONFIG_X86_64
+	sys_tbl_pa = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	sys_tbl_pa = ei->efi_systab;
+#endif
+	if (!sys_tbl_pa) {
+		debug_putstr("EFI system table not found.");
+		return 0;
+	}
+
+	return sys_tbl_pa;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fede1afa39e9..b2acd3ac6525 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -185,11 +185,17 @@ enum efi_type {
 #ifdef CONFIG_EFI
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *bp);
+unsigned long efi_get_system_table(struct boot_params *bp);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
 	return EFI_TYPE_NONE;
 }
+
+static inline unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

