Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE132601497
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJQRSM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQRSK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C2719B9
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13F29B819CD
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BB3C433B5;
        Mon, 17 Oct 2022 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027084;
        bh=RJT1PGkq99Sb/5oTgcwfKoBIRleTU9YvUAphLeMfw2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMPwZnVoZ1F2qnwSIEovTyqEQYjjAQme/jUPuqIoE7LkRqQixD2pZASJa2SBP96xR
         PNMA4t54yZbcx54XdlELpY1FsRaHWQxj0ggbeO1akLDux1qO31xU13fapH45TUIFAm
         QtYo8Cq2/OtnV8rXeWJiLZrsm8nQo5zvpJVeSEzN3B0dW9DrDvn+goAK5ezpUOTTpk
         RjL6AHCZE+x5utOcOjPJwzr2z2V5k4Lm6P239VhK3DaQn9MhI7sVF3+bzqgmSb+0FZ
         KHrGS7J9nylPEEcknrx03Neby7DIVu4ZC56g07XWh4dEWSYLEAS8SgNOUsXGJQ50tO
         j4AQ9++I3gAVQ==
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
Subject: [PATCH 14/21] efi: libstub: Factor out EFI stub entrypoint into separate file
Date:   Mon, 17 Oct 2022 19:16:53 +0200
Message-Id: <20221017171700.3736890-15-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8216; i=ardb@kernel.org; h=from:subject; bh=RJT1PGkq99Sb/5oTgcwfKoBIRleTU9YvUAphLeMfw2M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3/nIiTnGM2hqObnvfsA4JH5Ll89/KCwW7xzkFM tW02y6SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N/wAKCRDDTyI5ktmPJHBwC/ 900mOnyK9j93NXdM8PvtOyYXfgsxmK/zvGI4XS3XrP1ZytktwuR+/A2Eb7wYv4L/lA0aAvEgHMQ78z m4pfpPhX/BNN1hxerR4dXw24lC7gfdb1klIHiB/L2HRS5wpbaZtUlcW6NSulZZSSlTdPjUxStQBDcQ /m8T2cBs8VSTzbPi66ZKx84E/yhMfjsYaZAXewPnbO1baDQ5dZOlrfj76YLyxTrubust2/jO0ajmXl qJs6WLPuePeHL2bByudkkH9EsdxZ/1PxFY8HpWJFHohNyQhheMgeKDwJ1rDC1Tg0BhcW+vLRKgP0s0 r6w0pe04WMXlEnTNlE5zbmYiQyxjiWgQoRZ0raULZuf4mn4d0mMaIJGZA1u9nsYTU4r++MzAtE1RaX 6ayjHXZbTroTOSafA9ScCtoyJ+3a3YIiVdkmJ+DiWQNdA75aU2FWUqG/q32e6Qu4qPJ2FgoG+v7Yf3 h3IoaP/+ErK6mutKkotD2nJUHleWIAQFZtTNPgN0EJUhY=
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

In preparation for allowing the EFI zboot decompressor to reuse most of
the EFI stub machinery, factor out the actual EFI PE/COFF entrypoint
into a separate file.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile         |  3 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c | 65 ++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       | 89 ++++++--------------
 drivers/firmware/efi/libstub/efistub.h        |  8 ++
 4 files changed, 101 insertions(+), 64 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 6824ee5a4ae6..d5d6c6239f9c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -67,7 +67,8 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o printk.o vsprintf.o
+				   alignedmem.o relocate.o printk.o vsprintf.o \
+				   efi-stub-entry.o
 
 # include the stub's libfdt dependencies from lib/ when needed
 libfdt-deps			:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c \
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
new file mode 100644
index 000000000000..5245c4f031c0
--- /dev/null
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/*
+ * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
+ * LoongArch. This is the entrypoint that is described in the PE/COFF header
+ * of the core kernel.
+ */
+efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
+				   efi_system_table_t *systab)
+{
+	efi_loaded_image_t *image;
+	efi_status_t status;
+	unsigned long image_addr;
+	unsigned long image_size = 0;
+	/* addr/point and size pairs for memory management*/
+	char *cmdline_ptr = NULL;
+	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
+	unsigned long reserve_addr = 0;
+	unsigned long reserve_size = 0;
+
+	WRITE_ONCE(efi_system_table, systab);
+
+	/* Check if we were booted by the EFI firmware */
+	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * Get a handle to the loaded image protocol.  This is used to get
+	 * information about the running image, such as size and the command
+	 * line.
+	 */
+	status = efi_bs_call(handle_protocol, handle, &loaded_image_proto,
+			     (void *)&image);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to get loaded image protocol\n");
+		return status;
+	}
+
+	status = efi_handle_cmdline(image, &cmdline_ptr);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	efi_info("Booting Linux Kernel...\n");
+
+	status = handle_kernel_image(&image_addr, &image_size,
+				     &reserve_addr,
+				     &reserve_size,
+				     image, handle);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to relocate kernel\n");
+		return status;
+	}
+
+	status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
+
+	efi_free(image_size, image_addr);
+	efi_free(reserve_size, reserve_addr);
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 8521dc09c6ae..2955c1ac6a36 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -115,61 +115,21 @@ static u32 get_supported_rt_services(void)
 	return supported;
 }
 
-/*
- * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
- * that is described in the PE/COFF header.  Most of the code is the same
- * for both archictectures, with the arch-specific code provided in the
- * handle_kernel_image() function.
- */
-efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
-				   efi_system_table_t *sys_table_arg)
+efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 {
-	efi_loaded_image_t *image;
-	efi_status_t status;
-	unsigned long image_addr;
-	unsigned long image_size = 0;
-	/* addr/point and size pairs for memory management*/
-	char *cmdline_ptr = NULL;
 	int cmdline_size = 0;
-	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
-	unsigned long reserve_addr = 0;
-	unsigned long reserve_size = 0;
-	struct screen_info *si;
-
-	efi_system_table = sys_table_arg;
-
-	/* Check if we were booted by the EFI firmware */
-	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE) {
-		status = EFI_INVALID_PARAMETER;
-		goto fail;
-	}
-
-	status = check_platform_features();
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	/*
-	 * Get a handle to the loaded image protocol.  This is used to get
-	 * information about the running image, such as size and the command
-	 * line.
-	 */
-	status = efi_bs_call(handle_protocol, handle, &loaded_image_proto,
-			     (void *)&image);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to get loaded image protocol\n");
-		goto fail;
-	}
+	efi_status_t status;
+	char *cmdline;
 
 	/*
 	 * Get the command line from EFI, using the LOADED_IMAGE
 	 * protocol. We are going to copy the command line into the
 	 * device tree, so this can be allocated anywhere.
 	 */
-	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size);
-	if (!cmdline_ptr) {
+	cmdline = efi_convert_cmdline(image, &cmdline_size);
+	if (!cmdline) {
 		efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
-		status = EFI_OUT_OF_RESOURCES;
-		goto fail;
+		return EFI_OUT_OF_RESOURCES;
 	}
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
@@ -183,25 +143,34 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	}
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
-		status = efi_parse_options(cmdline_ptr);
+		status = efi_parse_options(cmdline);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
 			goto fail_free_cmdline;
 		}
 	}
 
-	efi_info("Booting Linux Kernel...\n");
+	*cmdline_ptr = cmdline;
+	return EFI_SUCCESS;
 
-	si = setup_graphics();
+fail_free_cmdline:
+	efi_bs_call(free_pool, cmdline_ptr);
+	return status;
+}
 
-	status = handle_kernel_image(&image_addr, &image_size,
-				     &reserve_addr,
-				     &reserve_size,
-				     image, handle);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to relocate kernel\n");
-		goto fail_free_screeninfo;
-	}
+efi_status_t efi_stub_common(efi_handle_t handle,
+			     efi_loaded_image_t *image,
+			     unsigned long image_addr,
+			     char *cmdline_ptr)
+{
+	struct screen_info *si;
+	efi_status_t status;
+
+	status = check_platform_features();
+	if (status != EFI_SUCCESS)
+		return status;
+
+	si = setup_graphics();
 
 	efi_retrieve_tpm2_eventlog();
 
@@ -221,13 +190,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
-	efi_free(image_size, image_addr);
-	efi_free(reserve_size, reserve_addr);
-fail_free_screeninfo:
 	free_screen_info(si);
-fail_free_cmdline:
-	efi_bs_call(free_pool, cmdline_ptr);
-fail:
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 215186a29ab9..a2fc0727880a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1010,6 +1010,14 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle);
 
+/* shared entrypoint between the normal stub and the zboot stub */
+efi_status_t efi_stub_common(efi_handle_t handle,
+			     efi_loaded_image_t *image,
+			     unsigned long image_addr,
+			     char *cmdline_ptr);
+
+efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr);
+
 asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 					    unsigned long fdt_addr,
 					    unsigned long fdt_size);
-- 
2.35.1

