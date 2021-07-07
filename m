Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5F3BEE61
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhGGSUe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:34 -0400
Received: from mail-bn8nam08on2080.outbound.protection.outlook.com ([40.107.100.80]:33248
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231397AbhGGSTu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbmcIyYycTRvJFwERY6PYuXOcOKjHYhTD8aYin/j0o0lykZXqMBrfFLHo8nFPpVoTw0PS1jmUSYKRoyyRJcnjsP0GfkU0FqaVUkgyYvAmGBbMz4zNSPB0Wn+VnqvyZDB/g6wrru6DCfBwGQGbAI24BUV1zS646pTsFaCL/gacGuQzT8beZ91ksfzJetI5BDVnmNoYhtiZfPFs+Rk7pOgpxrtacvrWW6Cr4hvfZgqRXP3v4ijRwA70N5NttxTZ6W6m5pl41oGGuGwM2IBNBl/QJx0pX1unRm15P4WkTzTREOUvJZbH8mYqzIWmUAxz7jGRYdX9zLmbTi1yL7zsAvyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCX9j8VzBE+xI2TTVKjFIAC7uhiRvxIGP2aZiYXM0cA=;
 b=fQtyIDjK8gSAHPga9MLLt7FEcBIZejQ8u04Lu6IYMt5VH+ghka0QaCrZVZbvbee/nvYC81SdgoWnNSEhvOr8avDujw1YiWXy/Nki0ibcaPxe/KmTNc6Nft338FgxPMSJNef/4DZesrIEWwO/3LtKIpqNNDMLhPwItc3OSMlJ+8YwG4a/0VcF3Nfd5CAN99jcbp2poTJ7j8zDEosUmKMRbvj0PS/cjpvGna2nJdS+Tk4pIXLG7UZjezPTchNzS3+cPdtoJGitLtgvo7ThJepQb3cBbBOT71ZBiA5D8h0LfdBhdIEAuCLG2G7N0+t/2y/rfdDnMrDAMo+tWWztGE7xFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCX9j8VzBE+xI2TTVKjFIAC7uhiRvxIGP2aZiYXM0cA=;
 b=GbtOTZcSrIKQIJavMY8AVoJnMxgUAfJMJdKoe3jsJ1sWOikE3/8MhdYUXn6kjUXYmAvV+ylA98iVlJTH//kCt13LlLIyiEyWhMRQ7y9s0KGGhLlYAqoBJ4Ck7puog85UuebdlwJiMa3Z3KC3k6rXP8JtVRcZdGBsGzk+QCTJ6OU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:45 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:45 +0000
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
Subject: [PATCH Part1 RFC v4 30/36] x86/sev: enable SEV-SNP-validated CPUID in #VC handlers
Date:   Wed,  7 Jul 2021 13:15:00 -0500
Message-Id: <20210707181506.30489-31-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010ce0c8-6592-45c1-61f4-08d941736110
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683AA57DDB7B46B49BC5824E51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmIfSiwnQYoB7W03qR//iVeHdKGPMYeKK+MKz9vkxGA6LRGXNx80LlKYB//z6+TbYRQ66Sp/OBqWBzlIyr9Rt2J6O02v9F5eCmfLZRO7qzU2dOjwrM2jMxQjNsEz8haR53x6x+dryU3UxVhxd1li6gTVPJCl9CGUB6+7g+LvaE+ncBADWLHgCUKLOzj8erx9+wYYVS5ZaiaHPHQlti951yTXB8evthMPP7KQxKziktrECzVCk7x+TC1oEjNdWJMymEcd+/FmunecC6xkkpjJ9TypI58UZ3/WhxJjAbWH6YPtPL2Q3gkVp35XtSAPGrpJm3nkzsRFLPeCK/zfXpAy5X9FmvfnPM+K0UBELkmzAhjNAcrR59O3shwbEwpWZviUWbzzoGGt9tWygTz6SUd2GsfQH1xlM5C/98X41NFMi1T/torrlHpldg2dxEP3UzBFw1locARK1YLIhErpOajwf/4QANOe1MjbWwuMg3wDhxiLjq32nr56Y3/SxNcMTIi781p1Y0sX+Fz1FFoVq00yklkxor0VgkSOk+lp5/aOb+6k3DxcgIiAuEiaa5w/v7+WPeM96CjeL/lUgTLURkHHwunpdFuwYgHuWKSzdrUxlpEyCl5IcP5pxN/9nJ6zNZpitYaf6Lkm3WM1glE9dwd57KYP6PK8lM8o3upXW3gSRnsA9zuTxNnrxCTYS3D2HcgDKFLVWZyEpHHICTBm8vxsWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(15650500001)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(30864003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXbL1FzXe0BAP4wT7l26VUk+znF17NWavtWpc7ytf/axMIW3D/2GfFYEbSrF?=
 =?us-ascii?Q?IFQAwUsw+3cK7PmFcs8ckG65sW9XW7+9fZs8wSFFGs7dbBWgtEt/OE0WMyZI?=
 =?us-ascii?Q?CZzR4Tn9+N2PL80+f6c0JEA/QNA4GjTbf8e2xKUArItu/YPvA+VJ3Wd4hKgC?=
 =?us-ascii?Q?+SqWXEoTN2Qs4/Ru6e2Ki/23UlVakHvTtp0KDckc5NUXVrVN4WcuP04JEW5O?=
 =?us-ascii?Q?rp0CBPpUFiV1gX4vA28sWwLVT1r2P0K4yxrcXS9HdDt5fkjbq1P5YkkBHX8i?=
 =?us-ascii?Q?wG6L2ht62+XIAopeimIU7DPBLkZJYH083Ae+LVtb+dFUgV3WhVWLmvT30H9Y?=
 =?us-ascii?Q?wJ+HJIFO0XVi28935XJMWskXXDXxZE1XHJJjkRyYVg1e40lGZXvpeItd0Hah?=
 =?us-ascii?Q?4XkFuYyVOZHZmhUaNhxqkePQc8mzrPysMJFgCkSx0dJCZSaFC+mEku/QwZUZ?=
 =?us-ascii?Q?xav2lLZdebtnM9fa74v98RgwuaiaiDvdDrUdKhckdRmCAnDOkqEu/7YaP33K?=
 =?us-ascii?Q?g6EVZiA49N6whpkd4vBOONRElCZvr3UbmP9FkUlo0aiPNkaM9uTrfPEzVvp2?=
 =?us-ascii?Q?Md71vHssNTETpkl7JqAJpTBf+DcLZRkn4BmaniJExrcB4tPrZ0XcYZ3/8pVt?=
 =?us-ascii?Q?AE/ZDST0upSRMvVcBwqbM1CHscqghRNcjFSSnkT/gxqLosfUW+OXei+BcamP?=
 =?us-ascii?Q?spUYow5TIUgx4AP55V4TK3F0wiFQtYsxd+7uCMlwvvJorL9sf5YTPJPAT8Ym?=
 =?us-ascii?Q?anl62ZfgRorHGBRKJbCxQWdKcHKr3O6jwy6pUKBA+cCrLsMWlr6npU8p7qtc?=
 =?us-ascii?Q?CpBLEALun8ist3d3d/OdDB0if1wrB63+pg3Va4eU6MXbAR0hwV9K0fr4zEap?=
 =?us-ascii?Q?pTeB/hpOuqXtD7hu1jesiYfhnu+qYqE0SVGKDAPDssnI1BoJU7RoVD6DQaTJ?=
 =?us-ascii?Q?WNHvFgg4Uo4PABTYaZ+IkJHXnVIEduImYntT/Dbo/yg7S6vSmwYrXDUDSLnc?=
 =?us-ascii?Q?Q1TRQgWBw/OLOeHWHzT/RRTCRJmQY77pU3Ax7gaNsqypZDZPn2jj8SblqxUG?=
 =?us-ascii?Q?JDO92oWlsQ3aTUxKL8Cu/1CcjygemMnWesH0X95qwZPfpyZt4Dt+T2NxxvH6?=
 =?us-ascii?Q?E9RlqDQa07u63usE9en72U9E5PXme8ygnH7Qbe5B9VuvwIDh4kBPZgDaYruo?=
 =?us-ascii?Q?9WkawGW1m7vU190rdSDEiy6VES/MWrB8FQAy/j93ozQJdgQoYf6jvdeRXi9a?=
 =?us-ascii?Q?7GOckXqZhAm6ZbGkM0AH2rnA6muV8ohsJp2970Y9Qe/3dwwA4yXJz67TD5O1?=
 =?us-ascii?Q?+SN1ZuEc0rG6tTw/gqurldUZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010ce0c8-6592-45c1-61f4-08d941736110
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:45.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH85+XoDjSD3G3RX04gVaK8nuSYgud8UKXInkmVC7D8b4/GL/LVSdlj4ljAHaM1wN7uRcDUsPsfx1TSW6H+l1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This adds support for utilizing the SEV-SNP-validated CPUID table in
the various #VC handler routines used throughout boot/run-time. Mostly
this is handled by re-using the CPUID lookup code introduced earlier
for the boot/compressed kernel, but at various stages of boot some work
needs to be done to ensure the CPUID table is set up and remains
accessible throughout. The following init routines are introduced to
handle this:

sev_snp_cpuid_init():

  This sets up access to the CPUID memory range for the #VC handler
  that gets set up just after entry to startup_64(). Since the code is
  still using an identity mapping, the existing sev_snp_cpuid_init()
  used by boot/compressed is used here as well, but annotated as __init
  so it can be cleaned up later (boot/compressed/sev.c already defines
  away __init when it pulls in shared SEV code). The boot/compressed
  kernel handles any necessary lookup of ConfidentialComputing blob
  from EFI and puts it into boot_params if present, so only boot_params
  needs to be checked.

sev_snp_cpuid_init_virtual():

  This is called when the previous identity mapping  is gone and the
  memory used for the CPUID memory range needs to be mapped into the
  new page table with encryption bit set and accessed via __va().

  Since this path is also entered later by APs to set up their initial
  VC handlers, a function pointer is used to switch them to a handler
  that doesn't attempt to re-initialize the SNP CPUID feature, as at
  that point it will have already been set up.

sev_snp_cpuid_init_remap_early():

  This is called when the previous mapping of CPUID memory range is no
  longer present. early_memremap() is now available, so use that to
  create a new one that can be used until memremap() is available.

sev_snp_cpuid_init_remap():

  This switches away from using early_memremap() to ioremap_encrypted()
  to map CPUID memory range, otherwise the leak detector will complain.
  This mapping is what gets used for the remaining life of the guest.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/include/asm/setup.h    |  5 +-
 arch/x86/include/asm/sev.h      |  8 +++
 arch/x86/kernel/head64.c        | 21 ++++++--
 arch/x86/kernel/head_64.S       |  6 ++-
 arch/x86/kernel/setup.c         |  3 ++
 arch/x86/kernel/sev-shared.c    | 93 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c       |  2 +
 8 files changed, 129 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d083c873..ff0eecee4235 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -63,6 +63,7 @@ extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
 #endif
+extern unsigned long initial_idt_setup;
 
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..12fc52894ad8 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,8 +50,9 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
-extern void startup_64_setup_env(unsigned long physbase);
-extern void early_setup_idt(void);
+extern void startup_64_setup_env(unsigned long physbase, struct boot_params *bp);
+extern void early_setup_idt_common(void *rmode);
+extern void __init early_setup_idt(void *rmode);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index b5715a26361a..6c23e694a109 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -133,6 +133,10 @@ bool sev_snp_enabled(void);
 #endif
 
 void sev_snp_cpuid_init(struct boot_params *bp);
+#ifndef __BOOT_COMPRESSED
+void sev_snp_cpuid_init_virtual(void);
+void sev_snp_cpuid_init_remap_early(void);
+#endif /* __BOOT_COMPRESSED */
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -154,6 +158,10 @@ static inline bool sev_snp_enabled { return false; }
 #endif
 
 static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
+#ifndef __BOOT_COMPRESSED
+static inline void sev_snp_cpuid_init_virtual(void) { }
+static inline void sev_snp_cpuid_init_remap_early(void) { }
+#endif /* __BOOT_COMPRESSED */
 #endif
 
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8615418f98f1..de3b4f1afbfe 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -567,7 +567,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void startup_64_load_idt(unsigned long physbase, struct boot_params *bp)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
@@ -577,6 +577,7 @@ static void startup_64_load_idt(unsigned long physbase)
 		void *handler;
 
 		/* VMM Communication Exception */
+		sev_snp_cpuid_init(bp); /* used by #VC handler */
 		handler = fixup_pointer(vc_no_ghcb, physbase);
 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
 	}
@@ -585,8 +586,8 @@ static void startup_64_load_idt(unsigned long physbase)
 	native_load_idt(desc);
 }
 
-/* This is used when running on kernel addresses */
-void early_setup_idt(void)
+/* Used for all CPUs */
+void early_setup_idt_common(void *rmode)
 {
 	/* VMM Communication Exception */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
@@ -596,10 +597,20 @@ void early_setup_idt(void)
 	native_load_idt(&bringup_idt_descr);
 }
 
+/* This is used by boot processor when running on kernel addresses */
+void __init early_setup_idt(void *rmode)
+{
+	/* SEV-SNP CPUID setup for use by #VC handler */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		sev_snp_cpuid_init_virtual();
+
+	early_setup_idt_common(rmode);
+}
+
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(unsigned long physbase, struct boot_params *bp)
 {
 	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
 
@@ -623,5 +634,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 	 */
 	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt(physbase, bp);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..78f35e446498 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -218,7 +218,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Setup and Load IDT */
 	pushq	%rsi
-	call	early_setup_idt
+	movq	%rsi, %rdi
+	movq	initial_idt_setup(%rip), %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rax
 	popq	%rsi
 
 	/* Check if nx is implemented */
@@ -341,6 +344,7 @@ SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+SYM_DATA(initial_idt_setup,	.quad early_setup_idt)
 
 /*
  * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 85acd22f8022..5ff264917b5b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -47,6 +47,7 @@
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
+#include <asm/sev.h>
 #include <linux/vmalloc.h>
 
 /*
@@ -1077,6 +1078,8 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
+	sev_snp_cpuid_init_remap_early();
+
 	idt_setup_early_pf();
 
 	/*
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 23328727caf4..dbc5c2600d9d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -264,7 +264,7 @@ static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return 0;
 }
 
-static bool sev_snp_cpuid_active(void)
+static inline bool sev_snp_cpuid_active(void)
 {
 	return sev_snp_cpuid_enabled;
 }
@@ -905,7 +905,7 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
  * indication that SEV-ES is enabled. Subsequent init levels will check for
  * SEV_SNP feature once available to also take SEV MSR value into account.
  */
-void sev_snp_cpuid_init(struct boot_params *bp)
+void __init sev_snp_cpuid_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -941,3 +941,92 @@ void sev_snp_cpuid_init(struct boot_params *bp)
 	if (cpuid_info->count > 0)
 		sev_snp_cpuid_enabled = 1;
 }
+
+#ifndef __BOOT_COMPRESSED
+
+static bool __init early_make_pgtable_enc(unsigned long physaddr)
+{
+	pmdval_t pmd;
+
+	/* early_pmd_flags hasn't been updated with SME bit yet; add it */
+	pmd = (physaddr & PMD_MASK) + early_pmd_flags + sme_get_me_mask();
+
+	return __early_make_pgtable((unsigned long)__va(physaddr), pmd);
+}
+
+/*
+ * This is called when we switch to virtual kernel addresses, before #PF
+ * handler is set up. boot_params have already been parsed at this point,
+ * but CPUID page is no longer identity-mapped so we need to create a
+ * virtual mapping.
+ */
+void __init sev_snp_cpuid_init_virtual(void)
+{
+	/*
+	 * We rely on sev_snp_cpuid_init() to do initial parsing of bootparams
+	 * and initial setup. If that didn't enable the feature then don't try
+	 * to enable it here.
+	 */
+	if (!sev_snp_cpuid_active())
+		return;
+
+	/*
+	 * Either boot_params/EFI advertised the feature even though SNP isn't
+	 * enabled, or something else went wrong. Bail out.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* If feature is enabled, but we can't map CPUID info, we're hosed */
+	if (!early_make_pgtable_enc(sev_snp_cpuid_pa))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = (const struct sev_snp_cpuid_info *)__va(sev_snp_cpuid_pa);
+}
+
+/* Called after early_ioremap_init() */
+void __init sev_snp_cpuid_init_remap_early(void)
+{
+	if (!sev_snp_cpuid_active())
+		return;
+
+	/*
+	 * This really shouldn't be possible at this point.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = early_memremap(sev_snp_cpuid_pa, sev_snp_cpuid_sz);
+}
+
+/* Final switch to run-time mapping */
+static int __init sev_snp_cpuid_init_remap(void)
+{
+	if (!sev_snp_cpuid_active())
+		return 0;
+
+	/*
+	 * This really shouldn't be possible at this point either.
+	 */
+	if (!sev_feature_enabled(SEV_SNP))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* Clean up earlier mapping. */
+	if (cpuid_info)
+		early_memunmap((void *)cpuid_info, sev_snp_cpuid_sz);
+
+	/*
+	 * We need ioremap_encrypted() to get an encrypted mapping, but this
+	 * is normal RAM so can be accessed directly.
+	 */
+	cpuid_info = (__force void *)ioremap_encrypted(sev_snp_cpuid_pa,
+						       sev_snp_cpuid_sz);
+	if (!cpuid_info)
+		return -EIO;
+
+	return 0;
+}
+
+arch_initcall(sev_snp_cpuid_init_remap);
+
+#endif /* __BOOT_COMPRESSED */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4fc07006f7f8..d3f4993b89cc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1041,6 +1041,8 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
 	initial_stack  = idle->thread.sp;
+	/* don't repeat IDT setup work specific to the BSP */
+	initial_idt_setup = (unsigned long)early_setup_idt_common;
 
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
-- 
2.17.1

