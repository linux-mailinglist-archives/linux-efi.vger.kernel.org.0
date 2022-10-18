Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747B86029CF
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJRLFF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJRLFA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAF24940
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9324561512
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED4C43470;
        Tue, 18 Oct 2022 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091093;
        bh=fOnIdv0Xyy55Ww2CKD9LOztyluMCPv+3nJyI3YpsVF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdFogkM/YvR0ICZqmNuKMnJRUxIg05fqAyNB8X53twaIVCGy0rpvrArb+RjqxP0qQ
         yWosl6raCPKzhdJYhFxPxn8upliX5U7PdmU4Hew+GXC9HkMziehh8/joi4MRjKyYyp
         0rNAW3WUH9pGE/x8KwfI4B3yO9pUOW6msC921tl99n54CVnjD3SIVZrS7rytWeFfSf
         PBcwCFosvZ6XatU1M3EBVQcPHlyqKXDOxaraurQde+BnZLUw5CPaXNTWktS5qXEh7Q
         saPYDWvCN3NUpZ1AFSmBDxgE89e8ITDr9kbtcbcNdC8rL2PYWcb8VO7KJv7jA/3kW7
         IC/XATeC4e+5w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/6] arm64: lds: reduce effective minimum image alignment to 64k
Date:   Tue, 18 Oct 2022 13:04:36 +0200
Message-Id: <20221018110441.3855148-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5081; i=ardb@kernel.org; h=from:subject; bh=fOnIdv0Xyy55Ww2CKD9LOztyluMCPv+3nJyI3YpsVF0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohAHq6+KfeoPUmam6DRiCZqZah9LWBjKGkmSMCj lX/kwg2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IQAAKCRDDTyI5ktmPJDZ9DA C/xJIV+LWKu7IwFMZnGt8Sb7I5n0+z0K/H30/w9+y9UNKq/u1NK41hFtPAUwW9LX8Ol3vTpKNVsZyn s/Rz/zbNWjA3awb81VPt9fr3J0FSI9lG1yQd8RzEUoU514h1Wh9jwPyM45rDbDo0ZhU2YbPDNFvvGK 68xPQoUT6ez1Q4L7Rf8tyYPUc9PlMJy7Eh2JwPOP+j8Garmmv78wx7EORedFadIGfaSySh6zIRDLpV uGrECP75CJojvdDU5sVl04CVF/h5kkLP9ZCd1fD8WwrhxdORWLW6RH54H9qzJ6Lds64FDWZo5PRn1I E/fpZB89cyAuPZe8Z6EGN5QdiM1g5X5zqqbpKdJMCdc362MuiJ/lq8knJLMzpNScQeR49HO6/K4rTH BG9gwuNAzwXUAqsy7m5DAfBv6Xg0x2jRSR6GUrjAI2tvV93aOXnMN0tnXVO8Tt93EhQlc73VYqN7Il vzsxEJh6oKy+XoeLoiVnMUG6hot29+cOyNcyv6BzQNFFA=
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
index 2196aad7b55b..f168e3309704 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -398,6 +398,9 @@ SYM_FUNC_END(create_kernel_mapping)
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
index e767a5ac8c3d..6229f42c797f 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -97,7 +97,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * 2M alignment if KASLR was explicitly disabled, even if it was not
 	 * going to be activated to begin with.
 	 */
-	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : SEGMENT_ALIGN;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 256e70e42114..1a395c24fdc0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -422,11 +422,7 @@ void efi_native_runtime_setup(void);
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

