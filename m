Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8739FEA5
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhFHSId (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:08:33 -0400
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com ([40.107.102.84]:30853
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234176AbhFHSIc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVDri659r3ccsiWA/JI/JPHmpsIAMNVlgIc8B8R8gmEs61gW8DYxCqyrFHjFX1oSqPbaehmsKlwLybwzmdRXjt5NzoFkU0zCFZsrdFnAFaf5KPUFGIIxFVBYszHFh41+OQ/Ox0Gea6YCYwDZBp6Nh8sjnEUeJTDW4V+CwOEW4Ic2izDKdcVvuvZf96hClGC/sL9Rsxy0KQPkZ1i1ShMjRvqgZ/UyOm5uOXbfKRqc+fBTn4Tx1AC1EzAWiD14Gz0rWr7td98IlJyONRe7sV91/Ziy+XNGMk/m81wGMeACjLpZ39eCLNXCsOPT4vbPCZfcUksnMZnIbRQU4DVSjlYh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V/fgw8Zdb79Sp8j7durUwyS0eECfGQTGfDekcmCQyw=;
 b=HYGTWAXp1rlQlci6Y2C1VbbE5tZvG2b5R619iPYBgnlBI+HobStSPBqfqObAUf7aSQYc+DVvN0aprci27miHk9J2bEZmOB6hKbaguwScRkpVDHf4LRpKABTnBU4j20mkPsq+eEfU96UbD0vSie4u00NZY6BoM7gIwG/L7kE8iSA6eGleNt9Xuvecnz1EFTXWl5ZgLEZUZl2V3HAvNnTiVQN5ans6wG7QUm5QXLnOuIArjXCQlmJbziKJ7sZvaBPEE0gZg59ZQrAEIJ1vzI2cRuokU0cVAqOzeVTN6z8gxwWbD1J/mBcoBRrrjzpUzmK1JrZtXBwxqURlrBJOe72ADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V/fgw8Zdb79Sp8j7durUwyS0eECfGQTGfDekcmCQyw=;
 b=K8HoWKV9PXBthgfPguZF2NkxUO4d3a4AWY0SMoWfzlLIAx2NB8UsOA1M1cdEp+TF0M7PG85CyZcxkN7Ggo2esm2LSWQoVeNHCTy/jjTPOmRa0LPab4ONcbXNCDU53iZw9/Nuf6t5BioC7n4OtRT/CliYaWOeb+mbQJGG2sg30vk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BYAPR12MB2936.namprd12.prod.outlook.com (2603:10b6:a03:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 18:06:37 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:06:37 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 3/5] mm: x86: Invoke hypercall when page encryption status is changed
Date:   Tue,  8 Jun 2021 18:06:26 +0000
Message-Id: <41f3cc3be60571ebe4d5c6d51f1ed27f32afd58c.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623174621.git.ashish.kalra@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SN6PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.8 via Frontend Transport; Tue, 8 Jun 2021 18:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05601bbe-0240-4b38-1768-08d92aa82876
X-MS-TrafficTypeDiagnostic: BYAPR12MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2936571D191087B58A041C0A8E379@BYAPR12MB2936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BJYK15s5DDw0/lgCwomtBxqQB5EklytLCoogOIfpnAFmBuugqHf4ufbCu8fIFaMnQEqQqosrZVWyDMJQC5TOywmCODLUnGRSZuU1QRO8olXjwzlq0yhy9/+8XR4mSNJhIHPjRJsKyUo/dP47UPyBweD562Q/gBxU97HSdszi/Xa7D/fWIDpaX0d9XKdG6GsqfFP9iKj/ICQol8WFEETOAaNB/qyUqNgG1UZILctGIa5W0Vgf1ZAMBY6zXNfgNfEGvG3sh4/8Jilrvb95F6DF5v9oqCT4VEIhXJjdiAilwfbjDJHJxw00/0zQRW3jzS3hFgtQYo/hYjDJdS7t5ZG9yX3oJhXpnkjtI0TKCwAAa3YzJiGFJPZWEBi8mZ0KD0SMKmD4cP1wwZpc42bJSnqpvTG8HdxByFip0M73BFCXto4RWQNY5+rLr/E0g2wTts/bx+t2xbtUgefFJbBn4zsv3WL7suNpsNjTosjn+YoeAtDeqNJo614E0yO8JIgTXHSsTtZ2zQm6itsDudhpD8mw7TjyvbE3kWfwpr8ZIFzUIalrJZVST2+mKPLGkPTV4KbvaUyToCG5hZQaWkQAIU4lpYYAqkLIXpQ+U1ddUkH7a5bwywAHGHwjta9tMrAp12a4mJz39wHikkgMGIBY92MW/Frj70qEltKbFBAk3ToiYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(36756003)(38100700002)(38350700002)(16526019)(2616005)(316002)(186003)(956004)(7416002)(5660300002)(8676002)(6486002)(26005)(4326008)(83380400001)(52116002)(8936002)(7696005)(6916009)(66946007)(6666004)(66556008)(66476007)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lj8Vfv32CWlE6pyhAeoQKZ0+hdLvfd4wYWdcWOsrycO/V3o6enO9f5qYhDUL?=
 =?us-ascii?Q?neSAMIZ+IMi7jxv9ZJous2XxA3sxyzw3knJ1nC91TMnP4Oor/bT8RhW/VPWn?=
 =?us-ascii?Q?AnjfyX+ScqIkeHPbHrnacKSnXH33AUYLeOgtBwJauStvE5JJ+UktPMXGru2C?=
 =?us-ascii?Q?a+PmImGaMqya47S+/Ldmb5w73X+yZCdpDFJqyHooUCy7kGbnWqe+0baFABQE?=
 =?us-ascii?Q?oRAQLGu6CvCm8zd5Yx9lo3hAZyhnYQUNSXW83Vi9+iWqAmePga1chmlEi1xW?=
 =?us-ascii?Q?/M62Sd0cBXEfRgbPyjnmo1mTRhNIit+i+wehmD/zTetKFH1ZgMtCmLv24W5o?=
 =?us-ascii?Q?350EF5WXtE32hMzq2SXDJ4niHHG5F9a7jkCSN7O9MeP0hS0a23O1ILMP0srH?=
 =?us-ascii?Q?D3L2p1SyedxdyuVrNRpLafqTkiQ7zCjdMYwELfwZp4nie53uq38/wXsNx6yL?=
 =?us-ascii?Q?2qH9lYzHlG4MO1nIzzY0GX4388dzmTKcMy2KLM0SgZKsUZaDg0vw7kOq21zm?=
 =?us-ascii?Q?uvVbQRA0/Fcaam9SGyw4lyURumaOreytjp9E7qnG+ukbcWF/zfQ5lLVFfDPB?=
 =?us-ascii?Q?0BGxSQKM29fzd6DMr+pqDKZc5IEm2jtrN4OuRXUNNmhmTiESzyco8KzXfSjr?=
 =?us-ascii?Q?3tiQU+hnlOjOHbgE6RvJJ+9JLmeCRulFUAsRE06pB43fhfwgJzKnYDvhsljk?=
 =?us-ascii?Q?XW9cnVC/Cn+I0DmqZDe1stOnsFfI9GmjPjRJv49aq5pjMsQZZYy/NIx0cFot?=
 =?us-ascii?Q?fct5e17syYaZE/2Yy/RxPyIBm2Sk5RMEDl3HCnp2r7Rdg6I8v7NS6J/O4nD7?=
 =?us-ascii?Q?8uwMdmBNW3RIZYuD6/fETx1IjyH/+TW09hkrGMO2d8FiwsbquglL2P69gOzk?=
 =?us-ascii?Q?I84f/MDNFynknStulUgPCqlGU0Wuhkmjyq8gctskXYjLAZkFCNuiKiJZBGLs?=
 =?us-ascii?Q?wjRI42jQMj3kaEYMtKZc1xYCgDGoFCsN+flokX47rFMBK2GlWg0Aefym2Cm4?=
 =?us-ascii?Q?TFSKvEIbR/CJBD9ilzEhOG7WBKPkGNhmmU+2As6+xtiKIKYV16kuGxuvupEq?=
 =?us-ascii?Q?ZSJG78d2WckEnVizjf/C6kGTKFi/SoaMC2YPCVN5iUX5EQcsoO59jalhrshV?=
 =?us-ascii?Q?7Cj88XTu+cUXsZeu6cDKHOO44qsMqaUTpVHmxxtjaSgHvccBej35+paAt3Xe?=
 =?us-ascii?Q?1T7/U5Rw4JbkQ3rfOmED8tuCBn5lsDcfIG2xVssJg5YsztGmCbzhXCr8UJtT?=
 =?us-ascii?Q?jcRDmLzcidt/vNdMqQtwRuL5P7yAMgsskznZI8vWYJF+spmJSVJbRLBiCbAU?=
 =?us-ascii?Q?qFLnam8FBKfNIkPDjEXRgphc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05601bbe-0240-4b38-1768-08d92aa82876
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:06:37.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SplhooJyuOfQ7Y9i3giQfdiNWJfx7QSXpKDIKQLGJut8UEiodZo6i/HaZ+7l+gbnIxJdxJz9U8lS1FrRXuH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

Invoke a hypercall when a memory region is changed from encrypted ->
decrypted and vice versa. Hypervisor needs to know the page encryption
status during the guest migration.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Steve Rutherford <srutherford@google.com>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/paravirt.h       |  6 +++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/include/asm/set_memory.h     |  1 +
 arch/x86/kernel/paravirt.c            |  1 +
 arch/x86/mm/mem_encrypt.c             | 69 +++++++++++++++++++++++----
 arch/x86/mm/pat/set_memory.c          |  7 +++
 6 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index da3a1ac82be5..540bf8cb37db 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -97,6 +97,12 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
+static inline void notify_page_enc_status_changed(unsigned long pfn,
+						  int npages, bool enc)
+{
+	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index d9d6b0203ec4..664199820239 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -168,6 +168,7 @@ struct pv_mmu_ops {
 
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
+	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
 
 #ifdef CONFIG_PARAVIRT_XXL
 	struct paravirt_callee_save read_cr2;
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 43fa081a1adb..872617542bbc 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -83,6 +83,7 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
+void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc057bed..1cc20ac9a54f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -296,6 +296,7 @@ struct paravirt_patch_template pv_ops = {
 			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
 
 	.mmu.exit_mmap		= paravirt_nop,
+	.mmu.notify_page_enc_status_changed	= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..6b12620376a4 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -228,29 +228,77 @@ void __init sev_setup_arch(void)
 	swiotlb_adjust_size(size);
 }
 
-static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 {
-	pgprot_t old_prot, new_prot;
-	unsigned long pfn, pa, size;
-	pte_t new_pte;
+	unsigned long pfn = 0;
+	pgprot_t prot;
 
 	switch (level) {
 	case PG_LEVEL_4K:
 		pfn = pte_pfn(*kpte);
-		old_prot = pte_pgprot(*kpte);
+		prot = pte_pgprot(*kpte);
 		break;
 	case PG_LEVEL_2M:
 		pfn = pmd_pfn(*(pmd_t *)kpte);
-		old_prot = pmd_pgprot(*(pmd_t *)kpte);
+		prot = pmd_pgprot(*(pmd_t *)kpte);
 		break;
 	case PG_LEVEL_1G:
 		pfn = pud_pfn(*(pud_t *)kpte);
-		old_prot = pud_pgprot(*(pud_t *)kpte);
+		prot = pud_pgprot(*(pud_t *)kpte);
 		break;
 	default:
-		return;
+		WARN_ONCE(1, "Invalid level for kpte\n");
+		return 0;
 	}
 
+	if (ret_prot)
+		*ret_prot = prot;
+
+	return pfn;
+}
+
+void notify_range_enc_status_changed(unsigned long vaddr, int npages,
+				    bool enc)
+{
+#ifdef CONFIG_PARAVIRT
+	unsigned long sz = npages << PAGE_SHIFT;
+	unsigned long vaddr_end = vaddr + sz;
+
+	while (vaddr < vaddr_end) {
+		int psize, pmask, level;
+		unsigned long pfn;
+		pte_t *kpte;
+
+		kpte = lookup_address(vaddr, &level);
+		if (!kpte || pte_none(*kpte)) {
+			WARN_ONCE(1, "kpte lookup for vaddr\n");
+			return;
+		}
+
+		pfn = pg_level_to_pfn(level, kpte, NULL);
+		if (!pfn)
+			continue;
+
+		psize = page_level_size(level);
+		pmask = page_level_mask(level);
+
+		notify_page_enc_status_changed(pfn, psize >> PAGE_SHIFT, enc);
+
+		vaddr = (vaddr & pmask) + psize;
+	}
+#endif
+}
+
+static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+{
+	pgprot_t old_prot, new_prot;
+	unsigned long pfn, pa, size;
+	pte_t new_pte;
+
+	pfn = pg_level_to_pfn(level, kpte, &old_prot);
+	if (!pfn)
+		return;
+
 	new_prot = old_prot;
 	if (enc)
 		pgprot_val(new_prot) |= _PAGE_ENC;
@@ -285,12 +333,13 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 static int __init early_set_memory_enc_dec(unsigned long vaddr,
 					   unsigned long size, bool enc)
 {
-	unsigned long vaddr_end, vaddr_next;
+	unsigned long vaddr_end, vaddr_next, start;
 	unsigned long psize, pmask;
 	int split_page_size_mask;
 	int level, ret;
 	pte_t *kpte;
 
+	start = vaddr;
 	vaddr_next = vaddr;
 	vaddr_end = vaddr + size;
 
@@ -345,6 +394,8 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
+	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT,
+					enc);
 out:
 	__flush_tlb_all();
 	return ret;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 156cd235659f..9729cb0d99e3 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2020,6 +2020,13 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	/*
+	 * Notify hypervisor that a given memory range is mapped encrypted
+	 * or decrypted. The hypervisor will use this information during the
+	 * VM migration.
+	 */
+	notify_range_enc_status_changed(addr, numpages, enc);
+
 	return ret;
 }
 
-- 
2.17.1

