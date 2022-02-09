Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58C4AF95A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiBISNM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiBISMs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F871C050CF8;
        Wed,  9 Feb 2022 10:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDq3ovroVZ/VYFG6U7ALoHE4+aHw+Lyl3f7D2eN4pXsbxrvFJuwy63kMA6AIGbjwx5bEHVmpnSy4XsfXZtNGVAOu3hTxiPkTlti0VdkFdj28etYQ8AjazWmk+YSrNmOIfRqrA02lcC0RobZZg2mCq511ngi0orZGFkFzhIVkAZrRHJ3mvy30iKJ+SGWM0g2UeH1hBewbkvWgnXOEpYcQttY3xRaq4mB/2LOUtzSWx0elzgrpK+OduRXf/RcDdcSjFbnwjIP6NQ490NJJtoV9JfF8WhCNCgwdx0h8G2HJ8cNARXfvuez1syG/a0gWwtbQxA+6Yyicl0ehpnhURVi7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f6991U586DQwh5xO6vkorTqibYyVgYpX+XBCYUojK8=;
 b=J0PVhICg7vheS6uBzpQUDaQaKEC0y7Bn0ehkuBYfPYxJlIWErNydZ2FnW0AS96vLGcR1b4laM8fCMxmvXzJJEZ+vUlsDVtKqFDLmqHaxIiVzGWYb3PIfwA/yyd48blFIVRlTle3vSZSCgbYBlE4yGvx2ojXW845DMr5O7SMYgb8cCesBHaT6ifG8QBr/iyLv3DqfzvRQ9/haXLVLgdIhsOkLlOqOhkYwGnJ/E+79rsc2D1co3YEZ8MLsXNG784Y4ujiJBK3AP9TymjGMcjeBmEeSKXGGFUZOs+3mxqaEYyZ7qylwD39Dnif6OTwkg09JF2NYypjLArCe5tK2z90aQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f6991U586DQwh5xO6vkorTqibYyVgYpX+XBCYUojK8=;
 b=0U50k9Hoh/l/0YKKa4w3IWfz9/lgr/EEy4DsHoPaA7VxppyZRdzXQy6VgsoXbe+T1Ab6DIw26RJ3bcISZKgdqC7l1xdGzULRlaVdD8OtxXtwhCBonZssnrcO47YTMgAML9Z+Sh/p07kvi3uFhYZ40YJMxKDAHgxIOpyEsKxxiwQ=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by BYAPR12MB3496.namprd12.prod.outlook.com (2603:10b6:a03:d8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:11:58 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::4) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:55 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v10 18/45] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Wed, 9 Feb 2022 12:10:12 -0600
Message-ID: <20220209181039.1262882-19-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26ed9ef6-b81f-4f1c-cb4b-08d9ebf7a989
X-MS-TrafficTypeDiagnostic: BYAPR12MB3496:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3496CEBC9B2016D0AF79943FE52E9@BYAPR12MB3496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOkmmg31WlAqyf0ZI0fAAjczpCHFFyzmZswjky4Nbqs0PKn/GQBNVmmNRqmV2BhdVOLDNKDSJBOgo5vlvuBllR/zxng9+5+LPRRO4jOkkrMet8UvdRl2hUJm1djGuG8FK3PiBdPWrrQU7EY/1bw8ggd6isJYrCQxucgYQz6d8Ij9FWWrOUVYcqN3NKcazHVWaW6kTTwrdQ7SK4TMzjQME+FSrU+deVxMFabT2rxMu3T33Fw1I+jlNhGPILWCRsqnWh7V5BpRfpswZjcaAzQPpHFW4kExau0h5gHXJsaspFP0cPtjboFcpoG3tOCik2cwqZqW6B8ycNgA1K1g81XF5KfRoHPwFrQ9fthbCCfgga7MvZtg9RAQyG/vwu3ztGN16qfiSah9zCw1rCVK3THL6sLNgv8yJlrFgJnl8iRtnYUwTi65ufA/aw3FIwvZKkgXhODqNmWpugWIVbUhh8Pzx6c6rE00wI0e+sh/g6PdenF1Z58l4gp+9SHTkO+4rdfnzseKryHplVroHqQVpGPI0mYkoGhgd26IW0yHEjwZAM2+FYdCY4mg/jDq84mEPvs+eLlUzObf25VU4E0ISdiKAmyBq3iZrKvwKrTVK3Nxn4K++3JoX3sRX4glH9DD+NST917nUYISWiuc+D+VyfNTR/M+O8MrlFHtNYJH5F+8IGyQSbZgjs9voVPCu89O30ChyIsYkaKvfKpH93hv4ZXqC+LKJEjDyBIgJZDEZzbT0lo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(36756003)(1076003)(40460700003)(8936002)(26005)(16526019)(36860700001)(47076005)(2616005)(7696005)(83380400001)(426003)(336012)(44832011)(6666004)(356005)(81166007)(82310400004)(54906003)(2906002)(7416002)(7406005)(86362001)(508600001)(5660300002)(70206006)(70586007)(316002)(110136005)(4326008)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:58.2684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ed9ef6-b81f-4f1c-cb4b-08d9ebf7a989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The early_set_memory_{encrypted,decrypted}() are used for changing the
page from decrypted (shared) to encrypted (private) and vice versa.
When SEV-SNP is active, the page state transition needs to go through
additional steps.

If the page is transitioned from shared to private, then perform the
following after the encryption attribute is set in the page table:

1. Issue the page state change VMGEXIT to add the page as a private
   in the RMP table.
2. Validate the page after its successfully added in the RMP table.

To maintain the security guarantees, if the page is transitioned from
private to shared, then perform the following before clearing the
encryption attribute from the page table.

1. Invalidate the page.
2. Issue the page state change VMGEXIT to make the page shared in the
   RMP table.

The early_set_memory_{encrypted,decrypted} can be called before the
GHCB is setup, use the SNP page state MSR protocol VMGEXIT defined in
the GHCB specification to request the page state change in the RMP
table.

While at it, add a helper snp_prep_memory() which will be used in
probe_roms(), in a later patch.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h    | 10 ++++
 arch/x86/kernel/sev.c         | 99 +++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c | 58 ++++++++++++++++++--
 3 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 48df02713ee0..f65d257e3d4a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -123,6 +123,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 	return rc;
 }
 void setup_ghcb(void);
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages);
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages);
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -132,6 +137,11 @@ static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
+static inline void __init
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index cc382c4f89ef..1e8dc71e7ba6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -556,6 +556,105 @@ static u64 get_jump_table_addr(void)
 	return ret;
 }
 
+static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
+{
+	unsigned long vaddr_end;
+	int rc;
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	while (vaddr < vaddr_end) {
+		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+		vaddr = vaddr + PAGE_SIZE;
+	}
+}
+
+static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+{
+	unsigned long paddr_end;
+	u64 val;
+
+	paddr = paddr & PAGE_MASK;
+	paddr_end = paddr + (npages << PAGE_SHIFT);
+
+	while (paddr < paddr_end) {
+		/*
+		 * Use the MSR protocol because this function can be called before
+		 * the GHCB is established.
+		 */
+		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+		VMGEXIT();
+
+		val = sev_es_rd_ghcb_msr();
+
+		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
+			 "Wrong PSC response code: 0x%x\n",
+			 (unsigned int)GHCB_RESP_CODE(val)))
+			goto e_term;
+
+		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
+			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
+			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
+			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+			goto e_term;
+
+		paddr = paddr + PAGE_SIZE;
+	}
+
+	return;
+
+e_term:
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+}
+
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	 /*
+	  * Ask the hypervisor to mark the memory pages as private in the RMP
+	  * table.
+	  */
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	/* Validate the memory pages after they've been added in the RMP table. */
+	pvalidate_pages(vaddr, npages, true);
+}
+
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	/* Invalidate the memory pages before they are marked shared in the RMP table. */
+	pvalidate_pages(vaddr, npages, false);
+
+	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
+{
+	unsigned long vaddr, npages;
+
+	vaddr = (unsigned long)__va(paddr);
+	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		early_snp_set_memory_private(vaddr, paddr, npages);
+	else if (op == SNP_PAGE_STATE_SHARED)
+		early_snp_set_memory_shared(vaddr, paddr, npages);
+	else
+		WARN(1, "invalid memory op %d\n", op);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..b59be6aac97b 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -31,6 +31,7 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -47,6 +48,36 @@ EXPORT_SYMBOL(sme_me_mask);
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
+/*
+ * SNP-specific routine which needs to additionally change the page state from
+ * private to shared before copying the data from the source to destination and
+ * restore after the copy.
+ */
+static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
+				     unsigned long paddr, bool decrypt)
+{
+	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (decrypt) {
+		/*
+		 * @paddr needs to be accessed decrypted, mark the page shared in
+		 * the RMP table before copying it.
+		 */
+		early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
+
+		memcpy(dst, src, sz);
+
+		/* Restore the page state after the memcpy. */
+		early_snp_set_memory_private((unsigned long)__va(paddr), paddr, npages);
+	} else {
+		/*
+		 * @paddr need to be accessed encrypted, no need for the page state
+		 * change.
+		 */
+		memcpy(dst, src, sz);
+	}
+}
+
 /*
  * This routine does not change the underlying encryption setting of the
  * page(s) that map this memory. It assumes that eventually the memory is
@@ -95,8 +126,13 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			snp_memcpy(sme_early_buffer, src, len, paddr, enc);
+			snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
+		} else {
+			memcpy(sme_early_buffer, src, len);
+			memcpy(dst, sme_early_buffer, len);
+		}
 
 		early_memunmap(dst, len);
 		early_memunmap(src, len);
@@ -318,14 +354,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 	clflush_cache_range(__va(pa), size);
 
 	/* Encrypt/decrypt the contents in-place */
-	if (enc)
+	if (enc) {
 		sme_early_encrypt(pa, size);
-	else
+	} else {
 		sme_early_decrypt(pa, size);
 
+		/*
+		 * ON SNP, the page state in the RMP table must happen
+		 * before the page table updates.
+		 */
+		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
+	}
+
 	/* Change the page encryption mask. */
 	new_pte = pfn_pte(pfn, new_prot);
 	set_pte_atomic(kpte, new_pte);
+
+	/*
+	 * If page is set encrypted in the page table, then update the RMP table to
+	 * add this page as private.
+	 */
+	if (enc)
+		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
 }
 
 static int __init early_set_memory_enc_dec(unsigned long vaddr,
-- 
2.25.1

