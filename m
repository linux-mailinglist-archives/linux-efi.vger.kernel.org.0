Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5A4D09D4
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbiCGVhH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245703AbiCGVgi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB289301;
        Mon,  7 Mar 2022 13:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnS76AMyI2tVdv4+fOu7E1ilkph540UTRQRw2gShrFVpMnpO6SLZMjH3sav4MZv4VQOz9bqATYgevsxd9nwtTNaWvMSRdp2OnzLzenP/18xiiXfPTOw7qYGdVYyddcJd3z+pp8OyzN17Li538Xd3KXo8phj8XDb2Hgpo8qbuUdj5OBL0aha7LheLkSGxdjDgKBCUnAHCpQVePmQ7f/NMxncCUejaVt536PTtssS0JK349VVvb1db5ht8gfiKx+ps3zNXtsEkZIlBgFbwV+q74kzdyHa4bInyxf/eFTV6606kE0C+j+nw8SWpb/WFj3yix2TmM6gafS83gWiFgScv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=Cf9vWCTAucNLUyskRAz17VjGrzC4zyQ/PE49bDVxBXhHk6UumkIHzNWFnRUMbh/ja1y1BZEwSkF93fod2W/gAfc6iqs8SU76UQxRVNwbxFxsv9/pE+rq5lfppxdLrv/aRbDRkO6KuWCrM+ZyBsmY1kjQaCZhM7t3Ja1anOJwsgLxSPJWaA13FQ10iaaZU5si3JSmRkZUgywrkks3TA+9in1LgIf5V9pzl/19306HGrsoRoX6loy4MAOVh2YPPMxszrGumotext1MjTWr1vkaydHkoSA6my3I7IUSroeMf8LBKm23o2TaPfMGnekaf8WO/RnmUGhUrdedmYZhAR1OcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=wreqGM/7g+bgEElZ4O6rtPGrlkoJ+RwZnTQmOtw8KxMfTMzwRQVkm54+t+rt173JLfZFk5W126u5e0oxom2hJSRbPGgFh4lJcT/6WikY6ZkFqukTqssDgCOVAoQM90l0QYHsgrpl50aHMpxuJeVXQbywRaxEAIS6e+Xh1KV1F/8=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:05 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b::4) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:05 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:02 -0600
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
Subject: [PATCH v12 26/46] x86/compressed/acpi: Move EFI config table lookup to helper
Date:   Mon, 7 Mar 2022 15:33:36 -0600
Message-ID: <20220307213356.2797205-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cad4a300-a4a6-499b-9d61-08da00825831
X-MS-TrafficTypeDiagnostic: DS7PR12MB5960:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB59606723CF4895A3A91064A1E5089@DS7PR12MB5960.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uW+1EaSoAjgTymRW8ZOe/pDDsAC9jC2JnVIY1eIrQx8BsfyXznzekjGJ7H+WDblhsCGDPSnjmjmi/e76QeN7+VHFqbcUzBNbkIGjYpN6z8mmuPcq1kStefBWPANho/kCKrEG7buhqc5fodIGMn03CsaCgpv7wKzNn5zHpFOlcMy9jjA0JRf1SEamEbwhJAJX+zDC6vgPDbEO8e4dLfVWVrWto5MXLWGC9zkpO8vNQ5hN3RCQOkFO8uxKSyk+pWW/6CfqbuTYkiffwv+EMzDMuP5Phg79HOFMRLIRPdzLaQvQxbKs/IL1+1ruzG5Qx3WiG9YwhCN/3sVx6XtOgmVrpyr41egWUYdMgOeVBNfXpKzofTBTEtMMPzezPbhe6ndJJK1ZDDcjdfJGoFrzeY4E3ZSyepHyKS4dZZSP6SnzRm8Z/vkvtFGJtmtlmaIrusNRwQTs/h/fn8sW9QlWiqqWvjpohabZ3CCxsTOzyRKYjjE2Y9Bt1bVtRZ4fR+Md+/8gc2fql8T2TJLVff2EQIHDjGhKj103PQLE7OsYS6CfWnFMf1ZKkomwec2IWuraBkgqbggrWNYeGDKWVzNQU+Mmpu84w9/UYWgNHJ+bM3pGZu5gA4VweusK0QauYdgNFuKmVHt3BJED5r9PZ1L9HX1/X/UkMrPubK/JaQljdI9BxLwMyeKlSPSY5AdKvIO8GHoZLp7yHzKkpzDRCdIpqfHYvbhkIOoQK5lvL0cm0LHGyY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(8936002)(36756003)(1076003)(508600001)(70586007)(54906003)(110136005)(26005)(186003)(16526019)(7406005)(7416002)(86362001)(6666004)(5660300002)(7696005)(2616005)(82310400004)(316002)(426003)(336012)(36860700001)(47076005)(44832011)(356005)(2906002)(81166007)(40460700003)(8676002)(4326008)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:05.1116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad4a300-a4a6-499b-9d61-08da00825831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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

