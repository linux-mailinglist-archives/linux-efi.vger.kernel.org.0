Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D04FB850
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbiDKJwT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbiDKJwD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D25CD1
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FA36B811AB
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0B4C385A5;
        Mon, 11 Apr 2022 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670565;
        bh=DC0j77pdpEuyY4bbJQfiQplf0y7I6OUkaVcvafBc/IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezoNETr9wq6mmhBjtkQGNncurVvv0686HMwb9GlsKs4s/EqVmLzqD7Xl4jOOTjRME
         YTPC+xN3wOIaW9bv6bHTBI3Z3oXezqX7a+mGjw6zpbEdtBxRVeELshcmlX1RUPttfI
         FSAfkB6ZIw6ymJGHoqsIDDrAbWFyljdJtRTjDNa8H6YDhVXt4cEaWyNHhuuYF/9DHb
         Lv/7dwgwVsgc1p49kr9Acr07MiWdq+TXLWQGUzXWESNZ3XWKrAZ16eLPvabrP8kcx1
         YtAqga5d8IvrlC9btbzrnXfOD1g9ZdQKY0vX+hi5jNyBHUMQmgBPk5M519w1bp1UF9
         9lHZAbTV5+ZmQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 18/30] arm64: head: record CPU boot mode after enabling the MMU
Date:   Mon, 11 Apr 2022 11:48:12 +0200
Message-Id: <20220411094824.4176877-19-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4919; h=from:subject; bh=DC0j77pdpEuyY4bbJQfiQplf0y7I6OUkaVcvafBc/IY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lTp6ME19ykmTFWNfCzvuF8WLTGejP5JLGMXVvy GXYpifGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5UwAKCRDDTyI5ktmPJAXgC/ 9574QZGzrSF1RLTIGJYvUtM21x1NitbwfUniClKodFNSLRoRUJT8+LI1y3VhBjDaFSWS6fb+K/jGJW TrQoIyqattrUSrkZCK18hpV5R2qscB5v/Rey1wGxjgeAcCYNzHeMqWTgF1klKH9/5035YZfgAfHnJF pHHjnVzkZRyCmDSH/OwMwFewGUyV/qoq5jluwX18trKZXRX+NO72+pshUxY1JGFPfWnpprpYeoKY6F hLkiNLOTClRsyOe3dZ+mC+SoOpiP8+rVCl5U2Qs36quLAf1+WTeW2YnENS6+MuF2aYYRhPOa2eDBDU ogF1/buxevPjBqDkUyztT05g/xsasv79yoTnAmkJm3ncpWIZpR20fs8NelVPgzw9S+7jRu/RZHS8V6 8o/wARhgYlQ+FjeR5RI3ijaMEfcatLCnjXoQiKltQtdzhov81pJUFb8KR52SoN9r6jBA84COxATF7h +Cwrcc9yR3ZY7zexe+4jWzSuP94c7YOh+SvsIEddamSrA=
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

In order to avoid having to touch memory with the MMU and caches
disabled, and therefore having to invalidate it from the caches
explicitly, just defer storing the value until after the MMU has been
turned on, unless we are giving up with an error.

While at it, move the associated variable definitions into C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 46 +++++---------------
 arch/arm64/mm/mmu.c      |  8 ++++
 2 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index f9f4af64d1fc..7744d5af3fa6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -81,8 +81,9 @@
 	 * The following callee saved general purpose registers are used on the
 	 * primary lowlevel boot path:
 	 *
-	 *  Register   Scope                      Purpose
+	 *  Register   Scope                                    Purpose
 	 *  x19        create_idmap() .. __ start_kernel()      ID map VA of the DT blob
+	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
@@ -91,9 +92,9 @@
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
+	mov	x20, x0
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
-	bl	set_cpu_boot_mode_flag
 	bl	create_idmap
 
 	/*
@@ -426,6 +427,9 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	sub	x4, x4, x0			// the kernel virtual and
 	str_l	x4, kimage_voffset, x5		// physical mappings
 
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
+
 	// Clear BSS
 	adr_l	x0, __bss_start
 	mov	x1, xzr
@@ -548,46 +552,16 @@ SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
 	b.ne	1f
 	add	x1, x1, #4
 1:	str	w0, [x1]			// Save CPU boot mode
-	dmb	sy
-	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
 SYM_FUNC_END(set_cpu_boot_mode_flag)
 
-/*
- * These values are written with the MMU off, but read with the MMU on.
- * Writers will invalidate the corresponding address, discarding up to a
- * 'Cache Writeback Granule' (CWG) worth of data. The linker script ensures
- * sufficient alignment that the CWG doesn't overlap another section.
- */
-	.pushsection ".mmuoff.data.write", "aw"
-/*
- * We need to find out the CPU boot mode long after boot, so we need to
- * store it in a writable variable.
- *
- * This is not in .bss, because we set it sufficiently early that the boot-time
- * zeroing of .bss would clobber it.
- */
-SYM_DATA_START(__boot_cpu_mode)
-	.long	BOOT_CPU_MODE_EL2
-	.long	BOOT_CPU_MODE_EL1
-SYM_DATA_END(__boot_cpu_mode)
-/*
- * The booting CPU updates the failed status @__early_cpu_boot_status,
- * with MMU turned off.
- */
-SYM_DATA_START(__early_cpu_boot_status)
-	.quad 	0
-SYM_DATA_END(__early_cpu_boot_status)
-
-	.popsection
-
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_FUNC_START(secondary_holding_pen)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
+	mov	x20, x0
 	mrs	x0, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
 	and	x0, x0, x1
@@ -605,7 +579,7 @@ SYM_FUNC_END(secondary_holding_pen)
 	 */
 SYM_FUNC_START(secondary_entry)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
+	mov	x20, x0
 	b	secondary_startup
 SYM_FUNC_END(secondary_entry)
 
@@ -624,6 +598,9 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 SYM_FUNC_END(secondary_startup)
 
 SYM_FUNC_START_LOCAL(__secondary_switched)
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
+	str_l	xzr, __early_cpu_boot_status, x3
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
 	isb
@@ -693,7 +670,6 @@ SYM_FUNC_START(__enable_mmu)
 	b.lt    __no_granule_support
 	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
-	update_early_cpu_boot_status 0, x3, x4
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
 	load_ttbr1 x1, x3
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 07219afe2723..e7145f0281be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -56,6 +56,14 @@ EXPORT_SYMBOL(kimage_vaddr);
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
+u32 __boot_cpu_mode[] = { BOOT_CPU_MODE_EL2, BOOT_CPU_MODE_EL1 };
+
+/*
+ * The booting CPU updates the failed status @__early_cpu_boot_status,
+ * with MMU turned off.
+ */
+long __section(".mmuoff.data.write") __early_cpu_boot_status;
+
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
-- 
2.30.2

