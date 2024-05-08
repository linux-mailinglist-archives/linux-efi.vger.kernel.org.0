Return-Path: <linux-efi+bounces-1024-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA98C04EA
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CDD2861E0
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FEF39AD6;
	Wed,  8 May 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xcQetQ+f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC4130AC2
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196285; cv=none; b=PImoyWe+xC244RKVbSPO7EmrA/WZDK/ImAxTlWXz0AzeuiQfpTmlqLo0wnEP9snfqW4iCuqPwis/HFtpJ6ICBRngz8YLVpMA21zpX8DSxQQ/fKsIv9u+QGmAU5uVQOqUsx2atTqNww2wZ9pY4+X30BXeqegMU+u6aQMX90srPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196285; c=relaxed/simple;
	bh=qn9psejSZA7JRo/psdWp7lYAEY5tgo06v+cxO4vKZQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWy7wDICf97DbAza/vurC/pMXIP79+V60jsbidMjq6bSu6pMnd6eYyB7XEfpbq3vImmZPS4VOmegqmD2N2RgR7yKj/gNNq33hBw8dQRlw13t8E9Bk0XHae+CU8fwT/v8NLGfoEFcqxLrFSDIO2QFpLfC5v8Ko9vqUs4MEkvbIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xcQetQ+f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so866065e9.1
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196281; x=1715801081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bID6WfA+atBgi3UdotMTiBHvNsJiSSNtZP3FlzKWl8Q=;
        b=xcQetQ+fE953RP6UFyuKfZcgZg7Oo/RsnsehPojGttQs/t9hn0s5e/a9EVjMvzS8Gp
         NTenIF3s+ca1PJaNzW8HmFpBHdaLSHy35VVHJ5g/M+qShKfLk+q7SdBiQvts43hT/JxQ
         GRuqKSkjVikXg00a/OiVlAZDCNOx0EYjGbKH8VEl4prAw+eCtC93chG9npn8ygnTNCFm
         q0C4LM9dMIIkHIfS3krG7y4+bxECjlPSndmtWUirxBW4DAwE1Zq/Wwjq/4+vrPmvh07b
         UKXUyph/difslf7GuJC9RWg2ssjLJOOoxxvHNkxPYYdzmV1PI5T4rzBnRKwO6rdhYLZO
         9/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196281; x=1715801081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bID6WfA+atBgi3UdotMTiBHvNsJiSSNtZP3FlzKWl8Q=;
        b=J0cDxH6Ce8BJVagx7A6vArBdlaWZLz0EaQJ0jj6i61vtgcG4HmHhqded0QdEPOZgOJ
         lIk+DKeIBzCprE0AWjCRymyrGMUz7OmLhzE09IjUE10yc+2qGcRqJtDj0ZYJJNyV6JFL
         h7bXmaZwMplUtC+rUh5t5WktxX2P0jU43J8efeYccgTFBEc3n6omwvAkEim6SkQbtb1/
         z7YhD/4TOTG+V5TIqMth/y2M8dxSG6kY+0ZOitTBIg+hc6v3gcegaWqG03E7LKNHQm44
         7sgT2AIUuJuIhHNXQRDo2UW9dbbwakeGgexCD6Q+fw4TMOdT0kyvTeSYiij+lFGMVPC/
         OHNw==
X-Forwarded-Encrypted: i=1; AJvYcCV8wyUNK63+Opxujk91Hj+jPQtYR0BF6F5BBcBqjUY5OolZlcEPPvjBIUE2/sy0hA1AAJ93dybI+tGHTMxvx22f8HZnSa+W5DIK
X-Gm-Message-State: AOJu0Yx25jS9/x2VNROmzoR0NuDC7MURlFpixJyk3RGk8iBqsaO4KOTC
	5tQogv/4PzJFMC67l00gU4ncIOZbsJhKPHwU1M077uModHLBHec5cUxQ3CGaTNo=
X-Google-Smtp-Source: AGHT+IFH7sC2GowLam3Jd+gaWz8gHH4sQsrwabW1J5xMuNqZ6dTlKzWFO1Hh7H4Mfqebgr3mIcqVow==
X-Received: by 2002:a05:600c:1991:b0:41d:803c:b945 with SMTP id 5b1f17b1804b1-41f71309fafmr39869075e9.10.1715196281225;
        Wed, 08 May 2024 12:24:41 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882089cbsm32567815e9.48.2024.05.08.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:24:40 -0700 (PDT)
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
Subject: [PATCH 05/12] mm, riscv, arm64: Use common set_pte() function
Date: Wed,  8 May 2024 21:19:24 +0200
Message-Id: <20240508191931.46060-6-alexghiti@rivosinc.com>
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

Make riscv use the contpte aware set_pte() function from arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 16 ++--------------
 arch/riscv/include/asm/kfence.h  |  4 ++--
 arch/riscv/include/asm/pgtable.h |  7 +++++--
 arch/riscv/kernel/efi.c          |  2 +-
 arch/riscv/kernel/hibernate.c    |  2 +-
 arch/riscv/kvm/mmu.c             | 10 +++++-----
 arch/riscv/mm/init.c             |  2 +-
 arch/riscv/mm/kasan_init.c       | 14 +++++++-------
 arch/riscv/mm/pageattr.c         |  4 ++--
 mm/contpte.c                     | 18 ++++++++++++++++++
 10 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8a0603257436..bb6210fb72c8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1432,20 +1432,8 @@ extern pte_t ptep_get(pte_t *ptep);
 extern pte_t ptep_get_lockless(pte_t *ptep);
 #define ptep_get_lockless ptep_get_lockless
 
-static inline void set_pte(pte_t *ptep, pte_t pte)
-{
-	/*
-	 * We don't have the mm or vaddr so cannot unfold contig entries (since
-	 * it requires tlb maintenance). set_pte() is not used in core code, so
-	 * this should never even be called. Regardless do our best to service
-	 * any call and emit a warning if there is any attempt to set a pte on
-	 * top of an existing contig range.
-	 */
-	pte_t orig_pte = __ptep_get(ptep);
-
-	WARN_ON_ONCE(pte_valid_cont(orig_pte));
-	__set_pte(ptep, pte_mknoncont(pte));
-}
+extern void set_pte(pte_t *ptep, pte_t pte);
+#define set_pte set_pte
 
 extern void set_ptes(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned int nr);
diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index f303fef8591c..36e9f638abf6 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -18,9 +18,9 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	pte_t *pte = virt_to_kpte(addr);
 
 	if (protect)
-		set_pte(pte, __pte(pte_val(__ptep_get(pte)) & ~_PAGE_PRESENT));
+		__set_pte(pte, __pte(pte_val(__ptep_get(pte)) & ~_PAGE_PRESENT));
 	else
-		set_pte(pte, __pte(pte_val(__ptep_get(pte)) | _PAGE_PRESENT));
+		__set_pte(pte, __pte(pte_val(__ptep_get(pte)) | _PAGE_PRESENT));
 
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 62cad1b974f1..4f8f673787e7 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -539,7 +539,7 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  * a page table are directly modified.  Thus, the following hook is
  * made available.
  */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
+static inline void __set_pte(pte_t *ptep, pte_t pteval)
 {
 	WRITE_ONCE(*ptep, pteval);
 }
@@ -551,7 +551,7 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 	if (pte_present(pteval) && pte_exec(pteval))
 		flush_icache_pte(mm, pteval);
 
-	set_pte(ptep, pteval);
+	__set_pte(ptep, pteval);
 }
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
@@ -790,11 +790,14 @@ extern pte_t ptep_get_lockless(pte_t *ptep);
 extern void set_ptes(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pteval, unsigned int nr);
 #define set_ptes set_ptes
+extern void set_pte(pte_t *ptep, pte_t pte);
+#define set_pte set_pte
 
 #else /* CONFIG_THP_CONTPTE */
 
 #define ptep_get		__ptep_get
 #define set_ptes		__set_ptes
+#define set_pte			__set_pte
 
 #endif /* CONFIG_THP_CONTPTE */
 
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
index 3d2a635c69ac..673eca7705ba 100644
--- a/arch/riscv/kernel/efi.c
+++ b/arch/riscv/kernel/efi.c
@@ -72,7 +72,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 		val = pte_val(pte) & ~_PAGE_EXEC;
 		pte = __pte(val);
 	}
-	set_pte(ptep, pte);
+	__set_pte(ptep, pte);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c0158..97ed3df7a308 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -186,7 +186,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 		pte_t pte = READ_ONCE(*src_ptep);
 
 		if (pte_present(pte))
-			set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
+			__set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
 	} while (dst_ptep++, src_ptep++, start += PAGE_SIZE, start < end);
 
 	return 0;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 70c6cb3864d6..1ee6139d495f 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -155,7 +155,7 @@ static int gstage_set_pte(struct kvm *kvm, u32 level,
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
 			if (!next_ptep)
 				return -ENOMEM;
-			set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
+			__set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
 					      __pgprot(_PAGE_TABLE)));
 		} else {
 			if (gstage_pte_leaf(ptep))
@@ -167,7 +167,7 @@ static int gstage_set_pte(struct kvm *kvm, u32 level,
 		ptep = &next_ptep[gstage_pte_index(addr, current_level)];
 	}
 
-	set_pte(ptep, *new_pte);
+	__set_pte(ptep, *new_pte);
 	if (gstage_pte_leaf(ptep))
 		gstage_remote_tlb_flush(kvm, current_level, addr);
 
@@ -251,7 +251,7 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t addr,
 			return;
 
 		if (op == GSTAGE_OP_CLEAR)
-			set_pte(ptep, __pte(0));
+			__set_pte(ptep, __pte(0));
 		for (i = 0; i < PTRS_PER_PTE; i++)
 			gstage_op_pte(kvm, addr + i * next_page_size,
 					&next_ptep[i], next_ptep_level, op);
@@ -259,9 +259,9 @@ static void gstage_op_pte(struct kvm *kvm, gpa_t addr,
 			put_page(virt_to_page(next_ptep));
 	} else {
 		if (op == GSTAGE_OP_CLEAR)
-			set_pte(ptep, __pte(0));
+			__set_pte(ptep, __pte(0));
 		else if (op == GSTAGE_OP_WP)
-			set_pte(ptep, __pte(pte_val(__ptep_get(ptep)) & ~_PAGE_WRITE));
+			__set_pte(ptep, __pte(pte_val(__ptep_get(ptep)) & ~_PAGE_WRITE));
 		gstage_remote_tlb_flush(kvm, ptep_level, addr);
 	}
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..bb5c6578204c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -325,7 +325,7 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	ptep = &fixmap_pte[pte_index(addr)];
 
 	if (pgprot_val(prot))
-		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
+		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
 	else
 		pte_clear(&init_mm, addr, ptep);
 	local_flush_tlb_page(addr);
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 381d61f42ab8..b5061cb3ce4d 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -41,7 +41,7 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
 	do {
 		if (pte_none(__ptep_get(ptep))) {
 			phys_addr = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
-			set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
+			__set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
 			memset(__va(phys_addr), KASAN_SHADOW_INIT, PAGE_SIZE);
 		}
 	} while (ptep++, vaddr += PAGE_SIZE, vaddr != end);
@@ -327,8 +327,8 @@ asmlinkage void __init kasan_early_init(void)
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
-		set_pte(kasan_early_shadow_pte + i,
-			pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
+		__set_pte(kasan_early_shadow_pte + i,
+			  pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
@@ -523,10 +523,10 @@ void __init kasan_init(void)
 		       kasan_mem_to_shadow((const void *)MODULES_VADDR + SZ_2G));
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(&kasan_early_shadow_pte[i],
-			mk_pte(virt_to_page(kasan_early_shadow_page),
-			       __pgprot(_PAGE_PRESENT | _PAGE_READ |
-					_PAGE_ACCESSED)));
+		__set_pte(&kasan_early_shadow_pte[i],
+			  mk_pte(virt_to_page(kasan_early_shadow_page),
+				 __pgprot(_PAGE_PRESENT | _PAGE_READ |
+					  _PAGE_ACCESSED)));
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 98c9dc4b983c..d623e4fc11fc 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -71,7 +71,7 @@ static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
 	pte_t val = __ptep_get(pte);
 
 	val = __pte(set_pageattr_masks(pte_val(val), walk));
-	set_pte(pte, val);
+	__set_pte(pte, val);
 
 	return 0;
 }
@@ -121,7 +121,7 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
 
 			ptep_new = (pte_t *)page_address(pte_page);
 			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
-				set_pte(ptep_new, pfn_pte(pfn + i, prot));
+				__set_pte(ptep_new, pfn_pte(pfn + i, prot));
 
 			smp_wmb();
 
diff --git a/mm/contpte.c b/mm/contpte.c
index 060e0bc1a2a3..543ae5b5a863 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -17,6 +17,7 @@
  *   - __pte_clear()
  *   - __ptep_set_access_flags()
  *   - __ptep_set_wrprotect()
+ *   - __set_pte()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
  *   - pte_valid_cont()
@@ -43,6 +44,7 @@
  *   - ptep_get()
  *   - set_ptes()
  *   - ptep_get_lockless()
+ *   - set_pte()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -658,4 +660,20 @@ __always_inline pte_t ptep_get_lockless(pte_t *ptep)
 
 	return contpte_ptep_get_lockless(ptep);
 }
+
+void set_pte(pte_t *ptep, pte_t pte)
+{
+	/*
+	 * We don't have the mm or vaddr so cannot unfold contig entries (since
+	 * it requires tlb maintenance). set_pte() is not used in core code, so
+	 * this should never even be called. Regardless do our best to service
+	 * any call and emit a warning if there is any attempt to set a pte on
+	 * top of an existing contig range.
+	 */
+	pte_t orig_pte = __ptep_get(ptep);
+
+	WARN_ON_ONCE(pte_valid_cont(orig_pte));
+	__set_pte(ptep, pte_mknoncont(pte));
+}
+
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


