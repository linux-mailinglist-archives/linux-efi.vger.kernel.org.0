Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9CF4C3315
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiBXRB6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiBXRBa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959CB3E40;
        Thu, 24 Feb 2022 08:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTohIFOf8fXsbwhlt5tAHrPhIsvAGEIPrqoVf5evIKw69EAmd0w+8UKCo/+YGBpYjUUYRo7vYiGTm6bjbCXUttFgJtw/kEpWzp84smbsYb16mwQ/+owVWGx2QV5nV5Ex2MR4HivMpCrqK+2sFlLPk0qL6hZvdPCGyg/2wFdpn0S4Fm0miWFQsOJPsm3dcGWHDoUIeKb0y+RwExj7+WgL7fsIJElgpVE72wxB6dHDGIvag+wp9l24qex0yBT8gQtlBjww+qTaIvyBGSFgAespHCRsw2cKh/2AyOoJp/XmHtQIxYwJiG0AEP/X4o8OUSCpKq8j9yW9IrEJnGHLFjC2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=jhdVid7883ymihSDCppvGFRs/b7MW9oq4G9OQzWb2E7kK+y4OuOOlW8CF4gJWLTEpovJABzuTQCHY76aOgpZpRVptDlDYAsBAhN18L2+AGbqVUvrtoNmoHZTlAV3Wi9mLrid/U5PEvuApZLSMvRbjc2ZHr7Yi8GMgRnOUkNU7k/th0q5aCvZmBwH8cGm/LPKhEn56aLK37muKWRsLA3+qVIaJvKisg1h5r+SRbhOM7iAHTUGlO2SjkxmwPAr88viLdbcDM9WOUbOhvH1ip+T6pibh7teQyE6j99XA8VlEFece+m4be8put7bXaL0VGp/19dGodBMibaI/fRPNpXQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=yoxcn9HSqvQIK+vYyQyvczI9OgFIWrqkQS6Y4mZElzC23dF6UYkw9j181TfeLx77Oeb8W+9lPZkWpJzvD4qHTNfsORPlGQzN7TfkkqtBv25hluiVBXdOjvFEHW0V8VCmQBsACMuS0g+xTZ7yNLPiUnnAizjOMpDhDimZD5R71Vo=
Received: from DS7PR03CA0171.namprd03.prod.outlook.com (2603:10b6:5:3b2::26)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:59:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::16) by DS7PR03CA0171.outlook.office365.com
 (2603:10b6:5:3b2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:02 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:55 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v11 36/45] x86/compressed: Export and rename add_identity_map()
Date:   Thu, 24 Feb 2022 10:56:16 -0600
Message-ID: <20220224165625.2175020-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c6dec0-3bdc-449b-28f2-08d9f7b6f5e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2921EAFDF3982F5E433A40EFE53D9@DM6PR12MB2921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baS77S7zbTRqbZK96mFddaj+wCDjRqCvcFQCy3YF8VSYKQ3/ed22Auq7qlBD7Zpw+Dn+P6sSJgOIr+blJV39zCcpIem6QfS5x//QxgnV3pLQ+LKV/lAtrJZFupd7LKgfKK6OrR9TCnhbAf70iZ1zgnVh4unhkiKo9+MLkxQD+muO5I08Cce5c1MUCMoy2PxRy5k7XqQMnNN/QhdkToHinUd4b7Rg3lAxuosvqbdGexKpEPjNUvqkjM7JhAfSzM+b9f4Ukn5LX4QA3RXjiXOjdF26VCtrNbgPh9QZVhxxOM7UX9pdBiGOPYy5Lr8FMrY2m8jZDYGMYl+G/hRRpTYu40LGWwQt5G/eRt/ZLOFK8WhsA2Z1XSk4ac7BsOwnRTlPorA4bk3gRw+YXvHcPk3nyX3gW5iMpp/bNuXdyWgTyl8zylqrE9R4Yjq4pZlQVpiIZGhoL19hGtgiCPnV3v2v2xG2mJ3D1oKZqLs+S/FaRjyk/ljuImjDxqGxPsOXIn117oxohO/oTf6+iYLRbpxX1vMx/8eH7FGmlfcND95yE9nnN5ePZ5dNSlzXgTCtL0mKfHcd3V/jqrYyg6AnCReIKKnOopknbR+8GlZzmHJUwyIi3eFSnv7nto/54AcwXLYmJpjpTokpge824PuHVeAcRVgNvVSeZmqzUTZ8wus/2vRyI6yFD7gtmftT1CXANAKRbjS8kfaoV6WP8qLfSeGPRc63Qi4HnFeo1gMae5FTev0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(70206006)(70586007)(40460700003)(8936002)(8676002)(7696005)(36756003)(7406005)(316002)(5660300002)(7416002)(44832011)(47076005)(54906003)(6666004)(110136005)(508600001)(86362001)(26005)(1076003)(82310400004)(36860700001)(81166007)(356005)(2906002)(186003)(83380400001)(2616005)(16526019)(336012)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:02.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c6dec0-3bdc-449b-28f2-08d9f7b6f5e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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

SEV-specific code will need to add some additional mappings, but doing
this within ident_map_64.c requires some SEV-specific helpers to be
exported and some SEV-specific struct definitions to be pulled into
ident_map_64.c. Instead, export add_identity_map() so SEV-specific (and
other subsystem-specific) code can be better contained outside of
ident_map_64.c.

While at it, rename the function to kernel_add_identity_map(), similar
to the kernel_ident_mapping_init() function it relies upon.

No functional changes.

Suggested-by: Borislav Petkov <bp@alien8.de>
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
index ba538af37e90..aae2722c6e9a 100644
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

