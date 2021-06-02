Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D5398B8D
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFBOHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:25 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:9824
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230291AbhFBOG4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFWdwn9PB0TKIXo1l61DtoDHf9dQquuC5H3wU0QAXzVmuUgN+MiiFR7SyyOVe2v59S639q4WRh2zTsXF6FsJ8vucyrpQes3h+uMHi+bvzAqLYN/u1V2ahbuLP1057Z8go2xksdHMCg+2/VCPliniA6blx29oAX2Vze8GWlW36eiylURxjJ5+2s5NJp2h9vgTV2DGgl3kmRHIxUTHWY25ZFtCCwsJ+oLIEacMoJtF5czbS+32oHuv2GICtASsKS2LwR0/q/0EbHFznZ3a5D0d+rdd0HZsrUA2ugRi3nMMpv5CWPvC8yYgIjofdCejPOac7uRKDErfUIp6KhN+iEv5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAxXa3XbI3kMvkyIuMan4kaJrAgUQ5kUqyJ5dU1SEUk=;
 b=dhaEckshBrT8RQm4Ez3mLpmPk9xLWA9NR/oWLnMLn44plKRs/G54jSCyk77ynFq6PPwGKMJu6RK/L+JHyNNvhDbihYIXz+dAf0gaVbd+G3fbU7H1Uo/U7AATG04Vcfutw28h5IgR6WF408yTQtBzdxkgjRdHYeAivXil9QzPHiHB3RP0uObzYuVxKc9r6V9i3hZx/BleAyeLBUFkgMA2gBr15aJcS7pQ+Ru/Npw7IbuZbbYhU4yjzM0ZDXZRbE/+i24Ohn3ykZBhhwJSyH/4TB6gUNYvMvsXW/fGoUKqK/Ie51w9oho7pFYc0jrB7q7QZMtR0P+Hyk+t6P+Inlks1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAxXa3XbI3kMvkyIuMan4kaJrAgUQ5kUqyJ5dU1SEUk=;
 b=2FxEWp1TzBZJr/yDAoBRTYk7tokOQJGbe7aQeYWG3BJJSZ7eoFk4yCVt5607KdexpI13Pva07rLvMWoshSZ15bnmrxS4rPzUcNB1f8Dp9/k56TRk1+GhyljevWkKiLyXShum4HqIifyPX0MP20eDmk8DoiKcEJjMmMOj9P1pWJ4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:04:56 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:56 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Wed,  2 Jun 2021 09:04:05 -0500
Message-Id: <20210602140416.23573-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b83349-d104-4a69-7f3c-08d925cf6683
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766F78B133CCA380240EB0EE53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iyiAwmwxSkly9Lrgpl5y0E3HTFjinuqHOIf1H9uGvCKS7kCPP8Wahx/kcRLepBRvIj6YyiQLI1PJUgNTPDt8ptcb1WvxYwczm9kJIQo1lV1R9isgPuGdnHbecdJH7DFwpbcZpj5Gw+pePiVeorUqTwcL3OF8w7KsOWsDKAj4jOndBA6VGWQKRi45vQLHQJfytg5s3jmd7MQqL5n6OjiRstJqPdlRFQPxrnG+qQ4EWq9jc/9Vija+2ks/AKRu1cHyyndnmpygcFcgfqLcmzzfLtnB0BfGW7/wmX3ForIhbV256BefEAUyUfBdlx2/oIBOlZZvHDzlWths8e11zqXqom66QUVqkPYP6jHyXtZ6XoN5zHs4WZL2CjgYno0Vs5pLjvVlJKe6xPtkFWSzmNMpWxyDgzHSdEc1/DB+2VIASvcg6NWX8EuEE5E+6e48uMXqhjCA96FAzhHMxK9j7MTXd/po1k+l34hMK9MLBa0UeK+GzoH37nhOS4YS2Oqw7xE+gOINxpwaJAyGp1qyzd1gQOcc3f84fIgk+AMUhq/Rz8zCFGRYCuZ6qf4UfuP0k46EWPS7rfxkRBgi0dHIOlEhTb3pVHFQME96FSCzZ/Ua0AMFoOSQ/MGoljVpQjLdktolAAhWBhvqcHJP7n3JJ/W5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(6666004)(66476007)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S7zCA1tRwRB2DcTNn1YxxUpawyOT7yqPF7sDqOnU3777a4oUjaS03bowx1Kl?=
 =?us-ascii?Q?y8jNiO7hZdjg220dtmznVPOTG1P++IQtNXpK5RQFrIK2DHfWVvUcgOWrvXay?=
 =?us-ascii?Q?X0h+MUbFr6iDk9+FboE69q5VWHgBwrfrBHgqyHkmX5OhirX2AHlQtepJU5Of?=
 =?us-ascii?Q?/a82jsXoK9gitAYNKb5BPMB4TeMKt0srje/9TxSP5/H/aw76bvmMjb1LuXL+?=
 =?us-ascii?Q?vSmJnkuB85Sl2sxA37dsbNHOSO0rCqGP4QoL+QzeQhO7IkmFceYCnK1wqqfy?=
 =?us-ascii?Q?VPM/VuQW7YqRhYQhavaC+CVFySOKu2BVPWXN6Gs1661LpP6wsDzHp9kklJOW?=
 =?us-ascii?Q?h1P4lD4hOZK0qJ+5puKzpXZPGd/Kb6yzc9ZqR7ZIznemJaK83AeE3C7SI9Cu?=
 =?us-ascii?Q?w7hXLKV9RHgrq2u9AhZXZWOSkDl1H9YWy24WDiJbmr/vwMJ+HtFRIqOQdgpy?=
 =?us-ascii?Q?eHo3590dHTSNd8FrYf5J7YRxSVamKGFuZa5gYF6fJnEIs3NKlFao1xEgWes4?=
 =?us-ascii?Q?0IsUgtTzmHDCkB8o7Ky9mx9cMH8iaeJ59+xsGMDA64xDgvbFkdSf3eDHQT6H?=
 =?us-ascii?Q?h5bOpMJry87YwEFtesntlrT1R63rpfu+f+/qbJOisCsLiZa/1GkOAdyTrvsf?=
 =?us-ascii?Q?nw8qUFZtLNQoJNXkf5BqZDiRlQ2xWuy19m/wWZfxKaQGeABT5VJ03QLYu+ma?=
 =?us-ascii?Q?F4v0mCdy7CRsUdY8N8mRuW1ZcNfaSf9MiNpDi59n56msywIY+NYQWKnia3Ug?=
 =?us-ascii?Q?s5Oo72ziH9/epccMMwoSAz0h5LBRP0KXmPqn91YAFOlZQ18c+40icDM65GFl?=
 =?us-ascii?Q?1bDQ8F2oxD9JDalGqMGe7iykU/9OaBED+0wMJwIDaqBt3gkg7ESOaXCe3bOY?=
 =?us-ascii?Q?vSszCNblOO4GwKLVgtE5CSO2b8zbyx/U70FikueXqJpR2Ys+5+ik02gmb1gN?=
 =?us-ascii?Q?McAFcOZBNwcNrSty7hpE+zcpfJVE66j3vX32heTB9x4gOX1q/DfglWNikF8N?=
 =?us-ascii?Q?0C3HKAOpaVeg7AKAOWVr/OK21qZ7M4p8caueszY4TZLjjabmBSUB20fgU9j7?=
 =?us-ascii?Q?crBWIe1UbdcQbH8PuBKRpExx3Vk3FUf6zRwGU0o1m5G7gMgsB765Lc0kKTrh?=
 =?us-ascii?Q?8Q3kvTkq/km3W8BRMwuEwX+PkbK54LkKjZM7WcRiOP43c3fRPfQa/hJhZh9X?=
 =?us-ascii?Q?YCLZwUqkRhJTQk5iPHoOwCx8op/ov85LxjlGlOYpQ4o7WMhW5oUxf/mJmCE6?=
 =?us-ascii?Q?3CNxLDwfefgUGZNXCVBkkEa0kGd4IV7uh4K+AD5Wg15yPBskj0WHtXC3GAAV?=
 =?us-ascii?Q?dZx4tsobQIsV6vENFP+qEBjI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b83349-d104-4a69-7f3c-08d925cf6683
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:56.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwdg7H0mJTVwN854ZJ3gYMcrVVgrhwKbJTMLsVLqdi5TjRcsDxFiDhfLR5sTzO9Rofe/e/SvUd1FZtlqonVgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
 arch/x86/include/asm/sev.h |  20 +++++++
 arch/x86/kernel/sev.c      | 105 +++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c  |  47 ++++++++++++++++-
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c41c786d69fe..7c2cb5300e43 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -65,6 +65,12 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
+/* Memory opertion for snp_prep_memory() */
+enum snp_mem_op {
+	MEMORY_PRIVATE,
+	MEMORY_SHARED
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -103,6 +109,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+		unsigned int npages);
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+		unsigned int npages);
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -110,6 +121,15 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
+static inline void __init
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages)
+{
+}
+static inline void __init
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages)
+{
+}
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 455c09a9b2c2..6e9b45bb38ab 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -532,6 +532,111 @@ static u64 get_jump_table_addr(void)
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
+			sev_es_terminate(1, GHCB_TERM_PVALIDATE);
+
+		vaddr = vaddr + PAGE_SIZE;
+	}
+}
+
+static void __init early_set_page_state(unsigned long paddr, unsigned int npages, int op)
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
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
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
+	sev_es_terminate(1, GHCB_TERM_PSC);
+}
+
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	 /* Ask hypervisor to add the memory pages in RMP table as a 'private'. */
+	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	/* Validate the memory pages after they've been added in the RMP table. */
+	pvalidate_pages(vaddr, npages, 1);
+}
+
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	/*
+	 * Invalidate the memory pages before they are marked shared in the
+	 * RMP table.
+	 */
+	pvalidate_pages(vaddr, npages, 0);
+
+	 /* Ask hypervisor to make the memory pages shared in the RMP table. */
+	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
+{
+	unsigned long vaddr, npages;
+
+	vaddr = (unsigned long)__va(paddr);
+	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	switch (op) {
+	case MEMORY_PRIVATE: {
+		early_snp_set_memory_private(vaddr, paddr, npages);
+		return;
+	}
+	case MEMORY_SHARED: {
+		early_snp_set_memory_shared(vaddr, paddr, npages);
+		return;
+	}
+	default:
+		break;
+	}
+
+	WARN(1, "invalid memory op %d\n", op);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 63e7799a9a86..45d9feb0151a 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -30,6 +30,7 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -48,6 +49,34 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
+/*
+ * When SNP is active, changes the page state from private to shared before
+ * copying the data from the source to destination and restore after the copy.
+ * This is required because the source address is mapped as decrypted by the
+ * caller of the routine.
+ */
+static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
+				     unsigned long paddr, bool decrypt)
+{
+	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (!sev_feature_enabled(SEV_SNP) || !decrypt) {
+		memcpy(dst, src, sz);
+		return;
+	}
+
+	/*
+	 * If the paddr needs to be accessed decrypted, mark the page
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
@@ -96,8 +125,8 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
+		snp_memcpy(sme_early_buffer, src, len, paddr, enc);
+		snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
 
 		early_memunmap(dst, len);
 		early_memunmap(src, len);
@@ -277,9 +306,23 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 	else
 		sme_early_decrypt(pa, size);
 
+	/*
+	 * If page is getting mapped decrypted in the page table, then the page state
+	 * change in the RMP table must happen before the page table updates.
+	 */
+	if (!enc)
+		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
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
2.17.1

