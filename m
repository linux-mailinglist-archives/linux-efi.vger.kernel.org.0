Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B231B766A
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDXNHk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgDXNHQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:16 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506D821473;
        Fri, 24 Apr 2020 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733635;
        bh=RG0br87sZZ0/fDV9RN7SwM/1ICjCTgZKJ0ZHR/mwPBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPjGUINROEYC/rT5vnhINPHfD3GqcK0klwjQu2LnVyY6X+1//0hyWznHSyraW8Xru
         PD3Bkzr0N4x6EtFrv7EIUV4O2xaUVibbHo1DWkpP3Igx2EU0FI7Pg87JpquXvjLnqt
         YJFzBDoRBeJ3asNwErNx5Ts8CrGQ4Gl8iGxXIruk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 29/33] efi/libstub: Drop __pure getter for efi_system_table
Date:   Fri, 24 Apr 2020 15:05:27 +0200
Message-Id: <20200424130531.30518-30-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
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
While at it, make it a pointer-to-const, because we can.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h                    | 14 ++++++-----
 .../firmware/efi/libstub/efi-stub-helper.c    |  6 ++---
 drivers/firmware/efi/libstub/efi-stub.c       | 13 ++++-------
 drivers/firmware/efi/libstub/efistub.h        |  6 ++---
 drivers/firmware/efi/libstub/fdt.c            |  6 ++---
 drivers/firmware/efi/libstub/x86-stub.c       | 23 ++++++++-----------
 6 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f59cba117dcb..78e839925a81 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -339,15 +339,17 @@ static inline u32 efi64_convert_status(efi_status_t status)
 
 #define efi_bs_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->boottime->func(__VA_ARGS__)	\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
-				boottime), func, __VA_ARGS__))
+		? efi_system_table->boottime->func(__VA_ARGS__)		\
+		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
+						   boottime),		\
+				    func, __VA_ARGS__))
 
 #define efi_rt_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->runtime->func(__VA_ARGS__)	\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
-				runtime), func, __VA_ARGS__))
+		? efi_system_table->runtime->func(__VA_ARGS__)		\
+		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
+						   runtime),		\
+				    func, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
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
index 8455c590c7b9..8edfd4022803 100644
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
+const efi_system_table_t *efi_system_table;
 
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
index 9a87fff1d4ba..c1481c5abea4 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,13 +31,13 @@ extern bool __pure noinitrd(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
 
-extern __pure efi_system_table_t  *efi_system_table(void);
+extern const efi_system_table_t *efi_system_table;
 
 #ifndef efi_bs_call
-#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
 #endif
 #ifndef efi_rt_call
-#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
 #endif
 #ifndef efi_is_native
 #define efi_is_native()		(true)
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
index 1c3807d0c321..3f132f51ab0f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,15 +20,10 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+const efi_system_table_t *efi_system_table;
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
+	efi_stub_entry(handle, sys_table_arg, boot_params);
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

