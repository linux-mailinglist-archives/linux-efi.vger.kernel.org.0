Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC44C326B
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiBXRAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXQ7o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161727EA31;
        Thu, 24 Feb 2022 08:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXuHgSyWtmoG+bfLvUQBzDblbEGnomT2ttz+6s2gOVSc2d96AWNOCLdlTD9srcbsZmPfw+83BQTPJ6/ankdnWYBlqgF+Hvb5YmLf4zA/DWh1aWH/Vv3Y+OIA1KCkt1E+NL6ipMeLYhraRSS3bFL9eP3mpO8Bt2x41cdDBpsn6ChA1RGIACy0YHTczr8igcVGXKL52cH7fr5LrLHtHMgAAhIfPXLj7oN/FjyiWygTimoFWgIJ3WhqYt22XMaRYBlsGaTUaFl5G3xXEzmrUGANPkkjlzMddQjuYgGRJqvl0e5mcexDW0f0Dci+ku9C6h+T+Qa/zrS/cnLetba2/Qo6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=R7ETg/RM0ypAJgVIGRUzLR0IBFaGW9H0w701aS6xuzBDVnHAbYlFN4TYXLqH6//mUaYNrCKvVqr6waDVcQrQU2JE8c0yTPTDPP1VzOwhWsmaROcIitfirVn7qbUrXK/BTbTGMtRoFjslQj79M3/NQBpkIHRB2jZCELqJw5z2RyzEyYLqBO0pjGJRSr0/bSLIYOGXxF90VcRAEPWpX616qBCGWCuZhTjj9+CFCTGCt4ZdEOkWKkbup4oFO4oP7Go2/tYomPJioocJw8hRR/YPAbeXsPrqYnI5HOh0zPa742lyUXWXTB8shdns5Jzkx76+jdrBuUzb2SzovGYb3dVxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=Ss0aIzS3IYYJc6UzHMoTj3cBUIofZVPTHyQa7LCFfXcsbSDdTwbwOXKnzb/vkKFD1OKbL+pRtUrZWTuTkgvkTctPA/ClMf7/vk559mNxNj90vCqewBhP/3G8Gou/XO6R+0Q8O2tzcA4qeH01IWa/7mkhzvEvBOO5JXjZqJ8Oq54=
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.22; Thu, 24 Feb 2022 16:58:40 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::29) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:37 -0600
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
Subject: [PATCH v11 26/45] x86/compressed/acpi: Move EFI config table lookup to helper
Date:   Thu, 24 Feb 2022 10:56:06 -0600
Message-ID: <20220224165625.2175020-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 877f7366-0ef1-4c83-cae5-08d9f7b6e872
X-MS-TrafficTypeDiagnostic: DS7PR12MB5910:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB591042F999BA9B45C9E03DFBE53D9@DS7PR12MB5910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUUfLUUNExd6uJRAtaArym69d7kT5IxCblp3CsL7kiNv4Klkm6rKTTxVQxZ7YBSP2yaer/xZiJVK8vKBVO2STWsxlri5hzxE2DwIJXlyaOYya3vQyHPWTwQALAooatt7ANqKyeITuybidaR7/6W5teZ8PjBtvBaVzVtLtPkRhMAcVqpwo48XX4W8VDYdXkRMW4bQuIAcub/Y7EJyOMqhpIytnXwf9/MWFbAKZW0ADxMTNE+KsceleiQB3A8aA7dLxn01djdptsiDlNNVUmuspS+kmbovw3VOeAe6EWMpjYHATr4dsDkb7/WuN/6MzVm92wv+VxrYXvipU8CsqtrPOnLVPIJ4H+/MESEXEi5QKL0E6VME+vU4oD9bpfKY6W6Ng7p5mIgZbD1RxOHp4bApR5rOQ/EZgElD0v0jY3d+JnfC/V2/uO5uvHzqMzElxUuUfmlZAS5Gf2GYj5djYq6QQkrS51c8jqGgKhXFQE8YF5f+9LLGVU0qj/KMEs5sg3rI0fDWFdvZxMSU2gcLaKTsBhgsIhx056xZk2yoin8zK1kxnzIMsLcneIsrty25VdETYhxpY7reQ8gTEGukSi5meSmBSUc6gQzNQQJfxX/4hT05kSUnDHJO/r1RdPctib2cYEZJJQnMBqOCrGuWvyvvbxUEjE9bLVB9ES67+Vixp8QCvXlTNzbrgjelmBkfXP3sf7lCUsvwQ5PpA2NpV7PN2VpszLDsPqEgAQ4i9mgDp4s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(110136005)(54906003)(4326008)(8676002)(40460700003)(356005)(81166007)(316002)(70586007)(47076005)(5660300002)(70206006)(82310400004)(44832011)(36756003)(7696005)(2616005)(26005)(7406005)(426003)(1076003)(186003)(336012)(83380400001)(36860700001)(6666004)(86362001)(508600001)(2906002)(8936002)(7416002)(16526019)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:40.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877f7366-0ef1-4c83-cae5-08d9f7b6e872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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
 arch/x86/boot/compressed/acpi.c | 25 ++++++-------------
 arch/x86/boot/compressed/efi.c  | 43 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  9 +++++++
 3 files changed, 60 insertions(+), 17 deletions(-)

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
index 72a81ba1f87b..70acddbbe7af 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -77,3 +77,46 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 
 	return sys_tbl_pa;
 }
+
+/**
+ * efi_get_conf_table - Given a pointer to boot_params, locate and return the physical
+ *                      address of EFI configuration table.
+ *
+ * @bp:                 pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len)
+{
+	unsigned long sys_tbl_pa = 0;
+	enum efi_type et;
+	int ret;
+
+	if (!cfg_tbl_pa || !cfg_tbl_len)
+		return -EINVAL;
+
+	sys_tbl_pa = efi_get_system_table(bp);
+	if (!sys_tbl_pa)
+		return -EINVAL;
+
+	/* Handle EFI bitness properly */
+	et = efi_get_type(bp);
+	if (et == EFI_TYPE_64) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa = stbl->tables;
+		*cfg_tbl_len = stbl->nr_tables;
+	} else if (et == EFI_TYPE_32) {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)sys_tbl_pa;
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
index b2acd3ac6525..8815af092a10 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -186,6 +186,8 @@ enum efi_type {
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *bp);
 unsigned long efi_get_system_table(struct boot_params *bp);
+int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
@@ -196,6 +198,13 @@ static inline unsigned long efi_get_system_table(struct boot_params *bp)
 {
 	return 0;
 }
+
+static inline int efi_get_conf_table(struct boot_params *bp,
+				     unsigned long *cfg_tbl_pa,
+				     unsigned int *cfg_tbl_len)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

