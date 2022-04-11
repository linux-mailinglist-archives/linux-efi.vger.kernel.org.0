Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55D4FB83B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiDKJwJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiDKJv5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EEF4132F
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF96B81199
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCBDC385AC;
        Mon, 11 Apr 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670546;
        bh=BYjl/REcrUqfhGta/QMKlFgjyt7mrq/E9vMZo9XFajk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xha6tGuUw6BWZT2yyEaVY7dEYgQ4OA0w/xSWr2JuLNOxD+iaiNit03nVXE5ITQheT
         vlVtPy6jr6olPPJgL5eHxPa7Vd/14nPetEUY2GHjBnn9JIua4D06Ae4Wm3671B0x3Z
         Ht+9V8IkY8y7kNMOsbSPFuJJVngHy98mdHR6bhRO7UaHT8ZZDn5KSr7wC2gLlbhSqi
         vl+7bt69lsWf5k/snaTDWHemucp3CBqNgZbwfBxo17jNjSfdRU7rL2p0byBnWVMGGB
         g9jYs9a8EGHxC8gR8x5GAvVHeRVX3lgJ8U937jakKlNAUrZMniKXZ6dDJkAUkw5vSo
         SrgOwd6JQ13cQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 10/30] arm64: mm: provide idmap pointer to cpu_replace_ttbr1()
Date:   Mon, 11 Apr 2022 11:48:04 +0200
Message-Id: <20220411094824.4176877-11-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4222; h=from:subject; bh=BYjl/REcrUqfhGta/QMKlFgjyt7mrq/E9vMZo9XFajk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lFcr/9/++HfumlZZAGjCHNQ6Yo10SA/GMH/SqO WlGiTZ+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5RQAKCRDDTyI5ktmPJMciC/ 9uh5pkR+m8BYzclbIUhedXp2HOh4d31TE2jrpu72K3tf2husk7D3Wm/jzIwkBIJByMY9Wqwm681EG2 OS7bSyXkh/F912gLrI04rNI8NmPmb/S7+hbXPzXfroRiOfOWBV/xJZPTHj57CpuGbGhCYT1sNto0Z2 cMc64aZy/BRfb14YCxHMuNkgP5g+eKsCiijPuERUpKwSRl0JnaF5NSIASCaYTd1xUwgmLgEB/djCls 5D2qb0zl+UqIRtv6qs964q8ooOsZXNL/KJs5mUDLmemTxFKgW452FboUYSY5LTFmujX3LAGnNWBNkg CsbG+Wlsz013JKeCkXO4G5FgXpuSGukfAJENZidfjPywE7eKf+YqQ3n2vk1PCKxNVEQLPThViInbt9 DWFsr7CmWFk1iLSF8IHQ6inGhHM0zstdQMBm/Qi3CdH66F6qfxJjniXwhRdicp7N9qWOWq5haW9eBE tmuVaZ7So2Y4hpEiBvPoRIea4od36xmUZfYoU5OR+wHoA=
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

In preparation for changing the way we initialize the permanent ID map,
update cpu_replace_ttbr1() so we can use it with the initial ID map as
well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 13 +++++++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/suspend.c          |  2 +-
 arch/arm64/mm/kasan_init.c           |  4 ++--
 arch/arm64/mm/mmu.c                  |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 7b387c3b312a..c7ccd82db1d2 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -105,13 +105,18 @@ static inline void cpu_uninstall_idmap(void)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
-static inline void cpu_install_idmap(void)
+static inline void __cpu_install_idmap(pgd_t *idmap)
 {
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
 	cpu_set_idmap_tcr_t0sz();
 
-	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
+	cpu_switch_mm(lm_alias(idmap), &init_mm);
+}
+
+static inline void cpu_install_idmap(void)
+{
+	__cpu_install_idmap(idmap_pg_dir);
 }
 
 /*
@@ -142,7 +147,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
@@ -165,7 +170,7 @@ static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 
 	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
 
-	cpu_install_idmap();
+	__cpu_install_idmap(idmap);
 	replace_phys(ttbr1);
 	cpu_uninstall_idmap();
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d72c4b4d389c..1661766f50f3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3108,7 +3108,7 @@ subsys_initcall_sync(init_32bit_el0_mask);
 
 static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *cap)
 {
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 }
 
 /*
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 19ee7c33769d..40bf1551d1ad 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -52,7 +52,7 @@ void notrace __cpu_suspend_exit(void)
 
 	/* Restore CnP bit in TTBR1_EL1 */
 	if (system_supports_cnp())
-		cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+		cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 
 	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index c12cd700598f..e969e68de005 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -236,7 +236,7 @@ static void __init kasan_init_shadow(void)
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
-	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
+	cpu_replace_ttbr1(lm_alias(tmp_pg_dir), idmap_pg_dir);
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -280,7 +280,7 @@ static void __init kasan_init_shadow(void)
 				PAGE_KERNEL_RO));
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 }
 
 static void __init kasan_init_depth(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0618ece00b7e..de171114a979 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -789,7 +789,7 @@ void __init paging_init(void)
 
 	pgd_clear_fixmap();
 
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
 
 	memblock_phys_free(__pa_symbol(init_pg_dir),
-- 
2.30.2

