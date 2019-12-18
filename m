Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B0124EB5
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLRRDT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRRDS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:18 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2112465E;
        Wed, 18 Dec 2019 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688597;
        bh=OLoWtStn3n1L6WL3y0UsrWphoPH/85dVoRcILlT/0k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dB86lx/+Nm305aN1bTjcEcEPkEaqW1so82IUTRuULZ53/vEdKFPO2ktTyII549oKN
         9G+0soQAi5gi3eHuH68Mcr8VBZ8CAVeqLbuoD0BMeZpkEwBfBxCPyG/gSDwsNdC61/
         Me7LpWwzemVNl11FkBF958taboAk4o1CJvZE+13s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 16/21] efi/libstub: drop protocol argument from efi_call_proto() macro
Date:   Wed, 18 Dec 2019 19:01:34 +0200
Message-Id: <20191218170139.9468-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After refactoring the mixed mode support code, efi_call_proto()
no longer uses its protocol argument in any of its implementation,
so let's remove it altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                     |  3 +--
 arch/arm64/include/asm/efi.h                   |  3 +--
 arch/x86/boot/compressed/eboot.c               | 23 ++++++++------------
 arch/x86/include/asm/efi.h                     |  6 ++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 22 ++++++++-----------
 drivers/firmware/efi/libstub/random.c          |  8 +++----
 drivers/firmware/efi/libstub/tpm.c             | 11 +++++-----
 7 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 58e5acc424a0..bdc5288cc643 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -57,8 +57,7 @@ void efi_virtmap_unload(void);
 #define efi_table_attr(table, attr, instance)				\
 	instance->attr
 
-#define efi_call_proto(protocol, f, instance, ...)			\
-	instance->f(instance, ##__VA_ARGS__)
+#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 
 struct screen_info *alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index d73693177f31..4bc1e89671ab 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -100,8 +100,7 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 #define efi_table_attr(table, attr, instance)				\
 	instance->attr
 
-#define efi_call_proto(protocol, f, instance, ...)			\
-	instance->f(instance, ##__VA_ARGS__)
+#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 
 #define alloc_screen_info(x...)		&screen_info
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index b4e859399451..da3e7509bbe7 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -76,27 +76,24 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->pcilen	= pci->romsize;
 	*__rom = rom;
 
-	status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
-				EfiPciIoWidthUint16, PCI_VENDOR_ID, 1,
-				&rom->vendor);
+	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+				PCI_VENDOR_ID, 1, &rom->vendor);
 
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to read rom->vendor\n");
 		goto free_struct;
 	}
 
-	status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
-				EfiPciIoWidthUint16, PCI_DEVICE_ID, 1,
-				&rom->devid);
+	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+				PCI_DEVICE_ID, 1, &rom->devid);
 
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to read rom->devid\n");
 		goto free_struct;
 	}
 
-	status = efi_call_proto(efi_pci_io_protocol, get_location, pci,
-				&rom->segment, &rom->bus, &rom->device,
-				&rom->function);
+	status = efi_call_proto(pci, get_location, &rom->segment, &rom->bus,
+				&rom->device, &rom->function);
 
 	if (status != EFI_SUCCESS)
 		goto free_struct;
@@ -198,7 +195,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		return;
 	}
 
-	efi_call_proto(apple_properties_protocol, get_all, p, NULL, &size);
+	efi_call_proto(p, get_all, NULL, &size);
 	if (!size)
 		return;
 
@@ -211,8 +208,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 			return;
 		}
 
-		status = efi_call_proto(apple_properties_protocol, get_all, p,
-					new->data, &size);
+		status = efi_call_proto(p, get_all, new->data, &size);
 
 		if (status == EFI_BUFFER_TOO_SMALL)
 			efi_call_early(free_pool, new);
@@ -287,8 +283,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 		pciio = NULL;
 		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
 
-		status = efi_call_proto(efi_uga_draw_protocol, get_mode, uga,
-					&w, &h, &depth, &refresh);
+		status = efi_call_proto(uga, get_mode, &w, &h, &depth, &refresh);
 		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
 			width = w;
 			height = h;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8137d4f5c104..7bdd2fb11e7c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -236,10 +236,10 @@ static inline bool efi_is_native(void)
 	__ret;								\
 })
 
-#define efi_call_proto(protocol, f, instance, ...)			\
+#define efi_call_proto(inst, func, ...)					\
 	(efi_is_native()						\
-		? instance->f(instance, ##__VA_ARGS__)			\
-		: efi64_thunk(instance->mixed_mode.f, instance,	##__VA_ARGS__))
+		? inst->func(inst, ##__VA_ARGS__)			\
+		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
 
 #define efi_call_early(f, ...)						\
 	(efi_is_native()						\
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 2ddeb312e8e5..4117813a1707 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -370,8 +370,8 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
 	unsigned long info_sz;
 
-	status = efi_call_proto(efi_file_handle, open, fh, &h, filename_16,
-				EFI_FILE_MODE_READ, (u64)0);
+	status = efi_call_proto(fh, open, &h, filename_16, EFI_FILE_MODE_READ,
+				(u64)0);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to open file: ");
 		efi_char16_printk(filename_16);
@@ -382,8 +382,7 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 	*handle = h;
 
 	info_sz = 0;
-	status = efi_call_proto(efi_file_handle, get_info, h, &info_guid,
-				&info_sz, NULL);
+	status = efi_call_proto(h, get_info, &info_guid, &info_sz, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL) {
 		efi_printk("Failed to get file info size\n");
 		return status;
@@ -397,8 +396,7 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 		return status;
 	}
 
-	status = efi_call_proto(efi_file_handle, get_info, h, &info_guid,
-				&info_sz, info);
+	status = efi_call_proto(h, get_info, &info_guid, &info_sz, info);
 	if (status == EFI_BUFFER_TOO_SMALL) {
 		efi_call_early(free_pool, info);
 		goto grow;
@@ -416,12 +414,12 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 static efi_status_t efi_file_read(efi_file_handle_t *handle,
 				  unsigned long *size, void *addr)
 {
-	return efi_call_proto(efi_file_handle, read, handle, size, addr);
+	return efi_call_proto(handle, read, size, addr);
 }
 
 static efi_status_t efi_file_close(efi_file_handle_t *handle)
 {
-	return efi_call_proto(efi_file_handle, close, handle);
+	return efi_call_proto(handle, close);
 }
 
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
@@ -440,7 +438,7 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 		return status;
 	}
 
-	status = efi_call_proto(efi_file_io_interface, open_volume, io, &fh);
+	status = efi_call_proto(io, open_volume, &fh);
 	if (status != EFI_SUCCESS)
 		efi_printk("Failed to open volume\n");
 	else
@@ -969,9 +967,7 @@ void *get_efi_config_table(efi_guid_t guid)
 
 void efi_char16_printk(efi_char16_t *str)
 {
-	efi_call_proto(efi_simple_text_output_protocol,
-		       output_string,
-		       efi_table_attr(efi_system_table, con_out,
+	efi_call_proto(efi_table_attr(efi_system_table, con_out,
 				      efi_system_table()),
-		       str);
+		       output_string, str);
 }
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 9b30d953d13b..fbd5b5724b19 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -37,7 +37,7 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	return efi_call_proto(efi_rng_protocol, get_rng, rng, NULL, size, out);
+	return efi_call_proto(rng, get_rng, NULL, size, out);
 }
 
 /*
@@ -173,7 +173,7 @@ efi_status_t efi_random_get_seed(void)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = efi_call_proto(efi_rng_protocol, get_rng, rng, &rng_algo_raw,
+	status = efi_call_proto(rng, get_rng, &rng_algo_raw,
 				 EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status == EFI_UNSUPPORTED)
@@ -181,8 +181,8 @@ efi_status_t efi_random_get_seed(void)
 		 * Use whatever algorithm we have available if the raw algorithm
 		 * is not implemented.
 		 */
-		status = efi_call_proto(efi_rng_protocol, get_rng, rng, NULL,
-					 EFI_RANDOM_SEED_SIZE, seed->bits);
+		status = efi_call_proto(rng, get_rng, NULL,
+					EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 9fae0850e2ac..dbb4b3cfc4e8 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -77,15 +77,14 @@ void efi_retrieve_tpm2_eventlog(void)
 	if (status != EFI_SUCCESS)
 		return;
 
-	status = efi_call_proto(efi_tcg2_protocol, get_event_log,
-				tcg2_protocol, version, &log_location,
-				&log_last_entry, &truncated);
+	status = efi_call_proto(tcg2_protocol, get_event_log, version,
+				&log_location, &log_last_entry, &truncated);
 
 	if (status != EFI_SUCCESS || !log_location) {
 		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
-		status = efi_call_proto(efi_tcg2_protocol, get_event_log,
-					tcg2_protocol, version, &log_location,
-					&log_last_entry, &truncated);
+		status = efi_call_proto(tcg2_protocol, get_event_log, version,
+					&log_location, &log_last_entry,
+					&truncated);
 		if (status != EFI_SUCCESS || !log_location)
 			return;
 
-- 
2.17.1

