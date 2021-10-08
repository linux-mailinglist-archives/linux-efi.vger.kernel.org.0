Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1D427045
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbhJHSJJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:09 -0400
Received: from mail-bn1nam07on2050.outbound.protection.outlook.com ([40.107.212.50]:10887
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240856AbhJHSHl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flP5ocHEGp9eoRjmVkAfrILRByIc50mvOfKsYcxTsuMNp+YQX+WwEO18BxmYgOxYl/uVihuoWkK492/vUZYMhoL4CNgDF18boD25j2dghIN5qh2D4+9yE0sL8I+1urnzP6b+85sni7VjfJmEdpOrobsJPtRRFvrHxvoWm0qWzFwctiq/nPHYwVNAeDa0is1FQMGAYf9zqaPSn7WQoQ05aD3NBYQ1TBAd6IpB18uUPHTQ4vGvbXL6HeelhOJl5sddN205uARbM1NOVAL8ziB8mZl+p7EgDQi3mj84MyMcQPcyjjvLbUzZMFL0/Lp6Tjji1BdkR38Q8kSOIbLyDz+4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itzaJ3WqhpgCWZFl6mIjeBADk3UWg3wGRk7AvddVQSU=;
 b=dKcQEgnguz1Vf0qZTtox0xXOnv4hBsT+FXXRKLvOS7QuHi3Fq3noGH9QgS2VxQwTFBavSUNbYhK2rMNzcChjsMBoRGkHMyTBUx0YZNNW/3ljXU2YQKY55M1IegyzXAI5vQ82w5R5ffaHx9JSjVhYG0m6iEH2tb6POvrbRh6r+XpjeavPZB+i1lwP9bL6zVcYxWjQtgM6QHOOzKzNr0nJCl+L3LSPkw/Htm+ENMxka0gQ4u6ZyH8fe8j9L9c++7fKrBtw6RbyfdfQzCftHJNuOALJJ/GAlPLF4xF9evUUX3LfUN4WnBE0/TvIsE4ur5lPIgTNw+sGFscxe+GyupW6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itzaJ3WqhpgCWZFl6mIjeBADk3UWg3wGRk7AvddVQSU=;
 b=kdY56mMB6ZLWqo30X7mdOE5SqGN0K1XoUGKUWK8rKDCaJrcjCnfpdyGYLrsb/WDJHeszPWrbqjgH/JSzjECifSNVVY5gFREYkJVZIdlnzYHsdYm+mSoNckjwcy//Gi4UGPk4jxBuAHb2qPXjCYxzA/wh1icJk4aYkJriMsn1dHw=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Fri, 8 Oct 2021 18:05:41 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::68) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:37 -0500
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
Subject: [PATCH v6 16/42] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Fri, 8 Oct 2021 13:04:27 -0500
Message-ID: <20211008180453.462291-17-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b1d78fa-c4fd-489f-708f-08d98a863d35
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-Microsoft-Antispam-PRVS: <DM6PR12MB330603B9BCE62E4FD1D12B90E5B29@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G6PBfAwOlDcjOeR7PzsmEqDeaIt13MKCJoiIiAmjgGOgyrzn+03j7eawIONenLi0NCfrsvmrlOGhqP9Uu24rZW6ioMOWXYBOefsvjvpIcANeTcY3wuaNw3/t04AfULTAECCKHms0D5UoXvrt6ueHESV4wt1WNgEc40QwhsdSmJxjm8Ij8RURUNJd6gTWWc9oR+7KwMCryZJVx/tav3jRWAqkGDfK/hOs30JD0RWOgdXYoCkDjypWcfpY0aj5mYSDQv/h0c2pubhtkhyKlJCKAOCE5ZaMNVxmnFjcC1parJ2eu4O2Aw5ULKXPjNwtaQPqTXtCmqiyOhl7Ofz7zeZkeaisDw0vlygDhAc8+WFIpxf5wJ1RhoQvIn7vPoooDI/SlM6qGeGDERapAYaeBvl6k5gP3f/1RwLHEJrUAXf7kpyN9VUizTAp3D3MQ/x8wDdUfcCeBkF1rpKEVJafmoVl4GD0CY8CKw9FX20nVkEXSshZTOZqrDFi/0+uHXmW8+OEY2qhieSKRZgJ6AD6f3XWP5SeLi8SiOu43uoXihArmInUgl2E0NR3FPmIUNcmVtspKY5CYwxpgE8k3SKnFwtMWk3e+AnFYhoXHvm1g+EmRnJTUkWeNMM10UT/FcP3OHnxJOVN+Yoxw5HoWhk3rggnDFv3GoB8O0jFU7LnVM92ERXxOJ1srxNssuvrit9epujaLKlpTZ77zdFbTd5htGd9JVya7Y9sFsdk0VZvUxt45gxJdyVkFR4YtplOTNhLpJ8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7406005)(7416002)(26005)(70206006)(36860700001)(81166007)(70586007)(86362001)(44832011)(508600001)(5660300002)(8936002)(4326008)(356005)(36756003)(110136005)(316002)(54906003)(7696005)(82310400003)(8676002)(6666004)(2906002)(83380400001)(2616005)(426003)(47076005)(1076003)(16526019)(336012)(186003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:40.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1d78fa-c4fd-489f-708f-08d98a863d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
index 242af1154e49..ecd8cd8c5908 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -104,6 +104,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages);
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages);
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -111,6 +116,11 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
+static inline void __init
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ad3fefb741e1..488011479678 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -553,6 +553,108 @@ static u64 get_jump_table_addr(void)
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
index 534c2c82fbec..d01bb95f7aef 100644
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
@@ -273,14 +302,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
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

