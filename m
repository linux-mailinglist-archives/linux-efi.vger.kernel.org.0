Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB11B7658
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgDXNHC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgDXNG6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:58 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D0721569;
        Fri, 24 Apr 2020 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733617;
        bh=vZ2mY0Fi8GtL2gtiC4tR9yAyAZ8ys6huFhYY105Hm+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Smbt+vIBubprOoGwndT69kEsRuXbh3Dsu0UOcxmxjFKs+bMmlvRHLXa/1tydGz9I
         DLzsaXCidBM3eeDXC7cZoy+KqzY3oU57rYyQ7FGcY7kreCuOps/dEfKvShQgyD0dXQ
         EHFkQ2Fk8ULBr04u6XmDgewrAxMaJ0Ep8TiBV/Ys=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 21/33] efi/libstub/arm64: Replace 'preferred' offset with alignment check
Date:   Fri, 24 Apr 2020 15:05:19 +0200
Message-Id: <20200424130531.30518-22-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The notion of a 'preferred' load offset for the kernel dates back to the
times when the kernel's primary mapping overlapped with the linear region,
and memory below it could not be used at all.

Today, the arm64 kernel does not really care where it is loaded in physical
memory, as long as the alignment requirements are met, and so there is no
point in unconditionally moving the kernel to a new location in memory at
boot. Instead, we can
- check for a KASLR seed, and randomly reallocate the kernel if one is
  provided
- otherwise, check whether the alignment requirements are met for the
  current placement of the kernel, and just run it in place if they are
- finally, do an ordinary page allocation and reallocate the kernel to a
  suitably aligned buffer anywhere in memory.

By the same reasoning, there is no need to take TEXT_OFFSET into account
if it is a round multiple of the minimum alignment, which is the usual
case for relocatable kernels with TEXT_OFFSET randomization disabled.
Otherwise, it suffices to use the relative misaligment of TEXT_OFFSET
when reallocating the kernel.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 62 +++++++++--------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index fc9f8ab533a7..cfd535c13242 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -34,6 +34,15 @@ efi_status_t check_platform_features(void)
 	return EFI_SUCCESS;
 }
 
+/*
+ * Relocatable kernels can fix up the misalignment with respect to
+ * MIN_KIMG_ALIGN, so they only require a minimum alignment of EFI_KIMG_ALIGN
+ * (which accounts for the alignment of statically allocated objects such as
+ * the swapper stack.)
+ */
+static const u64 min_kimg_align = IS_ENABLED(CONFIG_RELOCATABLE) ? EFI_KIMG_ALIGN
+								 : MIN_KIMG_ALIGN;
+
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -43,7 +52,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_memsize = 0;
-	unsigned long preferred_offset;
 	u64 phys_seed = 0;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
@@ -61,14 +69,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 	}
 
-	/*
-	 * The preferred offset of the kernel Image is TEXT_OFFSET bytes beyond
-	 * a 2 MB aligned base, which itself may be lower than dram_base, as
-	 * long as the resulting offset equals or exceeds it.
-	 */
-	preferred_offset = round_down(dram_base, MIN_KIMG_ALIGN) + TEXT_OFFSET;
-	if (preferred_offset < dram_base)
-		preferred_offset += MIN_KIMG_ALIGN;
+	if (image->image_base != _text)
+		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
 
 	kernel_size = _edata - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
@@ -103,46 +105,32 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 		*image_addr = *reserve_addr + offset;
 	} else {
-		/*
-		 * Else, try a straight allocation at the preferred offset.
-		 * This will work around the issue where, if dram_base == 0x0,
-		 * efi_low_alloc() refuses to allocate at 0x0 (to prevent the
-		 * address of the allocation to be mistaken for a FAIL return
-		 * value or a NULL pointer). It will also ensure that, on
-		 * platforms where the [dram_base, dram_base + TEXT_OFFSET)
-		 * interval is partially occupied by the firmware (like on APM
-		 * Mustang), we can still place the kernel at the address
-		 * 'dram_base + TEXT_OFFSET'.
-		 */
-		*image_addr = (unsigned long)_text;
-		if (*image_addr == preferred_offset)
-			return EFI_SUCCESS;
-
-		*image_addr = *reserve_addr = preferred_offset;
-		*reserve_size = round_up(kernel_memsize, EFI_ALLOC_ALIGN);
-
-		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA,
-				     *reserve_size / EFI_PAGE_SIZE,
-				     (efi_physical_addr_t *)reserve_addr);
+		status = EFI_OUT_OF_RESOURCES;
 	}
 
 	if (status != EFI_SUCCESS) {
-		*reserve_size = kernel_memsize + TEXT_OFFSET;
+		if (IS_ALIGNED((u64)_text - TEXT_OFFSET, min_kimg_align)) {
+			/*
+			 * Just execute from wherever we were loaded by the
+			 * UEFI PE/COFF loader if the alignment is suitable.
+			 */
+			*image_addr = (u64)_text;
+			*reserve_size = 0;
+			return EFI_SUCCESS;
+		}
+
+		*reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align;
 		status = efi_low_alloc(*reserve_size,
-				       MIN_KIMG_ALIGN, reserve_addr);
+				       min_kimg_align, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to relocate kernel\n");
 			*reserve_size = 0;
 			return status;
 		}
-		*image_addr = *reserve_addr + TEXT_OFFSET;
+		*image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align;
 	}
 
-	if (image->image_base != _text)
-		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
-
 	memcpy((void *)*image_addr, _text, kernel_size);
 
 	return EFI_SUCCESS;
-- 
2.17.1

