Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485D93F2EF2
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhHTPWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:21 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:58049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241250AbhHTPWF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRMkTt/BP9jMDD443cWE1QwF+xjXJdhZjMrkK1fZ8ZsjqTHyEM2Ra7gmgmJPOmdE3/P8778OcNtrY/erccwuhjKuiox7mzueww1048DJPOTMAWU40+weTnRQ25llstmZk/VhUTJmI51J1P0UePLs+OvDQDob1caS/9S7UnPEE17fhTzvCwBmzdHWyhi4JFDxkdCOpDT1goT5C7uvjj7YqFw5tZyIi3GCWvn4ro9EhScbfWw/BqeqCM7xhMUoXHYw1hfjsbvKkPBtTryCtJap8GiZyZBhMfOwXHRc+v8bxUPueNQ0+0oaWzEBVjQhBjtFOD9uCdIrjVfyIcYzpVbWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XJaf9Sd3uCj6h+YVUCGKJMr+GJXoBbOu1AbKab/s0Q=;
 b=OQcvzJGS9/Plga5nR1y+f27GYpmxQ2DvfoaYnUPSUk0gkdJULrcL83CBobXPYPnjABeHQRPdVzFx+gt4Cb5RJkt1Gy1IWcbukQ3aw34b9DZXqDCDJbqxqHNRqeuTzdp3nalJcdeWK1qtuxUZ+Qy9GSVrWIo0gdH2SasQkDzUZluu1wTsOd1AIf5uzNQF9BePeI2Ve+ywMruIuQU3dNhC68DODJuB/W8oBy6Fd3DxYsTYXVwuHraFXo95geR49sIaDrdf92SbuIDThdTap0qjpvsNfGpxux5VPPm21/8CyIvl0cTSag7zkM4J4pGMCEbQEb9o8cwVz1mKX9kIibA4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XJaf9Sd3uCj6h+YVUCGKJMr+GJXoBbOu1AbKab/s0Q=;
 b=h1JyM6fOvL+p8KwW8TO/NZR5bSBpp9wdDz4p8GXlTAwMiQXGpdrq+MbT9s8MQ2wAfj6Uf8rC9N8gvOPOyK5NJ/IAapeR+GstQXcmEW0DEiu1YAbIeoTfbA+Fy2N/Yk+JcbDFwuX7KscLgTy6afVIoEJNvY0fCs2ezRkQ2GPb1DM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:05 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 14/38] x86/sev: Add helper for validating pages in early enc attribute changes
Date:   Fri, 20 Aug 2021 10:19:09 -0500
Message-Id: <20210820151933.22401-15-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f3d9b8-f5aa-47c0-7a49-08d963ee20bb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446809F2FAD1EB9428D429AE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFENNIsueq34vCUEBQpUIHx7Slcp1jua5or0EwBFdCZAHT38OzZEFzs0HiX9zUEzN5L57b8NEJfwq8C68pf5VDlmJ3n3KEIEzMViZ081J5nVBCCzYRtLk15/ZTI8cdeSLa0oRffdlAuAvwiWcLacKb6bSZmkrLtJmoEaVTIgZKetwDAWTJdKWQfj5VJwRrd+sWdhtdUMoFpVV28bC91dej2Hg4oy/qiO4lIFrK1idK0pS9cgnH0Ob+8x6ats7fU512YqrLmP7c9XPEc0pwH1rt6efkS/SkteBRsZ8aO77KliELE3DJB3tFnsUsiNq8pIg9KRGcLR57FwFsMBhbqAjgftU7NzLemKU7sBrX4ixqOftWExFyzY5W/SowHHpk459K7PL0D0vqgQfSy4609xBIsftJYyKOHOKwSBldFo+4Zx9BtzH47+0zlcWv2eIQqcdu6NpmVKMKam+rUGUwEbnmZNNQav6LuDY2KvF0M4BYfGnAFnSQ+7YepFpOpsIjsTdKNoOpYa9wAAiUKVirIwUQBXwT3l+80JpAzwdp5OWLXktjYrsdC1JLbF5G2ZtQ7j3D5IuOGTwCksF1QClqtoCwDXwCM6dezPMD0SYTWNHetz4arOaX3jkUcrV8ifjNbW2THHB9h1dl3wkUPDLNDQjHM8ptqdM73PONufq4BP8Ge5HE82FqX1UfmO36hzMfz6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wq0uBUKXpyoVyTsWw4V6HqW0jSuzQys6SybFRL8OCgvOYrFAbhI/7/I5AKck?=
 =?us-ascii?Q?NW6H5V6s1YlEuNWkxHUHJVwQdoH5b2MWjKQ00vPoA46TPLdU5o2QqvBRvBBr?=
 =?us-ascii?Q?mc6VvFRZhnHHETpVL6WMSidKQqkT/BT8JVVBjZo9vHD8INyLcvHTJhlOeV/8?=
 =?us-ascii?Q?wqY1r4pVkaSoyTe3SHdHidDUGMURpnIJPj1vsNPDYNhWuDCVefARZRoyG0am?=
 =?us-ascii?Q?QEBLqx+0bGsFpoTbg1dwCf6IjRni4OHkX6Lruir7ktEIsPwhvxxkjO5YneMl?=
 =?us-ascii?Q?0XAK8lfwBuK1lWCe2ylox6svPQCmNYI6jUgCsbFgyMCeLQ/SrTTy7GosSqZp?=
 =?us-ascii?Q?bvQsLbC6pvP08w85QWdFhUx3XD/jH6CNUtURFLLs+u4xiyTiWqns9IT5mISP?=
 =?us-ascii?Q?y9ZduEtBzhhl5UXYa1ZZRXdu4I26pVdabcwBDiOyu6EwSXg9m6bsKEdCYt5H?=
 =?us-ascii?Q?UpJa0V2Y+Li3GHldxy46QakwpVlbeAhubFbPpFrhkphsSiF+5DioQ8KyoWNX?=
 =?us-ascii?Q?dULVQt7/5S209CaDNaBaq7wW2Zlxji5CVokVCNduvwt6/lwgU51GpvQloqHU?=
 =?us-ascii?Q?HaZsMJt7NYVAWuvUEcK7FgUrAYS3skBt7mRogxe61H2a6KOKJRGcxBKZuYu+?=
 =?us-ascii?Q?zTioSxsXnXbWUj4g7iht5s4LRWEJvW7wFsYblxCT/zkKI18vNtySbNBdbXO/?=
 =?us-ascii?Q?bBbI4l23Hz0x4mvtnj6oR7NGcdo4yjFqLW69ibzhg7HN6AM8Qp5HobU1RvWl?=
 =?us-ascii?Q?ch2tSJJ8QHUyYBt9yYyGhaxZlBXXzgBPuSse9VzqchZ+zX51FYGg0rhwVD4y?=
 =?us-ascii?Q?9KM5y4YK7dptFnuURfHeQ36yyNs01AQmBVokyPwEnEu00fXDWJPwuQ/gdGb5?=
 =?us-ascii?Q?te6DHsafHILXgssgT5xpkvh+79n09dvUQtYieQeTezXxZ51sAfWJlYOvBHEg?=
 =?us-ascii?Q?Tgtb4NGNvxZGjd/rj0+3wUUX8w55Zr6a8JsPHiXG7AU+vCRV66ZD6aWcpn5J?=
 =?us-ascii?Q?MSZ5JOXKw74E4HiWQkC+XVjjrBWaLDK4bUi3NZsdTejy7popwCG4LgXuUv9O?=
 =?us-ascii?Q?/PsUR5wL/6QuqP5Ubq1IEXPDMRXTs6wNgPTSiETEB8FxWuXFdOMoXlKFaLo4?=
 =?us-ascii?Q?p3Z+Ms/j/AewLvchydiiM3rdbwi6KZGyT01EhXdkQQrqs935DbMSd/uhky1L?=
 =?us-ascii?Q?L/6gdi/ASSm5rBMJOf8rbZm3V433fEQO++FfLXcJSfHEDbm+NCyWX9m+dajn?=
 =?us-ascii?Q?/6gAIqYiVpenm8eAiZ5MfxKvdnL8Fe6se8UrhGsAV1mdy6TuYmkljzlFCOQa?=
 =?us-ascii?Q?8nGlQwOCjPr0UbMCnv+MaYSA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f3d9b8-f5aa-47c0-7a49-08d963ee20bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:05.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1fJZxVsAuYRffV1ryGWiaVs3grPIeXyRocWSytrPvQmgTIF8n4QybIbyaRZQX4I1fHZqKdwkkELqx/RpOwg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
index 9ab541b893c2..0ddc032fd252 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -591,6 +591,108 @@ static u64 get_jump_table_addr(void)
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
+	if (!sev_feature_enabled(SEV_SNP))
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
+	if (!sev_feature_enabled(SEV_SNP))
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

