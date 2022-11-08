Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE4621BCC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKHSWh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiKHSWg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D22BE2
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E708161728
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB9CC433B5;
        Tue,  8 Nov 2022 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931754;
        bh=BSPbdyn+0wdNt5TH3CR06gDbxLNByYa+H+dOwnVBqIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BydbxnZ+ra/lf/jgc7o939DMY4Xt4wKTkZh6ZwvdMg5yg9x3d/J1eo6JzX3VDdnNV
         FquVTCzVLBjB8yl15hsLwEPgMWsZkmCSrG/xixKq3Mi83bCy3OWLGXVAgHM8veMizT
         FUyQG666ydKylaFq/h3L7R5hy+Lr7ozRqYA3zCztQ+fHCtcAJbR3jHqzFb1NyUWkLs
         cwCB4If165X4bCuDRxGSmjC0Q8CBzCy1zlIVGUkqKTCWq0ogoA9W+wpih03nSF3CNW
         Yhk4NGDGB7ANSi3TDtziAyChfWZ+0oLH35sonzPE3IUDPcsMMe/RJmxEEE6c/cXrC2
         ylM718ZsnSibw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 5/7] arm64: head: Clean the ID map and the HYP text to the PoC if needed
Date:   Tue,  8 Nov 2022 19:22:02 +0100
Message-Id: <20221108182204.2447664-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=ardb@kernel.org; h=from:subject; bh=BSPbdyn+0wdNt5TH3CR06gDbxLNByYa+H+dOwnVBqIg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5IJ/gliatLgpExMKIgiOYkVwmBYFEHtI4jpLdE mbvy94iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeSAAKCRDDTyI5ktmPJLZtDA CoyQbnSzKp28X77uKnl/Lj85MOohXqA5PXNlnhepLBDSBNTmRs8bvepcIzxEJC+7t0yt04sGQkL2ao J6J9goz1MwiQd1DWXOsbit1ySDziNWG6xcZEF6qWt02YmyRHyQslJfGaO/F9vhRWwBdTR2GPFafdee WF2KS8UoWBneMMHzWoKNoW3gMLFD4HlizsBKK20JSyRyK3pQKgi+bDjo4rFA3axITNRInSx89sUWE2 YiNdZj1MPeHPIvDYNKJjwlDJp3Af/YZRNYfq3aPMsFjTmABtjFV1gOm0x8jvn14TM2ywvbEGbeRX8E pmX+t9NjgO19u0Y91OEFBqTNwN/CPzTwnREmGQOnr00umfhCeZM7awRwcUKY6154Kli1wZsVmNy/9P HdZ+O6eFAfAk8MGUVx7sSd4QbP6HwBUMh60Y5TPwc/EYoltFRs6zYad03oqeIFJrsgVXwlsHV8p7fj TH/rFPWVRrq5SNu6Q9HiyvKNrwPwxtSdMIU6lXGwTQGiI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If we enter with the MMU and caches enabled, the bootloader may not have
performed any cache maintenance to the PoC. So clean the ID mapped page
to the PoC, to ensure that instruction and data accesses with the MMU
off see the correct data. For similar reasons, clean all the HYP text to
the PoC as well when entering at EL2 with the MMU and caches enabled.

Note that this means primary_entry() itself needs to be moved into the
ID map as well, as we will return from init_kernel_el() with the MMU and
caches off.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 31 +++++++++++++++++---
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a7c84cde67c5c652..825f1d0549661030 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -70,7 +70,7 @@
 
 	__EFI_PE_HEADER
 
-	__INIT
+	.section ".idmap.text","awx"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -90,6 +90,17 @@ SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	create_idmap
+
+	/*
+	 * If we entered with the MMU and caches on, clean the ID mapped part
+	 * of the primary boot code to the PoC so we can safely execute it with
+	 * the MMU off.
+	 */
+	cbz	x19, 0f
+	adrp	x0, __idmap_text_start
+	adr_l	x1, __idmap_text_end
+	bl	dcache_clean_poc
+0:	mov	x19, x0
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -111,6 +122,7 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+	__INIT
 SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x19, CurrentEL
 	cmp	x19, #CurrentEL_EL2
@@ -505,10 +517,12 @@ SYM_FUNC_END(__primary_switched)
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x0 if
  * booted in EL1 or EL2 respectively, with the top 32 bits containing
  * potential context flags. These flags are *not* stored in __boot_cpu_mode.
+ *
+ * x0: whether we are being called from the primary boot path with the MMU on
  */
 SYM_FUNC_START(init_kernel_el)
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
+	mrs	x1, CurrentEL
+	cmp	x1, #CurrentEL_EL2
 	b.eq	init_el2
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
@@ -523,6 +537,14 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	eret
 
 SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
+	msr	elr_el2, lr
+
+	// clean all HYP code to the PoC if we booted at EL2 with the MMU on
+	cbz	x0, 0f
+	adrp	x0, __hyp_idmap_text_start
+	adr_l	x1, __hyp_text_end
+	bl	dcache_clean_poc
+0:
 	mov_q	x0, HCR_HOST_NVHE_FLAGS
 	msr	hcr_el2, x0
 	isb
@@ -556,7 +578,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 2:
-	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2
 	orr	x0, x0, x2
 	eret
@@ -567,6 +588,7 @@ SYM_FUNC_END(init_kernel_el)
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_FUNC_START(secondary_holding_pen)
+	mov	x0, xzr
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mrs	x2, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
@@ -584,6 +606,7 @@ SYM_FUNC_END(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 SYM_FUNC_START(secondary_entry)
+	mov	x0, xzr
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	b	secondary_startup
 SYM_FUNC_END(secondary_entry)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 7b7c56e048346e97..2ae7cff1953aaf87 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -99,6 +99,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
+	mov	x0, xzr
 	bl	init_kernel_el
 	mov	x19, x0			// preserve boot mode
 #if VA_BITS > 48
-- 
2.35.1

