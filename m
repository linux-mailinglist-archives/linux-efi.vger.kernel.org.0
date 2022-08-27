Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D615A388B
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiH0P7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0P7I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B529CBD
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21CACB80959
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A659C4347C;
        Sat, 27 Aug 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615944;
        bh=siT/ql7gc1x2QdNaLu6Pss33SOZRPfGyw8QLuQoqcv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5huSXpLvs4TbpjScyZPpBiQAaYsy1sut2YJwq72sIUkrkMjRBkv8+1nKX6MTcklQ
         f+zazf5f+sN1m0DY/Kdrjko+z5TK2MBuIGI+12pb4oVmYxB1GRstpO/XitaQK/uNfK
         Uml4lGNuL1PRpDvwczlEprpr3OTT80eNw7SjP+pgG1ksEf6cfn5UQJ8G3TzPh0DT0x
         X5+N247nSRF4c6/x+GLEOCpjqL9Ze1mmS4Ehf4z8jfzs+mPLH5TMKIeMyAaVx9DZpS
         h8qM6foC28+a1NvuQUBCzqmDoi8mzF9Bk18ZYSpQTXaPVoVh+IcobaFpIBXD+Q6eXI
         PckJNfoPn8aVw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 1/7] arm64: lds: reduce effective minimum image alignment to 64k
Date:   Sat, 27 Aug 2022 17:58:46 +0200
Message-Id: <20220827155852.3338551-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5081; i=ardb@kernel.org; h=from:subject; bh=siT/ql7gc1x2QdNaLu6Pss33SOZRPfGyw8QLuQoqcv4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj8wJkgAhKnWWn6Od9QZrhbzX/chuxukNvLC+4o6 9If29VWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/MAAKCRDDTyI5ktmPJPi0C/ 9CqbgCFVBCZsomLQOe7YC+pYbRO7rjWFqdAMjrRSb95dqSvAPVK1WqPJwCcyfmpUntiXAZv/T7XTME DvvOTF1QrqeYmEGdfGS/Ze7Vd20j025WFvBT0Y04DaaM6Y5TWqDwyMf6Ww7Gm2i/wlRG/7H1+QYkDT RtHC2sa/XKrv1qIp0ua7NtiYv+I1rqq+r6+Z9jmfxgBVjikthi+FxhUOvGhwxfRqPj2ec9ypau97hI 9PtUvqCGyk+yKv8kEwMEa7cJPNGvhlYIs9oum6X3xaUNPdQd4fGEZ44OzY5GrbWY1HltRTBf9CW+i6 RBDGup+Qg+HS1NGLEwvQNZoy0EsxGaqcHs9KEgtdpohS9KvxA9VRxEAFt0kCRhLReRz2ZxWnSoaTZp EPfeOA+la/yWscShFZyY0naVe9NUNgul8+UiqrMY79WGjv78tN8n0ORypXWVeeqANoS8538e0ducgY Ml1kbSqSHH9Ibcb4FTp9vb5ZRomZ5Bw+J533rQ3abygWE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/include/asm/efi.h              |  7 -------
 arch/arm64/kernel/head.S                  |  3 +++
 arch/arm64/kernel/vmlinux.lds.S           | 11 ++++++++++-
 drivers/firmware/efi/libstub/arm64-stub.c |  2 +-
 include/linux/efi.h                       |  6 +-----
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 439e2bc5d5d8..3177e76de708 100644
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
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cefe6a73ee54..bd7c04f1f993 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -396,6 +396,9 @@ SYM_FUNC_END(create_kernel_mapping)
 	msr	sp_el0, \tsk
 
 	ldr	\tmp1, [\tsk, #TSK_STACK]
+#if THREAD_ALIGN > SEGMENT_ALIGN
+	bic	\tmp1, \tmp1, #THREAD_ALIGN - 1
+#endif
 	add	sp, \tmp1, #THREAD_SIZE
 	sub	sp, sp, #PT_REGS_SIZE
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 45131e354e27..0efccdf52be2 100644
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
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 577173ee1f83..ad7392e6c200 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -98,7 +98,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * 2M alignment if KASLR was explicitly disabled, even if it was not
 	 * going to be activated to begin with.
 	 */
-	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : SEGMENT_ALIGN;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39..d7c87666baf9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -416,11 +416,7 @@ void efi_native_runtime_setup(void);
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

