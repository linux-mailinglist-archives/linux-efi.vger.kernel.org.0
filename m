Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B395BC01C
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIRVgS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIRVgR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BC13FB7
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CF1612A3
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A846C433B5;
        Sun, 18 Sep 2022 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536974;
        bh=4IQCCp85/a9TbrSEYrwJOPa+sZS2yTCwU9hWVkII4gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqUgldACNBxS9W3H2oFaX5Gi6GbJUfFF/uYQGexaTEJVH4iQFkeweYRS0zdlZSdQ5
         /6bM6kDTiTRasmis1WjiXfAf/5TkEkrsCF7Wl5/XTm4DiLylElBDTzAWZiBYXXXtT/
         KR8MfnvEJq161LmzRkYkgQZOZwWNw+WgEaU6ehNlMGo7oeTV/JHDJ7E2vE/di9PWpI
         NIZEPEF4OlI9N55sz+UZ7yYBmoI3FiMWgzHb3xta9g8yeZawVc0opuFui5j92j0XKx
         2Gifu3zmcgkyU/0+YkTIiiGewbGEIEyqe7EnSWV7YHIVfiimk8Gj49PAsAJz+dPVqC
         MGVO/5ni9JHAQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 07/12] efi: libstub: unify initrd loading between architectures
Date:   Sun, 18 Sep 2022 23:35:39 +0200
Message-Id: <20220918213544.2176249-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16521; i=ardb@kernel.org; h=from:subject; bh=4IQCCp85/a9TbrSEYrwJOPa+sZS2yTCwU9hWVkII4gw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48mmt4RTTOmDpsKtlySDVyqEe18HipGQwZayROG Qw4eu2GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePJgAKCRDDTyI5ktmPJJWfC/ 4qMUPjfJpdpwYup2oxOH/XJIX9FLAjcLoRj210zSio7s+tWQrsjQSZQnKZ6k/LuZ6aIMMSfvFZgeVQ yidsFFrwQ9TjHnUYiQoUQmIJ3JVzIxrxMXENhdqTgBGpDYF2B9NTjjlkyCcmlwjaq7tdr3GwkHKNqp Fc4ul31aZuzNEX95C7oVCzS6GUF8MREWY0uuaveufoprxbi6uEGJeXDG8OS1yYykf83/csclBtOEm2 sPdwvXlot7hjr4TeUliHzhN7970TQMlzagWWjguTlrsTWqaF5zeHBSmWjw+ElsfpU9KTwhL4/h1jrB /xPNW4Ae50JWNzPouWPKCRSUZIsgsGWOebxdbjDRI1u69/mL5fgpBzDbIuZF1/i9IDaie388lBoYzY qfuhrYLzDvPzkmQNDau2g4UT4fRT8xOPRMaL1zDsM7fsJXmKvg9KZTTT23cgFNUmQ01vJtrpuZbRYP PRaOLMKBiOJcrTFro3Z9+iGHoeBJj/Zkn/XQOO6sF10x0=
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

Use a EFI configuration table to pass the initrd to the core kernel,
instead of per-arch methods. This cleans up the code considerably, and
should make it easier for architectures to get rid of their reliance on
DT for doing EFI boot in the future.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arm/uefi.rst                     |  4 --
 drivers/firmware/efi/efi.c                     | 15 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 64 ++++++++++----------
 drivers/firmware/efi/libstub/efi-stub.c        | 14 ++---
 drivers/firmware/efi/libstub/efistub.h         |  3 -
 drivers/firmware/efi/libstub/fdt.c             | 41 +++----------
 drivers/firmware/efi/libstub/x86-stub.c        | 10 +--
 include/linux/efi.h                            |  5 ++
 8 files changed, 67 insertions(+), 89 deletions(-)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index 9b0b5e458a1e..baebe688a006 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -65,10 +65,6 @@ linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in the UEFI
 
 linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
 
-linux,initrd-start          64-bit   Physical start address of an initrd
-
-linux,initrd-end            64-bit   Physical end address of an initrd
-
 kaslr-seed                  64-bit   Entropy used to randomize the kernel image
                                      base address location.
 ==========================  ======   ===========================================
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e4080ad96089..f0c776916b9c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/of.h>
+#include <linux/initrd.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/platform_device.h>
@@ -55,6 +56,7 @@ EXPORT_SYMBOL(efi);
 unsigned long __ro_after_init efi_rng_seed = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
+static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
 
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
@@ -532,6 +534,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_TPM_EVENT_LOG_GUID,		&efi.tpm_log,		"TPMEventLog"	},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID,		&efi.tpm_final_log,	"TPMFinalLog"	},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
+	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
@@ -674,6 +677,18 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    initrd != EFI_INVALID_TABLE_ADDR) {
+		struct linux_efi_initrd *tbl;
+
+		tbl = early_memremap(initrd, sizeof(*tbl));
+		if (tbl) {
+			phys_initrd_start = tbl->base;
+			phys_initrd_size = tbl->size;
+			early_memunmap(tbl, sizeof(*tbl));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e8af32377d75..742ecd9e0df3 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -559,20 +559,16 @@ static const struct {
  * * %EFI_SUCCESS if the initrd was loaded successfully, in which
  *   case @load_addr and @load_size are assigned accordingly
  * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
- * * %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
  * * %EFI_OUT_OF_RESOURCES if memory allocation failed
  * * %EFI_LOAD_ERROR in all other cases
  */
 static
-efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
-				      unsigned long *load_size,
+efi_status_t efi_load_initrd_dev_path(struct linux_efi_initrd *initrd,
 				      unsigned long max)
 {
 	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
 	efi_device_path_protocol_t *dp;
 	efi_load_file2_protocol_t *lf2;
-	unsigned long initrd_addr;
-	unsigned long initrd_size;
 	efi_handle_t handle;
 	efi_status_t status;
 
@@ -586,42 +582,39 @@ efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_proto(lf2, load_file, dp, false, &initrd_size, NULL);
+	initrd->size = 0;
+	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return EFI_LOAD_ERROR;
 
-	status = efi_allocate_pages(initrd_size, &initrd_addr, max);
+	status = efi_allocate_pages(initrd->size, &initrd->base, max);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_proto(lf2, load_file, dp, false, &initrd_size,
-				(void *)initrd_addr);
+	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size,
+				(void *)initrd->base);
 	if (status != EFI_SUCCESS) {
-		efi_free(initrd_size, initrd_addr);
+		efi_free(initrd->size, initrd->base);
 		return EFI_LOAD_ERROR;
 	}
-
-	*load_addr = initrd_addr;
-	*load_size = initrd_size;
 	return EFI_SUCCESS;
 }
 
 static
 efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
-				     unsigned long *load_addr,
-				     unsigned long *load_size,
+				     struct linux_efi_initrd *initrd,
 				     unsigned long soft_limit,
 				     unsigned long hard_limit)
 {
 	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
 	    (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
-		*load_addr = *load_size = 0;
+		initrd->size = 0;
 		return EFI_SUCCESS;
 	}
 
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
 				    soft_limit, hard_limit,
-				    load_addr, load_size);
+				    &initrd->base, &initrd->size);
 }
 
 static const struct {
@@ -645,7 +638,7 @@ static const struct {
 	{ "Linux initrd" },
 };
 
-static void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
+static void efi_measure_initrd(struct linux_efi_initrd *initrd)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_tcg2_protocol_t *tcg2 = NULL;
@@ -654,7 +647,7 @@ static void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
 	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
 	if (tcg2) {
 		status = efi_call_proto(tcg2, hash_log_extend_event,
-					0, load_addr, load_size,
+					0, initrd->base, initrd->size,
 					&initrd_tcg2_event.event_data);
 		if (status != EFI_SUCCESS)
 			efi_warn("Failed to measure initrd data: 0x%lx\n",
@@ -676,34 +669,39 @@ static void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
  * Return:	status code
  */
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
-			     unsigned long *load_addr,
-			     unsigned long *load_size,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit)
 {
-	efi_status_t status;
+	efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
+	efi_status_t status = EFI_SUCCESS;
+	struct linux_efi_initrd *initrd;
+
+	if (!efi_noinitrd) {
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+				     sizeof(*initrd), (void **)&initrd);
+		if (status != EFI_SUCCESS)
+			return status;
 
-	if (efi_noinitrd) {
-		*load_addr = *load_size = 0;
-		status = EFI_SUCCESS;
-	} else {
-		status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
+		status = efi_load_initrd_dev_path(initrd, hard_limit);
 		if (status == EFI_SUCCESS) {
 			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-			if (*load_size > 0)
-				efi_measure_initrd(*load_addr, *load_size);
+			if (initrd->size > 0)
+				efi_measure_initrd(initrd);
 		} else if (status == EFI_NOT_FOUND) {
-			status = efi_load_initrd_cmdline(image, load_addr, load_size,
+			status = efi_load_initrd_cmdline(image, initrd,
 							 soft_limit, hard_limit);
-			if (status == EFI_SUCCESS && *load_size > 0)
+			if (status == EFI_SUCCESS && initrd->size > 0)
 				efi_info("Loaded initrd from command line option\n");
 		}
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to load initrd: 0x%lx\n", status);
-			*load_addr = *load_size = 0;
+			efi_bs_call(free_pool, initrd);
+			return status;
 		}
-	}
 
+		status = efi_bs_call(install_configuration_table, &tbl_guid,
+				     initrd);
+	}
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 6d9ce2c89576..88bdd0a6b488 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -130,8 +130,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	unsigned long image_addr;
 	unsigned long image_size = 0;
 	/* addr/point and size pairs for memory management*/
-	unsigned long initrd_addr = 0;
-	unsigned long initrd_size = 0;
 	unsigned long fdt_addr = 0;  /* Original DTB */
 	unsigned long fdt_size = 0;
 	char *cmdline_ptr = NULL;
@@ -247,7 +245,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!fdt_addr)
 		efi_info("Generating empty DTB\n");
 
-	efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
+	efi_load_initrd(image, ULONG_MAX,
 			efi_get_max_initrd_addr(image_addr));
 
 	efi_random_get_seed();
@@ -290,11 +288,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	install_memreserve_table();
 
-	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						initrd_addr, initrd_size,
-						cmdline_ptr, fdt_addr, fdt_size);
+	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr, cmdline_ptr,
+						fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
-		goto fail_free_initrd;
+		goto fail_free_fdt;
 
 	if (IS_ENABLED(CONFIG_ARM))
 		efi_handle_post_ebs_state();
@@ -302,10 +299,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
 	/* not reached */
 
-fail_free_initrd:
+fail_free_fdt:
 	efi_err("Failed to update FDT and exit boot services\n");
 
-	efi_free(initrd_size, initrd_addr);
 	efi_free(fdt_size, fdt_addr);
 
 fail_free_image:
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2bd520b30192..82cff342da05 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -867,7 +867,6 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
 					    unsigned long fdt_size);
@@ -944,8 +943,6 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 }
 
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
-			     unsigned long *load_addr,
-			     unsigned long *load_size,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
 /*
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 91ca0c1597e5..a3cd603ea484 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -28,8 +28,7 @@ static void fdt_update_cell_size(void *fdt)
 }
 
 static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
-			       void *fdt, int new_fdt_size, char *cmdline_ptr,
-			       u64 initrd_addr, u64 initrd_size)
+			       void *fdt, int new_fdt_size, char *cmdline_ptr)
 {
 	int node, num_rsv;
 	int status;
@@ -93,21 +92,6 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 			goto fdt_set_fail;
 	}
 
-	/* Set initrd address/end in device tree, if present */
-	if (initrd_size != 0) {
-		u64 initrd_image_end;
-		u64 initrd_image_start = cpu_to_fdt64(initrd_addr);
-
-		status = fdt_setprop_var(fdt, node, "linux,initrd-start", initrd_image_start);
-		if (status)
-			goto fdt_set_fail;
-
-		initrd_image_end = cpu_to_fdt64(initrd_addr + initrd_size);
-		status = fdt_setprop_var(fdt, node, "linux,initrd-end", initrd_image_end);
-		if (status)
-			goto fdt_set_fail;
-	}
-
 	/* Add FDT entries for EFI runtime services in chosen node. */
 	node = fdt_subnode_offset(fdt, 0, "chosen");
 	fdt_val64 = cpu_to_fdt64((u64)(unsigned long)efi_system_table);
@@ -226,22 +210,18 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 #endif
 
 /*
- * Allocate memory for a new FDT, then add EFI, commandline, and
- * initrd related fields to the FDT.  This routine increases the
- * FDT allocation size until the allocated memory is large
- * enough.  EFI allocations are in EFI_PAGE_SIZE granules,
- * which are fixed at 4K bytes, so in most cases the first
- * allocation should succeed.
- * EFI boot services are exited at the end of this function.
- * There must be no allocations between the get_memory_map()
- * call and the exit_boot_services() call, so the exiting of
- * boot services is very tightly tied to the creation of the FDT
- * with the final memory map in it.
+ * Allocate memory for a new FDT, then add EFI and commandline related fields
+ * to the FDT.  This routine increases the FDT allocation size until the
+ * allocated memory is large enough.  EFI allocations are in EFI_PAGE_SIZE
+ * granules, which are fixed at 4K bytes, so in most cases the first allocation
+ * should succeed.  EFI boot services are exited at the end of this function.
+ * There must be no allocations between the get_memory_map() call and the
+ * exit_boot_services() call, so the exiting of boot services is very tightly
+ * tied to the creation of the FDT with the final memory map in it.
  */
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
 					    unsigned long fdt_size)
@@ -266,8 +246,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	}
 
 	status = update_fdt((void *)fdt_addr, fdt_size,
-			    (void *)*new_fdt_addr, MAX_FDT_SIZE, cmdline_ptr,
-			    initrd_addr, initrd_size);
+			    (void *)*new_fdt_addr, MAX_FDT_SIZE, cmdline_ptr);
 
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to construct new device tree.\n");
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1ae1e7e576b9..8c67aa69fb7a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -766,7 +766,6 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
-	unsigned long addr, size;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -861,16 +860,9 @@ unsigned long efi_main(efi_handle_t handle,
 	 * arguments will be processed only if image is not NULL, which will be
 	 * the case only if we were loaded via the PE entry point.
 	 */
-	status = efi_load_initrd(image, &addr, &size, hdr->initrd_addr_max,
-				 ULONG_MAX);
+	status = efi_load_initrd(image, hdr->initrd_addr_max, ULONG_MAX);
 	if (status != EFI_SUCCESS)
 		goto fail;
-	if (size > 0) {
-		efi_set_u64_split(addr, &hdr->ramdisk_image,
-				  &boot_params->ext_ramdisk_image);
-		efi_set_u64_split(size, &hdr->ramdisk_size,
-				  &boot_params->ext_ramdisk_size);
-	}
 
 	/*
 	 * If the boot loader gave us a value for secure_boot then we use that,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6ad8eda0de7d..8668d9769bb0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1343,6 +1343,11 @@ struct linux_efi_coco_secret_area {
 	u64	size;
 };
 
+struct linux_efi_initrd {
+	unsigned long	base;
+	unsigned long	size;
+};
+
 /* Header of a populated EFI secret area */
 #define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
 
-- 
2.35.1

