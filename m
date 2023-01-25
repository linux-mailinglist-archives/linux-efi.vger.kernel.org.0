Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9567AB87
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjAYIYs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 03:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYIYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 03:24:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210E366AF
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:24:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m7so2552743wru.8
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsDDO4uellZf0C+juEHPa8tYsGopFAarZz2ZBHCW4I4=;
        b=dfWH2lswOdqIUZ/YYYefexC06dURbScM6EolsJTBtYvrgs3gkgtcTx5i67xPAsYi+L
         wjbrt1ZgENjDXlEw7VMga1qWLMbqOkyPpu8tuTJVBiQ578K9zfMZARc3/3wL8r7S3Dm0
         s9MCfhI8CGk1J9S+1kjMf8fgGlgXgfZOVmG6v1z+ISlZroN0Nc4cRb0DMJF3ofXdHcrY
         u6SkgqvNss963ad45ZWDNmo+9B4qaycTfOvf/wJBbtMHriU71Cm7Ji4Me2qY2Y96sNQC
         HrQmy6kOMlI4Scdm78IuXhtAZD8JQ0mRNfRwdIwKCH568OH/bUEwSKi+v+k2lEkO2ezf
         3HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsDDO4uellZf0C+juEHPa8tYsGopFAarZz2ZBHCW4I4=;
        b=h2jZlylV0ko+Fgj5xscK4fw+Z82pLqr6vdtvZAfLJJh42SGfVYFMtjn+w0Jn8leC05
         y6pV0ZJ5KOQA/Q/5UEBYP+rptc+Ms6ytuE6zxYO2+veGxkLNDxnTO/cdlS+gaP3TCINU
         BnarxhTOGhluxE9RIcxAZ4V93zL5UEYsnWJWnZyjD43pnQBc6+9IGnF9lYSwL0zB6jSa
         B2d3bWe9f7WushtKdiIZLdKWRVYVvufgF9SY6EAPPK55zWGRaofMJ8eK4WiU47VRUMkw
         ET691BVT3mo0/Sxpx3B17eX/rAJ1FFJ4PC/Av8TJLGiomTBE3epp3mMjTAAR3gwNVRbJ
         KcyA==
X-Gm-Message-State: AFqh2koLsIe7ECzAOEvruY5FbHgMaqfbvMe6bZzjVWHMq40gW4SXtQhX
        QiBdMnlekkSwa27Eeq+7b6p62Q==
X-Google-Smtp-Source: AMrXdXvUfDW02iWHjC4V8HdBJNgWuPo79iiwb+fawpoZGRl7cU+yedbPnqUSrRjr675uSWiz5gbEBw==
X-Received: by 2002:a5d:4349:0:b0:2bd:e1fc:ef83 with SMTP id u9-20020a5d4349000000b002bde1fcef83mr23982267wrr.71.1674635084153;
        Wed, 25 Jan 2023 00:24:44 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c2e8500b003db15b1fb3csm1095183wmn.13.2023.01.25.00.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:24:43 -0800 (PST)
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
Subject: [PATCH v3 1/6] riscv: Split early and final KASAN population functions
Date:   Wed, 25 Jan 2023 09:23:28 +0100
Message-Id: <20230125082333.1577572-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125082333.1577572-1-alexghiti@rivosinc.com>
References: <20230125082333.1577572-1-alexghiti@rivosinc.com>
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

This is a preliminary work that allows to make the code more
understandable.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/kasan_init.c | 185 +++++++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 69 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index e1226709490f..2a48eba6bd08 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -95,23 +95,13 @@ static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned
 }
 
 static void __init kasan_populate_pud(pgd_t *pgd,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pud_t *pudp, *base_pud;
 	unsigned long next;
 
-	if (early) {
-		/*
-		 * We can't use pgd_page_vaddr here as it would return a linear
-		 * mapping address but it is not mapped yet, but when populating
-		 * early_pg_dir, we need the physical address and when populating
-		 * swapper_pg_dir, we need the kernel virtual address so use
-		 * pt_ops facility.
-		 */
-		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_pgd_pfn(*pgd)));
-	} else if (pgd_none(*pgd)) {
+	if (pgd_none(*pgd)) {
 		base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
 		memcpy(base_pud, (void *)kasan_early_shadow_pud,
 			sizeof(pud_t) * PTRS_PER_PUD);
@@ -130,16 +120,10 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 		next = pud_addr_end(vaddr, end);
 
 		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE) {
-			if (early) {
-				phys_addr = __pa(((uintptr_t)kasan_early_shadow_pmd));
-				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_TABLE));
+			phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
+			if (phys_addr) {
+				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
 				continue;
-			} else {
-				phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
-				if (phys_addr) {
-					set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
-					continue;
-				}
 			}
 		}
 
@@ -152,34 +136,21 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	if (!early)
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
 }
 
 static void __init kasan_populate_p4d(pgd_t *pgd,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	p4d_t *p4dp, *base_p4d;
 	unsigned long next;
 
-	if (early) {
-		/*
-		 * We can't use pgd_page_vaddr here as it would return a linear
-		 * mapping address but it is not mapped yet, but when populating
-		 * early_pg_dir, we need the physical address and when populating
-		 * swapper_pg_dir, we need the kernel virtual address so use
-		 * pt_ops facility.
-		 */
-		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgd)));
-	} else {
-		base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-		if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
-			base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
-			memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
-				sizeof(p4d_t) * PTRS_PER_P4D);
-		}
+	base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
+	if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
+		base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
+		memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
+		       sizeof(p4d_t) * PTRS_PER_P4D);
 	}
 
 	p4dp = base_p4d + p4d_index(vaddr);
@@ -188,20 +159,14 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 		next = p4d_addr_end(vaddr, end);
 
 		if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) && (next - vaddr) >= P4D_SIZE) {
-			if (early) {
-				phys_addr = __pa(((uintptr_t)kasan_early_shadow_pud));
-				set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_TABLE));
+			phys_addr = memblock_phys_alloc(P4D_SIZE, P4D_SIZE);
+			if (phys_addr) {
+				set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_KERNEL));
 				continue;
-			} else {
-				phys_addr = memblock_phys_alloc(P4D_SIZE, P4D_SIZE);
-				if (phys_addr) {
-					set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_KERNEL));
-					continue;
-				}
 			}
 		}
 
-		kasan_populate_pud((pgd_t *)p4dp, vaddr, next, early);
+		kasan_populate_pud((pgd_t *)p4dp, vaddr, next);
 	} while (p4dp++, vaddr = next, vaddr != end);
 
 	/*
@@ -210,8 +175,7 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	if (!early)
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
 }
 
 #define kasan_early_shadow_pgd_next			(pgtable_l5_enabled ?	\
@@ -219,16 +183,15 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 							(pgtable_l4_enabled ?	\
 				(uintptr_t)kasan_early_shadow_pud :		\
 				(uintptr_t)kasan_early_shadow_pmd))
-#define kasan_populate_pgd_next(pgdp, vaddr, next, early)			\
+#define kasan_populate_pgd_next(pgdp, vaddr, next)				\
 		(pgtable_l5_enabled ?						\
-		kasan_populate_p4d(pgdp, vaddr, next, early) :			\
+		kasan_populate_p4d(pgdp, vaddr, next) :				\
 		(pgtable_l4_enabled ?						\
-			kasan_populate_pud(pgdp, vaddr, next, early) :		\
+			kasan_populate_pud(pgdp, vaddr, next) :			\
 			kasan_populate_pmd((pud_t *)pgdp, vaddr, next)))
 
 static void __init kasan_populate_pgd(pgd_t *pgdp,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	unsigned long next;
@@ -237,11 +200,7 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 		next = pgd_addr_end(vaddr, end);
 
 		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE) {
-			if (early) {
-				phys_addr = __pa((uintptr_t)kasan_early_shadow_pgd_next);
-				set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_TABLE));
-				continue;
-			} else if (pgd_page_vaddr(*pgdp) ==
+			if (pgd_page_vaddr(*pgdp) ==
 				   (unsigned long)lm_alias(kasan_early_shadow_pgd_next)) {
 				/*
 				 * pgdp can't be none since kasan_early_init
@@ -258,7 +217,95 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 			}
 		}
 
-		kasan_populate_pgd_next(pgdp, vaddr, next, early);
+		kasan_populate_pgd_next(pgdp, vaddr, next);
+	} while (pgdp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_pud(p4d_t *p4dp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	pud_t *pudp, *base_pud;
+	phys_addr_t phys_addr;
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
+		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) &&
+		    (next - vaddr) >= PUD_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_pmd);
+			set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		BUG();
+	} while (pudp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_p4d(pgd_t *pgdp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	p4d_t *p4dp, *base_p4d;
+	phys_addr_t phys_addr;
+	unsigned long next;
+
+	/*
+	 * We can't use pgd_page_vaddr here as it would return a linear
+	 * mapping address but it is not mapped yet, but when populating
+	 * early_pg_dir, we need the physical address and when populating
+	 * swapper_pg_dir, we need the kernel virtual address so use
+	 * pt_ops facility.
+	 * Note that this test is then completely equivalent to
+	 * p4dp = p4d_offset(pgdp, vaddr)
+	 */
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
+		if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) &&
+		    (next - vaddr) >= P4D_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_pud);
+			set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		kasan_early_populate_pud(p4dp, vaddr, next);
+	} while (p4dp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_pgd(pgd_t *pgdp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	phys_addr_t phys_addr;
+	unsigned long next;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+
+		if (pgd_none(*pgdp) && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
+		    (next - vaddr) >= PGDIR_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_p4d);
+			set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		kasan_early_populate_p4d(pgdp, vaddr, next);
 	} while (pgdp++, vaddr = next, vaddr != end);
 }
 
@@ -295,16 +342,16 @@ asmlinkage void __init kasan_early_init(void)
 					PAGE_TABLE));
 	}
 
-	kasan_populate_pgd(early_pg_dir + pgd_index(KASAN_SHADOW_START),
-			   KASAN_SHADOW_START, KASAN_SHADOW_END, true);
+	kasan_early_populate_pgd(early_pg_dir + pgd_index(KASAN_SHADOW_START),
+				 KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	local_flush_tlb_all();
 }
 
 void __init kasan_swapper_init(void)
 {
-	kasan_populate_pgd(pgd_offset_k(KASAN_SHADOW_START),
-			   KASAN_SHADOW_START, KASAN_SHADOW_END, true);
+	kasan_early_populate_pgd(pgd_offset_k(KASAN_SHADOW_START),
+				 KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	local_flush_tlb_all();
 }
@@ -314,7 +361,7 @@ static void __init kasan_populate(void *start, void *end)
 	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 
-	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend, false);
+	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend);
 
 	local_flush_tlb_all();
 	memset(start, KASAN_SHADOW_INIT, end - start);
-- 
2.37.2

