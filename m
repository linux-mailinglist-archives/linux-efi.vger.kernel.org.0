Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2B44CBD8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhKJWMJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:09 -0500
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:17406
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233637AbhKJWL3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E58OFvMeLJyQNlzfapF4c9adFg3I7s6FEhCVVf6XmjjmRJt+Ckxg5hN2WfEhrLqUK5B9vB2BIxS6nm9K/Vc7rJqTWeMrPdnVNkfirF8qimCtb2zY/B9yapoSGHzro77VhyYhUmABhbxy2m+a8+4t6vsUC0k6GR774uuXW0ivkLBgtf+tFsziVwd/1dudEYh63JwEy4tsHa8YHsXgfzw1UmIglIwExRg2W5tdcQhjnF6NliWUlfIy96cOzwMJF/eOsLba0wBNo5cJgihCxHCjkcBmfrFiJxaKRZFWICcMRaarCjgJgfs73Y4cP9lWmo1hac5dqldptCUrdJK/LVO1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izeAY1ZNzQ2GU37JXUGsPFVwuavs/Ietb8cu1QnLt68=;
 b=AHs79IEf0aLMk5LX9729PTVmV9S0Uwdgg7csUX0YPrrjd+Hsj6mJ5LnpjGkhBuoKbqut0wSMACS0LQUuFhy+ye37NvT7K242SFteDXo9R6MYfiG8iq9Ps54BJ5ydxtgz2GTVGr1QwHphNBLFUuZ582mSk3fGEVmXZTOWsBm29HzJTdERDXzLKtc2ZdnYGQIPfjQlCzSEsSw1/B8IveDbE8kP3PRh7JXYl/J8/Suq+qfxzQe+hZmx5Wx+PAUD6vGiRdVFV+4ETl/1Yiyi6Hf+AUqntVE4cXju0dUDIMf7bwe5r0NOkOGwn2kiyHJ9MGg/b7FgMIdB/JhrT8YZJ38D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izeAY1ZNzQ2GU37JXUGsPFVwuavs/Ietb8cu1QnLt68=;
 b=m1ExIoLETXgP8+LScfH77aPp4e0sx8egVuNbBP6xmd7gq0b+IHkSNs9mRv2MR7s3Jtxz6FfwQY/2gx2OhluwwbLCDJnwyRTkzFa/oqRA47/AiF0VLFVmzEQU58gjusdMVRwyy/fWys/FJUGD5DUQvU78rwO80U/jP4N95LWwdq0=
Received: from DM6PR21CA0003.namprd21.prod.outlook.com (2603:10b6:5:174::13)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:35 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a7) by DM6PR21CA0003.outlook.office365.com
 (2603:10b6:5:174::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:35 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:32 -0600
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
Subject: [PATCH v7 25/45] x86/sev: Use SEV-SNP AP creation to start secondary CPUs
Date:   Wed, 10 Nov 2021 16:07:11 -0600
Message-ID: <20211110220731.2396491-26-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfebfb9c-b395-4b1c-79c6-08d9a496a3ee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42656BEE385C17B006081D20E5939@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkfiiJT96cevZhVETFZlkRaugi6dWQdJNg/gASk1joarJ0oizCRYijz5tgwIalEIh5LW41OYpSbdzqzUHdT5FgzjeiZXd9TJcV/OELuWXU5eRaDfnMoopnvIZohqQhXJgWW/ksSxQUOdK7aUgfQfSQ3SqNZgG6KYoiVe76C2S99hcYc9gjHXG2pViLOKsADhPYEzLoW8Zq5hdN61AC+3/wcc1t/daEQCSXobAoKQ49vx/g0wiTDFElfZWjVs+cksflsDfsnTQsdkT4psAgoHvEcM4Z0GWFJq//08topp97lYegBoGHZ+i7zfThF1zTlDIjNbYbeMNz2/keTi8+ZIWNI0rjRoo2fkK24ULLhH2i2UDru3IxPWytLlWWocYL/odw9h/Jp3BG2U/QJgw7qseNjkHO8pW2DpQ3eOaM0Q4RXxHDmSQkyXSWDvgEkSWK/UKNlqp5L7ppwvQmemaP0tWonjJF/UC0QJlnLZumjptIXQ83djH2TaCn6dBSWQxhhnfAmoM3vwrF+78GUGAOLRybljm+dSGvo3j8YBvKOQWExAtcdZxHLBWypXxopDhfFyk04M1IxQLOY1ZSd2PQJMMarHVOZ0TYF/HszPkgCQbLMSitf35W0XDvZYHAcQh7m4VTOttCpFU82we+FJsu7S8kPyNN/1Wvin0DHdyb6qyTKqHKEdb9Mm0wE6hpp08MGJPdonsqVj49foHesKm6q0H2+B0FmFvgxh7+vFCPtm4Ppc8x3UODeLaufmWib6moIa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(8676002)(70586007)(8936002)(5660300002)(54906003)(36756003)(7696005)(47076005)(1076003)(6666004)(36860700001)(82310400003)(26005)(356005)(7406005)(30864003)(70206006)(44832011)(186003)(7416002)(2616005)(86362001)(426003)(83380400001)(81166007)(336012)(316002)(110136005)(4326008)(2906002)(16526019)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:35.0501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfebfb9c-b395-4b1c-79c6-08d9a496a3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
AP Creation NAE event. This allows for guest control over the AP register
state rather than trusting the hypervisor with the SEV-ES Jump Table
address.

During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
SEV-SNP is active, will set/override apic->wakeup_secondary_cpu. This
will allow the SEV-SNP AP Creation NAE event method to be used to boot
the APs. As a result of installing the override when SEV-SNP is active,
this method of starting the APs becomes the required method. The override
function will fail to start the AP if the hypervisor does not have
support for AP creation.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   1 +
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/uapi/asm/svm.h   |   5 +
 arch/x86/kernel/sev.c             | 229 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c         |   3 +
 5 files changed, 242 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index c2c5d60f0da0..c380aba9fc8d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -104,6 +104,7 @@ enum psc_op {
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
 
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f5d0569fd02b..f7cbd5164136 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -66,6 +66,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
+#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -130,6 +132,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+void snp_set_wakeup_secondary_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -146,6 +149,7 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_wakeup_secondary_cpu(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 0dcdb6e0c913..8b4c57baec52 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,10 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_AP_CREATION			0x80000013
+#define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
+#define SVM_VMGEXIT_AP_CREATE			1
+#define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -221,6 +225,7 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 156026cfd9be..e966b93212c7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -31,6 +32,7 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -87,6 +89,8 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -789,6 +793,231 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, 1);
 }
 
+static int snp_set_vmsa(void *va, bool vmsa)
+{
+	u64 attrs;
+
+	/*
+	 * The RMPADJUST instruction is used to set or clear the VMSA bit for
+	 * a page. A change to the VMSA bit is only performed when running
+	 * at VMPL0 and is ignored at other VMPL levels. If too low of a target
+	 * VMPL level is specified, the instruction can succeed without changing
+	 * the VMSA bit should the kernel not be in VMPL0. Using a target VMPL
+	 * level of 1 will return a FAIL_PERMISSION error if the kernel is not
+	 * at VMPL0, thus ensuring that the VMSA bit has been properly set when
+	 * no error is returned.
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+}
+
+#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
+#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static void *snp_safe_alloc_page(void)
+{
+	unsigned long pfn;
+	struct page *p;
+
+	/*
+	 * Allocate an SNP safe page to workaround the SNP erratum where
+	 * the CPU will incorrectly signal an RMP violation  #PF if a
+	 * hugepage (2mb or 1gb) collides with the RMP entry of VMSA page.
+	 * The recommeded workaround is to not use the large page.
+	 *
+	 * Allocate one extra page, use a page which is not 2mb aligned
+	 * and free the other.
+	 */
+	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	if (!p)
+		return NULL;
+
+	split_page(p, 1);
+
+	pfn = page_to_pfn(p);
+	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
+		pfn++;
+		__free_page(p);
+	} else {
+		__free_page(pfn_to_page(pfn + 1));
+	}
+
+	return page_address(pfn_to_page(pfn));
+}
+
+static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int cpu, err, ret;
+	u8 sipi_vector;
+	u64 cr4;
+
+	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Verify the desired start IP against the known trampoline start IP
+	 * to catch any future new trampolines that may be introduced that
+	 * would require a new protected guest entry point.
+	 */
+	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
+		      "Unsupported SEV-SNP start_ip: %lx\n", start_ip))
+		return -EINVAL;
+
+	/* Override start_ip with known protected guest start IP */
+	start_ip = real_mode_header->sev_es_trampoline_start;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	cur_vmsa = per_cpu(snp_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)snp_safe_alloc_page();
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= 0xffff;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set VMSA entries to the INIT values as documented in the APM */
+	vmsa->ds.limit		= 0xffff;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= 0xffff;
+	vmsa->ldtr.limit	= 0xffff;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= 0xffff;
+	vmsa->tr.limit		= 0xffff;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->efer		= 0x1000;	/* Must set SVME bit */
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= 0x60000010;
+	vmsa->dr7		= 0x400;
+	vmsa->dr6		= 0xffff0ff0;
+	vmsa->rflags		= 0x2;
+	vmsa->g_pat		= 0x0007040600070406ULL;
+	vmsa->xcr0		= 0x1;
+	vmsa->mxcsr		= 0x1f80;
+	vmsa->x87_ftw		= 0x5555;
+	vmsa->x87_fcw		= 0x0040;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl		= 0;
+	vmsa->sev_features	= sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = snp_set_vmsa(vmsa, true);
+	if (ret) {
+		pr_err("set VMSA page failed (%u)\n", ret);
+		free_page((unsigned long)vmsa);
+
+		return -EINVAL;
+	}
+
+	/* Issue VMGEXIT AP Creation NAE event */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_alert("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		err = snp_set_vmsa(vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)vmsa);
+
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa) {
+		err = snp_set_vmsa(cur_vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)cur_vmsa);
+	}
+
+	/* Record the current VMSA page */
+	per_cpu(snp_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void snp_set_wakeup_secondary_cpu(void)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	/*
+	 * Always set this override if SEV-SNP is enabled. This makes it the
+	 * required method to start APs under SEV-SNP. If the hypervisor does
+	 * not support AP creation, then no APs will be started.
+	 */
+	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8241927addff..2bf8d9ce7d94 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1419,6 +1420,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_set_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.25.1

