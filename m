Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287F4D09D5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiCGVhL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiCGVgm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7BA89331;
        Mon,  7 Mar 2022 13:35:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci2blbMY1Uss44qhQ40rF/cN3DTBI1o7emmxuGj2EuXfeMfrkEKJXccsF3rCJFySShADJSJ1TsZ7C22QfLXbqqC20n6ajoffehZ1yjyVerpiGfWFRn1L7sF9lE2/TEbWQDEwr8q6gpGqmZwI+tHuOCxo1t33EzURRHDHX8kGuQlHw3UiSK+VhxV2AC1LEABH1bh3r98OWz4ACkjpNFUwAXOWhANyZKz4E2IuccGF0JA5Qh3EjnwQZTAWIF088Qcvkt9kUs7bDEZ9XYQZhLiuTwNAqCTpt4RkRqF97VZivRp3CwO7ZRc8J1Cike67aMx0JMiqkScAX1iVRpMMD2rDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=VtbrXh2hjnWWHhlFUDAgj2n4Dl9YpOMG+kUfenj3dl5CUg5OaUl7K1xXCZJbJHBUolP00gQ6BJK1K9Ex4yByTgKwypzreS0bsO3h2I/jklBiz9gObGLp2A+vY8e06zOwHXfURwJDvOng9ehBh4+4ZzMBIx9CsJKES13nDHNaj36506j2MVeeI5UYOTiX0I5pwDHPIM8NKHx1sjiX9J4mWGbLgE//ip72OBA9Aj4C00ElgGxigGTi2gOmG5SsE6q8V1JcCFgKEwUxa0Pkx+Cl8o5hpnKPz9xjQz/B4yP8qy6RSbC1XXy4NxIr5ECsoxrFiVePschj0ub4O+vWnMm5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=4RCtOFH5wNomzSdi4EmfKqA7Mc28lXrvVArMh1B63JQHm1VMqEOGYfwc612aY/s4VQE+nyoSm13S89CjfkZqWdSzX1XHm0Y+NkT985XraqI+XtWVuaQ+Tt4+PCSVZkIwhJ+aDjMyCQ0MemTKGlqRUA4azvQQXHHeyldA2VoyjoA=
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:06 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::24) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:06 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:04 -0600
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
Subject: [PATCH v12 27/46] x86/compressed/acpi: Move EFI vendor table lookup to helper
Date:   Mon, 7 Mar 2022 15:33:37 -0600
Message-ID: <20220307213356.2797205-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1701498c-f350-4a6c-a212-08da0082591d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4942345C88C4CE1C0950313EE5089@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTHoLABB6zVui5GxAbegpiUEDeZ7O77xTEIQnHynIj+Rg5m29lwml1dDUHve9a0vQLhp20HiqKUz6+7fVN4hWlo6HhbI11VT0+Vg/ggQJ7B7skExD7ynHS3qnRy4HHPNSTE6CKiSnEBArr45+6xKTW4YE1g51MEx18tqzo/6L1xh1VCr2ace7xwLgHcYObW+PeZoylcfni8dXkK9nPFGu2v0l0VCuQIKqAUdO5pd/xB+sWeOKJiYITSroPt0yli1F3DHkBtebg67MMcNzQk+VUJ3xWvHcoOyPO2vzeO8Txzb1E6vZSDeFPA2wgcgnKzpEQvNye7+88PikoIx/1/0EkYQB6hCEx5JKYMtSPeKeqqaDIxpdPyJdI1yPLgJvUXkBIL1VGrxHUviuoGU9Y8mI6Yj6TJU8EHtENG0r1mTplydpsBOs5zyEmW8KRd9LgkjMF5lW8vS86LtxwGP5PnKT5w95Vfe2PQOVGijoFisZn7s8lMb656GYZnZ+hOewzYAW2JMm7cEeaNT0dY2zUjtQGmtYOX91IzvrFjAQPIxT3ui3ukUByrTwd6rS1KzeP/1ouZK6GgwZ0INv5EKxXdb2Yv3DkT0rmqf6nSkbFZNpdnLevi0TKreLFwjUeHTBs3KjeevXK1Hxvsvqj+8PRW2c8yQ+oGly1ZyIwSFVnKdReIvY4FOQJgdHJJ0HadIO1+abmpjY6WKx9wuzBdbz2nCioD/atX9rqu/QWTw2gZN260=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(2616005)(186003)(336012)(83380400001)(40460700003)(356005)(26005)(1076003)(426003)(8676002)(4326008)(44832011)(8936002)(7406005)(2906002)(81166007)(5660300002)(36756003)(7416002)(110136005)(316002)(70586007)(70206006)(82310400004)(86362001)(7696005)(6666004)(47076005)(54906003)(36860700001)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:06.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1701498c-f350-4a6c-a212-08da0082591d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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

