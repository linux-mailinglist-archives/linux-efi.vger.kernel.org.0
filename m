Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39371470448
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhLJPrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:52 -0500
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:32586
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243295AbhLJPru (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDLdEN1T20k5ek4GMg+DB8gUJVZcVKCZh27tsXFVOpSoLZ6soCG8NjetPRpaRKvr/2fF3dewvgjqlxglzcwgQCfC3joIfDg6qXnwndZbX3U7DNLifejA+WhkegXgXhczMklIPIj9e8AXV/DTwbLGYKDus7MU+uDYYkpY+ycgmeFujHWEeAn19L5Zrhd+RJzn+xWhCTQXhAWi03oY4e+zyaPQxl19oJ7+uxtccqGV76lrgnaRfQkgd9o3+rBOvBdrVqtKbPZywQm9A718N4C9CQXewEtizSf5xMa8yfFVdGcsw6JhHzIX73tX1KkAcalooi5JRd7DjtGSQPPvMmaPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52AJNTN9PJADg9pknyknWpdErqREPjG/dnUAgNhpwJI=;
 b=OU7iGv1OSIShZ8yGZtlYhhGS1IhIt/lnoH8V3IkIAAZcnDV5WJnA1njWpcENc9IjvKxBEqvdw+VBU1SYe+0HAewtC3Z3AGoD2/nRcyXiWI991oucqva4bS3aCj25h1DiXXmAGtbhvPasBNO3MnusmWokGm/IFWQHEGafctPKNhjVLPhZOsrg94DKByvTgiey2NTeE1gxDfBTuu04ey1rS7MJUAOflgVCJNuUBJFXodSt+/EUe2FND1LN1gOxCYK/WtIr3QbZoBNsEdidY4l2eDV+WiSsnelCbhuyad8g/G6LUcnjNnwIOGbkaytXB93Y6lszLqtsau3eHyzmtz7/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52AJNTN9PJADg9pknyknWpdErqREPjG/dnUAgNhpwJI=;
 b=IUwJcjRSC6qup7HpM8XFZr+K1yEI9rSgDtp8Vn77ydVR2XA6wXm5oKgAwQt2YnaQ+TajUe/ISwHDRHMBeOS1l/4aEiRXfteMEvK7gu62hZ5zdn2++PHhshI9RdvSzH7TaHNTWGw1rqH3YI4zOU/5fHCbbsee0tcTQmjJGEbHT4o=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by DM6PR12MB3145.namprd12.prod.outlook.com (2603:10b6:5:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 15:44:13 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::a0) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:13 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:11 -0600
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
Subject: [PATCH v8 15/40] x86/mm: Add support to validate memory when changing C-bit
Date:   Fri, 10 Dec 2021 09:43:07 -0600
Message-ID: <20211210154332.11526-16-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ac8f26a-7991-4fde-d668-08d9bbf3ea52
X-MS-TrafficTypeDiagnostic: DM6PR12MB3145:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31452514FFE40C75F996B917E5719@DM6PR12MB3145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6UcElbhljKekHFwT4sYyis1VmTz+wszmZKgeVvs+o3bbq2hwHZSqsYy1lkrjM3cZMXkBmE4lJUUdEyqfMGngnarnyA5bSZ6GSMzmvDvFvyNAxgs9qFichwtSOPsAoWwIGmmlQExP8lJrV1z9hdnYP6zCT1EeQVXEfezDZHts2v+1j4t7ezBP3cvnO6Ma9rOcnfJFKb9whcyueNXvlofXXUEQ9kZ0xhzLlLFpcNiTr9T+JKOkBdy8mHpdfrWKUDnLa53IKIE6d88kW4ZCW1yI+z6vjbqj6lc5jB2c7TgzpmmRi5lGL3VMuN2qXGPptYvNQjxe7vV3/0oh5ERzXQUwSq3d9Gj3TcxheUQ/Sc6OgqSjPkfaECOdsYP4IVxOaYK/yroRmilI1ityDIegXm9m5K2+eNHHx0CMvcsO/0ZLe5ixZzx+DNDjpmq7YzjeQszPuSDUIM1lp4IxX+K95L4OQBXIhw45UxNclJnQOKpdFsgy72WOiXS/UY6GRhdAOxRpH5lSRQ5GPkYkj40yI13fzM4xNzO6sZAezUNWSh9/Vf7WIdoBe2WqU3ddCaV8ndg7bonwJ44ELTUu81NpOJsgBLRAWw2EGscew0Zhcxnpt9FnIMyniOFS3WwkD5SdhFWbYHxC2AIDT/b4/sQLzWdCS0Pb4ZfeIKq1aH1Dcl427RQbIccKAMUhnQLUPBX9o5+oQ0iJngSn86knyPdJMvMs5CvbtZwrZKuMYXp4IGO6/LGWRszGhuQchsH5BHtPvOKJJtRc4bZdCJm27Yf31RFA+BU+7HjAd5CxXXpaLbRChDJfDqhQjLaB1sBf107Or01/CUY9M8tuJZkxayeQEnvrSsoUfeqFuNvElnA7oPE982zpRLZS9JO5m3gVf600nux
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(426003)(7416002)(15650500001)(82310400004)(83380400001)(1076003)(26005)(36756003)(8676002)(7406005)(47076005)(336012)(7696005)(16526019)(44832011)(356005)(40460700001)(86362001)(8936002)(316002)(6666004)(110136005)(508600001)(4326008)(70586007)(30864003)(5660300002)(2906002)(36860700001)(186003)(81166007)(70206006)(54906003)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:13.1946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8f26a-7991-4fde-d668-08d9bbf3ea52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3145
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
index 6dc27963690e..123a96f7dff2 100644
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
index 2971aa280ce6..35c772bf9f6c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -574,7 +574,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_page_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -622,7 +622,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
 
 	/* Validate the memory pages after they've been added in the RMP table. */
 	pvalidate_pages(vaddr, npages, 1);
@@ -641,7 +641,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	pvalidate_pages(vaddr, npages, 0);
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
@@ -659,6 +659,161 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
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
index b4072115c8ef..5dc17d446204 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,6 +32,7 @@
 #include <asm/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/sev.h>
 
 #include "../mm_internal.h"
 
@@ -2012,8 +2013,22 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
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

