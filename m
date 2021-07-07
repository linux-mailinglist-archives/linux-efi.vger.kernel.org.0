Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528843BEE0C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGGSTT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:19 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231458AbhGGSTI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOf3LhlV7NfmTWwUTqoAhmXN2p0xS4XGq5u2y/qs5uqa5PTiYn4HurKjXr678OVNr+2Kg3l1/izQ+wmZxG+mRZWMs83EpTti7vsnrtpZgbf+1p/ShCD14z14zw3jMEa5SD0m3IJdJqOEupgsiDORmjPxy2EHs6fyUx0yL/2+ca8QduFbELv6anFNvdXIgA6RxCoL1QLOzSVckYxICmoO9m9jPCim0YK86ToOpYXu39HH+1z7dDuuUSNiR5F9ePfM4hSJ3bqd9LMgrwxtrsHz1vJB7itKJiaverqkECjuV1zuiIDWbyHClwekD6zVNPWMUb0GwC1eEAOEnpoxOvBgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwkUdAZK2Sn+ef6/Ck2d2e4mu8wVrnC14FlkE2s0GU0=;
 b=fXnnFjcjhnZse6WDMlbD563xgh+Dv8XCKLDYtNK95eaJZ219SLmreADM7DmXvXO5/zT1YYYQ71clDFm7I5rUN37eoklYuNz+LG2vGMy53IPvn9tlx3ATi6bj+GjiFnhz4zZLwsv1Rac+DePN8BChlHMIGDJOVA44RhteTG8e/uypHZ+uOfOEOG3QEfu5vvqTlwpPjN85T0rXhIJllTVz88Omb7DQsxXDWNvIIYi9V+Glt15SvNwxnPyJeB169ptlAbtyakNj046wP6JXkkTr/fMnHFc4LWhhxkcJtFzMMZyrUXwaXEWw/4pCHiubLHs2YxWA17WAtR6NZK47H0sCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwkUdAZK2Sn+ef6/Ck2d2e4mu8wVrnC14FlkE2s0GU0=;
 b=Wup8KZRaCoTwu+TPixyW1KVp29zWqtVdc+rxzU2oon/ptI2WaAsSw8Smw7nFD600z10lN/cCuKC1q/v18UBI4ChQPznAWo5pEQucZIHOndQpHcn5vXK8f29FVjrrEaHo9PtimpNNPPQV91GSoouFq5EafNjgcVwqG2lOwzfRYDY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:57 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:57 +0000
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
Subject: [PATCH Part1 RFC v4 12/36] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Wed,  7 Jul 2021 13:14:42 -0500
Message-Id: <20210707181506.30489-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80df8925-5c16-45ed-a0dc-08d94173445f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644998D927504BDE06EDABAE51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mcoc0iEAuz/24BH1W0hy8MbBaHhREAK5mDy04yvnUdipLJqQG8rf0SJ5eCuDrp8jSQlPcdlfVuuIIPFzrhTb1x23yIZFpqnh6EYsEZoKZg17BU/P0yYKhbJe2KpJbMYvIyUiH+Bj4ZSPUbSs3kgKPMh7ooPiYumXJB6QS/yCNPneBDfqaTJZZnmulHqGTytIGQiu7cRiG4yZ5nwkbj0hzrW0xRsD7CFUGWsgK3xx+HoTm6+ZWzDHDZ9NRdQZec2Wo0hzdP0do/zftW/eBtmSDMr6aw0epiyN8/q/hxHBdvDEOIu8VgiTYLjUGlDGFm9APz+/lmQUAkn5HiJ08N2o4Wid//xkPmrkE+1YaImogcA8qkGIrT7dme6QQ3VFc8faUhNi5t/ghD2t9hWOjm56f4XwJz96nGRgGo955sg3hWmJOFsjT3JVcTsfzHJ+3iJTcHHcSrUWtKuBGL94Rl5fuwe4zezvkraNgck5nzOyAjI1Ki+LZs5zOTeDtt50bgq9LOevsy4gtJnhWv4tabfvMmjUWXMeYxD47rCsJINhce+mPXPlQQ2RguN5wy1kTbFptAQDtjmsq+/ZtRW2vGHQrgoMRVdkFvBWJpzMv0c/QOmJICYrma5Cbqp1ta67qNZMoAe6c723hunssdLNU+yX+RI+jGCqOIbbuvi5+dJf0H9wJ66a2ml8FksvkihlZnv5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vF7zTzdt8JW+teLdsxI6MQs26lDRb39V5S+Z1+r8p+O5VBYIWhSLyCaMBkv5?=
 =?us-ascii?Q?EUHmdr5ztWEPhZDA+Wqpo5nf44WTP4E3Do0riZFBFEkVzYYaBJzp9sO1oD8v?=
 =?us-ascii?Q?fagoqkYDbdABQHpa+kSNuBM5yCUmbkoM2fBBEHlv3rNJ+q3p+j5Jh1hSbUAP?=
 =?us-ascii?Q?z4lLHxqV9xd7/nRWa+8F5S9L5QNhJ+XrkMcKmnyF2mT4O2+mv1p29HVuJ67X?=
 =?us-ascii?Q?SJDbUPsB36rVL21+xRRF2QUGM9D58ao6Ydn9/iI3DiCJyH+L46DjW21bKbcZ?=
 =?us-ascii?Q?mD8t3yLoRJ7Wmog2V4sJQpNlve8yc98uS9lpUGeDuZU3jvVQOgUBbKFTmQoR?=
 =?us-ascii?Q?jzmHDdAYWeQg1E1SVF21VFcFQf1LMNhOakNd8cndsSv73UCrz4CMO88qRLkx?=
 =?us-ascii?Q?8xSxo6mayUDQfyovr3HzbOMSixDa9Xa4rDOWG6gyaCo/7WPGhcBN5m5XaYFb?=
 =?us-ascii?Q?uIq5ZJV+WB6Mcs3nfpB6ZWd8DMTWrTdyTkfBp85lCrIK5BF10PR/GONT0znC?=
 =?us-ascii?Q?3Ynuy5Fruf/GqqGCgC2JUxWG3cckyknH7WhllBXpO8NtIrZsfGRW3xmcUPZk?=
 =?us-ascii?Q?mvAmB4wtizNpkOG3OLPWssKuCcW1i5ZtS2Lqbz6Ep25dmv96artPIH+tKFW9?=
 =?us-ascii?Q?605S0WIyMyFki+/zJWlXwrzRc739TwWhCgYbTwusZYTGz2jJjmpgPpJQgmWW?=
 =?us-ascii?Q?bGPyvwNy9xfDCON1m5HXPsxkRCcNOM2M0U0aukwY/Lci5tHhtNyjCiaw2paD?=
 =?us-ascii?Q?x0rtl18Nk/BOeVvkBTl/TAavJ9Umpd1nT6wyBYk+zH6aHoOiFD1obr5MJ/OQ?=
 =?us-ascii?Q?X1E+bvGVMUUtmtg0ZqxO3BtqRERZkmGG9tMRX5re9+ZnqXKG/JO0ob/yntgw?=
 =?us-ascii?Q?k2S3/DEpOtIWHd/F3QvjqnpjMMFvw/CXFqr9BOqfqtqyLrUPmhSvGPRyLqcz?=
 =?us-ascii?Q?XuuUIp/l81lTfTWYa5qGXxQ1Apu46crT5XLuquSqBwJl7zBVE8FjaJx1extA?=
 =?us-ascii?Q?QHyMMxqTjBWCpiqGykXpD4mSWtH3FOBdNMXeVKfofWRamACCYOsOT2wdW9sk?=
 =?us-ascii?Q?vq1Pd2pBNs51oC6DhaksGNMxbPMPTL7i1au3Bh8KtSXUFHNg8e1+w1D57oA8?=
 =?us-ascii?Q?HyKSr098PPcVwTOB5ltMBJyB1MMOfI4j7DHdoDBlHOgXiOc/Tg6wjAsfHOLT?=
 =?us-ascii?Q?NT2Ua1NSnw0eqy68zLG4BPEHKSig3GBxqkeBJdnNO9a+DYznAq4XizkLQZzr?=
 =?us-ascii?Q?Hebk5aMDC9rIMdrTJ/N3y7O+x1VLTchpO37TT7J2XX6CyogRwoI8P8GFJoKR?=
 =?us-ascii?Q?g0icnm35kJLB6PwHmqiYFAS+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80df8925-5c16-45ed-a0dc-08d94173445f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:57.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxtPasek7KL6+YWEFuS6z5pOprWOIRgRPdBk3ytTfcdPZxZRZXq6gduXyEQjNwcdYMiVbM3d7oImj5YY0AXWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
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
 arch/x86/include/asm/sev.h | 10 ++++
 arch/x86/kernel/sev.c      | 99 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c  | 51 ++++++++++++++++++--
 3 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 242af1154e49..9a676fb0929d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -104,6 +104,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages);
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages);
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
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
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c7ff60b55bde..62034879fb3f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -595,6 +595,105 @@ static u64 get_jump_table_addr(void)
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
index 63e7799a9a86..d434376568de 100644
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
+	if (!sev_feature_enabled(SEV_SNP) || !decrypt) {
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
@@ -272,14 +301,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
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
2.17.1

