Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2356B689151
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBCHym (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjBCHyl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:54:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCA921AA
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:54:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a2so3584139wrd.6
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p6730qGIPkioknL8TRnBkhBH8OCOBT9jGWzAP1Fd50=;
        b=p1jEDjMAIDo0UQBh3rO3OsgtGT8uLBjfHDSh1b+Z8cvlblWwjnUDFq5xDqdnJCbk+N
         qs9t4v3pUqEl/WWyECwzIQo+rmn69krbzEp/mWotjRysqXoBrSQ18apVaypJdWOi5A1i
         Ow3oNeLDKW/P7haj2dka8HjN4v/rWc+eq3AEWJHbFrYVisnc194ohvl2ZOaYN4pVsrNS
         yV4Tq5+OuKrzj9VUi6ptsISlNjoHjFazuRwkBxP4L0OEKGckbrHzMch8IC2uzh6AUM+o
         m7I9gb8fMTTYF0svhjmPH75OQDbt7JYUGnQ2qRc2TLIgZudVCxs+t8mGOYLvzlcwmGe/
         29Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p6730qGIPkioknL8TRnBkhBH8OCOBT9jGWzAP1Fd50=;
        b=aEQO/L9PZSO8SxO67p/6OB/wYtJom3ES1U2u9Hu6EgL9MlL4Y4D+KWJ2xvadQwuRv7
         ONzfbMo1dNk44LZibh2/85dMPpk1LPE0TDoggvTIPcy9q/mjHHgEqBqqnr+dusKGg/EJ
         oFiv2LFZ30vE+2N2HlPaqSwvNaCPHyszz3ovP7d+RNLfhBb9fbZcINL7zJ7Qo8vHR1vD
         jTZg1S3DTkztzvkLr+Cb3sxnX2egpPBLA5/DNFcHBEi/lOhKtsX0As0TIc0VVK2K7pjB
         2il4zddmRVBDSsI039vHfhk5jb9PTtliiXMoyN+K0NiNCKaXyb5mXa7gtFPJB4sLbdTZ
         HtgA==
X-Gm-Message-State: AO0yUKXf9ksSTc/XZJuEc0OKYxMkCLykvfVPCv8A4+UskbArJEyf3Omq
        OgIw74sfLbQQ0fLZ5C7YU46E5tKQXc+zFpBi
X-Google-Smtp-Source: AK7set/mMULLurdbm0Fs+kUt0K9x5XcL5v2oVCqPRJ4XiZv3foAVn9ZP1/iyPJYY8KzDOyP+2OPpXg==
X-Received: by 2002:adf:dfcc:0:b0:2c3:d65e:d12e with SMTP id q12-20020adfdfcc000000b002c3d65ed12emr833910wrn.71.1675410877592;
        Thu, 02 Feb 2023 23:54:37 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id t17-20020a0560001a5100b002bfb5618ee7sm1316284wry.91.2023.02.02.23.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:54:37 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 2/6] riscv: Rework kasan population functions
Date:   Fri,  3 Feb 2023 08:52:28 +0100
Message-Id: <20230203075232.274282-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Our previous kasan population implementation used to have the final kasan
shadow region mapped with kasan_early_shadow_page, because we did not clean
the early mapping and then we had to populate the kasan region "in-place"
which made the code cumbersome.

So now we clear the early mapping, establish a temporary mapping while we
populate the kasan shadow region with just the kernel regions that will
be used.

This new version uses the "generic" way of going through a page table
that may be folded at runtime (avoid the XXX_next macros).

It was tested with outline instrumentation on an Ubuntu kernel
configuration successfully.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/kasan_init.c | 361 +++++++++++++++++++------------------
 1 file changed, 183 insertions(+), 178 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 2a48eba6bd08..8fc0efcf905c 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -18,58 +18,48 @@
  * For sv39, the region is aligned on PGDIR_SIZE so we only need to populate
  * the page global directory with kasan_early_shadow_pmd.
  *
- * For sv48 and sv57, the region is not aligned on PGDIR_SIZE so the mapping
- * must be divided as follows:
- * - the first PGD entry, although incomplete, is populated with
- *   kasan_early_shadow_pud/p4d
- * - the PGD entries in the middle are populated with kasan_early_shadow_pud/p4d
- * - the last PGD entry is shared with the kernel mapping so populated at the
- *   lower levels pud/p4d
- *
- * In addition, when shallow populating a kasan region (for example vmalloc),
- * this region may also not be aligned on PGDIR size, so we must go down to the
- * pud level too.
+ * For sv48 and sv57, the region start is aligned on PGDIR_SIZE whereas the end
+ * region is not and then we have to go down to the PUD level.
  */
 
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
+pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
+pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
 
 static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
-	pte_t *ptep, *base_pte;
+	pte_t *ptep, *p;
 
-	if (pmd_none(*pmd))
-		base_pte = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
-	else
-		base_pte = (pte_t *)pmd_page_vaddr(*pmd);
+	if (pmd_none(*pmd)) {
+		p = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
+		set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(p)), PAGE_TABLE));
+	}
 
-	ptep = base_pte + pte_index(vaddr);
+	ptep = pte_offset_kernel(pmd, vaddr);
 
 	do {
 		if (pte_none(*ptep)) {
 			phys_addr = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 			set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
+			memset(__va(phys_addr), KASAN_SHADOW_INIT, PAGE_SIZE);
 		}
 	} while (ptep++, vaddr += PAGE_SIZE, vaddr != end);
-
-	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(base_pte)), PAGE_TABLE));
 }
 
 static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
-	pmd_t *pmdp, *base_pmd;
+	pmd_t *pmdp, *p;
 	unsigned long next;
 
 	if (pud_none(*pud)) {
-		base_pmd = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
-	} else {
-		base_pmd = (pmd_t *)pud_pgtable(*pud);
-		if (base_pmd == lm_alias(kasan_early_shadow_pmd))
-			base_pmd = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
+		p = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
+		set_pud(pud, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	pmdp = base_pmd + pmd_index(vaddr);
+	pmdp = pmd_offset(pud, vaddr);
 
 	do {
 		next = pmd_addr_end(vaddr, end);
@@ -78,43 +68,28 @@ static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned
 			phys_addr = memblock_phys_alloc(PMD_SIZE, PMD_SIZE);
 			if (phys_addr) {
 				set_pmd(pmdp, pfn_pmd(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				memset(__va(phys_addr), KASAN_SHADOW_INIT, PMD_SIZE);
 				continue;
 			}
 		}
 
 		kasan_populate_pte(pmdp, vaddr, next);
 	} while (pmdp++, vaddr = next, vaddr != end);
-
-	/*
-	 * Wait for the whole PGD to be populated before setting the PGD in
-	 * the page table, otherwise, if we did set the PGD before populating
-	 * it entirely, memblock could allocate a page at a physical address
-	 * where KASAN is not populated yet and then we'd get a page fault.
-	 */
-	set_pud(pud, pfn_pud(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
 }
 
-static void __init kasan_populate_pud(pgd_t *pgd,
+static void __init kasan_populate_pud(p4d_t *p4d,
 				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
-	pud_t *pudp, *base_pud;
+	pud_t *pudp, *p;
 	unsigned long next;
 
-	if (pgd_none(*pgd)) {
-		base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
-		memcpy(base_pud, (void *)kasan_early_shadow_pud,
-			sizeof(pud_t) * PTRS_PER_PUD);
-	} else {
-		base_pud = (pud_t *)pgd_page_vaddr(*pgd);
-		if (base_pud == lm_alias(kasan_early_shadow_pud)) {
-			base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
-			memcpy(base_pud, (void *)kasan_early_shadow_pud,
-			       sizeof(pud_t) * PTRS_PER_PUD);
-		}
+	if (p4d_none(*p4d)) {
+		p = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
+		set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	pudp = base_pud + pud_index(vaddr);
+	pudp = pud_offset(p4d, vaddr);
 
 	do {
 		next = pud_addr_end(vaddr, end);
@@ -123,37 +98,28 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 			phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
 			if (phys_addr) {
 				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				memset(__va(phys_addr), KASAN_SHADOW_INIT, PUD_SIZE);
 				continue;
 			}
 		}
 
 		kasan_populate_pmd(pudp, vaddr, next);
 	} while (pudp++, vaddr = next, vaddr != end);
-
-	/*
-	 * Wait for the whole PGD to be populated before setting the PGD in
-	 * the page table, otherwise, if we did set the PGD before populating
-	 * it entirely, memblock could allocate a page at a physical address
-	 * where KASAN is not populated yet and then we'd get a page fault.
-	 */
-	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
 }
 
 static void __init kasan_populate_p4d(pgd_t *pgd,
 				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
-	p4d_t *p4dp, *base_p4d;
+	p4d_t *p4dp, *p;
 	unsigned long next;
 
-	base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-	if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
-		base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
-		memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
-		       sizeof(p4d_t) * PTRS_PER_P4D);
+	if (pgd_none(*pgd)) {
+		p = memblock_alloc(PTRS_PER_P4D * sizeof(p4d_t), PAGE_SIZE);
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 	}
 
-	p4dp = base_p4d + p4d_index(vaddr);
+	p4dp = p4d_offset(pgd, vaddr);
 
 	do {
 		next = p4d_addr_end(vaddr, end);
@@ -162,34 +128,15 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 			phys_addr = memblock_phys_alloc(P4D_SIZE, P4D_SIZE);
 			if (phys_addr) {
 				set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				memset(__va(phys_addr), KASAN_SHADOW_INIT, P4D_SIZE);
 				continue;
 			}
 		}
 
-		kasan_populate_pud((pgd_t *)p4dp, vaddr, next);
+		kasan_populate_pud(p4dp, vaddr, next);
 	} while (p4dp++, vaddr = next, vaddr != end);
-
-	/*
-	 * Wait for the whole P4D to be populated before setting the P4D in
-	 * the page table, otherwise, if we did set the P4D before populating
-	 * it entirely, memblock could allocate a page at a physical address
-	 * where KASAN is not populated yet and then we'd get a page fault.
-	 */
-	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
 }
 
-#define kasan_early_shadow_pgd_next			(pgtable_l5_enabled ?	\
-				(uintptr_t)kasan_early_shadow_p4d :		\
-							(pgtable_l4_enabled ?	\
-				(uintptr_t)kasan_early_shadow_pud :		\
-				(uintptr_t)kasan_early_shadow_pmd))
-#define kasan_populate_pgd_next(pgdp, vaddr, next)				\
-		(pgtable_l5_enabled ?						\
-		kasan_populate_p4d(pgdp, vaddr, next) :				\
-		(pgtable_l4_enabled ?						\
-			kasan_populate_pud(pgdp, vaddr, next) :			\
-			kasan_populate_pmd((pud_t *)pgdp, vaddr, next)))
-
 static void __init kasan_populate_pgd(pgd_t *pgdp,
 				      unsigned long vaddr, unsigned long end)
 {
@@ -199,25 +146,86 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 	do {
 		next = pgd_addr_end(vaddr, end);
 
-		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE) {
-			if (pgd_page_vaddr(*pgdp) ==
-				   (unsigned long)lm_alias(kasan_early_shadow_pgd_next)) {
-				/*
-				 * pgdp can't be none since kasan_early_init
-				 * initialized all KASAN shadow region with
-				 * kasan_early_shadow_pud: if this is still the
-				 * case, that means we can try to allocate a
-				 * hugepage as a replacement.
-				 */
-				phys_addr = memblock_phys_alloc(PGDIR_SIZE, PGDIR_SIZE);
-				if (phys_addr) {
-					set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_KERNEL));
-					continue;
-				}
+		if (pgd_none(*pgdp) && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
+		    (next - vaddr) >= PGDIR_SIZE) {
+			phys_addr = memblock_phys_alloc(PGDIR_SIZE, PGDIR_SIZE);
+			if (phys_addr) {
+				set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				memset(__va(phys_addr), KASAN_SHADOW_INIT, PGDIR_SIZE);
+				continue;
 			}
 		}
 
-		kasan_populate_pgd_next(pgdp, vaddr, next);
+		kasan_populate_p4d(pgdp, vaddr, next);
+	} while (pgdp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_clear_pud(p4d_t *p4dp,
+					 unsigned long vaddr, unsigned long end)
+{
+	pud_t *pudp, *base_pud;
+	unsigned long next;
+
+	if (!pgtable_l4_enabled) {
+		pudp = (pud_t *)p4dp;
+	} else {
+		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
+		pudp = base_pud + pud_index(vaddr);
+	}
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE) {
+			pud_clear(pudp);
+			continue;
+		}
+
+		BUG();
+	} while (pudp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_clear_p4d(pgd_t *pgdp,
+					 unsigned long vaddr, unsigned long end)
+{
+	p4d_t *p4dp, *base_p4d;
+	unsigned long next;
+
+	if (!pgtable_l5_enabled) {
+		p4dp = (p4d_t *)pgdp;
+	} else {
+		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
+		p4dp = base_p4d + p4d_index(vaddr);
+	}
+
+	do {
+		next = p4d_addr_end(vaddr, end);
+
+		if (pgtable_l4_enabled && IS_ALIGNED(vaddr, P4D_SIZE) &&
+		    (next - vaddr) >= P4D_SIZE) {
+			p4d_clear(p4dp);
+			continue;
+		}
+
+		kasan_early_clear_pud(p4dp, vaddr, next);
+	} while (p4dp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_clear_pgd(pgd_t *pgdp,
+					 unsigned long vaddr, unsigned long end)
+{
+	unsigned long next;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+
+		if (pgtable_l5_enabled && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
+		    (next - vaddr) >= PGDIR_SIZE) {
+			pgd_clear(pgdp);
+			continue;
+		}
+
+		kasan_early_clear_p4d(pgdp, vaddr, next);
 	} while (pgdp++, vaddr = next, vaddr != end);
 }
 
@@ -362,117 +370,64 @@ static void __init kasan_populate(void *start, void *end)
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 
 	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend);
-
-	local_flush_tlb_all();
-	memset(start, KASAN_SHADOW_INIT, end - start);
-}
-
-static void __init kasan_shallow_populate_pmd(pgd_t *pgdp,
-					      unsigned long vaddr, unsigned long end)
-{
-	unsigned long next;
-	pmd_t *pmdp, *base_pmd;
-	bool is_kasan_pte;
-
-	base_pmd = (pmd_t *)pgd_page_vaddr(*pgdp);
-	pmdp = base_pmd + pmd_index(vaddr);
-
-	do {
-		next = pmd_addr_end(vaddr, end);
-		is_kasan_pte = (pmd_pgtable(*pmdp) == lm_alias(kasan_early_shadow_pte));
-
-		if (is_kasan_pte)
-			pmd_clear(pmdp);
-	} while (pmdp++, vaddr = next, vaddr != end);
 }
 
-static void __init kasan_shallow_populate_pud(pgd_t *pgdp,
+static void __init kasan_shallow_populate_pud(p4d_t *p4d,
 					      unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
-	pud_t *pudp, *base_pud;
-	pmd_t *base_pmd;
-	bool is_kasan_pmd;
-
-	base_pud = (pud_t *)pgd_page_vaddr(*pgdp);
-	pudp = base_pud + pud_index(vaddr);
+	void *p;
+	pud_t *pud_k = pud_offset(p4d, vaddr);
 
 	do {
 		next = pud_addr_end(vaddr, end);
-		is_kasan_pmd = (pud_pgtable(*pudp) == lm_alias(kasan_early_shadow_pmd));
 
-		if (!is_kasan_pmd)
-			continue;
-
-		base_pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		set_pud(pudp, pfn_pud(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
-
-		if (IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE)
+		if (pud_none(*pud_k)) {
+			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+			set_pud(pud_k, pfn_pud(PFN_DOWN(__pa(p)), PAGE_TABLE));
 			continue;
+		}
 
-		memcpy(base_pmd, (void *)kasan_early_shadow_pmd, PAGE_SIZE);
-		kasan_shallow_populate_pmd((pgd_t *)pudp, vaddr, next);
-	} while (pudp++, vaddr = next, vaddr != end);
+		BUG();
+	} while (pud_k++, vaddr = next, vaddr != end);
 }
 
-static void __init kasan_shallow_populate_p4d(pgd_t *pgdp,
+static void __init kasan_shallow_populate_p4d(pgd_t *pgd,
 					      unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
-	p4d_t *p4dp, *base_p4d;
-	pud_t *base_pud;
-	bool is_kasan_pud;
-
-	base_p4d = (p4d_t *)pgd_page_vaddr(*pgdp);
-	p4dp = base_p4d + p4d_index(vaddr);
+	void *p;
+	p4d_t *p4d_k = p4d_offset(pgd, vaddr);
 
 	do {
 		next = p4d_addr_end(vaddr, end);
-		is_kasan_pud = (p4d_pgtable(*p4dp) == lm_alias(kasan_early_shadow_pud));
-
-		if (!is_kasan_pud)
-			continue;
-
-		base_pud = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		set_p4d(p4dp, pfn_p4d(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
 
-		if (IS_ALIGNED(vaddr, P4D_SIZE) && (next - vaddr) >= P4D_SIZE)
+		if (p4d_none(*p4d_k)) {
+			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+			set_p4d(p4d_k, pfn_p4d(PFN_DOWN(__pa(p)), PAGE_TABLE));
 			continue;
+		}
 
-		memcpy(base_pud, (void *)kasan_early_shadow_pud, PAGE_SIZE);
-		kasan_shallow_populate_pud((pgd_t *)p4dp, vaddr, next);
-	} while (p4dp++, vaddr = next, vaddr != end);
+		kasan_shallow_populate_pud(p4d_k, vaddr, end);
+	} while (p4d_k++, vaddr = next, vaddr != end);
 }
 
-#define kasan_shallow_populate_pgd_next(pgdp, vaddr, next)			\
-		(pgtable_l5_enabled ?						\
-		kasan_shallow_populate_p4d(pgdp, vaddr, next) :			\
-		(pgtable_l4_enabled ?						\
-		kasan_shallow_populate_pud(pgdp, vaddr, next) :			\
-		kasan_shallow_populate_pmd(pgdp, vaddr, next)))
-
 static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
 	void *p;
 	pgd_t *pgd_k = pgd_offset_k(vaddr);
-	bool is_kasan_pgd_next;
 
 	do {
 		next = pgd_addr_end(vaddr, end);
-		is_kasan_pgd_next = (pgd_page_vaddr(*pgd_k) ==
-				     (unsigned long)lm_alias(kasan_early_shadow_pgd_next));
 
-		if (is_kasan_pgd_next) {
+		if (pgd_none(*pgd_k)) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
-		}
-
-		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE)
 			continue;
+		}
 
-		memcpy(p, (void *)kasan_early_shadow_pgd_next, PAGE_SIZE);
-		kasan_shallow_populate_pgd_next(pgd_k, vaddr, next);
+		kasan_shallow_populate_p4d(pgd_k, vaddr, next);
 	} while (pgd_k++, vaddr = next, vaddr != end);
 }
 
@@ -482,7 +437,37 @@ static void __init kasan_shallow_populate(void *start, void *end)
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 
 	kasan_shallow_populate_pgd(vaddr, vend);
-	local_flush_tlb_all();
+}
+
+static void create_tmp_mapping(void)
+{
+	void *ptr;
+	p4d_t *base_p4d;
+
+	/*
+	 * We need to clean the early mapping: this is hard to achieve "in-place",
+	 * so install a temporary mapping like arm64 and x86 do.
+	 */
+	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(pgd_t) * PTRS_PER_PGD);
+
+	/* Copy the last p4d since it is shared with the kernel mapping. */
+	if (pgtable_l5_enabled) {
+		ptr = (p4d_t *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
+		memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
+		set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
+			pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
+		base_p4d = tmp_p4d;
+	} else {
+		base_p4d = (p4d_t *)tmp_pg_dir;
+	}
+
+	/* Copy the last pud since it is shared with the kernel mapping. */
+	if (pgtable_l4_enabled) {
+		ptr = (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KASAN_SHADOW_END)));
+		memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
+		set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
+			pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
+	}
 }
 
 void __init kasan_init(void)
@@ -490,10 +475,27 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
-	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+	create_tmp_mapping();
+	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
+
+	kasan_early_clear_pgd(pgd_offset_k(KASAN_SHADOW_START),
+			      KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+	kasan_populate_early_shadow((void *)kasan_mem_to_shadow((void *)FIXADDR_START),
+				    (void *)kasan_mem_to_shadow((void *)VMALLOC_START));
+
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		kasan_shallow_populate(
 			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
 			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
+		/* Shallow populate modules and BPF which are vmalloc-allocated */
+		kasan_shallow_populate(
+			(void *)kasan_mem_to_shadow((void *)MODULES_VADDR),
+			(void *)kasan_mem_to_shadow((void *)MODULES_END));
+	} else {
+		kasan_populate_early_shadow((void *)kasan_mem_to_shadow((void *)VMALLOC_START),
+					    (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
+	}
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &p_start, &p_end) {
@@ -506,8 +508,8 @@ void __init kasan_init(void)
 		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
 	}
 
-	/* Populate kernel, BPF, modules mapping */
-	kasan_populate(kasan_mem_to_shadow((const void *)MODULES_VADDR),
+	/* Populate kernel */
+	kasan_populate(kasan_mem_to_shadow((const void *)MODULES_END),
 		       kasan_mem_to_shadow((const void *)MODULES_VADDR + SZ_2G));
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
@@ -518,4 +520,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+
+	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
+	local_flush_tlb_all();
 }
-- 
2.37.2

