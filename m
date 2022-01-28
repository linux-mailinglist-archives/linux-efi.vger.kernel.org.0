Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039349FF2F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiA1RUG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:06 -0500
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:6539
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350797AbiA1RTJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLsE4bxa6jPbRV+EnAlbwRRpI7OZ3mo0YibVuhLQl8JUTmIay1uEtu5nYDxGRieYsdpUux3js24jEJvYbX+iZNiwairs8AXm4ROp9oVuMrY7By/mRAXmXP3A60voPN5XgqtmXDfOo9nuuAPilZVWWaf8N0no9tRLSiauLmYCldb+FlXHI1wN0whLbrLIPDf1vVJBZKFS6u1gjC+7RpNA4I+ZZJANYT477szy7HkoTeM+PUWV2LmrRobTIYQVmWy5szimq9XyM3JwrMC14JPNe5AHVkEvddNHR2mrlsb7fyrvg1hR8U6GjX3usE6lBKchb/gOvKlwA033aGOL176Eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxJwaCYorG4MwI9zDbmgwH/rZp0zezXSCcE+zJfhW3U=;
 b=PigXbmuxOgluA23AY1zIjMfv+O//e8+LAAZa+Phde/jda2Dni6F/vVH5nGinCGaeQ02D+w6M2xTiKBtlPacQIWu66gQh5qudEBklOtaCZVA6PqUp6PgLaMGBD1BJ+FZS0BK8z8ZlF5LJAmc/uswks1Sv/BZB/Q/rzyX4ynyxbhoKQpn84f2hUOVDnNdbbGKnoLEDX5hCqnRYMXv+hmi2E/SzIeRXd2U9deIsGGxcJ+Buwsqb+4ayofbItajgizj38DVzOhW7liekMIMBIvB9/Ruwqt1UXxiUb1ffQWqd4OkBU4B8e3Pl3EhhllXVA9qXcD7FafH0qNoFSQDgYuB6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxJwaCYorG4MwI9zDbmgwH/rZp0zezXSCcE+zJfhW3U=;
 b=069ztMjMM5cAutFYmS8XX5UoCZqlNMcY7wxstL1/UstoXKi/daGTsps0ZQxNlmZex0y4HQPr06f7xwkA25vnbOpwCy97L8SErYhb/fn6cjoA38gJ961olD+Olj2j1iHFKt/zPuEAtxsUUIrptVJXHqF6Ce7Fq/pVR1OuC+EyLTs=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 17:19:06 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::c7) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:05 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:03 -0600
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
Subject: [PATCH v9 28/43] x86/compressed/acpi: Move EFI kexec handling into common code
Date:   Fri, 28 Jan 2022 11:17:49 -0600
Message-ID: <20220128171804.569796-29-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3eccc66-f517-4ba1-de62-08d9e2824986
X-MS-TrafficTypeDiagnostic: MN2PR12MB3421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3421B847CAA8D884BA8E7278E5229@MN2PR12MB3421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jh6AeI+hw4TADdKXadcd2jbnddFsz9NGWb9WPoxpN2dTCcmvy02d3C84gY2KUrNmYEKfxSDgij4Ksf7xFPZBlAqi0o8kfHilvpa+E4Q7gAdNplPoVrqtNJYzmqxKwoFHbZVOhiInZsEgIxh4wmtXUwHbnJiU6QBwCV3IxSb37FT0+Q829xFLfPd5MgzJSy3/MmyQ5/OsJgetdXOkfvrPKR3VFzww0sD2cdBZluHDfbWaxTVFlHJvv5OhaO1nxMiuXPP1za+P8bYUtWczuV0XLXX0A+ybnceahBMkRUSuQRVrypeTlT2q2X4Lu8NPjgiHVckxvuRXNeIKpdLGmgSRpcgDN6wUb7zGXqnmQ95Q9/lS/Q9V0YICuoa0ZTyq/TcdjJikQ9XADNP+xIq5NVc4j59TVz3HQBUqT0Iih5RZFcn7CwnotdOHKiaPapqCvA6DpVosiA07AwlV1mItxQAJ/EZN0ijIRX6yR0es+97yJpwZ8JZfYywwJc3gTdQFhIsXbGui5cRrCsxH7OAEubzFHlEPJgmt32rDjrf02chwaEpVO/A3xYl6Sh2dla4jNuYJMfHk//9s6z7WauQKN/Rr/s3oeGyN5yCHQlUtqViXh9lX4P8ZfnroLQU5cgkpgwOj/vb9/zMBe77YT66mmckfZx1O2LYwX51IdT+kVWYW3/rnQvixWrQLWdeT6Eckt0Zfydlrz2H9BYGWNHboVAjB/juW+a+2Xg6oCfT7Tz3XciL8gI9mDbukAN7Et425swb0tWe9E3ISR8KRhn92uZYGQqhpgGnBCq8YS1zF3Mr5xJjIozJ2/qIkemecLk98lmOV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(186003)(70206006)(508600001)(8936002)(44832011)(7406005)(86362001)(5660300002)(16526019)(26005)(82310400004)(83380400001)(7416002)(36860700001)(6666004)(81166007)(4326008)(70586007)(8676002)(40460700003)(36756003)(426003)(47076005)(2906002)(2616005)(54906003)(110136005)(7696005)(336012)(356005)(1076003)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:05.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eccc66-f517-4ba1-de62-08d9e2824986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
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
 arch/x86/boot/compressed/efi.c  | 49 ++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index d505335bcc25..c726da7eed64 100644
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
@@ -211,14 +160,6 @@ acpi_physical_address get_rsdp_addr(void)
 
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
index 6413a808b2e7..aeed0f0f9f2e 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -78,6 +78,49 @@ unsigned long efi_get_system_table(struct boot_params *boot_params)
 	return sys_tbl_pa;
 }
 
+/*
+ * EFI config table address changes to virtual address after boot, which may
+ * not be accessible for the kexec'd kernel. To address this, kexec provides
+ * the initial physical address via a struct setup_data entry, which is
+ * checked for here, along with some sanity checks.
+ */
+static struct efi_setup_data *get_kexec_setup_data(struct boot_params *boot_params,
+						   enum efi_type et)
+{
+#ifdef CONFIG_X86_64
+	struct efi_setup_data *esd = NULL;
+	struct setup_data *data;
+	u64 pa_data;
+
+	if (et != EFI_TYPE_64)
+		return NULL;
+
+	pa_data = boot_params->hdr.setup_data;
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
  * efi_get_conf_table - Given boot_params, locate EFI system table from it and
  *                      return the physical address of EFI configuration table.
@@ -107,8 +150,12 @@ int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_p
 	if (et == EFI_TYPE_64) {
 		efi_system_table_64_t *stbl =
 			(efi_system_table_64_t *)sys_tbl_pa;
+		struct efi_setup_data *esd;
 
-		*cfg_tbl_pa = stbl->tables;
+		/* kexec provides an alternative EFI conf table, check for it. */
+		esd = get_kexec_setup_data(boot_params, et);
+
+		*cfg_tbl_pa = esd ? esd->tables : stbl->tables;
 		*cfg_tbl_len = stbl->nr_tables;
 	} else if (et == EFI_TYPE_32) {
 		efi_system_table_32_t *stbl =
-- 
2.25.1

