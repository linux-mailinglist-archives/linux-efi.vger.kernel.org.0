Return-Path: <linux-efi+bounces-1031-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625968C0511
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2451C221FD
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1C130A4A;
	Wed,  8 May 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qpXz0fpK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92938130AC7
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196714; cv=none; b=IxmfDoVvWPsgBBD1jxNqVhBt//bMbON5TwucQptm7s6hbbZGljvGv9Dr1x7sGu0Wxskaf1nyjIFaavIRycewZLjgsvpJt2jlYFw4H0X1cWxSTugEzTj5FrmJdb2uQPrmRrDzVwBMtEwPn++lUmcQFCiJ4u+bim+LbSuuFIUYbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196714; c=relaxed/simple;
	bh=17Fc7ODuOz1kLt1gNe1cLiC3KB/RQ6g/Lgo9SPZ4gaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRlSyGwRKOIdXu5S5i/jlOqeI5/95njbbufjs3zNGicZV0bQ8F//tLb6wL98u6ubuLvbnCF9N5guTTGezbMsXvlAOwmcjFx7F5WJQX3McDqpugWd33CfcaNDiHBj7wcrfYcPq6B3ud0awpRB2w6Li27kncE9PInXSKH4Dp5CxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qpXz0fpK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso741278f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196710; x=1715801510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mj4lZQ0sNzizek27x00kn2/PQ3ffbB6QFBBUZYNyzk=;
        b=qpXz0fpK6bmYnoAg6TyQoKjCo8PTRaAKLX3LxpHCm0YM37mPKT6RKI+g+cQyhN9RwJ
         pep0GkfvVSkvmsCkiNtQkVBjUONZJZ5sTF02IBaGPLYxJg5xpnxaMP+jYTKoTkT8RVu7
         wiMyKY+jKs7avzysbZRNmNcBv4c9p8+UoD/9sR7ZHB5GrDnad5zgPLialTH2Ri8WGDsy
         28UrsbOqaJjJs7tuHntTbfIxRjMEcN5K6LnHIFM6mtkGar8yFQcicRKPWY+PlN6BDZ3y
         mc08qKZapIhvT2s2AFh1vBePl2TzpspcjY17CGHgGP7DtGgtdtNs5JhE9v1u5kb0hUUc
         XBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196710; x=1715801510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mj4lZQ0sNzizek27x00kn2/PQ3ffbB6QFBBUZYNyzk=;
        b=fxOwtyXShQoi8Tt7rdE8LcWy5OjLr1SEeCmnf2WMF8K6R7layatFm+/yaJ9bnmiMZQ
         yEfXNH4v5xYcKIjkL0gV2CwPJGIVyJ5vkKsVoajeuq0DpwNbUF9wKTLcQcBidwOlGgM1
         hiIbZUyWyz69LiRHt/HqD4i9seJMvQEvsi+EBrZ/kKgmWZyA5X9GQTBhCMimY9JcpOvj
         HwGf5EJvGNgcSdcLixnseA+Xot8RI4KVb09iFOrKq9js4kXShSyD0vl9VJ1ZJZRv7Jnu
         /JbVgsHAKAWo65g4+Yq64Urgalx86Q6LeVpHt0yXh26cGB+IwnkszurmhEQm3xeBbweE
         ntVg==
X-Forwarded-Encrypted: i=1; AJvYcCV4n7Dz2qpDBBWhLfV7JOxTt1TocMF76H/K3nQD3p6npAh1vPvXHt1jhSF5I9GFf4STywWtdYsw7ZCmNiH8tOiVAq/xxW6gH/E8
X-Gm-Message-State: AOJu0Yx19oO2aCbn5aPIiwApdrh+J6dELCa1qcXjnK2MGiOGxV1UlSO8
	v+Z1WN04ZmnnZerHwuU53Z7z3648juL9VB+e3SJ87o+9whCClolxLS1Qz24f/eE=
X-Google-Smtp-Source: AGHT+IGynnks5bQyXkefndTUc8PNt1+uZJK8w5+sVciCnroxfstzlHH5YDMjCv7Za3kPs8Z2dwdXzA==
X-Received: by 2002:adf:fe8a:0:b0:34c:fd92:3359 with SMTP id ffacd0b85a97d-350185d57e7mr489056f8f.21.1715196709811;
        Wed, 08 May 2024 12:31:49 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4242000000b003472489d26fsm15924162wrr.19.2024.05.08.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:31:49 -0700 (PDT)
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
Subject: [PATCH 12/12] mm, riscv, arm64: Use common get_and_clear_full_ptes()/clear_full_ptes() functions
Date: Wed,  8 May 2024 21:19:31 +0200
Message-Id: <20240508191931.46060-13-alexghiti@rivosinc.com>
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

Make riscv use the contpte aware get_and_clear_full_ptes()/clear_full_ptes()
function from arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 41 ++++------------------------
 arch/arm64/mm/Makefile           |  1 -
 arch/arm64/mm/contpte.c          | 46 -------------------------------
 arch/riscv/include/asm/pgtable.h | 39 ++++++++++++++++++++++++++
 include/linux/contpte.h          |  5 ++++
 mm/contpte.c                     | 47 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 83 deletions(-)
 delete mode 100644 arch/arm64/mm/contpte.c

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 162efd9647dd..f8a3159f9df0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1373,17 +1373,6 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 
 #ifdef CONFIG_THP_CONTPTE
 
-/*
- * The contpte APIs are used to transparently manage the contiguous bit in ptes
- * where it is possible and makes sense to do so. The PTE_CONT bit is considered
- * a private implementation detail of the public ptep API (see below).
- */
-extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, unsigned int nr, int full);
-extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep,
-				unsigned int nr, int full);
-
 #define pte_batch_hint pte_batch_hint
 static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
 {
@@ -1428,34 +1417,14 @@ extern void pte_clear(struct mm_struct *mm,
 		      unsigned long addr, pte_t *ptep);
 #define pte_clear pte_clear
 
+extern void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned int nr, int full);
 #define clear_full_ptes clear_full_ptes
-static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, unsigned int nr, int full)
-{
-	if (likely(nr == 1)) {
-		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-		__clear_full_ptes(mm, addr, ptep, nr, full);
-	} else {
-		contpte_clear_full_ptes(mm, addr, ptep, nr, full);
-	}
-}
 
+extern pte_t get_and_clear_full_ptes(struct mm_struct *mm,
+				     unsigned long addr, pte_t *ptep,
+				     unsigned int nr, int full);
 #define get_and_clear_full_ptes get_and_clear_full_ptes
-static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep,
-				unsigned int nr, int full)
-{
-	pte_t pte;
-
-	if (likely(nr == 1)) {
-		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-		pte = __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
-	} else {
-		pte = contpte_get_and_clear_full_ptes(mm, addr, ptep, nr, full);
-	}
-
-	return pte;
-}
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 extern pte_t ptep_get_and_clear(struct mm_struct *mm,
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 52a1b2082627..dbd1bc95967d 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -3,7 +3,6 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
 				   context.o proc.o pageattr.o fixmap.o
-obj-$(CONFIG_THP_CONTPTE)	+= contpte.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
deleted file mode 100644
index 1cef93b15d6e..000000000000
--- a/arch/arm64/mm/contpte.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2023 ARM Ltd.
- */
-
-#include <linux/mm.h>
-#include <linux/efi.h>
-#include <linux/export.h>
-#include <asm/tlbflush.h>
-
-static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, unsigned int nr)
-{
-	/*
-	 * Unfold any partially covered contpte block at the beginning and end
-	 * of the range.
-	 */
-
-	if (ptep != arch_contpte_align_down(ptep) || nr < CONT_PTES)
-		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-
-	if (ptep + nr != arch_contpte_align_down(ptep + nr)) {
-		unsigned long last_addr = addr + PAGE_SIZE * (nr - 1);
-		pte_t *last_ptep = ptep + nr - 1;
-
-		contpte_try_unfold(mm, last_addr, last_ptep,
-				   __ptep_get(last_ptep));
-	}
-}
-
-void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, unsigned int nr, int full)
-{
-	contpte_try_unfold_partial(mm, addr, ptep, nr);
-	__clear_full_ptes(mm, addr, ptep, nr, full);
-}
-EXPORT_SYMBOL_GPL(contpte_clear_full_ptes);
-
-pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep,
-				unsigned int nr, int full)
-{
-	contpte_try_unfold_partial(mm, addr, ptep, nr);
-	return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
-}
-EXPORT_SYMBOL_GPL(contpte_get_and_clear_full_ptes);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 728f31da5e6a..a4843bdfdb37 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -754,6 +754,37 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
+static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned int nr, int full)
+{
+	for (;;) {
+		__ptep_get_and_clear(mm, addr, ptep);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
+static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep,
+					      unsigned int nr, int full)
+{
+	pte_t pte, tmp_pte;
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		if (pte_dirty(tmp_pte))
+			pte = pte_mkdirty(pte);
+		if (pte_young(tmp_pte))
+			pte = pte_mkyoung(pte);
+	}
+	return pte;
+}
+
 static inline void __ptep_set_wrprotect(struct mm_struct *mm,
 					unsigned long address, pte_t *ptep,
 					pte_t pte)
@@ -823,6 +854,13 @@ extern void ptep_set_wrprotect(struct mm_struct *mm,
 extern void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned int nr);
 #define wrprotect_ptes	wrprotect_ptes
+extern void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned int nr, int full);
+#define clear_full_ptes	clear_full_ptes
+extern pte_t get_and_clear_full_ptes(struct mm_struct *mm,
+				     unsigned long addr, pte_t *ptep,
+				     unsigned int nr, int full);
+#define get_and_clear_full_ptes	get_and_clear_full_ptes
 
 #else /* CONFIG_THP_CONTPTE */
 
@@ -842,6 +880,7 @@ extern void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 #define ptep_set_wrprotect(mm, addr, ptep)					\
 			__ptep_set_wrprotect(mm, addr, ptep, __ptep_get(ptep))
 #define wrprotect_ptes		__wrprotect_ptes
+#define clear_full_ptes		__clear_full_ptes
 
 #endif /* CONFIG_THP_CONTPTE */
 
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
index d1439db1706c..b24554ebca41 100644
--- a/include/linux/contpte.h
+++ b/include/linux/contpte.h
@@ -28,5 +28,10 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				  pte_t entry, int dirty);
 void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned int nr);
+void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep, unsigned int nr, int full);
+pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
+				      unsigned long addr, pte_t *ptep,
+				      unsigned int nr, int full);
 
 #endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index fe36b6b1d20a..677344e0e3c3 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -51,6 +51,8 @@
  *   - ptep_clear_flush_young()
  *   - wrprotect_ptes()
  *   - ptep_set_wrprotect()
+ *   - clear_full_ptes()
+ *   - get_and_clear_full_ptes()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -905,4 +907,49 @@ __always_inline void ptep_set_wrprotect(struct mm_struct *mm,
 {
 	wrprotect_ptes(mm, addr, ptep, 1);
 }
+
+void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep, unsigned int nr, int full)
+{
+	contpte_try_unfold_partial(mm, addr, ptep, nr);
+	__clear_full_ptes(mm, addr, ptep, nr, full);
+}
+EXPORT_SYMBOL_GPL(contpte_clear_full_ptes);
+
+pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
+				      unsigned long addr, pte_t *ptep,
+				      unsigned int nr, int full)
+{
+	contpte_try_unfold_partial(mm, addr, ptep, nr);
+	return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
+}
+EXPORT_SYMBOL_GPL(contpte_get_and_clear_full_ptes);
+
+__always_inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned int nr, int full)
+{
+	if (likely(nr == 1)) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		__clear_full_ptes(mm, addr, ptep, nr, full);
+	} else {
+		contpte_clear_full_ptes(mm, addr, ptep, nr, full);
+	}
+}
+
+__always_inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep,
+					      unsigned int nr, int full)
+{
+	pte_t pte;
+
+	if (likely(nr == 1)) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		pte = __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
+	} else {
+		pte = contpte_get_and_clear_full_ptes(mm, addr, ptep, nr, full);
+	}
+
+	return pte;
+}
+
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


