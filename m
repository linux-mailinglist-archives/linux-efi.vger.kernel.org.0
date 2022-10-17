Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264816014A0
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJQRSt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJQRS1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5C71BF8
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76678611DB
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FBC43141;
        Mon, 17 Oct 2022 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027104;
        bh=3XkptpC2lSj1V7TvcyimU53oTRv00/wBOR0JleKWnso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwY2AakSVh8EBdbEtYXPC9jTbZUX0h1jAAbgUT3OYR7wC4aVZfAZrawEMo8WRrS+q
         /NquR4OXWRnd8GAcEbFbDZfmTnUURnaoaTxD8A8KJ80AqcJsrMdCzbaLJ7o32N18wO
         lNw7JLPMziksYxhPJSOGOxtvk3ONvMeQ/0fhwwkw/2egKbBPmRiHarOMUQucLR/Nbx
         YtwyrSLYQkSnGPW/gVrwdJVuPkrCEND0bWP9oWQ2yeGl2SCkZOXOA2Av3KeMQXLBxS
         g2d78H9JrvXvcK6roQM40TfBrf2P8OUQ9Gruy87ovDiNNPWP0xrQ0ZdETj88ROq9cI
         SBrJ6WKtPiLCg==
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
Subject: [PATCH 20/21] efi/loongarch: libstub: Split off kernel image relocation for builtin stub
Date:   Mon, 17 Oct 2022 19:16:59 +0200
Message-Id: <20221017171700.3736890-21-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6766; i=ardb@kernel.org; h=from:subject; bh=3XkptpC2lSj1V7TvcyimU53oTRv00/wBOR0JleKWnso=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4JKK0YC38UTZ9ZZM1c9uUpStUbHQlD3EzOX03A 84vhchiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OCQAKCRDDTyI5ktmPJOTsDA CThrqVSByG0Mjuk2Oiom0ny8DoG+s+fCBT0DomKmtuR6A9zQAQhm/Nadx2qZjlcmdh63ulfhwmV0Hy GQDHjINGlpvft4PbvYT1Ac+Gpx2FtmDM5vxb0MwMwCUxrSAKnTx5vumUhgg8qxyDrQ1HowyIZhXmzg lxQO1QM82Ww5D+rV3KKlsHqRawbMmDdtoYtRgfHtiTQyAuSVPoeTQ300FRyMMajLNFzGQdgjedaA05 sW7Q0wFImaaOxZBS+7l5+AqoQdMECRjYBMWLbhGyeQ9G/hVaHWfNxPMPEcvGsMRCvzfFm+WlF8Qndk v8bfKFxCfmWOALUTvwQliVvlRLl0ROnT3qaWa2oy8eUpuwam4D17JbM1MXcHWoDv4zpYCNrGC70fUt B797g3/L/0Kyk2eR8VX0dwMelhZgUwtNyIGp6q1E9i9w1OBVzBrCXa8kLj3kquvJ7JmcPrIS7lTG1J ZqydQYKZ7AKJqdWfp4oQJ9syiW/sxO7dpi4XNOY0sTAyw=
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

The LoongArch build of the EFI stub is part of the core kernel image, and
therefore accesses section markers directly when it needs to figure out
the size of the various section.

The zboot decompressor does not have access to those symbols, but
doesn't really need that either. So let's move handle_kernel_image()
into a separate file (or rather, move everything else into a separate
file) so that the zboot build does not pull in unused code that links to
symbols that it does not define.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c | 67 +---------------
 drivers/firmware/efi/libstub/loongarch.c      | 80 ++++++++++++++++++++
 3 files changed, 82 insertions(+), 67 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ee24b222489c..37e23e4ab68d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -87,7 +87,7 @@ lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o arm64-entry.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
-lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
+lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index 6b30fc281458..eee7ed43cdfb 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -9,18 +9,10 @@
 #include <asm/addrspace.h>
 #include "efistub.h"
 
-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
-					  unsigned long systab);
-
 extern int kernel_asize;
 extern int kernel_fsize;
 extern int kernel_offset;
-extern kernel_entry_t kernel_entry;
-
-efi_status_t check_platform_features(void)
-{
-	return EFI_SUCCESS;
-}
+extern int kernel_entry;
 
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
@@ -53,66 +45,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-struct exit_boot_struct {
-	efi_memory_desc_t	*runtime_map;
-	int			runtime_entry_count;
-};
-
-static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
-{
-	struct exit_boot_struct *p = priv;
-
-	/*
-	 * Update the memory map with virtual addresses. The function will also
-	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
-	 * entries so that we can pass it straight to SetVirtualAddressMap()
-	 */
-	efi_get_virtmap(map->map, map->map_size, map->desc_size,
-			p->runtime_map, &p->runtime_entry_count);
-
-	return EFI_SUCCESS;
-}
-
 unsigned long kernel_entry_address(void)
 {
 	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
 
 	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
 }
-
-efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
-			     unsigned long kernel_addr, char *cmdline_ptr)
-{
-	kernel_entry_t real_kernel_entry;
-	struct exit_boot_struct priv;
-	unsigned long desc_size;
-	efi_status_t status;
-	u32 desc_ver;
-
-	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
-	if (status != EFI_SUCCESS) {
-		efi_err("Unable to retrieve UEFI memory map.\n");
-		return status;
-	}
-
-	efi_info("Exiting boot services\n");
-
-	efi_novamap = false;
-	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	/* Install the new virtual address map */
-	efi_rt_call(set_virtual_address_map,
-		    priv.runtime_entry_count * desc_size, desc_size,
-		    desc_ver, priv.runtime_map);
-
-	/* Config Direct Mapping */
-	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
-	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
-
-	real_kernel_entry = (void *)kernel_entry_address();
-
-	real_kernel_entry(true, (unsigned long)cmdline_ptr,
-			  (unsigned long)efi_system_table);
-}
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
new file mode 100644
index 000000000000..807cba2693fc
--- /dev/null
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Yun Liu <liuyun@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/efi.h>
+#include <asm/addrspace.h>
+#include "efistub.h"
+
+typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+					  unsigned long systab);
+
+efi_status_t check_platform_features(void)
+{
+	return EFI_SUCCESS;
+}
+
+struct exit_boot_struct {
+	efi_memory_desc_t	*runtime_map;
+	int			runtime_entry_count;
+};
+
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
+{
+	struct exit_boot_struct *p = priv;
+
+	/*
+	 * Update the memory map with virtual addresses. The function will also
+	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
+	 * entries so that we can pass it straight to SetVirtualAddressMap()
+	 */
+	efi_get_virtmap(map->map, map->map_size, map->desc_size,
+			p->runtime_map, &p->runtime_entry_count);
+
+	return EFI_SUCCESS;
+}
+
+unsigned long __weak kernel_entry_address(void)
+{
+	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+}
+
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long kernel_addr, char *cmdline_ptr)
+{
+	kernel_entry_t real_kernel_entry;
+	struct exit_boot_struct priv;
+	unsigned long desc_size;
+	efi_status_t status;
+	u32 desc_ver;
+
+	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
+	if (status != EFI_SUCCESS) {
+		efi_err("Unable to retrieve UEFI memory map.\n");
+		return status;
+	}
+
+	efi_info("Exiting boot services\n");
+
+	efi_novamap = false;
+	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	/* Install the new virtual address map */
+	efi_rt_call(set_virtual_address_map,
+		    priv.runtime_entry_count * desc_size, desc_size,
+		    desc_ver, priv.runtime_map);
+
+	/* Config Direct Mapping */
+	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
+	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
+
+	real_kernel_entry = (void *)kernel_entry_address();
+
+	real_kernel_entry(true, (unsigned long)cmdline_ptr,
+			  (unsigned long)efi_system_table);
+}
-- 
2.35.1

