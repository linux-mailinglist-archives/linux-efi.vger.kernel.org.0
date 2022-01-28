Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA24F49FF1C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbiA1RTw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:52 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:33742
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343686AbiA1RSz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy2j0V7nY/WSpB0luoeXQW2WrMPHHykt8wyPvD5igft+fCTzp64ZPBMnJtMlLDSpQJjl151JbLl7TdhFWCyC096IbPDDq78Usq7Ap6ePb5yBo7HUEbchs+mlPs6QffWPIt+x4Y9paBTD4h+X7rQgEpoTDSZPNiSCjYTZ/DWGsqvQCiVZhgmfc6eKBhWw5UIInRLvINl6mVz/dJ3m0T0Pl98VSnykt4LAlKu5dggeStTpkuRHQLkKVXXiFh4t4dhcH5uu3FH6PfPLsW/+zsqnriwrnYwC+cLyzoi0IrruPx9BPBjpuFU3dlQu5VYZPhLU3RBrYh1gsDzgQ8vUylPegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj3tTGD4GDEd1mC+RY5+EM9oj97X2t6t2v0vT0ra9LY=;
 b=G7fPstXvti4Yozg39jBaCgJ3GygyavKry+bWdmBxkPVoo4ffOxjjHNEb2k2KHNEXOyqekq9abzYuCkc7IzSpuZZO6RuNDn4U46n1Xa/tsISK3H053J4ca0Tk/nHfx7wu7jmhcgHqnvMUZ2aOl4nE+8On9nGSqHHS2V2pXEETsELwGTV6tdUQ+uUEBv/hB9smz4o4dm1KgWddV5WFp5bkRtFtt40NGWFVlxvpHHCI0Mw3rxLkptA/HRAAqgxNfQ3XyM2/yzwChgM3WiFDighhvMQCNp08V3vZLIkk3EzJ99KMyy1cs0ZuksyNOD/05b5ZgDi0u+YCs0o35Ks8+xoXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj3tTGD4GDEd1mC+RY5+EM9oj97X2t6t2v0vT0ra9LY=;
 b=aqV5bIhQyluBD6SuWDMx33Zs36i9Nyx6uFwPN4i/xUrqw7PcyFAk6qhMq1mwoO6ASro8ne9W3tZzYlRwM0Q/ESoi+LB3gzMI3ih6c+v+o7da3EJLK8t/zKU+TsUQxW0PhTI6KFlkaLmn8S4dX+bS3Sv7bDQFFj2bmXZUj4MDDYM=
Received: from DM5PR04CA0041.namprd04.prod.outlook.com (2603:10b6:3:12b::27)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 28 Jan
 2022 17:18:53 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::86) by DM5PR04CA0041.outlook.office365.com
 (2603:10b6:3:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:52 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:50 -0600
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
Subject: [PATCH v9 20/43] x86/sev: Use SEV-SNP AP creation to start secondary CPUs
Date:   Fri, 28 Jan 2022 11:17:41 -0600
Message-ID: <20220128171804.569796-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: af9508e1-481f-4709-eb7c-08d9e28241c2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52867D856C805708B2D80555E5229@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtreFDLrZAhXhX8UUT8yMP/7ZKM0CVN/DZCUfksBsrQKRSra/XfSo38UlvheA42WUJ1GWR8lyJGS8/B6RKrIILpj5HY98bhkptUHuzZZR+9LZbo7ccWWkQK8Cc3HzmTskURGb4rHYFbzhDbVVcTIZOoDPkxxJHwIyixrkRT2B7YYMzqwI+h5JRX/RXEAhdwZXJQlkxpoZu+EVRnc4kdC1f+ED5tVAlg7rqlQlRrDTcQndcO1kqOm82k2KwVEcmQwzG8ZwT2re8K47x96rxl6E2iyKv9UHVv6aWGfHXOXuJrLU+IvkVl1BgZYlw8RKci71eFt7aQnqDXX8izxwhumEC2Z0/zW3fAs95ZaA/UY7N+l2z+Ch38ULSLMxLWI+zHm/nbCrvBj9Rm2NCJ2xgEVVo2XaYX1/WmN7D77/oJAoN9gZ9OiWxU4qQtPNNKm5fly2fi3Cee7Iq9JVm8JpQZHKB/bdveGXHEXOwHoxHieVgHhydnCccrt8AB7UL2Kxgz6tDR20O0bS5hRa5hLViAKNRnn3/3DM1nSN6nx/cypYEsjMht2xifshWD8tr0Dq0ua32d7gWm70EZm/HHr/Vguem0wZ8RXWd9JC8PY7UYF6nHqLLV2EBhhjmgB584Y9MZQEC7LmH6jb3ggOpY++XygmRumIjMA5aaxYwY0ew8eq9hy2QfNRfOvv8mUXFw7tVKT1/X3atfiCXgFVWsgXEeuEYrCElIYRwB7v47rrQaL1WSy5Yg1V4yIUqx9c1zt0hW/Gqwwb4CRSPG4AT2AN0g6KtoBV6I8upeJTuRq8VJqQ39xyIUqHGmhp/nbRqBWEQxi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(82310400004)(81166007)(47076005)(26005)(110136005)(7406005)(7416002)(426003)(7696005)(83380400001)(6666004)(8936002)(70206006)(16526019)(186003)(356005)(70586007)(36756003)(2906002)(86362001)(5660300002)(336012)(4326008)(54906003)(30864003)(316002)(44832011)(36860700001)(508600001)(2616005)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:52.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9508e1-481f-4709-eb7c-08d9e28241c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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
 arch/x86/kernel/sev.c             | 250 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c         |   3 +
 5 files changed, 263 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 956b8b49528a..6d90f7c688b1 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -104,6 +104,7 @@ enum psc_op {
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index feeb93e6ec97..a3203b2caaca 100644
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
index b7ae741a8c66..19a8ffcbd83b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -31,9 +32,26 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #define DR7_RESET_VALUE        0x400
 
+/* AP INIT values as documented in the APM2  section "Processor Initialization State" */
+#define AP_INIT_CS_LIMIT		0xffff
+#define AP_INIT_DS_LIMIT		0xffff
+#define AP_INIT_LDTR_LIMIT		0xffff
+#define AP_INIT_GDTR_LIMIT		0xffff
+#define AP_INIT_IDTR_LIMIT		0xffff
+#define AP_INIT_TR_LIMIT		0xffff
+#define AP_INIT_RFLAGS_DEFAULT		0x2
+#define AP_INIT_DR6_DEFAULT		0xffff0ff0
+#define AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define AP_INIT_XCR0_DEFAULT		0x1
+#define AP_INIT_X87_FTW_DEFAULT		0x5555
+#define AP_INIT_X87_FCW_DEFAULT		0x0040
+#define AP_INIT_CR0_DEFAULT		0x60000010
+#define AP_INIT_MXCSR_DEFAULT		0x1f80
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -90,6 +108,8 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -822,6 +842,236 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, true);
 }
 
+static int snp_set_vmsa(void *va, bool vmsa)
+{
+	u64 attrs;
+
+	/*
+	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+	 * using the RMPADJUST instruction. However, for the instruction to
+	 * succeed it must target the permissions of a lesser privileged
+	 * VMPL level, so use VMPL1 (refer to the RMPADJUST instruction in the
+	 * AMD64 APM Volume 3).
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
+static void *snp_alloc_vmsa_page(void)
+{
+	unsigned long pfn;
+	struct page *p;
+
+	/*
+	 * Allocate vmsa page to workaround the SEV-SNP erratum where the CPU
+	 * will incorrectly signal an RMP violation #PF if a large page (2MB
+	 * or 1GB) collides with the RMP entry of VMSA page. The recommended
+	 * workaround is to not use the large page.
+	 *
+	 * Allocate one extra page, use a page which is not 2MB-aligned
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
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
+static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u8 sipi_vector;
+	int cpu, ret;
+	u64 cr4;
+
+	/*
+	 * SNP-SNP AP creation requires that the hypervisor must support SEV-SNP
+	 * feature. The SEV-SNP feature check is already performed, so just check
+	 * for the AP_CREATION feature flag.
+	 */
+	if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
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
+	cur_vmsa = per_cpu(sev_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page();
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= AP_INIT_CS_LIMIT;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set AP INIT defaults as documented in the APM */
+	vmsa->ds.limit		= AP_INIT_DS_LIMIT;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= AP_INIT_GDTR_LIMIT;
+	vmsa->ldtr.limit	= AP_INIT_LDTR_LIMIT;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= AP_INIT_IDTR_LIMIT;
+	vmsa->tr.limit		= AP_INIT_TR_LIMIT;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= AP_INIT_CR0_DEFAULT;
+	vmsa->dr7		= DR7_RESET_VALUE;
+	vmsa->dr6		= AP_INIT_DR6_DEFAULT;
+	vmsa->rflags		= AP_INIT_RFLAGS_DEFAULT;
+	vmsa->g_pat		= AP_INIT_GPAT_DEFAULT;
+	vmsa->xcr0		= AP_INIT_XCR0_DEFAULT;
+	vmsa->mxcsr		= AP_INIT_MXCSR_DEFAULT;
+	vmsa->x87_ftw		= AP_INIT_X87_FTW_DEFAULT;
+	vmsa->x87_fcw		= AP_INIT_X87_FCW_DEFAULT;
+
+	/* SVME must be set. */
+	vmsa->efer		= EFER_SVME;
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
+		pr_err("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		snp_cleanup_vmsa(vmsa);
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa)
+		snp_cleanup_vmsa(cur_vmsa);
+
+	/* Record the current VMSA page */
+	per_cpu(sev_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void snp_set_wakeup_secondary_cpu(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
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
index 617012f4619f..ad23d53b39ac 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1436,6 +1437,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_set_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.25.1

