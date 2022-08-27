Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F65A3892
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiH0P7U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiH0P7T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7B2A422
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19BB060DE5
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F84C43470;
        Sat, 27 Aug 2022 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615957;
        bh=IR05DDycZMbGq8a97hAoQd06qveIIORpmdL4ZSt3KMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMKH1fA6gwtK3UwoR8buZRqVmbq7v1VQOUOkf8t4pm9Kg3ZeV9LQ1Qcf2VJ2Jl0Kx
         cc4ouXm6f2u+A2PKpjyrM5XpUY/dt837vjG2O5LzeJRch3Cxr2ie2n/J/AaFregJS+
         tN4SO1GVWmSOs1HyX5uMT+FP81F8Qt8CMgwy73kRRnwbvp/JXW4piM5kOxtagixRpz
         qXZKGTFGdWqOHVwn1KUQx4AHyXyZlGKsF2r0vMu0b/TTxxz2FU797Kn4/+UDUL8KBA
         lUzH8sm3xN1hApSy0vPUHfAlt6X5BDK45B1UYoGavCpUkjR3GZdiAGbL7U0LZVAALQ
         4eFiYNwWIrhxA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 7/7] arm64: efi/libstub: enter with the MMU on
Date:   Sat, 27 Aug 2022 17:58:52 +0200
Message-Id: <20220827155852.3338551-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6846; i=ardb@kernel.org; h=from:subject; bh=IR05DDycZMbGq8a97hAoQd06qveIIORpmdL4ZSt3KMQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj87bnkRye1v/ryi0LzQuneHcaCQv2/Q1OBlICj9 iOd3JA+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/OwAKCRDDTyI5ktmPJNCxDA CG+7U2RGlMr7EHFyEs1TGh07arVMaDa1QZuqjdP5MtFlLbG1xAIJbKZ4Nddjx7Nnsm5THJCpVtqW7c ifxIXrqGEl/WwWshroC+xY18Hbs+YPCHyWANnWJgnt55hIRYNgVr/F6BHJTMFBfvnsgZz0KgzHmNMY zZudr7JevCb5AgZ0tYo2rSwIUJXjkqmc4nOuiYP47VVAdkd/uUmHgNt7C4SFzc+cpWIbTi/Z/UbHNC FmMtJx5NEsMdsgM6Xz5qRCCZMWaIml3yDIUnCnSjI0cIxXXGYD3nLK6Pi+h1ilAh09Es7PXkbsQqrl K3H9tIb2bd0snr1XCbmiCsmnlWPTKL5Scml7iU6RBb1Do5rHWcSOj5Zj0Uq0MbLL7YrhX0yJbUDQVV qiCebn+Ed5rY50AUruHtqdBZ+Wh3My1rcC2a2A2yIljffXtZQDqLt8fNBoGm5wFHc9nPkYxHXkXv2x kVVrKkPztXZyAvIKr3Udzhc4NL0oJ7Qf7PdHt5tz6pX14=
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

Instead of disabling the MMU and caches before jumping to the kernel's
entry point, just call it directly, and keep the MMU and caches enabled.
This removes the need for any cache invalidation in the entry path. It
also allows us to get rid of the asm routine, as doing the jump is
easily done from C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/Makefile                |  9 +--
 arch/arm64/kernel/efi-entry.S             | 69 --------------------
 arch/arm64/kernel/image-vars.h            |  6 +-
 arch/arm64/mm/cache.S                     |  5 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 18 ++++-
 5 files changed, 24 insertions(+), 83 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1add7b01efa7..3c502facb7e1 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,12 +36,6 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
 			   patching.o
 
-targets			+= efi-entry.o
-
-OBJCOPYFLAGS := --prefix-symbols=__efistub_
-$(obj)/%.stub.o: $(obj)/%.o FORCE
-	$(call if_changed,objcopy)
-
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
 obj-$(CONFIG_COMPAT)			+= sigreturn32.o
@@ -56,8 +50,7 @@ obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
-					   efi-rt-wrapper.o
+obj-$(CONFIG_EFI)			+= efi.o efi-rt-wrapper.o
 obj-$(CONFIG_PCI)			+= pci.o
 obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
 obj-$(CONFIG_ACPI)			+= acpi.o
diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
deleted file mode 100644
index 61a87fa1c305..000000000000
--- a/arch/arm64/kernel/efi-entry.S
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * EFI entry point.
- *
- * Copyright (C) 2013, 2014 Red Hat, Inc.
- * Author: Mark Salter <msalter@redhat.com>
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-#include <asm/assembler.h>
-
-	__INIT
-
-SYM_CODE_START(efi_enter_kernel)
-	/*
-	 * efi_pe_entry() will have copied the kernel image if necessary and we
-	 * end up here with device tree address in x1 and the kernel entry
-	 * point stored in x0. Save those values in registers which are
-	 * callee preserved.
-	 */
-	ldr	w2, =primary_entry_offset
-	add	x19, x0, x2		// relocated Image entrypoint
-	mov	x20, x1			// DTB address
-
-	/*
-	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
-	 * stale icache entries from before relocation.
-	 */
-	ldr	w1, =kernel_size
-	add	x1, x0, x1
-	bl	dcache_clean_poc
-	ic	ialluis
-
-	/*
-	 * Clean the remainder of this routine to the PoC
-	 * so that we can safely disable the MMU and caches.
-	 */
-	adr	x0, 0f
-	adr	x1, 3f
-	bl	dcache_clean_poc
-0:
-	/* Turn off Dcache and MMU */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-	bic	x0, x0, #1 << 0	// clear SCTLR.M
-	bic	x0, x0, #1 << 2	// clear SCTLR.C
-	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
-	isb
-	b	2f
-1:
-	mrs	x0, sctlr_el1
-	bic	x0, x0, #1 << 0	// clear SCTLR.M
-	bic	x0, x0, #1 << 2	// clear SCTLR.C
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x0
-	isb
-2:
-	/* Jump to kernel entry point */
-	mov	x0, x20
-	mov	x1, xzr
-	mov	x2, xzr
-	mov	x3, xzr
-	br	x19
-3:
-SYM_CODE_END(efi_enter_kernel)
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index afa69e04e75e..cb97a9941425 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -10,8 +10,7 @@
 #error This file should only be included in vmlinux.lds.S
 #endif
 
-PROVIDE(__efistub_kernel_size		= _edata - _text);
-PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
+PROVIDE(__efistub_primary_entry		= primary_entry);
 
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
@@ -32,10 +31,11 @@ PROVIDE(__efistub_strnlen		= __pi_strnlen);
 PROVIDE(__efistub_strcmp		= __pi_strcmp);
 PROVIDE(__efistub_strncmp		= __pi_strncmp);
 PROVIDE(__efistub_strrchr		= __pi_strrchr);
-PROVIDE(__efistub_dcache_clean_poc	= __pi_dcache_clean_poc);
+PROVIDE(__efistub_caches_clean_inval_pou = __pi_caches_clean_inval_pou);
 
 PROVIDE(__efistub__text			= _text);
 PROVIDE(__efistub__end			= _end);
+PROVIDE(__efistub___inittext_end       	= __inittext_end);
 PROVIDE(__efistub__edata		= _edata);
 PROVIDE(__efistub_screen_info		= screen_info);
 PROVIDE(__efistub__ctype		= _ctype);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 081058d4e436..8c3b3ee9b1d7 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -52,10 +52,11 @@ alternative_else_nop_endif
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START(caches_clean_inval_pou)
+SYM_FUNC_START(__pi_caches_clean_inval_pou)
 	caches_clean_inval_pou_macro
 	ret
-SYM_FUNC_END(caches_clean_inval_pou)
+SYM_FUNC_END(__pi_caches_clean_inval_pou)
+SYM_FUNC_ALIAS(caches_clean_inval_pou, __pi_caches_clean_inval_pou)
 
 /*
  *	caches_clean_inval_user_pou(start,end)
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index f32e89b4049f..eb568ea3120b 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -87,7 +87,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_handle_t image_handle)
 {
 	efi_status_t status;
-	unsigned long kernel_size, kernel_memsize = 0;
+	unsigned long kernel_size, kernel_codesize, kernel_memsize = 0;
 	u32 phys_seed = 0;
 
 	/*
@@ -131,6 +131,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			SEGMENT_ALIGN >> 10);
 
 	kernel_size = _edata - _text;
+	kernel_codesize = __inittext_end - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
 	*reserve_size = kernel_memsize;
 
@@ -174,6 +175,21 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	*image_addr = *reserve_addr;
 	memcpy((void *)*image_addr, _text, kernel_size);
+	caches_clean_inval_pou((void *)*image_addr,
+			       (void *)*image_addr + kernel_codesize);
 
 	return EFI_SUCCESS;
 }
+
+asmlinkage void primary_entry(void);
+
+void __noreturn efi_enter_kernel(unsigned long entrypoint,
+				 unsigned long fdt_addr,
+				 unsigned long fdt_size)
+{
+	void (* __noreturn enter_kernel)(u64, u64, u64, u64);
+	u64 offset = (char *)primary_entry - _text;
+
+	enter_kernel = (void *)entrypoint + offset;
+	enter_kernel(fdt_addr, 0, 0, 0);
+}
-- 
2.35.1

