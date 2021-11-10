Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C144CC1F
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhKJWNb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:31 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:12896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234034AbhKJWLv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9FIqf3KfYutWgqJda/jkHpU/0BHci35y6rRTOhvMMaZvsLqxcY4SrxrMMmSIiltw2CTpChIujlZjzJfyprbLVrc7r0noQjsoOANPM8fxMOgpVt9nGLbEkN+shD79l/FJY0OuXzfGE4KJ1hGofA+DjWTrC3oFvqjJGVUeUVjCBV9k2SiygLFgBVFPcRYvxl+0EMVl5zIarVoKOmZWX5lNgtKoH7ZOJHKkyIjF+NWCbEVU42SdWf5j6Qp5wTTJ+A2B3WKSZAwQ2UONHFgohH5HiRJCJDAkqZz8vTPq6PzEZm6WLD8IVKJnmXKJxm8TZqK2QCnh/sBmkFcdzbE06RSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJFWUjd0B3rTzpv8yuA5raaKMB69nrJGb4ObrnVCSEg=;
 b=bfqTXRqX1PI2TAuH9mvV0L1aSbNZ1Em8MclV/flkldWweaiPKR0Gi54USWsFc8TlDept4QWDte+uXZzeEvQmrcYnmOHT4Rpp1M0IKCIvzDdOKnmlRDePn34y6CFj2uT7t4RL19UE6WkxIX6XCqcgXul/GoEylRTxoRnxxj7+xxRdnNd0gtMQ2l2q1ybBpTa89USuJjjpjpQBwUjEv3jZZvHWvHEzMBMR44Mdf+Q9wgiLjp6ltmZBeFdIxF6zRDDANU4X2YZc7iAGZnhZMuDJb0tm6yP+0jk5cQbbHE2SjrnDqRwVg1YZXZ0Whs7e1KaDxdKPqt1Cw6eEiOcY6HlCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJFWUjd0B3rTzpv8yuA5raaKMB69nrJGb4ObrnVCSEg=;
 b=aCW8aTygwVJb9//amAWzIlnad6Zta6NXe1qe+0rPKm1swk6r2159BgAdWcNe1EAEct+TA/40bZT6MpGoV69oxKX0uVkrtWW5BtoBjZFm/tjWGshJXaCvvnBYH2A6X43I0087RmNVaNji/JsImwOJetkDBtKh7QOGEb4XVomshLA=
Received: from DM5PR2001CA0005.namprd20.prod.outlook.com (2603:10b6:4:16::15)
 by DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 22:08:43 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::60) by DM5PR2001CA0005.outlook.office365.com
 (2603:10b6:4:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:43 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:41 -0600
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
Subject: [PATCH v7 30/45] x86/compressed/acpi: move EFI config table lookup to helper
Date:   Wed, 10 Nov 2021 16:07:16 -0600
Message-ID: <20211110220731.2396491-31-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4aa05274-370d-46ce-af91-08d9a496a8df
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:
X-Microsoft-Antispam-PRVS: <DM5PR12MB237681E1ACB36E78ED718542E5939@DM5PR12MB2376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MhNruxZX5Z/rWBM/+IdomnFxtS5A7jWQnf1/LVn58UtsU602RlaSvFCPjBSL2vjdaDZlOmh6W6IL8x/9Ni0NbvU8Y7g8CgMdQjlzFZDev3s7+SXVJNg8SDYlMMNRlJ528KZ4PfmWxWwmKS8wNv57Rb7cpDwb0CUVZUNjRMTct9j9foprnfsFAzWX9NW0yGAEAs3QhNS8Nwtq5ebUpFEXom26uzvxPjLE9jKxn31rrjNsfB1YSB0W0kbCkU0+ftyAZmVx85GuM2sBLOvYRirvL2bZmAdpZdCXKR6T3h21Av1XMxO9bNMLKz26IqjmsjOn/7RV/yO9TuVbKxgkdWeJkHfO4a0J6ZaVUIaUhqyqF7BEcd0Sd9Kne+tTBR/ySmMjFcyXALMVMw/9d22u7RHiryD7Jns3XGxubc8gFnMAWqkXej5VNtmJWRWgiw+d96BGnfaEJIaznhpD7FiIh14vgqaSKgQR6UhY3cGUT8LZPBrqN/QYmt8+zZYXl84sHPztyNvAgyO9oahVRASMbCfEKJ9AOkXiCZYKN7Y6muECynTAP9Q++8upBQtfpT1CO29ece+8neb9Mg9FRNCxSFIgUB0bABY+m3VdbVFSnkc89I/6q6vxKyVdJa7MHmHLFschDel7Wjfjh9vO4Agd5ASV9xd8VLYmsi2DA7nQxOaq8pd9lXyFs0JT7WDr+fHZnx4FVcA66Z0mM8zTaosU+i0FF6O2hqeR7tNWQd6NID5DrenYwdCEqRlBRJozKxKHMrY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(7696005)(8936002)(83380400001)(82310400003)(70206006)(2906002)(81166007)(8676002)(47076005)(508600001)(6666004)(70586007)(316002)(186003)(36860700001)(4326008)(44832011)(2616005)(356005)(110136005)(7406005)(1076003)(7416002)(54906003)(36756003)(426003)(86362001)(336012)(26005)(16526019)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:43.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa05274-370d-46ce-af91-08d9a496a8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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
index bcf1d5650e26..4398b55acd9f 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -69,3 +69,45 @@ int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl
 	*is_efi_64 = efi_64;
 	return 0;
 }
+
+/**
+ * Given boot_params, locate EFI system table from it and return the physical
+ * address EFI configuration table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
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
index 165640f64b71..074674b89925 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -181,6 +181,8 @@ unsigned long sev_verify_cbit(unsigned long cr3);
 /* helpers for early EFI config table access */
 int efi_get_system_table(struct boot_params *boot_params,
 			 unsigned long *sys_tbl_pa, bool *is_efi_64);
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+			unsigned int *cfg_tbl_len, bool *is_efi_64);
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

