Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57F697ECC
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBOOyW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 09:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBOOyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 09:54:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9F2884E
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:54:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso1755460wmb.4
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4BvO75ZXrS10LcJgsz5zZo07cuKH8B95qcklsNq3N4=;
        b=eJwhJ0KloQW4mUrbp/N3CD+WQpxcec1WXR77m6jHwd2ZBGUgvgl59M61JDT9YepATU
         GcEXqyFBrXjKS40imQJoOKr008H1gWwgRIDNGNNLxMJr6Be/ZBn8lMJjqGXSL5vBz1oc
         4UxXpwDr5Aw3SHaLbU2+tEqHHkpSpIXrlyccNsgfJZj6JTRIgFX+oUH73RUl8pk754gt
         HUIm85UIWorCz5T435tLoiMQWdCWQJSK0vJtREOnuBnhF7B6plkQT56+vEtDlDoBWZaw
         zszx7g1tyrR10lOVOMhlWI8NNdUcTzF54Si7ByUYk+Ff+n5JtKXZ+nQ4q0DouiKsN1dB
         ju2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4BvO75ZXrS10LcJgsz5zZo07cuKH8B95qcklsNq3N4=;
        b=vgisVaVn5G8elehajj+1ezF4iLyt2UoCe2u8xrpkrUVoni/KXe+ypQYIzLk9dxwUoJ
         6H37gRkJAL7L5tDDjStzFmgeHGp+aYYDNpENQ5bIL0+nB5PCvjy/0b/pFIoIhG5SuXmy
         YCm62DNzEeNjiOhqw+Yo6lzYO7D1CY3IdO5xtdQ7BlCCE75b6V2s6MttHVUo3I8VdqbQ
         4C1A4HMkwMWPWRWBVlQcTeaXJM6DJGmWHe2xqDcgOucGDX6OhVEC2gc59ujuxkxIrLCE
         kdC3zNlJDSi0ezP9ccvmd5KTpY54orIJCV96GEfVAm6s2TgThqpjJam7f4D2cCgpXHwS
         0v5w==
X-Gm-Message-State: AO0yUKVsCwBvisK2xNc86rL7UNgskxt29Ayt27LbrRhh8URVsdh/RF/t
        RsDM1ExCaWa8Lws75MphlM9NaA==
X-Google-Smtp-Source: AK7set+z1EuF/qTEsW13BueUE8joVeOlGJPKhW0X4Yacc2kbVno1G0GuXcjMOyleMwbiyg2+WUkCcg==
X-Received: by 2002:a05:600c:5128:b0:3de:e8c5:d833 with SMTP id o40-20020a05600c512800b003dee8c5d833mr2690072wms.22.1676472858522;
        Wed, 15 Feb 2023 06:54:18 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id i29-20020a1c541d000000b003dc4fd6e624sm2358568wmb.19.2023.02.15.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:54:18 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/4] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
Date:   Wed, 15 Feb 2023 15:51:12 +0100
Message-Id: <20230215145113.465558-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215145113.465558-1-alexghiti@rivosinc.com>
References: <20230215145113.465558-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/firmware/efi/libstub/arm64-stub.c     | 110 +------------
 .../firmware/efi/libstub/efi-stub-helper.c    | 147 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 3 files changed, 162 insertions(+), 103 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7327b98d8e3f..86ea9bfa6513 100644
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
 	unsigned long kernel_size, kernel_memsize = 0;
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
@@ -95,50 +34,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	kernel_size = _edata - _text;
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
-			goto clean_image_to_poc;
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
+	status = efi_kaslr_relocate_kernel(image_addr,
+				 reserve_addr, reserve_size,
+				 kernel_size, kernel_memsize,
+				 efi_kaslr_get_phys_seed(image_handle));
+	if (status != EFI_SUCCESS)
+		return status;
 
-clean_image_to_poc:
 	/*
 	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
 	 * stale icache entries from before relocation.
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f5a4bdacac64..ebf72beee4f5 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -651,3 +651,150 @@ efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
 
 	return status;
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
+		if (status == EFI_SUCCESS)
+			return phys_seed;
+		else if (status == EFI_NOT_FOUND) {
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
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 unsigned long kernel_size,
+				 unsigned long kernel_memsize,
+				 u32 phys_seed)
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
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5b8f2c411ed8..747f33763df0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1076,4 +1076,12 @@ struct efi_smbios_type1_record {
 
 const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
 
+efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
+				       unsigned long *reserve_addr,
+				       unsigned long *reserve_size,
+				       unsigned long kernel_size,
+				       unsigned long kernel_memsize,
+				       u32 phys_seed);
+u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
+
 #endif
-- 
2.37.2

