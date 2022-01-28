Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9249FF62
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbiA1RVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:17 -0500
Received: from mail-dm3nam07on2074.outbound.protection.outlook.com ([40.107.95.74]:21797
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343852AbiA1RT3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Di2MZGhM4/rSMxQPcL8GI5TnrGz7wz0rA6x2YCGuUpT6rJcL6MEJW/B9wo1AkYq5SgJwQg6J6DGzwIXXA2FncwAaRgZEZwCl2rxMJ2cbkSX3R10uu3QoOMtV6SqKhxUvFXdIh1fgo7HMjkt90aAr2gfQPz6iv2USUeJJgbPsU1ala1L11uEYndIri7a3cUt8UZTtQTXed36ro46orb3n1A4plWRWkghVt3z23Sg5LUJ/QO3lsGpx7uNv6kPf5kTMZc42s99edUr2vviv2M0nShXuG+N5oDY/819vBkgCAmuWFYnfp0QTbl6GHXe1TKt1KL61/wUXdpPTkKO9991w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJBCdw0q7FUGxJUrl5DLUlv4WxZ77PECuUfoXYQRC/g=;
 b=Jj2JA5wUkarba/omm6K78z0f/I3D1oSl4eGfp5yB1OfHOaO+I/dUULjF6tE6b7quFySSO3v+2phLauKLzoxp53alfXlPvFsa67/bbUSDnsskr6RpARECwg3yJNJSXv8SNe3ZXNeT4rKJwrRjpqkDLja6M11c5EzW+NbT3xYUkZxrduGGLxV4XoMkZdTJCFzMwo1MoamuuoBhnLBwBpV8YPX7DVlPF13dvsb+Kol8+mxtBWMMuk6R6y67eZOnbFKiuZsXi0qSxbTag9IHhXrfBFqjwVL4NrwFv0Q9HDTTUhi1pE30ke7fgbH5nL5dCO+uIEm0SJ8LQg3aNcD5mIYOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJBCdw0q7FUGxJUrl5DLUlv4WxZ77PECuUfoXYQRC/g=;
 b=RuD4n7OoWJMCygkVOyGxBiAN2KLxmAoTBxp1UifSGtoiWnKoeQXvim/B/YjdWdBtWx4FHXlrg3wlr43NY9IxUrs2j59v4KKtPDnlFHsJhnzT7766TIQKq9nXxMvXG5H1OlXal+vbcfZ6K7tuTyp5UDG65yWn5Zhnvkn14zL42TU=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 DM6PR12MB4764.namprd12.prod.outlook.com (2603:10b6:5:31::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Fri, 28 Jan 2022 17:19:26 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::a2) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:26 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:14 -0600
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
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v9 35/43] x86/compressed: Export and rename add_identity_map()
Date:   Fri, 28 Jan 2022 11:17:56 -0600
Message-ID: <20220128171804.569796-36-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd1c0b8a-d0ee-42b3-e948-08d9e2825616
X-MS-TrafficTypeDiagnostic: DM6PR12MB4764:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4764B03C23D7956E287F3E31E5229@DM6PR12MB4764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5xwjdTq9t1gex45NS8hqBocqUhidquzWSSoQbbh8IfoLGxfRjKCM1KN3eNlUmzCPbgYuh7z4P7fUx5AstnfRjdmVaY7rIYExOJBJZYXRj/vDNGfHruE14jSwsw4LPT2LKR0lFixLt1oCW3A2fm52qqWTfBD3Z8/ggB8V64Uf+eXd5h1pP0kZH7HAMK19x5LMjeMr5xzi66jEtLJGAoGOGg1WPrXCSJsCTih09nZqnh6d/KXsQ8YoFpnrCyW4AomfTOgUQF2G5kRIDhhbQVo97lO70RluF1TM51sgeADj9psETW8VaOE36dfBOxx7Oad8rEYb2U8i91WjWl0gQ9C4YoaCAXJtum85ZL5wefL7YJQWwCoyRPPZ4oSvQ+nwQSagTgHXpaYXTMhaKk3wCVqSpQjKXjdpS4Mk5+u3j2h8+BTUsKVGtiE+bmiF1jLlNlPMljNTbMcbD+QRu1k6mwIWhUi+oD7tGXjITh063towac8G+FKDP2La11gDiFmwJpvHcccXIh14DF3zlX2o/HAH1doeBkolaO3/6uR/5TdDQ0T6aOQ2/1adcSVQR9Q7ghqJPpkJm1+NJ2PU0RRjsLOhnhkDWI73X4Mlm1CPPnr8JuXn9yVQeRiVmOSBMpXYnHSyikHicNX5Jc8V00xvfilWDY36OA6Cqq624N9+xp/6DVpyvpKKkJhgdIyR5fW2IDbfGTuzj9uw+XSVkCi266uBdDnkSkI4wllqYplrauxXU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(2616005)(82310400004)(426003)(40460700003)(4326008)(83380400001)(2906002)(16526019)(86362001)(47076005)(1076003)(336012)(7406005)(36756003)(186003)(8936002)(8676002)(44832011)(70206006)(70586007)(81166007)(54906003)(110136005)(6666004)(5660300002)(356005)(7416002)(508600001)(316002)(36860700001)(7696005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:26.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1c0b8a-d0ee-42b3-e948-08d9e2825616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4764
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-specific code will need to add some additional mappings, but doing
this within ident_map_64.c requires some SEV-specific helpers to be
exported and some SEV-specific struct definitions to be pulled into
ident_map_64.c. Instead, export add_identity_map() so SEV-specific (and
other subsystem-specific) code can be better contained outside of
ident_map_64.c.

While at it, rename the function to kernel_add_identity_map(), similar
to the kernel_ident_mapping_init() function it relies upon.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 +++++++++---------
 arch/x86/boot/compressed/misc.h         |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 3d566964b829..7975680f521f 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -90,7 +90,7 @@ static struct x86_mapping_info mapping_info;
 /*
  * Adds the specified range to the identity mappings.
  */
-static void add_identity_map(unsigned long start, unsigned long end)
+void kernel_add_identity_map(unsigned long start, unsigned long end)
 {
 	int ret;
 
@@ -157,11 +157,11 @@ void initialize_identity_maps(void *rmode)
 	 * explicitly here in case the compressed kernel does not touch them,
 	 * or does not touch all the pages covering them.
 	 */
-	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
 	boot_params = rmode;
-	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
 	cmdline = get_cmd_line_ptr();
-	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
 	/* Load the new page-table. */
 	sev_verify_cbit(top_level_pgt);
@@ -246,10 +246,10 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	 * It should already exist, but keep things generic.
 	 *
 	 * To map the page just read from it and fault it in if there is no
-	 * mapping yet. add_identity_map() can't be called here because that
-	 * would unconditionally map the address on PMD level, destroying any
-	 * PTE-level mappings that might already exist. Use assembly here so
-	 * the access won't be optimized away.
+	 * mapping yet. kernel_add_identity_map() can't be called here because
+	 * that would unconditionally map the address on PMD level, destroying
+	 * any PTE-level mappings that might already exist. Use assembly here
+	 * so the access won't be optimized away.
 	 */
 	asm volatile("mov %[address], %%r9"
 		     :: [address] "g" (*(unsigned long *)address)
@@ -363,5 +363,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 * Error code is sane - now identity map the 2M region around
 	 * the faulting address.
 	 */
-	add_identity_map(address, end);
+	kernel_add_identity_map(address, end);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 991b46170914..cfa0663bf931 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -156,6 +156,7 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 #endif
+extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
 extern pteval_t __default_kernel_pte_mask;
-- 
2.25.1

