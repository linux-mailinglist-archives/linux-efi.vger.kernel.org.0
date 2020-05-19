Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD361D9C8E
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgESQ1M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 12:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESQ1L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 12:27:11 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4C520829;
        Tue, 19 May 2020 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905631;
        bh=ML7xIKOoEGmj8SHYu1fMuw14GUBck0Lag61YRn3ulRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZqtt8PwB6TkdWgrA2FRdjr5KkG5dGewH7ouN/4ABHG6Mv/8Gf5LYxfqWN7z2Suqa
         /MC52+qM0/hZLEFKsbYX7v5/pOLXymZYjJm7u05LJ0LzMZmrUQ8edCuKSAE3z3C1ev
         FtLBBTTG6WqxxuTbRwd0jUKVdZr73YKCbSipBpQs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 5/5] ARM: decompressor: run decompressor in place if loaded via UEFI
Date:   Tue, 19 May 2020 18:26:45 +0200
Message-Id: <20200519162645.31065-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519162645.31065-1-ardb@kernel.org>
References: <20200519162645.31065-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The decompressor can load from anywhere in memory, and the only reason
the EFI stub code relocates it is to ensure it appears within the first
128 MiB of memory, so that the uncompressed kernel ends up at the right
offset in memory.

We can short circuit this, and simply jump into the decompressor startup
code at the point where it knows where the base of memory lives. This
also means there is no need to disable the MMU and caches, create new
page tables and re-enable them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/boot/compressed/head.S           | 39 ++++++-----------
 drivers/firmware/efi/libstub/arm32-stub.c | 45 +++-----------------
 2 files changed, 20 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index ce442ec5028a..c79db44ba128 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1430,37 +1430,26 @@ reloc_code_end:
 
 #ifdef CONFIG_EFI_STUB
 ENTRY(efi_enter_kernel)
-		mov	r7, r0				@ preserve image base
-		mov	r4, r1				@ preserve DT pointer
+		mov	r4, r0			@ preserve image base
+		mov	r8, r1			@ preserve DT pointer
 
-		mov	r0, r4				@ DT start
-		add	r1, r4, r2			@ DT end
-		bl	cache_clean_flush
+		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
+		tst	r0, #0x1		@ MMU enabled?
+		orreq	r4, r4, #1		@ set LSB if not
 
-		mov	r0, r7				@ relocated zImage
-		ldr	r1, =_edata			@ size of zImage
-		add	r1, r1, r0			@ end of zImage
+		mov	r0, r8			@ DT start
+		add	r1, r8, r2		@ DT end
 		bl	cache_clean_flush
 
-		@ The PE/COFF loader might not have cleaned the code we are
-		@ running beyond the PoU, and so calling cache_off below from
-		@ inside the PE/COFF loader allocated region is unsafe unless
-		@ we explicitly clean it to the PoC.
-		adr	r0, call_cache_fn		@ region of code we will
-		adr	r1, 0f				@ run with MMU off
-		bl	cache_clean_flush
-		bl	cache_off
+		adr	r0, 0f			@ switch to our stack
+		ldr	sp, [r0]
+		add	sp, sp, r0
 
-		@ Set parameters for booting zImage according to boot protocol
-		@ put FDT address in r2, it was returned by efi_entry()
-		@ r1 is the machine type, and r0 needs to be 0
-		mov	r0, #0
-		mov	r1, #0xFFFFFFFF
-		mov	r2, r4
-		add	r7, r7, #(__efi_start - start)
-		mov	pc, r7				@ no mode switch
+		mov	r5, #0			@ appended DTB size
+		mov	r7, #0xFFFFFFFF		@ machine ID
+		b	wont_overwrite
 ENDPROC(efi_enter_kernel)
-0:
+0:		.long	.L_user_stack_end - .
 #endif
 
 		.align
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 7826553af2ba..0050d811bf20 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -199,14 +199,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	unsigned long kernel_base;
 	efi_status_t status;
 
-	/*
-	 * Verify that the DRAM base address is compatible with the ARM
-	 * boot protocol, which determines the base of DRAM by masking
-	 * off the low 27 bits of the address at which the zImage is
-	 * loaded. These assumptions are made by the decompressor,
-	 * before any memory map is available.
-	 */
-	kernel_base = round_up(dram_base, SZ_128M);
+	/* use a 16 MiB aligned base for the decompressed kernel */
+	kernel_base = round_up(dram_base, SZ_16M) + TEXT_OFFSET;
 
 	/*
 	 * Note that some platforms (notably, the Raspberry Pi 2) put
@@ -215,41 +209,14 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * base of the kernel image is only partially used at the moment.
 	 * (Up to 5 pages are used for the swapper page tables)
 	 */
-	kernel_base += TEXT_OFFSET - 5 * PAGE_SIZE;
-
-	status = reserve_kernel_base(kernel_base, reserve_addr, reserve_size);
+	status = reserve_kernel_base(kernel_base - 5 * PAGE_SIZE, reserve_addr,
+				     reserve_size);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
 	}
 
-	/*
-	 * Relocate the zImage, so that it appears in the lowest 128 MB
-	 * memory window.
-	 */
-	*image_addr = (unsigned long)image->image_base;
-	*image_size = image->image_size;
-	status = efi_relocate_kernel(image_addr, *image_size, *image_size,
-				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
-	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to relocate kernel.\n");
-		efi_free(*reserve_size, *reserve_addr);
-		*reserve_size = 0;
-		return status;
-	}
-
-	/*
-	 * Check to see if we were able to allocate memory low enough
-	 * in memory. The kernel determines the base of DRAM from the
-	 * address at which the zImage is loaded.
-	 */
-	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
-		pr_efi_err("Failed to relocate kernel, no low memory available.\n");
-		efi_free(*reserve_size, *reserve_addr);
-		*reserve_size = 0;
-		efi_free(*image_size, *image_addr);
-		*image_size = 0;
-		return EFI_LOAD_ERROR;
-	}
+	*image_addr = kernel_base;
+	*image_size = 0;
 	return EFI_SUCCESS;
 }
-- 
2.17.1

