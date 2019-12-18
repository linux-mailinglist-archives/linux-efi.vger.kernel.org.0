Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76111124EB4
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfLRRDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRRDP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:15 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2817824650;
        Wed, 18 Dec 2019 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688593;
        bh=o+8yPMufRC5rH8kPkD4IGmTVMSSYMGYSBukroCMTXZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxYsTkPioPIpN9jN8XBK5mr8MdDALf9qViduAPBLHMqlQnywZ2kYTgHOKAtcGA7mJ
         qIC/DuojY1iJhI7wvWB1+BksZPFsCtHl0zzabW/lzgRP3sOGAhXWi9Mkc2F0/ivK/i
         gJ1hqpK9ES6CjJk92dLMfx2n7o0+1XUYaISDmCTs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 15/21] efi/libstub: remove 'sys_table_arg' from all function prototypes
Date:   Wed, 18 Dec 2019 19:01:33 +0200
Message-Id: <20191218170139.9468-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We have a helper efi_system_table() that gives us the address of the
EFI system table in memory, so there is no longer point in passing
it around from each function to the next.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                     |  4 +-
 arch/arm64/include/asm/efi.h                   |  3 +-
 arch/x86/boot/compressed/eboot.c               | 40 +++++------
 drivers/firmware/efi/libstub/arm-stub.c        | 55 +++++++--------
 drivers/firmware/efi/libstub/arm32-stub.c      | 26 +++----
 drivers/firmware/efi/libstub/arm64-stub.c      | 12 ++--
 drivers/firmware/efi/libstub/efi-stub-helper.c | 74 +++++++++-----------
 drivers/firmware/efi/libstub/efistub.h         | 17 ++---
 drivers/firmware/efi/libstub/fdt.c             | 37 +++++-----
 drivers/firmware/efi/libstub/gop.c             | 10 ++-
 drivers/firmware/efi/libstub/random.c          | 10 ++-
 drivers/firmware/efi/libstub/secureboot.c      |  2 +-
 drivers/firmware/efi/libstub/tpm.c             |  5 +-
 include/linux/efi.h                            | 43 +++++-------
 14 files changed, 147 insertions(+), 191 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 555364b7bd2a..58e5acc424a0 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -60,8 +60,8 @@ void efi_virtmap_unload(void);
 #define efi_call_proto(protocol, f, instance, ...)			\
 	instance->f(instance, ##__VA_ARGS__)
 
-struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg);
-void free_screen_info(efi_system_table_t *sys_table, struct screen_info *si);
+struct screen_info *alloc_screen_info(void);
+void free_screen_info(struct screen_info *si);
 
 static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 {
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 9aa518d67588..d73693177f31 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -105,8 +105,7 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 
 #define alloc_screen_info(x...)		&screen_info
 
-static inline void free_screen_info(efi_system_table_t *sys_table_arg,
-				    struct screen_info *si)
+static inline void free_screen_info(struct screen_info *si)
 {
 }
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 92fbd455f496..b4e859399451 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -347,7 +347,7 @@ void setup_graphics(struct boot_params *boot_params)
 				EFI_LOCATE_BY_PROTOCOL,
 				&graphics_proto, NULL, &size, gop_handle);
 	if (status == EFI_BUFFER_TOO_SMALL)
-		status = efi_setup_gop(NULL, si, &graphics_proto, size);
+		status = efi_setup_gop(si, &graphics_proto, size);
 
 	if (status != EFI_SUCCESS) {
 		size = 0;
@@ -396,8 +396,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 		return NULL;
 	}
 
-	status = efi_low_alloc(sys_table, 0x4000, 1,
-			       (unsigned long *)&boot_params);
+	status = efi_low_alloc(0x4000, 1, (unsigned long *)&boot_params);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		return NULL;
@@ -422,7 +421,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(sys_table, image, &options_size);
+	cmdline_ptr = efi_convert_cmdline(image, &options_size);
 	if (!cmdline_ptr)
 		goto fail;
 
@@ -440,7 +439,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	if (status != EFI_SUCCESS)
 		goto fail2;
 
-	status = handle_cmdline_files(sys_table, image,
+	status = handle_cmdline_files(image,
 				      (char *)(unsigned long)hdr->cmd_line_ptr,
 				      "initrd=", hdr->initrd_addr_max,
 				      &ramdisk_addr, &ramdisk_size);
@@ -448,7 +447,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	if (status != EFI_SUCCESS &&
 	    hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G) {
 		efi_printk("Trying to load files to higher address\n");
-		status = handle_cmdline_files(sys_table, image,
+		status = handle_cmdline_files(image,
 				      (char *)(unsigned long)hdr->cmd_line_ptr,
 				      "initrd=", -1UL,
 				      &ramdisk_addr, &ramdisk_size);
@@ -464,9 +463,9 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	return boot_params;
 
 fail2:
-	efi_free(sys_table, options_size, hdr->cmd_line_ptr);
+	efi_free(options_size, hdr->cmd_line_ptr);
 fail:
-	efi_free(sys_table, 0x4000, (unsigned long)boot_params);
+	efi_free(0x4000, (unsigned long)boot_params);
 
 	return NULL;
 }
@@ -633,7 +632,7 @@ static efi_status_t allocate_e820(struct boot_params *params,
 	boot_map.key_ptr	= NULL;
 	boot_map.buff_size	= &buff_size;
 
-	status = efi_get_memory_map(sys_table, &boot_map);
+	status = efi_get_memory_map(&boot_map);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -655,8 +654,7 @@ struct exit_boot_struct {
 	struct efi_info		*efi;
 };
 
-static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
-				   struct efi_boot_memmap *map,
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   void *priv)
 {
 	const char *signature;
@@ -666,14 +664,14 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
-	p->efi->efi_systab		= (unsigned long)sys_table_arg;
+	p->efi->efi_systab		= (unsigned long)efi_system_table();
 	p->efi->efi_memdesc_size	= *map->desc_size;
 	p->efi->efi_memdesc_version	= *map->desc_ver;
 	p->efi->efi_memmap		= (unsigned long)*map->map;
 	p->efi->efi_memmap_size		= *map->map_size;
 
 #ifdef CONFIG_X86_64
-	p->efi->efi_systab_hi		= (unsigned long)sys_table_arg >> 32;
+	p->efi->efi_systab_hi		= (unsigned long)efi_system_table() >> 32;
 	p->efi->efi_memmap_hi		= (unsigned long)*map->map >> 32;
 #endif
 
@@ -705,8 +703,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 		return status;
 
 	/* Might as well exit boot services now */
-	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
-					exit_boot_func);
+	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -759,14 +756,14 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	 * otherwise we ask the BIOS.
 	 */
 	if (boot_params->secure_boot == efi_secureboot_mode_unset)
-		boot_params->secure_boot = efi_get_secureboot(sys_table);
+		boot_params->secure_boot = efi_get_secureboot();
 
 	/* Ask the firmware to clear memory on unclean shutdown */
-	efi_enable_reset_attack_mitigation(sys_table);
+	efi_enable_reset_attack_mitigation();
 
-	efi_random_get_seed(sys_table);
+	efi_random_get_seed();
 
-	efi_retrieve_tpm2_eventlog(sys_table);
+	efi_retrieve_tpm2_eventlog();
 
 	setup_graphics(boot_params);
 
@@ -782,8 +779,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	}
 
 	gdt->size = 0x800;
-	status = efi_low_alloc(sys_table, gdt->size, 8,
-			   (unsigned long *)&gdt->address);
+	status = efi_low_alloc(gdt->size, 8, (unsigned long *)&gdt->address);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate memory for 'gdt'\n");
 		goto fail;
@@ -795,7 +791,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	 */
 	if (hdr->pref_address != hdr->code32_start) {
 		unsigned long bzimage_addr = hdr->code32_start;
-		status = efi_relocate_kernel(sys_table, &bzimage_addr,
+		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
 					     hdr->kernel_alignment,
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 2ed4bd457e66..e1ec0b2cde29 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -44,7 +44,7 @@ __pure efi_system_table_t *efi_system_table(void)
 	return sys_table;
 }
 
-static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
+static struct screen_info *setup_graphics(void)
 {
 	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
 	efi_status_t status;
@@ -56,15 +56,15 @@ static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
 	status = efi_call_early(locate_handle, EFI_LOCATE_BY_PROTOCOL,
 				&gop_proto, NULL, &size, gop_handle);
 	if (status == EFI_BUFFER_TOO_SMALL) {
-		si = alloc_screen_info(sys_table_arg);
+		si = alloc_screen_info();
 		if (!si)
 			return NULL;
-		efi_setup_gop(sys_table_arg, si, &gop_proto, size);
+		efi_setup_gop(si, &gop_proto, size);
 	}
 	return si;
 }
 
-void install_memreserve_table(efi_system_table_t *sys_table_arg)
+void install_memreserve_table(void)
 {
 	struct linux_efi_memreserve *rsv;
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
@@ -95,8 +95,7 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
  * must be reserved. On failure it is required to free all
  * all allocations it has made.
  */
-efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
-				 unsigned long *image_addr,
+efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
@@ -135,7 +134,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	status = check_platform_features(sys_table);
+	status = check_platform_features();
 	if (status != EFI_SUCCESS)
 		goto fail;
 
@@ -151,7 +150,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 		goto fail;
 	}
 
-	dram_base = get_dram_base(sys_table);
+	dram_base = get_dram_base();
 	if (dram_base == EFI_ERROR) {
 		pr_efi_err("Failed to find DRAM base\n");
 		goto fail;
@@ -162,7 +161,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	 * protocol. We are going to copy the command line into the
 	 * device tree, so this can be allocated anywhere.
 	 */
-	cmdline_ptr = efi_convert_cmdline(sys_table, image, &cmdline_size);
+	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size);
 	if (!cmdline_ptr) {
 		pr_efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		goto fail;
@@ -178,9 +177,9 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 
 	pr_efi("Booting Linux Kernel...\n");
 
-	si = setup_graphics(sys_table);
+	si = setup_graphics();
 
-	status = handle_kernel_image(sys_table, image_addr, &image_size,
+	status = handle_kernel_image(image_addr, &image_size,
 				     &reserve_addr,
 				     &reserve_size,
 				     dram_base, image);
@@ -189,12 +188,12 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 		goto fail_free_cmdline;
 	}
 
-	efi_retrieve_tpm2_eventlog(sys_table);
+	efi_retrieve_tpm2_eventlog();
 
 	/* Ask the firmware to clear memory on unclean shutdown */
-	efi_enable_reset_attack_mitigation(sys_table);
+	efi_enable_reset_attack_mitigation();
 
-	secure_boot = efi_get_secureboot(sys_table);
+	secure_boot = efi_get_secureboot();
 
 	/*
 	 * Unauthenticated device tree data is a security hazard, so ignore
@@ -206,8 +205,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 		if (strstr(cmdline_ptr, "dtb="))
 			pr_efi("Ignoring DTB from command line.\n");
 	} else {
-		status = handle_cmdline_files(sys_table, image, cmdline_ptr,
-					      "dtb=",
+		status = handle_cmdline_files(image, cmdline_ptr, "dtb=",
 					      ~0UL, &fdt_addr, &fdt_size);
 
 		if (status != EFI_SUCCESS) {
@@ -220,7 +218,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 		pr_efi("Using DTB from command line\n");
 	} else {
 		/* Look for a device tree configuration table entry. */
-		fdt_addr = (uintptr_t)get_fdt(sys_table, &fdt_size);
+		fdt_addr = (uintptr_t)get_fdt(&fdt_size);
 		if (fdt_addr)
 			pr_efi("Using DTB from configuration table\n");
 	}
@@ -228,7 +226,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	status = handle_cmdline_files(sys_table, image, cmdline_ptr, "initrd=",
+	status = handle_cmdline_files(image, cmdline_ptr, "initrd=",
 				      efi_get_max_initrd_addr(dram_base,
 							      *image_addr),
 				      (unsigned long *)&initrd_addr,
@@ -236,7 +234,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		pr_efi_err("Failed initrd from command line!\n");
 
-	efi_random_get_seed(sys_table);
+	efi_random_get_seed();
 
 	/* hibernation expects the runtime regions to stay in the same place */
 	if (!IS_ENABLED(CONFIG_HIBERNATION) && !nokaslr()) {
@@ -251,18 +249,17 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 					    EFI_RT_VIRTUAL_SIZE;
 		u32 rnd;
 
-		status = efi_get_random_bytes(sys_table, sizeof(rnd),
-					      (u8 *)&rnd);
+		status = efi_get_random_bytes(sizeof(rnd), (u8 *)&rnd);
 		if (status == EFI_SUCCESS) {
 			virtmap_base = EFI_RT_VIRTUAL_BASE +
 				       (((headroom >> 21) * rnd) >> (32 - 21));
 		}
 	}
 
-	install_memreserve_table(sys_table);
+	install_memreserve_table();
 
 	new_fdt_addr = fdt_addr;
-	status = allocate_new_fdt_and_exit_boot(sys_table, handle,
+	status = allocate_new_fdt_and_exit_boot(handle,
 				&new_fdt_addr, efi_get_max_fdt_addr(dram_base),
 				initrd_addr, initrd_size, cmdline_ptr,
 				fdt_addr, fdt_size);
@@ -277,15 +274,15 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 
 	pr_efi_err("Failed to update FDT and exit boot services\n");
 
-	efi_free(sys_table, initrd_size, initrd_addr);
-	efi_free(sys_table, fdt_size, fdt_addr);
+	efi_free(initrd_size, initrd_addr);
+	efi_free(fdt_size, fdt_addr);
 
 fail_free_image:
-	efi_free(sys_table, image_size, *image_addr);
-	efi_free(sys_table, reserve_size, reserve_addr);
+	efi_free(image_size, *image_addr);
+	efi_free(reserve_size, reserve_addr);
 fail_free_cmdline:
-	free_screen_info(sys_table, si);
-	efi_free(sys_table, cmdline_size, (unsigned long)cmdline_ptr);
+	free_screen_info(si);
+	efi_free(cmdline_size, (unsigned long)cmdline_ptr);
 fail:
 	return EFI_ERROR;
 }
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 7b5c717ddfac..e7a38d912749 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -7,7 +7,7 @@
 
 #include "efistub.h"
 
-efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
+efi_status_t check_platform_features(void)
 {
 	int block;
 
@@ -26,7 +26,7 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
 
 static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
 
-struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg)
+struct screen_info *alloc_screen_info(void)
 {
 	struct screen_info *si;
 	efi_status_t status;
@@ -52,7 +52,7 @@ struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg)
 	return NULL;
 }
 
-void free_screen_info(efi_system_table_t *sys_table_arg, struct screen_info *si)
+void free_screen_info(struct screen_info *si)
 {
 	if (!si)
 		return;
@@ -61,8 +61,7 @@ void free_screen_info(efi_system_table_t *sys_table_arg, struct screen_info *si)
 	efi_call_early(free_pool, si);
 }
 
-static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
-					unsigned long dram_base,
+static efi_status_t reserve_kernel_base(unsigned long dram_base,
 					unsigned long *reserve_addr,
 					unsigned long *reserve_size)
 {
@@ -119,7 +118,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 	 * released to the OS after ExitBootServices(), the decompressor can
 	 * safely overwrite them.
 	 */
-	status = efi_get_memory_map(sys_table_arg, &map);
+	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
 		return status;
@@ -190,8 +189,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
-efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
-				 unsigned long *image_addr,
+efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
@@ -219,8 +217,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 */
 	kernel_base += TEXT_OFFSET - 5 * PAGE_SIZE;
 
-	status = reserve_kernel_base(sys_table, kernel_base, reserve_addr,
-				     reserve_size);
+	status = reserve_kernel_base(kernel_base, reserve_addr, reserve_size);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
@@ -231,12 +228,11 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 * memory window.
 	 */
 	*image_size = image->image_size;
-	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
-				     *image_size,
+	status = efi_relocate_kernel(image_addr, *image_size, *image_size,
 				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to relocate kernel.\n");
-		efi_free(sys_table, *reserve_size, *reserve_addr);
+		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		return status;
 	}
@@ -248,9 +244,9 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 */
 	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
 		pr_efi_err("Failed to relocate kernel, no low memory available.\n");
-		efi_free(sys_table, *reserve_size, *reserve_addr);
+		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
-		efi_free(sys_table, *image_size, *image_addr);
+		efi_free(*image_size, *image_addr);
 		*image_size = 0;
 		return EFI_LOAD_ERROR;
 	}
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b09dda600c78..beba45e478c7 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -21,7 +21,7 @@
 
 #include "efistub.h"
 
-efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
+efi_status_t check_platform_features(void)
 {
 	u64 tg;
 
@@ -40,8 +40,7 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
 	return EFI_SUCCESS;
 }
 
-efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
-				 unsigned long *image_addr,
+efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
@@ -56,8 +55,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		if (!nokaslr()) {
-			status = efi_get_random_bytes(sys_table_arg,
-						      sizeof(phys_seed),
+			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
 				pr_efi("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
@@ -108,7 +106,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
 		*reserve_size = kernel_memsize + offset;
-		status = efi_random_alloc(sys_table_arg, *reserve_size,
+		status = efi_random_alloc(*reserve_size,
 					  MIN_KIMG_ALIGN, reserve_addr,
 					  (u32)phys_seed);
 
@@ -139,7 +137,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 
 	if (status != EFI_SUCCESS) {
 		*reserve_size = kernel_memsize + TEXT_OFFSET;
-		status = efi_low_alloc(sys_table_arg, *reserve_size,
+		status = efi_low_alloc(*reserve_size,
 				       MIN_KIMG_ALIGN, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index ebe792f2ed27..2ddeb312e8e5 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -84,8 +84,7 @@ static inline bool mmap_has_headroom(unsigned long buff_size,
 	return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
 }
 
-efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
-				struct efi_boot_memmap *map)
+efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 {
 	efi_memory_desc_t *m = NULL;
 	efi_status_t status;
@@ -135,7 +134,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 }
 
 
-unsigned long get_dram_base(efi_system_table_t *sys_table_arg)
+unsigned long get_dram_base(void)
 {
 	efi_status_t status;
 	unsigned long map_size, buff_size;
@@ -151,7 +150,7 @@ unsigned long get_dram_base(efi_system_table_t *sys_table_arg)
 	boot_map.key_ptr =	NULL;
 	boot_map.buff_size =	&buff_size;
 
-	status = efi_get_memory_map(sys_table_arg, &boot_map);
+	status = efi_get_memory_map(&boot_map);
 	if (status != EFI_SUCCESS)
 		return membase;
 
@@ -172,8 +171,7 @@ unsigned long get_dram_base(efi_system_table_t *sys_table_arg)
 /*
  * Allocate at the highest possible address that is not above 'max'.
  */
-efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
-			    unsigned long size, unsigned long align,
+efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
 			    unsigned long *addr, unsigned long max)
 {
 	unsigned long map_size, desc_size, buff_size;
@@ -191,7 +189,7 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 	boot_map.key_ptr =	NULL;
 	boot_map.buff_size =	&buff_size;
 
-	status = efi_get_memory_map(sys_table_arg, &boot_map);
+	status = efi_get_memory_map(&boot_map);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
@@ -271,8 +269,7 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 /*
  * Allocate at the lowest possible address that is not below 'min'.
  */
-efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
-				 unsigned long size, unsigned long align,
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
@@ -289,7 +286,7 @@ efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
 	boot_map.key_ptr =	NULL;
 	boot_map.buff_size =	&buff_size;
 
-	status = efi_get_memory_map(sys_table_arg, &boot_map);
+	status = efi_get_memory_map(&boot_map);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
@@ -348,8 +345,7 @@ efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
-void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
-	      unsigned long addr)
+void efi_free(unsigned long size, unsigned long addr)
 {
 	unsigned long nr_pages;
 
@@ -365,9 +361,8 @@ void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
 	efi_call_early(free_pages, addr, nr_pages);
 }
 
-static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
-				  efi_char16_t *filename_16, void **handle,
-				  u64 *file_sz)
+static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
+				  void **handle, u64 *file_sz)
 {
 	efi_file_handle_t *h, *fh = __fh;
 	efi_file_info_t *info;
@@ -429,8 +424,7 @@ static efi_status_t efi_file_close(efi_file_handle_t *handle)
 	return efi_call_proto(efi_file_handle, close, handle);
 }
 
-static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
-				    efi_loaded_image_t *image,
+static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 				    efi_file_handle_t **__fh)
 {
 	efi_file_io_interface_t *io;
@@ -524,8 +518,7 @@ efi_status_t efi_parse_options(char const *cmdline)
  * We only support loading a file from the same filesystem as
  * the kernel image.
  */
-efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
-				  efi_loaded_image_t *image,
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  char *cmd_line, char *option_string,
 				  unsigned long max_addr,
 				  unsigned long *load_addr,
@@ -627,13 +620,13 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 
 		/* Only open the volume once. */
 		if (!i) {
-			status = efi_open_volume(sys_table_arg, image, &fh);
+			status = efi_open_volume(image, &fh);
 			if (status != EFI_SUCCESS)
 				goto free_files;
 		}
 
-		status = efi_file_size(sys_table_arg, fh, filename_16,
-				       (void **)&file->handle, &file->size);
+		status = efi_file_size(fh, filename_16, (void **)&file->handle,
+				       &file->size);
 		if (status != EFI_SUCCESS)
 			goto close_handles;
 
@@ -648,8 +641,8 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 		 * so allocate enough memory for all the files.  This is used
 		 * for loading multiple files.
 		 */
-		status = efi_high_alloc(sys_table_arg, file_size_total, 0x1000,
-				    &file_addr, max_addr);
+		status = efi_high_alloc(file_size_total, 0x1000, &file_addr,
+					max_addr);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to alloc highmem for files\n");
 			goto close_handles;
@@ -699,7 +692,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 	return status;
 
 free_file_total:
-	efi_free(sys_table_arg, file_size_total, file_addr);
+	efi_free(file_size_total, file_addr);
 
 close_handles:
 	for (k = j; k < i; k++)
@@ -722,8 +715,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
  * address is not available the lowest available address will
  * be used.
  */
-efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
-				 unsigned long *image_addr,
+efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
@@ -761,8 +753,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 	 * possible.
 	 */
 	if (status != EFI_SUCCESS) {
-		status = efi_low_alloc_above(sys_table_arg, alloc_size,
-					     alignment, &new_addr, min_addr);
+		status = efi_low_alloc_above(alloc_size, alignment, &new_addr,
+					     min_addr);
 	}
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to allocate usable memory for kernel.\n");
@@ -839,8 +831,7 @@ static u8 *efi_utf16_to_utf8(u8 *dst, const u16 *src, int n)
  * Size of memory allocated return in *cmd_line_len.
  * Returns NULL on error.
  */
-char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
-			  efi_loaded_image_t *image,
+char *efi_convert_cmdline(efi_loaded_image_t *image,
 			  int *cmd_line_len)
 {
 	const u16 *s2;
@@ -869,8 +860,8 @@ char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
 
 	options_bytes++;	/* NUL termination */
 
-	status = efi_high_alloc(sys_table_arg, options_bytes, 0,
-				&cmdline_addr, MAX_CMDLINE_ADDRESS);
+	status = efi_high_alloc(options_bytes, 0, &cmdline_addr,
+				MAX_CMDLINE_ADDRESS);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
@@ -892,20 +883,19 @@ char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
  * specific structure may be passed to the function via priv.  The client
  * function may be called multiple times.
  */
-efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
-				    void *handle,
+efi_status_t efi_exit_boot_services(void *handle,
 				    struct efi_boot_memmap *map,
 				    void *priv,
 				    efi_exit_boot_map_processing priv_func)
 {
 	efi_status_t status;
 
-	status = efi_get_memory_map(sys_table_arg, map);
+	status = efi_get_memory_map(map);
 
 	if (status != EFI_SUCCESS)
 		goto fail;
 
-	status = priv_func(sys_table_arg, map, priv);
+	status = priv_func(map, priv);
 	if (status != EFI_SUCCESS)
 		goto free_map;
 
@@ -937,7 +927,7 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 		if (status != EFI_SUCCESS)
 			goto fail;
 
-		status = priv_func(sys_table_arg, map, priv);
+		status = priv_func(map, priv);
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
 			goto fail;
@@ -957,10 +947,12 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
-void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
+void *get_efi_config_table(efi_guid_t guid)
 {
-	unsigned long tables = efi_table_attr(efi_system_table, tables, sys_table);
-	int nr_tables = efi_table_attr(efi_system_table, nr_tables, sys_table);
+	unsigned long tables = efi_table_attr(efi_system_table, tables,
+					      efi_system_table());
+	int nr_tables = efi_table_attr(efi_system_table, nr_tables,
+				       efi_system_table());
 	int i;
 
 	for (i = 0; i < nr_tables; i++) {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 4a6acd28ce65..b5d9c9e65213 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -40,10 +40,9 @@ extern __pure efi_system_table_t  *efi_system_table(void);
 void efi_char16_printk(efi_char16_t *);
 void efi_char16_printk(efi_char16_t *);
 
-unsigned long get_dram_base(efi_system_table_t *sys_table_arg);
+unsigned long get_dram_base(void);
 
-efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
-					    void *handle,
+efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
 					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
@@ -51,22 +50,20 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    unsigned long fdt_addr,
 					    unsigned long fdt_size);
 
-void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size);
+void *get_fdt(unsigned long *fdt_size);
 
 void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
 		     int *count);
 
-efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table,
-				  unsigned long size, u8 *out);
+efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
-efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
-			      unsigned long size, unsigned long align,
+efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed);
 
-efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
+efi_status_t check_platform_features(void);
 
-void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
+void *get_efi_config_table(efi_guid_t guid);
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 1bf7edfd81ec..0a91e5232127 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -16,7 +16,7 @@
 #define EFI_DT_ADDR_CELLS_DEFAULT 2
 #define EFI_DT_SIZE_CELLS_DEFAULT 2
 
-static void fdt_update_cell_size(efi_system_table_t *sys_table, void *fdt)
+static void fdt_update_cell_size(void *fdt)
 {
 	int offset;
 
@@ -27,8 +27,7 @@ static void fdt_update_cell_size(efi_system_table_t *sys_table, void *fdt)
 	fdt_setprop_u32(fdt, offset, "#size-cells",    EFI_DT_SIZE_CELLS_DEFAULT);
 }
 
-static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
-			       unsigned long orig_fdt_size,
+static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 			       void *fdt, int new_fdt_size, char *cmdline_ptr,
 			       u64 initrd_addr, u64 initrd_size)
 {
@@ -62,7 +61,7 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 			 * Any failure from the following function is
 			 * non-critical:
 			 */
-			fdt_update_cell_size(sys_table, fdt);
+			fdt_update_cell_size(fdt);
 		}
 	}
 
@@ -111,7 +110,7 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 
 	/* Add FDT entries for EFI runtime services in chosen node. */
 	node = fdt_subnode_offset(fdt, 0, "chosen");
-	fdt_val64 = cpu_to_fdt64((u64)(unsigned long)sys_table);
+	fdt_val64 = cpu_to_fdt64((u64)(unsigned long)efi_system_table());
 
 	status = fdt_setprop_var(fdt, node, "linux,uefi-system-table", fdt_val64);
 	if (status)
@@ -140,7 +139,7 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		efi_status_t efi_status;
 
-		efi_status = efi_get_random_bytes(sys_table, sizeof(fdt_val64),
+		efi_status = efi_get_random_bytes(sizeof(fdt_val64),
 						  (u8 *)&fdt_val64);
 		if (efi_status == EFI_SUCCESS) {
 			status = fdt_setprop_var(fdt, node, "kaslr-seed", fdt_val64);
@@ -210,8 +209,7 @@ struct exit_boot_struct {
 	void			*new_fdt_addr;
 };
 
-static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
-				   struct efi_boot_memmap *map,
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   void *priv)
 {
 	struct exit_boot_struct *p = priv;
@@ -244,8 +242,7 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
  * with the final memory map in it.
  */
 
-efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
-					    void *handle,
+efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
 					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
@@ -275,7 +272,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	 * subsequent allocations adding entries, since they could not affect
 	 * the number of EFI_MEMORY_RUNTIME regions.
 	 */
-	status = efi_get_memory_map(sys_table, &map);
+	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to retrieve UEFI memory map.\n");
 		return status;
@@ -284,7 +281,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	pr_efi("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_high_alloc(sys_table, MAX_FDT_SIZE, EFI_FDT_ALIGN,
+	status = efi_high_alloc(MAX_FDT_SIZE, EFI_FDT_ALIGN,
 				new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to allocate memory for new device tree.\n");
@@ -295,11 +292,11 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	 * Now that we have done our final memory allocation (and free)
 	 * we can get the memory map key needed for exit_boot_services().
 	 */
-	status = efi_get_memory_map(sys_table, &map);
+	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS)
 		goto fail_free_new_fdt;
 
-	status = update_fdt(sys_table, (void *)fdt_addr, fdt_size,
+	status = update_fdt((void *)fdt_addr, fdt_size,
 			    (void *)*new_fdt_addr, MAX_FDT_SIZE, cmdline_ptr,
 			    initrd_addr, initrd_size);
 
@@ -313,7 +310,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	priv.runtime_entry_count	= &runtime_entry_count;
 	priv.new_fdt_addr		= (void *)*new_fdt_addr;
 
-	status = efi_exit_boot_services(sys_table, handle, &map, &priv, exit_boot_func);
+	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
 
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
@@ -322,7 +319,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 			return EFI_SUCCESS;
 
 		/* Install the new virtual address map */
-		svam = sys_table->runtime->set_virtual_address_map;
+		svam = efi_system_table()->runtime->set_virtual_address_map;
 		status = svam(runtime_entry_count * desc_size, desc_size,
 			      desc_ver, runtime_map);
 
@@ -353,19 +350,19 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	pr_efi_err("Exit boot services failed.\n");
 
 fail_free_new_fdt:
-	efi_free(sys_table, MAX_FDT_SIZE, *new_fdt_addr);
+	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
-	sys_table->boottime->free_pool(runtime_map);
+	efi_system_table()->boottime->free_pool(runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
 
-void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
+void *get_fdt(unsigned long *fdt_size)
 {
 	void *fdt;
 
-	fdt = get_efi_config_table(sys_table, DEVICE_TREE_GUID);
+	fdt = get_efi_config_table(DEVICE_TREE_GUID);
 
 	if (!fdt)
 		return NULL;
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 6c49d0a9aa3f..c3afe8d4a688 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -88,9 +88,8 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 #define efi_gop_attr(table, attr, instance) \
 	(efi_table_attr(efi_graphics_output_protocol##table, attr, instance))
 
-static efi_status_t
-setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
-	  efi_guid_t *proto, unsigned long size, void **handles)
+static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
+			      unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *gop, *first_gop;
 	u16 width, height;
@@ -185,8 +184,7 @@ setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
 /*
  * See if we have Graphics Output Protocol
  */
-efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
-			   struct screen_info *si, efi_guid_t *proto,
+efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size)
 {
 	efi_status_t status;
@@ -203,7 +201,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
-	status = setup_gop(sys_table_arg, si, proto, size, gop_handle);
+	status = setup_gop(si, proto, size, gop_handle);
 
 free_handle:
 	efi_call_early(free_pool, gop_handle);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 4f5c249c62dc..9b30d953d13b 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -26,8 +26,7 @@ union efi_rng_protocol {
 	} mixed_mode;
 };
 
-efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
-				  unsigned long size, u8 *out)
+efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
@@ -79,8 +78,7 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
  */
 #define MD_NUM_SLOTS(md)	((md)->virt_addr)
 
-efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
-			      unsigned long size,
+efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long align,
 			      unsigned long *addr,
 			      unsigned long random_seed)
@@ -99,7 +97,7 @@ efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
 	map.key_ptr =	NULL;
 	map.buff_size =	&buff_size;
 
-	status = efi_get_memory_map(sys_table_arg, &map);
+	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -155,7 +153,7 @@ efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
-efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
+efi_status_t efi_random_get_seed(void)
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 9071b57da8fe..0935d824a6ab 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -32,7 +32,7 @@ static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
  * Please keep the logic in sync with
  * arch/x86/xen/efi.c:xen_efi_get_secureboot().
  */
-enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table_arg)
+enum efi_secureboot_mode efi_get_secureboot(void)
 {
 	u32 attr;
 	u8 secboot, setupmode, moksbstate;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 86658b005e85..9fae0850e2ac 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -57,7 +57,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
+void efi_retrieve_tpm2_eventlog(void)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
@@ -139,8 +139,7 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	final_events_table = get_efi_config_table(sys_table_arg,
-						LINUX_EFI_TPM_FINAL_LOG_GUID);
+	final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1cddf3337471..f97f48a3dc81 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1553,22 +1553,17 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
 
 void efi_printk(char *str);
 
-void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
-	      unsigned long addr);
+void efi_free(unsigned long size, unsigned long addr);
 
-char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
-			  efi_loaded_image_t *image, int *cmd_line_len);
+char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
-efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
-				struct efi_boot_memmap *map);
+efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
 
-efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
-				 unsigned long size, unsigned long align,
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min);
 
 static inline
-efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
-			   unsigned long size, unsigned long align,
+efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
 			   unsigned long *addr)
 {
 	/*
@@ -1576,23 +1571,20 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 	 * checks pointers against NULL. Skip the first 8
 	 * bytes so we start at a nice even number.
 	 */
-	return efi_low_alloc_above(sys_table_arg, size, align, addr, 0x8);
+	return efi_low_alloc_above(size, align, addr, 0x8);
 }
 
-efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
-			    unsigned long size, unsigned long align,
+efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
 			    unsigned long *addr, unsigned long max);
 
-efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
-				 unsigned long *image_addr,
+efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
-efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
-				  efi_loaded_image_t *image,
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  char *cmd_line, char *option_string,
 				  unsigned long max_addr,
 				  unsigned long *load_addr,
@@ -1600,8 +1592,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 
 efi_status_t efi_parse_options(char const *cmdline);
 
-efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
-			   struct screen_info *si, efi_guid_t *proto,
+efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
 #ifdef CONFIG_EFI
@@ -1619,18 +1610,18 @@ enum efi_secureboot_mode {
 	efi_secureboot_mode_disabled,
 	efi_secureboot_mode_enabled,
 };
-enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table);
+enum efi_secureboot_mode efi_get_secureboot(void);
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
-void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg);
+void efi_enable_reset_attack_mitigation(void);
 #else
 static inline void
-efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
+efi_enable_reset_attack_mitigation(void) { }
 #endif
 
-efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
+efi_status_t efi_random_get_seed(void);
 
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
+void efi_retrieve_tpm2_eventlog(void);
 
 /*
  * Arch code can implement the following three template macros, avoiding
@@ -1682,12 +1673,10 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 })
 
 typedef efi_status_t (*efi_exit_boot_map_processing)(
-	efi_system_table_t *sys_table_arg,
 	struct efi_boot_memmap *map,
 	void *priv);
 
-efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table,
-				    void *handle,
+efi_status_t efi_exit_boot_services(void *handle,
 				    struct efi_boot_memmap *map,
 				    void *priv,
 				    efi_exit_boot_map_processing priv_func);
-- 
2.17.1

