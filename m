Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC13724243
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjFFMf6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMf4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 08:35:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E410C6
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 05:35:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30d181952a2so4072775f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686054949; x=1688646949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SgsE0comFoB1VjaF7YlwvyPoupgsV5f87YT3m751cs=;
        b=WPeP76Atbwy3c8ZI4ym5xlqfx64GgCGx2uCOC4x+ZIhp9+mxZrxLPtn26zhDyZp2uy
         w+1ouaZNflrJIziRIakZWP9xvWrH+OB6aXYRxSJJvu2qZMpuqpaaNNaeMP0QLTAu6ISi
         v5gp7ksuFuv0lQTCIDlxJ1MeEf5XZghk7uS68/1LjL+OyVL7n1PFB+5LIaTgIlBtLPz8
         zCbVlbvNgmSNSbWFVNn1KpwGuLEn1RosG3g2fQLX4X4STVkEFWfjH4KwFeWADKZMGTJ7
         sfCk4voZuMqVRNMo0XpbkdwO7irGCkRCb+lwrZX4NhwL/utViNClvwtL6nligtpTqQLz
         nkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054949; x=1688646949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SgsE0comFoB1VjaF7YlwvyPoupgsV5f87YT3m751cs=;
        b=GuJRCBxzwA58NLTanJoxMuD/W9lQm+2wBdCXFwtrnSBdhK1m1pmTnLe4/2olmjRMbv
         67fQne3JQW34FEVB22DYdgnuaDtaOYkYLn6cnkhgKGHn1X1E6XppbOfKHu4DVg0kg1CZ
         GGwUg0386BZcX5oxOkZXEIlBI85cZOhZYOC1so+6ppL3lQoZFbWryUnqxmpkpZx2d426
         lFdNQDYelRQEsbskwjMPgNaJpebw9XP6um3hEaKXAlQP5XysoNFHWV/3PZDPmzr0EsSq
         cVEm8Rs/XzZYeW5RedmXlXiwVP960dFrFT1A2n4BCJf+0Cfyn5XmKGbxk8RkvLd774ml
         TB4w==
X-Gm-Message-State: AC+VfDzXTScdgIO1cdF3lXVxbjXE5eyirz1OYub32RVc7hr/P7sF6ajC
        kY8W5+oTZ6QsRJbxKlAqEyQwOA==
X-Google-Smtp-Source: ACHHUZ7VWbtl9YzKBspY400amxFwZvbVWJA2yA4oZGbH+/PvLTfYSAMfy76HLLnAsAd+sI1550Ja8w==
X-Received: by 2002:adf:fa92:0:b0:30d:491d:c057 with SMTP id h18-20020adffa92000000b0030d491dc057mr1886129wrr.14.1686054949066;
        Tue, 06 Jun 2023 05:35:49 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030644bdefd8sm12349136wrn.52.2023.06.06.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:35:48 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 3/5] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
Date:   Tue,  6 Jun 2023 14:32:40 +0200
Message-Id: <20230606123242.20804-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
References: <20230606123242.20804-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This prepares for riscv to use the same functions to handle the pĥysical
kernel move when KASLR is enabled.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/efi.h                  |   1 +
 arch/riscv/include/asm/efi.h                  |   1 +
 drivers/firmware/efi/libstub/arm64-stub.c     | 112 +------------
 .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  13 ++
 5 files changed, 174 insertions(+), 104 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index f86b157a5da3..1870af1bc42e 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -111,6 +111,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 	 */
 	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
 }
+#define efi_get_kimg_min_align	efi_get_kimg_min_align
 
 #define EFI_ALLOC_ALIGN		SZ_64K
 #define EFI_ALLOC_LIMIT		((1UL << 48) - 1)
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 29e9a0d84b16..c3dafaab36a2 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -43,6 +43,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 	 */
 	return IS_ENABLED(CONFIG_64BIT) ? SZ_2M : SZ_4M;
 }
+#define efi_get_kimg_min_align	efi_get_kimg_min_align
 
 #define EFI_KIMG_PREFERRED_ADDRESS	efi_get_kimg_min_align()
 
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 770b8ecb7398..de4a64f05c07 100644
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
 
 	if (image->image_base != _text) {
 		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
@@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
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
-	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
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
index 1e0203d74691..a5c61a768d59 100644
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
+	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d5a20802e0..502f53100453 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1132,5 +1132,18 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 
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
+
+#ifndef efi_get_kimg_min_align
+static inline unsigned long efi_get_kimg_min_align(void) {}
+#define efi_get_kimg_min_align efi_get_kimg_min_align
+#endif
 
 #endif
-- 
2.39.2

