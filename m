Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0640470480
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbhLJPs6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:58 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:64640
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243478AbhLJPsL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If/R8wNdNcY8H8/wBfNtrv1TQVAgJZCxllef9O9nsF6jBe2oKA6pbN8tv1djCWFWyRaH5bqXQPhLZANw7yfPBtH3qLaGaTBcQ/2npC/TsDxoNXlZmppA4pprtMI3PToJVXSbuv79dc85X6vaShQQfF1PGLKvCPPUfqR7ezBYiI+GRD3H0OKGaSerRd0VvxBx2trUe3tfqtBTjQOqiUNBbRnpLqwcRuJKtUcnCg4KBvz+8n/mCWJ0OYt8bpmQ0nUCFsK7ZxGCHXTiBB3OyFgQSdEF22vNrRRmn7qnjn8O/OhNwXlh2gt/6+uSJQG6eXnwwPQlQ6ZYyOy2GtpgmUZRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vVFBLr2gNM29VBj/fFP61jnDmF8Ul0IAZ5L2Kgq8Po=;
 b=eC/KIz+4Pty5GiEl9UE6YFeOdgkEVcLqYp9Hjz6EhUIu5cOTzNAfGFV9wEEGdx9CmwAKqhUFRNnL4mhGOscCzY8vukPYDkVAboUkIDcjInF8n+yVMhDGYqtEj1FOgWAATMF/0MsV0/5wmX1w1GhZy87Xt72TgfIZixARj8sMIO4UUYAEPElDtA4Uyjo5exLhe8aFXJ+fScQ4QMDwArKMu7Ht4CI442yQBC9coZGCa+ZZX00WYCZX97afFwPKLTzxm+30zNNZjObH9PbwfqvFC4zovcIzloKVfPYi78CwWy3zrVUo+v8RffRBMfE8dq4yN2L7nuD4FDNkfM/0f4zt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vVFBLr2gNM29VBj/fFP61jnDmF8Ul0IAZ5L2Kgq8Po=;
 b=F6ZqRVKFLSY+syJ1IOJEPr8gIJ6ZjWg66plEnFs0yZ7MjBAixJUJI4Ogej5joPhsoG5jZ7034Vp/KtN8EGekyY6L2XhUJqL9NUSKZHNT1XHOiFE5JHSKymzt7WEMiaQs3GWQIk1dHAosjGGzuO/PiN+RcxYnxqBOvrUIrR6tLYU=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by BN6PR12MB1201.namprd12.prod.outlook.com (2603:10b6:404:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:44:31 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::b7) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:31 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:29 -0600
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
Subject: [PATCH v8 26/40] x86/compressed/acpi: move EFI vendor table lookup to helper
Date:   Fri, 10 Dec 2021 09:43:18 -0600
Message-ID: <20211210154332.11526-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84ef2d68-edb9-452d-a102-08d9bbf3f502
X-MS-TrafficTypeDiagnostic: BN6PR12MB1201:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1201CE90234685A1CC4AE6FEE5719@BN6PR12MB1201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJTZYCqWKGNX1pMOE8ADZ60olol0KfepmmLO9ze6rvCihVsCWsirFkB8vYbj7SmgzSQkqyBHS5NvUO9KYzB06zFFFj/kG36/jDZrXpdYlo7fXYFeq85mfOUBL4sGt84YAumqTgc5KVBuuK3i2LfQ4L15JnvL1/QizX9B1tBwWaxgg/qapeHLJacazDFXrs68F5OC4WmOBeCbZxq5QnOhD4SYfFNUdAXjzqv3mI41VU4U0CaqKfEUDo4nOA/ocV3X7GiBU6f9ESE737QKXhCUulEBpKpMFoo74D+AHn7nE31TAlm67XsDuHsT3M34rIWaC2gLxDukTXSsXdN8bO693fzCzXQkbqHnuu+sRYWseHQSVNB510gzzuDqCn0Ns7f+iTYcz7SJnnrqYzumTm4hTyHooD85RTHgEt1+9ZWUZtPirTAsGzzuC6JwkOFtbIVvUBkKPBZg4tHnrnLUUFs4RI7s9wW9bCKSG6M37l28va1BzwN5/salc9PCLsal+IBAMJlnHo+0i0OBT9JxQzxSNODAP9pa3lcIviHB7hXsTwZVHZ/egXIx4CGJG1Ao/SdN/yEuHEUwmBnPxkVB9XOheFhR8NXuKnJqzkj3i4xL4Q1wfrzxI6wRJx5bLWJzXT6Nq3BRs3tXQNvqJIOtsRF9Kft/ywONWVmoIV8uzYb4ZvrtdvRg5w3raxsJcb+1sSRVhFDW9ZA+P1uCHsiE5hLRtXErLwHyCUSVX4YCNFGcYZAUVA5AgEV6uI7ZnMEQLnqjjVrI13JpgSsA4klpjIUmS0XTzNIzUfqTB3OlAmItGd3Mluw8jvhjflKYZc7IX3rl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7406005)(336012)(7416002)(44832011)(82310400004)(40460700001)(70206006)(426003)(70586007)(186003)(83380400001)(16526019)(2616005)(26005)(36860700001)(47076005)(508600001)(110136005)(8676002)(1076003)(8936002)(316002)(54906003)(4326008)(86362001)(2906002)(6666004)(356005)(7696005)(36756003)(81166007)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:31.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ef2d68-edb9-452d-a102-08d9bbf3f502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1201
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
index fea72a1504ff..0670c8f8888a 100644
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
index 08ad517b0731..c1ddc72ef4d9 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -112,3 +112,68 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
 
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
+ * efi_find_vendor_table - Given EFI config table, search it for the physical
+ *                         address of the vendor table associated with GUID.
+ *
+ * @cfg_tbl_pa:        pointer to EFI configuration table
+ * @cfg_tbl_len:       number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ * @efi_64:            true if using 64-bit EFI
+ * @vendor_tbl_pa:     location to store physical address of vendor table
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
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
index 1c69592e83da..e9fde1482fbe 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -183,6 +183,8 @@ int efi_get_system_table(struct boot_params *boot_params,
 			 unsigned long *sys_tbl_pa, bool *is_efi_64);
 int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
 		       unsigned int *cfg_tbl_len, bool *is_efi_64);
+int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
+			  efi_guid_t guid, bool efi_64, unsigned long *vendor_tbl_pa);
 #else
 static inline int
 efi_get_system_table(struct boot_params *boot_params,
@@ -197,6 +199,13 @@ efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
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

