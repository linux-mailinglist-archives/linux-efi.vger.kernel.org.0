Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D375C079
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGUHyL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGUHyJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 03:54:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B430C0
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:53:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so13188455e9.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689926037; x=1690530837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTCLx/Z9PJYFq6Pk7xMLXjel9CDG1RIukbxZ6yTca28=;
        b=J/iWEZAAnGscNPHr9bcJKT6sQV3lA1cAElt66GYks+N721W2ngt1KUuDO/4JJOAol4
         hAsDPLzv+vfyE3Ii2Ed3lamxdG4pGqWBx5FEhGtvqefQ0fW0dxKEBDnuALpuQylRaT8i
         O9eIWEVC2kqcw53z/RL5ILtx1Gr35jSnwwPClrLWiKLHtAwEzGmi2ryH8IDkR8JiYns9
         8ao6NY1I+YhsFAe4ovw0uj4RnzVkaK6q99UjCCvsyfeVwXYryOKvCej8hN1xMVF/3laF
         bv/I3sh2MdvGY9jkTcVlvHm580DtNZjZe7HLLMQayAej8h0LH/8Yxq6RLN676OsIwEej
         clAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926037; x=1690530837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTCLx/Z9PJYFq6Pk7xMLXjel9CDG1RIukbxZ6yTca28=;
        b=jCD7T1bG2R2Z6DV8EoLENCfjZg8anDG6+FTUKMPuHT0stDADM+znKXG7xy+QD/RaSC
         wCA5srnjtaGmB3TnrZbroRE13mIfyo1pEii4AgPQhWiQncaiQq74MqOTkPkhJvLoV4fi
         /LU3iS1JC4wF6LTnYvHFvKatfJ9QouSSrHwHNw496vYSuR8p49tBBo8fFmtn79TQhP51
         ZRhnOHgWsTnzRE9PtJWPbMsE9A4l8ugJckdDdy2j18bwBRubWezfV5PC1GIq6Id4kREN
         dMMVhQfNm/p1UhEanQ7jiRPB4mwK5h7NY74yqfNXcpLqztEBoQKFCOp1VQ9ZcVpTMNFC
         smTw==
X-Gm-Message-State: ABy/qLZpQDYT6pyvqR936DhfFG7RG5moZHCe3KhJbIrSw8wLixMiXiJK
        +S4FDS3R8DXqsTVSuMUQIKhPBg==
X-Google-Smtp-Source: APBJJlFLnJTaXTTskNiyakPpL3YLbA+OfGjHB9N3lPuS4SI171RVD04EGAih2bgloP1Jhme0UbwDJA==
X-Received: by 2002:a1c:ed0f:0:b0:3fb:a506:5656 with SMTP id l15-20020a1ced0f000000b003fba5065656mr740023wmh.32.1689926036800;
        Fri, 21 Jul 2023 00:53:56 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003fc06169abdsm2892519wmk.2.2023.07.21.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:53:56 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 5/5] riscv: libstub: Implement KASLR by using generic functions
Date:   Fri, 21 Jul 2023 09:48:50 +0200
Message-Id: <20230721074850.310644-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721074850.310644-1-alexghiti@rivosinc.com>
References: <20230721074850.310644-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 arch/riscv/include/asm/efi.h              |  2 ++
 arch/riscv/kernel/image-vars.h            |  1 +
 drivers/firmware/efi/libstub/riscv-stub.c | 33 +++++++++++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 29e9a0d84b16..00b24ba55035 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -51,4 +51,6 @@ void efi_virtmap_unload(void);
 
 unsigned long stext_offset(void);
 
+void efi_icache_sync(unsigned long start, unsigned long end);
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
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 145c9f0ba217..c96d6dcee86c 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -30,32 +30,29 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
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
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
-- 
2.39.2

