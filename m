Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C651ACDFA
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 18:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDPQsj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 12:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgDPQsi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 12:48:38 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8719A206B9;
        Thu, 16 Apr 2020 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587055717;
        bh=X/KPtyh90DV+kNf7Uh+KF1gqlQ/QqgrCpr2PxVnk+r0=;
        h=From:To:Cc:Subject:Date:From;
        b=ffmM9+H8PmRvEISvUu/5RmNU7oPxkP/7QSMKwYQ49HgTJjGpl/oy0xtM9rsc5es3y
         QKDJZbhP5Ifo/MSK8C0+IHjA65fzQFTM/RPmGAz1WKka7DaEE/Q4TrAQKfv1v83G50
         MilM3ZL6IX6tU0npQsuYLFZRjjRHhebayi/trZLI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/libstub: drop __pure getter for efi_system_table
Date:   Thu, 16 Apr 2020 18:48:30 +0200
Message-Id: <20200416164831.11724-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The practice of using __pure getter functions to access global
variables in the EFI stub dates back to the time when we had to
carefully prevent GOT entries from being emitted, because we
could not rely on the toolchain to do this for us.

Today, we use the hidden visibility pragma for all EFI stub source
files, which now all live in the same subdirectory, and we apply a
sanity check on the objects, so we can get rid of these getter
functions and simply refer to global data objects directly.

Start with efi_system_table(), and convert it into a global variable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                    |  4 ++--
 arch/arm64/include/asm/efi.h                  |  4 ++--
 arch/x86/include/asm/efi.h                    |  8 +++----
 .../firmware/efi/libstub/efi-stub-helper.c    |  6 ++---
 drivers/firmware/efi/libstub/efi-stub.c       | 13 ++++-------
 drivers/firmware/efi/libstub/efistub.h        |  2 +-
 drivers/firmware/efi/libstub/fdt.c            |  6 ++---
 drivers/firmware/efi/libstub/x86-stub.c       | 23 ++++++++-----------
 8 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 5ac46e2860bc..5ee888266d12 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -50,8 +50,8 @@ void efi_virtmap_unload(void);
 
 /* arch specific definitions used by the stub code */
 
-#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
-#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
 #define efi_is_native()		(true)
 
 #define efi_table_attr(inst, attr)	(inst->attr)
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 45e821222774..c1b6609aec65 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -86,8 +86,8 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
-#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
 #define efi_is_native()		(true)
 
 #define efi_table_attr(inst, attr)	(inst->attr)
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f59cba117dcb..d7e40bf88f7e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -339,14 +339,14 @@ static inline u32 efi64_convert_status(efi_status_t status)
 
 #define efi_bs_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->boottime->func(__VA_ARGS__)	\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
+		? efi_system_table->boottime->func(__VA_ARGS__)	\
+		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
 				boottime), func, __VA_ARGS__))
 
 #define efi_rt_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->runtime->func(__VA_ARGS__)	\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
+		? efi_system_table->runtime->func(__VA_ARGS__)	\
+		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
 				runtime), func, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 14e56a64f208..0b1688b10ddc 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -287,8 +287,8 @@ efi_status_t efi_exit_boot_services(void *handle,
 
 void *get_efi_config_table(efi_guid_t guid)
 {
-	unsigned long tables = efi_table_attr(efi_system_table(), tables);
-	int nr_tables = efi_table_attr(efi_system_table(), nr_tables);
+	unsigned long tables = efi_table_attr(efi_system_table, tables);
+	int nr_tables = efi_table_attr(efi_system_table, nr_tables);
 	int i;
 
 	for (i = 0; i < nr_tables; i++) {
@@ -305,7 +305,7 @@ void *get_efi_config_table(efi_guid_t guid)
 
 void efi_char16_printk(efi_char16_t *str)
 {
-	efi_call_proto(efi_table_attr(efi_system_table(), con_out),
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
 		       output_string, str);
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index bf42d6c742a8..1e9f433ce51f 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -38,12 +38,7 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping;
 
-static efi_system_table_t *sys_table;
-
-__pure efi_system_table_t *efi_system_table(void)
-{
-	return sys_table;
-}
+efi_system_table_t *efi_system_table;
 
 static struct screen_info *setup_graphics(void)
 {
@@ -167,10 +162,10 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	efi_properties_table_t *prop_tbl;
 	unsigned long max_addr;
 
-	sys_table = sys_table_arg;
+	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
-	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE) {
+	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE) {
 		status = EFI_INVALID_PARAMETER;
 		goto fail;
 	}
@@ -184,7 +179,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	 * information about the running image, such as size and the command
 	 * line.
 	 */
-	status = sys_table->boottime->handle_protocol(handle,
+	status = efi_system_table->boottime->handle_protocol(handle,
 					&loaded_image_proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to get loaded image protocol\n");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index aa920dc71dc6..7fcd1579fad7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,7 +31,7 @@ extern bool __pure noinitrd(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
 
-extern __pure efi_system_table_t  *efi_system_table(void);
+extern efi_system_table_t  *efi_system_table;
 
 #define pr_efi(msg)		do {			\
 	if (!is_quiet()) efi_printk("EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 46cffac7a5f1..06d5e7fc8e34 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -110,7 +110,7 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
 
 	/* Add FDT entries for EFI runtime services in chosen node. */
 	node = fdt_subnode_offset(fdt, 0, "chosen");
-	fdt_val64 = cpu_to_fdt64((u64)(unsigned long)efi_system_table());
+	fdt_val64 = cpu_to_fdt64((u64)(unsigned long)efi_system_table);
 
 	status = fdt_setprop_var(fdt, node, "linux,uefi-system-table", fdt_val64);
 	if (status)
@@ -314,7 +314,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 			return EFI_SUCCESS;
 
 		/* Install the new virtual address map */
-		svam = efi_system_table()->runtime->set_virtual_address_map;
+		svam = efi_system_table->runtime->set_virtual_address_map;
 		status = svam(runtime_entry_count * desc_size, desc_size,
 			      desc_ver, runtime_map);
 
@@ -348,7 +348,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
-	efi_system_table()->boottime->free_pool(runtime_map);
+	efi_system_table->boottime->free_pool(runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1c3807d0c321..0e6113799f4c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,15 +20,10 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+efi_system_table_t *efi_system_table;
 extern const bool efi_is64;
 extern u32 image_offset;
 
-__pure efi_system_table_t *efi_system_table(void)
-{
-	return sys_table;
-}
-
 __attribute_const__ bool efi_is_64bit(void)
 {
 	if (IS_ENABLED(CONFIG_EFI_MIXED))
@@ -227,7 +222,7 @@ static const efi_char16_t apple[] = L"Apple";
 static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table(), fw_vendor);
+		efi_table_attr(efi_system_table, fw_vendor);
 
 	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
@@ -377,10 +372,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
-	sys_table = sys_table_arg;
+	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
-	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
+	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
@@ -446,7 +441,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		}
 	}
 
-	efi_stub_entry(handle, sys_table, boot_params);
+	efi_stub_entry(handle, efi_system_table, boot_params);
 	/* not reached */
 
 fail2:
@@ -651,14 +646,14 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
-	p->efi->efi_systab		= (unsigned long)efi_system_table();
+	p->efi->efi_systab		= (unsigned long)efi_system_table;
 	p->efi->efi_memdesc_size	= *map->desc_size;
 	p->efi->efi_memdesc_version	= *map->desc_ver;
 	p->efi->efi_memmap		= (unsigned long)*map->map;
 	p->efi->efi_memmap_size		= *map->map_size;
 
 #ifdef CONFIG_X86_64
-	p->efi->efi_systab_hi		= (unsigned long)efi_system_table() >> 32;
+	p->efi->efi_systab_hi		= (unsigned long)efi_system_table >> 32;
 	p->efi->efi_memmap_hi		= (unsigned long)*map->map >> 32;
 #endif
 
@@ -719,10 +714,10 @@ unsigned long efi_main(efi_handle_t handle,
 	efi_status_t status;
 	unsigned long cmdline_paddr;
 
-	sys_table = sys_table_arg;
+	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
-	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
+	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	/*
-- 
2.17.1

