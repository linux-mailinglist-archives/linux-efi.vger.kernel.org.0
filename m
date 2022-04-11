Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D984FB834
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbiDKJwC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbiDKJvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3D4131C
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73A4611D8
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37874C385AC;
        Mon, 11 Apr 2022 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670537;
        bh=tP8R1xHI6gZfqXXfZqQtZ+TXUEOhPzFX2O0GeERgqzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjwGPjotMV83lseT4RVC08AQfTu51QLb6KDG/iPRphy59mvnpEmG1xdww7Whe4vs9
         n1aXZIsmGpsrq0VOcZX0i48xvQ5HZnRewjwopyxnNQo2qj6Td3BBcmEFCFRaQ3qRIq
         X+Xh1NgrXK5PQ71G5VA1OB9JUarLp8ZZqbRUqhjM6NCcdlfm8IXd0Luj5/ZHG8ozk+
         ZEJcy5+6QtOqTvmEF20vESPgSYlFD9Ju6Bz9+zFG3kfTUrCoQ+4p6s7hpdIUsft/gv
         I3E0R5ufSCH3tftd2jqWKaCDU4CloxDsOXh+kP+70OnqxeI45SFE0kEPBDtuABGQoq
         Wi50VzziyYwVg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 06/30] arm64: head: switch to map_memory macro for the extended ID map
Date:   Mon, 11 Apr 2022 11:48:00 +0200
Message-Id: <20220411094824.4176877-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6360; h=from:subject; bh=tP8R1xHI6gZfqXXfZqQtZ+TXUEOhPzFX2O0GeERgqzc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k/w3V5UYIKiCXjI91akig/McBpdcqTLhu/dp6m 6mD3u+qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5PwAKCRDDTyI5ktmPJB2mC/ 9JNH5D3KzhCgS+Ey65CRlkPxg87Sk1r5IhaVORqwaAzKWF8efarzfL6vE70s1/lpIS26selE8526ua 5YMuSz2tCuph3y5NYiiQqQbLR2w5leQrcoLMzOI8YbDu0qC1K5GI1a1zZR00zsBBNacE7tg0W4+WYe CUK6rSeLJPB56Xh4OE9ZsEne0Y1+PN9jxniRwytKyCx82j90OD2I8rqst1Pj65ymY6uhPx5dKVkvgX y8lIx92PwT7yGSgkAGNVrfyUsLGlcskk5iP/aNcIYWBbfym228lEhugMOaipyR+Ux4w/aIr2bTPQx6 qSCJRWXAKTpl8tS0v3iz1FsbFNyGI053URdrOEfjBfBu553B5i3b6jq3HUYIkmO/R6bOCn2Rk2A5gH 6o7APALWdvy8PWGIsfJQ7NWi3zjgITjjFs4GaPqE8dfgfUTomOl+iWOHK6fwSyNEG4EChfpDbO7/hH w1JOAEP16v3yAui0c/cbML3byjXw7NeekNNF4wc6qZl50=
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

In a future patch, we will start using an ID map that covers the entire
image, rather than a single page. This means that we need to deal with
the pathological case of an extended ID map where the kernel image does
not fit neatly inside a single entry at the root level, which means we
will need to create additional table entries and map additional pages
for page tables.

The existing map_memory macro already takes care of most of that, so
let's just extend it to deal with this case as well. While at it, drop
the conditional branch on the value of T0SZ: we don't set the variable
anymore in the entry code, and so we can just let the map_memory macro
deal with the case where the output address exceeds VA_BITS.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 76 ++++++++++----------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9fdde2f9cc0f..eb54c0289c8a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -122,29 +122,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	b	dcache_inval_poc		// tail call
 SYM_CODE_END(preserve_boot_args)
 
-/*
- * Macro to create a table entry to the next page.
- *
- *	tbl:	page table address
- *	virt:	virtual address
- *	shift:	#imm page table shift
- *	ptrs:	#imm pointers per table page
- *
- * Preserves:	virt
- * Corrupts:	ptrs, tmp1, tmp2
- * Returns:	tbl -> next level table page address
- */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
-	add	\tmp1, \tbl, #PAGE_SIZE
-	phys_to_pte \tmp2, \tmp1
-	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
-	lsr	\tmp1, \virt, #\shift
-	sub	\ptrs, \ptrs, #1
-	and	\tmp1, \tmp1, \ptrs		// table index
-	str	\tmp2, [\tbl, \tmp1, lsl #3]
-	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
-	.endm
-
 /*
  * Macro to populate page table entries, these entries can be pointers to the next level
  * or last level entries pointing to physical memory.
@@ -209,15 +186,27 @@ SYM_CODE_END(preserve_boot_args)
  *	phys:	physical address corresponding to vstart - physical memory is contiguous
  *	order:  #imm 2log(number of entries in PGD table)
  *
+ * If extra_shift is set, an extra level will be populated if the end address does
+ * not fit in 'extra_shift' bits. This assumes vend is in the TTBR0 range.
+ *
  * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
  * Preserves:	vstart, flags
  * Corrupts:	tbl, rtbl, vend, istart, iend, tmp, count, sv
  */
-	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv, extra_shift
 	sub \vend, \vend, #1
 	add \rtbl, \tbl, #PAGE_SIZE
 	mov \count, #0
 
+	.ifnb	\extra_shift
+	tst	\vend, #~((1 << (\extra_shift)) - 1)
+	b.eq	.L_\@
+	compute_indices \vstart, \vend, #\extra_shift, #(PAGE_SHIFT - 3), \istart, \iend, \count
+	mov \sv, \rtbl
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	mov \tbl, \sv
+	.endif
+.L_\@:
 	compute_indices \vstart, \vend, #PGDIR_SHIFT, #\order, \istart, \iend, \count
 	mov \sv, \rtbl
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
@@ -284,20 +273,32 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
 	/*
-	 * VA_BITS may be too small to allow for an ID mapping to be created
-	 * that covers system RAM if that is located sufficiently high in the
-	 * physical address space. So for the ID map, use an extended virtual
-	 * range in that case, and configure an additional translation level
-	 * if needed.
+	 * The ID map carries a 1:1 mapping of the physical address range
+	 * covered by the loaded image, which could be anywhere in DRAM. This
+	 * means that the required size of the VA (== PA) space is decided at
+	 * boot time, and could be more than the configured size of the VA
+	 * space for ordinary kernel and user space mappings.
+	 *
+	 * There are three cases to consider here:
+	 * - 39 <= VA_BITS < 48, and the ID map needs up to 48 VA bits to cover
+	 *   the placement of the image. In this case, we configure one extra
+	 *   level of translation on the fly for the ID map only. (This case
+	 *   also covers 42-bit VA/52-bit PA on 64k pages).
+	 *
+	 * - VA_BITS == 48, and the ID map needs more than 48 VA bits. This can
+	 *   only happen when using 64k pages, in which case we need to extend
+	 *   the root level table rather than add a level. Note that we can
+	 *   treat this case as 'always extended' as long as we take care not
+	 *   to program an unsupported T0SZ value into the TCR register.
+	 *
+	 * - Combinations that would require two additional levels of
+	 *   translation are not supported, e.g., VA_BITS==36 on 16k pages, or
+	 *   VA_BITS==39/4k pages with 5-level paging, where the input address
+	 *   requires more than 47 or 48 bits, respectively.
 	 */
-	idmap_get_t0sz x5
-	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
-	b.ge	1f			// .. then skip VA range extension
-
 #if (VA_BITS < 48)
 #define IDMAP_PGD_ORDER	(VA_BITS - PGDIR_SHIFT)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
-#define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
 
 	/*
 	 * If VA_BITS < 48, we have to configure an additional table level.
@@ -309,20 +310,17 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #if VA_BITS != EXTRA_SHIFT
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
-
-	mov	x2, EXTRA_PTRS
-	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6
 #else
 #define IDMAP_PGD_ORDER	(PHYS_MASK_SHIFT - PGDIR_SHIFT)
+#define EXTRA_SHIFT
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
 	 * translation level, but the top-level table has more entries.
 	 */
 #endif
-1:
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
-	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14
+	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
-- 
2.30.2

