Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7754E3BEE58
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhGGSUY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:24 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:45792
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232328AbhGGSTq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PML/qSV2+5/fvJNAepZGut+0A47b6bp5OrX4br4+nxiY+aaYuEWFWcZyT8gF1yZ8/a8SUzbdOMqfVp8hpKl4Tr67t3txmlppPwt8RGNUHina3JFT/jY5SYLThw9DhrQC6TDaf4/Sv7q8J4et0oqwpaekCDLiv0I6o9yy4lOA2g/qJ2/KvP5K9sH294Rw9zqj3vIZTFVXP5EhhwyW15JnNKijsIhPZjfKK05G7xelLl4B0bSaT0AzpIjK2UYEb9bC+28ICiCqf/GLM8bY41Nwhc3GFlVCgM1PCfn/qHOn6F0B1fVchLUSgmfrfJ2Xs8+Km/OWMJwcbQ3q1j7Lvcs1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRNMl3IXvWwOUax7hMfK5EO/9R9ig4gPmMuNhf+5sf4=;
 b=iLxM1E/6JVjXOU8d7bc/LV0UnoDMx6rloGSnUI8ptCVZouiVLBKY7PJ1W6ckQfl92aX//JQccbmsR5rO0UYpdcfw/JZlbXmeMzkdQAm7rE2xayCbg3bUhvAOzVLWXbXUCRqXyvOWCyYk7ZV8pz0gm0EYUPn4dCZyIRAs/14Nqk1s9rxtucNQuc8K8UMW1amxDx30clbwc5RhmoFJK/EfdXefhhBq5Nosuj+5nJ/+TNwkQ4L25N1Lo1AUwP20BISD65xWkgHBP1ZsEQGQSjykBlWoGU6Qq8SifVvgQfd4Svr3fYUNzqapWa9s5EM5tSvrLTB7fdTFyrN8PReeNqkTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRNMl3IXvWwOUax7hMfK5EO/9R9ig4gPmMuNhf+5sf4=;
 b=FFre4MGOuW3lT47d7JqPvTU7MCf1KAYJoagbAb10c5uMCVbfYorABZqagFMmFRERUfqGWUHXMjC7HEXt65HYtkBvXidgemdX4R49DgsOKqKxGuzSYJt4w/HDG29OTQlSbSn9PCUvCmu5DtA4+v+hyP7yC9CbW0GzmAG4zcUiRXI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:43 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:43 +0000
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
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: [PATCH Part1 RFC v4 29/36] x86/compressed/64: add identity mapping for Confidential Computing blob
Date:   Wed,  7 Jul 2021 13:14:59 -0500
Message-Id: <20210707181506.30489-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1199ba-bfe4-4e26-6ec2-08d941735f9c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683879AB26781D42CFB5EB8E51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaCn67UmncoOc+Hy9XOkkvj/CvAmCmp5j9gjhEfKqtqzftPfbKt+MJd2hlGc9ItAubTcyF/EP8eWFIjPUb/4E9p752/lVC+8DlEn17auBJ6rQKQU8qR2Z+JK4Br0pdEVtGAFnYjkPdLvtrBK+WKfOeDXDjVFSLZZYhknYokE3jpeF4Fv4cDEXlto4CBAvxjW5Sq9LSy8LKEs/qHdjJaKzNA+UMFV3SJWzxD2ap3mJbAiUjTy6lkTzHiLg3LnJQEWwO/gj0HmUlbp1UoVe7+CmW6YVtgckxToqjglDssqvZprYAAKWJcNzC6eDdMMEJWBEvCV0BxEIBDN//vSKpNnU/Q/JIRePM8inZ4y2+E30nR+zq6s3e/KwQfOgWMlwB4bhguAdyFNqL0WBCbqzpi/fsnEP/LtzV+tge5lHtmMW/T/cEISOZCvEpe6KQS8OYTHn5MuX1YxCxIbEiTF/PM4pUrlH2hpp2rAKPbDQYGh44CU8f37HN4RSusmBZ3EgKXQ6tFcK+ohWI7fNRXIG7doBNqFRg0XiVIk75xXV4u1M8Tql5iZVC/GPmPf3LIeWPcQ45eZjyjMLOmbqciLSy9SOa6QiLHvAVWZhPsziCMzm+uEe4nS6KemkKuDOlgRhJOK/oU/VsRJUN4HDp2R1Vcr1QseCsZ77YPRmifh/L0PbdPfEjQPfNV6BjimUmPAi6kY+aOz9crgQGJghXecU6J0oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a39YZzbwmD3s4QobiatcDUkIoQUJZ512OXaJiUSmfCjtYtUiugcvoY49LYF5?=
 =?us-ascii?Q?dYer0Su+IuJmPg13bbCZCWVBOA3vhDX16BUgCwaunr9gFVoyM6Rd0THPNyeh?=
 =?us-ascii?Q?DpFzFLYtWupzYh1L8ltwsoatxc67USoRmJ988vv9/tA1kmYbbSDfsHGEqJ19?=
 =?us-ascii?Q?a263mSw0D5o8LuLFiTsn3rGoclre9JUSjl4JWhpYcfIqW8mp6Yqt5xtXixxe?=
 =?us-ascii?Q?5iLqHN7teZyKp/un2cXb+2l0as41SyeW/AY1Dvywmb/5vgxgrWLP6SfuFWtV?=
 =?us-ascii?Q?QE28sIZNPEN+3aV/2g4mDWHUaEKkQTp1zBPEM4x/YHcx5XDY2s0NSTwpHX3R?=
 =?us-ascii?Q?9efaDlb94E4DZp25bfpUaqXAZKDyaH5nJIhGec0dcf2JKMNc473lUQASQMOP?=
 =?us-ascii?Q?w76pYBWZKrB1y/FUJ7if1L/ghmnlpDIO1hqvxeWGXkx8YtnSE1+6eE3G2dSZ?=
 =?us-ascii?Q?DLlKIeI3f6QcjtUPqt3LoVGLXkTTMnHyBEejD+GZY9ciH9/w+P0QLt0K+vZg?=
 =?us-ascii?Q?q0lcE/3LaMqRw/0izSu9E+39lNI0BqyXAqQnCmrUnt/eA7awiW7NXIgspCa/?=
 =?us-ascii?Q?3Z/czSuLN4jSEVf9lRD5aSk8Ap1LXQhqNMUH5sKtHm0qGxqzqMfcRUQYHsYx?=
 =?us-ascii?Q?0nWdsdxS4dKzTtYmbYmiM4XfnC5LoOsNZQdpizH63WpWjnU0+Nw6XX5fm9Kz?=
 =?us-ascii?Q?BdL8lKrgTeokSqCdzwHjgC5vKBWIFaoAQuaU0nYN3RVr5m55pxZ+r5HDKqCL?=
 =?us-ascii?Q?9YMc7f1Y12wLxYHBCY8ZBpT43bIT1YAA5BKrgYqurIdd5XmyOwSllaiz5oxF?=
 =?us-ascii?Q?+fQ1SXqQFfImXSQVdp+2cEwDYKOLwqu/eDiz7BwUqMCz03sBaD05Yx/w4Ate?=
 =?us-ascii?Q?CDGUJPtXIX6lN4u/KM/xpnApzUxWp8s5TCmCY8WdSL8wV40ZLOeN++CVf8nb?=
 =?us-ascii?Q?jiSoS4wOaFy1NTULmqMATKLAf4LSlyB61WEqbdQINIfLu5oJfxT0FqVd+l/w?=
 =?us-ascii?Q?lmDwZJLUIxlKTGW95i/tudVFEprAinQTsdNHW1WU6aNmA+MqsO0zjelTvv0u?=
 =?us-ascii?Q?wZKEZujIw9D9n+lPKLJFYGW3fXAazVhuSs7WmlEP94yxJ3bKvcAqOLX65eTT?=
 =?us-ascii?Q?XbQryy8+nMA3YSUnjGjwaAAZ+rk/id65irKRV00H2b+clN+0pdQx5o3fGSX5?=
 =?us-ascii?Q?y1wU3FEulL0eUjc5dvqymaGCxDmAP7mm4FRvJU29On8HXJ8YNkzzPqjRqPxD?=
 =?us-ascii?Q?2pOsJiuexrklOoCsU02dXs8vDfR35/JTM5kvH68QWEJe1PdCCk+miwl8rhCr?=
 =?us-ascii?Q?jedRRO3H0d0gdMi0edGHKUwx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1199ba-bfe4-4e26-6ec2-08d941735f9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:43.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51xZPWlTt+/V+0IsJPh/rOZWEqKMTQc6ePVfKh5L/+z5ZgDjbD7Ew9U/bvWzS1O+mFOA4OsrpoASx3R1T6uy9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At that
stage of boot it will be relying on the identity-mapped page table set
up by boot/compressed kernel, so make sure we have both of them mapped
in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 ++++++++++++++++++
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/sev.h              |  8 ++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 59befc610993..91e5ab433be4 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -37,6 +37,9 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#define __BOOT_COMPRESSED
+#include <asm/sev.h> /* For sev_snp_active() + ConfidentialComputing blob */
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
@@ -163,6 +166,21 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	/*
+	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * kernel to find CPUID memory to handle cpuid instructions. Make sure
+	 * an identity-mapping exists so they can be accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		struct cc_blob_sev_info *cc_info =
+			(void *)(unsigned long)boot_params->cc_blob_address;
+
+		add_identity_map((unsigned long)cc_info,
+				 (unsigned long)cc_info + sizeof(*cc_info));
+		add_identity_map((unsigned long)cc_info->cpuid_phys,
+				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
 	/* Load the new page-table. */
 	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 13a6ce74f320..87080bc4a574 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -123,7 +123,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	unsigned long low, high;
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e403bd1fcb23..b5715a26361a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -128,6 +128,10 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 
+#ifdef __BOOT_COMPRESSED
+bool sev_snp_enabled(void);
+#endif
+
 void sev_snp_cpuid_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
@@ -145,6 +149,10 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 
+#ifdef __BOOT_COMPRESSED
+static inline bool sev_snp_enabled { return false; }
+#endif
+
 static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
 #endif
 
-- 
2.17.1

