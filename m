Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90543BEDF8
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhGGSSw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:52 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231500AbhGGSSg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMjbwlr82qJePoaQz0PJIlB3mUgNhDqcZf+AHGzOT2PU+13RQ3AFdIij4yCZvAESXEAQ9zdZfVpYj/uk3Ual3K+6ygSESekj0TwWudIp07lU3t6l7y3t4V8n3OWovD1IlVfmsM+1UeYPOTLt8J5Kalkg7+sOTc4xHJHEFLWEl/slV1mK/Lj289o8gXy+W7QXu9XjroFolwCPwi3YPPLLVTSSZ1aGaic5WI8jCRlKVGEL7IzedIAjl3cWrWLxDSgl4KCARInH0lJzNS/Fl6p39ycRZhaCc505eH8sa8ZmjloAZ9QmHmhuEalLMEbv2Ak/XIj5cHqKX5IacfNLToIj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pjBkcL7QnB0SswiCg0GAFBxc5e0iY64A++7veHCNrA=;
 b=YAeMtvGKl6rgjeJ7zEfGsztQ8aJZcgwuavOoCKnNFGrLXJDRelMQUV4jS/1J/txDEWr2NxH1vATe1vE/FECuGjNTU9E7h+CBiiF7HytPO4OpCaFci4mYfwigD5H2JQAiZvz8d3DN6pjo33hwXQuTp5tZRmEwXLIWa0vHVUDNgwL6qaLVCdapuZ7aEyc5wQtrBV5dUz4OgrJGhRM1DpNY0Zrl1G+ucqoL1ESUjCxDF1EigqqSzHSwzt4AV9F/U/DNWUvsbbxXfJsNYcGuaeaFTb7jwBmXkNoZqckyPheWVN1jhoBqFPisIyaaIHfD0380V13yzzOa4PoI1l/23LlhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pjBkcL7QnB0SswiCg0GAFBxc5e0iY64A++7veHCNrA=;
 b=ZuDm7afMGzBpBJV+Hb1JmYNXgLr5xefXZe+7IHQXxakSmuu7vvObVX8VJ2Ny5yX+ySlUHvUHNMXD4mrvAiy3Ap8YWTqijvqJG10YZnI97mnXS8ayRFPiklxgql21tcdwEG6EC49y0/7pOTAiIIuMe+RuP1IknVB7W6E+Rr62ObQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:50 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:50 +0000
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 09/36] x86/compressed: Add helper for validating pages in the decompression stage
Date:   Wed,  7 Jul 2021 13:14:39 -0500
Message-Id: <20210707181506.30489-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10179a3-6a95-426d-d60b-08d941733feb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644012965F2AC4185338B30E51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQcHnR6EBIPDcOFtCYbFZ8BwnWDiSpwRXSU46DTjCOYjrcqTCpFU9cCte8VWkEH+Mv9LO4/2EOMaRJjlrNRniW1ab3qvwKBzDx1qZmtqrAGWp60T9ie/jB7yL8IoIwpqzGegXTrQ8rx/gfd0HPKqKZbk/xrVHAWPsjfn0LTEUCMYO2phq4XwOjA5Hi1V/onuvxYc/4PR5ZDuIgVEQLE8xmx98YAaAt8QdifzKNDaWENRBcpgKvswFcgzK/am/VCjSk4V+DInBpE01l3kECRDm0KzIwypvvjCj3oku+pATG/W1mo6EA89JTy3meQMfhKZiAjXItBVUxANp+ZuOS2CnGl8y+AW6a4IWZ0avCRkqzYyNPubQZ42vc4OAU0WVx/VXVgjeZ3/OrsGsqxbSgZxdRPfbWo4/cZEVMg5lrEUKr7coGy/efJ0u/MqBu8T381iPTKyhVqHB5fjOG9Ji1/lNt10SVTnc/3GpDB+tGSWZQoI/G4fRX23nnRmdRgV8rFIf9oDxcXvQzIBD8givaVWy6t0Vk6luDk1wUkMntWmrNmt/ADSYOFcPzF7cPhYZ88GW1CVr3wsWKvFf9wrzTf/ITGYufXH9OWA79v59or+mBEWwSCHBeCgXAUPG1QZ/pAwXbGvesBSt5r5H2GBG1xBVC3WQMFKDXBn8vRDNYXe1LpSFgfeKmhl4d3KKmODmdXruRqC6ASjwVY2E7heBJgTUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?paPwh1kb7CD/65wPIUzFAIBBHM2KT+dzCYq/Z0SMe4kd/VyGkNCdItRJa0y8?=
 =?us-ascii?Q?4Ep4GwbgUj9pPGURdq7wBDAr0IHp9OJyXzkB9PYo7HkEBLB/6aRXc4+C0pAN?=
 =?us-ascii?Q?1GMmhYLeI7qd/leHCJmSm6X/FAf6cGkPT8aPysrdfWW+82+313swuFMCK4+n?=
 =?us-ascii?Q?+IU/lWBJA9CEik4oeLgc5ZBdr3jMR/ZBnJPkYJH2tYdh6Oh+TodWq/dGATSX?=
 =?us-ascii?Q?qT+PNpUrth3GkUCGn6LTLbcXZAeEGkiyBiABXJIFK6e0sTHY7SkbiOM71Zix?=
 =?us-ascii?Q?jTLzVIpCU4x3wD850ObZUpB8jhrBdso6aFpa+BlPY3C2QftrSUHzEpbx7IIB?=
 =?us-ascii?Q?9KUIVKPjQBBErnZWySEIWDhR+G+M6HrsB9oeQklSj7js+KQernvIE9HN7c/a?=
 =?us-ascii?Q?ef8+oS5TUZnUQ9ZOt5x0wFjlYYlJEIt5jxsH2fwBSgWMamSm7/s51R8BbZzy?=
 =?us-ascii?Q?ekH5qvH5tJ3nXzq2hoHiVDI4tL+o3JQ3+HjgEAsYI3moeqlxYPHZBZVK3rjk?=
 =?us-ascii?Q?md/z+z6MRfGsDi4DF0tEPz2I2Rym/Ev12bJLgm3wiiDhK5xWCBP1MJG1iQ2p?=
 =?us-ascii?Q?Y6F3qZDnKy0RaLCP3Ex19+5CQW/L3LpkxTBZu+iGFSc6GI7DQjXGhRj0E8gO?=
 =?us-ascii?Q?hdW+lgz6ihZRL8Mhis0/Bj2qX2+Q3/dfz5XlVaETJrzIuKH+HWREGo5WlJWN?=
 =?us-ascii?Q?jOca6IVgbOYvDyO+4Qj7/a2hLuO7nS7U7XaN6+IPEf8Fr2ZNqb+SMfDtDyd+?=
 =?us-ascii?Q?J2ykStYSa5AClGObNWafFI+RvPoYWinvWC1S/iZ0rbS0CZaPeNkHzE0fOAi6?=
 =?us-ascii?Q?tZCLC1fYiyNxylAGBfcYRfWeOMorm38qexAtQGnx/tJ6ZWVUyOhDdg040byi?=
 =?us-ascii?Q?aClDoG3Fptp6yXiqmlUg9ZLHeX18oDAF8o34wjIMY4zU3LITvwXbnn94x+qA?=
 =?us-ascii?Q?FDK6BYFCUySUjzPFJB5HgebwpliT4KG6TeKvqHWgL1UKmN4eQpLl8DZDmVb+?=
 =?us-ascii?Q?W4qISj1spwtMSLqQVoh/2Fyva4CmvUAxmAdavQGXLkC33sxohcfk48GCZeQI?=
 =?us-ascii?Q?6gtn1nAjOYhsdKqec2p0wcVgRDPQNnayJRIEb6xA4lBjsOHLbHqodbBLW6II?=
 =?us-ascii?Q?tFEQrLG80zQFtD3LRUlNP8dXKZAWMG1L5IHYOcK35x2Zt0KmJJFhY1h/jVTL?=
 =?us-ascii?Q?mpoU2ORh1P69uCxoyBwzXSgNs3m6QxT2Rqi5vtcd7DrZJxWW50LL/r/ethEe?=
 =?us-ascii?Q?U+0rw57/ii6P+GX+sx/L7CnXGrN7xJgw8DqGkr/Np313P2NSicBN8qSmpqHY?=
 =?us-ascii?Q?A7q4f7N+LH+wEohFcHLTTS9E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10179a3-6a95-426d-d60b-08d941733feb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:50.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZigCn9XvFWKpneyR24v8S10TekK9Dt/ztlhtivwLpVL38QF2cZDh7NPlLKjr5SvijBLRh0hcf3xKErhQMhXeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many of the integrity guarantees of SEV-SNP are enforced through the
Reverse Map Table (RMP). Each RMP entry contains the GPA at which a
particular page of DRAM should be mapped. The VMs can request the
hypervisor to add pages in the RMP table via the Page State Change VMGEXIT
defined in the GHCB specification. Inside each RMP entry is a Validated
flag; this flag is automatically cleared to 0 by the CPU hardware when a
new RMP entry is created for a guest. Each VM page can be either
validated or invalidated, as indicated by the Validated flag in the RMP
entry. Memory access to a private page that is not validated generates
a #VC. A VM must use PVALIDATE instruction to validate the private page
before using it.

To maintain the security guarantee of SEV-SNP guests, when transitioning
pages from private to shared, the guest must invalidate the pages before
asking the hypervisor to change the page state to shared in the RMP table.

After the pages are mapped private in the page table, the guest must issue
a page state change VMGEXIT to make the pages private in the RMP table and
validate it.

On boot, BIOS should have validated the entire system memory. During
the kernel decompression stage, the VC handler uses the
set_memory_decrypted() to make the GHCB page shared (i.e clear encryption
attribute). And while exiting from the decompression, it calls the
set_page_encrypted() to make the page private.

Add sev_snp_set_page_{private,shared}() helper that is used by the
set_memory_{decrypt,encrypt}() to change the page state in the RMP table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 17 +++++++++-
 arch/x86/boot/compressed/misc.h         |  6 ++++
 arch/x86/boot/compressed/sev.c          | 41 +++++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h       | 17 ++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..59befc610993 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -274,16 +274,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	/*
 	 * Changing encryption attributes of a page requires to flush it from
 	 * the caches.
+	 *
+	 * If the encryption attribute is being cleared, then change the page
+	 * state to shared in the RMP table.
 	 */
-	if ((set | clr) & _PAGE_ENC)
+	if ((set | clr) & _PAGE_ENC) {
 		clflush_page(address);
 
+		if (clr)
+			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
+	}
+
 	/* Update PTE */
 	pte = *ptep;
 	pte = pte_set_flags(pte, set);
 	pte = pte_clear_flags(pte, clr);
 	set_pte(ptep, pte);
 
+	/*
+	 * If the encryption attribute is being set, then change the page state to
+	 * private in the RMP entry. The page state must be done after the PTE
+	 * is updated.
+	 */
+	if (set & _PAGE_ENC)
+		snp_set_page_private(pte_pfn(*ptep) << PAGE_SHIFT);
+
 	/* Flush TLB after changing encryption attribute */
 	write_cr3(top_level_pgt);
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 31139256859f..822e0c254b9a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -121,12 +121,18 @@ void set_sev_encryption_mask(void);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
+void snp_set_page_private(unsigned long paddr);
+void snp_set_page_shared(unsigned long paddr);
+
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
 	return false;
 }
+static inline void snp_set_page_private(unsigned long paddr) { }
+static inline void snp_set_page_shared(unsigned long paddr) { }
+
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 2f3081e9c78c..f386d45a57b6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,6 +164,47 @@ static bool is_vmpl0(void)
 	return true;
 }
 
+static void __page_state_change(unsigned long paddr, int op)
+{
+	u64 val;
+
+	if (!sev_snp_enabled())
+		return;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if ((op == SNP_PAGE_STATE_SHARED) && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page is added in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if ((op == SNP_PAGE_STATE_PRIVATE) && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+void snp_set_page_private(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+}
+
+void snp_set_page_shared(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+}
+
 static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index ea508835ab33..aee07d1bb138 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -45,6 +45,23 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* SNP Page State Change */
+#define GHCB_MSR_PSC_REQ		0x014
+#define SNP_PAGE_STATE_PRIVATE		1
+#define SNP_PAGE_STATE_SHARED		2
+#define GHCB_MSR_PSC_GFN_POS		12
+#define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
+#define GHCB_MSR_PSC_OP_POS		52
+#define GHCB_MSR_PSC_OP_MASK		0xf
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)	\
+	(((unsigned long)((op) & GHCB_MSR_PSC_OP_MASK) << GHCB_MSR_PSC_OP_POS) | \
+	((unsigned long)((gfn) & GHCB_MSR_PSC_GFN_MASK) << GHCB_MSR_PSC_GFN_POS) | \
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_ERROR_POS		32
+#define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
+
 /* GHCB Hypervisor Feature Request */
 #define GHCB_MSR_HV_FT_REQ	0x080
 #define GHCB_MSR_HV_FT_RESP	0x081
-- 
2.17.1

