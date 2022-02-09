Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D618F4AF96E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiBISOC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiBISNw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A86C03BFEC;
        Wed,  9 Feb 2022 10:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrWrq5Q68I+sBNUUBRe4J4t1qXt09rikTN8g/rtc59jEgCNUxVR8fwp3J+C4HLnVNhBd6bbOAfy2TaoAQ6bTxxqu8hcxhBD6WGFdhYIdBFpr4Ndroq8pK2zEp0jY9lYFOepjt32ql9e4gagGzR2FWXuKIcjmYExvnoyaz/Iq5AI0AyfM5MMLMFUDcjg/zSQs8/1Hy4JGOgNutoCOtsmj/dtH1l3KPf6riIHLZX4RqtHW69g217XLAOBY13O175rK9L3uVtEGWC7/8LmfvvdsU+fT+Q4v4Cwk67vGdR6Ealvxr1Bnk3wUprANNkM3CGhgLU9POLNP+cy96fU/7toxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=aC7fd9bpmPUpdfq9hgni2vvR0PZ7bBx4h5s0ytDMG6IlqJobEXgnvHC2jgDvTT2adHwukxJnK6DTkcG2gdo9UD5NfKk0gTdSr8cquXMU7J2aGfmYKm7dyuE5mr5yxfcT+szg+zZqxeb1MP6tnu3GvimLNrQ5T1aUY/pkO6EU4EgVx4vZ1VaH5L/RATosrL90piua9aGl+Qrz/qGbctgKHQ6iY7s7ObyczIy6XXEaiGpqAzXkT+21xdYf+wiJMXpbqUvUmsJudw0wzAhjNkmei6Yim/MzcQPaL8DGpYpQL+uJtWISwLr6Uh+oTzK9dfmmhInfppVUnn4IpLo9kIYvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JapXAys+V8GO+YHKSmj31uh0Rt5HgWdJJuYFZCRPPzk=;
 b=IuDbCttgjrcaxfKRqh+V867gyFy016NTg+lyDWPxxGlQrw9BRCT8W3qDLgqPgespMk/c09M75JF5hHqM1jMgm1sGVNZ8ROWMOgpjSTfBB9cjT8PKiHI6JrZ+sWLM6vC9DzF/9EWtgcfdCcvqmLywAxWxQwHr3CMB9Ij7Tswa2ZU=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:16 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::e1) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:16 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:11 -0600
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
Subject: [PATCH v10 27/45] x86/compressed/acpi: Move EFI vendor table lookup to helper
Date:   Wed, 9 Feb 2022 12:10:21 -0600
Message-ID: <20220209181039.1262882-28-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcfc64fe-8d9d-4fda-d134-08d9ebf7b47f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1921E04E5BA0EB445BBC5962E52E9@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Kb4aSIkqLygVKr3leVB3fM9lUZHYw319/b3P+2RZHYHA7SibOaHUq1Oijf579RjfB3hsawO2ju5HWF7d6U8G82Dcal0++0IWy4wk4K/iPXuspHKFdg5M2VAqtxYx2m3vjGT/hoxUiHskXL2f3yK4Xy1UwUAgiIx4qLrKBK7K7CwbjGM+q5unsSelxmKwqDsxexZg80IBXEA/LRt/0Zhnkt3DCS1fYEOwn8Wof/E8ElGscjImMcbjdYv4RZhxHVXixcHAPGjlI9xG7msnAkBlPWyZpxfYHcxjGrVWPGnPVy8OaT6q8BDtoWmreUQGQO0a1fY7v1MqDJa83LiWV3i+Isg2NP8zDUGP3q2YCD82RBxv0+bxCxMF4JdG54cev8hp2EjZ63UGhKhHwR9BZZ/X3bTphwoW261XMM3UfmkIJdiyEF03nmFcu8Svr1NX3s4Kk/mCH29mZ5CxHxlWZ+qa9Av+i5yihYiOf3NMG8aMyNlRdlxVfGo8t9NrvOV9nz1YNRknadk/dKTcHAeaJYPyfhc+MBsccED/NzYpsAI73OeXRoDhUbrRdtGnRjm8Jg1jTBgSdIZTJeMRY1Ak0c3cW10NrdNMhtATNtBH0TXGA1CQ6F7SeNrgvYdxit9N5wuNJjSxjaAn1/lzjBvfLHf3mlve38mJzuqfhv/nL6ChNhIBdXIBPBGcbIeFR9PJ5Jy8BwiIrXtGqzqEdFgZvZ6EpghquGBD07c+7C5bwRrqmM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(508600001)(26005)(2616005)(1076003)(426003)(82310400004)(336012)(7696005)(86362001)(6666004)(36860700001)(40460700003)(356005)(83380400001)(8676002)(70586007)(81166007)(47076005)(70206006)(4326008)(316002)(54906003)(110136005)(36756003)(44832011)(2906002)(7416002)(7406005)(5660300002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:16.6423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc64fe-8d9d-4fda-d134-08d9ebf7b47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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

