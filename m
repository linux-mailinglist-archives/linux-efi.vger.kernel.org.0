Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCA49FF4E
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbiA1RUd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:33 -0500
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:31840
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350767AbiA1RTE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb0LJ/GvcwLjfDqbPgzh5FKA8P+xGbRom2qxO7iBJWWhFl1fo0Utl2iZYuPmQwfYMfw0PbY3iyyu9kgVPdUkpvfp05M1ZdVhdDGKzXAOE/nsCqUEpMCYiO0OBQtbTo48ylDdh6BI82ZTaoHE/KBqBgGQ1EWJhOmBIwBI792K+ujmR1Cun3AnCpda+hTt9oT//pJHCDc2dwdH7aejxyQw3t6YylZEJfugd2utVSj06PyuVblZv1ZqckYOgOCVdd+z1px0XCYN6Jt1VqT4H+29l0C4URzvyhuVlj4g+EAYZq58DOzXhLiKHXHqnTsRjkLdXSpoH89juQ358aj23e4lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyyPP6ZE5MuvUdXWYLA/MY3mpcmk5kAJgcXKxAMqm4M=;
 b=ecrMnKpALKaHLU3GE1mP64g4Yz9p0MVXYRF/1vgf8wm2caKSXIaMHyPpNURsfzso7WFw0NlizOhe+yQljdROz22TKJ0hiOuLtL54WAil+Rc9iBnRfgQ/ruzeSQIIZ1F8kC8VzTiugdaG/U5fLAjfarnESV+2dR7WhchB2NoBBBP/0kWVbS7bbMF5J/DpJ77fJFI1lJKdPveVJKsO93zdCKEKAuN/pElN8hoWqaRLKa3R929YV0kil5qkvVwW0WFtyTvdqr6iqKvi8K3FQXHHGnPEK20ZfmeITRbBJksg5KbNRtekf2alwa80MBB6errbRlNzp7jl6HZZGMrFYXQmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyyPP6ZE5MuvUdXWYLA/MY3mpcmk5kAJgcXKxAMqm4M=;
 b=M9NihLMrKuZ/R/KIEJ+BbXMilpT80VRgFGTdF3viwM5K2u+TJuJuVetFSWca0Kb7Oad5wPcIL1Qbphk2t/qlSh2rUjcXyQnj3mBL8h9foG3w9wVrSgbfSb7kdU8bQF8cqMf0wWcSwKUOEXMhzsTEckmRe1ktAGutL8ma1b2qpFw=
Received: from DM5PR21CA0013.namprd21.prod.outlook.com (2603:10b6:3:ac::23) by
 BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Fri, 28 Jan 2022 17:19:00 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::b5) by DM5PR21CA0013.outlook.office365.com
 (2603:10b6:3:ac::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.7 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:00 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:58 -0600
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
Subject: [PATCH v9 25/43] x86/compressed/acpi: Move EFI system table lookup to helper
Date:   Fri, 28 Jan 2022 11:17:46 -0600
Message-ID: <20220128171804.569796-26-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8541033-eca9-47f4-e159-08d9e2824692
X-MS-TrafficTypeDiagnostic: BL0PR12MB2339:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB233995841520D41B176133A2E5229@BL0PR12MB2339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRE3yPlOczf0Nd4E43w4zzVUfJsAehI6dWk4gRRkXpKbs/6+L7cAEBv0XB7zD7DDM3SVmhNrKV3cxUBxBzt0VKjw5sE/TfxWA8c6kPVqVoLNs3KKZIcVJB8kORHBt01VSU2xHyUrADRqJ92Tejr5YTLM845f6USoXCuhm0Vc77wZEKq2gI7UFlz4aWEjDj6STElIimSKo1DbZsD2BsczetcGdEAEkUeu3l+s0piVqoRim0Ojsc9olapzU4vqbUI2fqPQF0QkGyPN+xUlOqC54jnPk+B5G2a6q8NxdKS0HccSJ59jQS6EaUM4l5hgAtu+6CcoyYqgyZTVLY+XDsqPhfIVY3GFkcFkw3p4fitYhmBL8SvG088hg1emGaAi2EeKViZDi3KbyhAiApfs4KaMQH7suEIqJPfq1+wHh5b10w93N1VId9Q6qa5ps+q3YdKU6AbweQAkamLItHYAHv1GycbTL1lcUsbONq951RTzWnaxuH5ZVEyiut5IOQsvlab7o1cfdRbDuQXcd7B4GFnrdYBl5v8k0m9ztRo8rTA0C9JiBiVL6mcuJmBsmDRFwD05VdPIQRTCuYwXUr/MPm3jFiGqYKolOI0lEKPNnl4zsxO7JNgc+Sy2EW6J2DwbJ/k7FJgTMeL5mt7Ybb2PK79AMmPpC55AvXSphpOvMaI5oAD+DsB/r99SNp6QEAFAmctYobT8wjs1DOU27xar7IVsB7t8x/gxSxKtFTmv6NZMh+izUYYNsOfvE0R2YhV9opeV1CoaSR0EtkqWtKC1Ll0+TXvWUtJ4DeH3dyd32r2WvLNnpai6KztVFZEZ5dNtxabd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(86362001)(83380400001)(70586007)(7416002)(7406005)(47076005)(336012)(16526019)(356005)(40460700003)(426003)(508600001)(36860700001)(26005)(70206006)(81166007)(7696005)(8936002)(82310400004)(54906003)(1076003)(2906002)(2616005)(44832011)(110136005)(36756003)(316002)(5660300002)(4326008)(6666004)(186003)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:00.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8541033-eca9-47f4-e159-08d9e2824692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
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
index daa73efdc7a5..bf99768cd229 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -48,3 +48,32 @@ enum efi_type efi_get_type(struct boot_params *boot_params)
 
 	return et;
 }
+
+/*
+ * efi_get_system_table - Given boot_params, retrieve the physical address of
+ *                        EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ *
+ * Return: EFI system table address on success. On error, return 0.
+ */
+unsigned long efi_get_system_table(struct boot_params *boot_params)
+{
+	unsigned long sys_tbl_pa;
+	struct efi_info *ei;
+	enum efi_type et;
+
+	/* Get systab from boot params. */
+	ei = &boot_params->efi_info;
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
index a26244c0fe01..24522be8c21d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -185,11 +185,17 @@ enum efi_type {
 #ifdef CONFIG_EFI
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *boot_params);
+unsigned long efi_get_system_table(struct boot_params *boot_params);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *boot_params)
 {
 	return EFI_TYPE_NONE;
 }
+
+static inline unsigned long efi_get_system_table(struct boot_params *boot_params)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

