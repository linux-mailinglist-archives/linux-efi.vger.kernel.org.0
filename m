Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A585BECDF
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiITSgU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiITSgT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADCB6CD18
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B3FBB81665
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D825C433C1;
        Tue, 20 Sep 2022 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698975;
        bh=g5RjjXUW/pzP1SPvxT6Ja7oTkYi3f51W0CWE7W3KTmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsWLTq6nV47F1n4pyoHepPYQ9ugjUrnIu/Z/GLQ4b7gk3hGfYJ4ggN6CfKWQ6ggaf
         f50mLOkmkITG/p85wJ+Chjsbmx2rJmD02txbgPaI5Uodtkj0dj8BxMel7yNmgRlHu8
         CaWcXKy8YqukXi/adGJIY3B2wGqDX4T6z5aiGvpN4YMLrCeoO2qX+0xVB/b1oC/6NM
         EZWpHH4mq1eZlVW1CIlxzzMkWQ/7mi/8I2BzfeyBlpJfKDPeRq+CWYmdUHVNrCY3eZ
         JPRtBfXTGaJ6kWHmFdvzkDdz0w0aMYE16S2YH9aAJPrdZFjJt75Fd5R9zqJeCpqSOB
         HLJBFM7x/+TQw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 6/8] efi: libstub: remove DT dependency from generic stub
Date:   Tue, 20 Sep 2022 20:35:52 +0200
Message-Id: <20220920183554.3870247-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920183554.3870247-1-ardb@kernel.org>
References: <20220920183554.3870247-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7347; i=ardb@kernel.org; h=from:subject; bh=g5RjjXUW/pzP1SPvxT6Ja7oTkYi3f51W0CWE7W3KTmg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKggFYRgIVypVIUGnnv7OKYgek8hjsFwagk+xPob+ RGuO3vuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoIBQAKCRDDTyI5ktmPJH4oC/ 9pXK+C6JXxuZakI9vLJlbxYSSYFh6igVBOEZXabbDrITp0doBADRv7UN04BBztAKaWvHIrHBbHQhKv feXWw0pdeM+QgoMmstj5tcIA2WpLSKC6+LwVQCV2I0O+SqmZmzSRcycYlafLePw+vQL2iabECY8a/k f+Jvuo8fZIVQf1bRotHWb9vDIB5jXgpaa1w66MTdUCE9ev5ov2J445kyaPd7STrZ6RpRXkBvmOOvee TSUu2mhgx4Q9yYrDC2uAkxoQ/lbmSwEDVwvNhx+p/4Smx7cmUpab7ujiyJjCkwxxtAP3VPsTnXtMS6 f5Te5jn9J8kKaY7KGPckHUO6Fx0CRWv5kJ8ObGAtyQIL7J/M9C5xVkbc2VZFEhSetkHabpgUZzamkt xcFu9zxF828eER2G8cRwUSoY81uZeiaMwxXO3AdBBiB21nP92IiFAvevV80KY1MwJG0nDbtotBVy4c JgdS4J/mmgXMrLb7dv0zrsYabnsiUWLuN6z76hh1FPTIY=
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
 drivers/firmware/efi/libstub/efi-stub.c | 53 +----------------
 drivers/firmware/efi/libstub/efistub.h  |  7 +--
 drivers/firmware/efi/libstub/fdt.c      | 61 ++++++++++++++++++--
 3 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 7d53528613ce..e6179a89430b 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/libfdt.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -132,14 +131,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
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
 
@@ -215,38 +211,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
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
 
@@ -290,23 +254,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
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
index 84d3d4e25d46..e26f8625a2b5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -844,11 +844,8 @@ typedef efi_status_t (*efi_exit_boot_map_processing)(
 efi_status_t efi_exit_boot_services(void *handle, void *priv,
 				    efi_exit_boot_map_processing priv_func);
 
-efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
-					    unsigned long *new_fdt_addr,
-					    char *cmdline_ptr,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long kernel_addr, char *cmdline_ptr);
 
 void *get_fdt(unsigned long *fdt_size);
 
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 3c252346a425..dbea887b9956 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -220,17 +220,18 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
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
 	struct exit_boot_struct priv;
+	unsigned long fdt_addr = 0;
+	unsigned long fdt_size = 0;
 
 	if (!efi_novamap) {
 		status = efi_alloc_virtmap(&priv.runtime_map, &desc_size,
@@ -241,6 +242,36 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		}
 	}
 
+	/*
+	 * Unauthenticated device tree data is a security hazard, so ignore
+	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
+	 * boot is enabled if we can't determine its state.
+	 */
+	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
+	    efi_get_secureboot() != efi_secureboot_mode_disabled) {
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
@@ -304,11 +335,33 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
+	efi_free(fdt_size, fdt_addr);
+
 	efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
 
+efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
+			     unsigned long kernel_addr, char *cmdline_ptr)
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
+	efi_enter_kernel(kernel_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
+	/* not reached */
+}
+
 void *get_fdt(unsigned long *fdt_size)
 {
 	void *fdt;
-- 
2.35.1

