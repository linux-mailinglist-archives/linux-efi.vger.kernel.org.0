Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1172424F
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFFMhy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMhx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 08:37:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4A10C6
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 05:37:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so61450925e9.3
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686055070; x=1688647070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM8+qImkZOK2K/lpYo6kR0/Sc4TGqvzUi2et0+LIzuI=;
        b=huVcB5kHcjEqaRoYXfSebsrkybDCAKN/IPvdnOWv5uaTVQzq802YQrF6AFLsksgGYg
         IzbrO8gCTPzYX8XwQ36KpODUDIvXhDJauocWaugR9hybIi6fWQ/DqGozW3tLSckpg2PW
         YOZM9UJvyCLjYJ0XmxHSle9qLY57DNDuMweEZ+ZXakLPefX3YG/88xVzzd2fjv2jeeJ9
         ZAp5V8PV2qB9ln5IqdM4p6Vfg6VuozlCU774/iFfmN6vIULwuCXROWBLlDerHHPK+gW7
         aoEJ/WJw7MseUoHQt2balT88i2W5+0fTAINZSg8G9UvKNoZM3D7b6jysh4ny+5jbRx80
         Zcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055070; x=1688647070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM8+qImkZOK2K/lpYo6kR0/Sc4TGqvzUi2et0+LIzuI=;
        b=KYDa/XwsOlnZlQbAi8jaIvcQfcrM7dzszbr9FHBEwVIVxla+Kb9Ykm9lxGMLQcciok
         qzkLPahKhTR5OjSfv+6jol+2+9KND3LMvYh+YoWE5HPvQIuuYQu7nQyr2CoParJok01R
         m0PI/yU7SqeoSPRw4FG5d07Q+wcRlsNkral6/R+s1H4YnCwucPPlWVDoE4lSexiYCIAo
         BgwBOHlvTLFxBy9Y4036dtNWWW/50EDA9oNkrwXYI3EdIrrA3dJyTZ7mu+YhK+2MuL8O
         YlSsaLDd/9pW+50C0g3jw1bUAN9dDUN7edhzKgdL68MApiGZZoXS1J3BgLt06fp/GfR+
         wbjw==
X-Gm-Message-State: AC+VfDxg6++C93YVHI7vrQ7ILwZKK+l+ehUsS5o0VtaosfthyraVm4g/
        607aApKZwpM/GebnTGWX/aVAuA==
X-Google-Smtp-Source: ACHHUZ7nc3AXEebjJExIy8WcfHRc9oXQzPGd6PNSMcTA5E4oqTueSlDrHWPJ9w4skwm2wu5hvgbUxg==
X-Received: by 2002:a1c:741a:0:b0:3f1:789d:ad32 with SMTP id p26-20020a1c741a000000b003f1789dad32mr2412546wmc.11.1686055070621;
        Tue, 06 Jun 2023 05:37:50 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f7e34c5219sm5876027wmd.42.2023.06.06.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:37:50 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 5/5] riscv: libstub: Implement KASLR by using generic functions
Date:   Tue,  6 Jun 2023 14:32:42 +0200
Message-Id: <20230606123242.20804-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
References: <20230606123242.20804-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/arm64/include/asm/efi.h                  |  3 ++
 arch/riscv/include/asm/efi.h                  |  3 ++
 arch/riscv/kernel/image-vars.h                |  1 +
 drivers/firmware/efi/libstub/arm64.c          |  5 ++++
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
 drivers/firmware/efi/libstub/efistub.h        |  5 ++++
 drivers/firmware/efi/libstub/riscv-stub.c     | 28 +++++++------------
 drivers/firmware/efi/libstub/riscv.c          |  5 ++++
 8 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 1870af1bc42e..796ac51d1f27 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -167,4 +167,7 @@ static inline void efi_capsule_flush_cache_range(void *addr, int size)
 	dcache_clean_inval_poc((unsigned long)addr, (unsigned long)addr + size);
 }
 
+void efi_icache_sync(unsigned long start, unsigned long end);
+#define efi_icache_sync	efi_icache_sync
+
 #endif /* _ASM_EFI_H */
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index c3dafaab36a2..6f99e8812dfd 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -52,4 +52,7 @@ void efi_virtmap_unload(void);
 
 unsigned long stext_offset(void);
 
+void efi_icache_sync(unsigned long start, unsigned long end);
+#define efi_icache_sync	efi_icache_sync
+
 #endif /* _ASM_EFI_H */
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
index 446e35eaf3d9..88c2fd092951 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -138,3 +138,8 @@ void __noreturn efi_enter_kernel(unsigned long entrypoint,
 	enter_kernel = (void *)entrypoint + primary_entry_offset();
 	enter_kernel(fdt_addr, 0, 0, 0);
 }
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	caches_clean_inval_pou(start, end);
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 029d1581db72..812ac2111786 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -864,7 +864,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 
 	memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
 	*image_addr = *reserve_addr;
-	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+	efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
 	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
 
 	return status;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 502f53100453..89c08d3e94b2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1146,4 +1146,9 @@ static inline unsigned long efi_get_kimg_min_align(void) {}
 #define efi_get_kimg_min_align efi_get_kimg_min_align
 #endif
 
+#ifndef efi_icache_sync
+static inline void efi_icache_sync(unsigned long start, unsigned long end) {}
+#define efi_icache_sync efi_icache_sync
+#endif
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
2.39.2

