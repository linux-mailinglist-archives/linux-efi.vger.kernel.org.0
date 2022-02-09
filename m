Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E24AF973
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiBISOG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiBISNM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E2C03C1B0;
        Wed,  9 Feb 2022 10:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn/0C9rP3wrvwi9guojajFVeoeO3BY+XMp6tQ8Q0B7clL2/6q55xdUKbGBpBeg9Wfpc7YwcGKtiZ174mn2xp5KnwAVyM9Q24jtraizy4/QmlUybS2sApgyWMLRfUDVmUTeGzmbK0XTaX54V4+yBrDbfsOdcvfGTRbHjocwHP/Z+nbzn1IvGpucOHMzLKfjTZuSedDI9IH9kdpMWVlxGAtiTiQB5AhhnN1qGCpctKhHzfe92as0BUOL3MXDjlTUqJo2mXFsiAl5Pm7F703A+gY/JRk/mIwyod8zIWodROBbu3byQ9gRz1bpE3jnUfRohSqeMQ8biVKcSU/vlLm267rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=XZpOjGALR0ScpteJHP4FGNrFaANIV+GXHWeFg7RiZMRHMc7LhfOirIQjTWmeLiUF3bjLQyjAFc7VrRMmDLcGX8wQDM9Xc0TCIIP6aZqVr6gXZBAl0pKt43uUauf1y9wTNHYOjt7/hB0+zJnWWMNf59ROwgaB+OYVvnlv0jkf6rw5cV5OthWqABbWR1bXW8mouUqL/h2vuIp7gtTTwvCVsWZysnEdtuPgVwsiK18ThrLNvq3MeAASVsKc8vEx82TMfqr024NW2M58UTpmdciYDb4t5LSb3z/sjmiMQzjQfNWOEI25EiDSNAnraPoZCiuSIAzbafXCpx1Zlohl9+go3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7THHF0Wx2FA67KQYmtOOB2p8rCK5n19XwVdJIoJW5Yo=;
 b=YG4jO9BXpyka97zf8+z5L9UN69xkemVqvwdk1xxN+16W/hQeL0mGYhckB7QkPCD74e4iuu71gMvJbiDwvKOxeu3m9lMo0amV8VvTBdrcW9QqDQq3i4YPgt6gawwOzUW26BMAVcf3oVLKEvywsg2qtdsqBOzuHgy/p/OPHrPpCMg=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:13 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::12) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:13 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:09 -0600
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
Subject: [PATCH v10 26/45] x86/compressed/acpi: Move EFI config table lookup to helper
Date:   Wed, 9 Feb 2022 12:10:20 -0600
Message-ID: <20220209181039.1262882-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: afbc553f-3929-48a2-03ee-08d9ebf7b284
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48537AE1993EEC8CCDBFC8EAE52E9@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxpuZvNXOTBx6kyONxXwH4vXMjMRYa6dRZBaxAYVEpNX9zahgQtNpupw3dEjVoyjRY4g89eb6Bfl4zI9vh37kyoqNSwOdQ5doiz843Dqs9MiDlWAFBzjXuyRhtJHtaRioWDWP9UCLufFUFBicvrlt6+1n2F8lbJlN/JPlp7ApO8AApJzJy7S/eg/u4/XdqrzbplcW84+kAfut8+FUHLpx94aYchqm5NMYBBh6VWik5Ngn4ARK8JUY0SKfGEdSi+KyqTPdYPT1eTrsQTFn61ZSBy9jWp/vm1rsxK2eCAsl65ryAt0vN8MYgflH5CLVC9RB8h5zAPyTCylrqqa+0g6ieQjztM+taac5qR+s9rTs0pUoC03q/+QLskBZIgNNAubqMAn6Kcf1RTaA23QNRxXIxcV9HGeh9+WDraiYxVxdPOp+0iicX8ali4uMmDxYWCSJNJb1O5Zfszb+IH4yH2rUnDftcBzglAnj9jikiCAZb3mH0NkzIjLmnJjwP3kMrrJKDLCZIs0ibScB/bC+p1Enn9d28Ef0sBR4z9WFVcuyO/odwdqxNDivTQoF/Ok35vrqbm9UvgbldG5Fn0z9ClVkhuG3casBqr4Ne6stvtG/gxeFdaiCAMvggNM0nUtvOvv+wB7R7I7/wIuJ6GfX4MEeetKmcsBOnxAr2P8t6vt39Q9lYFA537TX1HOg5QrarSBr66tl2pe8nO9X7JbCat0ElcX3dQTfeOScxU/+R8voRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(36860700001)(110136005)(1076003)(54906003)(186003)(2616005)(426003)(336012)(7416002)(36756003)(16526019)(316002)(7406005)(44832011)(2906002)(26005)(8936002)(86362001)(81166007)(356005)(508600001)(4326008)(6666004)(82310400004)(7696005)(40460700003)(5660300002)(8676002)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:13.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbc553f-3929-48a2-03ee-08d9ebf7b284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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

