Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3524AF9AA
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiBISOv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbiBISN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:56 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA0C035443;
        Wed,  9 Feb 2022 10:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuC11nisrlIxcYEOa/KJ8V6+1IUajjmpZS5qOnYclWWTJhz6bp/e0RplX99K6yqQsSWl6Iiq++yCYxyHXBppLxMqhCpHGrkXs6IHWNoAhEBwM2WUqGA8Wqnfkxfmg0yxwhN+oFrUTa7YZ7Asg3+UVBZfDBKC80bTWz5Ufxp+9/ajuekBSZ476ghDVQYm/22CO6NNudMVtzhI1YtUZ+TB242wm9i7C8hvzwRWZrPbAwh0kSpYYoPvg1EITY+Tm3IDStIOZrAMvJZVJ5m6/XpZAE8nSzLaToIZu5oJvGJQGZYtUcrzcafCIKpW44xmmJfkN20BXnx31a0AfMTN0NiytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aECr4lxRaZY7FAYkVXj8D7W6XkLP0iMx+fQkjtxy/z0=;
 b=UxE5RhGfw7hx6305bIvDM4pzEeslyYDY4ya6s+sJWP/jvXRHEZgW/2ujNO+ctRIL8zGCBUvJilbyrppsLM1rPlZ+oMHk0H3L8on9kzQQw2OKhBrahp1VyswPOCdAyEZDhsOBH6qBNd9MXq3tXgMblKqwPoFCgvougNXz+rEicNyyzLcpZYd38SJrk4Ts7W/kIzyKeZiK8ZH8IDjS0W24/CBcpyoqZ9TTQg4KKs6axNQreHI1Z3MAFXbEZ54RKEYge6vE5CA4OS9KaO+Ka+zyzl05hfBk5UXptI7jrEP7e/MX3KC8WSR+/Ra5sn3/GHdAQdKzmnVxxbdWAQ6hheYEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aECr4lxRaZY7FAYkVXj8D7W6XkLP0iMx+fQkjtxy/z0=;
 b=IFy7Tuuwgvr35K/le87VPzcyk9O70r/fMeS5nT0xO1aVXDJRoAuc99BbNqrt+fR4VL7dAsi9Ps8pr85SHlCMRGYhNvy17um3pefoY0FOnmJDFuYyjb8oilLj0MfjnqOTlglZBtV+C/CWEJWRvVZ6isC7nnp3nwZm+5zNO4yNaW0=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:12:21 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::73) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:21 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:13 -0600
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
Subject: [PATCH v10 28/45] x86/compressed/acpi: Move EFI kexec handling into common code
Date:   Wed, 9 Feb 2022 12:10:22 -0600
Message-ID: <20220209181039.1262882-29-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dac9b10f-abac-40a3-1a70-08d9ebf7b75e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4208FBCA0B4EC7E4938FA7D4E52E9@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpFR9JU94/q/hCVBUfdaka/oryvnw48Lq4O7pq3Ys05ipUWS+xmTDtUoDftsij2tgkzv9YVOSz6CYSDzYwpVDiHVCpb4U0sPh/2fwad8HLwAT6XVwf3KboQK8IYuhw3Hdb2ClNDwUw9iXLYNLUjDdZSroalBcNwlZkPrV3C+UMpbLlENfQJGiQ9iNUS/MCi1Xqx4m6/pJJYu4Kmjyk0eB/GDUTdLrWaQJ5bOgWhGMMwLxgN1WvzG9kWMQNLFZsLjit+ruFDSsmTzI0EUPkiYlE4dRhZcIOpF6nz7iLSmcHr0scUHoWA2iSJRsQ0vaOv87lC4LzO2caCq3EDiVB9EhYpWL+Z3y1z3xt8dp3JbpJJN51fVTBIc00U6rxweV+WQP/KREd25qD2rfAx1TZ0gnBgQE8YFnCIYd+9CmuXkfQ1NczgQkIlzZEJZwrUSMVJzM0cAwfxpJXukzi+lt77X35wWqr9Asf0WQX6BBo4X4iWP67NOiNjBda+2gSgWPL/dTPWIpIEszavYuxI+wtevhHj8diOYkBRsRg0KI3LaBUgdChlwE7QY0EyAMr/3a2aOxrQDM5D0k77Uwismr8SmxHM6oRsxa4j/kSYVH8W4sz5nbOkBaAluFzfD3U82T2DGlWkubHup0s0pMEtCqDjFmg+dFtf3kWptpyLjoaia7N6vrn5AZ+HIh6b8s77+BVN8IS9VBr4CcUFCXz9Rk6SMEHRwiZZNYyzFLXwVglgeXOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(7416002)(7406005)(2906002)(44832011)(356005)(47076005)(81166007)(36756003)(40460700003)(70586007)(70206006)(110136005)(508600001)(426003)(336012)(316002)(82310400004)(83380400001)(2616005)(186003)(26005)(1076003)(16526019)(54906003)(86362001)(36860700001)(6666004)(7696005)(8676002)(4326008)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:21.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac9b10f-abac-40a3-1a70-08d9ebf7b75e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

