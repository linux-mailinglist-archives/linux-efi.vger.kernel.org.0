Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6A470442
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbhLJPrs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:48 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:6848
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243197AbhLJPrn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiqhXXQknsfN2udtVHo9DLO+DPcEhkr5JqXC3jkq/CR00/dUswFhXB1us8+l0ByLvcKAlrvMDqKz6LE17VkNTZNMZjdr2ipQHsCmqbLm0X9HuRfzetbsppRRu3l2H67m/jyHMf1SS9y24lPvMLnR3MHGZPZmM1tD4HlV48nCq28hT94O/etj+3RNtcLsWdFZzxoksgfCtS1nmPtFKur7J0bRJurrUnlJLm6TSAOaXiKTy9/EBWMxUDUUwQMxVlS+fLucjxpnmFJLi2bAjlRmxc+NyqLDfwGlgsbXI4dvNJdCYNIgPxYa0qqBxxTVEWELi4bhf+dFBDN3nMxFg/B/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2immQbkv/b/j4AYJewzck/bVgoPhk9CL711T9p91fs=;
 b=oWikW0uVncEzHaN6TK9LUdz+gaXzbCGUceN4ZVRuKN2ghpvVN1hQNZtx6+aPFyhL19kn3VH3227lxauBIS+7eSz5KyR7jbPCHTEM/ZU5/aZS+cPXacfRvGN1XkQo0stuXhua7j02Z1XEtMxJ1cQ0jLS1l5gWX5SgRMrPW/ZQRbhmRmvQ1jlOTnK5icbwLi3Pn6JTwp8CpTzo0vZqQJ7kRNg9RkbX/0Ibql8XglL8LzU2J0DsWOKEURhQgNwlwGhfMy5AR+KzPFXjx384bsXmnyTHOLVUpLKX3AOa0o7Z30oVyctA98J5GfoOz8ysO2J6EebVjFvJaFUlLeCkwuC1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2immQbkv/b/j4AYJewzck/bVgoPhk9CL711T9p91fs=;
 b=WQ6mXnxLo3pXyRE0wfQRYcV+xjWRIQtjMrXKtXy+11KFE/iNOOasU7v9tL47zKFQT6dclnSaRsFnUlvFpH/VuWSEeHHa88GXOwLeZDKcS6h/u1PEfaOhCAp59sT1s1YAEVE2z50g6XEb/Iz6YDR46bzLlmogvBWheTfHOYy6f+8=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 15:44:05 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::74) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:01 -0600
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
Subject: [PATCH v8 09/40] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Fri, 10 Dec 2021 09:43:01 -0600
Message-ID: <20211210154332.11526-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d972a2eb-85cf-4b5f-5605-08d9bbf3e47a
X-MS-TrafficTypeDiagnostic: PH0PR12MB5449:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5449928819ABAED39043E5E7E5719@PH0PR12MB5449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDvFwgH3wFGT4JmoHAJeh5ZRAeXGhYKOlYF05GUO6df3InSE7eYQZLRSgjk4QLFsCDaPGy24A/hqvnv7t04B4it/A+HKbzVnxvK31mZUDYFoSwa8oaBDRY0VWo/v8kzOs3Brh7e+tBO9opriVj7iHxfubM8RuI1dx3w+yrd7NyQmHHeQJuFD/WtCsuEi3FlVPOcYOvv3FCfMwF6Z9D2OQ1rBpAcwedBzfjILFAYjsc26j4I1zemUP7T3pI8TFmMk2R44WxZTdtxhQjEw6/DLfgMrdX84LiEOLhQ/sCXUpbff4lTcGpXY6JWeuQCFfKbUczH6RFpxwV5MDetCN5PU6+C62zkihT3C4UQGRNXdx6OoPkkBr8kkK4vhr05GbVH4cjVUU+LwQvkJp3aSvBkvSa2V4dHthxxUwEGJ4ibwyymj2pfwwoqJ5yljybPsvYiV5O4WiObZRx0tcndd7UCrwWPny06F9gQ4jeqrjZYSn+gq7psgefTPP/kOWSshjgWdLWtlzBDGQ34LOHSjNEeDcleO3ZfWyZBCGa8O+pULWQC9OrrjaKSu4pSgIOj3Q8NXW7kNRBPpnhZVaKj1sZkIb+9MNw+jnCZlnzvbJryW7gnFhtTCvvb9tbHepAye0P0+JEepukGaBhSLGwlKtbnkOjtOVPR6L3jVjpsonGuosnCL1YI3Smpbdk0F27CywKdaqUm8V5XLJzkIOIhg6UD/9WaGbeoBaWKqjKIx08H5XO2AhwvEhHAJd6EGBomSzfcrb/1zD/gl4n3bLd5Y6DT9EpiwXuszeBPBswzoOHPZZNR+OqO2Wu7wqRukeeK1GJaR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(36860700001)(7406005)(7416002)(86362001)(54906003)(70586007)(44832011)(110136005)(70206006)(2616005)(1076003)(356005)(2906002)(8676002)(4326008)(82310400004)(8936002)(316002)(40460700001)(81166007)(26005)(508600001)(7696005)(47076005)(336012)(83380400001)(186003)(426003)(16526019)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:03.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d972a2eb-85cf-4b5f-5605-08d9bbf3e47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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
the kernel decompression stage, the VC handler uses the
set_memory_decrypted() to make the GHCB page shared (i.e clear encryption
attribute). And while exiting from the decompression, it calls the
set_page_encrypted() to make the page private.

Add sev_snp_set_page_{private,shared}() helper that is used by the
set_memory_{decrypt,encrypt}() to change the page state in the RMP table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 18 +++++++++-
 arch/x86/boot/compressed/misc.h         |  4 +++
 arch/x86/boot/compressed/sev.c          | 46 +++++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h       | 26 ++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..ef77453cc629 100644
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
+			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
+	}
+
 	/* Update PTE */
 	pte = *ptep;
 	pte = pte_set_flags(pte, set);
 	pte = pte_clear_flags(pte, clr);
 	set_pte(ptep, pte);
 
+	/*
+	 * If the encryption attribute is being set, then change the page state to
+	 * private in the RMP entry. The page state must be done after the PTE
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
index 9be369f72299..12a93acc94ba 100644
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
+	 * Now that page is added in the RMP table, validate it so that it is
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
index 7ac5842e32b6..a2f956cfafba 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,32 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/*
+ * SNP Page State Change Operation
+ *
+ * GHCBData[55:52] - Page operation:
+ *   0x0001 – Page assignment, Private
+ *   0x0002 – Page assignment, Shared
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

