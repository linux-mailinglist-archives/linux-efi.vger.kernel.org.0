Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0949FF01
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350832AbiA1RTO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:14 -0500
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:7105
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350521AbiA1RSm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvr62yhy6/aON6lssaxUE1hatulOnHIgNNV9y6T+zdVZgOdUH2zT8hQ+Sd4s/1HWeVlFmr6rUriAmJAIQT9B9RwbW1WpYuUcKlfEGTLG02Uca+1hE3omRExDK+PsTwwP3Qu594aa+YlbmcO54dbRPtRZo04Mef5rlBeQvO1vFvI8hGG0Uq0ft0ampYhnG9nW7xKZXv2ht/j/wAn1H48+bPmz44NvG+QCj9lSKcKck16DocsGxeahgDwNJZjucR1eLwi2+tqidm3ovrTsGELhkcoPpNmuK6ffARUy2xfpdsnXhEUlfiLh4axk10sWCOFJQkAloZN54A1K+ifGFKRmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFzxufRorHhLnvM2t1DbV2ZchHHwFLYTguAWZOgN+QI=;
 b=CiizpRtv2ryBNYk+GdUq6TZTHC2G3hM3UHlP8tzugGMAhJ3Tb761limrHrhDJHF7Xi9PI9A/PJ3Rh1ON1KYuBOTnQh1LcOrz5zH388HxP2lAor+EkOxKB5q6JT6ysnBvafIvB30hOGsFfDt3JTdEYRd3nhhl11qVwxSd9Z1ByYnw0n1HDuYS4g2Ghfx+DSRK2xoCUTmFK/AKMcuftpNtxsPFhgSKJ+HFOwnazMJne4wB/yGWuVGrPe4MJ852bhnJswxFTn3XvC7Bk7/u2AUj1uBXbG8kaO58lr5O7FexEUZiQ9xlUz88HPSv+EB20vAGvUl4ZF+2lmrQzCn+MibD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFzxufRorHhLnvM2t1DbV2ZchHHwFLYTguAWZOgN+QI=;
 b=X2wCRp4jTeOVoCZZEzCqBSiZESp0Uc2fI0rq+nRXJU9BRt1z2tEOXWLO3pTMgxla2ll6i9QY71N0+Qk4RaHQAq03lPxlTcivW0vFXVnQnMgtvgzg3M+dktIgPAwuFtxB/J04YJd4sys6d1AXtLw3M7FaI2AT3nS6gH+KXlhGTnw=
Received: from DM6PR02CA0086.namprd02.prod.outlook.com (2603:10b6:5:1f4::27)
 by DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 17:18:40 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::31) by DM6PR02CA0086.outlook.office365.com
 (2603:10b6:5:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:38 -0600
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
Subject: [PATCH v9 13/43] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Fri, 28 Jan 2022 11:17:34 -0600
Message-ID: <20220128171804.569796-14-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: df0aded8-269e-43f5-657a-08d9e2823ab7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2504E63679D252448C7A6B5AE5229@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8RY4uyyM7uDAeaCWMWobnKCkqt4/jvyXT68mGeYBZZjRBMcg1QnydgNV0gI/rXwTEBdGLziT3SjsbytAtQAJM5WYKR/2jaVCjvxOFdXrQUjU4MJztQkXAtYmPtq6sGhfzp/zERxJSmM3jH3aVxH8p+abTrmyJfukRvzOZah3HgZAwZFv0c+8LJHpfoo7IBKnUIlKl9wgusOWrsugNtGlr+RCCqRUUcN84K1blihVd1wDFshiQeEX2OysyDPX8h6qdN0oxlTTjhiQYoqcUf6XAVdsKgg3puaphQ9QFpQERkDum4RkKQzHZxYIyRHqMnA75ixaoNeacX8ugoc+GqCMPjgrJgyhjM8U5tXJwDXX5KPmmIAJg7hvrlxSpVoA0yD+cPbzmeOX2LVd8MMhQ02ZRGmI8NpEefrEg/oUxg90Lro4dZX5McdU90vupPO2cVlaZgAyed7l2vUe4XEvDE0YC+tmi5fgrjdAJlrNujwHJtguMgUpenJId38UWTXYcba4t5TScIjQnrpkYM985+ewYUOvUygKBEZuVOL8IWYLXPVwKVIufE8rA1wQ6KDPnQqblxkP4EITsVBiLKt2k+MxCRWg7sdwIU+vcadGlcXNpTNhoaoVhVn5FEWyiLM53uBMgjhr/4fHNiGaDLFX/1oEzDqzTyKiG4MwW26ftkyMBCjQRGdlvCFT7oH5LZrCMkhMLyd6rsVsff55TP3rVBCqY1Q9zjk3RiARp+KH7Tj67E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(40460700003)(508600001)(356005)(47076005)(86362001)(6666004)(81166007)(7696005)(36756003)(2616005)(44832011)(186003)(336012)(7406005)(7416002)(70586007)(16526019)(1076003)(8676002)(26005)(426003)(8936002)(70206006)(36860700001)(4326008)(5660300002)(83380400001)(110136005)(54906003)(316002)(2906002)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:40.7265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0aded8-269e-43f5-657a-08d9e2823ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many of the integrity guarantees of SEV-SNP are enforced through the
Reverse Map Table (RMP). Each RMP entry contains the GPA at which a
particular page of DRAM should be mapped. The VMs can request the
hypervisor to add pages in the RMP table via the Page State Change VMGEXIT
defined in the GHCB specification. Inside each RMP entry is a Validated
flag; this flag is automatically cleared to 0 by the CPU hardware when a
new RMP entry is created for a guest. Each VM page can be either
validated or invalidated, as indicated by the Validated flag in the RMP
entry. Memory access to a private page that is not validated generates
a #VC. A VM must use PVALIDATE instruction to validate the private page
before using it.

To maintain the security guarantee of SEV-SNP guests, when transitioning
pages from private to shared, the guest must invalidate the pages before
asking the hypervisor to change the page state to shared in the RMP table.

After the pages are mapped private in the page table, the guest must issue
a page state change VMGEXIT to make the pages private in the RMP table and
validate it.

On boot, BIOS should have validated the entire system memory. During
the kernel decompression stage, the early_setup_ghcb() uses the
set_page_decrypted() to make the GHCB page shared (i.e clear encryption
attribute). And while exiting from the decompression, it calls the
set_page_encrypted() to make the page private.

Add snp_set_page_{private,shared}() helpers that are used by the
set_page_{decrypted,encrypted}() to change the page state in the RMP table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 +++++++++-
 arch/x86/boot/compressed/misc.h         |  4 +++
 arch/x86/boot/compressed/sev.c          | 46 +++++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h       | 26 ++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..3d566964b829 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	 * Changing encryption attributes of a page requires to flush it from
 	 * the caches.
 	 */
-	if ((set | clr) & _PAGE_ENC)
+	if ((set | clr) & _PAGE_ENC) {
 		clflush_page(address);
 
+		/*
+		 * If the encryption attribute is being cleared, then change
+		 * the page state to shared in the RMP table.
+		 */
+		if (clr)
+			snp_set_page_shared(__pa(address & PAGE_MASK));
+	}
+
 	/* Update PTE */
 	pte = *ptep;
 	pte = pte_set_flags(pte, set);
 	pte = pte_clear_flags(pte, clr);
 	set_pte(ptep, pte);
 
+	/*
+	 * If the encryption attribute is being set, then change the page state to
+	 * private in the RMP entry. The page state change must be done after the PTE
+	 * is updated.
+	 */
+	if (set & _PAGE_ENC)
+		snp_set_page_private(__pa(address & PAGE_MASK));
+
 	/* Flush TLB after changing encryption attribute */
 	write_cr3(top_level_pgt);
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 23e0e395084a..01cc13c12059 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -124,6 +124,8 @@ static inline void console_init(void)
 void sev_enable(struct boot_params *bp);
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
+void snp_set_page_private(unsigned long paddr);
+void snp_set_page_shared(unsigned long paddr);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -131,6 +133,8 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
 	return false;
 }
+static inline void snp_set_page_private(unsigned long paddr) { }
+static inline void snp_set_page_shared(unsigned long paddr) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index adfec1d43a77..1305267372d1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,6 +119,52 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static inline bool sev_snp_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
+static void __page_state_change(unsigned long paddr, enum psc_op op)
+{
+	u64 val;
+
+	if (!sev_snp_enabled())
+		return;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page state is changed in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+void snp_set_page_private(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+}
+
+void snp_set_page_shared(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+}
+
 static bool early_setup_ghcb(void)
 {
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index f2b6da96f79b..dbb4635f2bb5 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,32 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/*
+ * SNP Page State Change Operation
+ *
+ * GHCBData[55:52] - Page operation:
+ *   0x0001	Page assignment, Private
+ *   0x0002	Page assignment, Shared
+ */
+enum psc_op {
+	SNP_PAGE_STATE_PRIVATE = 1,
+	SNP_PAGE_STATE_SHARED,
+};
+
+#define GHCB_MSR_PSC_REQ		0x014
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)			\
+	/* GHCBData[55:52] */				\
+	(((u64)((op) & 0xf) << 52) |			\
+	/* GHCBData[51:12] */				\
+	((u64)((gfn) & GENMASK_ULL(39, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_RESP_VAL(val)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
-- 
2.25.1

