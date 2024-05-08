Return-Path: <linux-efi+bounces-1027-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDB8C04FE
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C441D1F22C7E
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765C130A4B;
	Wed,  8 May 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uDgDcuRt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB0130AF6
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196468; cv=none; b=MPHbfGWt5LRs5RQYujuQo+ENQxEceQ4XN7MBsKEOJMtTSKV8+2xhgJ5rjHN1IDstBnZ+CeusSYsjK5I8/5ondnHIKI+1gT2kqcfgEf7Z0WwIvUIhrB3Eo1KysXGQN1FZwm8kiYIX59BM8XMyCmr3DQIP9jKikeNoxsy4WgfehLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196468; c=relaxed/simple;
	bh=fOzCgUszZM7Ia/o3+z4qKk//tXf0jL7dlyhhquBMlIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4rcvY+uuPzAvf0V8vr0fjSidm0BxHIkwyWaed4pjfw8bqTtc++/Xco738/NqStpLboyaSnJ9L1pzdqs5WPfA1bm123K8Rlr88PZb5DFynrw1UMWcWipmYpOlveVyKtSek9FO+vk4mTGd9TS0GaMSU+uHUlJhmOL2hWts4m0j+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uDgDcuRt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso795155e9.1
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196465; x=1715801265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcfQWqIQyCa6XQTZ9KciN3KqArzYv/m686IwSCSxNEA=;
        b=uDgDcuRtTvm9m3D+w86APkoYdhYqkvs6RxZh4OeLBg18aFyr23xmNblQ8aApDQ6PXg
         Dl6ARNN9s2UQb/Gu94FASDY/ISLfl+e4u1JrjwAZE4+k6ubUr0/ALvNq5SbkZtZG3C1H
         Xm/GcjWUhiLGVWaurHbONDYNeM5FuCabausMVIj+4sVe9skWpam5XFYYpICr2S9eAurs
         LdY3qAC8kqFx8p6kkmCez6RVJjB9FO/NEseDzvPmveDC1v5PswWcq0VNUv0iHjNr4Szk
         kYoKQ864g20JH2q+bTpoRpY/tf1CfFbVAtTyu0Fq6fzoX46FI72n9wqLhW8SkCf7V5cc
         l69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196465; x=1715801265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcfQWqIQyCa6XQTZ9KciN3KqArzYv/m686IwSCSxNEA=;
        b=mjReA7iEUuFxeHLM8umkj2sBFMSWMP2udRroO7yQe+bpw9r56bHi1OD6+zvIv1D26Q
         ERpK41RZt8aecY3LIqeARQI8y9+TX2hIhlqpr9DhwZyrOJcLXNwpzDNJVPBgDD34mZJJ
         b9syUL8ArjTUK0URFsw3dDF4aF1c9I+Ibiq0uYFmhpKPcxeJPs46uBMnEklZuridZ2ev
         hKUC2peduy+KuN2hRnz/6D9jxBDQxD2ZppEA1Ft6SamZrfInqAbSUf1tqg0wIXxu/XGZ
         NUIf325crSQ2ThAVH5k/VKfxkqWbC+bD+Ik3izQAPStnFhV+VoU92disrYmLSDWvVkvc
         MQRA==
X-Forwarded-Encrypted: i=1; AJvYcCXLxNf/uHtgoxc4XNGJoU95C1BX7tK/BsU8vQB9hySrf27IpuxKTPcP5yvsQRuJUL+MoIfBu+k9iwkZ/q4SzG6l5JlwA22FU9tL
X-Gm-Message-State: AOJu0Yx4V2vam2ZRYYnVezVo0vuaCafzK+aptcm3uekKVap+TCBYRLnt
	jBptRSRu2jert4GnCrE+pCaR75/MEphZVOpFCLY9j+TVhLFdIsd96bTMcopY0kM=
X-Google-Smtp-Source: AGHT+IG713uLBQWbwM0MRsX1LOPSAYD3hwSeYc9+OS0/mfL1VayM0FBzmqDZCPlWciEj7G1Kaomx7g==
X-Received: by 2002:a05:600c:3103:b0:41b:f43b:e263 with SMTP id 5b1f17b1804b1-41fbc12bdcbmr5274575e9.0.1715196465070;
        Wed, 08 May 2024 12:27:45 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c24f8fsm33175985e9.15.2024.05.08.12.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:27:44 -0700 (PDT)
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
Subject: [PATCH 08/12] mm, riscv, arm64: Use common ptep_test_and_clear_young() function
Date: Wed,  8 May 2024 21:19:27 +0200
Message-Id: <20240508191931.46060-9-alexghiti@rivosinc.com>
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

Make riscv use the contpte aware ptep_test_and_clear_young() function from
arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 14 ++----------
 arch/arm64/mm/contpte.c          | 25 --------------------
 arch/riscv/include/asm/pgtable.h | 12 ++++++----
 arch/riscv/kvm/mmu.c             |  2 +-
 arch/riscv/mm/pgtable.c          |  2 +-
 include/linux/contpte.h          |  2 ++
 mm/contpte.c                     | 39 ++++++++++++++++++++++++++++++++
 7 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ff7fe1d9cabe..9a8702d1ad00 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1389,8 +1389,6 @@ extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep,
 				unsigned int nr, int full);
-extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
@@ -1477,16 +1475,8 @@ extern pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep)
-{
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (likely(!pte_valid_cont(orig_pte)))
-		return __ptep_test_and_clear_young(vma, addr, ptep);
-
-	return contpte_ptep_test_and_clear_young(vma, addr, ptep);
-}
+extern int ptep_test_and_clear_young(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 5e9e40145085..9bf471633ca4 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -45,31 +45,6 @@ pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(contpte_get_and_clear_full_ptes);
 
-int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
-					unsigned long addr, pte_t *ptep)
-{
-	/*
-	 * ptep_clear_flush_young() technically requires us to clear the access
-	 * flag for a _single_ pte. However, the core-mm code actually tracks
-	 * access/dirty per folio, not per page. And since we only create a
-	 * contig range when the range is covered by a single folio, we can get
-	 * away with clearing young for the whole contig range here, so we avoid
-	 * having to unfold.
-	 */
-
-	int young = 0;
-	int i;
-
-	ptep = arch_contpte_align_down(ptep);
-	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
-
-	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
-		young |= __ptep_test_and_clear_young(vma, addr, ptep);
-
-	return young;
-}
-EXPORT_SYMBOL_GPL(contpte_ptep_test_and_clear_young);
-
 int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 03cd640137ed..d39cb24c6c4a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -739,8 +739,7 @@ static inline void __pte_clear(struct mm_struct *mm,
 
 extern int __ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				   pte_t *ptep, pte_t entry, int dirty);
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c */
-extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
+extern int __ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
 				     pte_t *ptep);
 
 static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
@@ -778,7 +777,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	 * shouldn't really matter because there's no real memory
 	 * pressure for swapout to react to. ]
 	 */
-	return ptep_test_and_clear_young(vma, address, ptep);
+	return __ptep_test_and_clear_young(vma, address, ptep);
 }
 
 #ifdef CONFIG_THP_CONTPTE
@@ -797,6 +796,9 @@ extern void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 extern pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+extern int ptep_test_and_clear_young(struct vm_area_struct *vma,
+				     unsigned long addr, pte_t *ptep);
 
 #else /* CONFIG_THP_CONTPTE */
 
@@ -806,6 +808,8 @@ extern pte_t ptep_get_and_clear(struct mm_struct *mm,
 #define pte_clear		__pte_clear
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young	__ptep_test_and_clear_young
 
 #endif /* CONFIG_THP_CONTPTE */
 
@@ -987,7 +991,7 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp)
 {
-	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+	return __ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
 }
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 1ee6139d495f..554926e33760 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -585,7 +585,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 				   &ptep, &ptep_level))
 		return false;
 
-	return ptep_test_and_clear_young(NULL, 0, ptep);
+	return __ptep_test_and_clear_young(NULL, 0, ptep);
 }
 
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 5756bde9eb42..5f31d0594109 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -18,7 +18,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-int ptep_test_and_clear_young(struct vm_area_struct *vma,
+int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long address,
 			      pte_t *ptep)
 {
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
index 01da4bfc3af6..38092adbe0d4 100644
--- a/include/linux/contpte.h
+++ b/include/linux/contpte.h
@@ -19,5 +19,7 @@ void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 			pte_t *ptep, pte_t pte);
 void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		      pte_t *ptep, pte_t pte, unsigned int nr);
+int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep);
 
 #endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index 5bf939639233..220e9d81f401 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -47,6 +47,7 @@
  *   - set_pte()
  *   - pte_clear()
  *   - ptep_get_and_clear()
+ *   - ptep_test_and_clear_young()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -690,4 +691,42 @@ pte_t ptep_get_and_clear(struct mm_struct *mm,
 	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 	return __ptep_get_and_clear(mm, addr, ptep);
 }
+
+int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep)
+{
+	/*
+	 * ptep_clear_flush_young() technically requires us to clear the access
+	 * flag for a _single_ pte. However, the core-mm code actually tracks
+	 * access/dirty per folio, not per page. And since we only create a
+	 * contig range when the range is covered by a single folio, we can get
+	 * away with clearing young for the whole contig range here, so we avoid
+	 * having to unfold.
+	 */
+
+	size_t pgsize;
+	int young = 0;
+	int i, ncontig;
+
+	ptep = arch_contpte_align_down(ptep);
+	ncontig = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
+	addr = ALIGN_DOWN(addr, ncontig * pgsize);
+
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		young |= __ptep_test_and_clear_young(vma, addr, ptep);
+
+	return young;
+}
+EXPORT_SYMBOL_GPL(contpte_ptep_test_and_clear_young);
+
+__always_inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					      unsigned long addr, pte_t *ptep)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (likely(!pte_valid_cont(orig_pte)))
+		return __ptep_test_and_clear_young(vma, addr, ptep);
+
+	return contpte_ptep_test_and_clear_young(vma, addr, ptep);
+}
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


