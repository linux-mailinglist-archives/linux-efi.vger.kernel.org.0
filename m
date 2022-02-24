Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212A4C32D9
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiBXRBR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiBXRA0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:00:26 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9F62129;
        Thu, 24 Feb 2022 08:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvPYWbXy/lxayS3a86LYA8s2a3x3OqL8SRR+j7yKaDeQCDI3tN/yK7m+YiGu2VeRvim1ouSi99Hq0IREuO+p9I/LuvW0gaeaxvoaQSclFnZQ5BELh5keo41GUZnvFKZ+/DGe2xZWI4yo/qijeuQuW62JTWcZlhMhGBk2zTs/N3n+0K/Yo0VqdoR28NtmttBur8G8McBXTEp4S0FKIt5jFPtelTXWTvwCLdn1SCNfuU/gvyu9h2ln20mdCjDoys7z2mw7UQ1ZXBognwfD+o8EZDG4nU8NXBgQdoxoEPXNvD1e9zMycLOqdv8JF3SGycXHqQjcqPOGeXy418QsJvSqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=cB6blG51c+QYybV7WWT35brWBg8BVrbRvseXQ2CYpRaQfQwx1xEkChj/w6IxFXXEVnus+mrG3t5wrlWihwVj2XK19eiSr+F+QSNjl8g7cFLfcPabqHeeGp2iJJDmku7PtP9q2fbmz/qi0jQQ4sDYGHMI/8+BMu5MfauXUp+XDUxrqSCLV/RNG2YzW2ZAyOjBa3lOagSDNJ4aSSl/3+sHZZKY080Nz3h41+j9OvDRFXYjUkM3883oDsykElMIJBab1Dltb0yj05a3AAqbq+WHTbzD77tSWfs0ZOmZxTDRtrdiNo2bP3OreEgv3hmMOKOSObK8MCzU40qut9flVqzXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=lBapBltVHV/1+D5jHWbQFppfxDAWjpPefetzao8XU2UT0a/WY/0ypEwOyY3c4ShyokwheQjIoaerNTclQ5KtqfnD3AlwgDVc+FsSxWx2K5Ao/xDwqNhZulM12pjjhHKLP1k6GLG4LbT2ZDKydAdBN5D3wajDPggZP7gQ0d6fo0Y=
Received: from DM3PR14CA0150.namprd14.prod.outlook.com (2603:10b6:0:53::34) by
 MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:58:43 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::1c) by DM3PR14CA0150.outlook.office365.com
 (2603:10b6:0:53::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:42 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:39 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v11 27/45] x86/compressed/acpi: Move EFI vendor table lookup to helper
Date:   Thu, 24 Feb 2022 10:56:07 -0600
Message-ID: <20220224165625.2175020-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76594fe4-1bfd-4b76-3cde-08d9f7b6e9c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679929E96C076712C755B96E53D9@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: em00kRAzmbzq9UtJ0VB2WupUyaoK9Euu/nHRdxRgZ22HMI8hb818oevT+WJsy8P+BJpsRhd9pjkLfN/K3eIsb9gZfaZGZn4QCARz8aZfUp1kPE4o9JiBefZws4xVJxAjZa1Rm5OuVEItLRPNjX2itJI4OLTRpDP0bWhaUJxaocUfOvrgvQKs1iJ/UkxYCixMyLhN6C1ngKG5TFoiXnqnbqZJoqkm/GkQmtBavlCcc753tL96b02wSGq1i9PWE3DDOppIp8EF0qIE1NTsxecda2LUuPbMFy6kQo1ur90/KWgB69ckggIJiFikAja0r+yw0H+QtiwAZCvD9Gjkdb3/YLKBmnO+q0pQxkbtHhrduFWsqoxwziJbxGEMXOSB75jRaxg677pl8dGirAZLeA6DMzKvVqClCW0WQyLB3sQ47mHOIf+vFCnyL+Ik3xwz3JD8ZMW/g0pX2agg0C3rhgjUQUMxqwX33TDYUtCltONILs2DgdyyaqLvts8rQfrev0e0GT/CkGZ48OE60z6rOOniCjnUU+VIFNUM6shOvyjBBPDARI/UentE31tsBiL7n9y6A6KLAY6sqEeTT3faDrtZ+5K6Yr6xe0vcYgk7Cs5OyTcHflHRkL62X82tV2KU+ax4oftfAJ7wFb3Mxfwi9b67FUawxp05dDcI3TGNnAR07D2RNUrDheS8OybuW24xEt4u/LhzWzdqTb5TMbIJRGKht9IWkLM0ImMWUgxjv8YlnKg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(47076005)(44832011)(36756003)(83380400001)(2616005)(426003)(16526019)(40460700003)(1076003)(186003)(336012)(26005)(316002)(110136005)(2906002)(54906003)(4326008)(7696005)(86362001)(70206006)(70586007)(5660300002)(8676002)(6666004)(7416002)(36860700001)(7406005)(81166007)(508600001)(356005)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:42.6537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76594fe4-1bfd-4b76-3cde-08d9f7b6e9c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/acpi.c | 68 +++++++++++--------------------
 arch/x86/boot/compressed/efi.c  | 72 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h | 13 ++++++
 3 files changed, 108 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9a824af69961..b0c1dffc5510 100644
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
@@ -123,15 +106,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab_pa;
 	unsigned int nr_tables;
 	enum efi_type et;
-	bool efi_64;
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
@@ -142,7 +120,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 70acddbbe7af..f8d26db22659 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -120,3 +120,75 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 
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
+ * @bp:                pointer to boot_params
+ * @cfg_tbl_pa:        pointer to EFI configuration table
+ * @cfg_tbl_len:       number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ *
+ * Return: vendor table address on success. On error, return 0.
+ */
+unsigned long efi_find_vendor_table(struct boot_params *bp,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid)
+{
+	enum efi_type et;
+	unsigned int i;
+
+	et = efi_get_type(bp);
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
index 8815af092a10..ba538af37e90 100644
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
@@ -188,6 +189,10 @@ enum efi_type efi_get_type(struct boot_params *bp);
 unsigned long efi_get_system_table(struct boot_params *bp);
 int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 		       unsigned int *cfg_tbl_len);
+unsigned long efi_find_vendor_table(struct boot_params *bp,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
@@ -205,6 +210,14 @@ static inline int efi_get_conf_table(struct boot_params *bp,
 {
 	return -ENOENT;
 }
+
+static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
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

