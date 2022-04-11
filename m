Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53844FB874
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbiDKJw3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344787AbiDKJvv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427484198E
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA9C4B81199
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5156C385AF;
        Mon, 11 Apr 2022 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670527;
        bh=nnF7M7PcH7AGljFxhk+1kS0DWN9btzeG7hbQYqOxYrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHn/66Dcqkmue8O9qjtSGu/PRWu/RIuh+0yc8Mya99Ex6qDyj1+ooe9IUIMalhi1y
         zQkOcoDq2TC+A9FcwraXhNmBjLP8+rEw0sLTYbtvPsIR9iEvG1AcyqsL9St/aRIPTt
         q6wMHskOTTYf6LYOtTfMwwb4pi/4ZNgU9wEtL2HLhX1+/hfU9I0OckQJbeqV/9Oo1t
         noH2k88MIcraef6yNFs+m0rsk1NV307A3nACrEQ0XyafCXIRX/ZzyDR4W0tbhwiaIc
         RVc6QaYmdesSfNAJNlNyNM5HOh2vYSEGFmgprRlzrihOqtgYpswkIepHue4cQIEqMn
         BRhmgi/C2Nd3g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 02/30] arm64: mm: make vabits_actual a build time constant if possible
Date:   Mon, 11 Apr 2022 11:47:56 +0200
Message-Id: <20220411094824.4176877-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103; h=from:subject; bh=nnF7M7PcH7AGljFxhk+1kS0DWN9btzeG7hbQYqOxYrQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k49z3HshtZskOsuOPow52IVZV3y9S8oWY9dDxR 1KfkHXKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5OAAKCRDDTyI5ktmPJE04C/ 42FMvcJRjeULojkYUP5mu6KQ5dvmOxDO5LCDKnAogTTJ0wyfSG7RdIr5MMvr2SqEGlYBwuqUTAcLzX zFMAat4VLbUZj3sJgKQBWpML3WCv8ZTqj9ig3eQwtG/+uDiPcw0toKxfIDg9lQYfhAUA0dGcNh32Oj aNzEs4+cja+CztoE9vpJaBWkruYYrwhcN3VEH7e9cvunA6ZVi1kAtFZzhWrPfrsHaB20f9yBkEhUWN N6WJYt/F/PH3AePPGCOyasLu9YsASaUU+gZ6IM/puZ/SnZcXcfa/bD8jiaHXJA+1lVdlQWZ2a6rbpx uT0ataOYqe18w4Qeub8r8VMQSJHC3V/7EBujcfVAqrrnqPrN2MTWqH8dEGxcVFMdQKPXVq7DjJWAgQ L+u9y/9bbpgs+tB1J0x19xrcAJMRAvbvn9rvnN4SrR9uNXSSAtUizMuflfWsmTKM6162/9ue4nJQNP rmBWgUdUtzg4yEoJKnS/S8thdSt4dUFD8lEafCv/27i9Q=
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

Currently, we only support 52-bit virtual addressing on 64k pages
configurations, and in all other cases, vabits_actual is guaranteed to
equal VA_BITS (== VA_BITS_MIN). So get rid of the variable entirely in
that case.

While at it, move the assignment out of the asm entry code - it has no
need to be there.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h |  4 ++++
 arch/arm64/kernel/head.S        | 15 +--------------
 arch/arm64/mm/mmu.c             | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..c751cd9b94f8 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -174,7 +174,11 @@
 #include <linux/types.h>
 #include <asm/bug.h>
 
+#if VA_BITS > 48
 extern u64			vabits_actual;
+#else
+#define vabits_actual		((u64)VA_BITS)
+#endif
 
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1cdecce552bb..dc07858eb673 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -293,19 +293,6 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
-#ifdef CONFIG_ARM64_VA_BITS_52
-	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
-	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
-	mov	x5, #52
-	cbnz	x6, 1f
-#endif
-	mov	x5, #VA_BITS_MIN
-1:
-	adr_l	x6, vabits_actual
-	str	x5, [x6]
-	dmb	sy
-	dc	ivac, x6		// Invalidate potentially stale cache line
-
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
@@ -713,7 +700,7 @@ SYM_FUNC_START(__enable_mmu)
 SYM_FUNC_END(__enable_mmu)
 
 SYM_FUNC_START(__cpu_secondary_check52bitva)
-#ifdef CONFIG_ARM64_VA_BITS_52
+#if VA_BITS > 48
 	ldr_l	x0, vabits_actual
 	cmp	x0, #52
 	b.ne	2f
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fde2b326419a..2018e75974ca 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,8 +46,10 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+#if VA_BITS > 48
+u64 vabits_actual __ro_after_init = VA_BITS_MIN;
 EXPORT_SYMBOL(vabits_actual);
+#endif
 
 u64 kimage_vaddr __ro_after_init = (u64)&_text;
 EXPORT_SYMBOL(kimage_vaddr);
@@ -769,6 +771,17 @@ void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
 
+#if VA_BITS > 48
+	if (cpuid_feature_extract_unsigned_field(
+				read_sysreg_s(SYS_ID_AA64MMFR2_EL1),
+				ID_AA64MMFR2_LVA_SHIFT))
+		vabits_actual = VA_BITS;
+
+	/* make the variable visible to secondaries with the MMU off */
+	dcache_clean_inval_poc((u64)&vabits_actual,
+			       (u64)&vabits_actual + sizeof(vabits_actual));
+#endif
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
-- 
2.30.2

