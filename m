Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979FA4EC894
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348339AbiC3PoK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348347AbiC3PoJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACDD33E9E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37EFB61727
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428FBC34118;
        Wed, 30 Mar 2022 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654943;
        bh=mlE7in6kp8AxPXbRmgxis3u7A1nYOdCcJHiVv3g+5g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI810+obTsHfHWryaVinmb3+le8TZnhFjBfncMoIT0yDFWcQFZYOycFaMX11Kk6aa
         XG/A37UEta5mciqPXVwe20q2tTKoYQd7wufzuiqRxmmJty5g/5qpPMUqqmUbMw2FsW
         FcH5ekjHILZQ2zsdaoxEMihH/8s2c9y/xNYzJ8DefIGIHyePr/1gNxYf4r1SdskDEc
         DV0mE8xqq/JeFffpUp2LA3h9CFt+2m94seaTHVTh5V+Gc6DluLHFEpQoQ7d2DGfAju
         PbzNxjxQDiJUWF0Y0plebCbl/tl8VVDkq1JFZuLn1tb82dGlrt2yA7aOdt08JDQ23y
         OvITNoUzRj5uA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 06/18] arm64: head: populate kernel page tables with MMU and caches on
Date:   Wed, 30 Mar 2022 17:41:53 +0200
Message-Id: <20220330154205.2483167-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911; h=from:subject; bh=mlE7in6kp8AxPXbRmgxis3u7A1nYOdCcJHiVv3g+5g4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo4/2sEZOXX/GDehtECXU7Si/1bIpoAUjef9zQC AV2Eo6iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6OAAKCRDDTyI5ktmPJO9qC/ 0Zh/uF0Y7I/Ah3uDuqKfksmeg1Yn05fO9wAGuPIVUfCE6zwkQ/VXkHtkgdgAEuxS3zI6zgihZaeMEZ BrpQiX+zmyj9HAGht0VmX0ZFNB9Yn4F/pt9hRxc3z7LcrzvgRedRGXQrcqTkE3XEVrul5xAu/dDeEr ZhOc9xRgpXb8YlerEb843qOdhlj/8r6n56N0Q/jeztCBNh5vcC2LYQVxSlcri181O8JWj3Z4cpxCO5 jmQLOZqmXl26K1Rgtw0Gt/N4K2z1xLtpj/hhgW4iiXLLOpdnf2Ayl6ZgA5jBQ4BeEMb+O7iNzi7GvR DhDtC23VE9KO6DuGeocye8R4Ihc/JBHLIwo0Wx7MBNK4JFcVpBrk1GbJ+Ctg4XconaX8Oxpvnvx4tH uFYY7tc/YLNTpBA8hmUOUIYDL5ZsetameFU09YtC0REEMi8DqQwn8pm/SnTVRydn1qj/7VpokherFa ptUKR1luRZBzb4RqoOVIb75AA8kHmakhVpu0WgD3Q31/g=
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
 arch/arm64/kernel/head.S | 48 +++++---------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7c4aefacf6c2..5d4cb481e42f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -84,8 +84,6 @@
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x28        clear_page_tables()                      callee preserved temp register
-	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
 	 */
 SYM_CODE_START(primary_entry)
@@ -94,9 +92,7 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	clear_page_tables
 	bl	create_idmap
-	bl	create_kernel_mapping
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -126,18 +122,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
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
@@ -151,7 +135,7 @@ SYM_FUNC_START_LOCAL(clear_page_tables)
 	subs	x1, x1, #64
 	b.ne	1b
 
-	ret	x28
+	ret
 SYM_FUNC_END(clear_page_tables)
 
 /*
@@ -381,16 +365,7 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 
 	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
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
@@ -862,13 +837,13 @@ SYM_FUNC_END(__relocate_kernel)
 #endif
 
 SYM_FUNC_START_LOCAL(__primary_switch)
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x19, x0				// preserve new SCTLR_EL1 value
-	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
-#endif
+	adrp	x1, reserved_pg_dir
+	bl	__enable_mmu
+	bl	clear_page_tables
+	bl	create_kernel_mapping
 
 	adrp	x1, init_pg_dir
-	bl	__enable_mmu
+	load_ttbr1 x1, x2
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
 	mov	x24, #0				// no RELR displacement yet
@@ -884,9 +859,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
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
 
@@ -894,8 +868,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
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

