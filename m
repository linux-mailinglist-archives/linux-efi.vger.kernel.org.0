Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769B46E37E1
	for <lists+linux-efi@lfdr.de>; Sun, 16 Apr 2023 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDPMIH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Apr 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDPMIG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Apr 2023 08:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5249C7;
        Sun, 16 Apr 2023 05:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF8761365;
        Sun, 16 Apr 2023 12:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF5EC4339B;
        Sun, 16 Apr 2023 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681646880;
        bh=i/f7yIvqZvWGjHoiWNWJh+xxJ5nECG4JhG0EAlnlRoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IIkGFhIZko6PNjgbUyhoZhg+TW+kHMm0dowjGHSaCKEXo+3izwQNPM9MkngS53afK
         eVXMM6NGuo+xdNWeK6YCJmmWitqe0ZqoxnQIa6tA/JpoTO/gsZS+Ip/1FGMGfr2vFQ
         RmTUt+GkkY+aEJ+Si3pJe7iWHLTF4OwazTcRv1XS97IB7F+SwKClgv2mNAX8/mfUjP
         4NHuZC9oRQEeEgWw5sk9efn9NQ7KW3wepampUhJV9r/8RWeaIiBChmN9ioBQix1JM+
         ZBFcxb5yooh1STOo++hO68/S5CaZdbr5p+h+Qo6VezUVIO5pIF1JE8fwEBD6aXJ5Mo
         6iqUfRH1RCeTA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 1/3] efi/libstub: x86: Split off pieces shared with zboot
Date:   Sun, 16 Apr 2023 14:07:27 +0200
Message-Id: <20230416120729.2470762-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=36623; i=ardb@kernel.org; h=from:subject; bh=i/f7yIvqZvWGjHoiWNWJh+xxJ5nECG4JhG0EAlnlRoo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcX6yT82XXG7v4rqKgIpFxsY1dTKrBP5devlA75/WnFGS tBS3rujlIVBjINBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATKTnKiPD03+6y9bdmeJrlnVa xiqKX0Tf88CrDZUNG3Ytd+3kUjpmxMgw5Y/EaW4+icMRAS4S9qsMqgy2TORLmaeit1q4rV63S5w TAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for implementing generic EFI zboot support also on x86,
split the X86 pieces into those that can be shared and those that are
tied to the way the EFI stub is currently embedded in the bare metal x86
decompressor.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h              |   5 +
 drivers/firmware/efi/libstub/Makefile   |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 591 +------------------
 drivers/firmware/efi/libstub/x86.c      | 612 ++++++++++++++++++++
 4 files changed, 625 insertions(+), 585 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 419280d263d2e3f2..dd49cb9b6e3a1f1f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -214,6 +214,11 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
+struct boot_params *efi_alloc_boot_params(void);
+
+efi_status_t efi_x86_stub_common(struct boot_params *boot_params,
+				 efi_handle_t handle);
+
 #ifdef CONFIG_EFI_MIXED
 
 #define ARCH_HAS_EFISTUB_WRAPPERS
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3abb2b357482a416..4dfbfac254614f18 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -87,7 +87,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o smbios.o
-lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86)		+= x86.o x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba97b1..d2b75025295822c7 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -7,11 +7,9 @@
  * ----------------------------------------------------------------------- */
 
 #include <linux/efi.h>
-#include <linux/pci.h>
 #include <linux/stddef.h>
 
 #include <asm/efi.h>
-#include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
@@ -26,192 +24,6 @@ const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
-static efi_status_t
-preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
-{
-	struct pci_setup_rom *rom = NULL;
-	efi_status_t status;
-	unsigned long size;
-	uint64_t romsize;
-	void *romimage;
-
-	/*
-	 * Some firmware images contain EFI function pointers at the place where
-	 * the romimage and romsize fields are supposed to be. Typically the EFI
-	 * code is mapped at high addresses, translating to an unrealistically
-	 * large romsize. The UEFI spec limits the size of option ROMs to 16
-	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
-	 */
-	romimage = efi_table_attr(pci, romimage);
-	romsize = efi_table_attr(pci, romsize);
-	if (!romimage || !romsize || romsize > SZ_16M)
-		return EFI_INVALID_PARAMETER;
-
-	size = romsize + sizeof(*rom);
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-			     (void **)&rom);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate memory for 'rom'\n");
-		return status;
-	}
-
-	memset(rom, 0, sizeof(*rom));
-
-	rom->data.type	= SETUP_PCI;
-	rom->data.len	= size - sizeof(struct setup_data);
-	rom->data.next	= 0;
-	rom->pcilen	= pci->romsize;
-	*__rom = rom;
-
-	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
-				PCI_VENDOR_ID, 1, &rom->vendor);
-
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to read rom->vendor\n");
-		goto free_struct;
-	}
-
-	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
-				PCI_DEVICE_ID, 1, &rom->devid);
-
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to read rom->devid\n");
-		goto free_struct;
-	}
-
-	status = efi_call_proto(pci, get_location, &rom->segment, &rom->bus,
-				&rom->device, &rom->function);
-
-	if (status != EFI_SUCCESS)
-		goto free_struct;
-
-	memcpy(rom->romdata, romimage, romsize);
-	return status;
-
-free_struct:
-	efi_bs_call(free_pool, rom);
-	return status;
-}
-
-/*
- * There's no way to return an informative status from this function,
- * because any analysis (and printing of error messages) needs to be
- * done directly at the EFI function call-site.
- *
- * For example, EFI_INVALID_PARAMETER could indicate a bug or maybe we
- * just didn't find any PCI devices, but there's no way to tell outside
- * the context of the call.
- */
-static void setup_efi_pci(struct boot_params *params)
-{
-	efi_status_t status;
-	void **pci_handle = NULL;
-	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	unsigned long size = 0;
-	struct setup_data *data;
-	efi_handle_t h;
-	int i;
-
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &pci_proto, NULL, &size, pci_handle);
-
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-				     (void **)&pci_handle);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to allocate memory for 'pci_handle'\n");
-			return;
-		}
-
-		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-				     &pci_proto, NULL, &size, pci_handle);
-	}
-
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	for_each_efi_handle(h, pci_handle, size, i) {
-		efi_pci_io_protocol_t *pci = NULL;
-		struct pci_setup_rom *rom;
-
-		status = efi_bs_call(handle_protocol, h, &pci_proto,
-				     (void **)&pci);
-		if (status != EFI_SUCCESS || !pci)
-			continue;
-
-		status = preserve_pci_rom_image(pci, &rom);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (data)
-			data->next = (unsigned long)rom;
-		else
-			params->hdr.setup_data = (unsigned long)rom;
-
-		data = (struct setup_data *)rom;
-	}
-
-free_handle:
-	efi_bs_call(free_pool, pci_handle);
-}
-
-static void retrieve_apple_device_properties(struct boot_params *boot_params)
-{
-	efi_guid_t guid = APPLE_PROPERTIES_PROTOCOL_GUID;
-	struct setup_data *data, *new;
-	efi_status_t status;
-	u32 size = 0;
-	apple_properties_protocol_t *p;
-
-	status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&p);
-	if (status != EFI_SUCCESS)
-		return;
-
-	if (efi_table_attr(p, version) != 0x10000) {
-		efi_err("Unsupported properties proto version\n");
-		return;
-	}
-
-	efi_call_proto(p, get_all, NULL, &size);
-	if (!size)
-		return;
-
-	do {
-		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-				     size + sizeof(struct setup_data),
-				     (void **)&new);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to allocate memory for 'properties'\n");
-			return;
-		}
-
-		status = efi_call_proto(p, get_all, new->data, &size);
-
-		if (status == EFI_BUFFER_TOO_SMALL)
-			efi_bs_call(free_pool, new);
-	} while (status == EFI_BUFFER_TOO_SMALL);
-
-	new->type = SETUP_APPLE_PROPERTIES;
-	new->len  = size;
-	new->next = 0;
-
-	data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
-	if (!data) {
-		boot_params->hdr.setup_data = (unsigned long)new;
-	} else {
-		while (data->next)
-			data = (struct setup_data *)(unsigned long)data->next;
-		data->next = (unsigned long)new;
-	}
-}
-
 static void
 adjust_memory_range_protection(unsigned long start, unsigned long size)
 {
@@ -310,134 +122,6 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 #endif
 }
 
-static const efi_char16_t apple[] = L"Apple";
-
-static void setup_quirks(struct boot_params *boot_params,
-			 unsigned long image_base,
-			 unsigned long image_size)
-{
-	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor);
-
-	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
-		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
-			retrieve_apple_device_properties(boot_params);
-	}
-
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
-		setup_memory_protection(image_base, image_size);
-}
-
-/*
- * See if we have Universal Graphics Adapter (UGA) protocol
- */
-static efi_status_t
-setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
-{
-	efi_status_t status;
-	u32 width, height;
-	void **uga_handle = NULL;
-	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_handle_t handle;
-	int i;
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-			     (void **)&uga_handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     uga_proto, NULL, &size, uga_handle);
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	height = 0;
-	width = 0;
-
-	first_uga = NULL;
-	for_each_efi_handle(handle, uga_handle, size, i) {
-		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
-		u32 w, h, depth, refresh;
-		void *pciio;
-
-		status = efi_bs_call(handle_protocol, handle, uga_proto,
-				     (void **)&uga);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		pciio = NULL;
-		efi_bs_call(handle_protocol, handle, &pciio_proto, &pciio);
-
-		status = efi_call_proto(uga, get_mode, &w, &h, &depth, &refresh);
-		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			width = w;
-			height = h;
-
-			/*
-			 * Once we've found a UGA supporting PCIIO,
-			 * don't bother looking any further.
-			 */
-			if (pciio)
-				break;
-
-			first_uga = uga;
-		}
-	}
-
-	if (!width && !height)
-		goto free_handle;
-
-	/* EFI framebuffer */
-	si->orig_video_isVGA	= VIDEO_TYPE_EFI;
-
-	si->lfb_depth		= 32;
-	si->lfb_width		= width;
-	si->lfb_height		= height;
-
-	si->red_size		= 8;
-	si->red_pos		= 16;
-	si->green_size		= 8;
-	si->green_pos		= 8;
-	si->blue_size		= 8;
-	si->blue_pos		= 0;
-	si->rsvd_size		= 8;
-	si->rsvd_pos		= 24;
-
-free_handle:
-	efi_bs_call(free_pool, uga_handle);
-
-	return status;
-}
-
-static void setup_graphics(struct boot_params *boot_params)
-{
-	efi_guid_t graphics_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
-	struct screen_info *si;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
-	efi_status_t status;
-	unsigned long size;
-	void **gop_handle = NULL;
-	void **uga_handle = NULL;
-
-	si = &boot_params->screen_info;
-	memset(si, 0, sizeof(*si));
-
-	size = 0;
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &graphics_proto, NULL, &size, gop_handle);
-	if (status == EFI_BUFFER_TOO_SMALL)
-		status = efi_setup_gop(si, &graphics_proto, size);
-
-	if (status != EFI_SUCCESS) {
-		size = 0;
-		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-				     &uga_proto, NULL, &size, uga_handle);
-		if (status == EFI_BUFFER_TOO_SMALL)
-			setup_uga(si, &uga_proto, size);
-	}
-}
-
-
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 {
 	efi_bs_call(exit, handle, status, 0, NULL);
@@ -480,14 +164,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
+	boot_params = efi_alloc_boot_params();
+	if (!boot_params)
+		efi_exit(handle, EFI_OUT_OF_RESOURCES);
 
 	hdr = &boot_params->hdr;
 
@@ -495,14 +174,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	memcpy(&hdr->jump, image_base + 512,
 	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
-	hdr->root_flags	= 1;
-	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
-
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
@@ -532,234 +203,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_exit(handle, status);
 }
 
-static void add_e820ext(struct boot_params *params,
-			struct setup_data *e820ext, u32 nr_entries)
-{
-	struct setup_data *data;
-
-	e820ext->type = SETUP_E820_EXT;
-	e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
-	e820ext->next = 0;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	if (data)
-		data->next = (unsigned long)e820ext;
-	else
-		params->hdr.setup_data = (unsigned long)e820ext;
-}
-
-static efi_status_t
-setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_size)
-{
-	struct boot_e820_entry *entry = params->e820_table;
-	struct efi_info *efi = &params->efi_info;
-	struct boot_e820_entry *prev = NULL;
-	u32 nr_entries;
-	u32 nr_desc;
-	int i;
-
-	nr_entries = 0;
-	nr_desc = efi->efi_memmap_size / efi->efi_memdesc_size;
-
-	for (i = 0; i < nr_desc; i++) {
-		efi_memory_desc_t *d;
-		unsigned int e820_type = 0;
-		unsigned long m = efi->efi_memmap;
-
-#ifdef CONFIG_X86_64
-		m |= (u64)efi->efi_memmap_hi << 32;
-#endif
-
-		d = efi_early_memdesc_ptr(m, efi->efi_memdesc_size, i);
-		switch (d->type) {
-		case EFI_RESERVED_TYPE:
-		case EFI_RUNTIME_SERVICES_CODE:
-		case EFI_RUNTIME_SERVICES_DATA:
-		case EFI_MEMORY_MAPPED_IO:
-		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
-		case EFI_PAL_CODE:
-			e820_type = E820_TYPE_RESERVED;
-			break;
-
-		case EFI_UNUSABLE_MEMORY:
-			e820_type = E820_TYPE_UNUSABLE;
-			break;
-
-		case EFI_ACPI_RECLAIM_MEMORY:
-			e820_type = E820_TYPE_ACPI;
-			break;
-
-		case EFI_LOADER_CODE:
-		case EFI_LOADER_DATA:
-		case EFI_BOOT_SERVICES_CODE:
-		case EFI_BOOT_SERVICES_DATA:
-		case EFI_CONVENTIONAL_MEMORY:
-			if (efi_soft_reserve_enabled() &&
-			    (d->attribute & EFI_MEMORY_SP))
-				e820_type = E820_TYPE_SOFT_RESERVED;
-			else
-				e820_type = E820_TYPE_RAM;
-			break;
-
-		case EFI_ACPI_MEMORY_NVS:
-			e820_type = E820_TYPE_NVS;
-			break;
-
-		case EFI_PERSISTENT_MEMORY:
-			e820_type = E820_TYPE_PMEM;
-			break;
-
-		default:
-			continue;
-		}
-
-		/* Merge adjacent mappings */
-		if (prev && prev->type == e820_type &&
-		    (prev->addr + prev->size) == d->phys_addr) {
-			prev->size += d->num_pages << 12;
-			continue;
-		}
-
-		if (nr_entries == ARRAY_SIZE(params->e820_table)) {
-			u32 need = (nr_desc - i) * sizeof(struct e820_entry) +
-				   sizeof(struct setup_data);
-
-			if (!e820ext || e820ext_size < need)
-				return EFI_BUFFER_TOO_SMALL;
-
-			/* boot_params map full, switch to e820 extended */
-			entry = (struct boot_e820_entry *)e820ext->data;
-		}
-
-		entry->addr = d->phys_addr;
-		entry->size = d->num_pages << PAGE_SHIFT;
-		entry->type = e820_type;
-		prev = entry++;
-		nr_entries++;
-	}
-
-	if (nr_entries > ARRAY_SIZE(params->e820_table)) {
-		u32 nr_e820ext = nr_entries - ARRAY_SIZE(params->e820_table);
-
-		add_e820ext(params, e820ext, nr_e820ext);
-		nr_entries -= nr_e820ext;
-	}
-
-	params->e820_entries = (u8)nr_entries;
-
-	return EFI_SUCCESS;
-}
-
-static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
-				  u32 *e820ext_size)
-{
-	efi_status_t status;
-	unsigned long size;
-
-	size = sizeof(struct setup_data) +
-		sizeof(struct e820_entry) * nr_desc;
-
-	if (*e820ext) {
-		efi_bs_call(free_pool, *e820ext);
-		*e820ext = NULL;
-		*e820ext_size = 0;
-	}
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-			     (void **)e820ext);
-	if (status == EFI_SUCCESS)
-		*e820ext_size = size;
-
-	return status;
-}
-
-static efi_status_t allocate_e820(struct boot_params *params,
-				  struct setup_data **e820ext,
-				  u32 *e820ext_size)
-{
-	unsigned long map_size, desc_size, map_key;
-	efi_status_t status;
-	__u32 nr_desc, desc_version;
-
-	/* Only need the size of the mem map and size of each mem descriptor */
-	map_size = 0;
-	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
-			     &desc_size, &desc_version);
-	if (status != EFI_BUFFER_TOO_SMALL)
-		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
-
-	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
-
-	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
-		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
-
-		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
-		if (status != EFI_SUCCESS)
-			return status;
-	}
-
-	return EFI_SUCCESS;
-}
-
-struct exit_boot_struct {
-	struct boot_params	*boot_params;
-	struct efi_info		*efi;
-};
-
-static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
-				   void *priv)
-{
-	const char *signature;
-	struct exit_boot_struct *p = priv;
-
-	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
-				   : EFI32_LOADER_SIGNATURE;
-	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
-
-	efi_set_u64_split((unsigned long)efi_system_table,
-			  &p->efi->efi_systab, &p->efi->efi_systab_hi);
-	p->efi->efi_memdesc_size	= map->desc_size;
-	p->efi->efi_memdesc_version	= map->desc_ver;
-	efi_set_u64_split((unsigned long)map->map,
-			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
-	p->efi->efi_memmap_size		= map->map_size;
-
-	return EFI_SUCCESS;
-}
-
-static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
-{
-	struct setup_data *e820ext = NULL;
-	__u32 e820ext_size = 0;
-	efi_status_t status;
-	struct exit_boot_struct priv;
-
-	priv.boot_params	= boot_params;
-	priv.efi		= &boot_params->efi_info;
-
-	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	/* Might as well exit boot services now */
-	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	/* Historic? */
-	boot_params->alt_mem_k	= 32 * 1024;
-
-	status = setup_e820(boot_params, e820ext, e820ext_size);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	return EFI_SUCCESS;
-}
-
 /*
  * On success, we return the address of startup_32, which has potentially been
  * relocated by efi_relocate_kernel.
@@ -878,32 +321,12 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 				  &boot_params->ext_ramdisk_size);
 	}
 
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
+		setup_memory_protection(bzimage_addr, buffer_end - buffer_start);
 
-	/*
-	 * If the boot loader gave us a value for secure_boot then we use that,
-	 * otherwise we ask the BIOS.
-	 */
-	if (boot_params->secure_boot == efi_secureboot_mode_unset)
-		boot_params->secure_boot = efi_get_secureboot();
-
-	/* Ask the firmware to clear memory on unclean shutdown */
-	efi_enable_reset_attack_mitigation();
-
-	efi_random_get_seed();
-
-	efi_retrieve_tpm2_eventlog();
-
-	setup_graphics(boot_params);
-
-	setup_efi_pci(boot_params);
-
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
-
-	status = exit_boot(boot_params, handle);
-	if (status != EFI_SUCCESS) {
-		efi_err("exit_boot() failed!\n");
+	status = efi_x86_stub_common(boot_params, handle);
+	if (status != EFI_SUCCESS)
 		goto fail;
-	}
 
 	return bzimage_addr;
 fail:
diff --git a/drivers/firmware/efi/libstub/x86.c b/drivers/firmware/efi/libstub/x86.c
new file mode 100644
index 0000000000000000..fcaf69eace751f17
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* -----------------------------------------------------------------------
+ *
+ *   Copyright 2011 Intel Corporation; author Matt Fleming
+ *
+ * ----------------------------------------------------------------------- */
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+#include <linux/stddef.h>
+
+#include <asm/efi.h>
+#include <asm/e820/types.h>
+#include <asm/setup.h>
+#include <asm/desc.h>
+#include <asm/boot.h>
+
+#include "efistub.h"
+
+static void add_e820ext(struct boot_params *params,
+			struct setup_data *e820ext, u32 nr_entries)
+{
+	struct setup_data *data;
+
+	e820ext->type = SETUP_E820_EXT;
+	e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
+	e820ext->next = 0;
+
+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
+
+	while (data && data->next)
+		data = (struct setup_data *)(unsigned long)data->next;
+
+	if (data)
+		data->next = (unsigned long)e820ext;
+	else
+		params->hdr.setup_data = (unsigned long)e820ext;
+}
+
+static efi_status_t
+setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_size)
+{
+	struct boot_e820_entry *entry = params->e820_table;
+	struct efi_info *efi = &params->efi_info;
+	struct boot_e820_entry *prev = NULL;
+	u32 nr_entries;
+	u32 nr_desc;
+	int i;
+
+	nr_entries = 0;
+	nr_desc = efi->efi_memmap_size / efi->efi_memdesc_size;
+
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+		unsigned int e820_type = 0;
+		unsigned long m = efi->efi_memmap;
+
+#ifdef CONFIG_X86_64
+		m |= (u64)efi->efi_memmap_hi << 32;
+#endif
+
+		d = efi_early_memdesc_ptr(m, efi->efi_memdesc_size, i);
+		switch (d->type) {
+		case EFI_RESERVED_TYPE:
+		case EFI_RUNTIME_SERVICES_CODE:
+		case EFI_RUNTIME_SERVICES_DATA:
+		case EFI_MEMORY_MAPPED_IO:
+		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+		case EFI_PAL_CODE:
+			e820_type = E820_TYPE_RESERVED;
+			break;
+
+		case EFI_UNUSABLE_MEMORY:
+			e820_type = E820_TYPE_UNUSABLE;
+			break;
+
+		case EFI_ACPI_RECLAIM_MEMORY:
+			e820_type = E820_TYPE_ACPI;
+			break;
+
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+			if (efi_soft_reserve_enabled() &&
+			    (d->attribute & EFI_MEMORY_SP))
+				e820_type = E820_TYPE_SOFT_RESERVED;
+			else
+				e820_type = E820_TYPE_RAM;
+			break;
+
+		case EFI_ACPI_MEMORY_NVS:
+			e820_type = E820_TYPE_NVS;
+			break;
+
+		case EFI_PERSISTENT_MEMORY:
+			e820_type = E820_TYPE_PMEM;
+			break;
+
+		default:
+			continue;
+		}
+
+		/* Merge adjacent mappings */
+		if (prev && prev->type == e820_type &&
+		    (prev->addr + prev->size) == d->phys_addr) {
+			prev->size += d->num_pages << 12;
+			continue;
+		}
+
+		if (nr_entries == ARRAY_SIZE(params->e820_table)) {
+			u32 need = (nr_desc - i) * sizeof(struct e820_entry) +
+				   sizeof(struct setup_data);
+
+			if (!e820ext || e820ext_size < need)
+				return EFI_BUFFER_TOO_SMALL;
+
+			/* boot_params map full, switch to e820 extended */
+			entry = (struct boot_e820_entry *)e820ext->data;
+		}
+
+		entry->addr = d->phys_addr;
+		entry->size = d->num_pages << PAGE_SHIFT;
+		entry->type = e820_type;
+		prev = entry++;
+		nr_entries++;
+	}
+
+	if (nr_entries > ARRAY_SIZE(params->e820_table)) {
+		u32 nr_e820ext = nr_entries - ARRAY_SIZE(params->e820_table);
+
+		add_e820ext(params, e820ext, nr_e820ext);
+		nr_entries -= nr_e820ext;
+	}
+
+	params->e820_entries = (u8)nr_entries;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
+				  u32 *e820ext_size)
+{
+	efi_status_t status;
+	unsigned long size;
+
+	size = sizeof(struct setup_data) +
+		sizeof(struct e820_entry) * nr_desc;
+
+	if (*e820ext) {
+		efi_bs_call(free_pool, *e820ext);
+		*e820ext = NULL;
+		*e820ext_size = 0;
+	}
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)e820ext);
+	if (status == EFI_SUCCESS)
+		*e820ext_size = size;
+
+	return status;
+}
+
+static efi_status_t allocate_e820(struct boot_params *params,
+				  struct setup_data **e820ext,
+				  u32 *e820ext_size)
+{
+	unsigned long map_size, desc_size, map_key;
+	efi_status_t status;
+	__u32 nr_desc, desc_version;
+
+	/* Only need the size of the mem map and size of each mem descriptor */
+	map_size = 0;
+	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
+			     &desc_size, &desc_version);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
+
+	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
+
+	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+
+		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+
+	return EFI_SUCCESS;
+}
+
+struct exit_boot_struct {
+	struct boot_params	*boot_params;
+	struct efi_info		*efi;
+};
+
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
+				   void *priv)
+{
+	const char *signature;
+	struct exit_boot_struct *p = priv;
+
+	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
+				   : EFI32_LOADER_SIGNATURE;
+	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
+
+	efi_set_u64_split((unsigned long)efi_system_table,
+			  &p->efi->efi_systab, &p->efi->efi_systab_hi);
+	p->efi->efi_memdesc_size	= map->desc_size;
+	p->efi->efi_memdesc_version	= map->desc_ver;
+	efi_set_u64_split((unsigned long)map->map,
+			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
+	p->efi->efi_memmap_size		= map->map_size;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
+{
+	struct setup_data *e820ext = NULL;
+	__u32 e820ext_size = 0;
+	efi_status_t status;
+	struct exit_boot_struct priv;
+
+	priv.boot_params	= boot_params;
+	priv.efi		= &boot_params->efi_info;
+
+	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	/* Might as well exit boot services now */
+	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	/* Historic? */
+	boot_params->alt_mem_k	= 32 * 1024;
+
+	status = setup_e820(boot_params, e820ext, e820ext_size);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t
+preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
+{
+	struct pci_setup_rom *rom = NULL;
+	efi_status_t status;
+	unsigned long size;
+	uint64_t romsize;
+	void *romimage;
+
+	/*
+	 * Some firmware images contain EFI function pointers at the place where
+	 * the romimage and romsize fields are supposed to be. Typically the EFI
+	 * code is mapped at high addresses, translating to an unrealistically
+	 * large romsize. The UEFI spec limits the size of option ROMs to 16
+	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
+	 */
+	romimage = efi_table_attr(pci, romimage);
+	romsize = efi_table_attr(pci, romsize);
+	if (!romimage || !romsize || romsize > SZ_16M)
+		return EFI_INVALID_PARAMETER;
+
+	size = romsize + sizeof(*rom);
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&rom);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate memory for 'rom'\n");
+		return status;
+	}
+
+	memset(rom, 0, sizeof(*rom));
+
+	rom->data.type	= SETUP_PCI;
+	rom->data.len	= size - sizeof(struct setup_data);
+	rom->data.next	= 0;
+	rom->pcilen	= pci->romsize;
+	*__rom = rom;
+
+	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+				PCI_VENDOR_ID, 1, &rom->vendor);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to read rom->vendor\n");
+		goto free_struct;
+	}
+
+	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+				PCI_DEVICE_ID, 1, &rom->devid);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to read rom->devid\n");
+		goto free_struct;
+	}
+
+	status = efi_call_proto(pci, get_location, &rom->segment, &rom->bus,
+				&rom->device, &rom->function);
+
+	if (status != EFI_SUCCESS)
+		goto free_struct;
+
+	memcpy(rom->romdata, romimage, romsize);
+	return status;
+
+free_struct:
+	efi_bs_call(free_pool, rom);
+	return status;
+}
+
+/*
+ * There's no way to return an informative status from this function,
+ * because any analysis (and printing of error messages) needs to be
+ * done directly at the EFI function call-site.
+ *
+ * For example, EFI_INVALID_PARAMETER could indicate a bug or maybe we
+ * just didn't find any PCI devices, but there's no way to tell outside
+ * the context of the call.
+ */
+static void setup_efi_pci(struct boot_params *params)
+{
+	efi_status_t status;
+	void **pci_handle = NULL;
+	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
+	unsigned long size = 0;
+	struct setup_data *data;
+	efi_handle_t h;
+	int i;
+
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &pci_proto, NULL, &size, pci_handle);
+
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+				     (void **)&pci_handle);
+
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to allocate memory for 'pci_handle'\n");
+			return;
+		}
+
+		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+				     &pci_proto, NULL, &size, pci_handle);
+	}
+
+	if (status != EFI_SUCCESS)
+		goto free_handle;
+
+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
+
+	while (data && data->next)
+		data = (struct setup_data *)(unsigned long)data->next;
+
+	for_each_efi_handle(h, pci_handle, size, i) {
+		efi_pci_io_protocol_t *pci = NULL;
+		struct pci_setup_rom *rom;
+
+		status = efi_bs_call(handle_protocol, h, &pci_proto,
+				     (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = preserve_pci_rom_image(pci, &rom);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		if (data)
+			data->next = (unsigned long)rom;
+		else
+			params->hdr.setup_data = (unsigned long)rom;
+
+		data = (struct setup_data *)rom;
+	}
+
+free_handle:
+	efi_bs_call(free_pool, pci_handle);
+}
+
+/*
+ * See if we have Universal Graphics Adapter (UGA) protocol
+ */
+static efi_status_t
+setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
+{
+	efi_status_t status;
+	u32 width, height;
+	void **uga_handle = NULL;
+	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
+	efi_handle_t handle;
+	int i;
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&uga_handle);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     uga_proto, NULL, &size, uga_handle);
+	if (status != EFI_SUCCESS)
+		goto free_handle;
+
+	height = 0;
+	width = 0;
+
+	first_uga = NULL;
+	for_each_efi_handle(handle, uga_handle, size, i) {
+		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
+		u32 w, h, depth, refresh;
+		void *pciio;
+
+		status = efi_bs_call(handle_protocol, handle, uga_proto,
+				     (void **)&uga);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		pciio = NULL;
+		efi_bs_call(handle_protocol, handle, &pciio_proto, &pciio);
+
+		status = efi_call_proto(uga, get_mode, &w, &h, &depth, &refresh);
+		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
+			width = w;
+			height = h;
+
+			/*
+			 * Once we've found a UGA supporting PCIIO,
+			 * don't bother looking any further.
+			 */
+			if (pciio)
+				break;
+
+			first_uga = uga;
+		}
+	}
+
+	if (!width && !height)
+		goto free_handle;
+
+	/* EFI framebuffer */
+	si->orig_video_isVGA	= VIDEO_TYPE_EFI;
+
+	si->lfb_depth		= 32;
+	si->lfb_width		= width;
+	si->lfb_height		= height;
+
+	si->red_size		= 8;
+	si->red_pos		= 16;
+	si->green_size		= 8;
+	si->green_pos		= 8;
+	si->blue_size		= 8;
+	si->blue_pos		= 0;
+	si->rsvd_size		= 8;
+	si->rsvd_pos		= 24;
+
+free_handle:
+	efi_bs_call(free_pool, uga_handle);
+
+	return status;
+}
+
+static void setup_graphics(struct boot_params *boot_params)
+{
+	efi_guid_t graphics_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
+	struct screen_info *si;
+	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
+	efi_status_t status;
+	unsigned long size;
+	void **gop_handle = NULL;
+	void **uga_handle = NULL;
+
+	si = &boot_params->screen_info;
+	memset(si, 0, sizeof(*si));
+
+	size = 0;
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &graphics_proto, NULL, &size, gop_handle);
+	if (status == EFI_BUFFER_TOO_SMALL)
+		status = efi_setup_gop(si, &graphics_proto, size);
+
+	if (status != EFI_SUCCESS) {
+		size = 0;
+		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+				     &uga_proto, NULL, &size, uga_handle);
+		if (status == EFI_BUFFER_TOO_SMALL)
+			setup_uga(si, &uga_proto, size);
+	}
+}
+
+static void retrieve_apple_device_properties(struct boot_params *boot_params)
+{
+	efi_guid_t guid = APPLE_PROPERTIES_PROTOCOL_GUID;
+	struct setup_data *data, *new;
+	efi_status_t status;
+	u32 size = 0;
+	apple_properties_protocol_t *p;
+
+	status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&p);
+	if (status != EFI_SUCCESS)
+		return;
+
+	if (efi_table_attr(p, version) != 0x10000) {
+		efi_err("Unsupported properties proto version\n");
+		return;
+	}
+
+	efi_call_proto(p, get_all, NULL, &size);
+	if (!size)
+		return;
+
+	do {
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+				     size + sizeof(struct setup_data),
+				     (void **)&new);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to allocate memory for 'properties'\n");
+			return;
+		}
+
+		status = efi_call_proto(p, get_all, new->data, &size);
+
+		if (status == EFI_BUFFER_TOO_SMALL)
+			efi_bs_call(free_pool, new);
+	} while (status == EFI_BUFFER_TOO_SMALL);
+
+	new->type = SETUP_APPLE_PROPERTIES;
+	new->len  = size;
+	new->next = 0;
+
+	data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
+	if (!data) {
+		boot_params->hdr.setup_data = (unsigned long)new;
+	} else {
+		while (data->next)
+			data = (struct setup_data *)(unsigned long)data->next;
+		data->next = (unsigned long)new;
+	}
+}
+
+static const efi_char16_t apple[] = L"Apple";
+
+static void setup_quirks(struct boot_params *boot_params)
+{
+	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
+		efi_table_attr(efi_system_table, fw_vendor);
+
+	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
+		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
+			retrieve_apple_device_properties(boot_params);
+	}
+}
+
+efi_status_t efi_x86_stub_common(struct boot_params *boot_params,
+				 efi_handle_t handle)
+{
+	efi_status_t status;
+
+	/*
+	 * If the boot loader gave us a value for secure_boot then we use that,
+	 * otherwise we ask the BIOS.
+	 */
+	if (boot_params->secure_boot == efi_secureboot_mode_unset)
+		boot_params->secure_boot = efi_get_secureboot();
+
+	/* Ask the firmware to clear memory on unclean shutdown */
+	efi_enable_reset_attack_mitigation();
+
+	efi_random_get_seed();
+
+	efi_retrieve_tpm2_eventlog();
+
+	setup_graphics(boot_params);
+
+	setup_efi_pci(boot_params);
+
+	setup_quirks(boot_params);
+
+	status = exit_boot(boot_params, handle);
+	if (status != EFI_SUCCESS)
+		efi_err("exit_boot() failed!\n");
+
+	return status;
+}
+
+struct boot_params *efi_alloc_boot_params(void)
+{
+	struct boot_params *boot_params;
+	efi_status_t status;
+
+	status = efi_allocate_pages(sizeof(struct boot_params),
+				    (unsigned long *)&boot_params, ULONG_MAX);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate lowmem for boot params\n");
+		return NULL;
+	}
+
+	memset(boot_params, 0x0, sizeof(struct boot_params));
+
+	/*
+	 * Fill out some of the header fields ourselves because the
+	 * EFI firmware loader doesn't load the first sector.
+	 */
+	boot_params->hdr.root_flags	= 1;
+	boot_params->hdr.vid_mode	= 0xffff;
+	boot_params->hdr.boot_flag	= 0xAA55;
+
+	return boot_params;
+}
-- 
2.39.2

