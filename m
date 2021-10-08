Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F9427068
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhJHSJs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:48 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:40480
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242830AbhJHSIS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elhYqJj2mtxTJ8vEuU+V9KouKbcAZ9cfpAEeyL4W42/uH6A+2erlmexCZCh75MeLYJwU1gc38DQzkv4yD1RYSAswvf/BGsrZa9uAf7HNiMBzBGBCHsp3kFoCslyjhFdSj8NM9PrsVqb8NIFDlDzxjacPTAkVDHyDz02EoerkQtrGP7vNeRtGhHUl2f1fi7stczlTxgquHijXVNA40FCVeuXnn1hR5BnCIWUceeXq0HIbYtNY1ayfViVHbQ5reyO4Hr2VFSm0uSDuIwRb7wHjyR+1qKYJk4fOx1PY4g8B3RDUdIweocM+Ua9/9Zi2QSmOV/ILXDCx4ta95t92ZCuIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPT5/8VjFAcJVkFhinAFXAQ9kj0d8tWXd896Kug0eFs=;
 b=Wmnr5geXk9a8s3tc5WteESD8KSpcHDCYJ3oCxD/5M7rZ2qKX4XwVg3xKoCYZ79sQqbn2hGqbR0cvXNXP2lJ1biHfOVNpi1+gcvf9UwoRMgPD+6v+G+GP+OvSKjv90pKDvuPt03OE3iNY4zHoTyKumQv3R+d7VdPhORlNvaIJtmOhjwGNQ+Cr85H7+O82MKBoTzCLE6V4IjlsFml+xY6eN+iabup/ySWTXsf87VwYlGhZntIXV8U+RS2gXoOTdc9UNkkHU4qwhjHzS5COgyOP1sUdiVQpmW5z7ykjB+S1ygGdAJNnR/QywkuqaVyi0J29WiW48EtgGL5drriSGIv2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPT5/8VjFAcJVkFhinAFXAQ9kj0d8tWXd896Kug0eFs=;
 b=P6BbvzvNreKAUiTCEjms9zkLp3e03WMAs/Ai1OQ5ms0IG58teAnS1GyQTV2v6QbNCb6DeiN7sFGfDnOtXfUxZW2+q0Wb11JNnOMyqDh+DwUAIW63eJbILzH0ZkLNAL3PctW6iKm3TWfakJZDmqcjZvVaI2Mk8XTyG3Mu5r2UeLY=
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 18:06:19 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::df) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:18 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:11 -0500
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
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v6 36/42] x86/compressed/64: add identity mapping for Confidential Computing blob
Date:   Fri, 8 Oct 2021 13:04:47 -0500
Message-ID: <20211008180453.462291-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142dfe3a-96fe-4fa4-feea-08d98a86540c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5280:
X-Microsoft-Antispam-PRVS: <DM4PR12MB528036B766CA9C658425846AE5B29@DM4PR12MB5280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N96+EH+SlT4ldGYGcydQ9QvNKmJt2GvB2ubc7L6dN93C2zjsF1uBawi5cVX9vrVd7MPQg/ovlaZDLnQGc874vIorpj8giKA/Qw1Rz6r2zPWi25tXNHo+PU93alVsYnlP7cyq8GmKNh2bVdT+o1FWaEmiupfY/c5HVK4q+Q5mxD8w8Kz6t1UNObdr49dfmjCyrLWPyvFaBlVcf+1lJ+9FjBnBoDGgDzG6Hf5gGVFbCA9cCJZBz4bku4EUQt7fUgbVLcNMHObwC73S1s1Y/udzso5xnv4eKnZ7NRs46dAa0UUV5PsBO563mvxAmOwDuvWW8iPSI3h2fLFMMxiKIGA+Fa74xgmVX7qvn9hDMS1IjD5S3xFGlxE7deilf36/0DK2SQKidkFyersmRew1Q3AN06xghQYD2NX9U4xQ2/ep28N6rpdHUqEqM1Lk7WaSFma/hN3ZBkXe7bdwvHpq006H90RZ/lCS01a+Unc4v3kJRbvL2LNhTB9xjyOv8FytdVxmCKeglYnugwHxGtL546CGiQM0YRS2XP1zD1TkDOlnlFhsvqAsXwQAwSRRUOaU8+ToFXAG6/U1NMywZvoDYj9SZzdXm5tBTrdi0i1wlJj5OzEAIhiSP8lDnQkGMbgC93dnJVjkxrcXuprCU6PGSVXmhVUJ7AqvL7dxpVzb6PHZ0S+DENrNyJF4G9FzZ+VsckCDv/kKLwpMD8+jRY/AQ90vTov0gTeFj3flVPynSo9/QT0LiCeYyoQHWCG44fLCU+sp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(316002)(336012)(508600001)(8676002)(7696005)(83380400001)(2616005)(4326008)(44832011)(1076003)(426003)(6666004)(82310400003)(186003)(26005)(356005)(36860700001)(54906003)(16526019)(7416002)(5660300002)(81166007)(70206006)(8936002)(70586007)(36756003)(2906002)(7406005)(86362001)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:18.8375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142dfe3a-96fe-4fa4-feea-08d98a86540c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At
that stage of boot it will be relying on the identity-mapped page table
set up by boot/compressed kernel, so make sure the blob and the CPUID
table it points to are mapped in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h         |  2 ++
 arch/x86/boot/compressed/sev.c          |  2 +-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 3cf7a7575f5c..10ecbc53f8bc 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -37,6 +37,8 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
+#include <asm/sev.h> /* For ConfidentialComputing blob */
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
@@ -106,6 +108,27 @@ static void add_identity_map(unsigned long start, unsigned long end)
 		error("Error: kernel_ident_mapping_init() failed\n");
 }
 
+void sev_prep_identity_maps(void)
+{
+	/*
+	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * kernel to find the in-memory cpuid table to handle cpuid
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
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
+	sev_verify_cbit(top_level_pgt);
+}
+
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void *rmode)
 {
@@ -163,8 +186,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps();
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9b66a8bf336e..ce1a884e8322 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -125,6 +125,7 @@ extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
 void snp_cpuid_init_boot(struct boot_params *bp);
+bool sev_snp_enabled(void);
 
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -135,6 +136,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
 static inline void snp_cpuid_init_boot(struct boot_params *bp) { }
+static inline bool sev_snp_enabled(void) { return false; }
 
 #endif
 
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 9d6a2ecb609f..1b77b819ddb4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -120,7 +120,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
-- 
2.25.1

