Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D43D5C20
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhGZOLn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 10:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhGZOLi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Jul 2021 10:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A10D060F51;
        Mon, 26 Jul 2021 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627311127;
        bh=JWGJLeetH3HuGov8csCJlaN7PMNSS72rL67Heew3DQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTMkYu7oSioO80BXX/pX2ZJZvRv6MbGvlcFqpskmB2vTHhgl95sbxnfii7dTxcp4d
         pfv3bGRtdCrSFLl+Pw29cBRODEIObasVG6I2Z3UlgZwiRlFmOvTjGx2Sbh+CNpRqbK
         TJSso6Xr6VAQ6tGlF0tiuybRqfmmO+WaMt/7rygLFVkNjt9P7+W2HZYPikrCWe3dVf
         xXKNaPFQxN7VTqrMAgndJC6ncAiQzA4WeqZtPm5Gms0iPT6KjmaL1BQb5j8C7T4TBt
         CExnYuZIACUJaLjzbhFf/OW2Y86FBszCeQBhsDwkU0Z4PbML/JALEsR1Cg+TrxJ+nK
         QBi8+VY2GB69w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/4] efi/libstub: arm64: Relax 2M alignment again for relocatable kernels
Date:   Mon, 26 Jul 2021 16:51:54 +0200
Message-Id: <20210726145156.12006-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726145156.12006-1-ardb@kernel.org>
References: <20210726145156.12006-1-ardb@kernel.org>
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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 28 +++++++++-----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 3698c1ce2940..6f214c9c303e 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -79,18 +79,6 @@ static bool check_image_region(u64 base, u64 size)
 	return ret;
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
@@ -101,6 +89,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
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
@@ -130,7 +128,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align(),
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
@@ -139,7 +137,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	if (status != EFI_SUCCESS) {
 		if (!check_image_region((u64)_text, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align())) {
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
@@ -150,7 +148,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align());
+						    ULONG_MAX, min_kimg_align);
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to relocate kernel\n");
-- 
2.20.1

