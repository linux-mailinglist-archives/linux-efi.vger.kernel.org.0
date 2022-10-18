Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF556029D4
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJRLFQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJRLFJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9224CA22
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA0761523
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3709FC43470;
        Tue, 18 Oct 2022 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091104;
        bh=ajAZKUqLaOvnZYGz9N1ipr/BfWU81j4u/S3wIzL9ky0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPXcrYiRpc+6OGEB9DCY5ERG2qV3gbhByKGda0loszkEvMKjEOBcGUUAU2GJ+usvw
         G5FIE8mfd1PswWH6imoDM3+aLwLC0CAT6TjiHGkmG+tSuLb0dcAiD9FGUrUAmczaEu
         wLiOXno/hv+LEY/d+7OR2NGw2iwQs7Npgan1WW0O3FUk5V7tVGzBXW34qEDsOYZJKG
         tHqaDvcYS9EJe1cXYbHsQTFGfsGsoBklfzzbZRmGeP/EfazRsDYCGKWwgu8hxwAHc6
         rO77oSfzPNf3m7QY5Gw4p2j93gyM8HwBttx2AUrO4N4l/Of8qGtBug1LT75nu0tRjU
         gojJzD48bx5ZQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/6] arm64: efi/libstub: enter with the MMU on
Date:   Tue, 18 Oct 2022 13:04:41 +0200
Message-Id: <20221018110441.3855148-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5695; i=ardb@kernel.org; h=from:subject; bh=ajAZKUqLaOvnZYGz9N1ipr/BfWU81j4u/S3wIzL9ky0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohIXzaJn/IlJ+kFr1EYdYg4nuTbXt53uRA+Daku FmMybzSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06ISAAKCRDDTyI5ktmPJI/BDA C2Wgvhwat6TNEwsKTKdXKsg0noF3KpdReIyTepvXE8UBG0XgnocFlw6jD1dNkY2lM8Pdmr3xHBjjJF IGJ6jwgtT6vUPlR2r1pQ7/UwD4QWqNdz6O6pR5H37vBRnWL+R2sVEr1XR1r9BLn3nkmaQYtcNHNCum ek1TOBMnDFNYXxMUW4pQYA395zUDv2GJt451/Y2kSTjMG0m2iK/SrSOpC+Ns2a7roDvBNA5h2+l3ot sPg5L+rlWBsWzqUb48Fs8giS9oh+A3df5EXaat7mOMKjc9cIp+UYMJva/VKerTyRHzLRfir+K8wvbH SswaTYcCX8gm8OVikTCAfD8SBJ+wbEKZ2SybzXw89b0nwA/a57v1Fmx7YpBXMqZM+6qHxZ4pkGnRgA pU68xLvz7tBO4tiA10RDplYzE+qcyzlIhBhwWK8ZXwJ5FKvByVEKWIWPYoeYGdvjNDxCL5p0nlcyhc Mm35VGTHNtZtJymkk+Vb+yLCdgBwH7j/HpAV/4E3048z4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of disabling the MMU and caches before jumping to the kernel's
entry point, just call it directly, and keep the MMU and caches enabled.

This removes the need for any unconditional cache invalidation to the
PoC in the entry path (although cache maintenance of the code portion of
the image is still necessary for I/D coherency if the image was moved
around in memory). It also allows us to get rid of the asm routine, as
doing the jump is easily done from C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h             |  5 +-
 arch/arm64/mm/cache.S                      |  5 +-
 drivers/firmware/efi/libstub/arm64-entry.S | 57 --------------------
 drivers/firmware/efi/libstub/arm64-stub.c  | 17 +++++-
 4 files changed, 22 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 74d20835cf91..13e082e946c5 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -10,7 +10,7 @@
 #error This file should only be included in vmlinux.lds.S
 #endif
 
-PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
+PROVIDE(__efistub_primary_entry		= primary_entry);
 
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
@@ -28,10 +28,11 @@ PROVIDE(__efistub_strnlen		= __pi_strnlen);
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
diff --git a/drivers/firmware/efi/libstub/arm64-entry.S b/drivers/firmware/efi/libstub/arm64-entry.S
deleted file mode 100644
index 4524525ab314..000000000000
--- a/drivers/firmware/efi/libstub/arm64-entry.S
+++ /dev/null
@@ -1,57 +0,0 @@
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
-	dc	cvac, x4
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
index 6229f42c797f..9c7e2c1aace2 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -86,7 +86,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_handle_t image_handle)
 {
 	efi_status_t status;
-	unsigned long kernel_size, kernel_memsize = 0;
+	unsigned long kernel_size, kernel_codesize, kernel_memsize;
 	u32 phys_seed = 0;
 
 	/*
@@ -130,6 +130,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			SEGMENT_ALIGN >> 10);
 
 	kernel_size = _edata - _text;
+	kernel_codesize = __inittext_end - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
 	*reserve_size = kernel_memsize;
 
@@ -173,6 +174,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	*image_addr = *reserve_addr;
 	memcpy((void *)*image_addr, _text, kernel_size);
+	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
 
 clean_image_to_poc:
 	/*
@@ -184,3 +186,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
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

