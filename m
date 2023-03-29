Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F56CD1A8
	for <lists+linux-efi@lfdr.de>; Wed, 29 Mar 2023 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC2FeT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Mar 2023 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2FeR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Mar 2023 01:34:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6CF197
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:33:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so8802596wms.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680068016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9AZET+Y+Ubd7JaCED2QPLhADiInjk5s5J91QKVSZ4k=;
        b=3zKhJk4p5gD71igAWtDX+1AQYoKoKXyB010oklo5qec7Q7rzwb7Z/8rmApcXytNFkB
         qwJfaC/1+iSlSoI/1ZIlyNDiFqwLfGihQprXFafbkJ4pmIafAxVK3ClKuEhqHprDkwiX
         kMcblA0WbF/w2EneXqc1ebhBfXp1cfr1vEo86a94VoR3OH9i7zgOoJQtWeFYZcpbu2Gw
         ZDcVXp8S1KoCXaKy4A9R5DUYLIbQMbM6O/k3fa2sxPP7di6FcRgUNz9rNAP0TUEEYEz4
         z0HSE77/jBFKtGbxF1gDvuvWXSKEUJkCwlv9BcWTHxM8NPBntW4/xF5l7xv+kamnA6TW
         +xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9AZET+Y+Ubd7JaCED2QPLhADiInjk5s5J91QKVSZ4k=;
        b=SdF4xBSoVEM9da7s/HLuu23gTVtgddjbVftS/112hLiThzQ+XlSPR1VrkowLrqUpLC
         zOcXjY7/Ev/hxWJ1DHQR34d9B4yrDRA1eBm+6JUzQQ+vbRJ5z6OnxjT76EOfll68LF5J
         StEuzpDGzh5lselNH25uHxq/Gp9ky+7QI/brz8DmRHq4y4wHHSb0TJVBqn9ZTVkLmPKJ
         OtCTGDnOacP92kR9PKs5D/VRXB2UJzHXWwbVOO03maZAYgzYfZxbxSucro2j0ZsIQw60
         A00+qiKHPR8vh9qIHEziYuDWRO+ArCs3hYKaVBhuUYW6KJnxq8++tI1nvzhbCXXB5lsD
         RDqw==
X-Gm-Message-State: AO0yUKVpUOvz9tzXCq9lruvrskqo6E2JI1MqjI0MO7PhACocZ9DMcBmM
        EafC4gCedD/ogtVawJc6xhKbdg==
X-Google-Smtp-Source: AK7set9LKzHC4m9zJD6QlkzNGWUSHa5ooY+SVzmZs/Ul21Y/QbX7qIXjNm1AraEG6VzRdd1yv2suPw==
X-Received: by 2002:a1c:4b06:0:b0:3ed:316d:668d with SMTP id y6-20020a1c4b06000000b003ed316d668dmr14254078wma.5.1680068015741;
        Tue, 28 Mar 2023 22:33:35 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003ef5bb63f13sm915242wms.10.2023.03.28.22.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:33:35 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/4] riscv: libstub: Implement KASLR by using generic functions
Date:   Wed, 29 Mar 2023 07:29:26 +0200
Message-Id: <20230329052926.69632-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329052926.69632-1-alexghiti@rivosinc.com>
References: <20230329052926.69632-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We can now use arm64 functions to handle the move of the kernel physical
mapping: if KASLR is enabled, we will try to get a random seed from the
firmware, if not possible, the kernel will be moved to a location that
suits its alignment constraints.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/image-vars.h                |  1 +
 drivers/firmware/efi/libstub/arm64.c          |  5 ++++
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
 drivers/firmware/efi/libstub/efistub.h        |  2 ++
 drivers/firmware/efi/libstub/riscv-stub.c     | 28 +++++++------------
 drivers/firmware/efi/libstub/riscv.c          |  5 ++++
 6 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 15616155008c..ea1a10355ce9 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -27,6 +27,7 @@ __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
 __efistub__edata		= _edata;
+__efistub___init_text_end	= __init_text_end;
 __efistub_screen_info		= screen_info;
 
 #endif
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index 399770266372..48bc7428d6df 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -108,3 +108,8 @@ void __noreturn efi_enter_kernel(unsigned long entrypoint,
 	enter_kernel = (void *)entrypoint + primary_entry_offset();
 	enter_kernel(fdt_addr, 0, 0, 0);
 }
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	caches_clean_inval_pou(start, end);
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 40ac2625949c..63c7275d42e7 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -865,7 +865,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 	memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
 	*image_addr = *reserve_addr;
 
-	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+	efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
 
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 64273371ce96..9ce114e04b23 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1107,4 +1107,6 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 				       u32 phys_seed);
 u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
 
+void efi_icache_sync(unsigned long start, unsigned long end);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 145c9f0ba217..7af07b33a993 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -30,32 +30,24 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
-	unsigned long kernel_size = 0;
-	unsigned long preferred_addr;
+	unsigned long kernel_size, kernel_codesize, kernel_memsize;
 	efi_status_t status;
 
 	kernel_size = _edata - _start;
+	kernel_codesize = __init_text_end - _start;
+	kernel_memsize = kernel_size + (_end - _edata);
 	*image_addr = (unsigned long)_start;
-	*image_size = kernel_size + (_end - _edata);
-
-	/*
-	 * RISC-V kernel maps PAGE_OFFSET virtual address to the same physical
-	 * address where kernel is booted. That's why kernel should boot from
-	 * as low as possible to avoid wastage of memory. Currently, dram_base
-	 * is occupied by the firmware. So the preferred address for kernel to
-	 * boot is next aligned address. If preferred address is not available,
-	 * relocate_kernel will fall back to efi_low_alloc_above to allocate
-	 * lowest possible memory region as long as the address and size meets
-	 * the alignment constraints.
-	 */
-	preferred_addr = EFI_KIMG_PREFERRED_ADDRESS;
-	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
-				     preferred_addr, efi_get_kimg_min_align(),
-				     0x0);
+	*image_size = kernel_memsize;
+	*reserve_size = *image_size;
 
+	status = efi_kaslr_relocate_kernel(image_addr,
+					   reserve_addr, reserve_size,
+					   kernel_size, kernel_codesize, kernel_memsize,
+					   efi_kaslr_get_phys_seed(image_handle));
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
 		*image_size = 0;
 	}
+
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/riscv.c b/drivers/firmware/efi/libstub/riscv.c
index 8022b104c3e6..365f891e598f 100644
--- a/drivers/firmware/efi/libstub/riscv.c
+++ b/drivers/firmware/efi/libstub/riscv.c
@@ -96,3 +96,8 @@ void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
 	csr_write(CSR_SATP, 0);
 	jump_kernel(hartid, fdt);
 }
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
-- 
2.37.2

