Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D64FB86B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbiDKJwR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344707AbiDKJwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F41419AA
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9016115F
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D042C385A4;
        Mon, 11 Apr 2022 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670563;
        bh=NkID3D8eKoGtatSQ1Pem1naBXL+jY6mndM5eYFvzQoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is+HGYUCBWze5mNGvvEvsq+Z9zj67ZMJUGix+5oVP0+NgNNbJDqJSw5KuDABGdbQy
         QXAqXW8h3rK6ceRwmcr5loLg742FhqQ1/e2wZTz7+ry/k4AkoTZVKhkuOJGy6Rms0+
         LbjL/eTXdaRNMVk2WRc47YGeALU+MC+YsvNFL8DhQ6bmXdH5xyp2jPp2UATU1Q2t+R
         0UmKJo3oBbGynXI5uauKWtYCCD0JO+b0t8pdB45x1/SqbpHbUFp94zK5brP2565w3x
         W7u4NQKYP6PjbpEPA/ONgDA8bu2EoYp8dEPJoDCdWjbz2o1JQEjwcoSVNJCNHP/YDG
         Yzh6I0F613RKA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 17/30] arm64: head: populate kernel page tables with MMU and caches on
Date:   Mon, 11 Apr 2022 11:48:11 +0200
Message-Id: <20220411094824.4176877-18-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236; h=from:subject; bh=NkID3D8eKoGtatSQ1Pem1naBXL+jY6mndM5eYFvzQoI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lR6D+qiYYkrj3l97ekye1ey0iZcFdFhgKKY8tM nTT6HKOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5UQAKCRDDTyI5ktmPJHo+C/ 9JBSsGNARpUsDK/iEL91eIay4XNqPJHshSrfZeBcoCKx7LnUhUB6Fh3VvTLXR0h4E9D912gJgPst6k gOe4Sk6vCBqxm3v20aFibkez7JaJ6r6BCRx8nHNT8ctVLjW7z33Oohg4bcYwnQHJusZjz1VXwqGce9 KBBDTcDk6rvRBAyfZ6f1yKelwxVhzb6X5zvxEzIaP8l2RTQwvztkzOvzq01ec1EV99I91uSYZLNfjd 2Qfr0/PfPDpe2rfTfIs8/wHEOoPir/NdXOhgF6WxgGESPFLPST+a5D50jG2qPpyz9V4ESyvfXMIHT1 +aO1c29HDW5xb46RiE57NQrSy+8IzB7lo9VjivW8eLzmMQJpWS6zUJZuqccBd4SyPg8c3H8pZOC+4l uI3XqKK+5B6iTl2XRky41rxNOnTmx1MXXdM33z4MeuPggk/9WN2YZnCE6qWyF0OOzz/uFQ0sRyfwdA Tc7gN4hDnFKQktAIdJz3A49JzHkjFEBLZyyU78S4Kmlx8=
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

Now that we can access the entire kernel image via the ID map, we can
execute the page table population code with the MMU and caches enabled.
The only thing we need to ensure is that translations via TTBR1 remain
disabled while we are updating the page tables the second time around,
in case KASLR wants them to be randomized.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 61 +++++---------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e52429f9a135..f9f4af64d1fc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -85,8 +85,6 @@
 	 *  x19        create_idmap() .. __ start_kernel()      ID map VA of the DT blob
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x28        clear_page_tables()                      callee preserved temp register
-	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
@@ -96,9 +94,7 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	clear_page_tables
 	bl	create_idmap
-	bl	create_kernel_mapping
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -128,32 +124,14 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
-	mov	x28, lr
-
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
 	/*
 	 * Clear the init page tables.
 	 */
 	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
-
-	ret	x28
+	sub	x2, x1, x0
+	mov	x1, xzr
+	b	__pi_memset			// tail call
 SYM_FUNC_END(clear_page_tables)
 
 /*
@@ -397,16 +375,7 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
-	/*
-	 * Since the page tables have been populated with non-cacheable
-	 * accesses (MMU disabled), invalidate those tables again to
-	 * remove any speculatively loaded cache lines.
-	 */
-	dmb	sy
-
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	b	dcache_inval_poc		// tail call
+	ret
 SYM_FUNC_END(create_kernel_mapping)
 
 	/*
@@ -866,14 +835,15 @@ SYM_FUNC_END(__relocate_kernel)
 #endif
 
 SYM_FUNC_START_LOCAL(__primary_switch)
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x19, x0				// preserve new SCTLR_EL1 value
-	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
-#endif
-
-	adrp	x1, init_pg_dir
+	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
+
+	bl	clear_page_tables
+	bl	create_kernel_mapping
+
+	adrp	x1, init_pg_dir
+	load_ttbr1 x1, x2
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
 	mov	x24, #0				// no RELR displacement yet
@@ -889,9 +859,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x20			// disable the MMU
-	isb
+	adrp	x1, reserved_pg_dir		// Disable translations via TTBR1
+	load_ttbr1 x1, x2
 	bl	clear_page_tables
 	bl	create_kernel_mapping		// Recreate kernel mapping
 
@@ -899,8 +868,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	dsb	nsh
 	isb
 
-	set_sctlr_el1	x19			// re-enable the MMU
-
+	adrp	x1, init_pg_dir			// Re-enable translations via TTBR1
+	load_ttbr1 x1, x2
 	bl	__relocate_kernel
 #endif
 #endif
-- 
2.30.2

