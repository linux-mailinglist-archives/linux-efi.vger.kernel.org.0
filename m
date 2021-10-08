Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168DC427053
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbhJHSJc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:32 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:8225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240055AbhJHSII (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1hJNdhGXQSbQD9LqJMGMuTZif0XNDeFwa6CoeEkRyUSFlEWnn3GvfVJyj6lmZI722/dPFjYZjlJkpEW3eRtvxaNtfkWsyRM0p0gT6EDFm1+VehHIwxypZ596vj3/sZgpUuAQiZ+OP6znBEmo3/jLTMYUX+qr/zZ6Yw36vcYU3q511kSwEaWgEYAfgX+KBuaa28prapvm0f+vX4FstgxniobnY8s9KMGFxrO/BZMUfd0Qi8bQxTirZ7vr1aNSFemG6KgCOPjrUxiMS7EDjHe5+sresLqWhDKKB7LKELBBuRywcwJJC3lEe/O1sREms/PjzvqGWgCLBrBQs/OkSVzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD1HF4+3H+NYxUVTlOYpMUlv/Q86dd3OFgcIXlKfn9M=;
 b=Ox8abJ5mrp7hSNISWAFpazYj4pllzpbdu4E2N5tIimhJ6ui9ExMFwWEm/vQXzDd/OqLtwZpztPLOPkBU/jKzj/5tzilwyqqWmgq4JxaIM3jsvwnWwik79ZmDBpQH7Gt2UXnugyLGjTmVSqP7SeKgYNAFxAbqim4jYsIoxZJ6uyDFzUay7GZyWVc9j+LlSUVbZDUFRRxzQzPG3nJUSbdlndEAXgOgabFgur7FkF+0IsG91tjQMH4jntemCH86PP1N45Nov6rAxKE3OiyycCkcjqmLBCnoR4J5pNT9Nc62W0NVx/DcrcsHK2eeYEtXRHvTYDH1+K8ysnXMM36TxlJ3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD1HF4+3H+NYxUVTlOYpMUlv/Q86dd3OFgcIXlKfn9M=;
 b=1YkXkYdxzKMEoaRJT9IGSWjv6+ZVATG4v9hL4YugDWMyp+oQCRbinCUx6mZ25ePqDR17YS0UhpfelMjjkAM0VBUtEapgtleTiFNSK9fKihdHxF04MhrMx50QVEmp4ejJE0fcu7b5KeY1ryoRI/iJedW9y9e8pVUmIfBO2LFqrbk=
Received: from MWHPR20CA0030.namprd20.prod.outlook.com (2603:10b6:300:ed::16)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:06:08 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::69) by MWHPR20CA0030.outlook.office365.com
 (2603:10b6:300:ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:07 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:59 -0500
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
Subject: [PATCH v6 29/42] x86/compressed/acpi: move EFI config table lookup to helper
Date:   Fri, 8 Oct 2021 13:04:40 -0500
Message-ID: <20211008180453.462291-30-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 359fab6d-ea3a-4be5-a5ea-08d98a864d3d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26801F8F85C02A850AB29757E5B29@BYAPR12MB2680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToWo+smgHThN0SqqsGJ3yU9nQdYGZr4tGgIxUI8DbCQBTywOzofV3toWxY8OEIIqh6/dsNy5VLn0SDaZiMSXHDxHdJSiWIbbH8tqfBtiZCRCfsvMIKOUzwt63uP7qiVpzSau89CSrs/9BkLzskrsSCtjgVuLjxuKxPJblqoEmBJIBdEIlpocojE+zablvTr99YqL2rtSkNuAlWjDbd6eUwd5HmtMWzRg/9dghRf5Z1aWmlXMQS/Ms6+hRXpcLLxCdRhZ5Yjxu9GkJqLP838PDlosUcGxECzB1ou1MdRuNCiIc93hKEHXCoH2Gk/u2fiRPnRoLBQihq+3OlVAtL/2w73TUQgc7SfsQlUR9naBR7X3eCMWDioJKAFeXYma0yyjFwrokMaOtePe45K1dLCO/KqPXZdNQz1XOeK2t6eXx3abIPCnMxrhkud1QbMpapxvDCOsRIGEePpWhRTbpqWl2eGS8b6nr9lxSHMyqGp3HuLnhLf2BxPqAlt6F59Yq1kVMgvODUg3wqXTyoLa4M2dKAY39NEYiLoA71Adg9m3t5yCUEyQRcQcSS8ASc27GvzjUT8s+3HfE5je1ht51P2YwwjzdPFKcuiv1/dGM/y3e2LLbhkoygPMYraxxUOajFjQrx2CBd+UQ+UuA4N8nXjfMWZY91GGhJmNGX98ZnR/JDQfZtqbOM4zSSJONdGa44ImicQdaUR7aE4YIb/1CH5ww0y1GqNmqThU5uVU6jZ6DKr17RjeiUIAofCQR+vGWS5p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(8676002)(110136005)(44832011)(82310400003)(83380400001)(336012)(7696005)(86362001)(8936002)(186003)(16526019)(1076003)(47076005)(426003)(5660300002)(36756003)(70586007)(2616005)(26005)(36860700001)(508600001)(7416002)(7406005)(356005)(70206006)(81166007)(6666004)(4326008)(2906002)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:07.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359fab6d-ea3a-4be5-a5ea-08d98a864d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
 arch/x86/boot/compressed/acpi.c | 52 +++++----------------------------
 arch/x86/boot/compressed/efi.c  | 42 ++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  9 ++++++
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 255f6959c090..d43ff3ff573b 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -117,54 +117,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
-	unsigned int nr_tables;
-	struct efi_info *ei;
+	unsigned long cfg_tbl_pa = 0;
+	unsigned int cfg_tbl_len;
 	bool efi_64;
-	char *sig;
-
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-
-	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
-		efi_64 = true;
-	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
-		efi_64 = false;
-	} else {
-		debug_putstr("Wrong EFI loader signature.\n");
-		return 0;
-	}
-
-	/* Get systab from boot params. */
-#ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
-#else
-	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
-		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
-		return 0;
-	}
-	systab = ei->efi_systab;
-#endif
-	if (!systab)
-		error("EFI system table not found.");
-
-	/* Handle EFI bitness properly */
-	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	}
+	int ret;
 
-	if (!config_tables)
-		error("EFI config tables not found.");
+	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len, &efi_64);
+	if (ret || !cfg_tbl_pa)
+		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 306b287b7368..e5f39b3f5665 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -62,3 +62,45 @@ int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl
 	*is_efi_64 = efi_64;
 	return 0;
 }
+
+/**
+ * Given boot_params, locate EFI system table from it and return the physical
+ * address EFI configuration table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len, bool *is_efi_64)
+{
+	unsigned long sys_tbl_pa = 0;
+	int ret;
+
+	if (!cfg_tbl_pa || !cfg_tbl_len || !is_efi_64)
+		return -EINVAL;
+
+	ret = efi_get_system_table(boot_params, &sys_tbl_pa, is_efi_64);
+	if (ret)
+		return ret;
+
+	/* Handle EFI bitness properly */
+	if (*is_efi_64) {
+		efi_system_table_64_t *stbl =
+			(efi_system_table_64_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl =
+			(efi_system_table_32_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index f86ff866fd7a..b72fd860362a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -179,6 +179,8 @@ unsigned long sev_verify_cbit(unsigned long cr3);
 /* helpers for early EFI config table access */
 int efi_get_system_table(struct boot_params *boot_params,
 			 unsigned long *sys_tbl_pa, bool *is_efi_64);
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+			unsigned int *cfg_tbl_len, bool *is_efi_64);
 #else
 static inline int
 efi_get_system_table(struct boot_params *boot_params,
@@ -186,6 +188,13 @@ efi_get_system_table(struct boot_params *boot_params,
 {
 	return -ENOENT;
 }
+
+static inline int
+efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		   unsigned int *cfg_tbl_len, bool *is_efi_64)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

