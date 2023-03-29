Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DE6CD1A5
	for <lists+linux-efi@lfdr.de>; Wed, 29 Mar 2023 07:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjC2FdO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Mar 2023 01:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjC2Fc6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Mar 2023 01:32:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC673AA6
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:32:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p34so8138513wms.3
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680067954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/RerhG4T/yFf2BoY2e3Gr2ZtC7zbwdaRkEeOQ/2QmI=;
        b=hZW97tAfR9MepbrUzxjza8gsmYfWRPxGTIOoFYDjD+S1T8fwx72pbxz1UA1FX/IEkJ
         4SRrCtDTIFUdrq7mlb9fKf5EOnr96bTWKT8bywcwUvQifb4v+p8Ue8RnersW52+PBS+o
         qkcUG1yBco/P45By3Mzf35wT8zqXB6Wy3574wZ0bty0uesnTGDa/wR1vZmjNCf5WBzSz
         b8XPy/IhmNb26OIhwjOKY1YF0wM6bh8wWgGQ1Fi7LWREA2R8Pl074hVgTs7ajBlQU5+A
         1YVDYxWYesJMo5rbtLiVtykD2GWbrsjERnBdSwcqE8boiqT5yNbZKZFrtU+FQOTYaF4x
         4Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680067954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/RerhG4T/yFf2BoY2e3Gr2ZtC7zbwdaRkEeOQ/2QmI=;
        b=XG8U/qcGMKJ8/1pvpWtegJlV+U7aUFohXGnAa8BBDXRhTRkSzTNKFuUolAoXNWQ3k4
         RLLctp4y7Khd9J9rB2GrZ0tc4x/W0JgebGBXq+bS8RP5pS6c9Ozj1Gzhza35BRvs0ijB
         W3w28s7Xr4Ee6iG4qu0VRgVEy890eD4WA8YXVLVcqCywnFh7ouq4H+G4yfp1CKtKZAzz
         1fH+/lWmIh4owcjJD0BBhSioR7mLO5HzG5F8rgRqzOlrfA5eiNJ8AuhDOQp4WbXo+6Lh
         U5ZgdniVPi5KDZwWtjJCjRpLNU8/YLBQIjh1UrOn8kRMKIzlQWelmUEqAPRLDNkdyMLs
         HErg==
X-Gm-Message-State: AO0yUKXWUS69HwCdAeaU+EgtlMXemNwfEw8NkpZU8oZi68v1RNBW5/Jn
        PcuW1we7LTL3Xt9ifk9jkvqlQg==
X-Google-Smtp-Source: AK7set8Z9evQXF1R8BE4vRjNMI06RxjawH9XbXADarypRfaTnz+UPMsRsqXQL3zUUU2PDeNv3uYbVA==
X-Received: by 2002:a05:600c:22d5:b0:3ee:3d2d:841a with SMTP id 21-20020a05600c22d500b003ee3d2d841amr15109287wmg.24.1680067954608;
        Tue, 28 Mar 2023 22:32:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003eda46d6792sm880724wmo.32.2023.03.28.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:32:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/4] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
Date:   Wed, 29 Mar 2023 07:29:25 +0200
Message-Id: <20230329052926.69632-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329052926.69632-1-alexghiti@rivosinc.com>
References: <20230329052926.69632-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This prepares for riscv to use the same functions to handle the pĥysical
kernel move when KASLR is enabled.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/firmware/efi/libstub/arm64-stub.c     | 111 +------------
 .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 3 files changed, 167 insertions(+), 103 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index d4a6b12a8741..b9e0d2cf09aa 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -14,42 +14,6 @@
 
 #include "efistub.h"
 
-/*
- * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
- * to provide space, and fail to zero it). Check for this condition by double
- * checking that the first and the last byte of the image are covered by the
- * same EFI memory map entry.
- */
-static bool check_image_region(u64 base, u64 size)
-{
-	struct efi_boot_memmap *map;
-	efi_status_t status;
-	bool ret = false;
-	int map_offset;
-
-	status = efi_get_memory_map(&map, false);
-	if (status != EFI_SUCCESS)
-		return false;
-
-	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
-		efi_memory_desc_t *md = (void *)map->map + map_offset;
-		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
-
-		/*
-		 * Find the region that covers base, and return whether
-		 * it covers base+size bytes.
-		 */
-		if (base >= md->phys_addr && base < end) {
-			ret = (base + size) <= end;
-			break;
-		}
-	}
-
-	efi_bs_call(free_pool, map);
-
-	return ret;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_codesize, kernel_memsize;
-	u32 phys_seed = 0;
-	u64 min_kimg_align = efi_get_kimg_min_align();
-
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
-		void *p;
-
-		if (efi_nokaslr) {
-			efi_info("KASLR disabled on kernel command line\n");
-		} else if (efi_bs_call(handle_protocol, image_handle,
-				       &li_fixed_proto, &p) == EFI_SUCCESS) {
-			efi_info("Image placement fixed by loader\n");
-		} else {
-			status = efi_get_random_bytes(sizeof(phys_seed),
-						      (u8 *)&phys_seed);
-			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable\n");
-				efi_nokaslr = true;
-			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
-					status);
-				efi_nokaslr = true;
-			}
-		}
-	}
 
 	if (image->image_base != _text)
 		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
@@ -96,49 +35,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	kernel_codesize = __inittext_end - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
 	*reserve_size = kernel_memsize;
+	*image_addr = (unsigned long)_text;
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
-		/*
-		 * If KASLR is enabled, and we have some randomness available,
-		 * locate the kernel at a randomized offset in physical memory.
-		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align,
-					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE);
-		if (status != EFI_SUCCESS)
-			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
-	} else {
-		status = EFI_OUT_OF_RESOURCES;
-	}
-
-	if (status != EFI_SUCCESS) {
-		if (!check_image_region((u64)_text, kernel_memsize)) {
-			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
-			   (u64)_end < EFI_ALLOC_LIMIT) {
-			/*
-			 * Just execute from wherever we were loaded by the
-			 * UEFI PE/COFF loader if the placement is suitable.
-			 */
-			*image_addr = (u64)_text;
-			*reserve_size = 0;
-			return EFI_SUCCESS;
-		}
-
-		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align,
-						    EFI_LOADER_CODE);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to relocate kernel\n");
-			*reserve_size = 0;
-			return status;
-		}
-	}
-
-	*image_addr = *reserve_addr;
-	memcpy((void *)*image_addr, _text, kernel_size);
-	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+	status = efi_kaslr_relocate_kernel(image_addr,
+					   reserve_addr, reserve_size,
+					   kernel_size, kernel_codesize,
+					   kernel_memsize,
+					   efi_kaslr_get_phys_seed(image_handle));
+	if (status != EFI_SUCCESS)
+		return status;
 
 	return EFI_SUCCESS;
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691..40ac2625949c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -718,3 +718,154 @@ void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 			efi_warn("Failed to remap data region non-executable\n");
 	}
 }
+
+/**
+ * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KASLR
+ * @image_handle:	Handle to the image
+ *
+ * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOCOL
+ * that will be used to move the kernel physical mapping.
+ *
+ * Return:	the random seed
+ */
+u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
+{
+	efi_status_t status;
+	u32 phys_seed;
+	efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
+	void *p;
+
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return 0;
+
+	if (efi_nokaslr) {
+		efi_info("KASLR disabled on kernel command line\n");
+	} else if (efi_bs_call(handle_protocol, image_handle,
+			       &li_fixed_proto, &p) == EFI_SUCCESS) {
+		efi_info("Image placement fixed by loader\n");
+	} else {
+		status = efi_get_random_bytes(sizeof(phys_seed),
+					      (u8 *)&phys_seed);
+		if (status == EFI_SUCCESS) {
+			return phys_seed;
+		} else if (status == EFI_NOT_FOUND) {
+			efi_info("EFI_RNG_PROTOCOL unavailable\n");
+			efi_nokaslr = true;
+		} else if (status != EFI_SUCCESS) {
+			efi_err("efi_get_random_bytes() failed (0x%lx)\n",
+				status);
+			efi_nokaslr = true;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
+ * to provide space, and fail to zero it). Check for this condition by double
+ * checking that the first and the last byte of the image are covered by the
+ * same EFI memory map entry.
+ */
+static bool check_image_region(u64 base, u64 size)
+{
+	struct efi_boot_memmap *map;
+	efi_status_t status;
+	bool ret = false;
+	int map_offset;
+
+	status = efi_get_memory_map(&map, false);
+	if (status != EFI_SUCCESS)
+		return false;
+
+	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
+		efi_memory_desc_t *md = (void *)map->map + map_offset;
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
+	efi_bs_call(free_pool, map);
+
+	return ret;
+}
+
+/**
+ * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR enabled)
+ * @image_addr:	Pointer to the current kernel location
+ * @reserve_addr:	Pointer to the relocated kernel location
+ * @reserve_size:	Size of the relocated kernel
+ * @kernel_size:	Size of the text + data
+ * @kernel_codesize:	Size of the text
+ * @kernel_memsize:	Size of the text + data + bss
+ * @phys_seed:		Random seed used for the relocation
+ *
+ * If KASLR is not enabled, this function relocates the kernel to a fixed
+ * address (or leave it as its current location). If KASLR is enabled, the
+ * kernel physical location is randomized using the seed in parameter.
+ *
+ * Return:	status code, EFI_SUCCESS if relocation is successful
+ */
+efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
+				       unsigned long *reserve_addr,
+				       unsigned long *reserve_size,
+				       unsigned long kernel_size,
+				       unsigned long kernel_codesize,
+				       unsigned long kernel_memsize,
+				       u32 phys_seed)
+{
+	efi_status_t status;
+	u64 min_kimg_align = efi_get_kimg_min_align();
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
+		/*
+		 * If KASLR is enabled, and we have some randomness available,
+		 * locate the kernel at a randomized offset in physical memory.
+		 */
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
+					  reserve_addr, phys_seed,
+					  EFI_LOADER_CODE);
+		if (status != EFI_SUCCESS)
+			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
+	} else {
+		status = EFI_OUT_OF_RESOURCES;
+	}
+
+	if (status != EFI_SUCCESS) {
+		if (!check_image_region(*image_addr, kernel_memsize)) {
+			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
+		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
+			   (u64)_end < EFI_ALLOC_LIMIT) {
+			/*
+			 * Just execute from wherever we were loaded by the
+			 * UEFI PE/COFF loader if the placement is suitable.
+			 */
+			*reserve_size = 0;
+			return EFI_SUCCESS;
+		}
+
+		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
+						    ULONG_MAX, min_kimg_align,
+						    EFI_LOADER_CODE);
+
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to relocate kernel\n");
+			*reserve_size = 0;
+			return status;
+		}
+	}
+
+	memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
+	*image_addr = *reserve_addr;
+
+	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6bd3bb86d967..64273371ce96 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1098,5 +1098,13 @@ const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
 
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
+efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
+				       unsigned long *reserve_addr,
+				       unsigned long *reserve_size,
+				       unsigned long kernel_size,
+				       unsigned long kernel_codesize,
+				       unsigned long kernel_memsize,
+				       u32 phys_seed);
+u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
 
 #endif
-- 
2.37.2

