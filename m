Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75C621BCF
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiKHSWl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiKHSWk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C0C22
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4566761727
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2DEC43470;
        Tue,  8 Nov 2022 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931758;
        bh=2LT4g6R1nMcPAxzEz9SIz9J/vXCoCtzO6ohXg48lfz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nftRC+QasozAq1uqe4KN25bXFi/tqyLWUxl/S5dhpDyX+Fb2ULDzKnUiN5dTNRPm0
         GB3qIfAaCoqW8+A74W53XvPGqtD77/VjZpbifyTZUHxIzal5+v2x4OuFmbKaRezOhS
         DxfRltz80V9WvXmlptTwF30X1fPqh4tjsQXZQzE1uewjV9RcKmmcTy4VvDxV0uzCGP
         JbbRv5HXLPwdkE4uQ718a7erSNgLRII70nXRksmF4RuKz1/TrvLoSdGKNsIf6SPkwg
         t0/QCtBta19JXkm+YA2WS5g2PxFaXuxtMT3kNsgYC6Pk7pSURUGXnDvVN/nRpJNtKF
         ld2mXY3keSV/A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 7/7] efi: arm64: enter with MMU and caches enabled
Date:   Tue,  8 Nov 2022 19:22:04 +0100
Message-Id: <20221108182204.2447664-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10257; i=ardb@kernel.org; h=from:subject; bh=2LT4g6R1nMcPAxzEz9SIz9J/vXCoCtzO6ohXg48lfz8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5LsbQS1qsGAKfMV/J3zbH30Ca+KL5ZNgIEy5K9 2es1fnKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeSwAKCRDDTyI5ktmPJJlVC/ 9EwYzqD5I3O+Kls7Zze6WX+/P1sWi7aw+tl7mMRZ5387xzNpkt+fTJ9hzqTjhm1WBY+R3DoAx+9MSU H5s9Iqm+nlm76ONiZAUQsJkZGGnv6leAkFZsmDHLGn7fvoEUfzphDsGS5ZsbVbwmOwXe0vYsTHC8Yc zh9l3zNn75l9xaxfS4KyI0iZ8He65YzACGW+0UoWDDzbZNLfMVn1zrBifFZzavoK5d8IWYq1m9SzWo LWlwMF0haSjD/3NY+1kq4qZHT4i+CJHm8lg8TSunUo0j5gamjmYtUgaPSbP3LlpWPhz6bPq0LqJNH9 Jb8/UXtmEZ/fJeJnAJ8OJ2YzEk2Ttd1XN9nZkjOw/j0OY3A03JT8o/52fJCt1xrcYwp2Zxuk6uQKth Her1hXlLDsVaFIoVQOyTEXc3tTz+s4z3sXC9KCbhh/WiT3nxFOkaG8lrrtoQ8LdpfRVADFo2O7RoJM 8Dxpbskb0Iaa7RfyFzusczX528YpEJCjMZuPEWsjYkszE=
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

Instead of cleaning the entire loaded kernel image to the PoC and
disabling the MMU and caches before branching to the kernel's bare metal
entry point, we can leave the MMU and caches enabled, and rely on EFI's
cacheable 1:1 mapping of all of system RAM (which is mandated by the
spec) to populate the initial page tables.

This removes the need for managing coherency in software, which is
tedious and error prone.

Note that we still need to clean the executable region of the image to
the PoU if this is required for I/D coherency, but only if we actually
decided to move the image in memory, as otherwise, this will have been
taken care of by the loader.

This change affects both the builtin EFI stub as well as the zboot
decompressor, which now carries the entire EFI stub along with the
decompression code and the compressed image.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h             |  5 +-
 arch/arm64/mm/cache.S                      |  5 +-
 drivers/firmware/efi/libstub/Makefile      |  4 +-
 drivers/firmware/efi/libstub/arm64-entry.S | 67 --------------------
 drivers/firmware/efi/libstub/arm64-stub.c  | 26 +++++---
 drivers/firmware/efi/libstub/arm64.c       | 41 ++++++++++--
 6 files changed, 61 insertions(+), 87 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f31130ba02331060..40ebb882d2d8c97b 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -10,7 +10,7 @@
 #error This file should only be included in vmlinux.lds.S
 #endif
 
-PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
+PROVIDE(__efistub_primary_entry		= primary_entry);
 
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
@@ -21,10 +21,11 @@ PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-PROVIDE(__efistub_dcache_clean_poc	= __pi_dcache_clean_poc);
+PROVIDE(__efistub_caches_clean_inval_pou = __pi_caches_clean_inval_pou);
 
 PROVIDE(__efistub__text			= _text);
 PROVIDE(__efistub__end			= _end);
+PROVIDE(__efistub___inittext_end       	= __inittext_end);
 PROVIDE(__efistub__edata		= _edata);
 PROVIDE(__efistub_screen_info		= screen_info);
 PROVIDE(__efistub__ctype		= _ctype);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 081058d4e4366edb..8c3b3ee9b1d725c8 100644
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
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 402dfb30ddc7a01e..f838ab98978f1038 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,7 +86,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 				   screen_info.o efi-stub-entry.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o arm64-entry.o
+lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
@@ -140,7 +140,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 #
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
-STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS64
+STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
 # For RISC-V, we don't need anything special other than arm64. Keep all the
 # symbols in .init section and make sure that no absolute symbols references
diff --git a/drivers/firmware/efi/libstub/arm64-entry.S b/drivers/firmware/efi/libstub/arm64-entry.S
deleted file mode 100644
index b5c17e89a4fc0c21..0000000000000000
--- a/drivers/firmware/efi/libstub/arm64-entry.S
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * EFI entry point.
- *
- * Copyright (C) 2013, 2014 Red Hat, Inc.
- * Author: Mark Salter <msalter@redhat.com>
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-	/*
-	 * The entrypoint of a arm64 bare metal image is at offset #0 of the
-	 * image, so this is a reasonable default for primary_entry_offset.
-	 * Only when the EFI stub is integrated into the core kernel, it is not
-	 * guaranteed that the PE/COFF header has been copied to memory too, so
-	 * in this case, primary_entry_offset should be overridden by the
-	 * linker and point to primary_entry() directly.
-	 */
-	.weak	primary_entry_offset
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
-
-	mov	x0, x1			// DTB address
-	mov	x1, xzr
-	mov	x2, xzr
-	mov	x3, xzr
-
-	/*
-	 * Clean the remainder of this routine to the PoC
-	 * so that we can safely disable the MMU and caches.
-	 */
-	adr	x4, 1f
-	dc	civac, x4
-	dsb	sy
-
-	/* Turn off Dcache and MMU */
-	mrs	x4, CurrentEL
-	cmp	x4, #CurrentEL_EL2
-	mrs	x4, sctlr_el1
-	b.ne	0f
-	mrs	x4, sctlr_el2
-0:	bic	x4, x4, #SCTLR_ELx_M
-	bic	x4, x4, #SCTLR_ELx_C
-	b.eq	1f
-	b	2f
-
-	.balign	32
-1:	pre_disable_mmu_workaround
-	msr	sctlr_el2, x4
-	isb
-	br	x19		// jump to kernel entrypoint
-
-2:	pre_disable_mmu_workaround
-	msr	sctlr_el1, x4
-	isb
-	br	x19		// jump to kernel entrypoint
-
-	.org	1b + 32
-SYM_CODE_END(efi_enter_kernel)
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7f0aab3a8ab302d6..00fb2eab6d0c74ef 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -58,7 +58,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_handle_t image_handle)
 {
 	efi_status_t status;
-	unsigned long kernel_size, kernel_memsize = 0;
+	unsigned long kernel_size, kernel_codesize, kernel_memsize;
 	u32 phys_seed = 0;
 	u64 min_kimg_align = efi_get_kimg_min_align();
 
@@ -93,6 +93,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			SEGMENT_ALIGN >> 10);
 
 	kernel_size = _edata - _text;
+	kernel_codesize = __inittext_end - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
 	*reserve_size = kernel_memsize;
 
@@ -120,7 +121,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			 */
 			*image_addr = (u64)_text;
 			*reserve_size = 0;
-			goto clean_image_to_poc;
+			return EFI_SUCCESS;
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
@@ -136,14 +137,21 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	*image_addr = *reserve_addr;
 	memcpy((void *)*image_addr, _text, kernel_size);
+	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
 
-clean_image_to_poc:
+	return EFI_SUCCESS;
+}
+
+asmlinkage void primary_entry(void);
+
+unsigned long primary_entry_offset(void)
+{
 	/*
-	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
-	 * stale icache entries from before relocation.
+	 * When built as part of the kernel, the EFI stub cannot branch to the
+	 * kernel proper via the image header, as the PE/COFF header is
+	 * strictly not part of the in-memory presentation of the image, only
+	 * of the file representation. So instead, we need to jump to the
+	 * actual entrypoint in the .text region of the image.
 	 */
-	dcache_clean_poc(*image_addr, *image_addr + kernel_size);
-	asm("ic ialluis");
-
-	return EFI_SUCCESS;
+	return (char *)primary_entry - _text;
 }
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index d2e94972c5fad523..99f86ddc91cf10cf 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -41,6 +41,12 @@ efi_status_t check_platform_features(void)
 	return EFI_SUCCESS;
 }
 
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
+#define DCTYPE	"civac"
+#else
+#define DCTYPE	"cvau"
+#endif
+
 void efi_cache_sync_image(unsigned long image_base,
 			  unsigned long alloc_size,
 			  unsigned long code_size)
@@ -49,13 +55,38 @@ void efi_cache_sync_image(unsigned long image_base,
 	u64 lsize = 4 << cpuid_feature_extract_unsigned_field(ctr,
 						CTR_EL0_DminLine_SHIFT);
 
-	do {
-		asm("dc civac, %0" :: "r"(image_base));
-		image_base += lsize;
-		alloc_size -= lsize;
-	} while (alloc_size >= lsize);
+	/* only perform the cache maintenance if needed for I/D coherency */
+	if (!(ctr & BIT(CTR_EL0_IDC_SHIFT))) {
+		do {
+			asm("dc " DCTYPE ", %0" :: "r"(image_base));
+			image_base += lsize;
+			code_size -= lsize;
+		} while (code_size >= lsize);
+	}
 
 	asm("ic ialluis");
 	dsb(ish);
 	isb();
 }
+
+unsigned long __weak primary_entry_offset(void)
+{
+	/*
+	 * By default, we can invoke the kernel via the branch instruction in
+	 * the image header, so offset #0. This will be overridden by the EFI
+	 * stub build that is linked into the core kernel, as in that case, the
+	 * image header may not have been loaded into memory, or may be mapped
+	 * with non-executable permissions.
+	 */
+       return 0;
+}
+
+void __noreturn efi_enter_kernel(unsigned long entrypoint,
+				 unsigned long fdt_addr,
+				 unsigned long fdt_size)
+{
+	void (* __noreturn enter_kernel)(u64, u64, u64, u64);
+
+	enter_kernel = (void *)entrypoint + primary_entry_offset();
+	enter_kernel(fdt_addr, 0, 0, 0);
+}
-- 
2.35.1

