Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC32849FF4B
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbiA1RUc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:32 -0500
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:11616
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350776AbiA1RTG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLimwxID5SwIcNyfYFlTbrpnESEkGyZWxQrkmRWEuAzkd2CPI3umB8wSe6VtCrmpTEgH2yCM6YzS9zWUWbw1XeqFV4O4Gw6XzjyVIIgQznsLNo06GHsG4JnUx3dToJqHLQGNRdHLLe8aKRgwLlJPwKNIVHbVFdrzN16P6/RzCZiarbYzepznpurViaeTuwFUxKmHDaK4KNFx2ZCHAvj6/FotcPskwiQEHBZZ8K7tboaHVKYd6HoyyIGdzmRfqbQYCvHlyF2kdlAsY51VATPDrO/mm4UzjTQ1YvO2TwaAyVYlTi0kJBXQ4cy3We6CgKflIaDkixsSxbKjlYckFFzZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwB4aO1Uz5ZwL0Cy0hXWcHM1BKnthZM2OnL7UBWdnzo=;
 b=a+mcwy7sEWoQta+N0FoqYEGr0mnjZZAUY7Rmfj2TmLJILvXXjrhhCXwvQqtdLTsgqpsZu1vSM+Bwa+c43AIHxshF9R4SzWSq1WV5xw1Q+oq5enlH3m0Fk06UD6lPKH+2XY0F2PxB+DQulckRYRh+Hj2zXj78C61uH98RNGyHT6O2OVxpGGEWjkRjPXGrbxvjmc85iEYPxlghh653wTdV35J+d92xMQf+gfYJH/IzznWwrBJcUM32npH7uIiKCu2pnIIU2jFCAyoSwnSUIT63PLdp4OkRRhh4y8cNzzw1wjM40fyLGn4MFw7OQpGnJCL1VNaPVhb2Wa9pD6d8Dz83nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwB4aO1Uz5ZwL0Cy0hXWcHM1BKnthZM2OnL7UBWdnzo=;
 b=YHjVMzs8CVOJcO+EwtYyX4PlveofhhmB+D+LRxTMid5a3H6QH3j1oX/a3ZP+lT6Xb9CpddTapWgb3Y8gYUdp/czBUof5zplvlY0ODRqXWgH41/My5FQgrjqHQv0k7p+CY0zssDPBxUySOGTmmRg80fZuBO0j6BlE88t0G/6Pv48=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 MWHPR1201MB2527.namprd12.prod.outlook.com (2603:10b6:300:df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 17:19:02 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::fc) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:02 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:00 -0600
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
Subject: [PATCH v9 26/43] x86/compressed/acpi: Move EFI config table lookup to helper
Date:   Fri, 28 Jan 2022 11:17:47 -0600
Message-ID: <20220128171804.569796-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1e285ec-7178-4628-08d7-08d9e2824797
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2527:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25277FAFC3A39A7C45889824E5229@MWHPR1201MB2527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uH1XLmIaiHaPQBc68YsQqNUuoFsJBA74XWadIQiGBdZ3v2vGpvf//Z4FzWnpOE5a6lBM2PaHJJRBK1zpxPT2TltwkN/1/4utBuKNtOJF2JwJ9A8PCHeMswPLB+ah3NeWrgz6bsPEuWlm7PcswUQQEf+ctSD4S90WqCdxxhxxys8KqkEH360RDJwdc8SvZxKBo9npJBDBGN4I9AVOUHELujmOexkyyDCES8mrF4Ml2EXesz4pazj/zmd+Es4Vict04TQ8CEOcee+Frrc792eOMsWxH2XyVndFAkJ+7NAnRIVNrd5bpSYEVmP6I5+Ymkcr/P81MXbLszlsFTyQtJnD4av3g3Nu/a61MU1XIVMJxgKSv/LwT1XjQsuiPgqBBKW3EQWZUrJYipV/3jRm82/Y7wtJHYI1e28gF2x+RBiBtUJwHBg2WGERP9z8LpJdQnxJbk6h3Z4HZiZousSe3qDEqWh9leh1xxTd6KR7Tac3BIH2PpHlupUMOUn6fzugyfFOd4Ld8C6934m09ylzbTOKc+80ufMkm8LK74Lf5MFDTPuL/iYMhAzxOHgnPjxaOwLdW600UqWzoxZDBSSaYttW79Bu9j4hBdwxFhzlpotzTF6j2e88vndJQ72JDOSKdarIypF8SXp6ovl2h3QrGI2OX6EOtdFeyCsyo1bZruZeRskrIAvj+qJTbPAes5YN1tEfU+rlYPZbkH3m5CkuE9RbjxMHprxwyVzcXzxOQ3eN1/3p46b/dlpSxDalPAJu2oWtutLJDzTd9GSDMyC1SSg4W1dYjzGNQsoQypwYjxJyZ3ze9R2Egg8IFDrD5xDAobgE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(83380400001)(8936002)(70586007)(5660300002)(2616005)(86362001)(508600001)(40460700003)(7696005)(426003)(47076005)(316002)(1076003)(36860700001)(8676002)(81166007)(4326008)(7406005)(44832011)(6666004)(336012)(7416002)(16526019)(82310400004)(186003)(356005)(110136005)(36756003)(26005)(54906003)(70206006)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:02.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e285ec-7178-4628-08d7-08d9e2824797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2527
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
 arch/x86/boot/compressed/acpi.c | 25 ++++++------------
 arch/x86/boot/compressed/efi.c  | 45 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  9 +++++++
 3 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 58a3d3f3e305..9a824af69961 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -118,10 +118,13 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab_pa, config_tables;
+	unsigned long cfg_tbl_pa = 0;
+	unsigned int cfg_tbl_len;
+	unsigned long systab_pa;
 	unsigned int nr_tables;
 	enum efi_type et;
 	bool efi_64;
+	int ret;
 
 	et = efi_get_type(boot_params);
 	if (et == EFI_TYPE_64)
@@ -135,23 +138,11 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	/* Handle EFI bitness properly */
-	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_pa;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_pa;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	}
-
-	if (!config_tables)
-		error("EFI config tables not found.");
+	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	if (ret || !cfg_tbl_pa)
+		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index bf99768cd229..feb00c6b4919 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -77,3 +77,48 @@ unsigned long efi_get_system_table(struct boot_params *boot_params)
 
 	return sys_tbl_pa;
 }
+
+/**
+ * efi_get_conf_table - Given boot_params, locate EFI system table from it and
+ *                      return the physical address of EFI configuration table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len)
+{
+	unsigned long sys_tbl_pa = 0;
+	enum efi_type et;
+	int ret;
+
+	if (!cfg_tbl_pa || !cfg_tbl_len)
+		return -EINVAL;
+
+	sys_tbl_pa = efi_get_system_table(boot_params);
+	if (!sys_tbl_pa)
+		return -EINVAL;
+
+	/* Handle EFI bitness properly */
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_64) {
+		efi_system_table_64_t *stbl =
+			(efi_system_table_64_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa = stbl->tables;
+		*cfg_tbl_len = stbl->nr_tables;
+	} else if (et == EFI_TYPE_32) {
+		efi_system_table_32_t *stbl =
+			(efi_system_table_32_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa = stbl->tables;
+		*cfg_tbl_len = stbl->nr_tables;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 24522be8c21d..162dbd7443eb 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -186,6 +186,8 @@ enum efi_type {
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *boot_params);
 unsigned long efi_get_system_table(struct boot_params *boot_params);
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *boot_params)
 {
@@ -196,6 +198,13 @@ static inline unsigned long efi_get_system_table(struct boot_params *boot_params
 {
 	return 0;
 }
+
+static inline int efi_get_conf_table(struct boot_params *boot_params,
+				     unsigned long *cfg_tbl_pa,
+				     unsigned int *cfg_tbl_len)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

