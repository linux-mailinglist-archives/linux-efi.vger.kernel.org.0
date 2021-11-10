Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC644CC06
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhKJWMz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:55 -0500
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:44304
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233974AbhKJWLp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwttapUBp4aNAv0qHD9bL2NHiWoPnsEFZ0ej9aq/XwjuHFD1zlCzMH9C/mzzXA0umNcpwUXmkvAKjUvD48Sjua1xpYgqQzK53ZUm9AE5VBtjlcL8SZxjiJbkz3MCnZn7APUz3yh4DVrFpF82C6RuLGpe36J8Q9tjnGb5aqDVJPFax2OwYH5ISZ1W6ysY01jiVcXRKmorZH6wf/80udXQpZdmR4zTyC4gEW60QpdBORGpAy7hHGgoX1eSXa81wJzAtl9fWjmplFNY5jXOcEVRtu4yDcNeWn5OIZTnAmRbh5nWDRT+AhGTYQWVUm+C9GGjmfR1w5CLkQVr3ZBjQgzcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EJYlhSm9Y5DMRGToK+jvFwKUYTRJCNN+76vC1AD0KQ=;
 b=MqnaeESJ4tgAmLaY+tXJW9LHHGNgxpiMPEGpRQPRlkGE3kxL89n9n5cm8PgAue5I8ojqXxRfkF5wEqZ0d3baNsrXR5vjpwyPZMYcLOtVKLYnMGOzUb3tP9s+1bfI2V1B6lm8J6IXk30DUuYFEWAkZF0Srxy1EvYXDrrRPGE3Wr0mPvDRBrPUCBG1gRMtUUxOXwFBWyAWFeoov9ArzR/aMbtO7S4HWTaRx7mP+4wYItQit7D+WguArv/4O1MAfMGwkALvALiWyTdWWR1/itrEtIFxnzywBuQgU7e/1MpJbR6naNIm4rXjs6sIZy3iy8j78Ff7ivMwTKuBBFlbiIdYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EJYlhSm9Y5DMRGToK+jvFwKUYTRJCNN+76vC1AD0KQ=;
 b=w6aBqK5/qEqIACx0833NX0c1Iuoivfa8nxNrLgm9MCqEaR3St3yZTELobEQZUjvU3EyA8NmywrPcfzuxUQ8CTEnNQ075umF7nBdIyR1u6ohpR6xET5pAJOJ56BHbmJUiKWeYa/L/fUPXx0kbF/1Ej3Av9Hp6ENbLxaxjMngt6dc=
Received: from DM5PR21CA0019.namprd21.prod.outlook.com (2603:10b6:3:ac::29) by
 BN6PR1201MB0258.namprd12.prod.outlook.com (2603:10b6:405:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:08:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::9d) by DM5PR21CA0019.outlook.office365.com
 (2603:10b6:3:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.5 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:54 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:42 -0600
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
Subject: [PATCH v7 31/45] x86/compressed/acpi: move EFI vendor table lookup to helper
Date:   Wed, 10 Nov 2021 16:07:17 -0600
Message-ID: <20211110220731.2396491-32-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45bad744-0be5-42c2-c252-08d9a496afb1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0258:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0258A8C1C6EAEA76CE0E078CE5939@BN6PR1201MB0258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCUiCny5TWok58/bzKmHGdr3EW11do4hGgCIWRAGGTh+TQzJRA+ytFlh09zwNjTShiYFZUB6dJMzZEJchKY7OLUpH/6KEaOUVQnuWujJmTtW2hAK6fpxQrP9+TytnUo2FjHNNAxbRGDhAWHOVhG/p1ocpZtEwgUdJTnL4cRhPocJLC1EQvqxe0bBgj6+I4rHQn9E6awc6bRqA5aky/rbLiWOMtnX5fN7+yu+bWr5vQD1OLEAFo5/PUbbDAK34HaG+u5RCUACLpSG0iR6AxMmtTz6bYarsAnB4qA1yyNldd8dpbHIthCG26m0FHycKQDJWqzwjOcXNNFdsIMkWn7GOQ3yK4qMCoAE6nJhkPmWktkh/FP8sb1yp+AGY1bnbFxUtJLdX+anSJtfgn5lhfHulUhRpziT1+uqQLFxwo/VQ+FBonOp0ylqYhqznJWZ3+YuU4CQ7O02sLv1PX31vMyfTafmcUGUpmiVRT/8EjgBEasfFZO5OS/mEqTNG85Wu267iC00HOrw8EosW+zPsuILkUGDMgRQGadRZcxCpqa7dcOhlBX7U3vePXsYNwmmFPLzXv2D23O91hL/nrz/wMFUH2n5t6TJoSYM6kX+Ra+C7AxytkFJKr38h0RxFD37fisnGtjnaUl6iq76nRCO+fpfgP/GsSjhBGFj+JZow7uiVrgV+q3MSvaxrX4Ub+zedTO6GKz4HOxLynof+4wyV3DoAHugTigP6Y9nt1SZRrmB3myVNyJORMIuonGqT54GyxfP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(1076003)(336012)(110136005)(36860700001)(26005)(44832011)(426003)(70206006)(70586007)(8676002)(7416002)(83380400001)(36756003)(47076005)(7406005)(8936002)(81166007)(5660300002)(2906002)(7696005)(6666004)(186003)(82310400003)(16526019)(4326008)(2616005)(316002)(356005)(508600001)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:54.8558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bad744-0be5-42c2-c252-08d9a496afb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0258
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
index 4398b55acd9f..db01af5d9a4a 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -111,3 +111,68 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
 
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
index 074674b89925..bb2e884467db 100644
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

