Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E413BEE7A
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhGGSVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:21:17 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:26112
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232508AbhGGSUX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5Pj2D442YTzlVGryNSzmu8pFB8xhkV9/GmmGDUG0W5vI9e8yXUpu9/BGY290XqO3xo6SCnu7OlOE7WbdyL0wcn+00betxH3tsK6N51kXDsT1xUMS3I4PU7Q7HZ81F2aKNGTe29jgKObtrmVaN05TcI7kjScoEViwypIDTd2yiRHmbXAA0G/CX7z1a5MVpBByWXNIibECNOUehGhDs0OF/6Ugp9R1JHqJGFrXbDLBYfrmYq9R2edJsGr6pgb1lMOB2W/N/6pcU8CGt0xM4FCVm+vQrtifpUOvL8O5+/G0K3WwVvWt1f7JCEcm/wIvT6LAtqAZrhr0aoW/cotbPx+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPZMrIjJ8mD/qBfBptD/Ox46LRwQeKqAd9aThHVDvOI=;
 b=eFulPikaeL5ryWd4dZDNDWSEAenvLq4VmVERpvdb3ebXCbmFdIYwkReSVJAJ3XksknB/LbqBz47McrROIn5O/01m9KpxcQcbMZX3X8qjZAlgLyhBK16a3ICYjA86l6tgloaJYhXLgdBx1QhTIK9KkuOouOPIcNuPsGmw1eZH0FHhWdPSsTbjpzzKWu8XabF4p/CNuUBMF6YL2hO0HYPpSVolrmp90X8RUo6mU+VsnoT9RrvGtAx2GEcRrwNeVNBWYEqkdfDcl1sekVW+PAXWVVpCoZ+mT4FgYRGvq8p8+iOPNSFzY0pNsoxZe9/GYtaGjk9s1XKV6n16OdKcbKE47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPZMrIjJ8mD/qBfBptD/Ox46LRwQeKqAd9aThHVDvOI=;
 b=zJwH49CTTjV37zbV6b4hTeP2mWH5lFwd+yj/kDB4c9ICN8fMvOlZ4/WsB6zvT//yJfOOgIEQV0YVaEnB6QbrXM0vcoj8Pe8kM1cFNjP30WLk+LyfuBUXjU72YoSrn4CrM2enAA0FhyadazSQeiCSk6NAJHZT0JlJThkmZ2vf/dg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:30 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:30 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config table access to common code
Date:   Wed,  7 Jul 2021 13:14:54 -0500
Message-Id: <20210707181506.30489-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d8fd6a-95f5-427d-da9b-08d9417357d3
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB501660285DB40FEEF8122424E51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FligQslX/nqSLIKKK7St2SjdBqNYPSOCQWP/f5fVXk0alBCLENoZxgex7gDXpxOmehTCTeMYzNUcLB4aHYrXTjMcqc3J3pup7xgfV2lqiczOq9V2YZ27i1p7JsZEsizOH2vuT94MfgveMoZL45G80h9vBYr9TftQl/WVXsYsT/uwvF1nmdYMzm7OPdGgY4E8I8uZuAJwfS02sf16yRVGbxn+9fOFjwHKvGhSA6IKJPi9Muqa4CtM9TV4QOhhw/xoT55UsLC7R5XgbUawGr3MufqTZRvCe8KY9Ll6PUM6DkUSBmf7cJEB0PhsyAFmZmNQq2MPPNa7MmOI1BXHmup4fIY2JwpYUYIueZcr/hseMZkJGG9TsdQxG7js7XYR9iwSFIJLkFdxcfT+2LEmU5XusTl5Mn5yLE9yqFcL1NuNjFkn5tM66sPbZ8q3LCyVcNGVID6uP38TVjAt7leHpxhUwJAjfE47MtXFSGBmDp6bUT9Bl36RloJiHVREHf/CQeUaA6xP74HhDVQ4geZ5rHliPgUZjrTsEczAQN+QuS5VtA1/iqAcMR0L+cM0RtMBVZe6g21laFaf97tAUTGxWu6OnoEmqCG2QuECnrYOs5Aqa7QcwhSf0IiCB6lUT+pfyPYgGtJqEc9n45Ny4VhPDDMOQVVw2kYF3CTCMvdM2VMYPfFiB0Y6g4DRlzUWiveNWEC0+6f2Ysl6qyGwPeWV7T5I6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/xY1WuiR5o8Qx+vaGhw3GgS4CCJasBwIfrmSbdPoFSutf79EubvsSezwK/f?=
 =?us-ascii?Q?xIYIlaKmv8JhYHyoSJXsGSOZlcQWf8P2l6wTDVlyrtk1fZ7z0vSf1GTs/0DV?=
 =?us-ascii?Q?9QbilIF04nIMP69JbaL5RmUjj2dHurQT9TznZNeq8Irt4TG2vZXNM3qIa/uL?=
 =?us-ascii?Q?DsL8hV9lJs18/jfIuAXdkO72lV7rFI90dJ49p5CKt9jhlRBkJ3xnxeXdph4p?=
 =?us-ascii?Q?ED82ClC6Us5fg/TUAr9+/5v/QfCsXWv5olnmjJeeaLmZurDze+GHlhW1MKJq?=
 =?us-ascii?Q?A6PJVNq3Lry/PhdeAqCp/XtPpE6vCVIUJQLGWAkp2SkMyg2ZhNWYL+R5ltZx?=
 =?us-ascii?Q?Z6u29VpCTSLu/4c/qWYsVbUwEkOWwk04kssttA7pyp5c7pY5WKZ2DisaWXbc?=
 =?us-ascii?Q?DXKiSJpk5bS49newapzEXC8hzSTn0ZSD3iHFlbErMNg1mgyLzlpRbgHEe2o1?=
 =?us-ascii?Q?In3l38xL6E/qrmFaTQh8j+BQK1xXnow6IehlkoDNKI0lLPwyd1hBJd5UQgHG?=
 =?us-ascii?Q?9Dse/wMHGISifG5+0BAMlXMrhkqCUYBnDo0VCLk+m34BFwavBUzjtTI0yW9K?=
 =?us-ascii?Q?x7Cpv4BB8g3r/xAOZMnuLpSBx4XQPPband2X9xmsmkSyOZGTrsmVcD4pGVY4?=
 =?us-ascii?Q?IXiJ4/Ix9i5Y+pKmPB7RxJmGmG5t+b2n/vR3cQWEXoHpYHqm5Eh4vIhmpesB?=
 =?us-ascii?Q?T+gakdXtu5PkH+ZtPrQP49ZHMNWqxGuURjjNT6mF/sLphGl+kzGTvqYbM+rM?=
 =?us-ascii?Q?dyqATvbYVy1c5E2MTvnfjy78KeVYIAv4dPgBrFpAvmLC3IZBsjziUU46YebJ?=
 =?us-ascii?Q?NE3A4o4NfQ3HWdf2ZjfgunyRnOYhIJPZdEyMpPPggFyXvOKbRKiFA7yb6DU9?=
 =?us-ascii?Q?x62KvrqZn5BadMUT/oJ+RPpFjuKgahp9+tKJeWfM7CflrqXcmlY+b8xzARN6?=
 =?us-ascii?Q?ZHlis9jAFJbnc5s6IPOkrPnd9rr4c4tjc9UMMj4K9ddYvTY/NmtTZIW93JvV?=
 =?us-ascii?Q?Fw5pbQvl8lMAinnpJvhZC5PDk1tpBzvP+sZnGWf2CdmtbEZnctgfxCfXbk2l?=
 =?us-ascii?Q?QFwAG1Uzs7j3Yu9EfygSScf1wvFm/bJ1pfmn+ptD3MeELXVXzXP0GpmWDplu?=
 =?us-ascii?Q?SSBwAug837XBI839YEFSx5ni+1DI3igB6SPJto3VFmaGoO1DUxwNRIrfdMsK?=
 =?us-ascii?Q?y2FDHOFGY9OM9+do5Tg/f4vMReLtMJpPjsq0CBZlfTjR4yHS/+rSzhxCkQLf?=
 =?us-ascii?Q?/AxUFG8yBdj+d1+SbZKaVodBUcApPqrbO/3Nsm89pPw3+R8vkQRYcUsSclca?=
 =?us-ascii?Q?lP5X1HP6XUlGclwXGQIGlFSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8fd6a-95f5-427d-da9b-08d9417357d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:30.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFcZq9RuwmVk1/IuYKqJjcS+XUh+DXM7HdmC/wCzB77NB3lQL05pYsm2S8QgO017W2esZn4D6c3nsYLZ8WJrgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Move the related code into a set of
helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/Makefile           |   1 +
 arch/x86/boot/compressed/acpi.c             | 124 +++++---------
 arch/x86/boot/compressed/efi-config-table.c | 180 ++++++++++++++++++++
 arch/x86/boot/compressed/misc.h             |  50 ++++++
 4 files changed, 272 insertions(+), 83 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi-config-table.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..b41aecfda49c 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,6 +100,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi-config-table.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..e087dcaf43b3 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -24,42 +24,36 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
  */
+#ifdef CONFIG_EFI
+static bool
+rsdp_find_fn(efi_guid_t guid, unsigned long vendor_table, bool efi_64,
+	     void *opaque)
+{
+	acpi_physical_address *rsdp_addr = opaque;
+
+	if (!(efi_guidcmp(guid, ACPI_TABLE_GUID))) {
+		*rsdp_addr = vendor_table;
+	} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
+		*rsdp_addr = vendor_table;
+		return false;
+	}
+
+	return true;
+}
+#endif
+
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
+__efi_get_rsdp_addr(unsigned long config_table_pa, unsigned int config_table_len,
 		    bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
-
 #ifdef CONFIG_EFI
-	int i;
-
-	/* Get EFI tables from systab. */
-	for (i = 0; i < nr_tables; i++) {
-		acpi_physical_address table;
-		efi_guid_t guid;
-
-		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-
-			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
-				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
-				return 0;
-			}
-		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-		}
+	int ret;
 
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
-			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
-			return table;
-	}
+	ret = efi_foreach_conf_entry((void *)config_table_pa, config_table_len,
+				     efi_64, rsdp_find_fn, &rsdp_addr);
+	if (ret)
+		debug_putstr("Error getting RSDP address.\n");
 #endif
 	return rsdp_addr;
 }
@@ -87,7 +81,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
 	struct efi_info *ei;
+	bool efi_64;
 	char *sig;
+	int ret;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,18 +94,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	/* Get systab from boot params. */
+	ret = efi_bp_get_system_table(boot_params, (unsigned long *)&systab, &efi_64);
+	if (ret)
+		error("EFI system table not found in kexec boot_params.");
+
+	if (!efi_64) {
 		debug_putstr("Wrong kexec EFI loader signature.\n");
 		return 0;
 	}
 
-	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
-	if (!systab)
-		error("EFI system table not found in kexec boot_params.");
-
 	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
 }
 #else
@@ -119,54 +113,18 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
-	unsigned int nr_tables;
-	struct efi_info *ei;
+	unsigned long config_table_pa = 0;
+	unsigned int config_table_len;
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
+	ret = efi_bp_get_conf_table(boot_params, &config_table_pa,
+				    &config_table_len, &efi_64);
+	if (ret || !config_table_pa)
+		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(config_table_pa, config_table_len,
+				   efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi-config-table.c b/arch/x86/boot/compressed/efi-config-table.c
new file mode 100644
index 000000000000..d1a34aa7cefd
--- /dev/null
+++ b/arch/x86/boot/compressed/efi-config-table.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for early access to EFI configuration table
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Michael Roth <michael.roth@amd.com>
+ */
+
+#include "misc.h"
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+/* Get vendor table address/guid from EFI config table at the given index */
+static int get_vendor_table(void *conf_table, unsigned int idx,
+			    unsigned long *vendor_table_pa,
+			    efi_guid_t *vendor_table_guid,
+			    bool efi_64)
+{
+	if (efi_64) {
+		efi_config_table_64_t *table_entry =
+			(efi_config_table_64_t *)conf_table + idx;
+
+		if (!IS_ENABLED(CONFIG_X86_64) &&
+		    table_entry->table >> 32) {
+			debug_putstr("Error: EFI config table entry located above 4GB.\n");
+			return -EINVAL;
+		}
+
+		*vendor_table_pa = table_entry->table;
+		*vendor_table_guid = table_entry->guid;
+
+	} else {
+		efi_config_table_32_t *table_entry =
+			(efi_config_table_32_t *)conf_table + idx;
+
+		*vendor_table_pa = table_entry->table;
+		*vendor_table_guid = table_entry->guid;
+	}
+
+	return 0;
+}
+
+/*
+ * Iterate through the entries in the EFI configuration table and pass the
+ * associated GUID/physical address of each entry on the provided callback
+ * function.
+ *
+ * @conf_table:         pointer to EFI configuration table
+ * @conf_table_len:     number of entries in EFI configuration table
+ * @efi_64:             true if using 64-bit EFI
+ * @fn:                 callback function that returns true if iteration
+ *                      should continue
+ * @opaque:             optional caller-provided data structure to pass to
+ *                      callback function on each iteration
+ *
+ * Returns 0 on success.
+ */
+int
+efi_foreach_conf_entry(void *conf_table, unsigned int conf_table_len,
+		       bool efi_64, bool (*fn)(efi_guid_t vendor_table_guid,
+					       unsigned long vendor_table_pa,
+					       bool efi_64,
+					       void *opaque),
+		       void *opaque)
+{
+	unsigned int i;
+
+	for (i = 0; i < conf_table_len; i++) {
+		unsigned long vendor_table_pa;
+		efi_guid_t vendor_table_guid;
+
+		if (get_vendor_table(conf_table, i, &vendor_table_pa,
+				     &vendor_table_guid, efi_64))
+			return -EINVAL;
+
+		if (!fn(vendor_table_guid, vendor_table_pa, efi_64, opaque))
+			break;
+	}
+
+	return 0;
+}
+
+/*
+ * Given boot_params, retrieve the physical address of EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @sys_table_pa:       location to store physical address of system table
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int
+efi_bp_get_system_table(struct boot_params *boot_params,
+			unsigned long *sys_table_pa, bool *is_efi_64)
+{
+	unsigned long sys_table;
+	struct efi_info *ei;
+	bool efi_64;
+	char *sig;
+
+	if (!sys_table_pa || !is_efi_64)
+		return -EINVAL;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		efi_64 = true;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		efi_64 = false;
+	} else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return -ENOENT;
+	}
+
+	/* Get systab from boot params. */
+#ifdef CONFIG_X86_64
+	sys_table = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("Error: EFI system table located above 4GB.\n");
+		return -EINVAL;
+	}
+	sys_table = ei->efi_systab;
+#endif
+	if (!sys_table) {
+		debug_putstr("EFI system table not found.");
+		return -ENOENT;
+	}
+
+	*sys_table_pa = sys_table;
+	*is_efi_64 = efi_64;
+	return 0;
+}
+
+/*
+ * Given boot_params, locate EFI system table from it and return the physical
+ * address EFI configuration table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @conf_table_pa:      location to store physical address of config table
+ * @conf_table_len:     location to store number of config table entries
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int
+efi_bp_get_conf_table(struct boot_params *boot_params,
+		      unsigned long *conf_table_pa,
+		      unsigned int *conf_table_len,
+		      bool *is_efi_64)
+{
+	unsigned long sys_table_pa = 0;
+	int ret;
+
+	if (!conf_table_pa || !conf_table_len || !is_efi_64)
+		return -EINVAL;
+
+	ret = efi_bp_get_system_table(boot_params, &sys_table_pa, is_efi_64);
+	if (ret)
+		return ret;
+
+	/* Handle EFI bitness properly */
+	if (*is_efi_64) {
+		efi_system_table_64_t *stbl =
+			(efi_system_table_64_t *)sys_table_pa;
+
+		*conf_table_pa	= stbl->tables;
+		*conf_table_len	= stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl =
+			(efi_system_table_32_t *)sys_table_pa;
+
+		*conf_table_pa	= stbl->tables;
+		*conf_table_len	= stbl->nr_tables;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 822e0c254b9a..522baf8ff04a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -21,6 +21,7 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -174,4 +175,53 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+int efi_foreach_conf_entry(void *conf_table, unsigned int conf_table_len,
+			   bool efi_64,
+			   bool (*fn)(efi_guid_t guid,
+				      unsigned long vendor_table_pa,
+				      bool efi_64,
+				      void *opaque),
+			   void *opaque);
+
+int efi_bp_get_system_table(struct boot_params *boot_params,
+			    unsigned long *sys_table_pa,
+			    bool *is_efi_64);
+
+int efi_bp_get_conf_table(struct boot_params *boot_params,
+			  unsigned long *conf_table_pa,
+			  unsigned int *conf_table_len,
+			  bool *is_efi_64);
+#else
+static inline int
+efi_foreach_conf_entry(void *conf_table, unsigned int conf_table_len,
+		       bool efi_64,
+		       bool (*fn)(efi_guid_t guid,
+				  unsigned long vendor_table_pa,
+				  bool efi_64,
+				  void *opaque),
+		       void *opaque);
+{
+	return -ENOENT;
+}
+
+static inline int
+efi_bp_get_system_table(struct boot_params *boot_params,
+			unsigned long *sys_table_pa,
+			bool *is_efi_64)
+{
+	return -ENOENT;
+}
+
+static inline int
+efi_bp_get_conf_table(struct boot_params *boot_params,
+		      unsigned long *conf_table_pa,
+		      unsigned int *conf_table_len,
+		      bool *is_efi_64)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.17.1

