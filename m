Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D65BC01D
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIRVgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIRVgS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5113FA8
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5239612AC
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86327C43470;
        Sun, 18 Sep 2022 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536976;
        bh=ay6ANRnQboi0NxXKHvifHtY18HiC0iKwDUCc7TAOKyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkoQZhyPdXem6+IsM4vC41g0FhxE8TV7TOVYR7OXjZ/UMTir1oHRrtZFxAhaUbanZ
         Bst/tocNNwK6Y/6mGOXk0SZXiZ6dpJuiQM/VN4cupJ9chxB3FfP+N8pd2tbWDVnLSG
         vwbtjJsW3e280aBH19TA9MOrWgtsaXVTsUsT8S1Zfo3HX5xUM5GmVQS95N/ahgFXaO
         ujyl9gV8Bp7oFDniy7LIX+uop9ypWVHvYnjkAiskXbqX1a0xdlrOotrgvwZGKLHUZE
         LjNWN2SEi5B7MfqmsQe1WYoCsdlexlIrOq5OFbW/9rmKS1PDv6W1nwOczSyc8jJLYo
         4vU5RGj7AmHUA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 08/12] efi: libstub: remove DT dependency from generic stub
Date:   Sun, 18 Sep 2022 23:35:40 +0200
Message-Id: <20220918213544.2176249-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7450; i=ardb@kernel.org; h=from:subject; bh=ay6ANRnQboi0NxXKHvifHtY18HiC0iKwDUCc7TAOKyk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48oQGwHYzRZQ0QbBxEQVVwJZmnB+PB+Oy3Eumk8 92zU3VqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePKAAKCRDDTyI5ktmPJM2UDA CqrhE3945MA9gAe3NGX5BLlC58E6OSAkaQDF0yAAhz7RMR7Ixp/3qDgdCJQfO3gqZpXLY2+yPX9mVx u48w9gCDXr2QLBO0ygpW1GP6sjCgK1bLuAVKiyjiVpsoRzOvxRXY9o4ux1XIdnexSw9+34XT7A6bwt UsbOKW70Ul3e1RenIdpQwtCd6JN9AAoC2NZb5ZK7hjiwDdeL2WTvX5iI7MHMwoRkzCkoIZ0fd+Sx1p T+zdUadBRUR1N3BdSofx4FU67VvNJeys5yA0oc6sGYIpG4fg5IplKXztkBqBVeySz+elOWWIT8bdVg g4ftxqxDEN5hHVhevbXiNLqGZWfM4A7RoxJ8jWEdLtvxa0EaunAyxLVAr5oZSRiIqq5jIHOkqrTBYr PuTLUX/RimC+jJlTWOz28r4bYT3ljOFD4yNt+Auf6EHUudEWKjjM8BkleI/phaRK6GVQpsuhIZzVnf kvGQnejOa35HQFtpFQfniWxkepdbIcopsgjKZRTwv2Bgo=
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

Refactor the generic EFI stub entry code so that all the dependencies on
device tree are abstracted and hidden behind a generic efi_boot_kernel()
routine that can also be implemented in other ways. This allows users of
the generic stub to avoid using FDT for passing information to the core
kernel.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 53 +---------------
 drivers/firmware/efi/libstub/efistub.h  |  7 +--
 drivers/firmware/efi/libstub/fdt.c      | 64 ++++++++++++++++++--
 3 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 88bdd0a6b488..8715f5a36b92 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/libfdt.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -130,14 +129,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	unsigned long image_addr;
 	unsigned long image_size = 0;
 	/* addr/point and size pairs for memory management*/
-	unsigned long fdt_addr = 0;  /* Original DTB */
-	unsigned long fdt_size = 0;
 	char *cmdline_ptr = NULL;
 	int cmdline_size = 0;
 	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
 	unsigned long reserve_addr = 0;
 	unsigned long reserve_size = 0;
-	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
 	efi_properties_table_t *prop_tbl;
 
@@ -213,38 +209,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
 
-	secure_boot = efi_get_secureboot();
-
-	/*
-	 * Unauthenticated device tree data is a security hazard, so ignore
-	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
-	 * boot is enabled if we can't determine its state.
-	 */
-	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
-	     secure_boot != efi_secureboot_mode_disabled) {
-		if (strstr(cmdline_ptr, "dtb="))
-			efi_err("Ignoring DTB from command line.\n");
-	} else {
-		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to load device tree!\n");
-			goto fail_free_image;
-		}
-	}
-
-	if (fdt_addr) {
-		efi_info("Using DTB from command line\n");
-	} else {
-		/* Look for a device tree configuration table entry. */
-		fdt_addr = (uintptr_t)get_fdt(&fdt_size);
-		if (fdt_addr)
-			efi_info("Using DTB from configuration table\n");
-	}
-
-	if (!fdt_addr)
-		efi_info("Generating empty DTB\n");
-
 	efi_load_initrd(image, ULONG_MAX,
 			efi_get_max_initrd_addr(image_addr));
 
@@ -288,23 +252,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	install_memreserve_table();
 
-	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr, cmdline_ptr,
-						fdt_addr, fdt_size);
-	if (status != EFI_SUCCESS)
-		goto fail_free_fdt;
-
-	if (IS_ENABLED(CONFIG_ARM))
-		efi_handle_post_ebs_state();
-
-	efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
-	/* not reached */
-
-fail_free_fdt:
-	efi_err("Failed to update FDT and exit boot services\n");
-
-	efi_free(fdt_size, fdt_addr);
+	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
-fail_free_image:
 	efi_free(image_size, image_addr);
 	efi_free(reserve_size, reserve_addr);
 fail_free_screeninfo:
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 82cff342da05..f65a8a3844b8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -865,11 +865,8 @@ typedef efi_status_t (*efi_exit_boot_map_processing)(
 efi_status_t efi_exit_boot_services(void *handle, void *priv,
 				    efi_exit_boot_map_processing priv_func);
 
-efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
-					    unsigned long *new_fdt_addr,
-					    char *cmdline_ptr,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long image_addr, char *cmdline_ptr);
 
 void *get_fdt(unsigned long *fdt_size);
 
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index a3cd603ea484..8251c9c8463d 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -219,17 +219,19 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
  * exit_boot_services() call, so the exiting of boot services is very tightly
  * tied to the creation of the FDT with the final memory map in it.
  */
-
+static
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
+					    efi_loaded_image_t *image,
 					    unsigned long *new_fdt_addr,
-					    char *cmdline_ptr,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size)
+					    char *cmdline_ptr)
 {
 	unsigned long desc_size;
 	u32 desc_ver;
 	efi_status_t status;
+	enum efi_secureboot_mode secure_boot;
 	struct exit_boot_struct priv;
+	unsigned long fdt_addr = 0;
+	unsigned long fdt_size = 0;
 
 	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
 	if (status != EFI_SUCCESS) {
@@ -237,6 +239,38 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return status;
 	}
 
+	secure_boot = efi_get_secureboot();
+
+	/*
+	 * Unauthenticated device tree data is a security hazard, so ignore
+	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
+	 * boot is enabled if we can't determine its state.
+	 */
+	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
+	    secure_boot != efi_secureboot_mode_disabled) {
+		if (strstr(cmdline_ptr, "dtb="))
+			efi_err("Ignoring DTB from command line.\n");
+	} else {
+		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
+
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to load device tree!\n");
+			goto fail;
+		}
+	}
+
+	if (fdt_addr) {
+		efi_info("Using DTB from command line\n");
+	} else {
+		/* Look for a device tree configuration table entry. */
+		fdt_addr = (uintptr_t)get_fdt(&fdt_size);
+		if (fdt_addr)
+			efi_info("Using DTB from configuration table\n");
+	}
+
+	if (!fdt_addr)
+		efi_info("Generating empty DTB\n");
+
 	efi_info("Exiting boot services...\n");
 
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
@@ -300,11 +334,33 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
+	efi_free(fdt_size, fdt_addr);
+
 	efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
 
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long image_addr, char *cmdline_ptr)
+{
+	unsigned long fdt_addr;
+	efi_status_t status;
+
+	status = allocate_new_fdt_and_exit_boot(handle, image, &fdt_addr,
+						cmdline_ptr);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to update FDT and exit boot services\n");
+		return status;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_handle_post_ebs_state();
+
+	efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
+	/* not reached */
+}
+
 void *get_fdt(unsigned long *fdt_size)
 {
 	void *fdt;
-- 
2.35.1

