Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E951760149B
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJQRSV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJQRSU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A476719AC
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD141611D5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A8C4347C;
        Mon, 17 Oct 2022 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027098;
        bh=uA10ts1bdJgyd9JKzcEXcregBLnghxvJwJwfubfNmN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9lfz39hFwUK+eJC1wahYrfkT216YfaIxqCB5egtSromgAfTzUm4A1OWQnD1EWrZ8
         4w9QUrWoW5xhSUqx1VAC+JGE/HmHy9BUKftpgEBNAKyIpyer7eUdDZ7VSFEwl2kGMf
         d7fN17Ldq0eVwwmwoSoz47DtqxpVwRrvNYKwK7dYyHWpz7zYeT65G2RM+Rrvt+jgbY
         bqE/3pmC2M9OircXGCwWXgaDpV56rBWjL1g0rffqiD54NDPMiUeteZow8mLIhGfcTn
         J8j7kNq0FzK9cECKzi9mIE8LuSrbhiY2HzhakciXWcqVvJb3fekjGvmW5ncrp9kkeK
         Z+TaM2E6baOlg==
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
Subject: [PATCH 18/21] efi/arm64: libstub: Split off kernel image relocation for builtin stub
Date:   Mon, 17 Oct 2022 19:16:57 +0200
Message-Id: <20221017171700.3736890-19-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6592; i=ardb@kernel.org; h=from:subject; bh=uA10ts1bdJgyd9JKzcEXcregBLnghxvJwJwfubfNmN4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4GM4L2eMPdXaZ58c7tKf6cEQdcrAVRM8SyYdMY GSrc2miJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OBgAKCRDDTyI5ktmPJByrDA C1Bb3N6ckOJnFeVeX/7nxNRxFxtQ8uJa3RgqQy568UaKCHXLg+P5tl6ZBbagICJgBdbcro7edx+TQ8 fR4W/91W0daNjr50BLj4TJgW7oKW/GZebuGzJqP/+NzFcYnZo+v43GCg9B1Ma4VZm4cYT5iiOzQV+o OA0HlPcJkfwsjjQKRgzoQ+8AbLRpF2GXstf0isPReVtRIqrT/o8hJitTlsQKZCE+Mkn8nC4dtYFRzV ESa0N/wA78M7OaxSNcu+24xahOf02Se2bER0lTH/PDYPmwnzY9FfAjxZbv0gPDelE3T4ESSvGeyPyt j3ZeDRbrWlJ5fnVMe5fVAyS48DrHsa+LHfRfpAE7N+czn52XtORldO9puOoi7bGVCYpdG1pT1Fsyxf tjubJNNqwjrY4GIRNEJyUvrgzCTPIg0IEudSTcl8UYgzihZHmwhso54J2kv+p8VZyf2VP1/Bx6kRH2 /xw6koU6ZkwQmufvVot2wPCwvpANBtgoTJvifkQbh03PE=
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

The arm64 build of the EFI stub is part of the core kernel image, and
therefore accesses section markers directly when it needs to figure out
the size of the various section.

The zboot decompressor does not have access to those symbols, but
doesn't really need that either. So let's move handle_kernel_image()
into a separate file (or rather, move everything else into a separate
file) so that the zboot build does not pull in unused code that links to
symbols that it does not define.

While at it, introduce a helper routine that the generic zboot loader
will need to invoke after decompressing the image but before invoking
it, to ensure that the I-side view of memory is consistent.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile      |  2 +-
 drivers/firmware/efi/libstub/arm64-entry.S | 12 ++++
 drivers/firmware/efi/libstub/arm64-stub.c  | 28 ---------
 drivers/firmware/efi/libstub/arm64.c       | 61 ++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h     |  4 ++
 5 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 28c8300c6a61..ee24b222489c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -84,7 +84,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 				   screen_info.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64-stub.o arm64-entry.o
+lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o arm64-entry.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
diff --git a/drivers/firmware/efi/libstub/arm64-entry.S b/drivers/firmware/efi/libstub/arm64-entry.S
index 87082b222a87..ec5492a738fe 100644
--- a/drivers/firmware/efi/libstub/arm64-entry.S
+++ b/drivers/firmware/efi/libstub/arm64-entry.S
@@ -8,6 +8,18 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
+	/*
+	 * The entrypoint of a arm64 bare metal image is at offset #0 of the
+	 * image, so this is a reasonable default for primary_entry_offset.
+	 * Only when the EFI stub is integrated into the core kernel, it is not
+	 * guaranteed that the PE/COFF header has been copied to memory too, so
+	 * in this case, primary_entry_offset should be overridden by the
+	 * linker and point to primary_entry() directly.
+	 */
+	.globl	primary_entry_offset
+	.weak	primary_entry_offset
+	.set	primary_entry_offset, 0
+
 SYM_CODE_START(efi_enter_kernel)
 	/*
 	 * efi_pe_entry() will have copied the kernel image if necessary and we
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index dd21b7b7309a..7f0aab3a8ab3 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -11,37 +11,9 @@
 #include <asm/efi.h>
 #include <asm/memory.h>
 #include <asm/sections.h>
-#include <asm/sysreg.h>
 
 #include "efistub.h"
 
-efi_status_t check_platform_features(void)
-{
-	u64 tg;
-
-	/*
-	 * If we have 48 bits of VA space for TTBR0 mappings, we can map the
-	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
-	 * unnecessary.
-	 */
-	if (VA_BITS_MIN >= 48)
-		efi_novamap = true;
-
-	/* UEFI mandates support for 4 KB granularity, no need to check */
-	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
-		return EFI_SUCCESS;
-
-	tg = (read_cpuid(ID_AA64MMFR0_EL1) >> ID_AA64MMFR0_EL1_TGRAN_SHIFT) & 0xf;
-	if (tg < ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN || tg > ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX) {
-		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-			efi_err("This 64 KB granular kernel is not supported by your CPU\n");
-		else
-			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
-		return EFI_UNSUPPORTED;
-	}
-	return EFI_SUCCESS;
-}
-
 /*
  * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
  * to provide space, and fail to zero it). Check for this condition by double
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
new file mode 100644
index 000000000000..d2e94972c5fa
--- /dev/null
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013, 2014 Linaro Ltd;  <roy.franz@linaro.org>
+ *
+ * This file implements the EFI boot stub for the arm64 kernel.
+ * Adapted from ARM version by Mark Salter <msalter@redhat.com>
+ */
+
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include <asm/memory.h>
+#include <asm/sysreg.h>
+
+#include "efistub.h"
+
+efi_status_t check_platform_features(void)
+{
+	u64 tg;
+
+	/*
+	 * If we have 48 bits of VA space for TTBR0 mappings, we can map the
+	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
+	 * unnecessary.
+	 */
+	if (VA_BITS_MIN >= 48)
+		efi_novamap = true;
+
+	/* UEFI mandates support for 4 KB granularity, no need to check */
+	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+		return EFI_SUCCESS;
+
+	tg = (read_cpuid(ID_AA64MMFR0_EL1) >> ID_AA64MMFR0_EL1_TGRAN_SHIFT) & 0xf;
+	if (tg < ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN || tg > ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX) {
+		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
+			efi_err("This 64 KB granular kernel is not supported by your CPU\n");
+		else
+			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
+		return EFI_UNSUPPORTED;
+	}
+	return EFI_SUCCESS;
+}
+
+void efi_cache_sync_image(unsigned long image_base,
+			  unsigned long alloc_size,
+			  unsigned long code_size)
+{
+	u32 ctr = read_cpuid_effective_cachetype();
+	u64 lsize = 4 << cpuid_feature_extract_unsigned_field(ctr,
+						CTR_EL0_DminLine_SHIFT);
+
+	do {
+		asm("dc civac, %0" :: "r"(image_base));
+		image_base += lsize;
+		alloc_size -= lsize;
+	} while (alloc_size >= lsize);
+
+	asm("ic ialluis");
+	dsb(ish);
+	isb();
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a2fc0727880a..576e5cfec980 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1038,4 +1038,8 @@ void efi_retrieve_tpm2_eventlog(void);
 struct screen_info *alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
 
+void efi_cache_sync_image(unsigned long image_base,
+			  unsigned long alloc_size,
+			  unsigned long code_size);
+
 #endif
-- 
2.35.1

