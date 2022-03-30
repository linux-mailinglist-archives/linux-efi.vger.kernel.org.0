Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78954EC890
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiC3PoG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiC3PoE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29533E0A
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 835F1B81D6C
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFDAC340F0;
        Wed, 30 Mar 2022 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654936;
        bh=1RGgIYkJzMKOK6H4zT0uJAGD/fEmshmpfZYVR6Ez7YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/dykukBVQCwUdpqkVfQ5+FWd+9ClF46VDw2pSZOgLg7phIG+n2T11j3/PZiUPn1v
         IIAdMQ1z4Ro62d8G/Pe6MFlrHDNHUPgI5aVdgbgJc4LdwtQWCV56riFQ6BMhgTclWd
         yWwkAogImQbVwYl4olG1BmUdrod0GLi9DBxLffDwHdupWUbncf61F6d+di7cY9AHhN
         tDtZ2n410gOg83KqTEA5uExzlhdEaJsNujG9gOrfXMHuHAXvRpj2e9RGPRSfn70N2e
         4iM6lNeesdzm4PUc7avdKD9dDrskFuNV50piGfN1EV78WnZwE5knJVtwZUoC3ePZlP
         A3w7SjX3S6CzA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 02/18] arm64: head: split off idmap creation code
Date:   Wed, 30 Mar 2022 17:41:49 +0200
Message-Id: <20220330154205.2483167-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5833; h=from:subject; bh=1RGgIYkJzMKOK6H4zT0uJAGD/fEmshmpfZYVR6Ez7YU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHox/YZB+W3jSlgP1/vvwe92Hgoxw3EU7ALxZtEH ShywPCeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6MQAKCRDDTyI5ktmPJJ/uDA CfmmpKX0vmqVPFIFnkpzPRGTF1hHjEA3fQtSj13xpjRxy7IrhgzzVBTuGnXn6D9Bvr+R3RB3NVaQGw vqvu+Rq3gR2T7oyGRPM741zb7CPD0JSkQNhHDzenXm49l6yw2AEmKCLMzhkuviWc8eWeAMCYMiZG7D 2NM6DicgmhMU2g5dv3gpkD/cQc/sxVdiHZO6lUH5kocyOgV/aaY6aaku5iYskspn18b/SPfTm7oRhn BhaChJezGIAjXxP3IExajDFSJ2XgTJVhIJhDKzUk+hDTzulFiwe2WqgqhE0whJNCs0r2LZvZzyoIST VhAa4AfI31p5gRs6bGhg8S84eRzXyrewg0cwzixw4L42UiTxOKg3J5mT2wmoiK5sVLPCVn1akif9Jd cyta+wuLPTbjLn9PPivrdOv5qVJcaLj1yb2Y3BWqFSK7HZ/FHdUY9WRL6OnVLk7hWOV4jhM1V4s/u7 BuXqDv8fiLAuucM+Gdu/DrwBJjVK0CyVLUBVzeygu1djM=
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
index 127e29f38715..275cd14a70c2 100644
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
  * Macro to create a table entry to the next page.
  *
@@ -252,44 +284,8 @@ SYM_CODE_END(preserve_boot_args)
 	populate_entries \tbl, \count, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
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
 
@@ -356,12 +352,23 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #endif
 1:
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
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
@@ -370,6 +377,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
@@ -380,16 +388,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
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
@@ -881,7 +883,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
-	bl	__create_page_tables		// recreate kernel mapping
+	bl	clear_page_tables
+	bl	create_kernel_mapping		// recreate kernel mapping
 
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
-- 
2.30.2

