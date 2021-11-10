Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE544CBE7
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhKJWMQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:16 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:38368
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233653AbhKJWLR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih9qsANVLoFkI8xyQY1GR9651khJ9fKhMfmsNUHS3+NB480Y7xk/vxJu8nJ6YX3FEXITPGjQodUrO5zeFp3495VBqj7rdKSE4K0JZtpZ25KChOLM0+hWqnih2li4kAu7JPFRCwyxv/K7IXVUWTAm37W/I2WFTIHE0y3soN83KjO7P9d/le+r+okYEV9TgBcSd51NKUL00sHsDirY6kMAf+ZAqX5/BNHP+0YqFKpSPTet8UdHuvpvVwzrwnQ9abU2BTLKcsy4E+59qUendfjF63t4BjFOmB3MndwB6GgB4cTzcYWdfzw3afp5h+2aPw++jX3EXWqg1rMq/gaOotU4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex7AGy6kUsXYDGSz2SxbubeQOTKTBrPGg0B5FnVwIcE=;
 b=C9B3JLzSSn8ji5OQrtfi93pN5gH4AhmdYfjbTMLjdwCuRtWMPHfP+Qe7tURpQp3uQKai6RruhQILBX202grj9lU1S/dCMPpLQBiL55MeDbcHLAtQp8X9GXFgPt6VkRWiNIvdaJrkk2cZnZfDRMFbou2WaOv9c0jSVQGUMaDY3EGkeo6eMNhpVxpdLqowN09ezVrOOm++5LA2/SxFu+9OwsaaH3vAIyZJ5R5RqNwze0faWnZUTVjiO6Vl9I4iKq3gVPWBwlq4A7jbHMsxaPikYeybPqpK2rktoO9AjsH+QFW3dg+4e7egUhZubonrD+ZZzp8ecG7YeA8OA9TPosLtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex7AGy6kUsXYDGSz2SxbubeQOTKTBrPGg0B5FnVwIcE=;
 b=RLQwObb+8ET1ey/yIzu52WO21qBY5Z7PsUILDoE2o02G6YlIX1n/hJVuWEmmw/HuOd9JZpGj1pl9Rd6vaM2VKjiwZPN53ADXklTGCrL+UC/yQF0XwBd1lv+CMXHhhpV3kfrNHB7R5xKrIxEXQYMXd0RuzxT5dsekEF4dvVaz/PA=
Received: from DM6PR11CA0062.namprd11.prod.outlook.com (2603:10b6:5:14c::39)
 by CH2PR12MB4806.namprd12.prod.outlook.com (2603:10b6:610:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:08:26 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::94) by DM6PR11CA0062.outlook.office365.com
 (2603:10b6:5:14c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:26 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:24 -0600
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
Subject: [PATCH v7 20/45] x86/mm: Add support to validate memory when changing C-bit
Date:   Wed, 10 Nov 2021 16:07:06 -0600
Message-ID: <20211110220731.2396491-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80431bc5-c904-4f43-e512-08d9a4969ec1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4806:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4806224FDBFC5BB765881BFFE5939@CH2PR12MB4806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UjaGaAFlaUL82m1Z0+nZW28RVs/x/ODKWGM5bU/myHPutp42+yaLKQZUoJMPUDFaHFfBQ82qTRKuel+7XQddFWwV9flBRxs2RCBDZgkDvr+1wNW9LkiFRf4BSd1Kv3Z+mO5GIpie+isufRSBGu+Hh4yo2YAlGS/I14EKoS4g3gxsEuerTKUqZGgCqPc8yIkv2Q9yCQOw0Y31HjCUaZQrWm8QVjHvYXXI0S1G1dzo1KMGt0L38UpGLN60YhR0s+gz6tRkPXZCbbRNhnUTt6inz9bPY3lI+E3Pzfs8F6+vccZgQVeoqvPHjQE+IzOm5v7LLb+8W5BPcDlrB8qXrXC2yEa4vh0F9BKv8StT3CRUsYOyQG6y8k+XVF54hH0+CFf6x8Y41HZA/TLdjfZ1lHYhHIBd0t1h9TN2Lwhi5OSYvzpYzhQgFGcvElNWwzMs/J+Ut0zTuemKo8sLvVS4PP7lJg3R5331wQHMjGTeBqCDZLPZcSXxv6fNlrR9yy4dkDwEQj2X8srfY8KvJhnxf/k+3CTtKyq3l9tSk1gPUd5EpS80feIb9uY+5pS/a0oBGsc5uZdg3PIVTuF7lUXwF2o/fTe0zPO5SPWTMWsu1NNWNz0EuHbHSFqpDj/5r+0AGn/zpzOxgtL/Mi0XnXrHYQDq39n1ioBhWrjS6Bwkv7zGGVlpkpVaQPFUvT3v5dbBe55ChxG1dERbO+LXqMzjPzu2O7wc7ILPQSuC6+gb/bqWW5QgUqhbKHhqUX77RwBmH8V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(7696005)(5660300002)(15650500001)(1076003)(7416002)(26005)(70586007)(8676002)(70206006)(47076005)(186003)(8936002)(44832011)(36756003)(4326008)(7406005)(54906003)(426003)(508600001)(110136005)(81166007)(83380400001)(356005)(2616005)(82310400003)(2906002)(16526019)(30864003)(316002)(6666004)(86362001)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:26.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80431bc5-c904-4f43-e512-08d9a4969ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4806
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

The GHCB specification provides the flexibility to use either 4K or 2MB
page size in during the page state change (PSC) request. For now use the
4K page size for all the PSC until page size tracking is supported in the
kernel.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  22 ++++
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/asm/svm.h        |   4 +-
 arch/x86/include/uapi/asm/svm.h   |   2 +
 arch/x86/kernel/sev.c             | 161 +++++++++++++++++++++++++++++-
 arch/x86/mm/pat/set_memory.c      |  15 +++
 6 files changed, 204 insertions(+), 4 deletions(-)

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
index eec2e1b9d557..f5d0569fd02b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -128,6 +128,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -142,6 +144,8 @@ early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index b00dbc5fac2b..d3277486a6c0 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -309,11 +309,13 @@ struct vmcb_save_area {
 	u64 x87_state_gpa;
 } __packed;
 
+#define GHCB_SHARED_BUF_SIZE	2032
+
 struct ghcb {
 	struct vmcb_save_area save;
 	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
 
-	u8 shared_buffer[2032];
+	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
 
 	u8 reserved_1[10];
 	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
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
index 3c3b96a2990f..156026cfd9be 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -549,7 +549,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_page_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -597,7 +597,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
 
 	/* Validate the memory pages after they've been added in the RMP table. */
 	pvalidate_pages(vaddr, npages, 1);
@@ -616,7 +616,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	pvalidate_pages(vaddr, npages, 0);
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
@@ -634,6 +634,161 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
+static int vmgexit_psc(struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+
+	/* __sev_get_ghcb() need to run with IRQs disabled because it using per-cpu GHCB */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (unlikely(!ghcb))
+		panic("SEV-SNP: Failed to get GHCB\n");
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying.
+	 *
+	 * The stragtegy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will result
+	 * in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		ret = sev_es_ghcb_hv_call(ghcb, true, NULL, SVM_VMGEXIT_PSC, 0, 0);
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
+		/* Verify that reserved bit is not set */
+		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backward.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
+"SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	__sev_put_ghcb(&state);
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
+			      unsigned long vaddr_end, int op)
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
+static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
+{
+	unsigned long vaddr_end, next_vaddr;
+	struct snp_psc_desc *desc;
+
+	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		panic("SEV-SNP: failed to allocate memory for PSC descriptor\n");
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	while (vaddr < vaddr_end) {
+		/*
+		 * Calculate the last vaddr that can be fit in one
+		 * struct snp_psc_desc.
+		 */
+		next_vaddr = min_t(unsigned long, vaddr_end,
+				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
+
+		__set_pages_state(desc, vaddr, next_vaddr, op);
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
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	pvalidate_pages(vaddr, npages, 1);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 527957586f3c..9b13770a633e 100644
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
+	 * To maintain the security guarantees of SEV-SNP guest invalidate the memory
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

