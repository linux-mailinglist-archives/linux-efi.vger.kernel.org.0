Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B33D5718
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhGZJ3E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 05:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhGZJ3D (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Jul 2021 05:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08DA960F57;
        Mon, 26 Jul 2021 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627294172;
        bh=Ik40s7rXNJCPEneff8M5kbvQdqEXc7MNpOqxzRIoROA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmJTcJLiRSYjdlKMH1l7kHoqN2oN3UXYguTkCbMNFM34bUa8DbWK3P70ohBn7J1HE
         oWztZBhMDYciDUwPxrX92G16cEAEPqHw1Lm5SB6qr+ziIBEvaD9AGFLxK1xWDiRb6D
         R6Kw02BZIjq1L4HEyPWMsX3P8mF3UihK1tg/CR90S0fae1buoriQ6GIxfn00wz7mdQ
         a54cumATi4g0fX5EYQoyZ11qVsW4pH2i+liKKeGuql4mc6cePiejbHLKKBIPcw2dQK
         Hik+Ak/xqU1Xl3b4ANGSCjg+ugnosnisANR9to8OLL+Thpxw4uDKraBf2c3MXiKZSe
         uqasODQ5nNz4w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/2] efi/libstub: arm64: Force Image reallocation if BSS was not reserved
Date:   Mon, 26 Jul 2021 12:09:21 +0200
Message-Id: <20210726100922.120029-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726100922.120029-1-ardb@kernel.org>
References: <20210726100922.120029-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Distro versions of GRUB replace the usual LoadImage/StartImage calls
used to load the kernel image with some local code that fails to honor
the allocation requirements described in the PE/COFF header, as it
does not account for the image's BSS section at all: it fails to
allocate space for it, and fails to zero initialize it.

Since the EFI stub itself is allocated in the .init segment, which is
in the middle of the image, its BSS section is not impacted by this,
and the main consequence of this omission is that the BSS section may
overlap with memory regions that are already used by the firmware.

So let's warn about this condition, and force image reallocation to
occur in this case, which works around the problem.

Fixes: 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset with alignment check")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 49 +++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7bf0a7acae5e..3698c1ce2940 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -34,6 +34,51 @@ efi_status_t check_platform_features(void)
 	return EFI_SUCCESS;
 }
 
+/*
+ * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
+ * to provide space, and fail to zero it). Check for this condition by double
+ * checking that the first and the last byte of the image are covered by the
+ * same EFI memory map entry.
+ */
+static bool check_image_region(u64 base, u64 size)
+{
+	unsigned long map_size, desc_size, buff_size;
+	efi_memory_desc_t *memory_map;
+	struct efi_boot_memmap map;
+	efi_status_t status;
+	bool ret = false;
+	int map_offset;
+
+	map.map =	&memory_map;
+	map.map_size =	&map_size;
+	map.desc_size =	&desc_size;
+	map.desc_ver =	NULL;
+	map.key_ptr =	NULL;
+	map.buff_size =	&buff_size;
+
+	status = efi_get_memory_map(&map);
+	if (status != EFI_SUCCESS)
+		return false;
+
+	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
+		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
+
+		/*
+		 * Find the region that covers base, and return whether
+		 * it covers base+size bytes.
+		 */
+		if (base >= md->phys_addr && base < end) {
+			ret = (base + size) <= end;
+			break;
+		}
+	}
+
+	efi_bs_call(free_pool, memory_map);
+
+	return ret;
+}
+
 /*
  * Although relocatable kernels can fix up the misalignment with respect to
  * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
@@ -92,7 +137,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	}
 
 	if (status != EFI_SUCCESS) {
-		if (IS_ALIGNED((u64)_text, min_kimg_align())) {
+		if (!check_image_region((u64)_text, kernel_memsize)) {
+			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align())) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
-- 
2.20.1

