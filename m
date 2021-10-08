Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2142701D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbhJHSIQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:16 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:43488
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240974AbhJHSHq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcEkhRiCq58KeYBIGCyzShKbEoJwTWl2Tu3lm7Tv254pkBdooDXuAJXWUmbb+Ya3T8wrT5g5eV1mkQPJgty0LW4Bj/b4G24r9jXLCEOJ3v9rRunDAh93v5kaM3duQ/JXqbSG0N6XcCkFhq7uHWl678PW/0rIaECB15sNLEIgfH6c3fxtIBfSF2wO/6mUH8e6JN2AjpcT46eK8Qjtqs+kAb65pa3/RnDDPYr2fOh+EgljKK2QWB4ZR/BpDY9tHvFbP4rLS3911KCN+bVTnpkfE1DBK5B2BMuiCv9jqadVYTs1xvR4dILjkpXWT2QK2NHtiSF5Y++AQ2K7zc92HTgFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly395ovnZOsqqsy088jWXToQbNG5Baqi6A1uvpzN8bQ=;
 b=TP2R3MAPvOXRiX+zMeCJQppBLPl3vVGgRcNfnXNmRBLATAVMw/63n5O770HPi479orb/Yyqv+KlnKuvUOPw1VkOmcKNHG+sjk9rhBypfULkoS/9Vw4ebXHNLVBOVm8i2coN2bOuDcI5mEnOfUoT2GEJy+t9Q1mF1loGCVG3iFONV1p5HaY40Q2tGvoxkXQkBNRKWqyjTfY9sKf0+FeWV0iKQV945zR+9GbMM1nrqpT4ll4GbXBF8Htz8eK2ALOqNCVIskwrkEPgnGWOW6+mKHTaDQRvIa0cscDughO/BPMb3Dh7Pwe6b/Yk+lp8DEbE8yKpRObnc8kCD9i3jhclbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly395ovnZOsqqsy088jWXToQbNG5Baqi6A1uvpzN8bQ=;
 b=B86sHuVTp4dBRjqmPROZymae20OwywDPjidrVBiokxC7z2bZcF5EFLoy6fFgwP6h+tnYC3cWlMIB2jZJpnsV9i9LWkSZncl+fwUiQ6Naz2Al8E8qeq/6p8crer6vIuctb0Dy6FpgyrbATo12FkEukGBYe7GLUSn+KGY9WCq7jTw=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 18:05:46 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::37) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:45 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:42 -0500
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
Subject: [PATCH v6 19/42] x86/mm: Add support to validate memory when changing C-bit
Date:   Fri, 8 Oct 2021 13:04:30 -0500
Message-ID: <20211008180453.462291-20-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41112e17-7e5e-44a2-d518-08d98a864017
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00910A58B31DC0947CE24368E5B29@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4B1KNP604xwWL2WHXc4RX8AyaPy2bILhkiklfNT+1LvXQ+N0fGftVv0cpbgon/gBU5bhaiFU7p2HxUggKwfcEc8jvSypjq3Qi3Yh9diXBnkla/33C+hL8g5QrB4pjKvfIOdpwuXymnvas27eWILX44xEjw+XyR3klFEE/NCNlKkcuJva9TrakZasEqaZNScAAs0hrAs4gUey1T6N04gBw2RzUQ85hdhXdBN0MbypxOJKFxqFgv7yK7RsrGWoe8tse/aaAtutaTGmR/aMv+lwpQWjiNe3ViLHkIcsSO2aKnHKTEaoy+PG2L2HkJm4S5cYxadH6yY+gu2P1ryYoyaCo1wNPt+pJWBL+YCMHjGLLXK9xDoFBFFmfleaKHmhzaRmAduoh2q7FbGwrbvv25Opu9y3Sbc3JJ4tgfYBaDpgdXC+OcW4wzMhGhh+uHwlnTvmFYaLSbZt+KgM7ojuyq5RA+KiRODZd34cm2PNRScoxbp2MYQCGWhmJyNsoAZiPlJspz1cEUbMXy+zXdUEYGNZQMTFf1nHpphJbHEFISA/L65P3boSXtqIHyDTslUfdvdVZFLL+/u6zavaHC5IhZ5R5pSI5USOUxTSrOfU+XxbQu1OhA+g5EtWhcEYLPgVE+BesGhVGuvg62hMMO94EyasbRI/mAlwdFfZymCNbPwNf1P8ulRXS9KfVipc4ou4xqYVnSHS3R1R6Lrs9goxE/kOFlJo6SPn73+nX9yLKbrJMrDql9p80UOG3yCBBJD69yvj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(86362001)(47076005)(6666004)(15650500001)(7416002)(2906002)(5660300002)(8936002)(4326008)(186003)(426003)(8676002)(81166007)(336012)(356005)(2616005)(44832011)(16526019)(7696005)(36756003)(316002)(54906003)(70586007)(110136005)(508600001)(70206006)(82310400003)(7406005)(83380400001)(36860700001)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:45.3551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41112e17-7e5e-44a2-d518-08d98a864017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The set_memory_{encrypt,decrypt}() are used for changing the pages
from decrypted (shared) to encrypted (private) and vice versa.
When SEV-SNP is active, the page state transition needs to go through
additional steps.

If the page is transitioned from shared to private, then perform the
following after the encryption attribute is set in the page table:

1. Issue the page state change VMGEXIT to add the memory region in
   the RMP table.
2. Validate the memory region after the RMP entry is added.

To maintain the security guarantees, if the page is transitioned from
private to shared, then perform the following before encryption attribute
is removed from the page table:

1. Invalidate the page.
2. Issue the page state change VMGEXIT to remove the page from RMP table.

To change the page state in the RMP table, use the Page State Change
VMGEXIT defined in the GHCB specification.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  22 ++++
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/uapi/asm/svm.h   |   2 +
 arch/x86/kernel/sev.c             | 165 ++++++++++++++++++++++++++++++
 arch/x86/mm/pat/set_memory.c      |  15 +++
 5 files changed, 208 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b82fff9d607b..c2c5d60f0da0 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -105,6 +105,28 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 
+/* SNP Page State Change NAE event */
+#define VMGEXIT_PSC_MAX_ENTRY		253
+
+struct psc_hdr {
+	u16 cur_entry;
+	u16 end_entry;
+	u32 reserved;
+} __packed;
+
+struct psc_entry {
+	u64	cur_page	: 12,
+		gfn		: 40,
+		operation	: 4,
+		pagesize	: 1,
+		reserved	: 7;
+} __packed;
+
+struct snp_psc_desc {
+	struct psc_hdr hdr;
+	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
+} __packed;
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ecd8cd8c5908..005f230d0406 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -109,6 +109,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -121,6 +123,8 @@ early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index b0ad00f4c1e1..0dcdb6e0c913 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_PSC				0x80000010
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -219,6 +220,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 488011479678..80fdfd83770a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,6 +655,171 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
+static int vmgexit_psc(struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret;
+	struct snp_psc_desc *data;
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+	struct psc_hdr *hdr;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (unlikely(!ghcb))
+		panic("SEV-SNP: Failed to get GHCB\n");
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, sizeof(*desc));
+
+	hdr = &data->hdr;
+	cur_entry = hdr->cur_entry;
+	end_entry = hdr->end_entry;
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Checks whether all the entries
+	 * are processed. If not, then keep retrying.
+	 *
+	 * The stragtegy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest access the memory pages. If the
+	 * page state was not successful, then later memory access will result
+	 * in the crash.
+	 */
+	while (hdr->cur_entry <= hdr->end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2)) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backward.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
+"SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, hdr->end_entry, cur_entry, hdr->cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	__sev_put_ghcb(&state);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void __set_page_state(struct snp_psc_desc *data, unsigned long vaddr,
+			     unsigned long vaddr_end, int op)
+{
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned long pfn;
+	int i;
+
+	hdr = &data->hdr;
+	e = data->entries;
+
+	memset(data, 0, sizeof(*data));
+	i = 0;
+
+	while (vaddr < vaddr_end) {
+		if (is_vmalloc_addr((void *)vaddr))
+			pfn = vmalloc_to_pfn((void *)vaddr);
+		else
+			pfn = __pa(vaddr) >> PAGE_SHIFT;
+
+		e->gfn = pfn;
+		e->operation = op;
+		hdr->end_entry = i;
+
+		/*
+		 * The GHCB specification provides the flexibility to
+		 * use either 4K or 2MB page size in the RMP table.
+		 * The current SNP support does not keep track of the
+		 * page size used in the RMP table. To avoid the
+		 * overlap request, use the 4K page size in the RMP
+		 * table.
+		 */
+		e->pagesize = RMP_PG_SIZE_4K;
+
+		vaddr = vaddr + PAGE_SIZE;
+		e++;
+		i++;
+	}
+
+	if (vmgexit_psc(data))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+}
+
+static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
+{
+	unsigned long vaddr_end, next_vaddr;
+	struct snp_psc_desc *desc;
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		panic("SEV-SNP: failed to allocate memory for PSC descriptor\n");
+
+	while (vaddr < vaddr_end) {
+		/*
+		 * Calculate the last vaddr that can be fit in one
+		 * struct snp_psc_desc.
+		 */
+		next_vaddr = min_t(unsigned long, vaddr_end,
+				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
+
+		__set_page_state(desc, vaddr, next_vaddr, op);
+
+		vaddr = next_vaddr;
+	}
+
+	kfree(desc);
+}
+
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	pvalidate_pages(vaddr, npages, 0);
+
+	set_page_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	set_page_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	pvalidate_pages(vaddr, npages, 1);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 527957586f3c..ffe51944606a 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -30,6 +30,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/sev.h>
 
 #include "../mm_internal.h"
 
@@ -2010,8 +2011,22 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
+	/*
+	 * To maintain the security gurantees of SEV-SNP guest invalidate the memory
+	 * before clearing the encryption attribute.
+	 */
+	if (!enc)
+		snp_set_memory_shared(addr, numpages);
+
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
+	/*
+	 * Now that memory is mapped encrypted in the page table, validate it
+	 * so that is consistent with the above page state.
+	 */
+	if (!ret && enc)
+		snp_set_memory_private(addr, numpages);
+
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
 	 * in case any speculative TLB caching occurred (but no need to flush
-- 
2.25.1

