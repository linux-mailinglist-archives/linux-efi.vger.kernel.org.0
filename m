Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F994FB863
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiDKJwT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbiDKJwF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6B6570
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D95561179
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EF6C385AD;
        Mon, 11 Apr 2022 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670570;
        bh=ccI3bEv12vP3jMk9pe+plmbmyNznlI1rhcVkhSAbqkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnoGb6ZXKBXfPJcMPkO7wLxk2rgiQQLkLSAypY4O04mQa5bg+EjmTY0HgltmPrHHz
         quNKqzN4S63IRHJzecpMMSbqSJHT6RkYwiFdtd7Tr3fDlX20yMG/IxpXySkQ6NC54/
         NT5m/W2h+YipHSjmexIw6HZHn1pILFU1FBLpZNqgZGUlKSJJbTZnPchXuTN5uX3iJT
         5FYgPwSdjV0XVayg+WS3NKxgL2Gv97UoffpGmrwukgfX6JTeGdj+7IFeupWukwOL6f
         F6xt1Oce6X3NVzUZh4iFSM5t6OxptmOlcRY/eh1CuerBpGgEEhD6mduAxC35tA/VLs
         DpvVRZzkRIe0A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 20/30] arm64: head: relocate kernel only a single time if KASLR is enabled
Date:   Mon, 11 Apr 2022 11:48:14 +0200
Message-Id: <20220411094824.4176877-21-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19694; h=from:subject; bh=ccI3bEv12vP3jMk9pe+plmbmyNznlI1rhcVkhSAbqkk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lW2hXoBZT6xMkOE4tr/K/3QTck+9e56DTQQh9I GOdYSEWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5VgAKCRDDTyI5ktmPJMkgC/ 9+23+4HD6Yvuum40n/x9Ee3v5Yr+hmuLgIcCmD8x7Ciddh2RqfwzgxH2OkaX0w2JGA+72t4IayeoC9 gs8qTHPuHxMA2ibb84mKH3McO7wv7Wa6QQukexnU+/Ew4LmhHXyPZF3Eq23zskn2BhmPDnzhf+mbIw 8jRzZa+rr8sM5pNaLvrvoP+3tEtHZcbgKw/WUySAZWa5v/u+6jJzrILYpeLFaYAFQKtY+21yBmHrVe 7A5+AvWImVSLUewJhj6ASiJfBJLB9VYCyjtbPvazBGRO6IENm7qzNxDnnZKfkM8qL2rVEXNADXcVYA BkIrmZHi8AWctlcbdO0xkgPQgO8P+BcA9rarClDdbaEvg/LXyAaPLncEzgieJen2327W2T/wX85ZnT 63N849ZlXWB485j+loFj11Hf/uU6KWuu1wd9Rna5w8Zb9WIsKCbPLuUNygzzS8BdNz2DYoBh8r8Muz HxDITqrqn9ZKZXx8AXdiQUjYb8tSg44BU51YrA3R1+Bfc=
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

Currently, when KASLR is in effect, we set up the kernel virtual address
space twice: the first time, the KASLR seed is looked up in the device
tree, and the kernel virtual mapping is torn down and recreated again,
after which the relocations are applied a second time. The latter step
means that statically initialized global pointer variables will be reset
to their initial values, and to ensure that BSS variables are not set to
values based on the initial translation, they are cleared again as well.

All of this is needed because we need the command line (taken from the
DT) to tell us whether or not to randomize the virtual address space
before entering the kernel proper. However, this code has expanded
little by little and now creates global state unrelated to the virtual
randomization of the kernel before the mapping is torn down and set up
again, and the BSS cleared for a second time. This has created some
issues in the past, and it would be better to avoid this little dance if
possible.

So instead, let's use the temporary mapping of the device tree, and
execute the bare minimum of code to decide whether or not KASLR should
be enabled, and what the seed is. Only then, create the virtual kernel
mapping, clear BSS, etc and proceed as normal.  This avoids the issues
around inconsistent global state due to BSS being cleared twice, and is
generally more maintainable, as it permits us to defer all the remaining
DT parsing and KASLR initialization to a later time.

This means the relocation fixup code runs only a single time as well,
allowing us to simplify the RELR handling code too, which is not
idempotent and was therefore required to keep track of the offset that
was applied the first time around.

Note that this means we have to clone a pair of FDT library objects, so
that we can control how they are built - we need the stack protector
and other instrumentation disabled so that the code can tolerate being
called this early. Note that only the kernel page tables and the
temporary stack are mapped read-write at this point, which ensures that
the early code does not modify any global state inadvertently.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h    |   2 +
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/head.S           |  68 +++--------
 arch/arm64/kernel/image-vars.h     |   4 +
 arch/arm64/kernel/kaslr.c          |  76 ++----------
 arch/arm64/kernel/pi/Makefile      |  33 +++++
 arch/arm64/kernel/pi/kaslr_early.c | 128 ++++++++++++++++++++
 arch/arm64/kernel/setup.c          |  12 +-
 8 files changed, 203 insertions(+), 122 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c751cd9b94f8..c17635f1538f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -195,6 +195,8 @@ static inline unsigned long kaslr_offset(void)
 	return kimage_vaddr - KIMAGE_VADDR;
 }
 
+void kaslr_init(void *fdt);
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
index 7744d5af3fa6..87498e414725 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -85,16 +85,13 @@
 	 *  x19        create_idmap() .. __ start_kernel()      ID map VA of the DT blob
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
-	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
+	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
-	adrp	x23, __PHYS_OFFSET
-	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	create_idmap
 
 	/*
@@ -443,16 +440,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #endif
 	mov	x0, x19				// pass FDT address in x0
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
@@ -761,27 +748,17 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
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
 	adr_l	x9, __relr_start
 	adr_l	x10, __relr_end
 
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
 
@@ -790,7 +767,7 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	cbz	x11, 6f
 	tbz	x11, #0, 5f			// skip bit if not set
 	ldr	x12, [x14]			// relocate bit
-	add	x12, x12, x15
+	add	x12, x12, x23
 	str	x12, [x14]
 
 5:	add	x14, x14, #8			// move to next bit's address
@@ -814,40 +791,25 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
-
+#ifdef CONFIG_RELOCATABLE
+	adrp	x23, __PHYS_OFFSET
+	and	x23, x23, MIN_KIMG_ALIGN - 1
+#ifdef CONFIG_RANDOMIZE_BASE
+	mov	x0, x19
+	adrp	x1, init_pg_end
+	mov	sp, x1
+	mov	x29, xzr
+	bl	__pi_kaslr_early_init
+	orr	x23, x23, x0			// record KASLR offset
+#endif
+#endif
 	bl	clear_page_tables
 	bl	create_kernel_mapping
 
 	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x2
 #ifdef CONFIG_RELOCATABLE
-#ifdef CONFIG_RELR
-	mov	x24, #0				// no RELR displacement yet
-#endif
 	bl	__relocate_kernel
-#ifdef CONFIG_RANDOMIZE_BASE
-	ldr	x8, =__primary_switched
-	adrp	x0, __PHYS_OFFSET
-	blr	x8
-
-	/*
-	 * If we return here, we have a KASLR displacement in x23 which we need
-	 * to take into account by discarding the current kernel mapping and
-	 * creating a new one.
-	 */
-	adrp	x1, reserved_pg_dir		// Disable translations via TTBR1
-	load_ttbr1 x1, x2
-	bl	clear_page_tables
-	bl	create_kernel_mapping		// Recreate kernel mapping
-
-	tlbi	vmalle1				// Remove any stale TLB entries
-	dsb	nsh
-	isb
-
-	adrp	x1, init_pg_dir			// Re-enable translations via TTBR1
-	load_ttbr1 x1, x2
-	bl	__relocate_kernel
-#endif
 #endif
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 241c86b67d01..0c381a405bf0 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -41,6 +41,10 @@ __efistub_dcache_clean_poc = __pi_dcache_clean_poc;
 __efistub___memcpy		= __pi_memcpy;
 __efistub___memmove		= __pi_memmove;
 __efistub___memset		= __pi_memset;
+
+__pi___memcpy			= __pi_memcpy;
+__pi___memmove			= __pi_memmove;
+__pi___memset			= __pi_memset;
 #endif
 
 __efistub__text			= _text;
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 3b12715642ce..16dafd66be6d 100644
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
@@ -105,44 +84,15 @@ u64 __init kaslr_early_init(void)
 	if (arch_get_random_seed_long_early(&raw))
 		seed ^= raw;
 
-	if (!seed) {
+	if (!seed || !kaslr_offset()) {
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
-		u64 end = (u64)_end - (u64)_text + KIMAGE_VADDR;
-
 		/*
 		 * Randomize the module region over a 2 GB window covering the
 		 * kernel. This reduces the risk of modules leaking information
@@ -152,11 +102,8 @@ u64 __init kaslr_early_init(void)
 		 * resolved normally.)
 		 */
 		module_range = SZ_2G - (u64)(_end - _stext);
-		module_alloc_base = max(end + offset - SZ_2G,
-					(u64)MODULES_VADDR);
+		module_alloc_base = max((u64)_end - SZ_2G, (u64)MODULES_VADDR);
 	} else {
-		u64 end = (u64)_etext - (u64)_text + KIMAGE_VADDR;
-
 		/*
 		 * Randomize the module region by setting module_alloc_base to
 		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
@@ -167,17 +114,15 @@ u64 __init kaslr_early_init(void)
 		 * when ARM64_MODULE_PLTS is enabled.
 		 */
 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
-		module_alloc_base = end + offset - MODULES_VSIZE;
+		module_alloc_base = (u64)_etext - MODULES_VSIZE;
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
@@ -189,11 +134,8 @@ static int __init kaslr_init(void)
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
index 000000000000..839291430cb3
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
+		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
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
index 000000000000..ef2f1f2fe690
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
+static bool is_kaslr_disabled_cmdline(const void *fdt)
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
+static u64 get_kaslr_seed(const void *fdt)
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
+asmlinkage u64 kaslr_early_init(const void *fdt)
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
index 3505789cf4bd..de546c8d543b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -184,9 +184,19 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	void *dt_virt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
 	const char *name;
 
-	if (dt_virt)
+	if (dt_virt) {
 		memblock_reserve(dt_phys, size);
 
+		/*
+		 * kaslr_init() will modify the DT, by wiping the KASLR seed
+		 * before returning it. So we must call it before remapping it
+		 * r/o [below] and before calling early_init_dt_scan(), which
+		 * takes a CRC and verifies it later.
+		 */
+		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+			kaslr_init(dt_virt);
+	}
+
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob at physical address %pa (virtual address 0x%px)\n"
-- 
2.30.2

