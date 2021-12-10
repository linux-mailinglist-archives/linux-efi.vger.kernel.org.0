Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C59470487
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbhLJPtG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:06 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:36833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243243AbhLJPrr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UctnEz4vlcxUR4jEEURVOJyBwU8tqxp7SC/srVdnJ1J/p0jzYhPNmch25cKr2H9y1U2/XI3vn03YzsAD5eNwWVOfUMer0redPYgCNd3MHydLSdyieWUyYY4m/70vfYtWPGLJCsWfSk3bJTxb2FvgQGPb7Ze/Ty5do1jf2VxElsXK8xCt+blts84YRnGVzCuwWieTOoTLMaq5/vs0w/aEdhBG1iKOlJlkzk1IBXMdjNXTDo+4IRbiADHOJsFvX7uFqcvRIG8tHzWxqdvdYl8axk1vEElxZ4EeLlmk4x9Q2AXgaieGF/a9FhltgagYWQvdVenflWYZRfZu4QqS/AfMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oFgE2nudDLxS7MIQOgAcuGopQy5fL8uDJVDPyTpwaA=;
 b=mLb8a/KhcIReyNtnnfknVroA1LlFmOdNi/Hzt+mZhZvWGniH0MCZGKmoDlYFOd4dX+xOeuaMnHgK/+Av6iqLLOjS0yVcblVXF4AfeUGp0faMVxppYZukGhRLc6JcM6GHrQ3riu+KMO1zP1yn2aRJBmBgsDEHg64Q/2zp44UMaQyZ3yFaZgG9ftH9ZfYfCWWYz5jXNRFQ3yuW1TrMDX3wx+FIHaT/bcBKivpki2i9SIbp14nXpNN0bk0L2KJNVgaT8vVUB7ChVaHJaAvExdXHq+Pn/6UMrx4rp6nhOEDrDXH97l22FZoXzBnSiH5kqD1x29qbuJIPZYjPkAO8lRWsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oFgE2nudDLxS7MIQOgAcuGopQy5fL8uDJVDPyTpwaA=;
 b=wc2d3vvznJZRhU0QRZNtrxw3KbVZRn1zUIdGjQlfSQYF5XMgEX0FVrJSWLyqHmShmJ6AI5rV0DrlzjmkawWAd43HkGoT1ir0EV0USWAqa50hjtuSkVjSoAyAhIKmjKzLZaxi5f5rLxhfC/JJ6TFsK4mrtd3gjN3Ub/H/WgUr/RM=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by BN6PR1201MB2546.namprd12.prod.outlook.com (2603:10b6:404:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:09 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::4) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:08 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:06 -0600
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
Subject: [PATCH v8 12/40] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Fri, 10 Dec 2021 09:43:04 -0600
Message-ID: <20211210154332.11526-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b23a90-5e0b-4c0b-1a6c-08d9bbf3e76d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2546:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2546798E81185E06F35A7DAFE5719@BN6PR1201MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKqxFOOW5u/emdYvWG8XQAQcgBbKn0/0GAupMbw0o/lPy3ZNRB7Osk+h0TUBOE2p4SiZRo55MPSlTG1uFcllU1JzgZYTqdWmjXgA6IlhPfvZO2iQHKs+ofwhKOhd3SuQ048p7u1KkTqnONGz18Qx9dvp/K6fP+D3icK9CNW5gGlTPysuphy9QLsVmVzx9DmwJw6Oy4wx3ipJomkwfX6irSspfI7EgjQdcIlMfaCtjkJVh/iaar2iUq9grmQG9Cpx1q7W+S5Oyjr6UYzE5VhOLehB0F8a8S1D1+vNZV+4//sO8Gq/QHesoUeQOXXFWJDpHPO0w0js/dc0nfi0JC1fbPWpIyGODRTg6zYhdb14DBdC9NDwpOEA05HhejmwyREX9ITKReIPF/8nxPnBstIV6aCcpq+MS5M5IrkXolcl2M+iGxKay6pUrAaCRbHiz7OSRTVPSledNeTlhDY7oVKOXXbL+dwIMcsSguXuIb9WmdpL6YThpWwpLnnSVukQE0JlN362lXgxj0Bgc8B4J6sc3jUPu9JxO2HVIS8H2KMJERmGZn3w3t4t1ZcGGK0ztqNR9pMWYB4nSRIX7zcSa1S+coCaqz65Xwbq5HKn+Qv/W2mUNEA23qSannhgy1hsitddJ4AwKFGrrKwz58vjKiQCGXkVfi2HJgkqGVq1B/4lY0sPorgHzM/0zMLHNWp8jv0OKOJ1IhFlNInQDteKdt4sCnQ2vx3Jv9TB7gaXOkBpj+UteBC6Gir2TUqfBL8lSOHX++b2cbyiAfMLYNJnUbU1ve3cmuJy3kbRXYMsF/4nbc7eI/ukKGAeLh9cKdy65oI1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(40460700001)(316002)(70586007)(54906003)(2906002)(110136005)(82310400004)(16526019)(186003)(26005)(2616005)(426003)(336012)(44832011)(1076003)(86362001)(7696005)(4326008)(47076005)(5660300002)(36860700001)(36756003)(70206006)(7406005)(356005)(83380400001)(8676002)(7416002)(8936002)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:08.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b23a90-5e0b-4c0b-1a6c-08d9bbf3e76d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2546
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The early_set_memory_{encrypt,decrypt}() are used for changing the
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

The early_set_memory_{encrypt,decrypt} can be called before the GHCB
is setup, use the SNP page state MSR protocol VMGEXIT defined in the GHCB
specification to request the page state change in the RMP table.

While at it, add a helper snp_prep_memory() that can be used outside
the sev specific files to change the page state for a specified memory
range.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  10 ++++
 arch/x86/kernel/sev.c      | 102 +++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c  |  51 +++++++++++++++++--
 3 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0df508374a35..eec2e1b9d557 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -123,6 +123,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 	return rc;
 }
 void sev_snp_register_ghcb(void);
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
 static inline void sev_snp_register_ghcb(void) { }
+static inline void __init
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 17ad603f62da..2971aa280ce6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -557,6 +557,108 @@ static u64 get_jump_table_addr(void)
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
+static void __init early_set_page_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+{
+	unsigned long paddr_end;
+	u64 val;
+
+	paddr = paddr & PAGE_MASK;
+	paddr_end = paddr + (npages << PAGE_SHIFT);
+
+	while (paddr < paddr_end) {
+		/*
+		 * Use the MSR protocol because this function can be called before the GHCB
+		 * is established.
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
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	 /*
+	  * Ask the hypervisor to mark the memory pages as private in the RMP
+	  * table.
+	  */
+	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	/* Validate the memory pages after they've been added in the RMP table. */
+	pvalidate_pages(vaddr, npages, 1);
+}
+
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	/*
+	 * Invalidate the memory pages before they are marked shared in the
+	 * RMP table.
+	 */
+	pvalidate_pages(vaddr, npages, 0);
+
+	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
+	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
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
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3ba801ff6afc..5d19aad06670 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -31,6 +31,7 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -49,6 +50,34 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
+/*
+ * When SNP is active, change the page state from private to shared before
+ * copying the data from the source to destination and restore after the copy.
+ * This is required because the source address is mapped as decrypted by the
+ * caller of the routine.
+ */
+static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
+				     unsigned long paddr, bool decrypt)
+{
+	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP) || !decrypt) {
+		memcpy(dst, src, sz);
+		return;
+	}
+
+	/*
+	 * With SNP, the paddr needs to be accessed decrypted, mark the page
+	 * shared in the RMP table before copying it.
+	 */
+	early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
+
+	memcpy(dst, src, sz);
+
+	/* Restore the page state after the memcpy. */
+	early_snp_set_memory_private((unsigned long)__va(paddr), paddr, npages);
+}
+
 /*
  * This routine does not change the underlying encryption setting of the
  * page(s) that map this memory. It assumes that eventually the memory is
@@ -97,8 +126,8 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
+		snp_memcpy(sme_early_buffer, src, len, paddr, enc);
+		snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
 
 		early_memunmap(dst, len);
 		early_memunmap(src, len);
@@ -320,14 +349,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
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

