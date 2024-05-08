Return-Path: <linux-efi+bounces-1030-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB568C050D
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D571C20F3D
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE7130A50;
	Wed,  8 May 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZVRcCf0A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C232130A4A
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196652; cv=none; b=cnjqcGNhwXEa92lcIRPjdHBJZsnfceQrKw5C0oQ5FtQKc2DdgTQcnlAn0pfZGIoOCra02y3bhkegps0+MSHIBkpuyel2/tz7KgOTC4a64FQOYqNqSN2zsbexEVQBU6/WfVAPrGrl0D5Hipuo1fmnOnjJ0BRAG6ALi8Z3jvS73E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196652; c=relaxed/simple;
	bh=X5FE53OY3eT3DtMIjRJ8IEAc0okRiwSAW9RSi2xWEnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lf7zxBOKoN2yu8dtMIpieXW8ulF8af8Jsiq0NKd1M8moKamZEg0K4BmTRarppw0Iwe1F9YtVOnB+6KkZQJhvAYzB0CIcQobzHIqK1EeLDqT1KuAOTgwb1EWw1xVmXbaElXne+j64Gdb4sSBws7Hr7LvxfjWbGLn8WHKyq4y7xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZVRcCf0A; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e242b1df60so1921721fa.1
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196649; x=1715801449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1s8quCXzhpwj2tdUrwB8sMaHFPnndxHFKfGkIDXtWo=;
        b=ZVRcCf0A0JtRmQC5tZ3g4zKQr6HbvObjCzvt5zjAws+Ib9N2O08aoIkIQW6i2JyfFH
         HDneGWKxcmNtuxRwOhJRT7fovkmOS2ZFV0k28CvrXH0copGQ5e+IejRMW7yrqMvkSKjZ
         1NTYTs+qot57B7T/ki/bgnp8HB/WjQIHaGLAJP+7zLC+seKMErnAamn3IVlro5QewyJ0
         Sak9LIUjdee8kQAWccLgUs6jMyXSNKK2ePteSDUf0JhJJ4D0NhYJa4nKA+eMamCPMIxq
         K9s0KXy0gqieEyQraTU6W3M74GhVA5dd8Rzy/3vKk8hnDw2ZSb7FVYZwOAEwE5MusUi3
         l+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196649; x=1715801449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1s8quCXzhpwj2tdUrwB8sMaHFPnndxHFKfGkIDXtWo=;
        b=RWD489CjpghTIDs3bMHuAeuZkZu0U9aego0WYBDoEJu2pVKt7q+i2OqM3JuTjCIu67
         WU3Qrv7gJx3hEUAzEOypiF3LWE0vl67/W7wJa2qi1Ftnqvfqnkk5WWZrd4A5wlNwPdbU
         THZJxhCDNL7zJEfGNki47KJ6LenE7j2zIx9XMC5w4Lp4ux7FVJQ/S7nsR/D94vcn0MXu
         lYd5OYStGVtNKxHYTe78ByvsrAwBfIhAc2tFGdj25uAwjj1qbzfqv1S4zVJHIhwxg1iD
         wicKKgsPLX0KFeafIUMUJFsOPbJ0aA1oq8Co1g2+UiRJYUU09FBjn5V6+2Mu6Lkdj1nk
         OzLg==
X-Forwarded-Encrypted: i=1; AJvYcCXt3kqrT6DaHssd/0U6EdMO5ENb2jlIxuDmvDfh/tDKC65fImvAOTc0687oURUUZryydujP8Rzu1gKcFTarkRif5fYABK/1LizU
X-Gm-Message-State: AOJu0Ywj4utD1lKSZrcK8ifZp3GQq6v9XWCBgwCn2gpqrrm410Dt8oKp
	KDV8abCr1apl5sjfOtlnx2lPD1fypaKIBY1XKHo7bXHbRRKkuVdaaRTlUzPb4kc=
X-Google-Smtp-Source: AGHT+IGXrMpV3e8NWTuY3a54mvQHDm5XG0kBaIk0g0HXiaoXOXDbgZBz/5WZyQXp8WNGVe1a2PspPg==
X-Received: by 2002:a05:651c:1541:b0:2df:e192:47ec with SMTP id 38308e7fff4ca-2e447081ef2mr37890971fa.29.1715196648606;
        Wed, 08 May 2024 12:30:48 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c4e0f00b0041aa79f27a0sm3273819wmq.38.2024.05.08.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:30:48 -0700 (PDT)
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
Subject: [PATCH 11/12] mm, riscv, arm64: Use common ptep_set_wrprotect()/wrprotect_ptes() functions
Date: Wed,  8 May 2024 21:19:30 +0200
Message-Id: <20240508191931.46060-12-alexghiti@rivosinc.com>
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

Make riscv use the contpte aware ptep_set_wrprotect()/wrprotect_ptes()
function from arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 56 ++++++------------------
 arch/arm64/mm/contpte.c          | 18 --------
 arch/riscv/include/asm/pgtable.h | 25 +++++++++--
 include/linux/contpte.h          |  2 +
 mm/contpte.c                     | 75 +++++++++++++++++++++++++++++++-
 5 files changed, 110 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6591aab11c67..162efd9647dd 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1208,7 +1208,11 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
+/*
+ * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
+ */
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
 					unsigned long address, pte_t *ptep,
 					pte_t pte)
 {
@@ -1222,23 +1226,13 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
 	} while (pte_val(pte) != pte_val(old_pte));
 }
 
-/*
- * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
- * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
- */
-static inline void __ptep_set_wrprotect(struct mm_struct *mm,
-					unsigned long address, pte_t *ptep)
-{
-	___ptep_set_wrprotect(mm, address, ptep, __ptep_get(ptep));
-}
-
 static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
 				pte_t *ptep, unsigned int nr)
 {
 	unsigned int i;
 
 	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
-		__ptep_set_wrprotect(mm, address, ptep);
+		__ptep_set_wrprotect(mm, address, ptep, __ptep_get(ptep));
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1246,7 +1240,7 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pmd_t *pmdp)
 {
-	__ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
+	__ptep_set_wrprotect(mm, address, (pte_t *)pmdp, __ptep_get((pte_t *)pmdp));
 }
 
 #define pmdp_establish pmdp_establish
@@ -1389,8 +1383,6 @@ extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep,
 				unsigned int nr, int full);
-extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, unsigned int nr);
 
 #define pte_batch_hint pte_batch_hint
 static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
@@ -1478,35 +1470,12 @@ extern int ptep_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep);
 
 #define wrprotect_ptes wrprotect_ptes
-static __always_inline void wrprotect_ptes(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep, unsigned int nr)
-{
-	if (likely(nr == 1)) {
-		/*
-		 * Optimization: wrprotect_ptes() can only be called for present
-		 * ptes so we only need to check contig bit as condition for
-		 * unfold, and we can remove the contig bit from the pte we read
-		 * to avoid re-reading. This speeds up fork() which is sensitive
-		 * for order-0 folios. Equivalent to contpte_try_unfold().
-		 */
-		pte_t orig_pte = __ptep_get(ptep);
-
-		if (unlikely(pte_cont(orig_pte))) {
-			__contpte_try_unfold(mm, addr, ptep, orig_pte);
-			orig_pte = pte_mknoncont(orig_pte);
-		}
-		___ptep_set_wrprotect(mm, addr, ptep, orig_pte);
-	} else {
-		contpte_wrprotect_ptes(mm, addr, ptep, nr);
-	}
-}
+extern void wrprotect_ptes(struct mm_struct *mm,
+			   unsigned long addr, pte_t *ptep, unsigned int nr);
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep)
-{
-	wrprotect_ptes(mm, addr, ptep, 1);
-}
+extern void ptep_set_wrprotect(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
@@ -1528,7 +1497,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young			__ptep_clear_flush_young
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define ptep_set_wrprotect			__ptep_set_wrprotect
+#define ptep_set_wrprotect(mm, addr, ptep)					\
+			__ptep_set_wrprotect(mm, addr, ptep, __ptep_get(ptep))
 #define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 5675a61452ac..1cef93b15d6e 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -44,21 +44,3 @@ pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 	return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
 }
 EXPORT_SYMBOL_GPL(contpte_get_and_clear_full_ptes);
-
-void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, unsigned int nr)
-{
-	/*
-	 * If wrprotecting an entire contig range, we can avoid unfolding. Just
-	 * set wrprotect and wait for the later mmu_gather flush to invalidate
-	 * the tlb. Until the flush, the page may or may not be wrprotected.
-	 * After the flush, it is guaranteed wrprotected. If it's a partial
-	 * range though, we must unfold, because we can't have a case where
-	 * CONT_PTE is set but wrprotect applies to a subset of the PTEs; this
-	 * would cause it to continue to be unpredictable after the flush.
-	 */
-
-	contpte_try_unfold_partial(mm, addr, ptep, nr);
-	__wrprotect_ptes(mm, addr, ptep, nr);
-}
-EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b151a5aa4de8..728f31da5e6a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -755,11 +755,21 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 }
 
 static inline void __ptep_set_wrprotect(struct mm_struct *mm,
-					unsigned long address, pte_t *ptep)
+					unsigned long address, pte_t *ptep,
+					pte_t pte)
 {
 	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
 }
 
+static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
+				    pte_t *ptep, unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
+		__ptep_set_wrprotect(mm, address, ptep, __ptep_get(ptep));
+}
+
 static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
 					   unsigned long address, pte_t *ptep)
 {
@@ -807,6 +817,12 @@ extern int ptep_clear_flush_young(struct vm_area_struct *vma,
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
 				 pte_t entry, int dirty);
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+extern void ptep_set_wrprotect(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep);
+extern void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, unsigned int nr);
+#define wrprotect_ptes	wrprotect_ptes
 
 #else /* CONFIG_THP_CONTPTE */
 
@@ -822,12 +838,13 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma,
 #define ptep_clear_flush_young	__ptep_clear_flush_young
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags	__ptep_set_access_flags
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define ptep_set_wrprotect(mm, addr, ptep)					\
+			__ptep_set_wrprotect(mm, addr, ptep, __ptep_get(ptep))
+#define wrprotect_ptes		__wrprotect_ptes
 
 #endif /* CONFIG_THP_CONTPTE */
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define ptep_set_wrprotect	__ptep_set_wrprotect
-
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
 {
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
index 76244b0c678a..d1439db1706c 100644
--- a/include/linux/contpte.h
+++ b/include/linux/contpte.h
@@ -26,5 +26,7 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep,
 				  pte_t entry, int dirty);
+void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned int nr);
 
 #endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index 9cbbff1f67ad..fe36b6b1d20a 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -49,6 +49,8 @@
  *   - ptep_get_and_clear()
  *   - ptep_test_and_clear_young()
  *   - ptep_clear_flush_young()
+ *   - wrprotect_ptes()
+ *   - ptep_set_wrprotect()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -266,7 +268,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_t pte;
 
 	if (!pte_cont(__ptep_get(ptep))) {
-		__ptep_set_wrprotect(mm, addr, ptep);
+		__ptep_set_wrprotect(mm, addr, ptep, __ptep_get(ptep));
 		return;
 	}
 
@@ -832,4 +834,75 @@ __always_inline int ptep_set_access_flags(struct vm_area_struct *vma,
 
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
+
+static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep, unsigned int nr)
+{
+	/*
+	 * Unfold any partially covered contpte block at the beginning and end
+	 * of the range.
+	 */
+	size_t pgsize;
+	int ncontig;
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+
+	if (ptep != arch_contpte_align_down(ptep) || nr < ncontig)
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+	if (ptep + nr != arch_contpte_align_down(ptep + nr)) {
+		unsigned long last_addr = addr + pgsize * (nr - 1);
+		pte_t *last_ptep = ptep + nr - 1;
+
+		contpte_try_unfold(mm, last_addr, last_ptep,
+				   __ptep_get(last_ptep));
+	}
+}
+
+void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned int nr)
+{
+	/*
+	 * If wrprotecting an entire contig range, we can avoid unfolding. Just
+	 * set wrprotect and wait for the later mmu_gather flush to invalidate
+	 * the tlb. Until the flush, the page may or may not be wrprotected.
+	 * After the flush, it is guaranteed wrprotected. If it's a partial
+	 * range though, we must unfold, because we can't have a case where
+	 * CONT_PTE is set but wrprotect applies to a subset of the PTEs; this
+	 * would cause it to continue to be unpredictable after the flush.
+	 */
+
+	contpte_try_unfold_partial(mm, addr, ptep, nr);
+	__wrprotect_ptes(mm, addr, ptep, nr);
+}
+EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
+
+__always_inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
+{
+	if (likely(nr == 1)) {
+		/*
+		 * Optimization: wrprotect_ptes() can only be called for present
+		 * ptes so we only need to check contig bit as condition for
+		 * unfold, and we can remove the contig bit from the pte we read
+		 * to avoid re-reading. This speeds up fork() which is sensitive
+		 * for order-0 folios. Equivalent to contpte_try_unfold().
+		 */
+		pte_t orig_pte = __ptep_get(ptep);
+
+		if (unlikely(pte_cont(orig_pte))) {
+			__contpte_try_unfold(mm, addr, ptep, orig_pte);
+			orig_pte = pte_mknoncont(orig_pte);
+		}
+		__ptep_set_wrprotect(mm, addr, ptep, orig_pte);
+	} else {
+		contpte_wrprotect_ptes(mm, addr, ptep, nr);
+	}
+}
+
+__always_inline void ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep)
+{
+	wrprotect_ptes(mm, addr, ptep, 1);
+}
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


