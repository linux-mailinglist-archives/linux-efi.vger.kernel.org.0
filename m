Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6987B566B
	for <lists+linux-efi@lfdr.de>; Mon,  2 Oct 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjJBPOv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Oct 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbjJBPOu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Oct 2023 11:14:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5064AC
        for <linux-efi@vger.kernel.org>; Mon,  2 Oct 2023 08:14:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4054496bde3so149280095e9.1
        for <linux-efi@vger.kernel.org>; Mon, 02 Oct 2023 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696259683; x=1696864483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIMzmr/PY70Z2D2FCaui5pQoBeqQRhmKx80FxNdR6+A=;
        b=ag2SJusyqsJLjtHo0OpgIam1YSh+Ym9AhrFxQzw7pnd8hDsBRroAhNgY2gBJNEZYJq
         BoExvwen9ci5IjQQJZ1trwktS+zs9dWSdSzealG7ByarZ159zWrrneFTXFnn1ZXd8Ts1
         qMtSYnuyp5JxxXjLKv3fMb7U1hzuEyuSK8MIiGXVLsAJPgtw2xaT8HDr44U1D06M5nRH
         73ZcdVnHyxjm837yuuUQYxVmGmnTb2Mld0HnkqUP5I+1X6O/lz3NTdPS8Xu3VVqIa6aR
         Ejsg7cL88CmNP8na1lZw7RTV0BxPcWLgAKWombDSCcn/1a5yzaCWYgR5jlIsQ8ZjdOQ8
         WEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259683; x=1696864483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIMzmr/PY70Z2D2FCaui5pQoBeqQRhmKx80FxNdR6+A=;
        b=F/VrjYeax0IqeYVtpnFGj3TLSY3bTCYVsUVpejaWE7YfMhIOCoUD2Pl+u/Zv5hmgEd
         6uY2OEaMu2iYiyxegG0ph84CncFAtEI58rF6Xn1bUcabKp6elOBKUhLPDA60go7lDT34
         XuPOw/j9rQu18cUv+lhVSdF71RQgkTcXzP9uQCDgcnmjlKXiabpqLt4u/RftCqcm3f5E
         2C0AClM/U+VLkFHWr50g+vAk5i3aABSvEFkShTSoGdXnTQ8wYbkGujHUqWCYho0NMSnS
         0Gyv/5Nh/WjWADJ8udtaATvsSfcoS9ZYukriKS+ZKjm1StbsMM7Cl3B+KHRJ6Az7SdSr
         N6mw==
X-Gm-Message-State: AOJu0YzmoexiIPRvkJ1Q+t6N2W6Ty3uj6hesD3eInbdX1/1qd3Y96MJ/
        Z4e6B91wmXsQK7i6PV43jqu+QA==
X-Google-Smtp-Source: AGHT+IG214vp+ZTT5MpbSlfQSK0LrUZVQ/xG9fCJWALrjsfwrlLNz7Oxp25mnoTTeHy0voW9+EtBtw==
X-Received: by 2002:a7b:c8d1:0:b0:405:3b92:2fed with SMTP id f17-20020a7bc8d1000000b004053b922fedmr9764385wml.26.1696259682974;
        Mon, 02 Oct 2023 08:14:42 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c234900b00401d8181f8bsm7491028wmq.25.2023.10.02.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:14:42 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 4/5] riscv: Suffix all page table entry pointers with 'p'
Date:   Mon,  2 Oct 2023 17:10:30 +0200
Message-Id: <20231002151031.110551-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002151031.110551-1-alexghiti@rivosinc.com>
References: <20231002151031.110551-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

That makes it more clear what the underlying type is, no functional
changes intended.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/kfence.h     |  6 +-
 arch/riscv/include/asm/kvm_host.h   |  2 +-
 arch/riscv/include/asm/pgalloc.h    | 86 +++++++++++++-------------
 arch/riscv/include/asm/pgtable-64.h | 20 +++---
 arch/riscv/kvm/mmu.c                | 22 +++----
 arch/riscv/mm/fault.c               | 38 ++++++------
 arch/riscv/mm/hugetlbpage.c         | 78 +++++++++++------------
 arch/riscv/mm/init.c                | 30 ++++-----
 arch/riscv/mm/kasan_init.c          | 96 ++++++++++++++---------------
 arch/riscv/mm/pageattr.c            | 74 +++++++++++-----------
 arch/riscv/mm/pgtable.c             | 46 +++++++-------
 11 files changed, 251 insertions(+), 247 deletions(-)

diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index 0bbffd528096..3b482d0a4633 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -15,12 +15,12 @@ static inline bool arch_kfence_init_pool(void)
 
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
-	pte_t *pte = virt_to_kpte(addr);
+	pte_t *ptep = virt_to_kpte(addr);
 
 	if (protect)
-		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
+		set_pte(ptep, __pte(pte_val(*ptep) & ~_PAGE_PRESENT));
 	else
-		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
+		set_pte(ptep, __pte(pte_val(*ptep) | _PAGE_PRESENT));
 
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 1ebf20dfbaa6..510045c05ee8 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -93,7 +93,7 @@ struct kvm_arch {
 	struct kvm_vmid vmid;
 
 	/* G-stage page table */
-	pgd_t *pgd;
+	pgd_t *pgdp;
 	phys_addr_t pgd_phys;
 
 	/* Guest Timer */
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index d169a4f41a2e..1bb3c9fcbe04 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -16,65 +16,65 @@
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
-	pmd_t *pmd, pte_t *pte)
+	pmd_t *pmdp, pte_t *ptep)
 {
-	unsigned long pfn = virt_to_pfn(pte);
+	unsigned long pfn = virt_to_pfn(ptep);
 
-	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pmd(pmdp, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
 static inline void pmd_populate(struct mm_struct *mm,
-	pmd_t *pmd, pgtable_t pte)
+	pmd_t *pmdp, pgtable_t pte)
 {
 	unsigned long pfn = virt_to_pfn(page_address(pte));
 
-	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pmd(pmdp, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
-static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 {
-	unsigned long pfn = virt_to_pfn(pmd);
+	unsigned long pfn = virt_to_pfn(pmdp);
 
-	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pud(pudp, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
-static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
 {
 	if (pgtable_l4_enabled) {
-		unsigned long pfn = virt_to_pfn(pud);
+		unsigned long pfn = virt_to_pfn(pudp);
 
-		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+		set_p4d(p4dp, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
-static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
-				     pud_t *pud)
+static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4dp,
+				     pud_t *pudp)
 {
 	if (pgtable_l4_enabled) {
-		unsigned long pfn = virt_to_pfn(pud);
+		unsigned long pfn = virt_to_pfn(pudp);
 
-		set_p4d_safe(p4d,
+		set_p4d_safe(p4dp,
 			     __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 {
 	if (pgtable_l5_enabled) {
-		unsigned long pfn = virt_to_pfn(p4d);
+		unsigned long pfn = virt_to_pfn(p4dp);
 
-		set_pgd(pgd, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+		set_pgd(pgdp, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
-static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
-				     p4d_t *p4d)
+static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgdp,
+				     p4d_t *p4dp)
 {
 	if (pgtable_l5_enabled) {
-		unsigned long pfn = virt_to_pfn(p4d);
+		unsigned long pfn = virt_to_pfn(p4dp);
 
-		set_pgd_safe(pgd,
+		set_pgd_safe(pgdp,
 			     __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
@@ -89,13 +89,13 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 }
 
 #define pud_free pud_free
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
 {
 	if (pgtable_l4_enabled)
-		__pud_free(mm, pud);
+		__pud_free(mm, pudp);
 }
 
-#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
+#define __pud_free_tlb(tlb, pudp, addr)  pud_free((tlb)->mm, pudp)
 
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -111,52 +111,52 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return NULL;
 }
 
-static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
+static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4dp)
 {
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	BUG_ON((unsigned long)p4dp & (PAGE_SIZE-1));
+	free_page((unsigned long)p4dp);
 }
 
 #define p4d_free p4d_free
-static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
+static inline void p4d_free(struct mm_struct *mm, p4d_t *p4dp)
 {
 	if (pgtable_l5_enabled)
-		__p4d_free(mm, p4d);
+		__p4d_free(mm, p4dp);
 }
 
 #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static inline void sync_kernel_mappings(pgd_t *pgd)
+static inline void sync_kernel_mappings(pgd_t *pgdp)
 {
-	memcpy(pgd + USER_PTRS_PER_PGD,
+	memcpy(pgdp + USER_PTRS_PER_PGD,
 	       init_mm.pgd + USER_PTRS_PER_PGD,
 	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd;
+	pgd_t *pgdp;
 
-	pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-	if (likely(pgd != NULL)) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+	pgdp = (pgd_t *)__get_free_page(GFP_KERNEL);
+	if (likely(pgdp != NULL)) {
+		memset(pgdp, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 		/* Copy kernel mappings */
-		sync_kernel_mappings(pgd);
+		sync_kernel_mappings(pgdp);
 	}
-	return pgd;
+	return pgdp;
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmdp, addr)  pmd_free((tlb)->mm, pmdp)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)			\
-do {							\
-	pagetable_pte_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
+#define __pte_free_tlb(tlb, ptep, buf)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(ptep));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(ptep));	\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index a65a352dcfbf..c5f608fe9980 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -303,10 +303,10 @@ static inline int p4d_bad(p4d_t p4d)
 	return 0;
 }
 
-static inline void p4d_clear(p4d_t *p4d)
+static inline void p4d_clear(p4d_t *p4dp)
 {
 	if (pgtable_l4_enabled)
-		set_p4d(p4d, __p4d(0));
+		set_p4d(p4dp, __p4d(0));
 }
 
 static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
@@ -336,12 +336,12 @@ static inline struct page *p4d_page(p4d_t p4d)
 #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 
 #define pud_offset pud_offset
-static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+static inline pud_t *pud_offset(p4d_t *p4dp, unsigned long address)
 {
 	if (pgtable_l4_enabled)
-		return p4d_pgtable(*p4d) + pud_index(address);
+		return p4d_pgtable(*p4dp) + pud_index(address);
 
-	return (pud_t *)p4d;
+	return (pud_t *)p4dp;
 }
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
@@ -376,10 +376,10 @@ static inline int pgd_bad(pgd_t pgd)
 	return 0;
 }
 
-static inline void pgd_clear(pgd_t *pgd)
+static inline void pgd_clear(pgd_t *pgdp)
 {
 	if (pgtable_l5_enabled)
-		set_pgd(pgd, __pgd(0));
+		set_pgd(pgdp, __pgd(0));
 }
 
 static inline p4d_t *pgd_pgtable(pgd_t pgd)
@@ -400,12 +400,12 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
 
 #define p4d_offset p4d_offset
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static inline p4d_t *p4d_offset(pgd_t *pgdp, unsigned long address)
 {
 	if (pgtable_l5_enabled)
-		return pgd_pgtable(*pgd) + p4d_index(address);
+		return pgd_pgtable(*pgdp) + p4d_index(address);
 
-	return (p4d_t *)pgd;
+	return (p4d_t *)pgdp;
 }
 
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 068c74593871..35db276bf0c2 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -101,7 +101,7 @@ static bool gstage_get_leaf_entry(struct kvm *kvm, gpa_t addr,
 	u32 current_level = gstage_pgd_levels - 1;
 
 	*ptep_level = current_level;
-	ptep = (pte_t *)kvm->arch.pgd;
+	ptep = (pte_t *)kvm->arch.pgdp;
 	ptep = &ptep[gstage_pte_index(addr, current_level)];
 	while (ptep && pte_val(*ptep)) {
 		if (gstage_pte_leaf(ptep)) {
@@ -139,7 +139,7 @@ static int gstage_set_pte(struct kvm *kvm, u32 level,
 			   gpa_t addr, const pte_t *new_pte)
 {
 	u32 current_level = gstage_pgd_levels - 1;
-	pte_t *next_ptep = (pte_t *)kvm->arch.pgd;
+	pte_t *next_ptep = (pte_t *)kvm->arch.pgdp;
 	pte_t *ptep = &next_ptep[gstage_pte_index(addr, current_level)];
 
 	if (current_level < level)
@@ -541,7 +541,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	if (!kvm->arch.pgd)
+	if (!kvm->arch.pgdp)
 		return false;
 
 	gstage_unmap_range(kvm, range->start << PAGE_SHIFT,
@@ -555,7 +555,7 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	int ret;
 	kvm_pfn_t pfn = pte_pfn(range->arg.pte);
 
-	if (!kvm->arch.pgd)
+	if (!kvm->arch.pgdp)
 		return false;
 
 	WARN_ON(range->end - range->start != 1);
@@ -576,7 +576,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	u32 ptep_level = 0;
 	u64 size = (range->end - range->start) << PAGE_SHIFT;
 
-	if (!kvm->arch.pgd)
+	if (!kvm->arch.pgdp)
 		return false;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
@@ -594,7 +594,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	u32 ptep_level = 0;
 	u64 size = (range->end - range->start) << PAGE_SHIFT;
 
-	if (!kvm->arch.pgd)
+	if (!kvm->arch.pgdp)
 		return false;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
@@ -712,7 +712,7 @@ int kvm_riscv_gstage_alloc_pgd(struct kvm *kvm)
 {
 	struct page *pgd_page;
 
-	if (kvm->arch.pgd != NULL) {
+	if (kvm->arch.pgdp != NULL) {
 		kvm_err("kvm_arch already initialized?\n");
 		return -EINVAL;
 	}
@@ -721,7 +721,7 @@ int kvm_riscv_gstage_alloc_pgd(struct kvm *kvm)
 				get_order(gstage_pgd_size));
 	if (!pgd_page)
 		return -ENOMEM;
-	kvm->arch.pgd = page_to_virt(pgd_page);
+	kvm->arch.pgdp = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
 
 	return 0;
@@ -732,10 +732,10 @@ void kvm_riscv_gstage_free_pgd(struct kvm *kvm)
 	void *pgd = NULL;
 
 	spin_lock(&kvm->mmu_lock);
-	if (kvm->arch.pgd) {
+	if (kvm->arch.pgdp) {
 		gstage_unmap_range(kvm, 0UL, gstage_gpa_size, false);
-		pgd = READ_ONCE(kvm->arch.pgd);
-		kvm->arch.pgd = NULL;
+		pgd = READ_ONCE(kvm->arch.pgdp);
+		kvm->arch.pgdp = NULL;
 		kvm->arch.pgd_phys = 0;
 	}
 	spin_unlock(&kvm->mmu_lock);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 6115d7514972..6284ef4b644a 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -111,11 +111,11 @@ bad_area(struct pt_regs *regs, struct mm_struct *mm, int code,
 
 static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
 {
-	pgd_t *pgd, *pgd_k;
-	pud_t *pud_k;
-	p4d_t *p4d_k;
-	pmd_t *pmd_k;
-	pte_t *pte_k;
+	pgd_t *pgdp, *pgdp_k;
+	pud_t *pudp_k;
+	p4d_t *p4dp_k;
+	pmd_t *pmdp_k;
+	pte_t *ptep_k;
 	int index;
 	unsigned long pfn;
 
@@ -133,39 +133,39 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 */
 	index = pgd_index(addr);
 	pfn = csr_read(CSR_SATP) & SATP_PPN;
-	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
-	pgd_k = init_mm.pgd + index;
+	pgdp = (pgd_t *)pfn_to_virt(pfn) + index;
+	pgdp_k = init_mm.pgd + index;
 
-	if (!pgd_present(*pgd_k)) {
+	if (!pgd_present(*pgdp_k)) {
 		no_context(regs, addr);
 		return;
 	}
-	set_pgd(pgd, *pgd_k);
+	set_pgd(pgdp, *pgdp_k);
 
-	p4d_k = p4d_offset(pgd_k, addr);
-	if (!p4d_present(*p4d_k)) {
+	p4dp_k = p4d_offset(pgdp_k, addr);
+	if (!p4d_present(*p4dp_k)) {
 		no_context(regs, addr);
 		return;
 	}
 
-	pud_k = pud_offset(p4d_k, addr);
-	if (!pud_present(*pud_k)) {
+	pudp_k = pud_offset(p4dp_k, addr);
+	if (!pud_present(*pudp_k)) {
 		no_context(regs, addr);
 		return;
 	}
-	if (pud_leaf(*pud_k))
+	if (pud_leaf(*pudp_k))
 		goto flush_tlb;
 
 	/*
 	 * Since the vmalloc area is global, it is unnecessary
 	 * to copy individual PTEs
 	 */
-	pmd_k = pmd_offset(pud_k, addr);
-	if (!pmd_present(*pmd_k)) {
+	pmdp_k = pmd_offset(pudp_k, addr);
+	if (!pmd_present(*pmdp_k)) {
 		no_context(regs, addr);
 		return;
 	}
-	if (pmd_leaf(*pmd_k))
+	if (pmd_leaf(*pmdp_k))
 		goto flush_tlb;
 
 	/*
@@ -174,8 +174,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * addresses. If we don't do this, this will just
 	 * silently loop forever.
 	 */
-	pte_k = pte_offset_kernel(pmd_k, addr);
-	if (!pte_present(*pte_k)) {
+	ptep_k = pte_offset_kernel(pmdp_k, addr);
+	if (!pte_present(*ptep_k)) {
 		no_context(regs, addr);
 		return;
 	}
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 96225a8533ad..7781e83b2f29 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -33,52 +33,52 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      unsigned long sz)
 {
 	unsigned long order;
-	pte_t *pte = NULL;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset(mm, addr);
-	p4d = p4d_alloc(mm, pgd, addr);
-	if (!p4d)
+	pte_t *ptep = NULL;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+
+	pgdp = pgd_offset(mm, addr);
+	p4dp = p4d_alloc(mm, pgdp, addr);
+	if (!p4dp)
 		return NULL;
 
-	pud = pud_alloc(mm, p4d, addr);
-	if (!pud)
+	pudp = pud_alloc(mm, p4dp, addr);
+	if (!pudp)
 		return NULL;
 
 	if (sz == PUD_SIZE) {
-		pte = (pte_t *)pud;
+		ptep = (pte_t *)pudp;
 		goto out;
 	}
 
 	if (sz == PMD_SIZE) {
-		if (want_pmd_share(vma, addr) && pud_none(*pud))
-			pte = huge_pmd_share(mm, vma, addr, pud);
+		if (want_pmd_share(vma, addr) && pud_none(*pudp))
+			ptep = huge_pmd_share(mm, vma, addr, pudp);
 		else
-			pte = (pte_t *)pmd_alloc(mm, pud, addr);
+			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
 		goto out;
 	}
 
-	pmd = pmd_alloc(mm, pud, addr);
-	if (!pmd)
+	pmdp = pmd_alloc(mm, pudp, addr);
+	if (!pmdp)
 		return NULL;
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
+			ptep = pte_alloc_huge(mm, pmdp, addr & napot_cont_mask(order));
 			break;
 		}
 	}
 
 out:
-	if (pte) {
-		pte_t pteval = ptep_get_lockless(pte);
+	if (ptep) {
+		pte_t pteval = ptep_get_lockless(ptep);
 
 		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
 	}
-	return pte;
+	return ptep;
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
@@ -86,43 +86,43 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long sz)
 {
 	unsigned long order;
-	pte_t *pte = NULL;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset(mm, addr);
-	if (!pgd_present(*pgd))
+	pte_t *ptep = NULL;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+
+	pgdp = pgd_offset(mm, addr);
+	if (!pgd_present(*pgdp))
 		return NULL;
 
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	p4dp = p4d_offset(pgdp, addr);
+	if (!p4d_present(*p4dp))
 		return NULL;
 
-	pud = pud_offset(p4d, addr);
+	pudp = pud_offset(p4dp, addr);
 	if (sz == PUD_SIZE)
 		/* must be pud huge, non-present or none */
-		return (pte_t *)pud;
+		return (pte_t *)pudp;
 
-	if (!pud_present(*pud))
+	if (!pud_present(*pudp))
 		return NULL;
 
-	pmd = pmd_offset(pud, addr);
+	pmdp = pmd_offset(pudp, addr);
 	if (sz == PMD_SIZE)
 		/* must be pmd huge, non-present or none */
-		return (pte_t *)pmd;
+		return (pte_t *)pmdp;
 
-	if (!pmd_present(*pmd))
+	if (!pmd_present(*pmdp))
 		return NULL;
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_offset_huge(pmd, addr & napot_cont_mask(order));
+			ptep = pte_offset_huge(pmdp, addr & napot_cont_mask(order));
 			break;
 		}
 	}
-	return pte;
+	return ptep;
 }
 
 static pte_t get_clear_contig(struct mm_struct *mm,
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..2afd13fd6e18 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -883,7 +883,7 @@ static void __init relocate_kernel(void)
 #endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_XIP_KERNEL
-static void __init create_kernel_page_table(pgd_t *pgdir,
+static void __init create_kernel_page_table(pgd_t *pgdp,
 					    __always_unused bool early)
 {
 	uintptr_t va, end_va;
@@ -891,25 +891,25 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 	/* Map the flash resident part */
 	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
 	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
-		create_pgd_mapping(pgdir, va,
+		create_pgd_mapping(pgdp, va,
 				   kernel_map.xiprom + (va - kernel_map.virt_addr),
 				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
 	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
 	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
-		create_pgd_mapping(pgdir, va,
+		create_pgd_mapping(pgdp, va,
 				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
 				   PMD_SIZE, PAGE_KERNEL);
 }
 #else
-static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
+static void __init create_kernel_page_table(pgd_t *pgdp, bool early)
 {
 	uintptr_t va, end_va;
 
 	end_va = kernel_map.virt_addr + kernel_map.size;
 	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
-		create_pgd_mapping(pgdir, va,
+		create_pgd_mapping(pgdp, va,
 				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
 				   PMD_SIZE,
 				   early ?
@@ -1521,30 +1521,30 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
 	const char *lvl;
 
 	for (addr = start; addr < end && addr >= start; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
-		pgd_t *pgd = pgd_offset_k(addr);
-		p4d_t *p4d;
-		pud_t *pud;
-		pmd_t *pmd;
+		pgd_t *pgdp = pgd_offset_k(addr);
+		p4d_t *p4dp;
+		pud_t *pudp;
+		pmd_t *pmdp;
 
 		lvl = "p4d";
-		p4d = p4d_alloc(&init_mm, pgd, addr);
-		if (!p4d)
+		p4dp = p4d_alloc(&init_mm, pgdp, addr);
+		if (!p4dp)
 			goto failed;
 
 		if (pgtable_l5_enabled)
 			continue;
 
 		lvl = "pud";
-		pud = pud_alloc(&init_mm, p4d, addr);
-		if (!pud)
+		pudp = pud_alloc(&init_mm, p4dp, addr);
+		if (!pudp)
 			goto failed;
 
 		if (pgtable_l4_enabled)
 			continue;
 
 		lvl = "pmd";
-		pmd = pmd_alloc(&init_mm, pud, addr);
-		if (!pmd)
+		pmdp = pmd_alloc(&init_mm, pudp, addr);
+		if (!pmdp)
 			goto failed;
 	}
 	return;
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 5e39dcf23fdb..ce0cb8e51d0a 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -26,17 +26,17 @@ static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
 static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
 
-static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pte(pmd_t *pmdp, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pte_t *ptep, *p;
 
-	if (pmd_none(*pmd)) {
+	if (pmd_none(*pmdp)) {
 		p = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
-		set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(p)), PAGE_TABLE));
+		set_pmd(pmdp, pfn_pmd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	ptep = pte_offset_kernel(pmd, vaddr);
+	ptep = pte_offset_kernel(pmdp, vaddr);
 
 	do {
 		if (pte_none(*ptep)) {
@@ -47,18 +47,18 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
 	} while (ptep++, vaddr += PAGE_SIZE, vaddr != end);
 }
 
-static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pmd(pud_t *pudp, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pmd_t *pmdp, *p;
 	unsigned long next;
 
-	if (pud_none(*pud)) {
+	if (pud_none(*pudp)) {
 		p = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
-		set_pud(pud, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
+		set_pud(pudp, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	pmdp = pmd_offset(pud, vaddr);
+	pmdp = pmd_offset(pudp, vaddr);
 
 	do {
 		next = pmd_addr_end(vaddr, end);
@@ -76,19 +76,19 @@ static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned
 	} while (pmdp++, vaddr = next, vaddr != end);
 }
 
-static void __init kasan_populate_pud(p4d_t *p4d,
+static void __init kasan_populate_pud(p4d_t *p4dp,
 				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pud_t *pudp, *p;
 	unsigned long next;
 
-	if (p4d_none(*p4d)) {
+	if (p4d_none(*p4dp)) {
 		p = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
-		set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
+		set_p4d(p4dp, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	pudp = pud_offset(p4d, vaddr);
+	pudp = pud_offset(p4dp, vaddr);
 
 	do {
 		next = pud_addr_end(vaddr, end);
@@ -106,19 +106,19 @@ static void __init kasan_populate_pud(p4d_t *p4d,
 	} while (pudp++, vaddr = next, vaddr != end);
 }
 
-static void __init kasan_populate_p4d(pgd_t *pgd,
+static void __init kasan_populate_p4d(pgd_t *pgdp,
 				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	p4d_t *p4dp, *p;
 	unsigned long next;
 
-	if (pgd_none(*pgd)) {
+	if (pgd_none(*pgdp)) {
 		p = memblock_alloc(PTRS_PER_P4D * sizeof(p4d_t), PAGE_SIZE);
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
+		set_pgd(pgdp, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	p4dp = p4d_offset(pgd, vaddr);
+	p4dp = p4d_offset(pgdp, vaddr);
 
 	do {
 		next = p4d_addr_end(vaddr, end);
@@ -162,14 +162,14 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 static void __init kasan_early_clear_pud(p4d_t *p4dp,
 					 unsigned long vaddr, unsigned long end)
 {
-	pud_t *pudp, *base_pud;
+	pud_t *pudp, *base_pudp;
 	unsigned long next;
 
 	if (!pgtable_l4_enabled) {
 		pudp = (pud_t *)p4dp;
 	} else {
-		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
-		pudp = base_pud + pud_index(vaddr);
+		base_pudp = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
+		pudp = base_pudp + pud_index(vaddr);
 	}
 
 	do {
@@ -187,14 +187,14 @@ static void __init kasan_early_clear_pud(p4d_t *p4dp,
 static void __init kasan_early_clear_p4d(pgd_t *pgdp,
 					 unsigned long vaddr, unsigned long end)
 {
-	p4d_t *p4dp, *base_p4d;
+	p4d_t *p4dp, *base_p4dp;
 	unsigned long next;
 
 	if (!pgtable_l5_enabled) {
 		p4dp = (p4d_t *)pgdp;
 	} else {
-		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
-		p4dp = base_p4d + p4d_index(vaddr);
+		base_p4dp = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
+		p4dp = base_p4dp + p4d_index(vaddr);
 	}
 
 	do {
@@ -232,15 +232,15 @@ static void __init kasan_early_populate_pud(p4d_t *p4dp,
 					    unsigned long vaddr,
 					    unsigned long end)
 {
-	pud_t *pudp, *base_pud;
+	pud_t *pudp, *base_pudp;
 	phys_addr_t phys_addr;
 	unsigned long next;
 
 	if (!pgtable_l4_enabled) {
 		pudp = (pud_t *)p4dp;
 	} else {
-		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
-		pudp = base_pud + pud_index(vaddr);
+		base_pudp = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
+		pudp = base_pudp + pud_index(vaddr);
 	}
 
 	do {
@@ -261,7 +261,7 @@ static void __init kasan_early_populate_p4d(pgd_t *pgdp,
 					    unsigned long vaddr,
 					    unsigned long end)
 {
-	p4d_t *p4dp, *base_p4d;
+	p4d_t *p4dp, *base_p4dp;
 	phys_addr_t phys_addr;
 	unsigned long next;
 
@@ -277,8 +277,8 @@ static void __init kasan_early_populate_p4d(pgd_t *pgdp,
 	if (!pgtable_l5_enabled) {
 		p4dp = (p4d_t *)pgdp;
 	} else {
-		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
-		p4dp = base_p4d + p4d_index(vaddr);
+		base_p4dp = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
+		p4dp = base_p4dp + p4d_index(vaddr);
 	}
 
 	do {
@@ -371,63 +371,63 @@ static void __init kasan_populate(void *start, void *end)
 	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend);
 }
 
-static void __init kasan_shallow_populate_pud(p4d_t *p4d,
+static void __init kasan_shallow_populate_pud(p4d_t *p4dp,
 					      unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
 	void *p;
-	pud_t *pud_k = pud_offset(p4d, vaddr);
+	pud_t *pudp_k = pud_offset(p4dp, vaddr);
 
 	do {
 		next = pud_addr_end(vaddr, end);
 
-		if (pud_none(*pud_k)) {
+		if (pud_none(*pudp_k)) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-			set_pud(pud_k, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
+			set_pud(pudp_k, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
 			continue;
 		}
 
 		BUG();
-	} while (pud_k++, vaddr = next, vaddr != end);
+	} while (pudp_k++, vaddr = next, vaddr != end);
 }
 
-static void __init kasan_shallow_populate_p4d(pgd_t *pgd,
+static void __init kasan_shallow_populate_p4d(pgd_t *pgdp,
 					      unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
 	void *p;
-	p4d_t *p4d_k = p4d_offset(pgd, vaddr);
+	p4d_t *p4dp_k = p4d_offset(pgdp, vaddr);
 
 	do {
 		next = p4d_addr_end(vaddr, end);
 
-		if (p4d_none(*p4d_k)) {
+		if (p4d_none(*p4dp_k)) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-			set_p4d(p4d_k, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
+			set_p4d(p4dp_k, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
 			continue;
 		}
 
-		kasan_shallow_populate_pud(p4d_k, vaddr, end);
-	} while (p4d_k++, vaddr = next, vaddr != end);
+		kasan_shallow_populate_pud(p4dp_k, vaddr, end);
+	} while (p4dp_k++, vaddr = next, vaddr != end);
 }
 
 static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
 	void *p;
-	pgd_t *pgd_k = pgd_offset_k(vaddr);
+	pgd_t *pgdp_k = pgd_offset_k(vaddr);
 
 	do {
 		next = pgd_addr_end(vaddr, end);
 
-		if (pgd_none(*pgd_k)) {
+		if (pgd_none(*pgdp_k)) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
+			set_pgd(pgdp_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 			continue;
 		}
 
-		kasan_shallow_populate_p4d(pgd_k, vaddr, next);
-	} while (pgd_k++, vaddr = next, vaddr != end);
+		kasan_shallow_populate_p4d(pgdp_k, vaddr, next);
+	} while (pgdp_k++, vaddr = next, vaddr != end);
 }
 
 static void __init kasan_shallow_populate(void *start, void *end)
@@ -441,7 +441,7 @@ static void __init kasan_shallow_populate(void *start, void *end)
 static void __init create_tmp_mapping(void)
 {
 	void *ptr;
-	p4d_t *base_p4d;
+	p4d_t *base_p4dp;
 
 	/*
 	 * We need to clean the early mapping: this is hard to achieve "in-place",
@@ -455,16 +455,16 @@ static void __init create_tmp_mapping(void)
 		memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
 		set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
 			pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
-		base_p4d = tmp_p4d;
+		base_p4dp = tmp_p4d;
 	} else {
-		base_p4d = (p4d_t *)tmp_pg_dir;
+		base_p4dp = (p4d_t *)tmp_pg_dir;
 	}
 
 	/* Copy the last pud since it is shared with the kernel mapping. */
 	if (pgtable_l4_enabled) {
 		ptr = (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KASAN_SHADOW_END)));
 		memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
-		set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
+		set_p4d(&base_p4dp[p4d_index(KASAN_SHADOW_END)],
 			pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
 	}
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 161d0b34c2cb..ffca6f19dd9c 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -25,65 +25,65 @@ static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
 	return new_val;
 }
 
-static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
+static int pageattr_pgd_entry(pgd_t *pgdp, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pgd_t val = READ_ONCE(*pgd);
+	pgd_t val = READ_ONCE(*pgdp);
 
 	if (pgd_leaf(val)) {
 		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
-		set_pgd(pgd, val);
+		set_pgd(pgdp, val);
 	}
 
 	return 0;
 }
 
-static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
+static int pageattr_p4d_entry(p4d_t *p4dp, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	p4d_t val = READ_ONCE(*p4d);
+	p4d_t val = READ_ONCE(*p4dp);
 
 	if (p4d_leaf(val)) {
 		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
-		set_p4d(p4d, val);
+		set_p4d(p4dp, val);
 	}
 
 	return 0;
 }
 
-static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+static int pageattr_pud_entry(pud_t *pudp, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pud_t val = READ_ONCE(*pud);
+	pud_t val = READ_ONCE(*pudp);
 
 	if (pud_leaf(val)) {
 		val = __pud(set_pageattr_masks(pud_val(val), walk));
-		set_pud(pud, val);
+		set_pud(pudp, val);
 	}
 
 	return 0;
 }
 
-static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+static int pageattr_pmd_entry(pmd_t *pmdp, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pmd_t val = READ_ONCE(*pmd);
+	pmd_t val = READ_ONCE(*pmdp);
 
 	if (pmd_leaf(val)) {
 		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
-		set_pmd(pmd, val);
+		set_pmd(pmdp, val);
 	}
 
 	return 0;
 }
 
-static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+static int pageattr_pte_entry(pte_t *ptep, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pte_t val = READ_ONCE(*pte);
+	pte_t val = READ_ONCE(*ptep);
 
 	val = __pte(set_pageattr_masks(pte_val(val), walk));
-	set_pte(pte, val);
+	set_pte(ptep, val);
 
 	return 0;
 }
@@ -209,36 +209,40 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 bool kernel_page_present(struct page *page)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-	pgd_t *pgd;
-	pud_t *pud;
-	p4d_t *p4d;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset_k(addr);
-	if (!pgd_present(*pgd))
+	pgd_t *pgdp, pgd;
+	pud_t *pudp, pud;
+	p4d_t *p4dp, p4d;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_k(addr);
+	pgd = *pgdp;
+	if (!pgd_present(pgd))
 		return false;
-	if (pgd_leaf(*pgd))
+	if (pgd_leaf(pgd))
 		return true;
 
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = *p4dp;
+	if (!p4d_present(p4d))
 		return false;
-	if (p4d_leaf(*p4d))
+	if (p4d_leaf(p4d))
 		return true;
 
-	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
+	pudp = pud_offset(p4dp, addr);
+	pud = *pudp;
+	if (!pud_present(pud))
 		return false;
-	if (pud_leaf(*pud))
+	if (pud_leaf(pud))
 		return true;
 
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	pmdp = pmd_offset(pudp, addr);
+	pmd = *pmdp;
+	if (!pmd_present(pmd))
 		return false;
-	if (pmd_leaf(*pmd))
+	if (pmd_leaf(pmd))
 		return true;
 
-	pte = pte_offset_kernel(pmd, addr);
-	return pte_present(*pte);
+	ptep = pte_offset_kernel(pmdp, addr);
+	return pte_present(*ptep);
 }
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index fef4e7328e49..9c93f24d0829 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -6,77 +6,77 @@
 #include <linux/pgtable.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
+int p4d_set_huge(p4d_t *p4dp, phys_addr_t addr, pgprot_t prot)
 {
 	return 0;
 }
 
-void p4d_clear_huge(p4d_t *p4d)
+void p4d_clear_huge(p4d_t *p4dp)
 {
 }
 
-int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
+int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), prot);
 
-	set_pud(pud, new_pud);
+	set_pud(pudp, new_pud);
 	return 1;
 }
 
-int pud_clear_huge(pud_t *pud)
+int pud_clear_huge(pud_t *pudp)
 {
-	if (!pud_leaf(READ_ONCE(*pud)))
+	if (!pud_leaf(READ_ONCE(*pudp)))
 		return 0;
-	pud_clear(pud);
+	pud_clear(pudp);
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
-	pmd_t *pmd = pud_pgtable(*pud);
+	pmd_t *pmdp = pud_pgtable(*pudp);
 	int i;
 
-	pud_clear(pud);
+	pud_clear(pudp);
 
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
-		if (!pmd_none(pmd[i])) {
-			pte_t *pte = (pte_t *)pmd_page_vaddr(pmd[i]);
+		if (!pmd_none(pmdp[i])) {
+			pte_t *ptep = (pte_t *)pmd_page_vaddr(pmdp[i]);
 
-			pte_free_kernel(NULL, pte);
+			pte_free_kernel(NULL, ptep);
 		}
 	}
 
-	pmd_free(NULL, pmd);
+	pmd_free(NULL, pmdp);
 
 	return 1;
 }
 
-int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
+int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), prot);
 
-	set_pmd(pmd, new_pmd);
+	set_pmd(pmdp, new_pmd);
 	return 1;
 }
 
-int pmd_clear_huge(pmd_t *pmd)
+int pmd_clear_huge(pmd_t *pmdp)
 {
-	if (!pmd_leaf(READ_ONCE(*pmd)))
+	if (!pmd_leaf(READ_ONCE(*pmdp)))
 		return 0;
-	pmd_clear(pmd);
+	pmd_clear(pmdp);
 	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
-	pte_t *pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pte_t *ptep = (pte_t *)pmd_page_vaddr(*pmdp);
 
-	pmd_clear(pmd);
+	pmd_clear(pmdp);
 
 	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
-	pte_free_kernel(NULL, pte);
+	pte_free_kernel(NULL, ptep);
 	return 1;
 }
 
-- 
2.39.2

