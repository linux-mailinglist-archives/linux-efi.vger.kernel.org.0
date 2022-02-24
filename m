Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0034C328C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiBXQ7x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBXQ7R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4C6E56B;
        Thu, 24 Feb 2022 08:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOmjZn1pT2oJ5J6YxqYamrNOz5f08GExSv3A9ZVfnBb2aFa0LPfChBI6JGFVOZoLZ4czj32EwKz8JpdS0QSTwAsdEkbiAHRic1K7DPEQdoNcFxEmVVZpXpkD9mSwVGkMAmUeylc4xD4KB4MtQO+ATrOs7HSAhl4l9B7IcmDVAIxz5NRgquax8oWwL7Nk17zc35UEGvI7NWq2yEBhYiI0UieSn509lCkYN3dx25G481uM9nsgkNheDm3RoCXY6w3TFzHkRyRW3V8d5avLilfwcRgITqyOlCmXrKGLkqrgrkDrhFYyjYFGsoEgqURDVKTzVVZxRmDbBFVa65gta7DlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJX73RtP+pulHJ/HOdmu5qq4go+/tIUE8pSiyFIC2Co=;
 b=DO7Da1g0d5wjfFJkxQhwgdBEVsdYV3PnCi5m2ABnsXEgm8EPZK+WJoM5aXempeQhODi+V2mpBY6up7fPYda2pSt21xdYDQqfRNOab5YMXLYhuA/uZ24TYK64l0GG7WQq0XxlnOFDhHN2fKplBIr0nIOK2IW9ejV4XWmTiReK824mNZrZofRR4b3NnIOy2RxAlIoQC0Lpj6RTeUCa982suCuQR1fH0Bcw9yOuKU7JgfLLlFBLl8CECadMiL16tL7RHzaKXrsZJBm4IHIRDXeARdlVw5GwxAHsoAuDw+OSvkdovWUQF1esphLAAXeT8pU0SfXpn3C5Vuvtw4hdva4XuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJX73RtP+pulHJ/HOdmu5qq4go+/tIUE8pSiyFIC2Co=;
 b=y6DT2wryE3l6nytR0Qzp+LDbGIn/LeZoC1wsVP/nppK07NrhC5x20IWEtaiBOwBDJTLLRfaFugbQETC7AY6xSY5ZaCDcgYstuCbnxo+jSagf44ZKotVbxQKc9h5BGi/EIYtb2MGTvvz1jRHEOSvBBpm2Z+ucElgIWhumnObGbic=
Received: from DM5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:3:7b::12) by
 CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 16:58:26 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::ed) by DM5PR13CA0026.outlook.office365.com
 (2603:10b6:3:7b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:25 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:18 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v11 15/45] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Thu, 24 Feb 2022 10:55:55 -0600
Message-ID: <20220224165625.2175020-16-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ee92988-b8c3-4312-93b6-08d9f7b6dfcb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00063AB070ADA4002D69F38BE53D9@CY4PR1201MB0006.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1jFDhAHL4vJCZXyO99Rr7VWeAZI8likkB+Ds9VsED0rewkBccd1qrw/gVsQ0uGswveS20yH4VzCIe2Jy+zYygDcjvAkjlW84pmcDwelDAP1+ZDf7Zs9WuZJP2fvKOPFUTK95uZF4xNqUE5Ks5r4xKba+aDghq8cRNUf8JqXogLSdV5+DSyexBkW0xSNxajDtSHx+pDLjvrdeASTto4nUI8F5czga56+6cBnIm9+z1128jbWUh7Nt9xCwnDdMqycUKXS0KQcOyItNUzQ8GGJqANFO8vx6xu9WCRz5hucxKiIH/bYTAdJU832zuMsOTe+cCE3c0aCM8YxjiDv12+gQXiu1iqffV6o8VYBjMsdUaJMfedsd33eKd4s48xXMJK6spioWnmB8/UL84z5ZK3sWXl9+xSA4/402JQaJ8MOvFNgNR8TC1TExnZbRYH/dMyiMkAmQu3rZkcBw/JqbcAZSWbQLueUqa9UqsdNR32eqUmSNWpD9DoZIFxdVRgg99jhbm9+VC6eztycxD5kaUSp/spToSTzf+S1nTKkkH3497YElE3tF/wic5+RgCzXLRHKjD1V7OVaM4LFBO87wtR4M698AgLUo5whdjsAkW+gEFGMnXtLhoZZOHsir42nxHkMxPpBvQOEVrNT9rl/iSy9/ZvfFcqcq0zWKBK4fjWu+CE0PRQTwsNZwdreCC/5rgZGqWuPe9uCc2GVTeWpSRnrNl+B9U4eCDElEMB2isnSTL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(4326008)(110136005)(2906002)(7406005)(44832011)(8676002)(70206006)(54906003)(40460700003)(70586007)(82310400004)(7416002)(8936002)(316002)(83380400001)(86362001)(36860700001)(36756003)(26005)(81166007)(356005)(47076005)(7696005)(16526019)(186003)(336012)(2616005)(1076003)(6666004)(508600001)(426003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:25.9311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee92988-b8c3-4312-93b6-08d9f7b6dfcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 84e7d45afa9e..23978d858297 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,52 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
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
index 7ac5842e32b6..fe7fe16e5fd5 100644
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

