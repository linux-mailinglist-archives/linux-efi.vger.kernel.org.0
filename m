Return-Path: <linux-efi+bounces-1462-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D1934A91
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545241C20DF4
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2237A724;
	Thu, 18 Jul 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMcQjuhW"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9147A715
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293152; cv=none; b=fsJJ5N2ju6eJxkExwNgufvDqfzurkNhNc7E2GJ7JSyi1L2HNprKpX38VQZo6IMIqL25T6PIGy56VNP7d29wseJDohFLI6KXN+BiUmI0tMqg1P56qR06bYnNeOIW6Mw7w+1aPmfv7y4lU6udmszaash4CzpCvOgSoHCdOQu9oTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293152; c=relaxed/simple;
	bh=pLbTxH8m3Pu5d2m2lDWp6Z1THC/A+jDNHTYZyc+OQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUNsRDnd8Q6RZiZu4AFG/QYpYx5jX8p4LutJQ1vw0qsJzyE6Vj3HMIc436IVAW7K1GunD+YNFeSBqRLA+YA+e4Y9u5UNecvbrzxsRyN726KfTvCX/rBdQOemJdVcgKufrTdaBTjibgxnMPn73pKjIKnRTd8ZFuyrIkASlbB1DBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMcQjuhW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCmuPnEyTzB6M7DQihQfFxfvOrguOlS28iXHft0X5VU=;
	b=XMcQjuhWfJGr85MabQcSsYXDlxynnspHc8am4HL2xo6ChVVxWueOtWCCU3NXR9aLu6XVCl
	zq/ZWNMtVxSvq0RrmMYyzxcR56Q50SUBr7Be0qyWJ2pYEoNLAT+E+M/CJLl1IXpvb+S51j
	vS+10yUjAD5P+nZ14SvfnKaNwdwBh2M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-ya1IOQc7NVm-WgfSceEv2g-1; Thu,
 18 Jul 2024 04:59:04 -0400
X-MC-Unique: ya1IOQc7NVm-WgfSceEv2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ABFE1955BED;
	Thu, 18 Jul 2024 08:59:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EBBC3000185;
	Thu, 18 Jul 2024 08:58:54 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 5/7] arm64: mm: Change to prototype of
Date: Thu, 18 Jul 2024 16:57:55 +0800
Message-ID: <20240718085759.13247-6-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The current allocator of __create_pgd_mapping_locked() takes only one
parameter, which reflects the current level of page table.

But kexec_page_alloc() should extra control information from the
parameter kimage. In order to make kexec_page_alloc() as an allocator,
re-shape the prototype of the allocator and hence of the
__create_pgd_mapping_locked().

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 arch/arm64/include/asm/mmu.h |  6 ++++
 arch/arm64/mm/mmu.c          | 67 ++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 65977c7783c58..4b908e0650105 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -64,6 +64,12 @@ extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
+extern void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
+					unsigned long virt, phys_addr_t size,
+					pgprot_t prot,
+					phys_addr_t (*pgtable_alloc)(int, void *),
+					void *arg,
+					int flags);
 extern void create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				   phys_addr_t size, pgprot_t prot);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c927e9312f102..875e2bc0cfb39 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -106,7 +106,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(int shift)
+static phys_addr_t __init early_pgtable_alloc(int shift, void *unused)
 {
 	phys_addr_t phys;
 
@@ -190,7 +190,8 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int),
+				phys_addr_t (*pgtable_alloc)(int, void *arg),
+				void *arg,
 				int flags)
 {
 	unsigned long next;
@@ -205,7 +206,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		if (flags & NO_EXEC_MAPPINGS)
 			pmdval |= PMD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		pte_phys = pgtable_alloc(PAGE_SHIFT, arg);
 		ptep = pte_set_fixmap(pte_phys);
 		init_clear_pgtable(ptep);
 		ptep += pte_index(addr);
@@ -241,7 +242,9 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(int), int flags)
+		     phys_addr_t (*pgtable_alloc)(int, void *),
+		     void *arg,
+		     int flags)
 {
 	unsigned long next;
 
@@ -263,7 +266,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 						      READ_ONCE(pmd_val(*pmdp))));
 		} else {
 			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
-					    pgtable_alloc, flags);
+					    pgtable_alloc, arg, flags);
 
 			BUG_ON(pmd_val(old_pmd) != 0 &&
 			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
@@ -275,7 +278,9 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int), int flags)
+				phys_addr_t (*pgtable_alloc)(int, void *),
+				void * arg,
+				int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -292,7 +297,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		if (flags & NO_EXEC_MAPPINGS)
 			pudval |= PUD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		pmd_phys = pgtable_alloc(PMD_SHIFT, arg);
 		pmdp = pmd_set_fixmap(pmd_phys);
 		init_clear_pgtable(pmdp);
 		pmdp += pmd_index(addr);
@@ -312,7 +317,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
+		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, arg, flags);
 
 		pmdp += pmd_index(next) - pmd_index(addr);
 		phys += next - addr;
@@ -323,7 +328,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
+			   phys_addr_t (*pgtable_alloc)(int, void *),
+			   void *arg,
 			   int flags)
 {
 	unsigned long next;
@@ -337,7 +343,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		if (flags & NO_EXEC_MAPPINGS)
 			p4dval |= P4D_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc(PUD_SHIFT);
+		pud_phys = pgtable_alloc(PUD_SHIFT, arg);
 		pudp = pud_set_fixmap(pud_phys);
 		init_clear_pgtable(pudp);
 		pudp += pud_index(addr);
@@ -368,7 +374,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 						      READ_ONCE(pud_val(*pudp))));
 		} else {
 			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
-					    pgtable_alloc, flags);
+					    pgtable_alloc, arg, flags);
 
 			BUG_ON(pud_val(old_pud) != 0 &&
 			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
@@ -381,7 +387,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 
 static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
+			   phys_addr_t (*pgtable_alloc)(int, void *),
+			   void *arg,
 			   int flags)
 {
 	unsigned long next;
@@ -395,7 +402,7 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		if (flags & NO_EXEC_MAPPINGS)
 			pgdval |= PGD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
-		p4d_phys = pgtable_alloc(P4D_SHIFT);
+		p4d_phys = pgtable_alloc(P4D_SHIFT, arg);
 		p4dp = p4d_set_fixmap(p4d_phys);
 		init_clear_pgtable(p4dp);
 		p4dp += p4d_index(addr);
@@ -411,7 +418,7 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		next = p4d_addr_end(addr, end);
 
 		alloc_init_pud(p4dp, addr, next, phys, prot,
-			       pgtable_alloc, flags);
+			       pgtable_alloc, arg, flags);
 
 		BUG_ON(p4d_val(old_p4d) != 0 &&
 		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
@@ -422,10 +429,11 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	p4d_clear_fixmap();
 }
 
-static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
+void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 					unsigned long virt, phys_addr_t size,
 					pgprot_t prot,
-					phys_addr_t (*pgtable_alloc)(int),
+					phys_addr_t (*pgtable_alloc)(int, void *),
+					void *arg,
 					int flags)
 {
 	unsigned long addr, end, next;
@@ -445,7 +453,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 	do {
 		next = pgd_addr_end(addr, end);
 		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
-			       flags);
+			       arg, flags);
 		phys += next - addr;
 	} while (pgdp++, addr = next, addr != end);
 }
@@ -453,12 +461,13 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(int),
+				 phys_addr_t (*pgtable_alloc)(int, void *),
+				 void *arg,
 				 int flags)
 {
 	mutex_lock(&fixmap_lock);
 	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
-				    pgtable_alloc, flags);
+				    pgtable_alloc, arg, flags);
 	mutex_unlock(&fixmap_lock);
 }
 
@@ -466,10 +475,10 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 extern __alias(__create_pgd_mapping_locked)
 void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(int), int flags);
+			     phys_addr_t (*pgtable_alloc)(int, void *), void *arg, int flags);
 #endif
 
-static phys_addr_t __pgd_pgtable_alloc(int shift)
+static phys_addr_t __pgd_pgtable_alloc(int shift, void *unused)
 {
 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
 	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
@@ -478,9 +487,9 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
 	return __pa(ptr);
 }
 
-static phys_addr_t pgd_pgtable_alloc(int shift)
+static phys_addr_t pgd_pgtable_alloc(int shift, void *unused)
 {
-	phys_addr_t pa = __pgd_pgtable_alloc(shift);
+	phys_addr_t pa = __pgd_pgtable_alloc(shift, unused);
 	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
 
 	/*
@@ -512,7 +521,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, NULL,
 			     NO_CONT_MAPPINGS);
 }
 
@@ -528,7 +537,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     pgd_pgtable_alloc, flags);
+			     pgd_pgtable_alloc, NULL, flags);
 }
 
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
@@ -540,7 +549,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, NULL,
 			     NO_CONT_MAPPINGS);
 
 	/* flush the TLBs after updating live kernel mappings */
@@ -551,7 +560,7 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 				  phys_addr_t end, pgprot_t prot, int flags)
 {
 	__create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
-			     prot, early_pgtable_alloc, flags);
+			     prot, early_pgtable_alloc, NULL, flags);
 }
 
 void __init mark_linear_text_alias_ro(void)
@@ -742,7 +751,7 @@ static int __init map_entry_trampoline(void)
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
 			     entry_tramp_text_size(), prot,
-			     __pgd_pgtable_alloc, NO_BLOCK_MAPPINGS);
+			     __pgd_pgtable_alloc, NULL, NO_BLOCK_MAPPINGS);
 
 	/* Map both the text and data into the kernel page table */
 	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
@@ -1344,7 +1353,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, params->pgprot, __pgd_pgtable_alloc,
+			     size, params->pgprot, __pgd_pgtable_alloc, NULL,
 			     flags);
 
 	memblock_clear_nomap(start, size);
-- 
2.41.0


