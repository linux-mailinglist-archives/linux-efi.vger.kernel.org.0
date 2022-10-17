Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F2601499
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJQRSO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQRSO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52671989
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E2E611E7
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C23C4347C;
        Mon, 17 Oct 2022 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027091;
        bh=+H157anxM+2dX1+H3yTb4uNIwJjI/6G+gPOrkXznwzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQiPdyEwZUdNhUc6R8L8XBz1qUT7AION3quF1TyMWmpsNqfHAdXnB6N9ZlpZvrrjU
         ahS47UZ2hhM9k1H3atDyPAYzZ+xr7uoXRDudps9YGv+IdfEMG5LBP5bKA3XzwkGln1
         Ao9cQuLLXneHmCwgMf4gTL4pWzm2RB+fmhIUH8k0ar4GuU7lAuZS6ksW9vTsga1hHO
         NlVPrCqyYrMF5th4XkghSGUEQsLzYOg5RRS2Y3o9/0mQlMs+E/8Fo1slZkldI0ULo/
         xs2JZvwbr4LCeV2YK7Fdo2U8BpqiUppu7idefG/ufhS3gToKg4CDCL4rDgv8XMtpaM
         eEqG19uZVA9TA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 16/21] efi: libstub: Factor out min alignment and preferred kernel load address
Date:   Mon, 17 Oct 2022 19:16:55 +0200
Message-Id: <20221017171700.3736890-17-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5774; i=ardb@kernel.org; h=from:subject; bh=+H157anxM+2dX1+H3yTb4uNIwJjI/6G+gPOrkXznwzI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4D7rgYdfP6lOh+IB2haaTnryrtxuLKqO7UDJNJ qBm2mmCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OAwAKCRDDTyI5ktmPJOQ7C/ 9+Qqym373prC9KJZvyv1lzYk3TwacrpLaPJ2eCTREfWMe3hVWz3amR8IAgKAItsqkZnETjzT/FHRxg sIbe2fC8D5FGhGm18obLwD6/ySF8VI1Wtx8y12oj5oWizuuiot2fVfpy5e0ozGVccCWTrxm64vqx5O V8EWGOq8HQy6DHt6hhaEi5DLtbQXfcPnrIetdUKx0to9KKEWhKMioD4SSqJSDnirKdOqAKF73tu1cI WH6kyfR4840+HtVPgkiBGhf2Ae50TtcwqxJGMl7+CwAYjeQOzJdsayXhxB57vGGChwkS8OvW4GsovJ L/bCve/RwdKoCKnaR4RlNLTyubLUaXJGwXC7UOZdW2w7e9X2Eq3fLpOey2r7eJbBdhK9KR+JLbQiew hVo1pKnFNJgitYuWIVhI6qSfOXxsT8u7EetAp6e+qA+QUcBczfgyVJahL6xSzGemfoSBpEvwmt12aO 4F2831KJHB2gRYSWFVAJi2oZ2KlBpbqL99HVc2ewjP9ak=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the expressions that describe the preferred placement of the
loaded image as well as the minimum alignment so we can reuse them in
the decompressor.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h                  | 15 +++++++++++++++
 arch/loongarch/include/asm/efi.h              |  7 +++++++
 arch/riscv/include/asm/efi.h                  | 11 +++++++++++
 drivers/firmware/efi/libstub/arm64-stub.c     | 11 +----------
 drivers/firmware/efi/libstub/loongarch-stub.c |  3 ++-
 drivers/firmware/efi/libstub/riscv-stub.c     | 15 +++------------
 6 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index af35ad671754..108b115dbf5b 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -76,6 +76,21 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
+static inline unsigned long efi_get_kimg_min_align(void)
+{
+	extern bool efi_nokaslr;
+
+	/*
+	 * Although relocatable kernels can fix up the misalignment with
+	 * respect to MIN_KIMG_ALIGN, the resulting virtual text addresses are
+	 * subtly out of sync with those recorded in the vmlinux when kaslr is
+	 * disabled but the image required relocation anyway. Therefore retain
+	 * 2M alignment if KASLR was explicitly disabled, even if it was not
+	 * going to be activated to begin with.
+	 */
+	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+}
+
 #define EFI_ALLOC_ALIGN		SZ_64K
 
 /*
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 60d6a170c18d..5a470c8d2bbc 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -24,4 +24,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 	return ULONG_MAX;
 }
 
+static inline unsigned long efi_get_kimg_min_align(void)
+{
+	return SZ_2M;
+}
+
+#define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
+
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index d0570936cb8c..a742868eb23c 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -31,6 +31,17 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 	return ULONG_MAX;
 }
 
+static inline unsigned long efi_get_kimg_min_align(void)
+{
+	/*
+	 * RISC-V requires the kernel image to placed 2 MB aligned base for 64
+	 * bit and 4MB for 32 bit.
+	 */
+	return IS_ENABLED(CONFIG_64BIT) ? SZ_2M : SZ_4M;
+}
+
+#define EFI_KIMG_PREFERRED_ADDRESS	efi_get_kimg_min_align()
+
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index e767a5ac8c3d..dd21b7b7309a 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -88,16 +88,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	efi_status_t status;
 	unsigned long kernel_size, kernel_memsize = 0;
 	u32 phys_seed = 0;
-
-	/*
-	 * Although relocatable kernels can fix up the misalignment with
-	 * respect to MIN_KIMG_ALIGN, the resulting virtual text addresses are
-	 * subtly out of sync with those recorded in the vmlinux when kaslr is
-	 * disabled but the image required relocation anyway. Therefore retain
-	 * 2M alignment if KASLR was explicitly disabled, even if it was not
-	 * going to be activated to begin with.
-	 */
-	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+	u64 min_kimg_align = efi_get_kimg_min_align();
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index 32329f2a92f9..a2e55e5c4003 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -35,7 +35,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
 
 	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
-				     PHYSADDR(VMLINUX_LOAD_ADDRESS), SZ_2M, 0x0);
+				     EFI_KIMG_PREFERRED_ADDRESS,
+				     efi_get_kimg_min_align(), 0x0);
 
 	*image_addr = kernel_addr;
 	*image_size = kernel_asize;
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index b450ebf95977..c5a551f69a7f 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -12,16 +12,6 @@
 
 #include "efistub.h"
 
-/*
- * RISC-V requires the kernel image to placed 2 MB aligned base for 64 bit and
- * 4MB for 32 bit.
- */
-#ifdef CONFIG_64BIT
-#define MIN_KIMG_ALIGN		SZ_2M
-#else
-#define MIN_KIMG_ALIGN		SZ_4M
-#endif
-
 typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
 
 static unsigned long hartid;
@@ -125,9 +115,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * lowest possible memory region as long as the address and size meets
 	 * the alignment constraints.
 	 */
-	preferred_addr = MIN_KIMG_ALIGN;
+	preferred_addr = EFI_KIMG_PREFERRED_ADDRESS;
 	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
-				     preferred_addr, MIN_KIMG_ALIGN, 0x0);
+				     preferred_addr, efi_get_kimg_min_align(),
+				     0x0);
 
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
-- 
2.35.1

