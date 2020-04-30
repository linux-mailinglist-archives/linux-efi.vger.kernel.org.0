Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5101C04C7
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD3S2u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33058 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3S2t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id v26so5909543qto.0;
        Thu, 30 Apr 2020 11:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtSkP+lLnfNckGLmjU18hHHM2xlkiWr1pDCWnLqRuL4=;
        b=hWva9FED8T8iA7I29Vv4SK12Hj8raTUcPKHtHjKCVsxUcM8X3rgXKiaLQWRirzIf2L
         VXYBwYXUCKXqvAFaukBGCtDboODnGxIJOkFO15KZvIXs3xXPqS2Qcblugty2IMZyVNHR
         l2hnkZxdms7amMsxsoieUVB9ZlxtK4hRPHJH1ITdG44GpIEduEQ9HVTug4if3EVwZSSO
         8vLy1yZYYt51+K95bl/Guz2i6dE8Efv/YEaEescpAYuuDX3xlzabSBZEBNV2gAod93/1
         rUAR4d9v/t5iW1+uIne9/rGFMBZ3jzoyGANk+iiMtWlBwsR0awfWjApxF6Y/vHBwHz1h
         gOgg==
X-Gm-Message-State: AGi0PuahVRSopVrMu1hgkBvcglvFlT/0MdwX97fh0RONWoApbXgFkZ+J
        C+pYix3wIHXK2Ffg1AviVM8CjPvhwCo=
X-Google-Smtp-Source: APiQypKH8Mu0ebdFPzajm9O3L4acwtyA6uzlwRVX6YGxRTjrcGvg2YmwVbg7jp+PTDElGJMi9fI7XQ==
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr5181602qtb.271.1588271327605;
        Thu, 30 Apr 2020 11:28:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:47 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 03/11] efi/libstub: Move pr_efi/pr_efi_err into efi namespace
Date:   Thu, 30 Apr 2020 14:28:35 -0400
Message-Id: <20200430182843.2510180-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename pr_efi to efi_info and pr_efi_err to efi_err to make it more
obvious that they are part of the EFI stub and not generic printk infra.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/firmware/efi/libstub/arm32-stub.c | 12 ++++-----
 drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++-----
 drivers/firmware/efi/libstub/efi-stub.c   | 32 +++++++++++------------
 drivers/firmware/efi/libstub/efistub.h    |  4 +--
 drivers/firmware/efi/libstub/fdt.c        | 16 ++++++------
 drivers/firmware/efi/libstub/file.c       | 12 ++++-----
 drivers/firmware/efi/libstub/pci.c        |  8 +++---
 drivers/firmware/efi/libstub/relocate.c   |  2 +-
 drivers/firmware/efi/libstub/secureboot.c |  4 +--
 9 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 7826553af2ba..b038afe2ee7a 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -18,7 +18,7 @@ efi_status_t check_platform_features(void)
 	/* LPAE kernels need compatible hardware */
 	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
 	if (block < 5) {
-		pr_efi_err("This LPAE kernel is not supported by your CPU\n");
+		efi_err("This LPAE kernel is not supported by your CPU\n");
 		return EFI_UNSUPPORTED;
 	}
 	return EFI_SUCCESS;
@@ -120,7 +120,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 	 */
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
+		efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
 		return status;
 	}
 
@@ -162,7 +162,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 					     (end - start) / EFI_PAGE_SIZE,
 					     &start);
 			if (status != EFI_SUCCESS) {
-				pr_efi_err("reserve_kernel_base(): alloc failed.\n");
+				efi_err("reserve_kernel_base(): alloc failed.\n");
 				goto out;
 			}
 			break;
@@ -219,7 +219,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	status = reserve_kernel_base(kernel_base, reserve_addr, reserve_size);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Unable to allocate memory for uncompressed kernel.\n");
+		efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
 	}
 
@@ -232,7 +232,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	status = efi_relocate_kernel(image_addr, *image_size, *image_size,
 				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to relocate kernel.\n");
+		efi_err("Failed to relocate kernel.\n");
 		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		return status;
@@ -244,7 +244,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * address at which the zImage is loaded.
 	 */
 	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
-		pr_efi_err("Failed to relocate kernel, no low memory available.\n");
+		efi_err("Failed to relocate kernel, no low memory available.\n");
 		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		efi_free(*image_size, *image_addr);
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index ba4db35015a3..7f6a57dec513 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -26,9 +26,9 @@ efi_status_t check_platform_features(void)
 	tg = (read_cpuid(ID_AA64MMFR0_EL1) >> ID_AA64MMFR0_TGRAN_SHIFT) & 0xf;
 	if (tg != ID_AA64MMFR0_TGRAN_SUPPORTED) {
 		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-			pr_efi_err("This 64 KB granular kernel is not supported by your CPU\n");
+			efi_err("This 64 KB granular kernel is not supported by your CPU\n");
 		else
-			pr_efi_err("This 16 KB granular kernel is not supported by your CPU\n");
+			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
 		return EFI_UNSUPPORTED;
 	}
 	return EFI_SUCCESS;
@@ -59,18 +59,18 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				pr_efi("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
+				efi_info("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
 			} else if (status != EFI_SUCCESS) {
-				pr_efi_err("efi_get_random_bytes() failed\n");
+				efi_err("efi_get_random_bytes() failed\n");
 				return status;
 			}
 		} else {
-			pr_efi("KASLR disabled on kernel command line\n");
+			efi_info("KASLR disabled on kernel command line\n");
 		}
 	}
 
 	if (image->image_base != _text)
-		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
+		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
 
 	kernel_size = _edata - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
@@ -102,7 +102,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 						    ULONG_MAX, min_kimg_align);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err("Failed to relocate kernel\n");
+			efi_err("Failed to relocate kernel\n");
 			*reserve_size = 0;
 			return status;
 		}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index ee225b323687..72ffd2670f99 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -69,7 +69,7 @@ static void install_memreserve_table(void)
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 			     (void **)&rsv);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to allocate memreserve entry!\n");
+		efi_err("Failed to allocate memreserve entry!\n");
 		return;
 	}
 
@@ -80,7 +80,7 @@ static void install_memreserve_table(void)
 	status = efi_bs_call(install_configuration_table,
 			     &memreserve_table_guid, rsv);
 	if (status != EFI_SUCCESS)
-		pr_efi_err("Failed to install memreserve config table!\n");
+		efi_err("Failed to install memreserve config table!\n");
 }
 
 static unsigned long get_dram_base(void)
@@ -182,13 +182,13 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	status = efi_system_table->boottime->handle_protocol(handle,
 					&loaded_image_proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to get loaded image protocol\n");
+		efi_err("Failed to get loaded image protocol\n");
 		goto fail;
 	}
 
 	dram_base = get_dram_base();
 	if (dram_base == EFI_ERROR) {
-		pr_efi_err("Failed to find DRAM base\n");
+		efi_err("Failed to find DRAM base\n");
 		status = EFI_LOAD_ERROR;
 		goto fail;
 	}
@@ -200,7 +200,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	 */
 	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size, ULONG_MAX);
 	if (!cmdline_ptr) {
-		pr_efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
+		efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		status = EFI_OUT_OF_RESOURCES;
 		goto fail;
 	}
@@ -213,7 +213,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
 		efi_parse_options(cmdline_ptr);
 
-	pr_efi("Booting Linux Kernel...\n");
+	efi_info("Booting Linux Kernel...\n");
 
 	si = setup_graphics();
 
@@ -222,7 +222,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 				     &reserve_size,
 				     dram_base, image);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to relocate kernel\n");
+		efi_err("Failed to relocate kernel\n");
 		goto fail_free_cmdline;
 	}
 
@@ -241,42 +241,42 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
 	     secure_boot != efi_secureboot_mode_disabled) {
 		if (strstr(cmdline_ptr, "dtb="))
-			pr_efi("Ignoring DTB from command line.\n");
+			efi_info("Ignoring DTB from command line.\n");
 	} else {
 		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err("Failed to load device tree!\n");
+			efi_err("Failed to load device tree!\n");
 			goto fail_free_image;
 		}
 	}
 
 	if (fdt_addr) {
-		pr_efi("Using DTB from command line\n");
+		efi_info("Using DTB from command line\n");
 	} else {
 		/* Look for a device tree configuration table entry. */
 		fdt_addr = (uintptr_t)get_fdt(&fdt_size);
 		if (fdt_addr)
-			pr_efi("Using DTB from configuration table\n");
+			efi_info("Using DTB from configuration table\n");
 	}
 
 	if (!fdt_addr)
-		pr_efi("Generating empty DTB\n");
+		efi_info("Generating empty DTB\n");
 
 	if (!efi_noinitrd) {
 		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
 		status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size,
 						  max_addr);
 		if (status == EFI_SUCCESS) {
-			pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
 		} else if (status == EFI_NOT_FOUND) {
 			status = efi_load_initrd(image, &initrd_addr, &initrd_size,
 						 ULONG_MAX, max_addr);
 			if (status == EFI_SUCCESS && initrd_size > 0)
-				pr_efi("Loaded initrd from command line option\n");
+				efi_info("Loaded initrd from command line option\n");
 		}
 		if (status != EFI_SUCCESS)
-			pr_efi_err("Failed to load initrd!\n");
+			efi_err("Failed to load initrd!\n");
 	}
 
 	efi_random_get_seed();
@@ -326,7 +326,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	/* not reached */
 
 fail_free_initrd:
-	pr_efi_err("Failed to update FDT and exit boot services\n");
+	efi_err("Failed to update FDT and exit boot services\n");
 
 	efi_free(initrd_size, initrd_addr);
 	efi_free(fdt_size, fdt_addr);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e8aa70ba08d5..8c905a1be1b4 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -49,11 +49,11 @@ extern const efi_system_table_t *efi_system_table;
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 #endif
 
-#define pr_efi(msg)		do {			\
+#define efi_info(msg)		do {			\
 	if (!efi_quiet) efi_printk("EFI stub: "msg);	\
 } while (0)
 
-#define pr_efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
+#define efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 3074a5e27c65..11ecf3c4640e 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -39,7 +39,7 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 	/* Do some checks on provided FDT, if it exists: */
 	if (orig_fdt) {
 		if (fdt_check_header(orig_fdt)) {
-			pr_efi_err("Device Tree header not valid!\n");
+			efi_err("Device Tree header not valid!\n");
 			return EFI_LOAD_ERROR;
 		}
 		/*
@@ -47,7 +47,7 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 		 * configuration table:
 		 */
 		if (orig_fdt_size && fdt_totalsize(orig_fdt) > orig_fdt_size) {
-			pr_efi_err("Truncated device tree! foo!\n");
+			efi_err("Truncated device tree! foo!\n");
 			return EFI_LOAD_ERROR;
 		}
 	}
@@ -270,16 +270,16 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	 */
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Unable to retrieve UEFI memory map.\n");
+		efi_err("Unable to retrieve UEFI memory map.\n");
 		return status;
 	}
 
-	pr_efi("Exiting boot services and installing virtual address map...\n");
+	efi_info("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Unable to allocate memory for new device tree.\n");
+		efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
 	}
 
@@ -296,7 +296,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 			    initrd_addr, initrd_size);
 
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Unable to construct new device tree.\n");
+		efi_err("Unable to construct new device tree.\n");
 		goto fail_free_new_fdt;
 	}
 
@@ -342,7 +342,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return EFI_SUCCESS;
 	}
 
-	pr_efi_err("Exit boot services failed.\n");
+	efi_err("Exit boot services failed.\n");
 
 fail_free_new_fdt:
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
@@ -363,7 +363,7 @@ void *get_fdt(unsigned long *fdt_size)
 		return NULL;
 
 	if (fdt_check_header(fdt) != 0) {
-		pr_efi_err("Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+		efi_err("Invalid header detected on UEFI supplied FDT, ignoring ...\n");
 		return NULL;
 	}
 	*fdt_size = fdt_totalsize(fdt);
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 50aaf15f9ad5..cc177152d0df 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -46,7 +46,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 
 	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to open file: ");
+		efi_err("Failed to open file: ");
 		efi_char16_printk(fi->filename);
 		efi_printk("\n");
 		return status;
@@ -55,7 +55,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	info_sz = sizeof(struct finfo);
 	status = fh->get_info(fh, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to get file info\n");
+		efi_err("Failed to get file info\n");
 		fh->close(fh);
 		return status;
 	}
@@ -75,13 +75,13 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 	status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
 			     (void **)&io);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to handle fs_proto\n");
+		efi_err("Failed to handle fs_proto\n");
 		return status;
 	}
 
 	status = io->open_volume(io, fh);
 	if (status != EFI_SUCCESS)
-		pr_efi_err("Failed to open volume\n");
+		efi_err("Failed to open volume\n");
 
 	return status;
 }
@@ -191,7 +191,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 							    &alloc_addr,
 							    hard_limit);
 			if (status != EFI_SUCCESS) {
-				pr_efi_err("Failed to allocate memory for files\n");
+				efi_err("Failed to allocate memory for files\n");
 				goto err_close_file;
 			}
 
@@ -215,7 +215,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 			status = file->read(file, &chunksize, addr);
 			if (status != EFI_SUCCESS) {
-				pr_efi_err("Failed to read file\n");
+				efi_err("Failed to read file\n");
 				goto err_close_file;
 			}
 			addr += chunksize;
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index b025e59b94df..60af51bed573 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -28,21 +28,21 @@ void efi_pci_disable_bridge_busmaster(void)
 
 	if (status != EFI_BUFFER_TOO_SMALL) {
 		if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-			pr_efi_err("Failed to locate PCI I/O handles'\n");
+			efi_err("Failed to locate PCI I/O handles'\n");
 		return;
 	}
 
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, pci_handle_size,
 			     (void **)&pci_handle);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to allocate memory for 'pci_handle'\n");
+		efi_err("Failed to allocate memory for 'pci_handle'\n");
 		return;
 	}
 
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
 			     NULL, &pci_handle_size, pci_handle);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to locate PCI I/O handles'\n");
+		efi_err("Failed to locate PCI I/O handles'\n");
 		goto free_handle;
 	}
 
@@ -106,7 +106,7 @@ void efi_pci_disable_bridge_busmaster(void)
 		status = efi_call_proto(pci, pci.write, EfiPciIoWidthUint16,
 					PCI_COMMAND, 1, &command);
 		if (status != EFI_SUCCESS)
-			pr_efi_err("Failed to disable PCI busmastering\n");
+			efi_err("Failed to disable PCI busmastering\n");
 	}
 
 free_handle:
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 1507d3c82884..93c04d6aaed1 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -157,7 +157,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 					     min_addr);
 	}
 	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to allocate usable memory for kernel.\n");
+		efi_err("Failed to allocate usable memory for kernel.\n");
 		return status;
 	}
 
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index a765378ad18c..5efc524b14be 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -67,10 +67,10 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 		return efi_secureboot_mode_disabled;
 
 secure_boot_enabled:
-	pr_efi("UEFI Secure Boot is enabled.\n");
+	efi_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
 
 out_efi_err:
-	pr_efi_err("Could not determine UEFI Secure Boot status.\n");
+	efi_err("Could not determine UEFI Secure Boot status.\n");
 	return efi_secureboot_mode_unknown;
 }
-- 
2.26.2

