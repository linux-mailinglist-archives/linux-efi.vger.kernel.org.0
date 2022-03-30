Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD064EC893
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiC3PoJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiC3PoG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2533E3E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9111F61562
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906F7C340F2;
        Wed, 30 Mar 2022 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654940;
        bh=c6iRYtAbo4zUXLvlyPL5mdWMCH5xxMM/KqJwOLjBhFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGM4OE8iUs2dTV3Li+2QCehHoWLE5Hfp/1lNKWqux4NMiIXtNUtcvuSHwJ0cithwq
         lBpHzfqCeeFlWckA1d6Hz8m3PD1kNtgRu7Ln16vG7vXA7Wsj/jFD2lF0gbqSvMUfO3
         NP0pXqEFszKZhRNVWzxKFNdwu25HT4MjjwWo3U9pIL16Mj3vj2b+QPvH2jzATecI4u
         W/8BNBN6iTI4q/NXuOB7V6NQHXNR5ciB64r7LOvKFI5LbshM4h985NLNql0vtrcclV
         ARjGOAq2QFTsCtiJFUIqr4uE+aFX0bUxYgy+znPGVGnXqmdlY/SpCYdbhy3TSrSTjb
         UpVR5+SAYh94g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 04/18] arm64: head: cover entire kernel image in ID map
Date:   Wed, 30 Mar 2022 17:41:51 +0200
Message-Id: <20220330154205.2483167-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; h=from:subject; bh=c6iRYtAbo4zUXLvlyPL5mdWMCH5xxMM/KqJwOLjBhFA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo1bwvcFKr9aJYAFLwhx72X6WP77BHK5U7s1aXY iI6OdOuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6NQAKCRDDTyI5ktmPJFfBC/ 9ioYg7jfchoEqb2LfzWB/OTkgGcnJdBDUVkCn1V4WqhDm4AjW/bJ9tTwdrkzzngucwbo+czZdezmzd nDJ8AMsh2Fa11XJ65JGrDrU9zhCoFOD0ThFUa+rCBFaOWxFc+pZJbsCTWzKFxbufsz9GnM048UnBs2 XSrAl2rkGctFqe45M5/lLJbSNhGIgEmI23uNlFkgjDB2MHas6pdOvDoTSc2114tY9xhmXeY8+W2n4c /XUplmxgQ863qNFgnnVrJfdBjg4M7IQLvFY2ReT34kFXFyL0PnafJ7mQXEeBx72OYgpoQrkDYoIQbc YOqGgfhNMQB4pgNNgD3d/euCEumC5daNmLPXo45foz5FleZQdd1C4v4TP9OHhXj4ihgJJlH0WSamSw ortlOB1XPSgUlfTVolRLcjEdHq5sRq00C2w6IvxnEhTwg+UVe86kfObwZJ4HHkVfgTIPgefQN7MZuR 1ies9362rUr7Iit6hW5lpwAG0AJ9wj/JzzYIAXX0SRmA8=
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |  2 +-
 arch/arm64/kernel/head.S                | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 96dc0f7da258..b62200a9456e 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -87,7 +87,7 @@
 			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
 			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
 #define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end))
-#define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		INIT_DIR_SIZE
 
 /* Initial memory map size */
 #if ARM64_KERNEL_USES_PMD_MAPS
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 275cd14a70c2..727561972e4a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -287,7 +287,7 @@ SYM_FUNC_END(clear_page_tables)
 
 SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
-	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
+	adrp	x3, _text			// __pa(_text)
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
@@ -312,10 +312,10 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
 	 * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
 	 * this number conveniently equals the number of leading zeroes in
-	 * the physical address of __idmap_text_end.
+	 * the physical address of _end.
 	 */
 	mov	x4, PTRS_PER_PGD
-	adrp	x5, __idmap_text_end
+	adrp	x5, _end
 	clz	x5, x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
@@ -351,7 +351,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
 #endif
 1:
-	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
+	adr_l	x6, _end			// __pa(_end)
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
@@ -884,7 +884,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
 	bl	clear_page_tables
-	bl	create_kernel_mapping		// recreate kernel mapping
+	bl	create_kernel_mapping		// Recreate kernel mapping
 
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
-- 
2.30.2

