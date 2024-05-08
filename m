Return-Path: <linux-efi+bounces-1022-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72A8C04DD
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558D5281ADE
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D06A347;
	Wed,  8 May 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jNZPJ6rF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D85130A48
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196163; cv=none; b=DRuwwAdtVTkRyTYHSgyL45hsQPwuLPSAyUoxAk81Pf4GuTWMDMKZzLxNpOB2eufFkpYPN4A3P5XOMQ4iatF8EoyKcEhatzshTfdiYJaFi6e8PcrG2PQtKj+HYdp0Dca7H0bdSQPfwuTWH7UKrBFVOwgYHjSFf3ZXD2MeNKKd99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196163; c=relaxed/simple;
	bh=PFaFqDeFlIMB7vX1AzN7hFS9D8gfzSUlM9G04s7s694=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjAKqn2HKA81j+5FxLrt8dqzs0Du3132XHyK9n9UD6gRKIrI9u4+DJ1aVRAHQ6pBPdrehW3c9bJjh/h0S1aPGfaMjbKXxnqm7Vg9ISV0+RfngrT1U2W3M4NpNph/RuQyWLLwgrbPXHBSBGhZMdnfVhl9+BpgzkiFaqFOzm+NXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jNZPJ6rF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so850655e9.0
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196159; x=1715800959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S8/CVFlZq+KrirwWJV8BSI4dNCVaFyTIK5dU7sIVgI=;
        b=jNZPJ6rFyXoLUh7GmYsQTobGohdDgqx7rgepaSAEn4qa7g30/F0dOnnWa4El74LK5A
         YfBp9z98aqDziIZ/1dG3za+QbcxVKo+yqL/sr69wRG3Qnegt4e1Bmxi3+QHYlAbRjZua
         2JVmYsv58O1PJq8mOeG46C5O26tWTkUwGDFFf0wbD1+D6pj69BvZfmYeAZTSwu8cGLxD
         Vae4w3Xg5QkIZhkz9QVVHtJQ+U8WFXvS0NTMS5VX0YSFEmc5qI6LJVWULwCIDZT2I02W
         Axw0fRUzGXDM+Hge7V+gbfD5NehITI6IqBX2y+YipbJRPiPY/aMZEJRvct6g8N01I3CD
         2Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196159; x=1715800959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S8/CVFlZq+KrirwWJV8BSI4dNCVaFyTIK5dU7sIVgI=;
        b=wkyaRC6iuYs7qSkjZP7KW9BsB3rT1oIiAKuOLrzif8BKOqTwm8L2VKWD8gBzH27l0r
         vvQRderauRgandNnkjQqSWqJlLemGFUKlUif+qcswPAjHHirvZ/648AOYrzc7s9LjtEX
         sfSRfDKq53dPjB0u6KEQyghDcVI37wFRXQK2fCnhPO1+CT699MhxEW3fXHtaYFOHSOPv
         /SQ0EaH/wXDFIW0cjOHD7EuqHVzvgSdL3cmYiBn1W718KCGvTzI1v3LQxf2pqhxMhQ+N
         jIdGpK9YvNDhjA5lSekTTt0sIpTYos3eOoVEAt+d8ymlBazpcAraSNRxPwrs9TnC3afj
         XsDg==
X-Forwarded-Encrypted: i=1; AJvYcCXVPU92CTHWLzGqbg5aSJcPyTQ+fKL/F6QIilpWQ0T/afxreAhkF9aXMehI96ji5T2kNSQn102ekgJZIYXkEAFuuj+LcjN/w7rR
X-Gm-Message-State: AOJu0YyrY3NwPAIGNjeIqOP8/Kks63OC5sg4ntwXzKHOGLBH+PECvgn3
	mwJw7g4VH2xescDtrdpASaUwK9gJvVlyP4FG7ndQTmg1dJZ/4gScGJvML3wVMrg=
X-Google-Smtp-Source: AGHT+IGv6186BLCsPjXiNHxvqIGGbP+8Nt6Ojq3omkEdJDigbcQHRKHJSnceRKhu854h+/CEdBxYBA==
X-Received: by 2002:a05:600c:3b83:b0:41b:4506:9fd with SMTP id 5b1f17b1804b1-41fbcb42dd6mr4932615e9.6.1715196158601;
        Wed, 08 May 2024 12:22:38 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0041bf7da4200sm3310028wmg.33.2024.05.08.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:22:38 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 03/12] mm, riscv, arm64: Use common set_ptes() function
Date: Wed,  8 May 2024 21:19:22 +0200
Message-Id: <20240508191931.46060-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508191931.46060-1-alexghiti@rivosinc.com>
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make riscv use the contpte aware set_ptes() function from arm64.

Note that riscv can support multiple contpte sizes so the arm64 code was
modified to take into account this possibility.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h |  88 ++++------
 arch/arm64/mm/contpte.c          | 162 ------------------
 arch/arm64/mm/mmu.c              |   2 +-
 arch/riscv/include/asm/pgtable.h |  76 +++++++++
 include/linux/contpte.h          |  10 ++
 mm/contpte.c                     | 277 ++++++++++++++++++++++++++++++-
 6 files changed, 398 insertions(+), 217 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a878735deb9f..e85b3a052a02 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -118,10 +118,17 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
-#define pte_cont_addr_end(addr, end)						\
-({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
-	(__boundary - 1 < (end) - 1) ? __boundary : (end);			\
-})
+static inline unsigned long arch_contpte_addr_end(unsigned long addr,
+						  unsigned long end,
+						  int *ncontig)
+{
+	unsigned long __boundary = (addr + CONT_PTE_SIZE) & CONT_PTE_MASK;
+
+	if (ncontig)
+		*ncontig = CONT_PTES;
+
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 
 #define pmd_cont_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + CONT_PMD_SIZE) & CONT_PMD_MASK;	\
@@ -1377,13 +1384,7 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
  * where it is possible and makes sense to do so. The PTE_CONT bit is considered
  * a private implementation detail of the public ptep API (see below).
  */
-extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte);
-extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-				 pte_t *ptep, pte_t pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
-extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte, unsigned int nr);
 extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr, int full);
 extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
@@ -1399,36 +1400,6 @@ extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
 
-static __always_inline void contpte_try_fold(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep, pte_t pte)
-{
-	/*
-	 * Only bother trying if both the virtual and physical addresses are
-	 * aligned and correspond to the last entry in a contig range. The core
-	 * code mostly modifies ranges from low to high, so this is the likely
-	 * the last modification in the contig range, so a good time to fold.
-	 * We can't fold special mappings, because there is no associated folio.
-	 */
-
-	const unsigned long contmask = CONT_PTES - 1;
-	bool valign = ((addr >> PAGE_SHIFT) & contmask) == contmask;
-
-	if (unlikely(valign)) {
-		bool palign = (pte_pfn(pte) & contmask) == contmask;
-
-		if (unlikely(palign &&
-		    pte_valid(pte) && !pte_cont(pte) && !pte_special(pte)))
-			__contpte_try_fold(mm, addr, ptep, pte);
-	}
-}
-
-static __always_inline void contpte_try_unfold(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep, pte_t pte)
-{
-	if (unlikely(pte_valid_cont(pte)))
-		__contpte_try_unfold(mm, addr, ptep, pte);
-}
-
 #define pte_batch_hint pte_batch_hint
 static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
 {
@@ -1485,20 +1456,9 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	__set_pte(ptep, pte_mknoncont(pte));
 }
 
+extern void set_ptes(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte, unsigned int nr);
 #define set_ptes set_ptes
-static __always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	pte = pte_mknoncont(pte);
-
-	if (likely(nr == 1)) {
-		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-		__set_ptes(mm, addr, ptep, pte, 1);
-		contpte_try_fold(mm, addr, ptep, pte);
-	} else {
-		contpte_set_ptes(mm, addr, ptep, pte, nr);
-	}
-}
 
 static inline void pte_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
@@ -1686,6 +1646,28 @@ static inline pte_t *arch_contpte_align_down(pte_t *ptep)
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 }
 
+static inline void arch_contpte_flush_tlb_range(struct vm_area_struct *vma,
+						unsigned long start,
+						unsigned long end,
+						unsigned long stride)
+{
+	__flush_tlb_range(vma, start, end, stride, true, 3);
+}
+
+static inline int arch_contpte_get_first_ncontig(size_t *pgsize)
+{
+	if (pgsize)
+		*pgsize = PAGE_SIZE;
+
+	return CONT_PTES;
+}
+
+/* Must return 0 when ncontig does not have any next. */
+static inline int arch_contpte_get_next_ncontig(int ncontig, size_t *pgsize)
+{
+	return 0;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index d5512ebb26e9..e225e458856e 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -8,19 +8,6 @@
 #include <linux/export.h>
 #include <asm/tlbflush.h>
 
-static inline bool mm_is_user(struct mm_struct *mm)
-{
-	/*
-	 * Don't attempt to apply the contig bit to kernel mappings, because
-	 * dynamically adding/removing the contig bit can cause page faults.
-	 * These racing faults are ok for user space, since they get serialized
-	 * on the PTL. But kernel mappings can't tolerate faults.
-	 */
-	if (unlikely(mm_is_efi(mm)))
-		return false;
-	return mm != &init_mm;
-}
-
 static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep, unsigned int nr)
 {
@@ -41,112 +28,6 @@ static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
-static void contpte_convert(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, pte_t pte)
-{
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	unsigned long start_addr;
-	pte_t *start_ptep;
-	int i;
-
-	start_ptep = ptep = arch_contpte_align_down(ptep);
-	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
-	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
-
-	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
-		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
-
-		if (pte_dirty(ptent))
-			pte = pte_mkdirty(pte);
-
-		if (pte_young(ptent))
-			pte = pte_mkyoung(pte);
-	}
-
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
-
-	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
-}
-
-void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-			pte_t *ptep, pte_t pte)
-{
-	/*
-	 * We have already checked that the virtual and pysical addresses are
-	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
-	 * remaining checks are to ensure that the contpte range is fully
-	 * covered by a single folio, and ensure that all the ptes are valid
-	 * with contiguous PFNs and matching prots. We ignore the state of the
-	 * access and dirty bits for the purpose of deciding if its a contiguous
-	 * range; the folding process will generate a single contpte entry which
-	 * has a single access and dirty bit. Those 2 bits are the logical OR of
-	 * their respective bits in the constituent pte entries. In order to
-	 * ensure the contpte range is covered by a single folio, we must
-	 * recover the folio from the pfn, but special mappings don't have a
-	 * folio backing them. Fortunately contpte_try_fold() already checked
-	 * that the pte is not special - we never try to fold special mappings.
-	 * Note we can't use vm_normal_page() for this since we don't have the
-	 * vma.
-	 */
-
-	unsigned long folio_start, folio_end;
-	unsigned long cont_start, cont_end;
-	pte_t expected_pte, subpte;
-	struct folio *folio;
-	struct page *page;
-	unsigned long pfn;
-	pte_t *orig_ptep;
-	pgprot_t prot;
-
-	int i;
-
-	if (!mm_is_user(mm))
-		return;
-
-	page = pte_page(pte);
-	folio = page_folio(page);
-	folio_start = addr - (page - &folio->page) * PAGE_SIZE;
-	folio_end = folio_start + folio_nr_pages(folio) * PAGE_SIZE;
-	cont_start = ALIGN_DOWN(addr, CONT_PTE_SIZE);
-	cont_end = cont_start + CONT_PTE_SIZE;
-
-	if (folio_start > cont_start || folio_end < cont_end)
-		return;
-
-	pfn = ALIGN_DOWN(pte_pfn(pte), CONT_PTES);
-	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
-	expected_pte = pfn_pte(pfn, prot);
-	orig_ptep = ptep;
-	ptep = arch_contpte_align_down(ptep);
-
-	for (i = 0; i < CONT_PTES; i++) {
-		subpte = pte_mkold(pte_mkclean(__ptep_get(ptep)));
-		if (!pte_same(subpte, expected_pte))
-			return;
-		expected_pte = pte_advance_pfn(expected_pte, 1);
-		ptep++;
-	}
-
-	pte = pte_mkcont(pte);
-	contpte_convert(mm, addr, orig_ptep, pte);
-}
-EXPORT_SYMBOL_GPL(__contpte_try_fold);
-
-void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-			pte_t *ptep, pte_t pte)
-{
-	/*
-	 * We have already checked that the ptes are contiguous in
-	 * contpte_try_unfold(), so just check that the mm is user space.
-	 */
-	if (!mm_is_user(mm))
-		return;
-
-	pte = pte_mknoncont(pte);
-	contpte_convert(mm, addr, ptep, pte);
-}
-EXPORT_SYMBOL_GPL(__contpte_try_unfold);
-
 pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 {
 	/*
@@ -204,49 +85,6 @@ pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 }
 EXPORT_SYMBOL_GPL(contpte_ptep_get_lockless);
 
-void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	unsigned long next;
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t prot;
-
-	/*
-	 * The set_ptes() spec guarantees that when nr > 1, the initial state of
-	 * all ptes is not-present. Therefore we never need to unfold or
-	 * otherwise invalidate a range before we set the new ptes.
-	 * contpte_set_ptes() should never be called for nr < 2.
-	 */
-	VM_WARN_ON(nr == 1);
-
-	if (!mm_is_user(mm))
-		return __set_ptes(mm, addr, ptep, pte, nr);
-
-	end = addr + (nr << PAGE_SHIFT);
-	pfn = pte_pfn(pte);
-	prot = pte_pgprot(pte);
-
-	do {
-		next = pte_cont_addr_end(addr, end);
-		nr = (next - addr) >> PAGE_SHIFT;
-		pte = pfn_pte(pfn, prot);
-
-		if (((addr | next | (pfn << PAGE_SHIFT)) & ~CONT_PTE_MASK) == 0)
-			pte = pte_mkcont(pte);
-		else
-			pte = pte_mknoncont(pte);
-
-		__set_ptes(mm, addr, ptep, pte, nr);
-
-		addr = next;
-		ptep += nr;
-		pfn += nr;
-
-	} while (addr != end);
-}
-EXPORT_SYMBOL_GPL(contpte_set_ptes);
-
 void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr, int full)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 495b732d5af3..b7ad732660aa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -222,7 +222,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	do {
 		pgprot_t __prot = prot;
 
-		next = pte_cont_addr_end(addr, end);
+		next = arch_contpte_addr_end(addr, end, NULL);
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8d05179f6bbe..ebfe6b16529e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -301,6 +301,20 @@ static inline unsigned long pte_napot(pte_t pte)
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
 #define pte_valid_cont		pte_valid_napot
 
+/*
+ * contpte is what we expose to the core mm code, this is not exactly a napot
+ * mapping since the size is not encoded in the pfn yet.
+ */
+static inline pte_t pte_mknoncont(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_NAPOT);
+}
+
+static inline pte_t pte_mkcont(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_NAPOT);
+}
+
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 {
 	int pos = order - 1 + _PAGE_PFN_SHIFT;
@@ -329,6 +343,11 @@ static inline unsigned long pte_napot(pte_t pte)
 
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	return __pgprot(pte_val(pte) & ~_PAGE_PFN_MASK);
+}
+
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -354,6 +373,11 @@ static inline int pte_present(pte_t pte)
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 
+static inline int pte_valid(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT);
+}
+
 static inline int pte_none(pte_t pte)
 {
 	return (pte_val(pte) == 0);
@@ -583,6 +607,55 @@ static inline pte_t *arch_contpte_align_down(pte_t *ptep)
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
 }
 
+static inline void arch_contpte_flush_tlb_range(struct vm_area_struct *vma,
+						unsigned long start,
+						unsigned long end,
+						unsigned long stride)
+{
+	flush_tlb_mm_range(vma->vm_mm, start, end, stride);
+}
+
+static inline int arch_contpte_get_first_ncontig(size_t *pgsize)
+{
+	if (pgsize)
+		*pgsize = PAGE_SIZE;
+
+	return 1 << NAPOT_CONT64KB_ORDER;
+}
+
+/* Must return 0 when ncontig does not have any next. */
+static inline int arch_contpte_get_next_ncontig(int ncontig, size_t *pgsize)
+{
+	return 0;
+}
+
+#define for_each_contpte_order_rev(ncontig, order, pgsize)				\
+	for (pgsize = PAGE_SIZE, order = NAPOT_ORDER_MAX - 1, ncontig = BIT(order);	\
+	     ncontig >= BIT(NAPOT_CONT_ORDER_BASE);					\
+	     order--, ncontig = BIT(order))
+
+static inline unsigned long arch_contpte_addr_end(unsigned long addr,
+						  unsigned long end,
+						  int *ncontig)
+{
+	unsigned long contpte_saddr, contpte_eaddr, contpte_size;
+	size_t pgsize;
+	int contig, order;
+
+	for_each_contpte_order_rev(contig, order, pgsize) {
+		contpte_size = contig * pgsize;
+		contpte_saddr = ALIGN_DOWN(addr, contpte_size);
+		contpte_eaddr = contpte_saddr + contpte_size;
+
+		if (contpte_saddr >= addr && contpte_eaddr <= end) {
+			*ncontig = contig;
+			return contpte_eaddr;
+		}
+	}
+
+	*ncontig = 0;
+	return end;
+}
 #endif
 
 static inline pte_t __ptep_get(pte_t *ptep)
@@ -712,6 +785,9 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 
 extern pte_t ptep_get(pte_t *ptep);
 #define ptep_get ptep_get
+extern void set_ptes(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pteval, unsigned int nr);
+#define set_ptes set_ptes
 
 #else /* CONFIG_THP_CONTPTE */
 
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
index 46acac7222ca..54d10204e9af 100644
--- a/include/linux/contpte.h
+++ b/include/linux/contpte.h
@@ -8,5 +8,15 @@
  * a private implementation detail of the public ptep API (see below).
  */
 pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
+void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte);
+void contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pte);
+void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t pte);
+void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte);
+void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pte, unsigned int nr);
 
 #endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index d365356bbf92..566745d7842f 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -7,6 +7,7 @@
 #include <linux/pgtable.h>
 #include <linux/hugetlb.h>
 #include <linux/contpte.h>
+#include <linux/efi.h>
 
 /*
  * Any arch that wants to use that needs to define:
@@ -20,6 +21,14 @@
  *   - arch_contpte_get_num_contig()
  *   - pte_valid_cont()
  *   - arch_contpte_align_down()
+ *   - arch_contpte_flush_tlb_range()
+ *   - arch_contpte_get_first_ncontig()
+ *   - arch_contpte_get_next_ncontig()
+ *   - arch_contpte_addr_end()
+ *   - pte_mkcont()
+ *   - pte_mknoncont()
+ *   - pte_valid()
+ *   - pte_pgprot()
  */
 
 /*
@@ -32,6 +41,7 @@
  *   - huge_ptep_set_wrprotect()
  *   - huge_ptep_clear_flush()
  *   - ptep_get()
+ *   - set_ptes()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -314,4 +324,269 @@ __always_inline pte_t ptep_get(pte_t *ptep)
 
 	return contpte_ptep_get(ptep, pte);
 }
-#endif /* CONTPTE_THP_CONTPTE */
+EXPORT_SYMBOL_GPL(ptep_get);
+
+static inline bool mm_is_user(struct mm_struct *mm)
+{
+	/*
+	 * Don't attempt to apply the contig bit to kernel mappings, because
+	 * dynamically adding/removing the contig bit can cause page faults.
+	 * These racing faults are ok for user space, since they get serialized
+	 * on the PTL. But kernel mappings can't tolerate faults.
+	 */
+	if (unlikely(mm_is_efi(mm)))
+		return false;
+	return mm != &init_mm;
+}
+
+static void contpte_convert(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, pte_t pte,
+			    int ncontig, size_t pgsize)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long start_addr;
+	pte_t *start_ptep;
+	int i;
+
+	start_addr = addr;
+	start_ptep = ptep;
+
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize) {
+		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
+
+		if (pte_dirty(ptent))
+			pte = pte_mkdirty(pte);
+
+		if (pte_young(ptent))
+			pte = pte_mkyoung(pte);
+	}
+
+	arch_contpte_flush_tlb_range(&vma, start_addr, addr, pgsize);
+
+	__set_ptes(mm, start_addr, start_ptep, pte, ncontig);
+}
+
+void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t pte)
+{
+	unsigned long start_addr;
+	pte_t *start_ptep;
+	size_t pgsize;
+	int ncontig;
+
+	/*
+	 * We have already checked that the ptes are contiguous in
+	 * contpte_try_unfold(), so just check that the mm is user space.
+	 */
+	if (!mm_is_user(mm))
+		return;
+
+	pte = pte_mknoncont(pte);
+	start_ptep = arch_contpte_align_down(ptep);
+	ncontig = arch_contpte_get_num_contig(mm, addr, start_ptep, 0, &pgsize);
+	start_addr = ALIGN_DOWN(addr, ncontig * pgsize);
+	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), ncontig), pte_pgprot(pte));
+
+	contpte_convert(mm, start_addr, start_ptep, pte, ncontig, pgsize);
+}
+
+__always_inline void contpte_try_unfold(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep,
+					pte_t pte)
+{
+	if (unlikely(pte_valid_cont(pte)))
+		__contpte_try_unfold(mm, addr, ptep, pte);
+}
+EXPORT_SYMBOL_GPL(contpte_try_unfold);
+
+static bool contpte_is_last_pte(unsigned long addr, pte_t pte, int ncontig)
+{
+	const unsigned long contmask = ncontig - 1;
+	bool valign = ((addr >> PAGE_SHIFT) & contmask) == contmask;
+
+	if (unlikely(valign)) {
+		bool palign = (pte_pfn(pte) & contmask) == contmask;
+
+		if (unlikely(palign &&
+		    pte_valid(pte) && !pte_cont(pte) && !pte_special(pte)))
+			return true;
+	}
+
+	return false;
+}
+
+void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte)
+{
+	/*
+	 * We have already checked that the virtual and pysical addresses are
+	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
+	 * remaining checks are to ensure that the contpte range is fully
+	 * covered by a single folio, and ensure that all the ptes are valid
+	 * with contiguous PFNs and matching prots. We ignore the state of the
+	 * access and dirty bits for the purpose of deciding if its a contiguous
+	 * range; the folding process will generate a single contpte entry which
+	 * has a single access and dirty bit. Those 2 bits are the logical OR of
+	 * their respective bits in the constituent pte entries. In order to
+	 * ensure the contpte range is covered by a single folio, we must
+	 * recover the folio from the pfn, but special mappings don't have a
+	 * folio backing them. Fortunately contpte_try_fold() already checked
+	 * that the pte is not special - we never try to fold special mappings.
+	 * Note we can't use vm_normal_page() for this since we don't have the
+	 * vma.
+	 */
+
+	unsigned long folio_start, folio_end;
+	unsigned long cont_start, cont_end;
+	pte_t expected_pte, subpte;
+	struct folio *folio;
+	struct page *page;
+	unsigned long pfn;
+	pte_t *cur_ptep;
+	pgprot_t prot;
+	size_t pgsize;
+	int i, ncontig, ncontig_prev;
+
+	if (!mm_is_user(mm))
+		return;
+
+	page = pte_page(pte);
+	folio = page_folio(page);
+	folio_start = addr - (page - &folio->page) * PAGE_SIZE;
+	folio_end = folio_start + folio_nr_pages(folio) * PAGE_SIZE;
+
+	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
+	ncontig_prev = 0;
+	ncontig = arch_contpte_get_first_ncontig(&pgsize);
+
+	do {
+		/* Make sure we still belong to the same folio */
+		cont_start = ALIGN_DOWN(addr, ncontig * pgsize);
+		cont_end = cont_start + ncontig * pgsize;
+
+		if (folio_start > cont_start || folio_end < cont_end)
+			break;
+
+		pfn = ALIGN_DOWN(pte_pfn(pte), ncontig);
+		expected_pte = pfn_pte(pfn, prot);
+		cur_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
+
+		/*
+		 * Either the region is already a contpte mapping or make sure
+		 * the ptes belong to a contpte region.
+		 */
+		if (!pte_valid_cont(__ptep_get(cur_ptep))) {
+			for (i = 0; i < ncontig - ncontig_prev; i++) {
+				subpte = pte_mkold(pte_mkclean(__ptep_get(cur_ptep)));
+				if (!pte_same(subpte, expected_pte))
+					goto out;
+				expected_pte = pte_advance_pfn(expected_pte, 1);
+				cur_ptep++;
+			}
+		}
+
+		/*
+		 * Compute the next contpte region to check: avoid checking
+		 * the same region again by only checking the "second-half"
+		 * (the "region buddy") of the current region, which keeps the
+		 * whole thing in O(n).
+		 */
+		ncontig_prev = ncontig;
+		ncontig = arch_contpte_get_next_ncontig(ncontig, &pgsize);
+		/* set_ptes spec states that "The PTEs are all in the same PMD" */
+		if (!ncontig || pgsize > PAGE_SIZE)
+			break;
+	} while (contpte_is_last_pte(addr, pte, ncontig));
+
+out:
+	if (!ncontig_prev)
+		return;
+
+	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig_prev);
+	cont_start = ALIGN_DOWN(addr, ncontig_prev * PAGE_SIZE);
+	pte = pte_mkcont(pte);
+	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), ncontig_prev), pte_pgprot(pte));
+
+	contpte_convert(mm, cont_start, ptep, pte, ncontig_prev, PAGE_SIZE);
+}
+EXPORT_SYMBOL_GPL(__contpte_try_fold);
+
+__always_inline void contpte_try_fold(struct mm_struct *mm,
+				      unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	/*
+	 * Only bother trying if both the virtual and physical addresses are
+	 * aligned and correspond to the last entry in a contig range. The core
+	 * code mostly modifies ranges from low to high, so this is the likely
+	 * the last modification in the contig range, so a good time to fold.
+	 * We can't fold special mappings, because there is no associated folio.
+	 *
+	 * Only test if the first ncontig is aligned, because it can't be the
+	 * last pte of a size larger than the first ncontig and not the last
+	 * of the first ncontig.
+	 */
+	int ncontig = arch_contpte_get_first_ncontig(NULL);
+
+	if (contpte_is_last_pte(addr, pte, ncontig))
+		__contpte_try_fold(mm, addr, ptep, pte);
+}
+
+void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	unsigned long contmask;
+	unsigned long next;
+	unsigned long end;
+	unsigned long pfn;
+	pgprot_t prot;
+	int ncontig;
+
+	/*
+	 * The set_ptes() spec guarantees that when nr > 1, the initial state of
+	 * all ptes is not-present. Therefore we never need to unfold or
+	 * otherwise invalidate a range before we set the new ptes.
+	 * contpte_set_ptes() should never be called for nr < 2.
+	 */
+	VM_WARN_ON(nr == 1);
+
+	if (!mm_is_user(mm))
+		return __set_ptes(mm, addr, ptep, pte, nr);
+
+	end = addr + (nr << PAGE_SHIFT);
+	pfn = pte_pfn(pte);
+	prot = pte_pgprot(pte);
+
+	do {
+		next = arch_contpte_addr_end(addr, end, &ncontig);
+		nr = (next - addr) >> PAGE_SHIFT;
+		pte = pfn_pte(pfn, prot);
+		contmask = (ncontig << PAGE_SHIFT) - 1;
+
+		if (ncontig && ((addr | next | (pfn << PAGE_SHIFT)) & contmask) == 0)
+			pte = pte_mkcont(pte);
+		else
+			pte = pte_mknoncont(pte);
+
+		__set_ptes(mm, addr, ptep, pte, nr);
+
+		addr = next;
+		ptep += nr;
+		pfn += nr;
+	} while (addr != end);
+}
+EXPORT_SYMBOL_GPL(contpte_set_ptes);
+
+__always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	pte = pte_mknoncont(pte);
+
+	if (likely(nr == 1)) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		__set_ptes(mm, addr, ptep, pte, 1);
+		contpte_try_fold(mm, addr, ptep, pte);
+	} else {
+		contpte_set_ptes(mm, addr, ptep, pte, nr);
+	}
+}
+#endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


