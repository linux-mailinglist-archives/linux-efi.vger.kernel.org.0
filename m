Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011E43D220E
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jul 2021 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhGVJqQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jul 2021 05:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhGVJqN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 22 Jul 2021 05:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BC4960FED;
        Thu, 22 Jul 2021 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626949571;
        bh=fHT59LhvE3gc9fM6N3ufqFMTVW0dfEM2SVeZ98t/cB0=;
        h=From:To:Cc:Subject:Date:From;
        b=jLlxmgvHZyeju+fi7zxuu2/WjWE6Cbc5+kLfAtzW/jhnNuA1kcGtCe8LbdKJnmXGB
         O3Ht0J1et3VdswiquEdvtfiHBcBH1u/ivS778uPWzOBgQE0XzdgFz0MOWO4AM72YA3
         Pyl4a8/lstZIrPORrhJ97AOguvzx94E+cabq+Km3OCdycM2+BkvOUYdjcEP6Pj1e2A
         qstAPldzEX3IS9SDa1S01ZEpaDQjV1N4Pk9eyM4IwMmMv1v682tT/nV+i1xBXKFeJm
         E2b5uuGWr82sLe9fk6mxJfGWzMZa0DpehTo9VyWL92fOW7LkXRlc6d7SY+M34K3+8u
         mIdWJTVV1PfKQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] efistub: arm64: relax 2M alignment again for relocatable kernels
Date:   Thu, 22 Jul 2021 12:26:00 +0200
Message-Id: <20210722102600.58392-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset with
alignment check") simplified the way the stub moves the kernel image
around in memory before booting it, given that a relocatable image does
not need to be copied to a 2M aligned offset if it was loaded on a 64k
boundary by EFI.

Commit d32de9130f6c ("efi/arm64: libstub: Deal gracefully with
EFI_RNG_PROTOCOL failure") inadvertently defeated this logic by
overriding the value of efi_nokaslr if EFI_RNG_PROTOCOL is not
available, which was mistaked by the loader logic as an explicit request
on the part of the user to disable KASLR and any associated relocation
of an Image not loaded on a 2M boundary.

So let's reinstate this functionality, by capturing the value of
efi_nokaslr at function entry to choose the minimum alignment.

Fixes: d32de9130f6c ("efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
This fixes the regression that was discussed in [0], but given that it
is very likely to break Ben's use case again, I'll sit on it for the
time being.

[0] https://lore.kernel.org/linux-efi/161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org/

 drivers/firmware/efi/libstub/arm64-stub.c | 28 +++++++++-----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7bf0a7acae5e..98e013404ca3 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -34,18 +34,6 @@ efi_status_t check_platform_features(void)
 	return EFI_SUCCESS;
 }
 
-/*
- * Although relocatable kernels can fix up the misalignment with respect to
- * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
- * sync with those recorded in the vmlinux when kaslr is disabled but the
- * image required relocation anyway. Therefore retain 2M alignment unless
- * KASLR is in use.
- */
-static u64 min_kimg_align(void)
-{
-	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -56,6 +44,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	unsigned long kernel_size, kernel_memsize = 0;
 	u32 phys_seed = 0;
 
+	/*
+	 * Although relocatable kernels can fix up the misalignment with
+	 * respect to MIN_KIMG_ALIGN, the resulting virtual text addresses are
+	 * subtly out of sync with those recorded in the vmlinux when kaslr is
+	 * disabled but the image required relocation anyway. Therefore retain
+	 * 2M alignment if KASLR was explicitly disabled, even if it was not
+	 * going to be activated to begin with.
+	 */
+	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		if (!efi_nokaslr) {
 			status = efi_get_random_bytes(sizeof(phys_seed),
@@ -85,14 +83,14 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align(),
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
 	}
 
 	if (status != EFI_SUCCESS) {
-		if (IS_ALIGNED((u64)_text, min_kimg_align())) {
+		if (IS_ALIGNED((u64)_text, min_kimg_align)) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
@@ -103,7 +101,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align());
+						    ULONG_MAX, min_kimg_align);
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to relocate kernel\n");
-- 
2.20.1

