Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822254FB836
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiDKJwI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344835AbiDKJv4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35841327
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB73CB8119E
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966AFC385A4;
        Mon, 11 Apr 2022 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670539;
        bh=OhKluuvrPX/ZIKI6cSSrnjwjMiDdvqkJIcBzUOSbddk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBX62F5Wb6q9terO3pGcKDNNUhIWzFFx8vukUGrfjPAj1xYDIC+XA+/XPDHA63kb1
         1pflSiT4DZc9s++ZbEyqUS0wjBDHDRn2QJf5iJ0ZlxpWnhJMymyaR77fspyjs5kLQL
         nzzG15rZfWIbtVvBGuwnAM4TLFhSctmzS/BiUpTs9CtmJ4KYwwnp6DvHBPzMWaUdET
         Pxc/eKrFbY/BjeV/shbiBWY4ZetuOqN9mC+u8Bc/iCRpP3TdAWoQazhOSerB7WWzA8
         38NJ+guWf2+DCMkeGZ8S7A9ZknzYUc30oYbckXA1DMTlTIrK6d+ax3bCCW2cXiezBs
         vQhU/s0aJOdDA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 07/30] arm64: head: split off idmap creation code
Date:   Mon, 11 Apr 2022 11:48:01 +0200
Message-Id: <20220411094824.4176877-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5970; h=from:subject; bh=OhKluuvrPX/ZIKI6cSSrnjwjMiDdvqkJIcBzUOSbddk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lABkB7RbgceET9//c1e3q1KM8XQiA2SuRu0Jut Lucg722JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5QAAKCRDDTyI5ktmPJIxwDA CVOTeNOWP0F9RBRumUbmOai/qMGkh7SZ7CPmXGuC/jSz/pBR3PZxKA69aidyXP3DTZyQXp2TxECSIv OoEdG7vRawMboEY0euW9PHo1bPXeeOOwPK0JioU7HEH1h8rvIZu4Ivp76HNSkFBFlPklvwZ9jAvukO DqFpFRbD2w4tTOlTe9maABUUiweg1ULo1QipfpYPJNN1u5Hxd7S8KaF0CG0ybu3/5H9o4Ou6DBAbDW 4alH19NBTYpl23te0PusjQwDsFRaIVz/VB7F7yQw4Y+DEEhNmBFmQiaCQJazdcywK4wt2dxnvUJIFS cLbzr85clKaM2aHGKF19ff9UPjY0puGug907BeQAXawXO5YfcJtIvonbOACuNfnmGsP2dU17u++a5k ELt2HUYFl3zGzljTqzZJiDIR+e+TbDr08EkUIAB/zk3gQvBWDtD6bLaohcrbpSWV5Dqhw27O5CisN6 UyrvMgn3YI0tuDQ84vzbhwF73opdpXu+5yVi64jPPyO00=
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

Split off the creation of the ID map page tables, so that we can avoid
running it again unnecessarily when KASLR is in effect (which only
randomizes the virtual placement). This will permit us to drop some
explicit cache maintenance to the PoC which was necessary because the
cache invalidation being performed on some global variables might
otherwise clobber unrelated variables that happen to share a cacheline.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 101 ++++++++++----------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index eb54c0289c8a..1cbc52097bf9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -84,7 +84,7 @@
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x28        __create_page_tables()                   callee preserved temp register
+	 *  x28        clear_page_tables()                      callee preserved temp register
 	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
 	 */
@@ -94,7 +94,10 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	__create_page_tables
+	bl	clear_page_tables
+	bl	create_idmap
+	bl	create_kernel_mapping
+
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
 	 * details.
@@ -122,6 +125,35 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	b	dcache_inval_poc		// tail call
 SYM_CODE_END(preserve_boot_args)
 
+SYM_FUNC_START_LOCAL(clear_page_tables)
+	mov	x28, lr
+
+	/*
+	 * Invalidate the init page tables to avoid potential dirty cache lines
+	 * being evicted. Other page tables are allocated in rodata as part of
+	 * the kernel image, and thus are clean to the PoC per the boot
+	 * protocol.
+	 */
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	bl	dcache_inval_poc
+
+	/*
+	 * Clear the init page tables.
+	 */
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+1:	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	subs	x1, x1, #64
+	b.ne	1b
+
+	ret	x28
+SYM_FUNC_END(clear_page_tables)
+
 /*
  * Macro to populate page table entries, these entries can be pointers to the next level
  * or last level entries pointing to physical memory.
@@ -231,44 +263,8 @@ SYM_CODE_END(preserve_boot_args)
 	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
-/*
- * Setup the initial page tables. We only setup the barest amount which is
- * required to get the kernel running. The following sections are required:
- *   - identity mapping to enable the MMU (low address, TTBR0)
- *   - first few MB of the kernel linear mapping to jump to once the MMU has
- *     been enabled
- */
-SYM_FUNC_START_LOCAL(__create_page_tables)
-	mov	x28, lr
 
-	/*
-	 * Invalidate the init page tables to avoid potential dirty cache lines
-	 * being evicted. Other page tables are allocated in rodata as part of
-	 * the kernel image, and thus are clean to the PoC per the boot
-	 * protocol.
-	 */
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	bl	dcache_inval_poc
-
-	/*
-	 * Clear the init page tables.
-	 */
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
-
-	mov	x7, SWAPPER_MM_MMUFLAGS
-
-	/*
-	 * Create the identity mapping.
-	 */
+SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
@@ -319,12 +315,23 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 #endif
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
 	/*
-	 * Map the kernel image (starting with PHYS_OFFSET).
+	 * Since the page tables have been populated with non-cacheable
+	 * accesses (MMU disabled), invalidate those tables again to
+	 * remove any speculatively loaded cache lines.
 	 */
+	dmb	sy
+
+	adrp	x0, idmap_pg_dir
+	adrp	x1, idmap_pg_end
+	b	dcache_inval_poc		// tail call
+SYM_FUNC_END(create_idmap)
+
+SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
@@ -332,6 +339,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
@@ -342,16 +350,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 	dmb	sy
 
-	adrp	x0, idmap_pg_dir
-	adrp	x1, idmap_pg_end
-	bl	dcache_inval_poc
-
 	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
-	bl	dcache_inval_poc
-
-	ret	x28
-SYM_FUNC_END(__create_page_tables)
+	b	dcache_inval_poc		// tail call
+SYM_FUNC_END(create_kernel_mapping)
 
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
@@ -836,7 +838,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
-	bl	__create_page_tables		// recreate kernel mapping
+	bl	clear_page_tables
+	bl	create_kernel_mapping		// Recreate kernel mapping
 
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
-- 
2.30.2

