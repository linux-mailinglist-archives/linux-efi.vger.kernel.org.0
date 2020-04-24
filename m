Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6D1B7657
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgDXNHB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgDXNHA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:00 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DABF20776;
        Fri, 24 Apr 2020 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733620;
        bh=dv+ZaFhzeEqvKSGnInxiwWTt/ioK6J793NdZ5ogNnHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaD36U46EHROKfyL42WnWW2saO3W2GOheB+ccWVAlZWgwB7kWcLZ2wF6Zk6rYZcSU
         7fctkjDj2iHGJ7xZSopyyjXj9JbLPN6bz+u0/dW93kyBRHsnz85/59ZgagZ2EZbkLL
         d+qQkZ35AcVW6tvnPcq1q1HV3RZ5eW4DPLntaabc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 22/33] efi/libstub/arm64: Simplify randomized loading of kernel image
Date:   Fri, 24 Apr 2020 15:05:20 +0200
Message-Id: <20200424130531.30518-23-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KASLR code path in the arm64 version of the EFI stub incorporates
some overly complicated logic to randomly allocate a region of the right
alignment: there is no need to randomize the placement of the kernel
modulo 2 MiB separately from the placement of the 2 MiB aligned allocation
itself - we can simply follow the same logic used by the non-randomized
placement, which is to allocate at the correct alignment, and only take
TEXT_OFFSET into account if it is not a round multiple of the alignment.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 32 ++++-------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index cfd535c13242..6fc3bd9a56db 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -52,7 +52,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_memsize = 0;
-	u64 phys_seed = 0;
+	u32 phys_seed = 0;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		if (!nokaslr()) {
@@ -74,36 +74,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	kernel_size = _edata - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
+	*reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
-		/*
-		 * Produce a displacement in the interval [0, MIN_KIMG_ALIGN)
-		 * that doesn't violate this kernel's de-facto alignment
-		 * constraints.
-		 */
-		u32 mask = (MIN_KIMG_ALIGN - 1) & ~(EFI_KIMG_ALIGN - 1);
-		u32 offset = (phys_seed >> 32) & mask;
-
-		/*
-		 * With CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET may not
-		 * be a multiple of EFI_KIMG_ALIGN, and we must ensure that
-		 * we preserve the misalignment of 'offset' relative to
-		 * EFI_KIMG_ALIGN so that statically allocated objects whose
-		 * alignment exceeds PAGE_SIZE appear correctly aligned in
-		 * memory.
-		 */
-		offset |= TEXT_OFFSET % EFI_KIMG_ALIGN;
-
 		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		*reserve_size = kernel_memsize + offset;
-		status = efi_random_alloc(*reserve_size,
-					  MIN_KIMG_ALIGN, reserve_addr,
-					  (u32)phys_seed);
-
-		*image_addr = *reserve_addr + offset;
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
+					  reserve_addr, phys_seed);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
 	}
@@ -119,7 +98,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			return EFI_SUCCESS;
 		}
 
-		*reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align;
 		status = efi_low_alloc(*reserve_size,
 				       min_kimg_align, reserve_addr);
 
@@ -128,9 +106,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			*reserve_size = 0;
 			return status;
 		}
-		*image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align;
 	}
 
+	*image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align;
 	memcpy((void *)*image_addr, _text, kernel_size);
 
 	return EFI_SUCCESS;
-- 
2.17.1

