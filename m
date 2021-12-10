Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2A47048F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbhLJPtN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:13 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:63904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243503AbhLJPsN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvG1kI/rAWfsO68HuMo+GxVZ50CbtqbhifykKAypa/Y10WVBCm1vRJfA2cX/IjdXZIqXDpTUzOpqF4QCX5D9xZoh1sUEYHxn+WMGTPf/6lFK42ntZUkcF9vtdW+2glgtb68UI3XzHvZU0G49YQ7kR3EzNV2Nih6v8rjidC99o9c4uM9C6Z1egPSKBXQxPvJyw0xLSZXgf5VNy0xOI1h4iM9KIUrZrgbUcsODP0VBcJ1b4edaciDkODusBg0UMTjd/f+fCUkiQex94d43DuSGmsdZfpUOV3YYHO0jyXTvDkqZrRx0SRVAtsbnhV9bIVSZZKLMD4H43grj00FO1gvAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3epH9VFTw7uP9HgFPaSSmxJsKbqpmMoDbhazQJ0NMg=;
 b=mEQQ7udOYz2SBfieKfabUof5UDnlt5A2uqQzyOOzE0sFpSRSFkDlp9+Q/MVk9ijILmoWwTBf/+fMrrutXSXG5oBZQdkXv3tdTrghOgqYIdfiQCCqbpNUTLHHZBws0Ely/D6aU/gi0StPLhbV7DuOsk3c0x/uqKXNRsWhI6mNRx/6n//kK4kkKpS0z3aZKUwPJrun4QCmj38Y3Y0J7/G8oI0WC04hQo3/Hk1JaWgFed6/MWSV6ThOkPv3dKAEIFFbX2MD3sMmoQnRQlGXQEZNB3BdKe82pFSWLxj0La1cnXnEoHK42SOeLA3hPZflTcgaFz+b4b/Uvvx509CGk5WJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3epH9VFTw7uP9HgFPaSSmxJsKbqpmMoDbhazQJ0NMg=;
 b=c0gTaImWPj7wK5xSblx4dCft6xuXIHJR+megQlj2d7FaBNDu596aEHLb+21nTN7QZLXfO1t1SbxNu32PLnGx00acIfb+YbelpZKEVbEPGP3M04Y9mEGQiAnHJ1GjUot4mZtsj/mmA6ioijg1n6N22dDhqTT20XiSBC8Igdm5wN0=
Received: from BN1PR14CA0022.namprd14.prod.outlook.com (2603:10b6:408:e3::27)
 by MN2PR12MB3102.namprd12.prod.outlook.com (2603:10b6:208:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 10 Dec
 2021 15:44:29 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::66) by BN1PR14CA0022.outlook.office365.com
 (2603:10b6:408:e3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:29 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:27 -0600
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
Subject: [PATCH v8 25/40] x86/compressed/acpi: move EFI config table lookup to helper
Date:   Fri, 10 Dec 2021 09:43:17 -0600
Message-ID: <20211210154332.11526-26-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab0c84e6-729b-4d50-f3a1-08d9bbf3f40e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3102:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3102AA1D6E0C34F20817DD7EE5719@MN2PR12MB3102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwu9NKpNpIzuiqwPZSyVlWRLfB5u04rLRVyQYamw7D7pjL+bUdgwureThItk6gpZJYSguCxXbSN3b2L5aGWNdAeyzCTLi9WNrw0AJ2u3dSNBuGvIZHqDd0YoIvNltcciAXmUThtkb/L2lo/M3woQ/Eom1uH+cd+PjiHWdrL+TCMKpvAeVtCf6WRTILpWhVf61bGEljRbXJM/Yaj9guVcZPa4QanAiO9zvb/+c1Qw/TOLwkVQNOOs5v9iOvp7HNNX/3XSOBdu1ST7YIFXKrEPhkaxM9ipiurIfi6YgQZFtVbvQQ7BWVZ9vYaBTwbYkv5rdGbUEC/PRmuAIQcBuXS9ZjqtKbEja5jXbjIRkYqy69LEo179FMsWL4t4EdLXYvTdRANtI/lRz62DNOzCf57vN7W7VjGp4HuAwawb4lTmNhHXqdklNzOCSGvd8grBJo7Cp9fkVyMEJR5tlU0vs/1p25CHV5qlDZ+mmSeZGf+3kJtYfbGRhdpB+7F8erHbv4WRVW6EJJFpXihgw30OAULUx7Ea7xM2yoSZPXpvOi5J5zGsw/zZoZRmVae+fexYO7ehTV11lOJAk3wFAyem68jNgSZ5FPtctryaWBjTwKZDQsXbFhWGEb5wteHjS/szOVeoMz3EIIDKocJXcCz65z8hz6uJM1l98OLYRngz7HOKKh7oXqLVNWA0pwwKBQ5O4qlrlYP9iuvVSEbNd0kT7bgWO+o8K+fntaXEnOXncIaDo79h/0GAWTu7OP7Q2xhlD5ZLzIlKfOLGyo+jVYqJ8oMUekUnQuhJBXrj7tQJrOY3+hFp5bxJP1S4sbIcyEGvRQOJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(7416002)(36756003)(16526019)(47076005)(7406005)(7696005)(40460700001)(82310400004)(426003)(1076003)(316002)(508600001)(8936002)(83380400001)(81166007)(6666004)(356005)(70206006)(2906002)(110136005)(26005)(8676002)(44832011)(4326008)(54906003)(2616005)(336012)(5660300002)(86362001)(186003)(70586007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:29.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c84e6-729b-4d50-f3a1-08d9bbf3f40e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/acpi.c | 25 ++++++--------------
 arch/x86/boot/compressed/efi.c  | 42 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  9 +++++++
 3 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9e784bd7b2e6..fea72a1504ff 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -117,8 +117,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab_tbl_pa, config_tables;
-	unsigned int nr_tables;
+	unsigned long cfg_tbl_pa = 0;
+	unsigned long systab_tbl_pa;
+	unsigned int cfg_tbl_len;
 	bool efi_64;
 	int ret;
 
@@ -134,23 +135,11 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (ret)
 		error("EFI support advertised, but unable to locate system table.");
 
-	/* Handle EFI bitness properly */
-	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_tbl_pa;
+	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len, &efi_64);
+	if (ret || !cfg_tbl_pa)
+		error("EFI config table not found.");
 
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_tbl_pa;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	}
-
-	if (!config_tables)
-		error("EFI config tables not found.");
-
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 1c626d28f07e..08ad517b0731 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -70,3 +70,45 @@ int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl
 	*is_efi_64 = efi_64;
 	return 0;
 }
+
+/**
+ * efi_get_conf_table - Given boot_params, locate EFI system table from it
+ *                        and return the physical address EFI configuration table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len, bool *is_efi_64)
+{
+	unsigned long sys_tbl_pa = 0;
+	int ret;
+
+	if (!cfg_tbl_pa || !cfg_tbl_len || !is_efi_64)
+		return -EINVAL;
+
+	ret = efi_get_system_table(boot_params, &sys_tbl_pa, is_efi_64);
+	if (ret)
+		return ret;
+
+	/* Handle EFI bitness properly */
+	if (*is_efi_64) {
+		efi_system_table_64_t *stbl =
+			(efi_system_table_64_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl =
+			(efi_system_table_32_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 165640f64b71..1c69592e83da 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -181,6 +181,8 @@ unsigned long sev_verify_cbit(unsigned long cr3);
 /* helpers for early EFI config table access */
 int efi_get_system_table(struct boot_params *boot_params,
 			 unsigned long *sys_tbl_pa, bool *is_efi_64);
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len, bool *is_efi_64);
 #else
 static inline int
 efi_get_system_table(struct boot_params *boot_params,
@@ -188,6 +190,13 @@ efi_get_system_table(struct boot_params *boot_params,
 {
 	return -ENOENT;
 }
+
+static inline int
+efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		   unsigned int *cfg_tbl_len, bool *is_efi_64)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

