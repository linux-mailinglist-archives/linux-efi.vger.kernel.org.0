Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46675601488
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJQRRc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJQRRb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD76E895
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52175B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FAEC433C1;
        Mon, 17 Oct 2022 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027048;
        bh=yeOhjjQ1LMVagWR+5PnZWjIVmQDU3ZdDYIHuTyFJOZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNNUSHuNgfDH0Eqkyu9AxRiJGNnMYDJaXJ368F0AVXQL24QW59F2gFedhHlA0rsRz
         cGa9AhxDKDGMOP3M/QJD0Sd03PtKEGBl20UsoysE7YzJf5hgEa5aJFTeMrQHZkmhTB
         /5BlH+h8ny4i1VKcddfAVnhP2SH4i4cpz0CSA117JUB+p0jdSANSHYECOgHvjf+wX4
         szFFIguPMbgj3oeLIVwLvZb8qafyD+AmP2ghd4jfKQPudguD7t+7+7raEKqQ84lcXb
         WOxOcgykBqXIJYW5iLky7C7I4cHNCE6m3Wvn4dB3GbcnfhLp/zTxv8Paq8ai2xw2kq
         wXTknYIY2q3XA==
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
Subject: [PATCH 03/21] arm64: efi: Move efi-entry.S into the libstub source directory
Date:   Mon, 17 Oct 2022 19:16:42 +0200
Message-Id: <20221017171700.3736890-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=ardb@kernel.org; h=from:subject; bh=yeOhjjQ1LMVagWR+5PnZWjIVmQDU3ZdDYIHuTyFJOZs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3tELVe+GWCgjpjgNGnqkdigsuCo8DA951wOuuz 9yLzo+WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N7QAKCRDDTyI5ktmPJH93DA C8Wal0LUK7J0jW7ctFbdOAIwAVppH6QK20iBxAkAHsZriqCRgXs1H5bSRrYnETtpSOBcWZwcXdafuR jxuN31k7WHtHst87lHV1nv2ZnzFnYs7/25zBIPUokOTIx2znEtjHm8jPJ5DnW/JbuEuchah2fJvf1e /MM4rTI/+cfjnrqTUtmz5tujo9RusXO8kTXUzbvb+gf1VXrASrilnmSANQcPCaX02bZ4Enwph/LMxU Ul+6IU3wOQFP/bQargnxhE7lILliJLwk8LOTBmk5rTqFTE/tpANRWh1dswkP2G/pwJPsF9oAuESmWs 4BhVnoFcYOmM9QpxIt8vTFemS3sfGpIfIkt/4t/EeIrBQkak3h92wZl3BoxL5RvteJ0ygHPw9GG5ct BmQq7gnmqahB6XU1ihI3rYwj7YvYXYYYSbTUoQmEcyxGQMVqBiYv0Fmjg6vMQ9AlsQN9tTZD9BSiot rOXDmUb1gT9zIICbyF4V+eOjxb/3jpKyfsZWBnsKH967w=
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

We will be sharing efi-entry.S with the zboot decompressor build, which
does not link against vmlinux directly. So move it into the libstub
source directory so we can include in the libstub static library.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/Makefile                                                  | 9 +--------
 drivers/firmware/efi/libstub/Makefile                                       | 4 ++--
 arch/arm64/kernel/efi-entry.S => drivers/firmware/efi/libstub/arm64-entry.S | 4 ----
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2f361a883d8c..2a3b0e4950f2 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,12 +36,6 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
 			   patching.o
 
-targets			+= efi-entry.o
-
-OBJCOPYFLAGS := --prefix-symbols=__efistub_
-$(obj)/%.stub.o: $(obj)/%.o FORCE
-	$(call if_changed,objcopy)
-
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
 obj-$(CONFIG_COMPAT)			+= sigreturn32.o
@@ -57,8 +51,7 @@ obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
-					   efi-rt-wrapper.o
+obj-$(CONFIG_EFI)			+= efi.o efi-rt-wrapper.o
 obj-$(CONFIG_PCI)			+= pci.o
 obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
 obj-$(CONFIG_ACPI)			+= acpi.o
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b1601aad7e1a..efc8cefab889 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -82,7 +82,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64-stub.o
+lib-$(CONFIG_ARM64)		+= arm64-stub.o arm64-entry.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
@@ -136,7 +136,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 #
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
-STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
+STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS64
 
 # For RISC-V, we don't need anything special other than arm64. Keep all the
 # symbols in .init section and make sure that no absolute symbols references
diff --git a/arch/arm64/kernel/efi-entry.S b/drivers/firmware/efi/libstub/arm64-entry.S
similarity index 97%
rename from arch/arm64/kernel/efi-entry.S
rename to drivers/firmware/efi/libstub/arm64-entry.S
index 8bce13356e29..87082b222a87 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/drivers/firmware/efi/libstub/arm64-entry.S
@@ -6,12 +6,8 @@
  * Author: Mark Salter <msalter@redhat.com>
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
-
 #include <asm/assembler.h>
 
-	__INIT
-
 SYM_CODE_START(efi_enter_kernel)
 	/*
 	 * efi_pe_entry() will have copied the kernel image if necessary and we
-- 
2.35.1

