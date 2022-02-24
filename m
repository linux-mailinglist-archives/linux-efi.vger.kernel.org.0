Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984D44C32B0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiBXRA1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiBXQ7f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29F7563B;
        Thu, 24 Feb 2022 08:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUbkD3mqk5vwLCCePpbiq3Jv584nG6sytxfHdZbwowUI8+FHShHFHKkeTnxPQ9f50Fkj4471BMgSJSPcL3p3NWuhEDxjuu7h6/xOQAStZxMsBp3ARB6CAWF8Y+p9i90rfo5EyD2/YdDcYCeHfg6vGO/KIN0QsLoo53REEeHRGQZD6/rg+1b5jW/vlAYvEEMTD+ALy4nf31sGg0UnFh7J/wqb99ByiFZEA0JOxy9kBwhHa6f5aYWclwJ3Z4FV3fYRyDWll+zr9vqLO6atrN0PyngCQKcaHb1YyDU/EtAta3TLIiWEgTlzbnui/jc+kZ537YRzrm5lTwwMRvc0I6jE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzs0LZinnI7EO7mq2eHmSBeymZECA63jxrm9GSOGHa0=;
 b=VSHmlbzrJbqmY+qm3FIT2d5ITvRie7nzj6SBZTmsDRTIhbdM3WZbE5s/WyTuUNDVndgCQxmAxQ1lhri4mfQwgge+z+THC1HNe50Ckhmce3lxTFGtDzUVkDyvnkCxvNTGVrNEchBaX3UwXEURHHCof+ZDdPIl7Is79k/3LzxNq0+oGbbPKTV1dqhx74zChDSrD/itWZ+lZb4xaDBH1YCfDioRVfDzL1EI9HWW1nydIvm09mKFhrWjXVJZdr39+7MHsb0X+9xSl+S1XYTHJmjBy6skHew74fF8uUweZD7yKHcEQPwxbTKnqw1ZKnvlwCMILB2oSd0Y5h+D12R4wxYTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzs0LZinnI7EO7mq2eHmSBeymZECA63jxrm9GSOGHa0=;
 b=d72QGtnz5iP1FgjeUUAOLiBL/oOp2O6Wn5HR4akfrgA2YePAqZwuC3NVZDgb/ZEP2ltVsFbryMmjqTO4V2rMr8zBWh7Sr9rMA4YkMz8JI6YSHBqIdEreVdS590Qiok9jA1VN+6mFGd5dXJufm4lOy6z6ej69qTTtnCXFQNMpcNY=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Thu, 24 Feb 2022 16:58:37 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b0) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:36 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:23 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v11 18/45] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Thu, 24 Feb 2022 10:55:58 -0600
Message-ID: <20220224165625.2175020-19-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f896bd9c-29d1-4817-27ff-08d9f7b6e65f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3574CA719AD633CF653088D0E53D9@BYAPR12MB3574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58jY1DzDKENWZFsS0/BKymzuvDhHXmr/G8Y/KpMzdd5OPntThaDzc1vjyhgiL8s66diCAPzLn9WkGJIDI1YPu5pDpAk92CRu2cYCBf1aYmeV6fOUwgGPvrClHXXqR2xTYjcGIGrldXIxBhcNRZ1TnRXJQWGwrrqI6H2e6Hk3rbB+gXIyRUb+24ge4L3zzfhtPYtYSOcBb2JYs7dEchUotAmANp/+vpV9IAjnUQRxYTBBc3BpJqKWTGWkQEp23+q/r4sDhy2mew/D2vkOapBifMZ2E3EMCl50ob2AAKFC2RcYT7FhBNoVlOKcN41mWJyQg/OuMX1L+tJBOJiBnRe3XmH0i9W7RTR5tjOHSLgmDNQVh7KpvfPp0W8n9Ka4Jb+VKT7o1FdAzLmx2+byWehr35tgVUPBhJMm+fmndA8+TLa+O7asrdWd+yR44jFQ1AH4O/dqxqjN4i2cTBpkgqt+u4MXak15ZuZzwVcDZI2xLfxw/S7Df1XV6WaleXRuwfzmoEpikvSmdltWD+HekY+syUP9hmemzJvlvrPcHuwAQDSYg6vJFoIArMfv+x3hG7lzGmFNVsBL4/uBHTqvihCueayStm7XGcEgVWW+a5hpCzX1xp89McJtg6q2P/tLdQ0QI1PmP5PVB6csNikJa52lZKq0j6CLzEnmpzJK+Sz8ebAV4RGiY0pSmbYnm3EBEYiL08iLJjEmdbPtbtgF2sVLu0695Wl+Ne8beoRX0cCKqok=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(36860700001)(44832011)(83380400001)(7696005)(7406005)(40460700003)(7416002)(336012)(2906002)(110136005)(6666004)(426003)(8936002)(47076005)(54906003)(36756003)(16526019)(2616005)(4326008)(81166007)(26005)(82310400004)(316002)(1076003)(86362001)(356005)(186003)(8676002)(508600001)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:36.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f896bd9c-29d1-4817-27ff-08d9f7b6e65f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
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
index 6169053c2854..8539dd6f24ff 100644
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
@@ -322,14 +358,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
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

