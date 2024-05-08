Return-Path: <linux-efi+bounces-1021-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF68C04D5
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7300B1C21278
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC9130A5B;
	Wed,  8 May 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VFrJJXEb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E51E532
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196102; cv=none; b=hUZzudliITgpJ6jssG+SlSig48d2kjmG4g5Y1ReuvHOYcEGmsXV0R+6zuBKLf32xCEU9lNKYs0lQFfNl/YMtakqKS+/KNH7g38QQRAkm5aZH0uutvi5d8oO+PfcPVx+9W+H9sKkifn5EvxA5pWzCXL/SbkmVCwu9Nk1X1oATkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196102; c=relaxed/simple;
	bh=Gx0RIsI7B8XZZJpNjLh819bjvB+1D7QUoTMNOgRMWQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9lOYN05xeh0jeHKkcUIQbZdUEeBke89FzPg7o2xyTo0l6nK+EPnwyxbJFMqaqTID8V0j9KHDkAKqD6RHYPlPMiVfXaVLHX93njmPO6BrQJlATjxCxRUZVlk8ZyEUMF8LJVzdz9fkU8iT38HJbF9lrkB74oQvvDQJ7L8mK3pS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VFrJJXEb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df848f9325so1360041fa.1
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196097; x=1715800897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex1T8OVqbNmmxq9WLkEl/7It9+lEf4Ajscw14zap9bQ=;
        b=VFrJJXEb6l0FTn8s7HBOubh4nh/aFx/G0eMRTYYbf/w0eGl4133Zk7xTNDjHXFxrQR
         tJ1fetsY+Udn1BatudRBjzRlcag5/2c4o2o/DOUvuqJQFB5rlG9ywe/2HlwMyl25m8uh
         n67wKkQxwYq1y7lrGj6Fam6/T5BOmRtI6haftX4Q16jpYPzWrrp2x0IUubIFCOdl5ZrO
         tbm34UrVG6E1Q1Pi4ZsHnkuZ9XSoiob7bBmqcr9y3ewdok5XZznZVk9NWcgEcMFBJOMc
         4q9OvRACV9M5vSf19ik+R1Ie265W+qG3z4Uuoh++6qv+yOJavnlqLUivmrPdCf+k5DD9
         QT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196097; x=1715800897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex1T8OVqbNmmxq9WLkEl/7It9+lEf4Ajscw14zap9bQ=;
        b=D4lRQTAfEO61mQ1RFKmhwYmifHsM6GOW5cpoa7MU/UEK5uVYrr/cnwpkGRSRvwRZ+E
         qBtIKm/zaphVOvqIgDFq+5wjQTsIFzYs4k8y/F1MH1UY0ayxIq5pm08DQmWaATY9eQ5T
         OKPc78T3A/DkfNG3FeSlhwE1nWpraxHEaJSyV5GgfQ5JxRCPiBT80uZQNNbG3r883wLR
         m8RgX5eUn0jIO10EOrL7F6m9O0bX6mPzbL0wWhNkH0dvH10ase4ea1yU3C6He77vRL7z
         uTrzTzrUoU9LK766t4476gSrvtCmqdsG2/hd6pqdtUdQvy74PXnote3xxhbDvgvaxEIg
         vSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrTGTci4NI974gkUqqQ2bHufAlP7HWMF5XVxMLBJ1AJEKEzpvNOxyB1YtnGv7yP2yQr+X3jAHTSO/6+VyjLDzknMEvQS1MC4wS
X-Gm-Message-State: AOJu0Yz0wmxl4Ufh0yw0Dmv8fpa9GOMNP9VFtCbpFVNt9M82asFz2Ca+
	JhgwSG3EQgPhPz8n2mEGDT2QX1tciQamcxp1kmInAO29MdW2iqlTQ8JVsYMNB9I=
X-Google-Smtp-Source: AGHT+IFjgJRFJyj/slQR8FaD0MqHewWXYnSXcVKmWwkcfJ76gy4SFUv7AbGxIQbLfo1flUN0YcCWiw==
X-Received: by 2002:ac2:454b:0:b0:51c:8b45:c9fb with SMTP id 2adb3069b0e04-5217cd4b3e1mr2066413e87.69.1715196097125;
        Wed, 08 May 2024 12:21:37 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t18-20020a195f12000000b0051f95499c00sm2324036lfb.103.2024.05.08.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:21:36 -0700 (PDT)
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
Subject: [PATCH 02/12] mm, riscv, arm64: Use common ptep_get() function
Date: Wed,  8 May 2024 21:19:21 +0200
Message-Id: <20240508191931.46060-3-alexghiti@rivosinc.com>
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

Make riscv use the contpte aware ptep_get() function from arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 30 ++++++++++----------
 arch/arm64/mm/contpte.c          | 47 +++++---------------------------
 arch/arm64/mm/hugetlbpage.c      |  6 ++--
 arch/riscv/include/asm/kfence.h  |  4 +--
 arch/riscv/include/asm/pgtable.h | 22 +++++++++++++++
 arch/riscv/kernel/efi.c          |  2 +-
 arch/riscv/kvm/mmu.c             | 16 +++++------
 arch/riscv/mm/fault.c            |  2 +-
 arch/riscv/mm/kasan_init.c       |  2 +-
 arch/riscv/mm/pageattr.c         |  4 +--
 arch/riscv/mm/pgtable.c          |  4 +--
 include/linux/contpte.h          | 12 ++++++++
 mm/contpte.c                     | 45 ++++++++++++++++++++++++++++++
 13 files changed, 122 insertions(+), 74 deletions(-)
 create mode 100644 include/linux/contpte.h

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1758ce71fae9..a878735deb9f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -38,6 +38,7 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
+#include <linux/contpte.h>
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
@@ -1379,8 +1380,7 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
 extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte);
-extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
+				 pte_t *ptep, pte_t pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
@@ -1456,16 +1456,8 @@ static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
  * setting it in the pgtable.
  */
 
+extern pte_t ptep_get(pte_t *ptep);
 #define ptep_get ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	pte_t pte = __ptep_get(ptep);
-
-	if (likely(!pte_valid_cont(pte)))
-		return pte;
-
-	return contpte_ptep_get(ptep, pte);
-}
 
 #define ptep_get_lockless ptep_get_lockless
 static inline pte_t ptep_get_lockless(pte_t *ptep)
@@ -1659,9 +1651,10 @@ static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
 	 * find out the number of contiguous ptes.
 	 */
 	if (size == 0)
-		return find_num_contig(mm, addr, ptep, pgsize);
+		return mm ? find_num_contig(mm, addr, ptep, pgsize) : CONT_PTES;
 
-	*pgsize = size;
+	if (pgsize)
+		*pgsize = size;
 
 	switch (size) {
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -1674,11 +1667,13 @@ static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
 		contig_ptes = 1;
 		break;
 	case CONT_PMD_SIZE:
-		*pgsize = PMD_SIZE;
+		if (pgsize)
+			*pgsize = PMD_SIZE;
 		contig_ptes = CONT_PMDS;
 		break;
 	case CONT_PTE_SIZE:
-		*pgsize = PAGE_SIZE;
+		if (pgsize)
+			*pgsize = PAGE_SIZE;
 		contig_ptes = CONT_PTES;
 		break;
 	}
@@ -1686,6 +1681,11 @@ static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
 	return contig_ptes;
 }
 
+static inline pte_t *arch_contpte_align_down(pte_t *ptep)
+{
+	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..d5512ebb26e9 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -21,11 +21,6 @@ static inline bool mm_is_user(struct mm_struct *mm)
 	return mm != &init_mm;
 }
 
-static inline pte_t *contpte_align_down(pte_t *ptep)
-{
-	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
-}
-
 static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep, unsigned int nr)
 {
@@ -34,10 +29,10 @@ static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
 	 * of the range.
 	 */
 
-	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
+	if (ptep != arch_contpte_align_down(ptep) || nr < CONT_PTES)
 		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 
-	if (ptep + nr != contpte_align_down(ptep + nr)) {
+	if (ptep + nr != arch_contpte_align_down(ptep + nr)) {
 		unsigned long last_addr = addr + PAGE_SIZE * (nr - 1);
 		pte_t *last_ptep = ptep + nr - 1;
 
@@ -54,7 +49,7 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 	pte_t *start_ptep;
 	int i;
 
-	start_ptep = ptep = contpte_align_down(ptep);
+	start_ptep = ptep = arch_contpte_align_down(ptep);
 	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
 	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
 
@@ -122,7 +117,7 @@ void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
 	expected_pte = pfn_pte(pfn, prot);
 	orig_ptep = ptep;
-	ptep = contpte_align_down(ptep);
+	ptep = arch_contpte_align_down(ptep);
 
 	for (i = 0; i < CONT_PTES; i++) {
 		subpte = pte_mkold(pte_mkclean(__ptep_get(ptep)));
@@ -152,34 +147,6 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(__contpte_try_unfold);
 
-pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
-{
-	/*
-	 * Gather access/dirty bits, which may be populated in any of the ptes
-	 * of the contig range. We are guaranteed to be holding the PTL, so any
-	 * contiguous range cannot be unfolded or otherwise modified under our
-	 * feet.
-	 */
-
-	pte_t pte;
-	int i;
-
-	ptep = contpte_align_down(ptep);
-
-	for (i = 0; i < CONT_PTES; i++, ptep++) {
-		pte = __ptep_get(ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-
-	return orig_pte;
-}
-EXPORT_SYMBOL_GPL(contpte_ptep_get);
-
 pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 {
 	/*
@@ -214,7 +181,7 @@ pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 		return orig_pte;
 
 	orig_prot = pte_pgprot(pte_mkold(pte_mkclean(orig_pte)));
-	ptep = contpte_align_down(orig_ptep);
+	ptep = arch_contpte_align_down(orig_ptep);
 	pfn = pte_pfn(orig_pte) - (orig_ptep - ptep);
 
 	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
@@ -312,7 +279,7 @@ int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 	int young = 0;
 	int i;
 
-	ptep = contpte_align_down(ptep);
+	ptep = arch_contpte_align_down(ptep);
 	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
 
 	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
@@ -389,7 +356,7 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 		 * faults. Avoid per-page tlb flush in __ptep_set_access_flags()
 		 * and instead flush the whole range at the end.
 		 */
-		ptep = contpte_align_down(ptep);
+		ptep = arch_contpte_align_down(ptep);
 		start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
 
 		for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5869f20ca28e..083e80ac5790 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -101,12 +101,14 @@ int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	pud_t *pudp;
 	pmd_t *pmdp;
 
-	*pgsize = PAGE_SIZE;
+	if (pgsize)
+		*pgsize = PAGE_SIZE;
 	p4dp = p4d_offset(pgdp, addr);
 	pudp = pud_offset(p4dp, addr);
 	pmdp = pmd_offset(pudp, addr);
 	if ((pte_t *)pmdp == ptep) {
-		*pgsize = PMD_SIZE;
+		if (pgsize)
+			*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}
 	return CONT_PTES;
diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index 7388edd88986..f303fef8591c 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -18,9 +18,9 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	pte_t *pte = virt_to_kpte(addr);
 
 	if (protect)
-		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
+		set_pte(pte, __pte(pte_val(__ptep_get(pte)) & ~_PAGE_PRESENT));
 	else
-		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
+		set_pte(pte, __pte(pte_val(__ptep_get(pte)) | _PAGE_PRESENT));
 
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9e397935536e..8d05179f6bbe 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -299,6 +299,7 @@ static inline unsigned long pte_napot(pte_t pte)
 #define pte_cont	pte_napot
 
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
+#define pte_valid_cont		pte_valid_napot
 
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 {
@@ -571,6 +572,17 @@ static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
 
 	return size >> hugepage_shift;
 }
+
+static inline pte_t *arch_contpte_align_down(pte_t *ptep)
+{
+	pte_t __pte = READ_ONCE(*ptep);
+	int ncontig;
+
+	ncontig = napot_pte_num(napot_cont_order(__pte));
+
+	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
+}
+
 #endif
 
 static inline pte_t __ptep_get(pte_t *ptep)
@@ -696,8 +708,18 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#ifdef CONFIG_THP_CONTPTE
+
+extern pte_t ptep_get(pte_t *ptep);
+#define ptep_get ptep_get
+
+#else /* CONFIG_THP_CONTPTE */
+
 #define ptep_get		__ptep_get
 #define set_ptes		__set_ptes
+
+#endif /* CONFIG_THP_CONTPTE */
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
 #define pte_clear		__pte_clear
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
index b64bf1624a05..3d2a635c69ac 100644
--- a/arch/riscv/kernel/efi.c
+++ b/arch/riscv/kernel/efi.c
@@ -60,7 +60,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
-	pte_t pte = ptep_get(ptep);
+	pte_t pte = __ptep_get(ptep);
 	unsigned long val;
 
 	if (md->attribute & EFI_MEMORY_RO) {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index a9e2fd7245e1..70c6cb3864d6 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -103,7 +103,7 @@ static bool gstage_get_leaf_entry(struct kvm *kvm, gpa_t addr,
 	*ptep_level = current_level;
 	ptep = (pte_t *)kvm->arch.pgd;
 	ptep = &ptep[gstage_pte_index(addr, current_level)];
-	while (ptep && pte_val(ptep_get(ptep))) {
+	while (ptep && pte_val(__ptep_get(ptep))) {
 		if (gstage_pte_leaf(ptep)) {
 			*ptep_level = current_level;
 			*ptepp = ptep;
@@ -113,7 +113,7 @@ static bool gstage_get_leaf_entry(struct kvm *kvm, gpa_t addr,
 		if (current_level) {
 			current_level--;
 			*ptep_level = current_level;
-			ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+			ptep = (pte_t *)gstage_pte_page_vaddr(__ptep_get(ptep));
 			ptep = &ptep[gstage_pte_index(addr, current_level)];
 		} else {
 			ptep = NULL;
@@ -149,7 +149,7 @@ static int gstage_set_pte(struct kvm *kvm, u32 level,
 		if (gstage_pte_leaf(ptep))
 			return -EEXIST;
 
-		if (!pte_val(ptep_get(ptep))) {
+		if (!pte_val(__ptep_get(ptep))) {
 			if (!pcache)
 				return -ENOMEM;
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
@@ -160,7 +160,7 @@ static int gstage_set_pte(struct kvm *kvm, u32 level,
 		} else {
 			if (gstage_pte_leaf(ptep))
 				return -EEXIST;
-			next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+			next_ptep = (pte_t *)gstage_pte_page_vaddr(__ptep_get(ptep));
 		}
 
 		current_level--;
@@ -239,11 +239,11 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t addr,
 
 	BUG_ON(addr & (page_size - 1));
 
-	if (!pte_val(ptep_get(ptep)))
+	if (!pte_val(__ptep_get(ptep)))
 		return;
 
 	if (ptep_level && !gstage_pte_leaf(ptep)) {
-		next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+		next_ptep = (pte_t *)gstage_pte_page_vaddr(__ptep_get(ptep));
 		next_ptep_level = ptep_level - 1;
 		ret = gstage_level_to_page_size(next_ptep_level,
 						&next_page_size);
@@ -261,7 +261,7 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t addr,
 		if (op == GSTAGE_OP_CLEAR)
 			set_pte(ptep, __pte(0));
 		else if (op == GSTAGE_OP_WP)
-			set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
+			set_pte(ptep, __pte(pte_val(__ptep_get(ptep)) & ~_PAGE_WRITE));
 		gstage_remote_tlb_flush(kvm, ptep_level, addr);
 	}
 }
@@ -603,7 +603,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 				   &ptep, &ptep_level))
 		return false;
 
-	return pte_young(ptep_get(ptep));
+	return pte_young(__ptep_get(ptep));
 }
 
 int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3ba1d4dde5dd..0e08afc1fc6a 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -175,7 +175,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * silently loop forever.
 	 */
 	pte_k = pte_offset_kernel(pmd_k, addr);
-	if (!pte_present(ptep_get(pte_k))) {
+	if (!pte_present(__ptep_get(pte_k))) {
 		no_context(regs, addr);
 		return;
 	}
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c301c8d291d2..381d61f42ab8 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -39,7 +39,7 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
 	ptep = pte_offset_kernel(pmd, vaddr);
 
 	do {
-		if (pte_none(ptep_get(ptep))) {
+		if (pte_none(__ptep_get(ptep))) {
 			phys_addr = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 			set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
 			memset(__va(phys_addr), KASAN_SHADOW_INIT, PAGE_SIZE);
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 410056a50aa9..98c9dc4b983c 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -68,7 +68,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
 static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pte_t val = ptep_get(pte);
+	pte_t val = __ptep_get(pte);
 
 	val = __pte(set_pageattr_masks(pte_val(val), walk));
 	set_pte(pte, val);
@@ -435,5 +435,5 @@ bool kernel_page_present(struct page *page)
 		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
-	return pte_present(ptep_get(pte));
+	return pte_present(__ptep_get(pte));
 }
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index e86df7ef193c..5756bde9eb42 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,7 +9,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 			    unsigned long address, pte_t *ptep,
 			    pte_t entry, int dirty)
 {
-	if (!pte_same(ptep_get(ptep), entry))
+	if (!pte_same(__ptep_get(ptep), entry))
 		__set_pte_at(vma->vm_mm, ptep, entry);
 	/*
 	 * update_mmu_cache will unconditionally execute, handling both
@@ -22,7 +22,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long address,
 			      pte_t *ptep)
 {
-	if (!pte_young(ptep_get(ptep)))
+	if (!pte_young(__ptep_get(ptep)))
 		return 0;
 	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
 }
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
new file mode 100644
index 000000000000..46acac7222ca
--- /dev/null
+++ b/include/linux/contpte.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTPTE_H
+#define _LINUX_CONTPTE_H
+
+/*
+ * The contpte APIs are used to transparently manage the contiguous bit in ptes
+ * where it is possible and makes sense to do so. The PTE_CONT bit is considered
+ * a private implementation detail of the public ptep API (see below).
+ */
+pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
+
+#endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index 15791f6d9c41..d365356bbf92 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/pgtable.h>
 #include <linux/hugetlb.h>
+#include <linux/contpte.h>
 
 /*
  * Any arch that wants to use that needs to define:
@@ -17,6 +18,8 @@
  *   - __ptep_set_wrprotect()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
+ *   - pte_valid_cont()
+ *   - arch_contpte_align_down()
  */
 
 /*
@@ -28,6 +31,7 @@
  *   - huge_ptep_set_access_flags()
  *   - huge_ptep_set_wrprotect()
  *   - huge_ptep_clear_flush()
+ *   - ptep_get()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -270,3 +274,44 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
 	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
 }
+
+#ifdef CONFIG_THP_CONTPTE
+pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
+{
+	/*
+	 * Gather access/dirty bits, which may be populated in any of the ptes
+	 * of the contig range. We are guaranteed to be holding the PTL, so any
+	 * contiguous range cannot be unfolded or otherwise modified under our
+	 * feet.
+	 */
+
+	pte_t pte;
+	int i, ncontig;
+
+	ptep = arch_contpte_align_down(ptep);
+	ncontig = arch_contpte_get_num_contig(NULL, 0, ptep, 0, NULL);
+
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte = __ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+EXPORT_SYMBOL_GPL(contpte_ptep_get);
+
+__always_inline pte_t ptep_get(pte_t *ptep)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	if (likely(!pte_valid_cont(pte)))
+		return pte;
+
+	return contpte_ptep_get(ptep, pte);
+}
+#endif /* CONTPTE_THP_CONTPTE */
-- 
2.39.2


