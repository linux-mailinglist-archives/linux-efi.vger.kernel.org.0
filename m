Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9EE4FB833
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbiDKJwB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344817AbiDKJvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A141F8B
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED24061182
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD50C385A6;
        Mon, 11 Apr 2022 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670532;
        bh=crxoRPnQH0+ODL0k8//ShruXGvOuJPs1P54hH/efCN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx+b6a7WclkUItElRcNCWKoxjpVoeDeT0fPdODnVogRT2LiDYqtrsJTptFFGq/zWk
         v8sV+fL+9BIOB1h25JtJhMcVEmWrELeM23fD0Y6o4nIia3ENvge696qdMvhW71ypkD
         Ya47oyB3GI1ZLlpCbQNIQup09sFsqhMVyN+K4LqrPEOZmYdWFmBXPvKS6vntWkyNR2
         zCuyDFoXogk/QVYksEPiI5o5ot5R/BLTRq+teJVku0RV3TwI53r85zFt8afdnVOo5g
         LuPW2cYqu+qvAarHVIvIGrQczuneg8pP8m5D4ELVHXDzl4k+78ad4epQCqurccyj8d
         Nmf8QQ8HlKesA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 04/30] arm64: head: drop idmap_ptrs_per_pgd
Date:   Mon, 11 Apr 2022 11:47:58 +0200
Message-Id: <20220411094824.4176877-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2609; h=from:subject; bh=crxoRPnQH0+ODL0k8//ShruXGvOuJPs1P54hH/efCN4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k8otA5pWFSgQEp9o6nmLZZTu1p+AulYE5Nu77I hmkif+SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5PAAKCRDDTyI5ktmPJIQlDA CccFIuJ6iWKny86UQPxdYrt4FiNKxAPZt+TVyBCo7husaotYUovpobqTcjzPgNvNwwLF8Ktd9mNHor pybKSjnivrHDxEvJXEONznR8lcfd7+sQfyW0tHdQ0B1YzJXthpI5RT1oapJqSRTn0Mh4vijINDndJ9 fj/Ik5S4Jktp8z0hE/nYCy4eJaTWgB9hBij7d/6t0WcRn2SCAM/DNaFY289nDpX4+EcPLtB9kVPk7R hnenPB2BMcL730DsWVmLdxIjzPZDS2NzCvNOsZolyKI+EcM6N48nI4ebLLTco2+5OR17YcqAYh5rbu N5EjOeO/AFma+hc8m7DUAnuZB5MFy/SwSuKZ7JomoOuat2oVsvBq1rqxqtPEP8jGIKREzyuD8z+a9J MfERsBkLs86u5qjidx8P9Q3tWOLiwkI/IJzGRWA+de9G7ivzkP9PKZgY0Yom0j9zGOK2e7c46UL6xX O6/2KsjPt5+wV2JlgwI+C3ErIdq0M33og5mV/KD88TT7s=
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

The assignment of idmap_ptrs_per_pgd lacks any cache invalidation, even
though it is updated with the MMU and caches disabled. However, we never
bother to read the value again except in the very next instruction, and
so we can just drop the variable entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 1 -
 arch/arm64/kernel/head.S             | 7 +++----
 arch/arm64/mm/mmu.c                  | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6ac0086ebb1a..7b387c3b312a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -61,7 +61,6 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
  * physical memory, in which case it will be smaller.
  */
 extern int idmap_t0sz;
-extern u64 idmap_ptrs_per_pgd;
 
 /*
  * Ensure TCR.T0SZ is set to the provided value.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7f361bc72d12..53126a35d73c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -300,6 +300,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * range in that case, and configure an additional translation level
 	 * if needed.
 	 */
+	mov	x4, #PTRS_PER_PGD
 	idmap_get_t0sz x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
@@ -319,18 +320,16 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 
-	mov	x4, EXTRA_PTRS
-	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+	mov	x2, EXTRA_PTRS
+	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6
 #else
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
 	 * translation level, but the top-level table has more entries.
 	 */
 	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
-	str_l	x4, idmap_ptrs_per_pgd, x5
 #endif
 1:
-	ldr_l	x4, idmap_ptrs_per_pgd
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
 	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a6732da20874..0618ece00b7e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -44,7 +44,6 @@
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
 int idmap_t0sz __ro_after_init;
-u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 #if VA_BITS > 48
 u64 vabits_actual __ro_after_init = VA_BITS_MIN;
-- 
2.30.2

