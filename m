Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E54FB832
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiDKJv7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbiDKJvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72C4198F
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93996611BE
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062EC385A3;
        Mon, 11 Apr 2022 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670530;
        bh=1i7oWF7CpW4iPsr714tfW2VvgBXGaNXD89YtNIdsq0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okFbbwDOhm0nSobcfzN7IlqWu5n6slQcUeAcDl1d4MMcwSdnCE0tTj4MAu6UDtMSq
         3Ptx+9igAMkqPQjPQy4TqqOgPd8vqOXnL5lSljymVknRjQcUOKWfNgNHfRVfwYj37c
         SvomTly4DQlMNToYlt4pIfQdjb4H5tdlcjGYLVeYIILJ6cIbqwtW9lcarkvZeEvsaI
         h3dpNu9S/CzxlR44WTWSWJL0654Idr7Np5N7J8+KjuHDuJpttimzfKYQd+4joZ74Ej
         LxgVFohsqaoXd7hAB8jrTqTF8ISjxYZkXpfl9qSvuYe+B8ps3YG5iSNNa0D/8kKsEL
         e1aGe5IqIU5ow==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 03/30] arm64: head: move assignment of idmap_t0sz to C code
Date:   Mon, 11 Apr 2022 11:47:57 +0200
Message-Id: <20220411094824.4176877-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4319; h=from:subject; bh=1i7oWF7CpW4iPsr714tfW2VvgBXGaNXD89YtNIdsq0s=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k69ea2mRWPz5W9fWAfs/UuHghgQiSWcGvgl+mo ZL4fpWqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5OgAKCRDDTyI5ktmPJIhVC/ wMgIpoXcKoZcbC7uQ58fUkU1FhnBHEn3B/NIu3VFWmFL7viWkKGqlDqQqcwyP9nLwxtDhFm7LXkB0s pmnCa4ERlnW1EsW+ONOAEpoQt65+7XgSPqqM96VTg6D1eVixm3+XEq4z2FdoudQDJDwKkdu+NbcRUh uNQKDTqSIXgNDKjNyLoXudGbc96kjF6H7RiWqkqyt3LPKLzEIwhBCfs9jsM/iy0FdQGxKX5Dd2bCSs ln4HlMBZIF/s2iFUvQVJvMMR2PhHN/jnUR0icy3zpl7Iy1ykhd45/zZoL+p/RNtQbA7ty0yOINo166 oOx6B/1jC43fOc6l1dtj2ZubtJXlTZLpMDF8yCBiQ533h6bGHzLM4/S/hiEa35wC98SGPx33wqsFL6 4BseGZfzWY4yDUWl1O/k1VXdt9OLd58Tq6naZ7k8GFGDtHFNmm1vM+QOn8qTJdQsGK1VmsicVsjGEm R02ShZI/haQnzJ0R/o7kQgTETSIs6OOUmCmjteczIJ3Iw=
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

Setting idmap_t0sz involves fiddling with the caches if done with the
MMU off. Since we will be creating an initial ID map with the MMU and
caches off, and the permanent ID map with the MMU and caches on, let's
move this assignment of idmap_t0sz out of the startup code, and replace
it with a macro that simply issues the three instructions needed to
calculate the value wherever it is needed before the MMU is turned on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h   | 14 ++++++++++++++
 arch/arm64/include/asm/mmu_context.h |  2 +-
 arch/arm64/kernel/head.S             | 13 +------------
 arch/arm64/mm/mmu.c                  |  5 ++++-
 arch/arm64/mm/proc.S                 |  2 +-
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8c5a61aeaf8e..9468f45c07a6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -359,6 +359,20 @@ alternative_cb_end
 	bfi	\valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
+/*
+ * idmap_get_t0sz - get the T0SZ value needed to cover the ID map
+ *
+ * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
+ * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
+ * this number conveniently equals the number of leading zeroes in
+ * the physical address of _end.
+ */
+	.macro	idmap_get_t0sz, reg
+	adrp	\reg, _end
+	orr	\reg, \reg, #(1 << VA_BITS_MIN) - 1
+	clz	\reg, \reg
+	.endm
+
 /*
  * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
  * ID_AA64MMFR0_EL1.PARange value
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6770667b34a3..6ac0086ebb1a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -60,7 +60,7 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
  * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
  * physical memory, in which case it will be smaller.
  */
-extern u64 idmap_t0sz;
+extern int idmap_t0sz;
 extern u64 idmap_ptrs_per_pgd;
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index dc07858eb673..7f361bc72d12 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -299,22 +299,11 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * physical address space. So for the ID map, use an extended virtual
 	 * range in that case, and configure an additional translation level
 	 * if needed.
-	 *
-	 * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
-	 * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
-	 * this number conveniently equals the number of leading zeroes in
-	 * the physical address of __idmap_text_end.
 	 */
-	adrp	x5, __idmap_text_end
-	clz	x5, x5
+	idmap_get_t0sz x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
 
-	adr_l	x6, idmap_t0sz
-	str	x5, [x6]
-	dmb	sy
-	dc	ivac, x6		// Invalidate potentially stale cache line
-
 #if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2018e75974ca..a6732da20874 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,7 +43,7 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
-u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
+int idmap_t0sz __ro_after_init;
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 #if VA_BITS > 48
@@ -782,6 +782,9 @@ void __init paging_init(void)
 			       (u64)&vabits_actual + sizeof(vabits_actual));
 #endif
 
+	idmap_t0sz = min(63UL - __fls(__pa_symbol(_end)),
+			 TCR_T0SZ(VA_BITS_MIN));
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 50bbed947bec..e802badf9ac0 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -469,7 +469,7 @@ SYM_FUNC_START(__cpu_setup)
 	add		x9, x9, #64
 	tcr_set_t1sz	tcr, x9
 #else
-	ldr_l		x9, idmap_t0sz
+	idmap_get_t0sz	x9
 #endif
 	tcr_set_t0sz	tcr, x9
 
-- 
2.30.2

