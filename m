Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E3E49FF49
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiA1RUb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:31 -0500
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:2497
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350779AbiA1RTG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhcbMcuGj0XsyU6BYXAG1ejX6N8KYfHUAQt23MV7vUdooHAW21mjSQDSSxQOuQEgJGYjc697OTbSFaLValdXG7J/kISFBwGfCHfTanAtkGRFu9JKABOeqZVVy0u6mLRJ0UQD59A37b3h/KdidKB53S+8GzeExR95ymBI0YklZFCxV7Ye7usMNBRdqnB69MEZsnBzTyDrMYWyGV4GmEcoVF0ZF1rCiPLZKPycvQ/o1SGth6XF2Kgev4WrYk7nJssgfTMhl/voaJ4yubZ/RiIfF3VIAp+HY4N2FxiQFmmhVgV9RiVQAXLNKb2WsePf+Ekzn87f5PDGZLlESg1mDemZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AtXAVK1O1cYgmb4Vd2k4betYNSdc5iLO44cM7BsLHQ=;
 b=oDmbc6WKELCxNVg1VPHpT8qjs+LHO1SZvmYWcOEk74Han3aqV+Po/M4+THRaLyq74MfWFYVpynfR6clvCJfsRYuzQppau801hV8cSgdzkR9STwXHRV7CuvUmk4DObFzwSdgBNPQxYBItkO2Y8kUcFlX2dr0ox0Kow4r3NS8Lu0mBSAqYUS+yzWCQCVxeL3ikV6TSMiSGEq0NubQNUb5Wq40CsIXcTNxLsamzzT9+GNuGizqi+taqpY/HIcJuGx72837aTBY75qbUjHHUYBCbl99Y5vs0u4hE8G2AVu19qp8tmwMeIniCOjYJCgqZAo02gzwc0p6Ek8eNVOnglMUfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AtXAVK1O1cYgmb4Vd2k4betYNSdc5iLO44cM7BsLHQ=;
 b=KhqqOWGMy6SP0qIPgslHb3k9oxRviCUCvHIT4dfnRtZgLpyaY9djc6zFeCrPsSeZBs9DxGUpn9qGfAyO8tUuhX03UD9qeWhn2texB8Vd05jhZzysdlT2wHlZRfp8CshyqMg0WPLPaLt9NwN3bFupDO01NVUah3DLrfig3FUc/ns=
Received: from DM6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:5:134::26)
 by BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:19:04 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::24) by DM6PR13CA0049.outlook.office365.com
 (2603:10b6:5:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:01 -0600
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
Subject: [PATCH v9 27/43] x86/compressed/acpi: Move EFI vendor table lookup to helper
Date:   Fri, 28 Jan 2022 11:17:48 -0600
Message-ID: <20220128171804.569796-28-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3aa6d1d6-8c07-41d3-1d48-08d9e2824887
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB272535DF079765AFBB6D6594E5229@BYAPR12MB2725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZZcogt+26G7l17GGk5DupUpJrzp97sDUQ6GdVRk5qKuTrv+II9DOVYRyn6r5G1sGh+/RTmr/nUxtnUmoyHC1KOv7dTWJ4aR/ptDpCS988dqAToQv76hbbSPsS9o/3E/bM33/hykE/LLVlYxvTEtd65PtCzSgk4zuCaPr2kDoVKVKohIB581S8K28vgiYSq6KQMCfussCD8BmX4qgj2Vk9Hfu/Qs2j/Yd3BLv+QNZN9JJ/DBt+Oq8cvTM5lJVpkIMlqxEB2yXZEYoFpgt5pbjFiBpqL5sS+kQGJcNvuMH2y5dPvDFfhtG/IQLsnGvUBqP/s3AMvCM3KANRzKWzhNCCu/CRSllVvLIpQDz/3Yd1iBYumAq4uUfagBfdllP5Ln2o7Tv/fteqCQCqPjjjFR276q/vupaKqWtHtLkxWXPFLv+QV67rnAbOC+DtxUsvuNA+3Xs1OxgO4ScOkSrscKzxLfRybNLPXoXvLjVeLukRFtEdg0+5g4neNS6+rWb4wGwXu/KErexJ588HXSw35CMwznuqVoqYAwHrWfaw29wX7C/Od22JIDygML9KiPKdDiB/uBlzfTeu4bKLm9XdZ3Bd72JjCEfOXyicpnp3pU8jsihllQsWCD2sX3ewnT6Eic//6NseGZNcSPCSVQUSlA8IjuukHCyp90TzDVXVhOUfQUIGTZjjZwgKmKYEVw80DTn2Y0HKjN7yCLeXUcJvfJ+K0Of8AK/5EdbSJPkyhuBv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(356005)(82310400004)(86362001)(4326008)(508600001)(6666004)(110136005)(40460700003)(316002)(54906003)(7696005)(36756003)(70206006)(70586007)(8676002)(8936002)(7406005)(36860700001)(7416002)(44832011)(16526019)(186003)(26005)(426003)(336012)(47076005)(5660300002)(83380400001)(1076003)(2906002)(2616005)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:03.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa6d1d6-8c07-41d3-1d48-08d9e2824887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
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
 arch/x86/boot/compressed/acpi.c | 67 +++++++++++-------------------
 arch/x86/boot/compressed/efi.c  | 72 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h | 13 ++++++
 3 files changed, 108 insertions(+), 44 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9a824af69961..d505335bcc25 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -20,48 +20,31 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
-/*
- * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
- * ACPI_TABLE_GUID are found, take the former, which has more features.
- */
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
-		    bool efi_64)
+__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
-	acpi_physical_address rsdp_addr = 0;
-
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
+	unsigned long rsdp_addr;
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
+	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+					  ACPI_20_TABLE_GUID);
+	if (rsdp_addr)
+		return (acpi_physical_address)rsdp_addr;
+
+	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
+	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+					  ACPI_TABLE_GUID);
+	if (rsdp_addr)
+		return (acpi_physical_address)rsdp_addr;
+
+	debug_putstr("Error getting RSDP address.\n");
 #endif
-	return rsdp_addr;
+	return 0;
 }
 
 /* EFI/kexec support is 64-bit only. */
@@ -109,7 +92,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
-	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
+	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables);
 }
 #else
 static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
@@ -127,11 +110,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	int ret;
 
 	et = efi_get_type(boot_params);
-	if (et == EFI_TYPE_64)
-		efi_64 = true;
-	else if (et == EFI_TYPE_32)
-		efi_64 = false;
-	else
+	if (et == EFI_TYPE_NONE)
 		return 0;
 
 	systab_pa = efi_get_system_table(boot_params);
@@ -142,7 +121,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index feb00c6b4919..6413a808b2e7 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -122,3 +122,75 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
 
 	return 0;
 }
+
+/* Get vendor table address/guid from EFI config table at the given index */
+static int get_vendor_table(void *cfg_tbl, unsigned int idx,
+			    unsigned long *vendor_tbl_pa,
+			    efi_guid_t *vendor_tbl_guid,
+			    enum efi_type et)
+{
+	if (et == EFI_TYPE_64) {
+		efi_config_table_64_t *tbl_entry =
+			(efi_config_table_64_t *)cfg_tbl + idx;
+
+		if (!IS_ENABLED(CONFIG_X86_64) && tbl_entry->table >> 32) {
+			debug_putstr("Error: EFI config table entry located above 4GB.\n");
+			return -EINVAL;
+		}
+
+		*vendor_tbl_pa = tbl_entry->table;
+		*vendor_tbl_guid = tbl_entry->guid;
+
+	} else if (et == EFI_TYPE_32) {
+		efi_config_table_32_t *tbl_entry =
+			(efi_config_table_32_t *)cfg_tbl + idx;
+
+		*vendor_tbl_pa = tbl_entry->table;
+		*vendor_tbl_guid = tbl_entry->guid;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * efi_find_vendor_table - Given EFI config table, search it for the physical
+ *                         address of the vendor table associated with GUID.
+ *
+ * @boot_params:       pointer to boot_params
+ * @cfg_tbl_pa:        pointer to EFI configuration table
+ * @cfg_tbl_len:       number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ *
+ * Return: vendor table address on success. On error, return 0.
+ */
+unsigned long efi_find_vendor_table(struct boot_params *boot_params,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid)
+{
+	enum efi_type et;
+	unsigned int i;
+
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_NONE)
+		return 0;
+
+	for (i = 0; i < cfg_tbl_len; i++) {
+		unsigned long vendor_tbl_pa;
+		efi_guid_t vendor_tbl_guid;
+		int ret;
+
+		ret = get_vendor_table((void *)cfg_tbl_pa, i,
+				       &vendor_tbl_pa,
+				       &vendor_tbl_guid, et);
+		if (ret)
+			return 0;
+
+		if (!efi_guidcmp(guid, vendor_tbl_guid))
+			return vendor_tbl_pa;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 162dbd7443eb..991b46170914 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,6 +23,7 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -188,6 +189,10 @@ enum efi_type efi_get_type(struct boot_params *boot_params);
 unsigned long efi_get_system_table(struct boot_params *boot_params);
 int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
 		       unsigned int *cfg_tbl_len);
+unsigned long efi_find_vendor_table(struct boot_params *boot_params,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *boot_params)
 {
@@ -205,6 +210,14 @@ static inline int efi_get_conf_table(struct boot_params *boot_params,
 {
 	return -ENOENT;
 }
+
+static inline unsigned long efi_find_vendor_table(struct boot_params *boot_params,
+						  unsigned long cfg_tbl_pa,
+						  unsigned int cfg_tbl_len,
+						  efi_guid_t guid)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

