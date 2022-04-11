Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3434FB858
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiDKJw1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344826AbiDKJvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB2419A1
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E166115F
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA45C385AD;
        Mon, 11 Apr 2022 09:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670534;
        bh=CrPCfA3V4PBM2GL+sj5SJDi9iVpmtimBzj/JgVJ0+Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G85PtY6NVLLrpuoR3LPfgT8UT15JuDeXNijSMKWFLUEwHqlz+buRDQUNOJGH8TCtt
         ByumpKdGuQLP4orGFNlmDWW4KWRl98pojbS/Iz7dV5GjijHwGyW+EWJxOaxkjKXMjC
         vd+CgeQ7E6RjWbNQ3n69c8J2vIuWotcvLwJp8/Hwqk9jBpECtobnaeXj8Dy85hAVLd
         4Qsa89oiV3cKAvoTfDjcBvoArRP5jNsXNe3wS1iUCYsRyTP7P+Pqg0i+rK6uEHZYBV
         806I9Qx2ogbSg7oEEawgVxB13ecIfKMW/3t960+oJLZ7oZQygJ9oPEfK3AR8r8lmel
         6MJzZlrAsKBnA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 05/30] arm64: head: simplify page table mapping macros (slightly)
Date:   Mon, 11 Apr 2022 11:47:59 +0200
Message-Id: <20220411094824.4176877-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6906; h=from:subject; bh=CrPCfA3V4PBM2GL+sj5SJDi9iVpmtimBzj/JgVJ0+Lw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k9FXSc03bKRkbZZivAv4z6021AB3/YP9xUV9nI oLbsa+OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5PQAKCRDDTyI5ktmPJBJzC/ 9Ro+R6drJNZXHy8IEK8YalAoFVJCt3N+Wt5e6WIx75e9A2wT6Z/Ok18MPFcj1zrh6CiHjg566alNtf chcCM+t/ctY+Dej6MFTwN9hfae+E/JFcXI+alkgZVVcpg+I8ymyzHRnR3/poOrhFPLHulOvl+HafY5 V1lr2oUfZwa4MUaLVWR5FV41dgcH8jVMdMJTuWgKg9s0/iesnxwO/Kb18rrNSLMGfbdtzi6laOEzq9 wpmIprb1VRYr0fd+hUKKLx4FkNQGrgFRdlKv3mAJPYGR5h7p/03xtrk0Uvao1eq6QBPR2HVTA61fqj HQY0uIbhykZJlmzLSkTXwVkoL/EFJuATHtxcyzu9ycwTz/oBFpO16OR5u/ylbolDuDCz//FCHgIF2u OgStc/AVgkPsOwQa3i6GbFxutEZmvBzH3TIn+NOuMvqKCprGWjmTCPRVks9H7HPwJDemCJgdooi0bU uNJH15qhOaBGwuNTLk2t0QntBEbTiDOfdLu6iuLGYahgg=
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

Simplify the macros in head.S that are used to set up the early page
tables, by switching to immediates for the number of bits that are
interpreted as the table index at each level. This makes it much
easier to infer from the instruction stream what is going on, and
reduces the number of instructions emitted substantially.

Note that the extended ID map for cases where no additional level needs
to be configured now uses a compile time size as well, which means that
we interpret up to 10 bits as the table index at the root level (for
52-bit physical addressing), without taking into account whether or not
this is supported on the current system.  However, those bits can only
be set if we are executing the image from an address that exceeds the
48-bit PA range, and are guaranteed to be cleared otherwise, and given
that we are dealing with a mapping in the lower TTBR0 range of the
address space, the result is therefore the same as if we'd mask off only
6 bits.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 55 ++++++++------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 53126a35d73c..9fdde2f9cc0f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -179,31 +179,20 @@ SYM_CODE_END(preserve_boot_args)
  *	vstart:	virtual address of start of range
  *	vend:	virtual address of end of range - we map [vstart, vend]
  *	shift:	shift used to transform virtual address into index
- *	ptrs:	number of entries in page table
+ *	order:  #imm 2log(number of entries in page table)
  *	istart:	index in table corresponding to vstart
  *	iend:	index in table corresponding to vend
  *	count:	On entry: how many extra entries were required in previous level, scales
  *			  our end index.
  *		On exit: returns how many extra entries required for next page table level
  *
- * Preserves:	vstart, vend, shift, ptrs
+ * Preserves:	vstart, vend
  * Returns:	istart, iend, count
  */
-	.macro compute_indices, vstart, vend, shift, ptrs, istart, iend, count
-	lsr	\iend, \vend, \shift
-	mov	\istart, \ptrs
-	sub	\istart, \istart, #1
-	and	\iend, \iend, \istart	// iend = (vend >> shift) & (ptrs - 1)
-	mov	\istart, \ptrs
-	mul	\istart, \istart, \count
-	add	\iend, \iend, \istart	// iend += count * ptrs
-					// our entries span multiple tables
-
-	lsr	\istart, \vstart, \shift
-	mov	\count, \ptrs
-	sub	\count, \count, #1
-	and	\istart, \istart, \count
-
+	.macro compute_indices, vstart, vend, shift, order, istart, iend, count
+	ubfx	\istart, \vstart, \shift, \order
+	ubfx	\iend, \vend, \shift, \order
+	add	\iend, \iend, \count, lsl \order
 	sub	\count, \iend, \istart
 	.endm
 
@@ -218,38 +207,39 @@ SYM_CODE_END(preserve_boot_args)
  *	vend:	virtual address of end of range - we map [vstart, vend - 1]
  *	flags:	flags to use to map last level entries
  *	phys:	physical address corresponding to vstart - physical memory is contiguous
- *	pgds:	the number of pgd entries
+ *	order:  #imm 2log(number of entries in PGD table)
  *
  * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
  * Preserves:	vstart, flags
  * Corrupts:	tbl, rtbl, vend, istart, iend, tmp, count, sv
  */
-	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, pgds, istart, iend, tmp, count, sv
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv
 	sub \vend, \vend, #1
 	add \rtbl, \tbl, #PAGE_SIZE
-	mov \sv, \rtbl
 	mov \count, #0
-	compute_indices \vstart, \vend, #PGDIR_SHIFT, \pgds, \istart, \iend, \count
+
+	compute_indices \vstart, \vend, #PGDIR_SHIFT, #\order, \istart, \iend, \count
+	mov \sv, \rtbl
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
 	mov \tbl, \sv
-	mov \sv, \rtbl
 
 #if SWAPPER_PGTABLE_LEVELS > 3
-	compute_indices \vstart, \vend, #PUD_SHIFT, #PTRS_PER_PUD, \istart, \iend, \count
+	compute_indices \vstart, \vend, #PUD_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
+	mov \sv, \rtbl
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
 	mov \tbl, \sv
-	mov \sv, \rtbl
 #endif
 
 #if SWAPPER_PGTABLE_LEVELS > 2
-	compute_indices \vstart, \vend, #SWAPPER_TABLE_SHIFT, #PTRS_PER_PMD, \istart, \iend, \count
+	compute_indices \vstart, \vend, #SWAPPER_TABLE_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
+	mov \sv, \rtbl
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
 	mov \tbl, \sv
 #endif
 
-	compute_indices \vstart, \vend, #SWAPPER_BLOCK_SHIFT, #PTRS_PER_PTE, \istart, \iend, \count
-	bic \count, \phys, #SWAPPER_BLOCK_SIZE - 1
-	populate_entries \tbl, \count, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
+	compute_indices \vstart, \vend, #SWAPPER_BLOCK_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
+	bic \rtbl, \phys, #SWAPPER_BLOCK_SIZE - 1
+	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
 /*
@@ -300,12 +290,12 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * range in that case, and configure an additional translation level
 	 * if needed.
 	 */
-	mov	x4, #PTRS_PER_PGD
 	idmap_get_t0sz x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
 
 #if (VA_BITS < 48)
+#define IDMAP_PGD_ORDER	(VA_BITS - PGDIR_SHIFT)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
 
@@ -323,16 +313,16 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	mov	x2, EXTRA_PTRS
 	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6
 #else
+#define IDMAP_PGD_ORDER	(PHYS_MASK_SHIFT - PGDIR_SHIFT)
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
 	 * translation level, but the top-level table has more entries.
 	 */
-	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
 #endif
 1:
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
-	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
+	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -340,13 +330,12 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
-	mov	x4, PTRS_PER_PGD
 	adrp	x6, _end			// runtime __pa(_end)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
 
-	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
+	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
 	/*
 	 * Since the page tables have been populated with non-cacheable
-- 
2.30.2

