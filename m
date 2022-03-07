Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512894D09D3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiCGVhG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbiCGVgh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:37 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820888B31;
        Mon,  7 Mar 2022 13:35:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMlXMO4bSBUEf7LjQqSSrQ7z+K4APuhAic+UpEP7FS55/Chp8rT7IsyL0fVE0ftx/pYeDj1vmJbfE/Yh3/vsBdrY2NzruTEZq5UOBEwZE3Vrh+SU+W098Hd8+wyWjmJC8tiI3hsgwADIO07onGu1q0RXCY4e0JEEgUCq5tCtWudOVNLiTPH98x6MrOWeDPHjARrvU079WFVcAUlmL6TB/bvBtbrEfC7bGjZxb4tegWYbj9HGwUAq8JUNeIj7rm/AdKW71+J5yec2EkcCM71hjCF+P8m81mm92+i2KaOjNkAg8CclqoKREGOtIeyz95isMjAOIlgECAgLMpy2sv+q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=ezTePnVDcqg1MrNLJ72kFFxdAhDBhvajQqXqW77Sc3Zmu+eCFzYutBa+Mep5ArXSGD+q8PqquMEcEirRx0n79mbP0RX7OU7AHNxPEn0vxPI4phqGkpvQzVuX2wMDV5b0qwDjCW4cJGHkwTemNXJpeeDWO3Sbak5zIKvFmFbZ3ZmeSrJMXInjPRvDYX6jPI9RFykVlaXNaO3zTxb/XZhUJach7Z0g1oZhsLThmG54/V0LGok9AGuNS9vYvpuvxCEzMkLK5PgemTbZ+JAm+8L98BR/i5oLdTUCXFEpkdxhVglrjMeCt7dCa+MEGesfBu90pNs/+mEhuV3GzPEWvOlITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP6H33Rr0o+xHwfMAMXFCS4I6yRECJeE/d+64V3e2Fg=;
 b=h3H7g1mGzspNBrfZuGHF9cZMY1UQ/c8J/Qtgzh+C2Ko9fhWpdiB5l4xNP+/mhLyr2Ee56jnc/LSHD1FGP09I2sUk57aUQn6leaRPT4QeqNEVOB02DAFRX73laJC/Nckd/Ltp2xZpMDevcHagNKttsf7v904BAdT1lHlhihMe2Y8=
Received: from BN6PR2001CA0026.namprd20.prod.outlook.com
 (2603:10b6:405:16::12) by BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 21:35:04 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ff) by BN6PR2001CA0026.outlook.office365.com
 (2603:10b6:405:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:01 -0600
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
Subject: [PATCH v12 25/46] x86/compressed/acpi: Move EFI system table lookup to helper
Date:   Mon, 7 Mar 2022 15:33:35 -0600
Message-ID: <20220307213356.2797205-26-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40b65186-c511-421b-9531-08da00825723
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB260014E44537EBB3235E13AAE5089@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfJ/U2O5i01+kLir2cbb4BxS9CPWBo2FUjMpxPCJPhDwyKDCIJs8shRxXoaJPAoC9Rbz+UzLucNE0cBZ6hOkVlBVX3KdeF6I+zcJVp3RzqnRZgBzb1CyJupsTxEiazkx1y3AMJ7b3d4qhzdaJCWqAqd9idNzNqFkSiyxPQQVX1RdAivJulRc+5/nf00YFpNReX0v3ZveEOWK08C21QXIa37tHhplfS3UfE+YcrzU4eJgnThU5wI2rYWQa455itLZPxDH75RLHrs1DBlkZAVDwnf8+9UgN4KWPnRmIUlBWlKbiT8R0EkPehN3lWHwA9RSKKKaKHRBVWacJKvqJTnzrzdUTr/CavQXxahq/ySl6iwrwtxDyrcTMj0ENg/yKWvEjPWnMAmksecirt+Z80gCgCuGP+KUhZHOtoanAvhqaxX9UM9s34DKaeriHKNqqJK5Yoe+Ls2Co3/KvHi9p9frPIIzL5O+f/LSqNdU8pn0dYUSTNVuZsxGVA8B+uWS0NNcxSKEumSeCScxzoUjryNNy/WeygTcMOAGiVoyvajAkyuAVLuDHWjwlPL9ysErESJabV3r5/1SyAVv2jsRVvb6AWWd0WxNM9CbAksDMrxFk09iXWAq4bAGb3SmAsTOIo6lzwIwSFniN+bQ1vKmL0O7ncnNplMWDNDs536HsJ0jIRdLmgfmep7QifPHVRmjtExvyTt4mIB/KzUIRCeuMUCIO6b+MVQKcGdMlc+jQ14SjRM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(36860700001)(7696005)(110136005)(8936002)(36756003)(47076005)(83380400001)(44832011)(2906002)(7416002)(316002)(7406005)(54906003)(426003)(336012)(1076003)(81166007)(4326008)(26005)(8676002)(186003)(40460700003)(508600001)(2616005)(82310400004)(6666004)(86362001)(70206006)(356005)(70586007)(16526019)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:03.3419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b65186-c511-421b-9531-08da00825723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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

