Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB694AF965
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiBISNb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiBISMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:49 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA57C03FEFB;
        Wed,  9 Feb 2022 10:12:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3fuYsS6BIiC4zUMvAkJFFBLYyvmYCzboY1eU6fjLu4/GsSpciNxmBD880s53qGILQ/Tu1dZuUSmUN6dxxsa1czwSeOquQf2IoGsY6bmvEW3GnmWiHtYlp6HTSLxvzlrPAUgvbEATTLqFAT5lFDLawBD64soofDo4VmjBVKVrIS28yg6c+rnCoIxtFQWtbTRf6+D+3YIxCJXghvy2VhZCmVDGsU5JyouNYkJC2TQKyouRNfYwE19EjCKTP5JWSOGFkv1DBP0K5Cwkz9UovAwuCHNxmYLH8Z1tNPQHhWcJ1QmLV9WebJAxm0AEIDkbS/Aw+wGfvZnlmxqQkCr3ffqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCQ6PS8X3zDNKEyTL3ntrb3s5JdJAhUHIdRGjfn2U4k=;
 b=oH/4oDY2yMb1N1qXC5xhZfTIR2Zjf4urOyMJNe3pXml/DRaFEnt9rbbDb7AR/IkGG21LOXK/9fcBRWsfgEqzo3v7ry95NcLziUboKdczu/mOx9ZSbUWUjUqVzU1bgbPkC3oXwB/Sf0RsN1buPMjsAOF9uQ3syl1cLDZtmRW09qNc4OQ7TBE1d09rHrZfhNoM7kvN+BhWDR6FtlfQnRPiXBsmPpCvFO0UVQ9CjjRfyWtiUomMk673S4yBrh/jlt8wHhjEKWxa8m1MVljS/vcZKzamQpsvCnEvE8PD9jixnL4ye6eUTFbsrLDXHuFSaEFDFiyYyn5V2H1DQw5eIFyLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCQ6PS8X3zDNKEyTL3ntrb3s5JdJAhUHIdRGjfn2U4k=;
 b=D8s+G5yUPyr/yPSw+hxATC7y1R6OBp8bvSDElHla/D+Vz+OYiPtJTwhHvnwl7Xq1aYlkCR/q7b09QPbLIbO6qmP8MzJhltiWTAILaOdKAqn66PmaZIUKIloUP4IMtoN0FqinuNkbLrydrch34tZWcMyDbd96+An5hMMVtfKKFfE=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 18:12:03 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::73) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:01 -0600
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
Subject: [PATCH v10 21/45] x86/mm: Add support to validate memory when changing C-bit
Date:   Wed, 9 Feb 2022 12:10:15 -0600
Message-ID: <20220209181039.1262882-22-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 229da489-97e9-48c8-ae98-08d9ebf7aca3
X-MS-TrafficTypeDiagnostic: BL0PR12MB4929:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4929504FEDCDD0F5ECEB815AE52E9@BL0PR12MB4929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0CONSq4hbGJrsl5JTRlPicPKE5af8k4X8V832ZD9tG9uaDpl7NGfOrI840q1LBNAz9eCqdeQI0EDoGkH7ZC90kUqdyRO0SNCbrNpQBQStne8/lOG21ShweclTtux+MHDVbLzV7gUAshcDiYrGaBH1c1Ga+ATT3Yq5XCwFMsino7iTv539CF85ekmUrV3HOvxoAs/kvrzmeTrZsMEF1yorR/9pQ3e/LuiRvI1KgrUe/91e6bbFxMLaCn3ONf3M8F1CSDRIel0ympajWF204kr/Cgkba+yjyPhHEE+izYdXSjJwQIJ9qSQ78u6kUGld4dHy8nK0diCKgs/DOILOWnafgDmmANhUOcYtUTOWCDNMITHdMdP5TZEGNXKHKjeC7/dVeIN9HnjJcgQ1ylUSe6DDpoH4pazDdsdOq24N0it6VgKLOzpk6woIWyFyiu/BnImir9ZwpdLEqbL7aElWOhAn7pOIy6rRK3MCen/CkGuczYXkw7exU/gUIwii+PFaT9IAcpmadcLgHki8vnXaZofcGbI5vmyxxbFTIsjo1xBIMlYF9uXKWiZi4CV5VXmK+lMA5qBucy5Ynd+nSkO7/5Wh+sn74Sgs/FT9K8f7QTrpLRcyDSs9Mwj4BxBjcubAWRc04N0P8smNOtAqDBqaqpvmTFBmrdKrOE9346gKzzvd+Ovja/JjAo5Cw1KtaiEyqxgaRA3Zx7nov020ZT0o1uMvydKMz1vJjF99jzDCuidP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(8676002)(83380400001)(336012)(15650500001)(7416002)(16526019)(5660300002)(508600001)(82310400004)(7406005)(36860700001)(30864003)(44832011)(86362001)(186003)(26005)(36756003)(6666004)(1076003)(7696005)(2616005)(426003)(47076005)(54906003)(70586007)(40460700003)(81166007)(356005)(110136005)(70206006)(316002)(4326008)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:03.4712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229da489-97e9-48c8-ae98-08d9ebf7aca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The set_memory_{encrypted,decrypted}() are used for changing the pages
from decrypted (shared) to encrypted (private) and vice versa.
When SEV-SNP is active, the page state transition needs to go through
additional steps done by the guest.

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
4K page size for all the PSC until RMP page size tracking is supported
in the kernel.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  22 ++++
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/uapi/asm/svm.h   |   2 +
 arch/x86/kernel/sev.c             | 168 ++++++++++++++++++++++++++++++
 arch/x86/mm/pat/set_memory.c      |  15 +++
 5 files changed, 211 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index f077a6c95e67..1aa72b5c2490 100644
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
index f65d257e3d4a..feeb93e6ec97 100644
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
index 1e8dc71e7ba6..4315be1602d1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,6 +655,174 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
+static int vmgexit_psc(struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	unsigned long flags;
+	struct ghcb *ghcb;
+
+	/*
+	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
+	 * a per-CPU GHCB.
+	 */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb) {
+		ret = 1;
+		goto out_unlock;
+	}
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying. Note, the hypervisor
+	 * will update the data memory directly to indicate the status, so
+	 * reference the data->hdr everywhere.
+	 *
+	 * The strategy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will
+	 * result in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		/* This will advance the shared buffer data points to. */
+		ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
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
+		 * Sanity check that entry processing is not going backwards.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
+"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	__sev_put_ghcb(&state);
+
+out_unlock:
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
+
+		/*
+		 * Current SNP implementation doesn't keep track of the RMP page
+		 * size so use 4K for simplicity.
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
+static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
+{
+	unsigned long vaddr_end, next_vaddr;
+	struct snp_psc_desc *desc;
+
+	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		panic("SNP: failed to allocate memory for PSC descriptor\n");
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	while (vaddr < vaddr_end) {
+		/* Calculate the last vaddr that fits in one struct snp_psc_desc. */
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
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	pvalidate_pages(vaddr, npages, false);
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	pvalidate_pages(vaddr, npages, true);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..e58d57b038ee 100644
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
+	 * To maintain the security guarantees of SEV-SNP guests, make sure
+	 * to invalidate the memory before clearing the encryption attribute.
+	 */
+	if (!enc)
+		snp_set_memory_shared(addr, numpages);
+
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
+	/*
+	 * Now that memory is mapped encrypted in the page table, validate it
+	 * so that it is consistent with the above page state.
+	 */
+	if (!ret && enc)
+		snp_set_memory_private(addr, numpages);
+
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
 	 * in case any speculative TLB caching occurred (but no need to flush
-- 
2.25.1

