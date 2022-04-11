Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A94FB83A
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbiDKJwK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344794AbiDKJv7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86341625
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5BE6B80F97
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E58C385A4;
        Mon, 11 Apr 2022 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670551;
        bh=n7GAVS9slOBzIfA5O5ulyZVXp1JEEXZyAX5hvOSUOTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRreosW3vQd6y8g+gD0cDQUDo3uCblDseEj1vkCa7PPkevsedM+Y4R5in45yO33mQ
         24PtJZFWJBvOSyqJ7ZnsCGy5EkOUJf7UlGJWSHx/Q+VyAu/Lpf9cwg6PQ7uKgIvjs+
         /avduxSQtySwukejgV2+10lDFU6SUe7NZqISHdOOKQ4rJ/QSEBspZoV7Y5grnaYVyH
         E5fcJxZV4RImZULoWoDlmYuCXZiiyYUawRBInPaQIMXaDzfY/cpk2dyrfDdUlwOVc7
         aaZ3yfqMRU0sob98rsioKQ29AGC+4nKdIJxJtGc3Y/TiG39bVR8VKM7pdrFRFF2AcJ
         GPDT0jj0p1UWA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 12/30] arm64: head: cover entire kernel image in initial ID map
Date:   Mon, 11 Apr 2022 11:48:06 +0200
Message-Id: <20220411094824.4176877-13-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7737; h=from:subject; bh=n7GAVS9slOBzIfA5O5ulyZVXp1JEEXZyAX5hvOSUOTE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lJai4Oa6+l0Tl16sO/od9EEuC8UtRHrmOS9p9c XO8lc72JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5SQAKCRDDTyI5ktmPJExQC/ wJECqRAM3HQBtFiSYBBJROLMlbckFGLY6a08iWSFJi22+WvxytN6ex4zKuIfIE94G8ut+XQN5WB8RG W4GaN32f3oa4JJhCStmVgnLeOhkLJHhbsvb3t6Ka5Tj+07EVNEgEbJfLR/nh8nfnQKNmkW2HTQflKA oEVrSoJ5EQ+5Rhrpo6xggCAQjeQL7lv+CxiWmg0H2zdI9osa7BbcHOWPBMvX/q/uSCJF+0r2GZ4DWK tYUnumOiEq+yXyTPo/FaCDFg+zGe6BqL1DWWuug2pyRLTA5X+nkJ7QR9pH3q57vwpKBiAJxilR97Gv WNLt0A5mrxFc8wH03VkqAaycYOAYDjRiCRSYLSuAhq8uJIizBEkD4lR5YL8x0vUtqWFOHiIMYAPIZP vkS2dl+UmcNQvpR7ZFirgxHYl7dBGIpREVAepk7oIoM++hTtCi9VgiTAeCNeHoWm0G+28t7QUNLCv5 0ufzlnfeY9YAayuDgfy9svHRIHXYT7nevCTb9XoNeoP1s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As a first step towards avoiding the need to create, tear down and
recreate the kernel virtual mapping with MMU and caches disabled, start
by expanding the ID map so it covers the page tables as well as all
executable code. This will allow us to populate the page tables with the
MMU and caches on, and call KASLR init code before setting up the
virtual mapping.

Since this ID map is only needed at boot, create it as a temporary set
of page tables, and populate the permanent ID map after enabling the MMU
and caches. While at it, switch to read-only attributes for the where
possible, as writable permissions are only needed for the initial kernel
page tables. Note that on 4k granule configurations, the permanent ID
map will now be reduced to a single page rather than a 2M block mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 16 ++++++----
 arch/arm64/kernel/head.S                | 31 +++++++++++++-------
 arch/arm64/kernel/vmlinux.lds.S         |  7 +++--
 arch/arm64/mm/mmu.c                     | 23 ++++++++++++++-
 4 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 96dc0f7da258..5395e5a04f35 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -35,10 +35,8 @@
  */
 #if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
-#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT) - 1)
 #else
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
-#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT))
 #endif
 
 
@@ -87,7 +85,13 @@
 			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
 			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
 #define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end))
-#define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
+
+/* the initial ID map may need two extra pages if it needs to be extended */
+#if VA_BITS < 48
+#define INIT_IDMAP_DIR_SIZE	(INIT_DIR_SIZE + (2 * PAGE_SIZE))
+#else
+#define INIT_IDMAP_DIR_SIZE	INIT_DIR_SIZE
+#endif
 
 /* Initial memory map size */
 #if ARM64_KERNEL_USES_PMD_MAPS
@@ -107,9 +111,11 @@
 #define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
 #if ARM64_KERNEL_USES_PMD_MAPS
-#define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
+#define SWAPPER_RW_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
+#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PMD_SECT_RDONLY)
 #else
-#define SWAPPER_MM_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
+#define SWAPPER_RW_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
+#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6fc8f7f88a1a..4ef12bcdfe6a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -87,6 +87,7 @@
 	 *  x28        clear_page_tables()                      callee preserved temp register
 	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
+	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
@@ -296,9 +297,7 @@ SYM_FUNC_START_LOCAL(remap_region)
 SYM_FUNC_END(remap_region)
 
 SYM_FUNC_START_LOCAL(create_idmap)
-	adrp	x0, idmap_pg_dir
-	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
-
+	mov	x28, lr
 	/*
 	 * The ID map carries a 1:1 mapping of the physical address range
 	 * covered by the loaded image, which could be anywhere in DRAM. This
@@ -345,11 +344,22 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * translation level, but the top-level table has more entries.
 	 */
 #endif
-	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
-	mov	x7, SWAPPER_MM_MMUFLAGS
+	adrp	x0, init_idmap_pg_dir
+	adrp	x3, _text
+	adrp	x6, _end
+	mov	x7, SWAPPER_RX_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
+	/* Remap the kernel page tables r/w in the ID map */
+	adrp	x1, _text
+	adrp	x2, init_pg_dir
+	adr_l	x3, init_pg_end - 1
+	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RW_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
 	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate those tables again to
@@ -357,9 +367,10 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 */
 	dmb	sy
 
-	adrp	x0, idmap_pg_dir
-	adrp	x1, idmap_pg_end
-	b	dcache_inval_poc		// tail call
+	adrp	x0, init_idmap_pg_dir
+	adrp	x1, init_idmap_pg_end
+	bl	dcache_inval_poc
+	ret	x28
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
@@ -370,7 +381,7 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	mov	x7, SWAPPER_MM_MMUFLAGS
+	mov	x7, SWAPPER_RW_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
@@ -851,7 +862,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 
 	adrp	x1, init_pg_dir
-	adrp	x2, idmap_pg_dir
+	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index edaf0faf766f..7030b5a57d23 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -195,8 +195,7 @@ SECTIONS
 	HYPERVISOR_DATA_SECTIONS
 
 	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	idmap_pg_end = .;
+	. += PAGE_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
@@ -232,6 +231,10 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
+	init_idmap_pg_dir = .;
+	. += INIT_IDMAP_DIR_SIZE;
+	init_idmap_pg_end = .;
+
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index de171114a979..07219afe2723 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -766,9 +766,28 @@ static void __init map_kernel(pgd_t *pgdp)
 	kasan_copy_shadow(pgdp);
 }
 
+static void __init create_idmap(void)
+{
+	u64 start = __pa_symbol(__idmap_text_start);
+	u64 size = __pa_symbol(__idmap_text_end) - start;
+	pgd_t *pgd = idmap_pg_dir;
+	u64 pgd_phys;
+
+	/* check if we need an additional level of translation */
+	if (VA_BITS < 48 && idmap_t0sz < TCR_T0SZ(VA_BITS_MIN)) {
+		pgd_phys = early_pgtable_alloc(PAGE_SHIFT);
+		set_pgd(&idmap_pg_dir[start >> VA_BITS],
+			__pgd(pgd_phys | P4D_TYPE_TABLE));
+		pgd = __va(pgd_phys);
+	}
+	__create_pgd_mapping(pgd, start, start, size, PAGE_KERNEL_ROX,
+			     early_pgtable_alloc, 0);
+}
+
 void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+	extern pgd_t init_idmap_pg_dir[];
 
 #if VA_BITS > 48
 	if (cpuid_feature_extract_unsigned_field(
@@ -789,13 +808,15 @@ void __init paging_init(void)
 
 	pgd_clear_fixmap();
 
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), init_idmap_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
 
 	memblock_phys_free(__pa_symbol(init_pg_dir),
 			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
 
 	memblock_allow_resize();
+
+	create_idmap();
 }
 
 /*
-- 
2.30.2

