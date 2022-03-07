Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0704D09D0
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbiCGVhL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbiCGVgm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:42 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9189323;
        Mon,  7 Mar 2022 13:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAvT1sOmj9xtnXrZSRb77k8+TEHQlJMTsjJA0tOmAYbbhU8oHPDZ/cq5FbOfU8fEmNKBt3K48JNp9ZZZR8ab1U9i2SkDcUDrX50yOBmu/n4MTcZKwg3aAgNwwj6Vnx+2kmgVFEqJIJ3RVqiYWqKeaBWkB0xaqrHRKOCsG7PR6hfgSZq4gNIlyrcJ/5fTC6qTLZr0/CTqDbW5FjztQIAnFIuzf7PETO3GDOhxgSZS1W8AEFfpvY2FzORS3UONscLVfobKMglHa68u1OPhVhyqi3ousnDp5+U6qiBJG3AdyeRD+oaXpZPVNS3dOx8FZvCbRDc8Nl/ev8+MGOmoSTXDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aECr4lxRaZY7FAYkVXj8D7W6XkLP0iMx+fQkjtxy/z0=;
 b=nZYTBsPry7hkb+nYKyEWlJhqdolvZFqbivA59hTYAqxEI0lSWCC82bOt9FctfF7+m68LfBN684HkBQaSBA1l64clib3JgyMOFdDu406AwybbRje7vodyKm1LBBEQ3y16kB/2Hb21jr5wBcVmO9Bx0mR3gsBnFIzYCo6AGlXgrb8hUV1V2IlgvUDLHLIVUB5e1dIlVLZnSwfuESxBlWGwqkeeA0wIIJ1ks7N0NI2752ifg1edFSgy2gVitGur7Q9bQbjzEN4G5W54DGulJiMzz5hV/wQTO3c5NfaySeem5DdSZSZWjgCTFGmQ6VD1R1MGkFEfNG6YMpV54T4s6QD+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aECr4lxRaZY7FAYkVXj8D7W6XkLP0iMx+fQkjtxy/z0=;
 b=olsZx4r6YpsHtMCRbg375D/4+6DUgPg3BhZzZiPzvJ1oq776HYZyLO4NsUWYQsfQlYn1tlggyMEQFqv2RVzWHus5pbQDPB7JoySKP9+1mjGMJcgNUT6C0wdsr0e1Dprz19tP2XzXeZvR1gaQxA4lP8SCUEdDTWQRf5+s8ctJJ54=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 21:35:09 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::9a) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:06 -0600
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
Subject: [PATCH v12 28/46] x86/compressed/acpi: Move EFI kexec handling into common code
Date:   Mon, 7 Mar 2022 15:33:38 -0600
Message-ID: <20220307213356.2797205-29-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0450998c-fc57-4c5d-3778-08da00825a4c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41779D5D7DF052C36E716F78E5089@BY5PR12MB4177.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AreXsYzf4e7TP2m8A0PYvKPH+Vunb76s6wRAbI0G96FxGco4gJ6WP7XccJDhGLq9dz7SoJTkTp3Ff0EbU+FKoPbD648sdhdaSfUghVOFTGkyAX9viws4jrd6jScGSOytGmOShNugIJUNwQ2jquhD4Tgpd1fU6F1YulX6VvIptmEtlZUUGvzcaFRykPzw4EGFWyyNkyVCTO3MXBmTb3Vl/JF/j1JlP/jFaU384Lz/T/+icQgnQ7y00TphlEbr+eUeUCWZEUHE9PSdCP5GdaEEyIR2mdl877WCjcviZfJVa1L1yVD0coufKd+59KV23j5IntXt0N7rfzaXS7vPnrN3sLupydv4ydXZDPRGgpxBTyjdy1OAo5JDbBq6YgTtidf9QIkEFDAYbz0yiUgBEfR/cL4OQWNf/WN4Aysgg14AEDLVqZDEWdjv5zmoKF397tlZFo6NKfVzbnzy17rekhZH9kd5cCXSJ3GCyUEjRTH4IIPlgu/A14A1LFggSYeOAMOiysYDO3eoXf/+JBF+18tO9Zbpy1nv6FbxGuKBJcv8LZZv9kaqDio54ClNvwSEm71Zls8kFeZH6myITDPsX9EsZoysV/WX2pHzt4zV7KWhFvaES1LftlkpXu6rIUccCQkCwSlpIFCOMr8RISuup2xFXLXaFh5Q5KRxqKDdauLxCxAcyT6NqS5HBLszGjpAxdkPJgyzsNyWLD5cNxbut2IHsPyyRUzQIOqcvmXDwaqQibY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(2906002)(40460700003)(86362001)(186003)(16526019)(426003)(336012)(8676002)(83380400001)(7696005)(47076005)(70586007)(70206006)(1076003)(316002)(36756003)(54906003)(8936002)(2616005)(508600001)(110136005)(26005)(36860700001)(6666004)(356005)(81166007)(82310400004)(5660300002)(7416002)(7406005)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:08.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450998c-fc57-4c5d-3778-08da00825a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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

In this instance, the current acpi.c kexec handling is mainly used to
get the alternative EFI config table address provided by kexec via a
setup_data entry of type SETUP_EFI. If not present, the code then falls
back to normal EFI config table address provided by EFI system table.
This would need to be done by all call-sites attempting to access the
EFI config table, so just have efi_get_conf_table() handle that
automatically.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/acpi.c | 59 ---------------------------------
 arch/x86/boot/compressed/efi.c  | 46 ++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 60 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index b0c1dffc5510..64b172dabd5c 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -47,57 +47,6 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	return 0;
 }
 
-/* EFI/kexec support is 64-bit only. */
-#ifdef CONFIG_X86_64
-static struct efi_setup_data *get_kexec_setup_data_addr(void)
-{
-	struct setup_data *data;
-	u64 pa_data;
-
-	pa_data = boot_params->hdr.setup_data;
-	while (pa_data) {
-		data = (struct setup_data *)pa_data;
-		if (data->type == SETUP_EFI)
-			return (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
-
-		pa_data = data->next;
-	}
-	return NULL;
-}
-
-static acpi_physical_address kexec_get_rsdp_addr(void)
-{
-	efi_system_table_64_t *systab;
-	struct efi_setup_data *esd;
-	struct efi_info *ei;
-	enum efi_type et;
-
-	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
-	if (!esd)
-		return 0;
-
-	if (!esd->tables) {
-		debug_putstr("Wrong kexec SETUP_EFI data.\n");
-		return 0;
-	}
-
-	et = efi_get_type(boot_params);
-	if (et != EFI_TYPE_64) {
-		debug_putstr("Unexpected kexec EFI environment (expected 64-bit EFI).\n");
-		return 0;
-	}
-
-	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *)efi_get_system_table(boot_params);
-	if (!systab)
-		error("EFI system table not found in kexec boot_params.");
-
-	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables);
-}
-#else
-static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
-#endif /* CONFIG_X86_64 */
-
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
@@ -210,14 +159,6 @@ acpi_physical_address get_rsdp_addr(void)
 
 	pa = boot_params->acpi_rsdp_addr;
 
-	/*
-	 * Try to get EFI data from setup_data. This can happen when we're a
-	 * kexec'ed kernel and kexec(1) has passed all the required EFI info to
-	 * us.
-	 */
-	if (!pa)
-		pa = kexec_get_rsdp_addr();
-
 	if (!pa)
 		pa = efi_get_rsdp_addr();
 
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index f8d26db22659..ff2e2eaba1d4 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -78,6 +78,46 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 	return sys_tbl_pa;
 }
 
+/*
+ * EFI config table address changes to virtual address after boot, which may
+ * not be accessible for the kexec'd kernel. To address this, kexec provides
+ * the initial physical address via a struct setup_data entry, which is
+ * checked for here, along with some sanity checks.
+ */
+static struct efi_setup_data *get_kexec_setup_data(struct boot_params *bp,
+						   enum efi_type et)
+{
+#ifdef CONFIG_X86_64
+	struct efi_setup_data *esd = NULL;
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = bp->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *)pa_data;
+		if (data->type == SETUP_EFI) {
+			esd = (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
+			break;
+		}
+
+		pa_data = data->next;
+	}
+
+	/*
+	 * Original ACPI code falls back to attempting normal EFI boot in these
+	 * cases, so maintain existing behavior by indicating non-kexec
+	 * environment to the caller, but print them for debugging.
+	 */
+	if (esd && !esd->tables) {
+		debug_putstr("kexec EFI environment missing valid configuration table.\n");
+		return NULL;
+	}
+
+	return esd;
+#endif
+	return NULL;
+}
+
 /**
  * efi_get_conf_table - Given a pointer to boot_params, locate and return the physical
  *                      address of EFI configuration table.
@@ -106,8 +146,12 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 	et = efi_get_type(bp);
 	if (et == EFI_TYPE_64) {
 		efi_system_table_64_t *stbl = (efi_system_table_64_t *)sys_tbl_pa;
+		struct efi_setup_data *esd;
 
-		*cfg_tbl_pa = stbl->tables;
+		/* kexec provides an alternative EFI conf table, check for it. */
+		esd = get_kexec_setup_data(bp, et);
+
+		*cfg_tbl_pa = esd ? esd->tables : stbl->tables;
 		*cfg_tbl_len = stbl->nr_tables;
 	} else if (et == EFI_TYPE_32) {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)sys_tbl_pa;
-- 
2.25.1

