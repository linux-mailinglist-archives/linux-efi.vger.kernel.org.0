Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553874AF99E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiBISPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiBISOr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:47 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B0C0302D8;
        Wed,  9 Feb 2022 10:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVcp/aAwYSSIhrFAAClBsr6yvmKiC6+26ClMnrkAx5DtA58XjjtwxkpRvd2rYbT/UbNSuyvNXLCQrORsqEKVCspvE/lbPu8D6j0TTLPoTmGeJhtohdgPLzMaRcJpansV1StweucTLo3WHhf68aXMwHklgYdivr0uP3S6J1pQ6tYL+NC3RNnItkRKS4NFTViBfgmWPZSNyBomN0ptmA2wwa00lL3c8ebNdq4i6+3y/VpthvrD2/yq70PGjasteThnv6NRmHhUBA6DpVByDZDZn2kTKu00PT0vuJehEjSTkIFGETS/Mk6MtJs550qm7wzTaIn2IDjwzvunpEnqxEQvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=M20frQKni+SqZLInXDWABCWg/ew4s0V9lcDsFXfHL0E0lgjaRBSIGJHpJygw9uk0H4OPSN7uaVpIIHO5M+Cysk9zNWqe4CS8V0PfE8uFxqI36mA3CxEoqIMIk0R12Zpk5e0YjFqTw7vAFkJ/JIWq4kx5QKboUpAdVEbajamGkT76zMoNY3sXvRUIhWDNsROa6Z6cualMLZrKJplbEmDC2cq6K0YknNSd+1vqcFVzjNy+rFq/NjfCxKLlHdVOmKEl5/322MJd3k/C1NeNdBtlPyQp1t8+yZXBDhz/+WOC4VEWNE/IXtpk171R1lqilc9+zaPLY2+FhBljtoFJlm/chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONB4YuxHXa++hwuSa4pidiloNkIVh6LyvbA7ZAHShv0=;
 b=z3C/pmxgbogstHs0w0dsQfIsOMo6ZMTpXfVqLlpNTUufS02zpFv2kiLJNJmKyVKorFO7DGG3bdCIH15+IJ/9Kyr2ZaixgdUPNhmq++fueUClHzjdYG+o5Oys2jkkBKByUzuk8ZaqoHXjalSInHMmbI8bUHRXB2xKW2salCCDJuc=
Received: from BN6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:404:65::16)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:12:32 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::bc) by BN6PR17CA0006.outlook.office365.com
 (2603:10b6:404:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:31 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:27 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v10 36/45] x86/compressed: Export and rename add_identity_map()
Date:   Wed, 9 Feb 2022 12:10:30 -0600
Message-ID: <20220209181039.1262882-37-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b3536b4-848b-4859-1f71-08d9ebf7bd7d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB527897BE933048AB0CE131D7E52E9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm8HVSFqRyHXFuvg5aZKg74dGA9xp5xCuHJH+2m+w6Z0ZO4FkE+3Swm3aU4kD4+8FjLu+WOx77nCouAcG5PcTJcnJzFccdaj8+VdAkItDrhBM9msorsloDtlMwtCHm0fhooDm+Wm6wfd9PHaOVkTupzyduG4MwyC6PpBylU00xfogmlOrWUyBWXrihsLujIb1ufGxQ3aHp4OGpkK+tZqU6aowv/eZHhTLc/5OUpDCyQFNgi4VmMrifPSfhem59NxRGiydvpdhLUxmfrxBTRh0/9di3AAvXENkUbDvG1xR2LMj1F0odhVKrwEs2i7Oiv3GoYc2Rpc/CkmBsHqfOUCiZCyRgkoJr+O3L3bqFPzOi/D3ZRjbrNR8q1ttTLDIjPart5zPCx8P2LVQZdcfO814jmAe/605QErw/e1H6e/QyDLAiqmT2lQs5+VcgmsVWpZjKmyH3PlZpd5ah3kNjE90QgHCUaclj/10NASimAkLuDCFB0WEs0pegIm4uQLeZYgC+60bdLvP/1yQjodk0ZRNeoyo/EP4XOVkzOZ5ipDFUA1leg6xVx4fsGRbn9tVAVZnpQsXJpnAEKBMxjbZhqaSnMerZCNI6GV68sOxeEP/oTXI0WaH319yjtti4cnn8DB9ZtMPhZEzStpTxpbtZHCFq6Qu0trs9I4iwQgDFsRekfu7Hh2sOC99XB9GpEcgvocxfWUMx+9LMdimXT1NaYLYLrIDc+jiSfVFIn2uCnTYRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7406005)(356005)(36860700001)(426003)(7416002)(36756003)(186003)(83380400001)(44832011)(4326008)(26005)(16526019)(1076003)(5660300002)(2906002)(81166007)(336012)(2616005)(110136005)(82310400004)(40460700003)(7696005)(8936002)(508600001)(54906003)(47076005)(70206006)(70586007)(86362001)(316002)(6666004)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:31.7554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3536b4-848b-4859-1f71-08d9ebf7bd7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

