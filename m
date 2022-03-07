Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652014D0A07
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbiCGVkD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiCGVhv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:51 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B58B6E7;
        Mon,  7 Mar 2022 13:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQIgLg9Dan9rj4YHphLyB0PMVMxYeWVd4AGPE8h4XVNp+avxa5sZn/f/TaZpAaQ4+vnqKdWJhmfo7ztoHxu2kVfy6B/FeitHu0blqXDs53LSlikXRCzWXDrZ+F21kZp+3ktqIgrJ/oMBInND2bKkAC18hjlc3IJ7ARQcgZMHPr1V+sIHB/roShJigtE4orrHyafMgEHrT/HLqSlhBBI5N/gaWhsSd2WOhzjbeMTPFrg39992/NwN/qF4QezTTHaO07KnsxOx3ydwgpPHTFOGD/YQnc4Jp8qQWRYI7scPX9dssfZq6dGwdeCGS65v3jfobvrsCDNOIF5bsxLo6lcDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=RyLavGtEgXErmXgDPDt5nxqAERg6vZlfAFQgFOmLOlozB6j02UchyXIL0sl4yAPda8MVUEIkgJuOYnIlGJ8GD+jjPuA0LDOUcBnnmLfD02Qdz5PvQk6I3mmkfjI8YJ9wRDQfcPOPorb5y1QLNlU4SYXMBgE9EOoUv80AO52+5dObGgz0jM6tqabQu3+cgTvjj+LSuUeXQYZZid9tZ665Jnx284DsSsf2aZfktww4g1GZcXYPqO3zX1kWx4KUooKyXndCyUEqBEekMgyBetc0BlhjEZ97C5htYtPG+ESAeQYBuzyxaQrl5FEt7ZXu1vMBAW1THT8T7JsS2y7JZf1rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=w/ZSZvbk5jQy9I7WyJjubNU7FsH7CpuV93g44z1Yg+u1cefu9qno/zuneBBeRq/TMPZ47rOuahO0eERmeIwRyvsP++J9GTCVRkgZxgd6CyZPPH72y6Ti9jqP2dWX1oHQHrCZYtSv304bX+UgsidUcxt6Hf63xFAD0IhgYFMKnbY=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:25 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::11) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:20 -0600
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
Subject: [PATCH v12 36/46] x86/compressed: Export and rename add_identity_map()
Date:   Mon, 7 Mar 2022 15:33:46 -0600
Message-ID: <20220307213356.2797205-37-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c445c3bd-609f-4a8d-295c-08da008263f5
X-MS-TrafficTypeDiagnostic: MW4PR12MB5603:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5603FF6C4FCD923B615E41CDE5089@MW4PR12MB5603.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7So/Kju6vIpxxeBZmLlhFQbsW34En/LnmWnZxRcrgnQdtgX1+gthAuD1TceG7QXVyjiZPGTR25BnmthJc6/dLE2tHN6P6HriSlBM+lZ1TXyhppffNAIk8OgJUeptkmiNtzC55Ut2LTCEKBR6SGf35RuuGTc1RokAMrZo3ngNkrFGbGpCQfvZ4vOXrI4uxKhB1hKgcjzNUMm72/+x9l7fPpzdJNUIqRBMWUYbYqMmsXVzWM9uyDwvg4G2Riwq3KIcjoggLVgTevxbuFstfgEXb3r7xrsxGv2WAGB0bEkzqVIkztwW6hj6Px00iX0C0M7oSgNJQ9dwPF6DjeElMcfu89t78ZFoo3fadG54XOl9D63kE9y6Lt0yUXgBsGSwLliPgSTD0ovROx4I6MGEzhmpKJRZG8QmA2Zkyo2SIaVRPfPqZuzvIkRNP+0zB9y8YWb/v1eHovGtkRmtkpY2a7o8vwdRrtY7KZ40jLrXTi15kFG96GgaGN79w+XTeY/C9Sxj2O6FRigXNVzIv3nwJJVy9wpMKX9EbpMuDksOzIVxH2m0CUNCOuYRI/os+AdVPtNVq5fIjPhjy1CU7m3G+G4NhikoCHCSTjx0B/6azZIsUq/TGFRKMYtjQ7cnI/fcTyHunASR9cJjQTSyZygsaA/uTBdNqWkNXuWeWvXpn0cXwmo/w9NumZDzdshBJaMQXYVSvUuNAvaI5BEYt6aYdgE3QCo/Cp9S1j3C079hjprCgbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(70586007)(70206006)(2906002)(8676002)(36756003)(508600001)(7696005)(6666004)(336012)(1076003)(82310400004)(426003)(186003)(26005)(16526019)(36860700001)(2616005)(316002)(54906003)(110136005)(356005)(86362001)(83380400001)(44832011)(81166007)(47076005)(5660300002)(7406005)(40460700003)(8936002)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:24.8325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c445c3bd-609f-4a8d-295c-08da008263f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

