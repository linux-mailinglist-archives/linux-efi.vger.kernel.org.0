Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B35427050
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbhJHSJa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:30 -0400
Received: from mail-mw2nam08on2069.outbound.protection.outlook.com ([40.107.101.69]:12385
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242390AbhJHSIJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmqMX6haEgv91eNPU/bVl7W1XKI2GSHafMsW3QyLIwu5sbEC+izcuDNYl8JS35syEpF0xrP/5jL1aLjXdWnxOBPO4jYLPoNSceYNjP00UmHPBtb7xl8fxPa4Rrh3ZhNKpMJcXQXmWuMoxRsXR34/2aiVHpDrzq1a3i0orq84kjPfkXf/o4fv+PfVQdffiollAYDPwqNZG8yA27LULhDGuIoUYb8iyD60hGXbtoaafqTiF3puc2fDOI8e55f/IwjsdlxLizDnMFwAuUxImuaaPxOnAy4VBW5iufdu7DhutGm8gH0oxSxViTr8NSdtyAAOG4twF6MesWJtmPQ4AvkYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OtbCZbidlQdu1N5U2s+EajZpLGj/wBO+l7KUSSv6tc=;
 b=GbozLivkhlyo3WFfXEZxVfKRdsbJtTH2pNp2BJiW3MBZXLvOLnXjZpzwSEqZtE0HtC6I1xGfR75+O4kcsXd8wor4s2P25bd8yQIPFJzYlm35OSxwZ+KjPAr1cGhQgT6qJQ9a7dyO3/0m5cip1N+l+O0EG30N70QkkiWaFGJonCUhykpsNJqNnIcMG1d87bMsQuKFxi0TrcNYiSwieUX0W4UavqPiftYrKKrFXjGpR1qzs8dW+iNQH4Y4ajP8LuEdm/mkfOogjHLfLqxDG0UQLLwA+dTtdtr5WRpm1PvRj1YOXpcKZqycrOv+gmgzzXJ6ccZLgwKSKmpIRfp5YTPxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OtbCZbidlQdu1N5U2s+EajZpLGj/wBO+l7KUSSv6tc=;
 b=PdwgybrLvFhM8P01Lzvxu8V6goeY9zTPVAgRVZSEGQiEUIRQiE+V8jDBF3iLw7RDDxcE3Ex93XuwgKun8Rpq+BaX210IK3qfB4Zehn9Odcc2wIOC9auNOiZkHVQeX34nJYobHgfHdeT1NuYzl86l07NmUTpGTKEj8Sy3/u1L9fE=
Received: from MWHPR20CA0045.namprd20.prod.outlook.com (2603:10b6:300:ed::31)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:06:09 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::1f) by MWHPR20CA0045.outlook.office365.com
 (2603:10b6:300:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:01 -0500
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
Subject: [PATCH v6 30/42] x86/compressed/acpi: move EFI vendor table lookup to helper
Date:   Fri, 8 Oct 2021 13:04:41 -0500
Message-ID: <20211008180453.462291-31-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd9cd5e-9af6-4bf7-07f2-08d98a864dd2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2589E9A0BB4157E84AC6EDA5E5B29@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFtEfoa8m9q8xCzkqAhmGQ0RGG2KEjTV+iRuZZRd1wfdNYXUH+GLOu2HvyzuNPiTQOmmleyIwUbu2M2FQvVrcgCY01SgTJINzHHbpVuFhXTzcUS/OnwIExGDfB+QeUuG/0c2YVbYFBEQ5yFDkt0JPKFWXp5IVoj1yIpSVuX49CIfZtjrqjpC0SPpTQWbMalEN77RS9bJw23qLwl/PZX6rkI9A+1ZpbscjbASD54abjZZHJ8I2bUMxfzUjwvuyWnDu7Dwp0vd+iuOIpLd/mnhPQ59SOj4BjjV9BjORl5AfPuzR2hWaL/c58/cA8gchd7Cf0fNUAOIFMKeYncLLbCUGTMRDwpufLpvuE1PLUIGq+D+SriyaxL8ABnuAcPGvRGl1WnK7iozTsski6io7QQVDw6o+OTixfEmc1JASUZBzc8nqM3pdflUSZOyhbtlrFkLon5PRObRjefXJA1N4pfw4V04qJU8MM1om2Px4PcbvCAbghPsMduT6D9FFeHqXJlqUxwS63V7gHYe+V/1NKMNK14+jXfBa1GfdVD8MCKTbz9Kk+gEMEY5Hw0rB6fbNXjLTAhDUvNy0JG+IJB8MH9UqZ+mEIrf2EwJ+4eCKeQnMWZNJF865sP+jCcjhwR4M8setBXkuUJ/EftBigYjIq/WJ5zwxKoVjRQwQe60Xx0aVRpBlUtKVi9ZkXjQRSrBhxOr//+7FJtt57fxniW3aSiB1MONhVFWD88lF+lDdhmbvgS/C5jEIdcSeJX+IiPOZOnr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(82310400003)(426003)(2616005)(36860700001)(336012)(16526019)(186003)(6666004)(26005)(70586007)(4326008)(44832011)(508600001)(1076003)(36756003)(8676002)(83380400001)(356005)(7696005)(7406005)(316002)(2906002)(86362001)(70206006)(8936002)(47076005)(5660300002)(7416002)(110136005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:08.3947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd9cd5e-9af6-4bf7-07f2-08d98a864dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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
 arch/x86/boot/compressed/acpi.c | 50 ++++++++-----------------
 arch/x86/boot/compressed/efi.c  | 65 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  9 +++++
 3 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index d43ff3ff573b..f2a6092738cd 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -20,46 +20,28 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
-/*
- * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
- * ACPI_TABLE_GUID are found, take the former, which has more features.
- */
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
-		    bool efi_64)
+__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len, bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
 
 #ifdef CONFIG_EFI
-	int i;
-
-	/* Get EFI tables from systab. */
-	for (i = 0; i < nr_tables; i++) {
-		acpi_physical_address table;
-		efi_guid_t guid;
-
-		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-
-			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
-				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
-				return 0;
-			}
-		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-		}
+	int ret;
 
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
-			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
-			return table;
-	}
+	/*
+	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
+	 * ACPI_TABLE_GUID because it has more features.
+	 */
+	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_20_TABLE_GUID,
+				    efi_64, (unsigned long *)&rsdp_addr);
+	if (!ret)
+		return rsdp_addr;
+
+	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
+	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_TABLE_GUID,
+				    efi_64, (unsigned long *)&rsdp_addr);
+	if (ret)
+		debug_putstr("Error getting RSDP address.\n");
 #endif
 	return rsdp_addr;
 }
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index e5f39b3f5665..9817e3020207 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -104,3 +104,68 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
 
 	return 0;
 }
+
+/* Get vendor table address/guid from EFI config table at the given index */
+static int get_vendor_table(void *cfg_tbl, unsigned int idx,
+			    unsigned long *vendor_tbl_pa,
+			    efi_guid_t *vendor_tbl_guid,
+			    bool efi_64)
+{
+	if (efi_64) {
+		efi_config_table_64_t *tbl_entry =
+			(efi_config_table_64_t *)cfg_tbl + idx;
+
+		if (!IS_ENABLED(CONFIG_X86_64) && tbl_entry->table >> 32) {
+			debug_putstr("Error: EFI config table entry located above 4GB.\n");
+			return -EINVAL;
+		}
+
+		*vendor_tbl_pa		= tbl_entry->table;
+		*vendor_tbl_guid	= tbl_entry->guid;
+
+	} else {
+		efi_config_table_32_t *tbl_entry =
+			(efi_config_table_32_t *)cfg_tbl + idx;
+
+		*vendor_tbl_pa		= tbl_entry->table;
+		*vendor_tbl_guid	= tbl_entry->guid;
+	}
+
+	return 0;
+}
+
+/**
+ * Given EFI config table, search it for the physical address of the vendor
+ * table associated with GUID.
+ *
+ * @cfg_tbl_pa:        pointer to EFI configuration table
+ * @cfg_tbl_len:       number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ * @efi_64:            true if using 64-bit EFI
+ * @vendor_tbl_pa:     location to store physical address of vendor table
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
+			  efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa)
+{
+	unsigned int i;
+
+	for (i = 0; i < cfg_tbl_len; i++) {
+		unsigned long vendor_tbl_pa_tmp;
+		efi_guid_t vendor_tbl_guid;
+		int ret;
+
+		if (get_vendor_table((void *)cfg_tbl_pa, i,
+				     &vendor_tbl_pa_tmp,
+				     &vendor_tbl_guid, efi_64))
+			return -EINVAL;
+
+		if (!efi_guidcmp(guid, vendor_tbl_guid)) {
+			*vendor_tbl_pa = vendor_tbl_pa_tmp;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b72fd860362a..d4a26f3d3580 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -181,6 +181,8 @@ int efi_get_system_table(struct boot_params *boot_params,
 			 unsigned long *sys_tbl_pa, bool *is_efi_64);
 int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
 			unsigned int *cfg_tbl_len, bool *is_efi_64);
+int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
+			  efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa);
 #else
 static inline int
 efi_get_system_table(struct boot_params *boot_params,
@@ -195,6 +197,13 @@ efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
 {
 	return -ENOENT;
 }
+
+static inline int
+efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
+		      efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

