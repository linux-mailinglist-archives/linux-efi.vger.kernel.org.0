Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757B14EC88F
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiC3PoB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiC3PoA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23833E0A
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083BA616D1
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12330C34112;
        Wed, 30 Mar 2022 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654934;
        bh=uNVpd+BcO15TfkQMvEjdAPTLmgNpGrNTiCbvCKq3dY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRb1JIQcex+u3P3bTToCz/ZXzgIc4JFUFWBw7LGmDaC5jV9voAvaVb2jXZfW5o72E
         QzI1DeMuV5y+hny/9l3mJzJ06pyTV+8LGmGgVzq528qum4A9+CNJNOOBPdSMkoZHo0
         FI6IUi2UBN2qJSC4InubUtNeJZO5G3rvs1Q/B4DGWOckJsWOybMSVFF+b0Amg2ThPG
         ZuMdk5WDjZqX/1xMjGx0xUKqJLdg0VBPYyz7PsTEWWzUpJs5uwLaCkEUg8D6ZfZA38
         mpHU0VLbFGloERSOx7JWCEBHxgvVSIR39yAPHnBwwzhexOjeCIipFtovQAAJJSAXoh
         2sNnES/rcVMtg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 01/18] arm64: head: drop idmap_ptrs_per_pgd
Date:   Wed, 30 Mar 2022 17:41:48 +0200
Message-Id: <20220330154205.2483167-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; h=from:subject; bh=uNVpd+BcO15TfkQMvEjdAPTLmgNpGrNTiCbvCKq3dY4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHowjDNUTuBzPDhj4tlrcnrufU18eJ0Y2QTq8ucm sqP5WaWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6MAAKCRDDTyI5ktmPJBZJDA CTSp+PWIMaN/3XJAbyd2n6gJ9iLXY2j8OpCD7V8ippIWkmw/Jsl1E8UmxDIhHRLO0upjnVkdQgOMkG gj8fpVM8Oy6/h6nD2l30bob6HIpljdnTozXpJYSsYUI0ATnG4QAVs/PvUQ//s+j0c71jWtiXPdkPJu DaJK+w77dD0nuIvvMunGa3iPtwH/VCSMQ01PH7+Ca0ItAq32zrQef4QH5rztegzCi64K4eS42LlyZL cWSIQ6bxhT1OuFAMrytfnbDhZwjR/F9HYFO/mYQr9VbGYoY/TVL36UF5TfLF5k91AaJcINnqUKJ3EH R/n8x759FK8AYsFih7ibbc9W1EDumJrUtxJbPOrd+Mkh5/avHC9k4lz3vZHMQuY24NxAMMdNn0oJkl bg8avvRtQQGGblzLAgvUxfKeKvvzdYjiZ7g0PY7gZmyR/qdugL8GdlTdeZtmG3YVLlLbJDnUfPhIo7 eIV68gkUfbvcfUnV8TZ22Vz212So1jWpcFkmG6qpyDIno=
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
 arch/arm64/kernel/head.S             | 4 ++--
 arch/arm64/mm/mmu.c                  | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6770667b34a3..52eb234101a2 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -61,7 +61,6 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
  * physical memory, in which case it will be smaller.
  */
 extern u64 idmap_t0sz;
-extern u64 idmap_ptrs_per_pgd;
 
 /*
  * Ensure TCR.T0SZ is set to the provided value.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6a98f1a38c29..127e29f38715 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -318,6 +318,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * this number conveniently equals the number of leading zeroes in
 	 * the physical address of __idmap_text_end.
 	 */
+	mov	x4, PTRS_PER_PGD
 	adrp	x5, __idmap_text_end
 	clz	x5, x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
@@ -345,16 +346,15 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 
 	mov	x4, EXTRA_PTRS
 	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+	mov	x4, PTRS_PER_PGD
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
index 626ec32873c6..e74a6453cb14 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -44,7 +44,6 @@
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
-u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 u64 __section(".mmuoff.data.write") vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
-- 
2.30.2

