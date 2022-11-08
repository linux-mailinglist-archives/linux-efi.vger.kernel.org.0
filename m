Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E8621BCA
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiKHSWe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKHSWd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BA2CB
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50C93B81BF5
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491EFC43140;
        Tue,  8 Nov 2022 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931750;
        bh=3pnGX8FHsLaShVzT6sQT9NeI+2vWRSqwJDen85XOp0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSmZIoB0shCru2q2qUozFtyAwcLMDwgWe6HqD4oWCWxP0U9/+DItCub1b7aeDFLgj
         XWdiHK/4/B4MziNEpyuY0cZKNS5p98YUOpqEwVnhWZNfV2UUF2KbpdskO9iVQEzhvY
         fA1RHquBYTNiT0kumqJT9lOg07miSc6DGCoL7W7MpSdK/BLVkfTIJ20pExaX7G+/H9
         vWE9u/J+dbUaz0hvzFPGXaMTuUi+yH7JgJn0uqJYPJtIxivDWJ72f8h8BD/eNimn03
         cJtHWpLlvdVGg1WiAs+JVK1/jTmBsds3X9HZmI2ya4WlAVZAMLFVPXpuaxQV3W0sOA
         D/UMydL9o4VNA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 3/7] arm64: head: record the MMU state at primary entry
Date:   Tue,  8 Nov 2022 19:22:00 +0100
Message-Id: <20221108182204.2447664-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4591; i=ardb@kernel.org; h=from:subject; bh=3pnGX8FHsLaShVzT6sQT9NeI+2vWRSqwJDen85XOp0s=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5E4RZhMI3V/6ys6kjY9ksOE+oo5+tezjXExJh1 Lk6A+RGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeRAAKCRDDTyI5ktmPJARFC/ 9G5HhKeivZj69Eggt/uXPaubV8naIsO70LUwFlXxYbFnvR1g2IukvNOKJDbXtnN7EZCC7SDgnsudzG VcZ0gB91+LPyafLp/HS5z5eTRzoDgJz7poy6rzpO+kSquOpp09RYIMgmt7l79lPnki3IK9rMQ1cYAT VQqrwDwfZbzs6047nVQaZeVwE1o9qAk0Dh+jDA5rYSrltJZHhOOvoOEdYoH03ETxUG6hgtyh0eYPkm dk6VHf3NoN14cpI6S0LOnzWsZCiRIPFJNBp/RVg1K7cNsLau35Fd+m8Dl4xhC7gAtv+1wgoWymL+Y0 sY+uFkBK6jfQBwMcx07Ik9XhOVv1/3rNQmH+xFSxh7zzenvvhM26DOeL8pRuIRcZGpSAhU38QAjQrW 4nxajQpXRGSrFbzaLxo6aBo0dbXeI5C4cx/LHTw2SHCm5tJe2L38wepHTDZGdTVrVXWHh9Fut5Cu0F bXYhWWg1AjjVHNqP8rvE0Vft3LnekECDq/2j8JIkXk38k=
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

Prepare for being able to deal with primary entry with the MMU and
caches enabled, by recording whether or not we entered with the MMU on
in register x19 and in a global variable. (Note that setting this
variable to '1' does not require cache invalidation, nor is it required
for storing the bootargs in that case, so omit the cache maintenance).

Since boot with the MMU enabled is not permitted by the bare metal boot
protocol, ensure that a diagnostic is emitted and a taint bit set if
the MMU was found to be enabled on a non-EFI boot. We will make an
exception for EFI boot later, which has strict requirements for the
mapping of system memory, permitting us to relax the boot protocol and
hand over from the EFI stub to the core kernel with MMU and caches left
enabled.

While at it, add 'pre_disable_mmu_workaround' macro invocations to
init_kernel_el, as its manipulation of SCTLR_ELx may amount to disabling
of the MMU after subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 21 ++++++++++++++++++++
 arch/arm64/kernel/setup.c |  9 +++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 272877c5b4fa1203..3e654e43fa115947 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -77,6 +77,7 @@
 	 * primary lowlevel boot path:
 	 *
 	 *  Register   Scope                      Purpose
+	 *  x19        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
@@ -86,6 +87,7 @@
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
+	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
@@ -109,6 +111,19 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+SYM_CODE_START_LOCAL(record_mmu_state)
+	mrs	x19, CurrentEL
+	cmp	x19, #CurrentEL_EL2
+	mrs	x19, sctlr_el1
+	b.ne	0f
+	mrs	x19, sctlr_el2
+0:	tst	x19, #SCTLR_ELx_C		// Z := (C == 0)
+	and	x19, x19, #SCTLR_ELx_M		// isolate M bit
+	ccmp	x19, xzr, #4, ne		// Z |= (M == 0)
+	cset	x19, ne				// set x19 if !Z
+	ret
+SYM_CODE_END(record_mmu_state)
+
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
@@ -119,11 +134,14 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
 	stp	x2, x3, [x0, #16]
 
+	cbnz	x19, 0f				// skip cache invalidation if MMU is on
 	dmb	sy				// needed before dc ivac with
 						// MMU off
 
 	add	x1, x0, #0x20			// 4 x 8 bytes
 	b	dcache_inval_poc		// tail call
+0:	str_l   x19, mmu_enabled_at_boot, x0
+	ret
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
@@ -494,6 +512,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -526,11 +545,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	cbz	x0, 1f
 
 	/* Set a sane SCTLR_EL1, the VHE way */
+	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
 	mov	x2, #BOOT_CPU_FLAG_E2H
 	b	2f
 
 1:
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 2:
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index fea3223704b6339a..11cf21afafa9f852 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -56,6 +56,7 @@ static int num_standard_resources;
 static struct resource *standard_resources;
 
 phys_addr_t __fdt_pointer __initdata;
+u64 mmu_enabled_at_boot __initdata;
 
 /*
  * Standard memory resources
@@ -328,8 +329,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	xen_early_init();
 	efi_init();
 
-	if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
-	     pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
+	if (!efi_enabled(EFI_BOOT)) {
+		if ((u64)_text % MIN_KIMG_ALIGN)
+			pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
+		WARN_TAINT(mmu_enabled_at_boot, TAINT_FIRMWARE_WORKAROUND,
+			   FW_BUG "Booted with MMU enabled!");
+	}
 
 	arm64_memblock_init();
 
-- 
2.35.1

