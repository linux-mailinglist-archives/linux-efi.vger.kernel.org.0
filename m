Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189554C32CB
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiBXRAd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBXQ7n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3706710EA;
        Thu, 24 Feb 2022 08:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/NHz8Xq5R7aWov1GmkUUHZy32cnjbxbx4DSuwUpv3uquI74+P8IIsIJihr5YIx22LTaRWq+yuDhLHrkhg/chnOGKyjf6Rd5HN07iTHUtZgejGuJbZlUk7DmYhPOkFqBeO0tfpx56OedtPaErk+IBq4lpm2hoDY3XzdVoH/3fqcU1q4LvMRwRUsZS1dpexFmgUG9SVbR31+L/EJWcHkLRnj4lkI8/0AUhHoBCfuCcm5OeCNAtbFMFTxXssTFRsG1uF6DGEqpBWpYWcOnHJZseZU+S5eD5H9zKt8DpM/Kt6jKFNh8MiV1s1h40BVzbLyOO66ZIKUEOrbwazrUDlGi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=FLP1pAuHS32qU1KQzOBNo3sEDGhdqZTzXmLfMLxItv3+Wg5Xe3ZzVZrPzxHbmh7rmVH4/DPHL6aYxel5XrHE5Jh2FyFbXWP2WBGHDCnPNETBtn8SJBVPr5fhiqaqEmrbCBAIrDXywWmWncE6TcQSmdVzz0/wK3HuedNsmfGUjP6hK1n+LuXdBk/prPJesKEf56SheG7ITeJwBTGDcNivDyLPJ7zP/3KkCpscskgXd0Wdvi3fwxHUCJB/F9WYINE5vuL2/WSRRFTDpJa3m4TSW/08qAvrXUwl+tQT1DYSQT4dbDMELY1Sq9hYLl/Nf5jM1+fQ/MXVw2AGXQYhX8Fi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=MuClEOhGiOj66Mq8XlycFSjMv2yC3zXHqUgLJacG98Awyb9FZT8H1/uxnvzj+OpCSo4OUQBWeuea1CGW1z9m14Kmz2wgmHiTtdqkt830xQsWuZohoPoOtl9MCtPZXBI5BlsmMfQa1mgWkv7w29/3woZZzS1Eg+ous/RR0yJjUew=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 16:58:40 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::5e) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:35 -0600
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
Subject: [PATCH v11 25/45] x86/compressed/acpi: Move EFI system table lookup to helper
Date:   Thu, 24 Feb 2022 10:56:05 -0600
Message-ID: <20220224165625.2175020-26-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1316d3e-b336-486b-0e37-08d9f7b6e7f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB353594747D9071494949085EE53D9@MN2PR12MB3535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2fXPg3yXk/tUtdd5rS7EGoR+iYViCFJGKHBCqzcO7btblYGRiCZ+H19+t6B+yc7SH2+dlFzIf7iD8QGftWcNXBoPd0piuOjq7Yyymk3Sv4yfapOXNOjXpoK7h2zaIO2yqgxzVZYeCbuEGwhSL8LQ3JfbjIddSooes6FcWEj0792/Fdz1Qm3HWWKA3Y9Yp3pjMz6iiU+GFO+NQbiE9AzpkFnKL0AdwgAoy0uWD6vAUIqiZukMW7QbF/+Jy5ZYwgbbGdOkebdvszVuBA5amLRxMbPRepNdsvOzbrKfS9qYPYDNJNy51B/KfGOvugKsyt8ua6Pt9AsD0EoObRls9lZ8INi1hBCsylLcMbLB5MQOW02D4b6ByzhYtvVbuc6Yt7zj9xsU4m35r+R5xd2AZ6xU7E6QSJahxQbUyaj1Vg6cTuCGIyj8xklUryJ+mgs9RASvToXDbY0OAeuJb/vatCLPucFUFQPzSIepk0QFAOk7dL41ARxo+ItRuFY2e8aZ0Da2IMYDo0oePu5vxmNGFbzpnAxSQ8/ZpsLr6bNBrRlnNa0bWyfCKgk7R1r/zebn/drIrJB8PKQJTPZkpuxXNmhsvzkzfkJ1GrOZJfVmRyzznVv+TVrjBzYjgo7WE3KqaFbTMmT14a2GRMaitBE1JCtk2dsk1mB8TuJecXN/ixQ1/6Zw0uvK8TTHyOA0A77Z8EDHGSd6D4WpTwtY6Ec2T5q/gg8k9AZivl0dDVofFOKlX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(81166007)(82310400004)(86362001)(7696005)(40460700003)(508600001)(36756003)(110136005)(36860700001)(356005)(6666004)(47076005)(70206006)(8676002)(16526019)(186003)(2906002)(5660300002)(316002)(7416002)(7406005)(44832011)(8936002)(26005)(70586007)(336012)(4326008)(1076003)(426003)(2616005)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:39.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1316d3e-b336-486b-0e37-08d9f7b6e7f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
parsing of the EFI configuration. Incrementally move the related
code into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/acpi.c | 21 +++++++--------------
 arch/x86/boot/compressed/efi.c  | 29 +++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  6 ++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index db6c561920f0..58a3d3f3e305 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -105,7 +105,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	}
 
 	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	systab = (efi_system_table_64_t *)efi_get_system_table(boot_params);
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
@@ -118,9 +118,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
+	unsigned long systab_pa, config_tables;
 	unsigned int nr_tables;
-	struct efi_info *ei;
 	enum efi_type et;
 	bool efi_64;
 
@@ -132,24 +131,18 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	else
 		return 0;
 
-	/* Get systab from boot params. */
-	ei = &boot_params->efi_info;
-#ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
-#else
-	systab = ei->efi_systab;
-#endif
-	if (!systab)
-		error("EFI system table not found.");
+	systab_pa = efi_get_system_table(boot_params);
+	if (!systab_pa)
+		error("EFI support advertised, but unable to locate system table.");
 
 	/* Handle EFI bitness properly */
 	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
 	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index bad0ce3e2ef6..72a81ba1f87b 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -48,3 +48,32 @@ enum efi_type efi_get_type(struct boot_params *bp)
 
 	return et;
 }
+
+/**
+ * efi_get_system_table - Given a pointer to boot_params, retrieve the physical address
+ *                        of the EFI system table.
+ *
+ * @bp:         pointer to boot_params
+ *
+ * Return: EFI system table address on success. On error, return 0.
+ */
+unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	unsigned long sys_tbl_pa;
+	struct efi_info *ei;
+	enum efi_type et;
+
+	/* Get systab from boot params. */
+	ei = &bp->efi_info;
+#ifdef CONFIG_X86_64
+	sys_tbl_pa = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	sys_tbl_pa = ei->efi_systab;
+#endif
+	if (!sys_tbl_pa) {
+		debug_putstr("EFI system table not found.");
+		return 0;
+	}
+
+	return sys_tbl_pa;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fede1afa39e9..b2acd3ac6525 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -185,11 +185,17 @@ enum efi_type {
 #ifdef CONFIG_EFI
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *bp);
+unsigned long efi_get_system_table(struct boot_params *bp);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
 	return EFI_TYPE_NONE;
 }
+
+static inline unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

