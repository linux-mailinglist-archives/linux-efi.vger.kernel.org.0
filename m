Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8712A2C3
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfLXPLY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfLXPLX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:23 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E8820731;
        Tue, 24 Dec 2019 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200281;
        bh=oGu3GJPZWVJnQnrx28TC+0tRtI9As/EpuDftgXBX0Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjnJMWCu3rpIO0Sombc5cF+hDrMJ690iKA/gLL6PPOLx32Bbzgz5QrgPFAQP2Qfre
         qxfssIe7LB6gqvLQEN5d5rJqwj5BO5kW0Q3tGkMkuQTMJ78x6GhSsexWkx8FG/lQam
         kZEiiNGf9lCIQUJ780DImo0a1Z5WjYitEMt0m0XI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 23/25] efi/libstub: rename efi_call_early/_runtime macros to be more intuitive
Date:   Tue, 24 Dec 2019 16:10:23 +0100
Message-Id: <20191224151025.32482-24-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The macros efi_call_early and efi_call_runtime are used to call EFI
boot services and runtime services, respectively. However, the naming
is confusing, given that the early vs runtime distinction may suggest
that these are used for calling the same set of services either early
or late (== at runtime), while in reality, the sets of services they
can be used with are completely disjoint, and efi_call_runtime is also
only usable in 'early' code.

So do a global sweep to replace all occurrences with efi_bs_call or
efi_rt_call, respectively, where BS and RT match the idiom used by
the UEFI spec to refer to boot time or runtime services.

While at it, use 'func' as the macro parameter name for the function
pointers, which is less likely to collide and cause weird build errors.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                    |  6 +-
 arch/arm64/include/asm/efi.h                  |  6 +-
 arch/x86/boot/compressed/eboot.c              | 77 +++++++++----------
 arch/x86/include/asm/efi.h                    | 12 +--
 drivers/firmware/efi/libstub/arm-stub.c       | 13 ++--
 drivers/firmware/efi/libstub/arm32-stub.c     | 30 ++++----
 drivers/firmware/efi/libstub/arm64-stub.c     |  8 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 70 ++++++++---------
 drivers/firmware/efi/libstub/efistub.h        |  8 ++
 drivers/firmware/efi/libstub/gop.c            | 17 ++--
 drivers/firmware/efi/libstub/random.c         | 23 +++---
 drivers/firmware/efi/libstub/secureboot.c     |  5 --
 drivers/firmware/efi/libstub/tpm.c            | 25 ++----
 13 files changed, 137 insertions(+), 163 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index bc720024a260..5ac46e2860bc 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -50,9 +50,9 @@ void efi_virtmap_unload(void);
 
 /* arch specific definitions used by the stub code */
 
-#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
-#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
-#define efi_is_native()			(true)
+#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_is_native()		(true)
 
 #define efi_table_attr(inst, attr)	(inst->attr)
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 6f041ae446d2..44531a69d32b 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -93,9 +93,9 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
-#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
-#define efi_is_native()			(true)
+#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_is_native()		(true)
 
 #define efi_table_attr(inst, attr)	(inst->attr)
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index cccd9e16b329..da04948d75ed 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -54,8 +54,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 
 	size = romsize + sizeof(*rom);
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
-				(void **)&rom);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&rom);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate memory for 'rom'\n");
 		return status;
@@ -95,7 +95,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	return status;
 
 free_struct:
-	efi_call_early(free_pool, rom);
+	efi_bs_call(free_pool, rom);
 	return status;
 }
 
@@ -119,23 +119,20 @@ static void setup_efi_pci(struct boot_params *params)
 	efi_handle_t h;
 	int i;
 
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				&pci_proto, NULL, &size, pci_handle);
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &pci_proto, NULL, &size, pci_handle);
 
 	if (status == EFI_BUFFER_TOO_SMALL) {
-		status = efi_call_early(allocate_pool,
-					EFI_LOADER_DATA,
-					size, (void **)&pci_handle);
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+				     (void **)&pci_handle);
 
 		if (status != EFI_SUCCESS) {
 			efi_printk("Failed to allocate memory for 'pci_handle'\n");
 			return;
 		}
 
-		status = efi_call_early(locate_handle,
-					EFI_LOCATE_BY_PROTOCOL, &pci_proto,
-					NULL, &size, pci_handle);
+		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+				     &pci_proto, NULL, &size, pci_handle);
 	}
 
 	if (status != EFI_SUCCESS)
@@ -150,8 +147,8 @@ static void setup_efi_pci(struct boot_params *params)
 		efi_pci_io_protocol_t *pci = NULL;
 		struct pci_setup_rom *rom;
 
-		status = efi_call_early(handle_protocol, h,
-					&pci_proto, (void **)&pci);
+		status = efi_bs_call(handle_protocol, h, &pci_proto,
+				     (void **)&pci);
 		if (status != EFI_SUCCESS || !pci)
 			continue;
 
@@ -168,7 +165,7 @@ static void setup_efi_pci(struct boot_params *params)
 	}
 
 free_handle:
-	efi_call_early(free_pool, pci_handle);
+	efi_bs_call(free_pool, pci_handle);
 }
 
 static void retrieve_apple_device_properties(struct boot_params *boot_params)
@@ -179,7 +176,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	u32 size = 0;
 	apple_properties_protocol_t *p;
 
-	status = efi_call_early(locate_protocol, &guid, NULL, (void **)&p);
+	status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&p);
 	if (status != EFI_SUCCESS)
 		return;
 
@@ -193,9 +190,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		return;
 
 	do {
-		status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-					size + sizeof(struct setup_data),
-					(void **)&new);
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+				     size + sizeof(struct setup_data),
+				     (void **)&new);
 		if (status != EFI_SUCCESS) {
 			efi_printk("Failed to allocate memory for 'properties'\n");
 			return;
@@ -204,7 +201,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		status = efi_call_proto(p, get_all, new->data, &size);
 
 		if (status == EFI_BUFFER_TOO_SMALL)
-			efi_call_early(free_pool, new);
+			efi_bs_call(free_pool, new);
 	} while (status == EFI_BUFFER_TOO_SMALL);
 
 	new->type = SETUP_APPLE_PROPERTIES;
@@ -248,14 +245,13 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	efi_handle_t handle;
 	int i;
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				size, (void **)&uga_handle);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&uga_handle);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				uga_proto, NULL, &size, uga_handle);
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     uga_proto, NULL, &size, uga_handle);
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
@@ -268,13 +264,13 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 		u32 w, h, depth, refresh;
 		void *pciio;
 
-		status = efi_call_early(handle_protocol, handle,
-					uga_proto, (void **)&uga);
+		status = efi_bs_call(handle_protocol, handle, uga_proto,
+				     (void **)&uga);
 		if (status != EFI_SUCCESS)
 			continue;
 
 		pciio = NULL;
-		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
+		efi_bs_call(handle_protocol, handle, &pciio_proto, &pciio);
 
 		status = efi_call_proto(uga, get_mode, &w, &h, &depth, &refresh);
 		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
@@ -312,7 +308,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	si->rsvd_pos		= 24;
 
 free_handle:
-	efi_call_early(free_pool, uga_handle);
+	efi_bs_call(free_pool, uga_handle);
 
 	return status;
 }
@@ -331,17 +327,15 @@ void setup_graphics(struct boot_params *boot_params)
 	memset(si, 0, sizeof(*si));
 
 	size = 0;
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				&graphics_proto, NULL, &size, gop_handle);
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &graphics_proto, NULL, &size, gop_handle);
 	if (status == EFI_BUFFER_TOO_SMALL)
 		status = efi_setup_gop(si, &graphics_proto, size);
 
 	if (status != EFI_SUCCESS) {
 		size = 0;
-		status = efi_call_early(locate_handle,
-					EFI_LOCATE_BY_PROTOCOL,
-					&uga_proto, NULL, &size, uga_handle);
+		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+				     &uga_proto, NULL, &size, uga_handle);
 		if (status == EFI_BUFFER_TOO_SMALL)
 			setup_uga(si, &uga_proto, size);
 	}
@@ -378,8 +372,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return EFI_INVALID_PARAMETER;
 
-	status = efi_call_early(handle_protocol, handle,
-				&proto, (void *)&image);
+	status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		return status;
@@ -594,13 +587,13 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 		sizeof(struct e820_entry) * nr_desc;
 
 	if (*e820ext) {
-		efi_call_early(free_pool, *e820ext);
+		efi_bs_call(free_pool, *e820ext);
 		*e820ext = NULL;
 		*e820ext_size = 0;
 	}
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				size, (void **)e820ext);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)e820ext);
 	if (status == EFI_SUCCESS)
 		*e820ext_size = size;
 
@@ -762,8 +755,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params);
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				sizeof(*gdt), (void **)&gdt);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*gdt),
+			     (void **)&gdt);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate memory for 'gdt' structure\n");
 		goto fail;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 39814a0a92f7..2d1378f19b74 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -227,17 +227,17 @@ static inline bool efi_is_native(void)
 		? inst->func(inst, ##__VA_ARGS__)			\
 		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
 
-#define efi_call_early(f, ...)						\
+#define efi_bs_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->boottime->f(__VA_ARGS__)		\
+		? efi_system_table()->boottime->func(__VA_ARGS__)	\
 		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				boottime)->mixed_mode.f, __VA_ARGS__))
+				boottime)->mixed_mode.func, __VA_ARGS__))
 
-#define efi_call_runtime(f, ...)					\
+#define efi_rt_call(func, ...)						\
 	(efi_is_native()						\
-		? efi_system_table()->runtime->f(__VA_ARGS__)		\
+		? efi_system_table()->runtime->func(__VA_ARGS__)	\
 		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				runtime)->mixed_mode.f, __VA_ARGS__))
+				runtime)->mixed_mode.func, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index e1ec0b2cde29..62280df09dd4 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -53,8 +53,8 @@ static struct screen_info *setup_graphics(void)
 	struct screen_info *si = NULL;
 
 	size = 0;
-	status = efi_call_early(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-				&gop_proto, NULL, &size, gop_handle);
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &gop_proto, NULL, &size, gop_handle);
 	if (status == EFI_BUFFER_TOO_SMALL) {
 		si = alloc_screen_info();
 		if (!si)
@@ -70,8 +70,8 @@ void install_memreserve_table(void)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
-				(void **)&rsv);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
+			     (void **)&rsv);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to allocate memreserve entry!\n");
 		return;
@@ -81,9 +81,8 @@ void install_memreserve_table(void)
 	rsv->size = 0;
 	atomic_set(&rsv->count, 0);
 
-	status = efi_call_early(install_configuration_table,
-				&memreserve_table_guid,
-				rsv);
+	status = efi_bs_call(install_configuration_table,
+			     &memreserve_table_guid, rsv);
 	if (status != EFI_SUCCESS)
 		pr_efi_err("Failed to install memreserve config table!\n");
 }
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e7a38d912749..7b2a6382b647 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -37,18 +37,18 @@ struct screen_info *alloc_screen_info(void)
 	 * its contents while we hand over to the kernel proper from the
 	 * decompressor.
 	 */
-	status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
-				sizeof(*si), (void **)&si);
+	status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
+			     sizeof(*si), (void **)&si);
 
 	if (status != EFI_SUCCESS)
 		return NULL;
 
-	status = efi_call_early(install_configuration_table,
-				&screen_info_guid, si);
+	status = efi_bs_call(install_configuration_table,
+			     &screen_info_guid, si);
 	if (status == EFI_SUCCESS)
 		return si;
 
-	efi_call_early(free_pool, si);
+	efi_bs_call(free_pool, si);
 	return NULL;
 }
 
@@ -57,8 +57,8 @@ void free_screen_info(struct screen_info *si)
 	if (!si)
 		return;
 
-	efi_call_early(install_configuration_table, &screen_info_guid, NULL);
-	efi_call_early(free_pool, si);
+	efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
+	efi_bs_call(free_pool, si);
 }
 
 static efi_status_t reserve_kernel_base(unsigned long dram_base,
@@ -91,8 +91,8 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 	 */
 	alloc_addr = dram_base + MAX_UNCOMP_KERNEL_SIZE;
 	nr_pages = MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE;
-	status = efi_call_early(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
-				EFI_BOOT_SERVICES_DATA, nr_pages, &alloc_addr);
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
+			     EFI_BOOT_SERVICES_DATA, nr_pages, &alloc_addr);
 	if (status == EFI_SUCCESS) {
 		if (alloc_addr == dram_base) {
 			*reserve_addr = alloc_addr;
@@ -156,11 +156,11 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 			start = max(start, (u64)dram_base);
 			end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
 
-			status = efi_call_early(allocate_pages,
-						EFI_ALLOCATE_ADDRESS,
-						EFI_LOADER_DATA,
-						(end - start) / EFI_PAGE_SIZE,
-						&start);
+			status = efi_bs_call(allocate_pages,
+					     EFI_ALLOCATE_ADDRESS,
+					     EFI_LOADER_DATA,
+					     (end - start) / EFI_PAGE_SIZE,
+					     &start);
 			if (status != EFI_SUCCESS) {
 				pr_efi_err("reserve_kernel_base(): alloc failed.\n");
 				goto out;
@@ -185,7 +185,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 
 	status = EFI_SUCCESS;
 out:
-	efi_call_early(free_pool, memory_map);
+	efi_bs_call(free_pool, memory_map);
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index beba45e478c7..2915b44132e6 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -129,10 +129,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		*image_addr = *reserve_addr = preferred_offset;
 		*reserve_size = round_up(kernel_memsize, EFI_ALLOC_ALIGN);
 
-		status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
-					EFI_LOADER_DATA,
-					*reserve_size / EFI_PAGE_SIZE,
-					(efi_physical_addr_t *)reserve_addr);
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA,
+				     *reserve_size / EFI_PAGE_SIZE,
+				     (efi_physical_addr_t *)reserve_addr);
 	}
 
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8754ec04788b..ef0ffa512c20 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -95,19 +95,19 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 	*map->map_size =	*map->desc_size * 32;
 	*map->buff_size =	*map->map_size;
 again:
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				*map->map_size, (void **)&m);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     *map->map_size, (void **)&m);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
 	*map->desc_size = 0;
 	key = 0;
-	status = efi_call_early(get_memory_map, map->map_size, m,
-				&key, map->desc_size, &desc_version);
+	status = efi_bs_call(get_memory_map, map->map_size, m,
+			     &key, map->desc_size, &desc_version);
 	if (status == EFI_BUFFER_TOO_SMALL ||
 	    !mmap_has_headroom(*map->buff_size, *map->map_size,
 			       *map->desc_size)) {
-		efi_call_early(free_pool, m);
+		efi_bs_call(free_pool, m);
 		/*
 		 * Make sure there is some entries of headroom so that the
 		 * buffer can be reused for a new map after allocations are
@@ -121,7 +121,7 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 	}
 
 	if (status != EFI_SUCCESS)
-		efi_call_early(free_pool, m);
+		efi_bs_call(free_pool, m);
 
 	if (map->key_ptr && status == EFI_SUCCESS)
 		*map->key_ptr = key;
@@ -163,7 +163,7 @@ unsigned long get_dram_base(void)
 		}
 	}
 
-	efi_call_early(free_pool, map.map);
+	efi_bs_call(free_pool, map.map);
 
 	return membase;
 }
@@ -249,9 +249,8 @@ efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
 	if (!max_addr)
 		status = EFI_NOT_FOUND;
 	else {
-		status = efi_call_early(allocate_pages,
-					EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
-					nr_pages, &max_addr);
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, nr_pages, &max_addr);
 		if (status != EFI_SUCCESS) {
 			max = max_addr;
 			max_addr = 0;
@@ -261,7 +260,7 @@ efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
 		*addr = max_addr;
 	}
 
-	efi_call_early(free_pool, map);
+	efi_bs_call(free_pool, map);
 fail:
 	return status;
 }
@@ -328,9 +327,8 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		if ((start + size) > end)
 			continue;
 
-		status = efi_call_early(allocate_pages,
-					EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
-					nr_pages, &start);
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, nr_pages, &start);
 		if (status == EFI_SUCCESS) {
 			*addr = start;
 			break;
@@ -340,7 +338,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 	if (i == map_size / desc_size)
 		status = EFI_NOT_FOUND;
 
-	efi_call_early(free_pool, map);
+	efi_bs_call(free_pool, map);
 fail:
 	return status;
 }
@@ -386,8 +384,8 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 	}
 
 grow:
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				info_sz, (void **)&info);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, info_sz,
+			     (void **)&info);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to alloc mem for file info\n");
 		return status;
@@ -395,12 +393,12 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 
 	status = h->get_info(h, &info_guid, &info_sz, info);
 	if (status == EFI_BUFFER_TOO_SMALL) {
-		efi_call_early(free_pool, info);
+		efi_bs_call(free_pool, info);
 		goto grow;
 	}
 
 	*file_sz = info->file_size;
-	efi_call_early(free_pool, info);
+	efi_bs_call(free_pool, info);
 
 	if (status != EFI_SUCCESS)
 		efi_printk("Failed to get initrd info\n");
@@ -428,8 +426,7 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 	efi_status_t status;
 	efi_handle_t handle = image->device_handle;
 
-	status = efi_call_early(handle_protocol, handle,
-				&fs_proto, (void **)&io);
+	status = efi_bs_call(handle_protocol, handle, &fs_proto, (void **)&io);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to handle fs_proto\n");
 		return status;
@@ -562,8 +559,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	if (!nr_files)
 		return EFI_SUCCESS;
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				nr_files * sizeof(*files), (void **)&files);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     nr_files * sizeof(*files), (void **)&files);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to alloc mem for file handle list\n");
 		goto fail;
@@ -668,7 +665,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 	}
 
-	efi_call_early(free_pool, files);
+	efi_bs_call(free_pool, files);
 
 	*load_addr = file_addr;
 	*load_size = file_size_total;
@@ -682,7 +679,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	for (k = j; k < i; k++)
 		efi_file_close(files[k].handle);
 free_files:
-	efi_call_early(free_pool, files);
+	efi_bs_call(free_pool, files);
 fail:
 	*load_addr = 0;
 	*load_size = 0;
@@ -728,9 +725,8 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 	 * as possible while respecting the required alignment.
 	 */
 	nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	status = efi_call_early(allocate_pages,
-				EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
-				nr_pages, &efi_addr);
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+			     EFI_LOADER_DATA, nr_pages, &efi_addr);
 	new_addr = efi_addr;
 	/*
 	 * If preferred address allocation failed allocate as low as
@@ -883,7 +879,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 	if (status != EFI_SUCCESS)
 		goto free_map;
 
-	status = efi_call_early(exit_boot_services, handle, *map->key_ptr);
+	status = efi_bs_call(exit_boot_services, handle, *map->key_ptr);
 
 	if (status == EFI_INVALID_PARAMETER) {
 		/*
@@ -900,12 +896,12 @@ efi_status_t efi_exit_boot_services(void *handle,
 		 * to get_memory_map() is expected to succeed here.
 		 */
 		*map->map_size = *map->buff_size;
-		status = efi_call_early(get_memory_map,
-					map->map_size,
-					*map->map,
-					map->key_ptr,
-					map->desc_size,
-					map->desc_ver);
+		status = efi_bs_call(get_memory_map,
+				     map->map_size,
+				     *map->map,
+				     map->key_ptr,
+				     map->desc_size,
+				     map->desc_ver);
 
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
@@ -916,7 +912,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 		if (status != EFI_SUCCESS)
 			goto fail;
 
-		status = efi_call_early(exit_boot_services, handle, *map->key_ptr);
+		status = efi_bs_call(exit_boot_services, handle, *map->key_ptr);
 	}
 
 	/* exit_boot_services() was called, thus cannot free */
@@ -926,7 +922,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 	return EFI_SUCCESS;
 
 free_map:
-	efi_call_early(free_pool, *map->map);
+	efi_bs_call(free_pool, *map->map);
 fail:
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b5d9c9e65213..4e2b33fd6a43 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -76,4 +76,12 @@ void *get_efi_config_table(efi_guid_t guid);
 	fdt_setprop((fdt), (node_offset), (name), &(var), sizeof(var))
 #endif
 
+#define get_efi_var(name, vendor, ...)				\
+	efi_rt_call(get_variable, (efi_char16_t *)(name),	\
+		    (efi_guid_t *)(vendor), __VA_ARGS__)
+
+#define set_efi_var(name, vendor, ...)				\
+	efi_rt_call(set_variable, (efi_char16_t *)(name),	\
+		    (efi_guid_t *)(vendor), __VA_ARGS__)
+
 #endif
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 8f746282c219..55e6b3f286fe 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -110,13 +110,11 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		void *dummy = NULL;
 		efi_physical_addr_t current_fb_base;
 
-		status = efi_call_early(handle_protocol, h,
-					proto, (void **)&gop);
+		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
 		if (status != EFI_SUCCESS)
 			continue;
 
-		status = efi_call_early(handle_protocol, h,
-					&conout_proto, &dummy);
+		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
@@ -187,20 +185,19 @@ efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 	efi_status_t status;
 	void **gop_handle = NULL;
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				size, (void **)&gop_handle);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&gop_handle);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				proto, NULL, &size, gop_handle);
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, proto, NULL,
+			     &size, gop_handle);
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
 	status = setup_gop(si, proto, size, gop_handle);
 
 free_handle:
-	efi_call_early(free_pool, gop_handle);
+	efi_bs_call(free_pool, gop_handle);
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index fbd5b5724b19..316ce9ff0193 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -32,8 +32,7 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 	efi_status_t status;
 	efi_rng_protocol_t *rng = NULL;
 
-	status = efi_call_early(locate_protocol, &rng_proto, NULL,
-				(void **)&rng);
+	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -141,14 +140,14 @@ efi_status_t efi_random_alloc(unsigned long size,
 		target = round_up(md->phys_addr, align) + target_slot * align;
 		pages = round_up(size, EFI_PAGE_SIZE) / EFI_PAGE_SIZE;
 
-		status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
-					EFI_LOADER_DATA, pages, &target);
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, pages, &target);
 		if (status == EFI_SUCCESS)
 			*addr = target;
 		break;
 	}
 
-	efi_call_early(free_pool, memory_map);
+	efi_bs_call(free_pool, memory_map);
 
 	return status;
 }
@@ -162,14 +161,13 @@ efi_status_t efi_random_get_seed(void)
 	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
-	status = efi_call_early(locate_protocol, &rng_proto, NULL,
-				(void **)&rng);
+	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
-				sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
-				(void **)&seed);
+	status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
+			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
+			     (void **)&seed);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -188,14 +186,13 @@ efi_status_t efi_random_get_seed(void)
 		goto err_freepool;
 
 	seed->size = EFI_RANDOM_SEED_SIZE;
-	status = efi_call_early(install_configuration_table, &rng_table_guid,
-				seed);
+	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
 
 	return EFI_SUCCESS;
 
 err_freepool:
-	efi_call_early(free_pool, seed);
+	efi_bs_call(free_pool, seed);
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 0935d824a6ab..a765378ad18c 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -21,11 +21,6 @@ static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
 static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
-#define get_efi_var(name, vendor, ...) \
-	efi_call_runtime(get_variable, \
-			 (efi_char16_t *)(name), (efi_guid_t *)(vendor), \
-			 __VA_ARGS__);
-
 /*
  * Determine whether we're in secure boot mode.
  *
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 4a0017a181bf..1d59e103a2e3 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -20,16 +20,6 @@ static const efi_char16_t efi_MemoryOverWriteRequest_name[] =
 #define MEMORY_ONLY_RESET_CONTROL_GUID \
 	EFI_GUID(0xe20939be, 0x32d4, 0x41be, 0xa1, 0x50, 0x89, 0x7f, 0x85, 0xd4, 0x98, 0x29)
 
-#define get_efi_var(name, vendor, ...) \
-	efi_call_runtime(get_variable, \
-			 (efi_char16_t *)(name), (efi_guid_t *)(vendor), \
-			 __VA_ARGS__)
-
-#define set_efi_var(name, vendor, ...) \
-	efi_call_runtime(set_variable, \
-			 (efi_char16_t *)(name), (efi_guid_t *)(vendor), \
-			 __VA_ARGS__)
-
 /*
  * Enable reboot attack mitigation. This requests that the firmware clear the
  * RAM on next reboot before proceeding with boot, ensuring that any secrets
@@ -72,8 +62,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	efi_tcg2_protocol_t *tcg2_protocol = NULL;
 	int final_events_size = 0;
 
-	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
-				(void **)&tcg2_protocol);
+	status = efi_bs_call(locate_protocol, &tcg2_guid, NULL,
+			     (void **)&tcg2_protocol);
 	if (status != EFI_SUCCESS)
 		return;
 
@@ -125,9 +115,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	}
 
 	/* Allocate space for the logs and copy them. */
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				sizeof(*log_tbl) + log_size,
-				(void **) &log_tbl);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
 		efi_printk("Unable to allocate memory for event log\n");
@@ -166,12 +155,12 @@ void efi_retrieve_tpm2_eventlog(void)
 	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
-	status = efi_call_early(install_configuration_table,
-				&linux_eventlog_guid, log_tbl);
+	status = efi_bs_call(install_configuration_table,
+			     &linux_eventlog_guid, log_tbl);
 	if (status != EFI_SUCCESS)
 		goto err_free;
 	return;
 
 err_free:
-	efi_call_early(free_pool, log_tbl);
+	efi_bs_call(free_pool, log_tbl);
 }
-- 
2.20.1

