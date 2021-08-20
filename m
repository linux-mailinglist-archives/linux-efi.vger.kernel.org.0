Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6E3F2EFA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbhHTPWY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:24 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:18017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241261AbhHTPWH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKbL1wLKi/2pgqFPkz9Qf8KHO/gaIeKxaJDT526wVJH8DturzauuxgKAP/T42861872f8mCVVfhFsoZVWteaEbPuVn7JW1weIZ66mjsn6JoDMgOXY1NtGFYhKsAF6I8S6NyruX1FKkqzSfdsd7mhGFS7ApAq3Lt2vTZCSabqyOPCpTV2B/TWEaEKDVHP4o+SJ0SUY6xegCu/+omZSz5nN3vVL3G+Nu2/b4iaa9KA9CfAQT5zORaIvPV7V6KoJFCx1+ionl725HAeV5/NiW4mIWYcAvSyKpMDM0ooyskxHdQ9DsPD/Q1A2YebdY42zfpz136KmSYXQYu4f0f57kc5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWwwMrQlJ/Vyk+y8B9pRCEavc+7EKvWY7FPqoU8sMxQ=;
 b=TEfniRS/BYFI5hb1Mzv+7J+GJF8bzBzJnt28GOnTnNnG0r51JmpuHTb8PghyCEJyLpsSm4JCpis082ziljKlyGeozWKp+mTGPlFkXCV8AUzZUVn+RimDVnaG4hM0E87Iw5gpux+rGLLkcHQJgKCTb8I3jS989SaBG9YyyW3EtDbghmyQWZ4MAPDwcGyPKGkdyqpoB+VBx+mdMKo+f4A5BUsYKgfmeaBgBEpWaJmZjvP9+hhnLnbrIH1FyqiFKPC+V/+FHgCurPQZgkhv8n07eVuq4K8GWbz9DT5yf8ZRyMmcIzJ55RhsXxwW7VaOvGFfJnPaHapi8YCDxh2aTBqCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWwwMrQlJ/Vyk+y8B9pRCEavc+7EKvWY7FPqoU8sMxQ=;
 b=WqimFakgHduWY1XBZwqIDa1sZvQYTeq9hrfFs5BSc9zIdUGLk8JyeLLxjlcz8FHiAOLhFP78XOi+q28rBd9rGI+wE5nthsM/7Avo9oObnttw/+ki5dKVEIVj2Q5eZxbeDerwfuxG9aeHWdt58gVy/rGk8819Ibblk5Mz+YeUkRc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:21 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:21 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 26/38] x86/compressed/acpi: move EFI config table access to common code
Date:   Fri, 20 Aug 2021 10:19:21 -0500
Message-Id: <20210820151933.22401-27-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a80506-7dce-4923-54f6-08d963ee2a31
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638E8990F1342A580D8C314E5C19@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iScexd+yEx/SqOTtjnAwRbjcEAjfSuZWEFMc31ucswARheh+HiFcT23q+h2Y6sm0eFjca7cp3CukLLqMpmq2nYu0kkffXgzHfU9QtXHYiSt1NB/JIGXysrCG/AWRwBs9j8WMCtAGMMs3f05kajC1lZyG5vR0lGt2wEQ6qhDQZ+Zk18BtnET9qppHhXlQ7f1VRMnnMjq21HcjY0aNYvDfBT0CO7trKn2Em9/2M7q3NmAH24XYiKBvdKkIgP9okG4iKQfng0pUuOYJSwGFOMMv2IlJeWOq3R5SBQM6xdd0BUiajVnlQCZGrcVQ0uoKKUrWaJN+/3GM0f99WMDbeOScZp+fhkmyYM3RtfBWfrOWCn/7P01d/qLPZA5Ab/axuVVdb6UyZbOtG6snmhhUUZSR22BvVoKdkHIF0IYMAYvwov27X4L0is1u+suyfoS2qGRqF2B13YRmTQ5szvQt5qaSLMQfBVuDSlHgK2TT0FXv5bUxObeRFGBIwddOeGIn7DDVhOAZ2yKnPUBa0Bk8CLndjQrgG+gLy3YQA2t+R0XOBx31cdSb2QqkfEQYwrOb/2V2G5f/pmd4U30OiwkkaL+inCIVL0hpK0BtqEuALHnfEkendLkZaksHPdvvwZjDnPBxNB7ZJGqoWMFJdxRCsCwk8ytx2lxQbBCUpM16jaUmimdQUnFLLJxmVaCHvr1MPUc/9QkMysp0P4I/ZL82PSwcSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8676002)(8936002)(86362001)(83380400001)(30864003)(316002)(54906003)(1076003)(478600001)(2616005)(44832011)(2906002)(4326008)(7406005)(956004)(66556008)(7416002)(66476007)(186003)(66946007)(26005)(5660300002)(36756003)(7696005)(52116002)(38100700002)(6486002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c2KWNelLL7X5kPjBWbd6s0XXXlWyDkUn3vXV9gdsLp5Mkgfh1FnFlRcF0oL?=
 =?us-ascii?Q?3MFF5pgkAtp2FAtp08V7qEr79zkYPbYDVGchXb42P83JoTOEyJK75mmaLoJV?=
 =?us-ascii?Q?mFOj0RHXPVijAi1LlJhOXJO4mfAitIiUiSz+cn8410w2O03aixiZs29LR3Ik?=
 =?us-ascii?Q?OuDcgOJUJXjZ4TkNTFq40ExCp/CYvqETE+oF02BfQQ8JE6fmTgWVa46agWma?=
 =?us-ascii?Q?AsXD/3MGjvoxAuH3Gq1T1L/sUU9KldKBM0gjBWIm9lkRVe2Zm8bfHopSRKS5?=
 =?us-ascii?Q?h3YnPVrhBOMA5Pd3Jrpm3P8hIcYp4ln1t4fl8wcSVtwHu+X/SPEGIqeJiaWt?=
 =?us-ascii?Q?DlsEG+MbQG6TU91GpXP2u+mdmuojlTZW2sl5KSO7LIGRj39FusrZFsZPCcKG?=
 =?us-ascii?Q?Dv10jGgQajhZLC60nADuHfGYjc9DognkWC36eTJnP4Zvne51DXgep1IaXO2V?=
 =?us-ascii?Q?JxI31qeY+wkBXrM1Z0srnWbpRICTbSV2qDN+HlZja5JK5dcL+75mpM+v6qLi?=
 =?us-ascii?Q?s59/+1HGHw3RYIFiVvYr66rNP9URLgcfD8TbV6Ww+WrernSzIrq+rYyxQl79?=
 =?us-ascii?Q?bDacj9rxm5qFFGLUM3wmxbFLC6FmqumwErBimLUEf3V2xDCGs+qQGqz0eE90?=
 =?us-ascii?Q?Zg1pUziqNbYRX+0BF+ccwDmW6sw3lFaF6WlbTGlhvXUkoL6cVHA9CUCmrgyW?=
 =?us-ascii?Q?QoLnfe0/QNoE/M6u+wk6DGDrdOsxS1aQb6cwJJABYbNzSYRqpe2UquOaZgW2?=
 =?us-ascii?Q?uORTc07Bc0PnnT/FTttTEtsaIcGBVEfRI9L6FuSn4bjt/mO/difAIUqai4If?=
 =?us-ascii?Q?mgfYI4echJNs2k0nnRbV8KSn6O7bBUuOqdYmIV+zuaJ0SUz2WICstp+6Cax5?=
 =?us-ascii?Q?6TNplFixNaE4Rm2BXihgZGHdLCiG47HxVPk7Y1SAeJZGF5xWmTV/Zwb2UqW5?=
 =?us-ascii?Q?+jKWDu1mt75QrD1TaqU67RulzdTAL1TDn/uawfN3CvXnfho5XX8D8+iDIdJJ?=
 =?us-ascii?Q?phju4eRLIVBFjKG1BpzqtUoccoryqYmWN6iV7JntUmsGe9lDZK+Nd9rOD/jF?=
 =?us-ascii?Q?cOtHGA2ODA7ZZGOBEUx5zzm8Oqq/r8IIT3I/h7/92QULi+Ee6o44hK5/yn+1?=
 =?us-ascii?Q?2Oer/Nuskbw0aN2rpTGQH5pYfmuDGEoo394SaumSc30lt8oo4Yrlk4b2WlZS?=
 =?us-ascii?Q?zcNc16nloH0n4cWUAjEDUXRNAk9BWQNbxxCP5l6nzo6QLyucint/kv5yc6dx?=
 =?us-ascii?Q?Lfz1ll8tCNbB6GWIh0ri1PsKDjbUs5jQVyQuvVqkaUr+hZw8ZDye1wKXohyx?=
 =?us-ascii?Q?QeCRfv3IiFbEwigeM3YrbDs0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a80506-7dce-4923-54f6-08d963ee2a31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:21.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkQtfYXIyIO6JkfPkE2Lzwy4uerOnpd9ID//oMDKlXZZM4L2uZDNj9p9UdwRuScqoe5HVP5KHufVNk38cFVG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
 arch/x86/boot/compressed/Makefile |   1 +
 arch/x86/boot/compressed/acpi.c   | 113 +++++--------------
 arch/x86/boot/compressed/efi.c    | 178 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h   |  43 ++++++++
 4 files changed, 251 insertions(+), 84 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..d364192c2367 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,6 +100,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..3a3f997d7210 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -25,41 +25,22 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
  * ACPI_TABLE_GUID are found, take the former, which has more features.
  */
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
-		    bool efi_64)
+__efi_get_rsdp_addr(unsigned long config_table_pa,
+		    unsigned int config_table_len, bool efi_64)
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
+	ret = efi_find_vendor_table(config_table_pa, config_table_len,
+				    ACPI_20_TABLE_GUID, efi_64,
+				    (unsigned long *)&rsdp_addr);
+	if (ret == -ENOENT)
+		ret = efi_find_vendor_table(config_table_pa, config_table_len,
+					    ACPI_TABLE_GUID, efi_64,
+					    (unsigned long *)&rsdp_addr);
+	if (ret)
+		debug_putstr("Error getting RSDP address.\n");
 #endif
 	return rsdp_addr;
 }
@@ -87,7 +68,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
 	struct efi_info *ei;
+	bool efi_64;
 	char *sig;
+	int ret;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,18 +81,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	/* Get systab from boot params. */
+	ret = efi_get_system_table(boot_params, (unsigned long *)&systab, &efi_64);
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
@@ -119,54 +100,18 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
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
+	ret = efi_get_conf_table(boot_params, &config_table_pa,
+				 &config_table_len, &efi_64);
+	if (ret || !config_table_pa)
+		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(config_table_pa, config_table_len,
+				   efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
new file mode 100644
index 000000000000..16ff5cb9a1fb
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,178 @@
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
+/**
+ * Given EFI config table, search it for the physical address of the vendor
+ * table associated with GUID.
+ *
+ * @conf_table:        pointer to EFI configuration table
+ * @conf_table_len:    number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ * @efi_64:            true if using 64-bit EFI
+ * @vendor_table_pa:   location to store physical address of vendor table
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int
+efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
+		      efi_guid_t guid, bool efi_64,
+		      unsigned long *vendor_table_pa)
+{
+	unsigned int i;
+
+	for (i = 0; i < conf_table_len; i++) {
+		unsigned long vendor_table_pa_tmp;
+		efi_guid_t vendor_table_guid;
+		int ret;
+
+		if (get_vendor_table((void *)conf_table_pa, i,
+				     &vendor_table_pa_tmp,
+				     &vendor_table_guid, efi_64))
+			return -EINVAL;
+
+		if (!efi_guidcmp(guid, vendor_table_guid)) {
+			*vendor_table_pa = vendor_table_pa_tmp;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * Given boot_params, retrieve the physical address of EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @sys_table_pa:       location to store physical address of system table
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int
+efi_get_system_table(struct boot_params *boot_params,
+		     unsigned long *sys_table_pa, bool *is_efi_64)
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
+/**
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
+efi_get_conf_table(struct boot_params *boot_params,
+		   unsigned long *conf_table_pa,
+		   unsigned int *conf_table_len,
+		   bool *is_efi_64)
+{
+	unsigned long sys_table_pa = 0;
+	int ret;
+
+	if (!conf_table_pa || !conf_table_len || !is_efi_64)
+		return -EINVAL;
+
+	ret = efi_get_system_table(boot_params, &sys_table_pa, is_efi_64);
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
index 822e0c254b9a..16b092fd7aa1 100644
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
@@ -174,4 +175,46 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+int
+efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
+		      efi_guid_t guid, bool efi_64,
+		      unsigned long *vendor_table_pa);
+
+int efi_get_system_table(struct boot_params *boot_params,
+			 unsigned long *sys_table_pa,
+			 bool *is_efi_64);
+
+int efi_get_conf_table(struct boot_params *boot_params,
+		       unsigned long *conf_table_pa,
+		       unsigned int *conf_table_len,
+		       bool *is_efi_64);
+#else
+static inline int
+efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
+		      efi_guid_t guid, bool efi_64,
+		      unsigned long *vendor_table_pa)
+{
+	return -ENOENT;
+}
+
+static inline int
+efi_get_system_table(struct boot_params *boot_params,
+		     unsigned long *sys_table_pa,
+		     bool *is_efi_64)
+{
+	return -ENOENT;
+}
+
+static inline int
+efi_get_conf_table(struct boot_params *boot_params,
+		   unsigned long *conf_table_pa,
+		   unsigned int *conf_table_len,
+		   bool *is_efi_64)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.17.1

