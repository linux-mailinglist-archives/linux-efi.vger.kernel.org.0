Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA8621BCE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiKHSWl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiKHSWj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB82CB
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6440B81BF6
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D0C4347C;
        Tue,  8 Nov 2022 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931756;
        bh=MWD3jiDqDGuRLBaHt/HdBEQzHS/nhfIQWq2XlQqRkt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQlbi3wPZJ9XLvE+EpwIE093Ab3zgJ91e1DqN/pHRZuLPYkV47sFa10y1NDg1cz/W
         zPsLqa3CH/LOPlcMp04cqjSF7hdz9rt9OlNEMtEXUcyggZHSWz1v4PYQsA6P6dDlPw
         TQzoX1xzmifCRUZWBww+OYpJ8xabFawFEjMPtPKTWw2Kw+YQVJ8OB/um+Znhh6fcBc
         jrjosSBbXV+GV/xxsHhPcC2yzwAx0BKUs1SOEYKd2geUtU+YGG3+oF1TGYTBq+Ao62
         OXnoaYt2nyz8uMExRKJ7VLTjBdnceoHZuPIiypvKuMce6SDC7MN3u5Sl3Btm6JxxVr
         PMfO9LcJyT3Wg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 6/7] arm64: lds: reduce effective minimum image alignment to 64k
Date:   Tue,  8 Nov 2022 19:22:03 +0100
Message-Id: <20221108182204.2447664-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4680; i=ardb@kernel.org; h=from:subject; bh=MWD3jiDqDGuRLBaHt/HdBEQzHS/nhfIQWq2XlQqRkt4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5JWXXKYnowwNzvCLta3MG3V6apoNBwitfw05zf YrDWe/uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeSQAKCRDDTyI5ktmPJKW2C/ 9S2oyok3Zym96V/+5yk6p0C5BDDM81GC8BWGowTtjp7eBqM4SULE9aAfguRffDVaH+CCfL6g5KhK5y wXgjRaIPuMEewbX6s66L5CCx1I4ZyM7X48jbC+192fX7dEQbObgH5sIuo1WqAVVk0As7QVW6EoK/ZC FTVm/izx+qiMlauOBKBlhkstMogDxH3ccoF10Z3hACAW/cAgTR0BjkhCvhMqkfOrcpmsWPc2ThTOld xkqhPTUbSzbHAmRyfPAoYCCiZ/10RPAm7XePuzfYqdLH2NY0ltxlqZSgvnOa4g8XZ6Ic0uLqu2VcTd /rX+7w6uFORNFNi2LE//O/w8C3OKhk/Zc6BPpyLng7XAvX6K/5SkzhsltOw6cqizqOpWLHY49FCjUV vDLW+B6W9EUC/mwO3hl9eMJ1VS4LtOtcX96I4OySOu7YhK+BFmDZZ7jO4bPyu8FsWtxnOqLphM8vV/ ml+TyY/JrJdJVxYCqFBxp7luHStPjtSTk+7RPdkXjpaBo=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Our segment alignment is 64k for all configurations, and coincidentally,
this is the largest alignment supported by the PE/COFF executable
format used by EFI. This means that generally, there is no need to move
the image around in memory after it has been loaded by the firmware,
which can be advantageous as it also permits us to rely on the memory
attributes set by the firmware (R-X for [_text, __inittext_end] and RW-
for [__initdata_begin, _end].

However, the minimum alignment of the image is actually 128k on 64k
pages configurations with CONFIG_VMAP_STACK=y, due to the existence of a
single 128k aligned object in the image, which is the stack of the init
task.

Let's work around this by adding some padding before the init stack
allocation, so we can round down the stack pointer to a suitably aligned
value if the image is not aligned to 128k in memory.

Note that this does not affect the boot protocol, which still requires 2
MiB alignment for bare metal boot, but is only part of the internal
contract between the EFI stub and the kernel proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h    |  9 +--------
 arch/arm64/kernel/head.S        |  3 +++
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 include/linux/efi.h             |  6 +-----
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 108b115dbf5b7436..7ed7a0e621a5b0b6 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -54,13 +54,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
 /* arch specific definitions used by the stub code */
 
-/*
- * In some configurations (e.g. VMAP_STACK && 64K pages), stacks built into the
- * kernel need greater alignment than we require the segments to be padded to.
- */
-#define EFI_KIMG_ALIGN	\
-	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
-
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
  * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
@@ -88,7 +81,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 	 * 2M alignment if KASLR was explicitly disabled, even if it was not
 	 * going to be activated to begin with.
 	 */
-	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+	return efi_nokaslr ? MIN_KIMG_ALIGN : SEGMENT_ALIGN;
 }
 
 #define EFI_ALLOC_ALIGN		SZ_64K
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 825f1d0549661030..8d7c6155da59e215 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -429,6 +429,9 @@ SYM_FUNC_END(create_kernel_mapping)
 	msr	sp_el0, \tsk
 
 	ldr	\tmp1, [\tsk, #TSK_STACK]
+#if THREAD_ALIGN > SEGMENT_ALIGN
+	bic	\tmp1, \tmp1, #THREAD_ALIGN - 1
+#endif
 	add	sp, \tmp1, #THREAD_SIZE
 	sub	sp, sp, #PT_REGS_SIZE
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index c7727a1740ce11f5..5002d869fa7f1767 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -274,7 +274,16 @@ SECTIONS
 
 	_data = .;
 	_sdata = .;
-	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
+#if THREAD_ALIGN > SEGMENT_ALIGN
+	/*
+	 * Add some padding for the init stack so we can fix up any potential
+	 * misalignment at runtime. In practice, this can only occur on 64k
+	 * pages configurations with CONFIG_VMAP_STACK=y.
+	 */
+	. += THREAD_ALIGN - SEGMENT_ALIGN;
+	ASSERT(. == init_stack, "init_stack not at start of RW_DATA as expected")
+#endif
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, SEGMENT_ALIGN)
 
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 16b7318957b0709f..19eda0bb4617a4cf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -421,11 +421,7 @@ void efi_native_runtime_setup(void);
 /*
  * This GUID may be installed onto the kernel image's handle as a NULL protocol
  * to signal to the stub that the placement of the image should be respected,
- * and moving the image in physical memory is undesirable. To ensure
- * compatibility with 64k pages kernels with virtually mapped stacks, and to
- * avoid defeating physical randomization, this protocol should only be
- * installed if the image was placed at a randomized 128k aligned address in
- * memory.
+ * and moving the image in physical memory is undesirable.
  */
 #define LINUX_EFI_LOADED_IMAGE_FIXED_GUID	EFI_GUID(0xf5a37b6d, 0x3344, 0x42a5,  0xb6, 0xbb, 0x97, 0x86, 0x48, 0xc1, 0x89, 0x0a)
 
-- 
2.35.1

