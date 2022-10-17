Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18060149C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJQRSV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQRSU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C671BE5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B59B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F2BC433D7;
        Mon, 17 Oct 2022 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027094;
        bh=gm4NPhu3zzk3cCptn9LomJfkU5uNciRUxGMp83dhxoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOHQddawMMa2113kkNky8zmhi0El0ePxha0XibJ8TUJs9aDly//k/bKJ4ti6kOFWL
         XbHLdJRO8UwUHD+SrDXJ+bAuPieFZ4Z8yW1MVU6OGfOBAG+CM3Mmfy9cm9a7TjCTSX
         aC2btwwjqxUkBoa+rFLedwPRoMOQO5932uBMPAX+rJlSB8WfRR1Kxkt4V711wRTRhE
         M7r+n29iDznOakIRRy72j7M1V/9Evuj3Qi1j1SzlW4S7xAJucfBz64JsOE2/uK2NcO
         TT7l7P16OHFjYsgwBRJkbUP2xMh3Cjzua/V5bVb3eiHwVAV+mm0Qr3eq1XwAcsvgM4
         NwLthPs+gKsRQ==
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
Subject: [PATCH 17/21] efi/riscv: libstub: Split off kernel image relocation for builtin stub
Date:   Mon, 17 Oct 2022 19:16:56 +0200
Message-Id: <20221017171700.3736890-18-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7550; i=ardb@kernel.org; h=from:subject; bh=gm4NPhu3zzk3cCptn9LomJfkU5uNciRUxGMp83dhxoA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4EYxAAplGcOBOEu9pU5tYGVlTCGy89TUzZvHdR Q3JgQsaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OBAAKCRDDTyI5ktmPJOAMDA CePNhHam2Cn2pBH7weo4+97ntuftHsUxkx4+U+fLmYQN4IFFhOQBbKt58T5rfCOpZVRTmq/lUTWN3B qF8HKO1uRuQw1SKbHnS3sl5n5rv7InRWMlQx5XRd5ryjfPys08I9j66mvFt+PS67zoWB2tEUFokwcv lwzE4WHi4dABUu8vtA6q46IPn9Yzjrursy6uH04qXcWG92NK+PN6aIIGn+oitZTdzBL0XVIObobLXy OChlYzc29wehkD+cvalYh74ZHyJMADB4mWluwLHbGeGNncMXh4vimKeBK+/R4yaeVJpdEreTjcDvQL 1Ju+kf2Xt54eZon8NPlKEsJVd0cqFe/8wSSYNPOknMXd0BcNmxIC8APjLFRRwR0IClrWn/qqjLBnKY kzDba/Uo8PCBn6ukf/ONadqRjlMiFZN1HikxTJ5WV4uxqrt2RNxaDCKNG++3cEmMbpXX4rLG6lH/ZZ r2MieskU4hoZuiYzK1NHUOigwAy+IA6DVhjoPHojM4ifc=
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

The RISC-V build of the EFI stub is part of the core kernel image, and
therefore accesses section markers directly when it needs to figure out
the size of the various section.

The zboot decompressor does not have access to those symbols, but
doesn't really need that either. So let's move handle_kernel_image()
into a separate file (or rather, move everything else into a separate
file) so that the zboot build does not pull in unused code that links to
symbols that it does not define.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/include/asm/efi.h              |  2 +
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/riscv-stub.c | 81 ++--------------
 drivers/firmware/efi/libstub/riscv.c      | 98 ++++++++++++++++++++
 4 files changed, 108 insertions(+), 75 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index a742868eb23c..6cbc7437d886 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -45,4 +45,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
+unsigned long stext_offset(void);
+
 #endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d5d6c6239f9c..28c8300c6a61 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,7 +86,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o arm64-entry.o
 lib-$(CONFIG_X86)		+= x86-stub.o
-lib-$(CONFIG_RISCV)		+= riscv-stub.o
+lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
 
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index c5a551f69a7f..145c9f0ba217 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/libfdt.h>
 
 #include <asm/efi.h>
 #include <asm/sections.h>
@@ -12,82 +11,16 @@
 
 #include "efistub.h"
 
-typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
-
-static unsigned long hartid;
-
-static int get_boot_hartid_from_fdt(void)
-{
-	const void *fdt;
-	int chosen_node, len;
-	const void *prop;
-
-	fdt = get_efi_config_table(DEVICE_TREE_GUID);
-	if (!fdt)
-		return -EINVAL;
-
-	chosen_node = fdt_path_offset(fdt, "/chosen");
-	if (chosen_node < 0)
-		return -EINVAL;
-
-	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
-	if (!prop)
-		return -EINVAL;
-
-	if (len == sizeof(u32))
-		hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
-	else if (len == sizeof(u64))
-		hartid = (unsigned long) fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop));
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static efi_status_t get_boot_hartid_from_efi(void)
+unsigned long stext_offset(void)
 {
-	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
-	struct riscv_efi_boot_protocol *boot_protocol;
-	efi_status_t status;
-
-	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
-			     (void **)&boot_protocol);
-	if (status != EFI_SUCCESS)
-		return status;
-	return efi_call_proto(boot_protocol, get_boot_hartid, &hartid);
-}
-
-efi_status_t check_platform_features(void)
-{
-	efi_status_t status;
-	int ret;
-
-	status = get_boot_hartid_from_efi();
-	if (status != EFI_SUCCESS) {
-		ret = get_boot_hartid_from_fdt();
-		if (ret) {
-			efi_err("Failed to get boot hartid!\n");
-			return EFI_UNSUPPORTED;
-		}
-	}
-	return EFI_SUCCESS;
-}
-
-void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
-				 unsigned long fdt_size)
-{
-	unsigned long stext_offset = _start_kernel - _start;
-	unsigned long kernel_entry = entrypoint + stext_offset;
-	jump_kernel_func jump_kernel = (jump_kernel_func)kernel_entry;
-
 	/*
-	 * Jump to real kernel here with following constraints.
-	 * 1. MMU should be disabled.
-	 * 2. a0 should contain hartid
-	 * 3. a1 should DT address
+	 * When built as part of the kernel, the EFI stub cannot branch to the
+	 * kernel proper via the image header, as the PE/COFF header is
+	 * strictly not part of the in-memory presentation of the image, only
+	 * of the file representation. So instead, we need to jump to the
+	 * actual entrypoint in the .text region of the image.
 	 */
-	csr_write(CSR_SATP, 0);
-	jump_kernel(hartid, fdt);
+	return _start_kernel - _start;
 }
 
 efi_status_t handle_kernel_image(unsigned long *image_addr,
diff --git a/drivers/firmware/efi/libstub/riscv.c b/drivers/firmware/efi/libstub/riscv.c
new file mode 100644
index 000000000000..8022b104c3e6
--- /dev/null
+++ b/drivers/firmware/efi/libstub/riscv.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/efi.h>
+#include <linux/libfdt.h>
+
+#include <asm/efi.h>
+#include <asm/unaligned.h>
+
+#include "efistub.h"
+
+typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
+
+static unsigned long hartid;
+
+static int get_boot_hartid_from_fdt(void)
+{
+	const void *fdt;
+	int chosen_node, len;
+	const void *prop;
+
+	fdt = get_efi_config_table(DEVICE_TREE_GUID);
+	if (!fdt)
+		return -EINVAL;
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node < 0)
+		return -EINVAL;
+
+	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
+	if (!prop)
+		return -EINVAL;
+
+	if (len == sizeof(u32))
+		hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
+	else if (len == sizeof(u64))
+		hartid = (unsigned long) fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop));
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static efi_status_t get_boot_hartid_from_efi(void)
+{
+	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
+	struct riscv_efi_boot_protocol *boot_protocol;
+	efi_status_t status;
+
+	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
+			     (void **)&boot_protocol);
+	if (status != EFI_SUCCESS)
+		return status;
+	return efi_call_proto(boot_protocol, get_boot_hartid, &hartid);
+}
+
+efi_status_t check_platform_features(void)
+{
+	efi_status_t status;
+	int ret;
+
+	status = get_boot_hartid_from_efi();
+	if (status != EFI_SUCCESS) {
+		ret = get_boot_hartid_from_fdt();
+		if (ret) {
+			efi_err("Failed to get boot hartid!\n");
+			return EFI_UNSUPPORTED;
+		}
+	}
+	return EFI_SUCCESS;
+}
+
+unsigned long __weak stext_offset(void)
+{
+	/*
+	 * This fallback definition is used by the EFI zboot stub, which loads
+	 * the entire image so it can branch via the image header at offset #0.
+	 */
+	return 0;
+}
+
+void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
+				 unsigned long fdt_size)
+{
+	unsigned long kernel_entry = entrypoint + stext_offset();
+	jump_kernel_func jump_kernel = (jump_kernel_func)kernel_entry;
+
+	/*
+	 * Jump to real kernel here with following constraints.
+	 * 1. MMU should be disabled.
+	 * 2. a0 should contain hartid
+	 * 3. a1 should DT address
+	 */
+	csr_write(CSR_SATP, 0);
+	jump_kernel(hartid, fdt);
+}
-- 
2.35.1

