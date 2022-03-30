Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6254EC89A
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiC3PoR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiC3PoQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532F34B93
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D7761562
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F68C340EC;
        Wed, 30 Mar 2022 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654949;
        bh=3s7ECbSI9OU8Gcb0pCsfqRlP9guYbq4NQGKwq8dM4+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmnScrsMNRllarE+rnB/SW4X6OJpppgKF1R3B+2b/KG05OhZqMREY7df6VwWy/5z5
         dJUpmPe2LzRTiCebMdBYTpH5mXS3axrfqg4CzRZfRzDZwGfwWP55U1gjZDnrhaBKap
         Zr3YT6Nx0/TtvbW7lAXFs6ARNrVRhX0CNo+fmiJJRDgIyDBq0NYYgIgJnLUfC6020d
         +JbCviZl0U1lPP8TL068JxAc4h3M/7taeL+8GxiFhSs43O4sGuhMsRVkBwUVkYv6K7
         koEuXqfFu6MskzrhuaxLtCbRP7U+vbWFpUqqf6tDHScXBQNciOD7JaDMwcv1SyWHKo
         CPPGrUjHsZ05w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 09/18] arm64: head: relocate kernel only a single time if KASLR is enabled
Date:   Wed, 30 Mar 2022 17:41:56 +0200
Message-Id: <20220330154205.2483167-10-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18808; h=from:subject; bh=3s7ECbSI9OU8Gcb0pCsfqRlP9guYbq4NQGKwq8dM4+4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo9bBKtVy5iVJqRelLP4Isb1r2v2QVWWBYeGy9I rXngtpyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6PQAKCRDDTyI5ktmPJIG/C/ 9LYOj3FJLZLAXOEcR8j4y3bSmLMN0nwupJetRMhN33WO3mY2LPGrdHR2anjGOeVDAtDeRZc59k0ghN EOJ9YGKVE8G5jb1EzHm14iXkzYNQY8yu0gQhR6GU9RZjhitkYUSIEhLRvu0669YZB4qa9nOIrRD8jc A3LXOZbFa3Sq9ePecenaFYWI5i6AfeZSZNKe2rI0ukmGUrFj0TZfLXcFcgjFd8DA6sgHoTrmSSfkpo AlN5W896EHp6E4vvAMfr7c4IWbIDua20OPbOvGJ3p684ncbcggXYpNbVNyu8K41o9yj9ipoMTEYQkc w08xvBlevc8txCDpYcjgX0jy1rC8Z3azvmUO7PNiiVsOpOb5YQYn+qHaByRhtODFmaCHHrO89W094U RIrAjqg0lSLChSoeQ72s9d8sKJO4rH8UCKddHRTSVz64ue9jxK8UEoW4lgvNrkao7ffDfg7MeddppR PFGUlr0bsIV2ziD1JMfPyW7opFHycxWB8X0VuYkAkZG0k=
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

We have accumulated a small pile of hacks to allow us to run C code and
parse command line options and DT properties before actually entering
the kernel in C mode. This was needed because we need the command line
(taken from the DT) to tell us whether or not to randomize the virtual
address space before entering the kernel proper. However, this code has
expanded little by little and now creates global state unrelated to the
virtual mapping of the kernel before the mapping is torn down and set up
again, and the BSS cleared for a second time. This has created some
issues in the past, and it would be better to avoid this little dance if
possible.

So instead, let's create a temporary mapping of the device tree before
even mapping the kernel, and execute the bare minimum of code to decide
whether or not KASLR should be enabled, and what the seed is. Only then,
create the virtual kernel mapping, clear BSS, etc and proceed as normal.
This avoids the issues around inconsistent global state due to BSS being
cleared twice, and is generally more maintainable, as it permits us to
defer all the remaining DT parsing and KASLR initialization to a later
time.

This means the relocation fixup code runs only a single time as well,
allowing us to simplify the RELR handling code too, which is not
idempotent and was therefore required to keep track of the offset that
was applied the first time around.

Note that this means we have to clone a pair of FDT library objects, so
that we can control how they are built - we need the stack protector
and other instrumentation disabled so that the code can tolerate being
called this early.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h    |   2 +
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/head.S           |  87 +++++++------
 arch/arm64/kernel/kaslr.c          |  71 ++---------
 arch/arm64/kernel/pi/Makefile      |  33 +++++
 arch/arm64/kernel/pi/kaslr_early.c | 128 ++++++++++++++++++++
 arch/arm64/kernel/setup.c          |   2 +
 7 files changed, 216 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..2f1a48be11cf 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -191,6 +191,8 @@ static inline unsigned long kaslr_offset(void)
 	return kimage_vaddr - KIMAGE_VADDR;
 }
 
+void kaslr_init(void *);
+
 /*
  * Allow all memory at the discovery stage. We will clip it later.
  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 986837d7ec82..45f7a0e2d35e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
-obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o pi/
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5d4cb481e42f..f3b096daf1c5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -83,14 +83,11 @@
 	 *
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
-	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
+	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	adrp	x23, __PHYS_OFFSET
-	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
 	bl	create_idmap
 
@@ -368,6 +365,27 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	ret
 SYM_FUNC_END(create_kernel_mapping)
 
+#ifdef CONFIG_RANDOMIZE_BASE
+// Create a temporary mapping of the device tree blob in the kernel page tables
+// so that we can grab the KASLR seed and command line options before mapping
+// the kernel at its randomized address.
+SYM_FUNC_START_LOCAL(create_temp_fdt_mapping)
+	adrp	x2, init_pg_dir
+	mov_q	x5, KIMAGE_VADDR
+	mov	x4, PTRS_PER_PGD
+	bic	x3, x21, #SZ_4M - 1		// map a 4 MiB block
+	add	x6, x5, #SZ_4M
+	mov	x7, SWAPPER_MM_MMUFLAGS
+
+	sub	x0, x21, x3			// return the mapped address in x0
+	add	x0, x0, x5
+
+	map_memory x2, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
+
+	ret
+SYM_FUNC_END(create_temp_fdt_mapping)
+#endif
+
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
 	 *
@@ -430,16 +448,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	mov	x0, x21				// pass FDT address in x0
 	bl	early_fdt_map			// Try mapping the FDT early
 	bl	init_feature_override		// Parse cpu feature overrides
-#ifdef CONFIG_RANDOMIZE_BASE
-	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
-	b.ne	0f
-	bl	kaslr_early_init		// parse FDT for KASLR options
-	cbz	x0, 0f				// KASLR disabled? just proceed
-	orr	x23, x23, x0			// record KASLR offset
-	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
-	ret					// to __primary_switch()
-0:
-#endif
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
 	bl	start_kernel
@@ -785,29 +793,19 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * entry in x9, the address being relocated by the current address or
 	 * bitmap entry in x13 and the address being relocated by the current
 	 * bit in x14.
-	 *
-	 * Because addends are stored in place in the binary, RELR relocations
-	 * cannot be applied idempotently. We use x24 to keep track of the
-	 * currently applied displacement so that we can correctly relocate if
-	 * __relocate_kernel is called twice with non-zero displacements (i.e.
-	 * if there is both a physical misalignment and a KASLR displacement).
 	 */
 	ldr	w9, =__relr_offset		// offset to reloc table
 	ldr	w10, =__relr_size		// size of reloc table
 	add	x9, x9, x11			// __va(.relr)
 	add	x10, x9, x10			// __va(.relr) + sizeof(.relr)
 
-	sub	x15, x23, x24			// delta from previous offset
-	cbz	x15, 7f				// nothing to do if unchanged
-	mov	x24, x23			// save new offset
-
 2:	cmp	x9, x10
 	b.hs	7f
 	ldr	x11, [x9], #8
 	tbnz	x11, #0, 3f			// branch to handle bitmaps
 	add	x13, x11, x23
 	ldr	x12, [x13]			// relocate address entry
-	add	x12, x12, x15
+	add	x12, x12, x23
 	str	x12, [x13], #8			// adjust to start of bitmap
 	b	2b
 
@@ -816,7 +814,7 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	cbz	x11, 6f
 	tbz	x11, #0, 5f			// skip bit if not set
 	ldr	x12, [x14]			// relocate bit
-	add	x12, x12, x15
+	add	x12, x12, x23
 	str	x12, [x14]
 
 5:	add	x14, x14, #8			// move to next bit's address
@@ -840,38 +838,35 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, reserved_pg_dir
 	bl	__enable_mmu
 	bl	clear_page_tables
-	bl	create_kernel_mapping
 
-	adrp	x1, init_pg_dir
-	load_ttbr1 x1, x2
 #ifdef CONFIG_RELOCATABLE
-#ifdef CONFIG_RELR
-	mov	x24, #0				// no RELR displacement yet
-#endif
-	bl	__relocate_kernel
+	adrp	x23, __PHYS_OFFSET
+	and	x23, x23, MIN_KIMG_ALIGN - 1
 #ifdef CONFIG_RANDOMIZE_BASE
-	ldr	x8, =__primary_switched
-	adrp	x0, __PHYS_OFFSET
-	blr	x8
+	bl	create_temp_fdt_mapping
+	adrp	x1, init_pg_dir
+	load_ttbr1 x1, x2
 
-	/*
-	 * If we return here, we have a KASLR displacement in x23 which we need
-	 * to take into account by discarding the current kernel mapping and
-	 * creating a new one.
-	 */
-	adrp	x1, reserved_pg_dir		// Disable translations via TTBR1
+	adrp	x1, init_stack
+	add	sp, x1, #THREAD_SIZE
+	mov	x29, xzr
+	bl	__pi_kaslr_early_init
+	orr	x23, x23, x0			// record KASLR offset
+
+	adrp	x1, reserved_pg_dir
 	load_ttbr1 x1, x2
-	bl	clear_page_tables
-	bl	create_kernel_mapping		// Recreate kernel mapping
 
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
 	isb
+#endif
+#endif
+	bl	create_kernel_mapping
 
-	adrp	x1, init_pg_dir			// Re-enable translations via TTBR1
+	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x2
+#ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
-#endif
 #endif
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 3b12715642ce..78339a2aa3f8 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -24,7 +24,6 @@ enum kaslr_status {
 	KASLR_ENABLED,
 	KASLR_DISABLED_CMDLINE,
 	KASLR_DISABLED_NO_SEED,
-	KASLR_DISABLED_FDT_REMAP,
 };
 
 static enum kaslr_status __initdata kaslr_status;
@@ -52,18 +51,9 @@ static __init u64 get_kaslr_seed(void *fdt)
 
 struct arm64_ftr_override kaslr_feature_override __initdata;
 
-/*
- * This routine will be executed with the kernel mapped at its default virtual
- * address, and if it returns successfully, the kernel will be remapped, and
- * start_kernel() will be executed from a randomized virtual offset. The
- * relocation will result in all absolute references (e.g., static variables
- * containing function pointers) to be reinitialized, and zero-initialized
- * .bss variables will be reset to 0.
- */
-u64 __init kaslr_early_init(void)
+void __init kaslr_init(void *fdt)
 {
-	void *fdt;
-	u64 seed, offset, mask, module_range;
+	u64 seed, module_range;
 	unsigned long raw;
 
 	/*
@@ -72,17 +62,6 @@ u64 __init kaslr_early_init(void)
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
 
-	/*
-	 * Try to map the FDT early. If this fails, we simply bail,
-	 * and proceed with KASLR disabled. We will make another
-	 * attempt at mapping the FDT in setup_machine()
-	 */
-	fdt = get_early_fdt_ptr();
-	if (!fdt) {
-		kaslr_status = KASLR_DISABLED_FDT_REMAP;
-		return 0;
-	}
-
 	/*
 	 * Retrieve (and wipe) the seed from the FDT
 	 */
@@ -94,7 +73,7 @@ u64 __init kaslr_early_init(void)
 	 */
 	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
 		kaslr_status = KASLR_DISABLED_CMDLINE;
-		return 0;
+		return;
 	}
 
 	/*
@@ -105,41 +84,14 @@ u64 __init kaslr_early_init(void)
 	if (arch_get_random_seed_long_early(&raw))
 		seed ^= raw;
 
-	if (!seed) {
+	if (!seed || !kimage_voffset) {
 		kaslr_status = KASLR_DISABLED_NO_SEED;
-		return 0;
+		return;
 	}
 
-	/*
-	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
-	 * kernel image offset from the seed. Let's place the kernel in the
-	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
-	 * the lower and upper quarters to avoid colliding with other
-	 * allocations.
-	 * Even if we could randomize at page granularity for 16k and 64k pages,
-	 * let's always round to 2 MB so we don't interfere with the ability to
-	 * map using contiguous PTEs
-	 */
-	mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
-	offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
-
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
-	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
-		/*
-		 * KASAN without KASAN_VMALLOC does not expect the module region
-		 * to intersect the vmalloc region, since shadow memory is
-		 * allocated for each module at load time, whereas the vmalloc
-		 * region is shadowed by KASAN zero pages. So keep modules
-		 * out of the vmalloc region if KASAN is enabled without
-		 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
-		 * module region.
-		 */
-		return offset % SZ_2G;
-
 	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
 		u64 end = (u64)_end - (u64)_text + KIMAGE_VADDR;
 
@@ -152,7 +104,7 @@ u64 __init kaslr_early_init(void)
 		 * resolved normally.)
 		 */
 		module_range = SZ_2G - (u64)(_end - _stext);
-		module_alloc_base = max(end + offset - SZ_2G,
+		module_alloc_base = max(end + kimage_voffset - SZ_2G,
 					(u64)MODULES_VADDR);
 	} else {
 		u64 end = (u64)_etext - (u64)_text + KIMAGE_VADDR;
@@ -167,17 +119,15 @@ u64 __init kaslr_early_init(void)
 		 * when ARM64_MODULE_PLTS is enabled.
 		 */
 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
-		module_alloc_base = end + offset - MODULES_VSIZE;
+		module_alloc_base = end + kimage_voffset - MODULES_VSIZE;
 	}
 
 	/* use the lower 21 bits to randomize the base of the module region */
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
-
-	return offset;
 }
 
-static int __init kaslr_init(void)
+static int __init kaslr_report_status(void)
 {
 	switch (kaslr_status) {
 	case KASLR_ENABLED:
@@ -189,11 +139,8 @@ static int __init kaslr_init(void)
 	case KASLR_DISABLED_NO_SEED:
 		pr_warn("KASLR disabled due to lack of seed\n");
 		break;
-	case KASLR_DISABLED_FDT_REMAP:
-		pr_warn("KASLR disabled due to FDT remapping failure\n");
-		break;
 	}
 
 	return 0;
 }
-core_initcall(kaslr_init)
+core_initcall(kaslr_report_status)
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
new file mode 100644
index 000000000000..3c503312b5dc
--- /dev/null
+++ b/arch/arm64/kernel/pi/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+
+KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   $(call cc-option,-mbranch-protection=none) \
+		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+		   -include $(srctree)/include/linux/hidden.h \
+		   -D__DISABLE_EXPORTS -ffreestanding \
+		   $(call cc-option,-fno-addrsig)
+
+# remove SCS flags from all objects in this directory
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
+			       --remove-section=.note.gnu.property \
+			       --prefix-alloc-sections=.init
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+obj-y		:= kaslr_early.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
new file mode 100644
index 000000000000..bbba01807ab6
--- /dev/null
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2022 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+// NOTE: code in this file runs *very* early, and is not permitted to use
+// global variables or anything that relies on absolute addressing.
+
+#include <linux/libfdt.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include <asm/archrandom.h>
+#include <asm/memory.h>
+
+/* taken from lib/string.c */
+static char *__strstr(const char *s1, const char *s2)
+{
+	size_t l1, l2;
+
+	l2 = strlen(s2);
+	if (!l2)
+		return (char *)s1;
+	l1 = strlen(s1);
+	while (l1 >= l2) {
+		l1--;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
+		s1++;
+	}
+	return NULL;
+}
+static bool cmdline_contains_nokaslr(const u8 *cmdline)
+{
+	const u8 *str;
+
+	str = __strstr(cmdline, "nokaslr");
+	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
+}
+
+static bool is_kaslr_disabled_cmdline(void *fdt)
+{
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		int node;
+		const u8 *prop;
+
+		node = fdt_path_offset(fdt, "/chosen");
+		if (node < 0)
+			goto out;
+
+		prop = fdt_getprop(fdt, node, "bootargs", NULL);
+		if (!prop)
+			goto out;
+
+		if (cmdline_contains_nokaslr(prop))
+			return true;
+
+		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+			goto out;
+
+		return false;
+	}
+out:
+	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
+}
+
+static u64 get_kaslr_seed(void *fdt)
+{
+	int node, len;
+	const fdt64_t *prop;
+	u64 ret;
+
+	node = fdt_path_offset(fdt, "/chosen");
+	if (node < 0)
+		return 0;
+
+	prop = fdt_getprop(fdt, node, "kaslr-seed", &len);
+	if (!prop || len != sizeof(u64))
+		return 0;
+
+	ret = fdt64_to_cpu(*prop);
+	return ret;
+}
+
+asmlinkage u64 kaslr_early_init(void *fdt)
+{
+	u64 seed, mask, offset;
+
+	if (is_kaslr_disabled_cmdline(fdt))
+		return 0;
+
+	seed = get_kaslr_seed(fdt);
+	if (!seed && (!__early_cpu_has_rndr() ||
+		      !__arm64_rndr((unsigned long *)&seed)))
+		return 0;
+
+	/*
+	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
+	 * kernel image offset from the seed. Let's place the kernel in the
+	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
+	 * the lower and upper quarters to avoid colliding with other
+	 * allocations.
+	 * Even if we could randomize at page granularity for 16k and 64k pages,
+	 * let's always round to 2 MB so we don't interfere with the ability to
+	 * map using contiguous PTEs
+	 */
+	mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
+	offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
+
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
+	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
+		/*
+		 * KASAN without KASAN_VMALLOC does not expect the module region
+		 * to intersect the vmalloc region, since shadow memory is
+		 * allocated for each module at load time, whereas the vmalloc
+		 * region is shadowed by KASAN zero pages. So keep modules
+		 * out of the vmalloc region if KASAN is enabled without
+		 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
+		 * module region.
+		 */
+		return offset % SZ_2G;
+
+	return offset;
+}
+
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index ebf69312eabf..26fb4bce5f8b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,6 +313,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	setup_machine_fdt(__fdt_pointer);
 
+	kaslr_init(initial_boot_params);
+
 	/* Early fixups are done, map the FDT as read-only now */
 	fixmap_remap_fdt(__fdt_pointer, NULL, PAGE_KERNEL_RO);
 
-- 
2.30.2

