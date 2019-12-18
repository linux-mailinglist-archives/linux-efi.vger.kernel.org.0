Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96240124EB9
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLRRDV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfLRRDV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:21 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5343227BF;
        Wed, 18 Dec 2019 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688600;
        bh=WgbTRG6Wud263XM1sXo40IuXMDK3kqjuWMjKIuwbqAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXxCP6bbc1uEeDd/V9Ct2lT59ZVUkqwh+k2La2Wx2eKbqHBZjjru1zg/cnZK6nnKC
         n1bYHEp+eK4znPkehB+qTpC/tc3hk3PgNcfxuwpStv5577mOh0r6cI3U2YzQ/umUDm
         69iyq6u1pfxgMXLn2iJyPtK3Vm7sCZDya51XOApE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 17/21] efi/libstub: drop 'table' argument from efi_table_attr() macro
Date:   Wed, 18 Dec 2019 19:01:35 +0200
Message-Id: <20191218170139.9468-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

None of the definitions of the efi_table_attr() still refer to
their 'table' argument so let's get rid of it entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                     |  3 +--
 arch/arm64/include/asm/efi.h                   |  3 +--
 arch/x86/boot/compressed/eboot.c               |  8 +++----
 arch/x86/include/asm/efi.h                     | 25 +++++++-------------
 drivers/firmware/efi/libstub/efi-stub-helper.c | 13 ++++------
 drivers/firmware/efi/libstub/gop.c             |  9 +++----
 6 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index bdc5288cc643..bc720024a260 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -54,8 +54,7 @@ void efi_virtmap_unload(void);
 #define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
 #define efi_is_native()			(true)
 
-#define efi_table_attr(table, attr, instance)				\
-	instance->attr
+#define efi_table_attr(inst, attr)	(inst->attr)
 
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 4bc1e89671ab..6f041ae446d2 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -97,8 +97,7 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 #define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
 #define efi_is_native()			(true)
 
-#define efi_table_attr(table, attr, instance)				\
-	instance->attr
+#define efi_table_attr(inst, attr)	(inst->attr)
 
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index da3e7509bbe7..a3000283dc7a 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -54,8 +54,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	 * large romsize. The UEFI spec limits the size of option ROMs to 16
 	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
 	 */
-	romimage = efi_table_attr(efi_pci_io_protocol, romimage, pci);
-	romsize = efi_table_attr(efi_pci_io_protocol, romsize, pci);
+	romimage = efi_table_attr(pci, romimage);
+	romsize = efi_table_attr(pci, romsize);
 	if (!romimage || !romsize || romsize > SZ_16M)
 		return EFI_INVALID_PARAMETER;
 
@@ -190,7 +190,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	if (status != EFI_SUCCESS)
 		return;
 
-	if (efi_table_attr(apple_properties_protocol, version, p) != 0x10000) {
+	if (efi_table_attr(p, version) != 0x10000) {
 		efi_printk("Unsupported properties proto version\n");
 		return;
 	}
@@ -233,7 +233,7 @@ static const efi_char16_t apple[] = L"Apple";
 static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor, sys_table);
+		efi_table_attr(efi_system_table(), fw_vendor);
 
 	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 7bdd2fb11e7c..593a8cda8361 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -225,16 +225,11 @@ static inline bool efi_is_native(void)
 		__builtin_types_compatible_p(u32, __typeof__(attr)),	\
 			(unsigned long)(attr), (attr))
 
-#define efi_table_attr(table, attr, instance) ({			\
-	__typeof__(instance->attr) __ret;				\
-	if (efi_is_native()) {						\
-		__ret = instance->attr;					\
-	} else {							\
-		__ret = (__typeof__(__ret))				\
-			efi_mixed_mode_cast(instance->mixed_mode.attr);	\
-	}								\
-	__ret;								\
-})
+#define efi_table_attr(inst, attr)					\
+	(efi_is_native()						\
+		? inst->attr						\
+		: (__typeof__(inst->attr))				\
+			efi_mixed_mode_cast(inst->mixed_mode.attr))
 
 #define efi_call_proto(inst, func, ...)					\
 	(efi_is_native()						\
@@ -244,16 +239,14 @@ static inline bool efi_is_native(void)
 #define efi_call_early(f, ...)						\
 	(efi_is_native()						\
 		? efi_system_table()->boottime->f(__VA_ARGS__)		\
-		: efi64_thunk(efi_table_attr(efi_boot_services,		\
-			boottime, efi_system_table())->mixed_mode.f,	\
-			__VA_ARGS__))
+		: efi64_thunk(efi_table_attr(efi_system_table(),	\
+				boottime)->mixed_mode.f, __VA_ARGS__))
 
 #define efi_call_runtime(f, ...)					\
 	(efi_is_native()						\
 		? efi_system_table()->runtime->f(__VA_ARGS__)		\
-		: efi64_thunk(efi_table_attr(efi_runtime_services,	\
-			runtime, efi_system_table())->mixed_mode.f,	\
-			__VA_ARGS__))
+		: efi64_thunk(efi_table_attr(efi_system_table(),	\
+				runtime)->mixed_mode.f, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 4117813a1707..59c273cb7a92 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -429,7 +429,7 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 	efi_file_handle_t *fh;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_status_t status;
-	void *handle = efi_table_attr(efi_loaded_image, device_handle, image);
+	void *handle = efi_table_attr(image, device_handle);
 
 	status = efi_call_early(handle_protocol, handle,
 				&fs_proto, (void **)&io);
@@ -947,17 +947,15 @@ efi_status_t efi_exit_boot_services(void *handle,
 
 void *get_efi_config_table(efi_guid_t guid)
 {
-	unsigned long tables = efi_table_attr(efi_system_table, tables,
-					      efi_system_table());
-	int nr_tables = efi_table_attr(efi_system_table, nr_tables,
-				       efi_system_table());
+	unsigned long tables = efi_table_attr(efi_system_table(), tables);
+	int nr_tables = efi_table_attr(efi_system_table(), nr_tables);
 	int i;
 
 	for (i = 0; i < nr_tables; i++) {
 		efi_config_table_t *t = (void *)tables;
 
 		if (efi_guidcmp(t->guid, guid) == 0)
-			return efi_table_attr(efi_config_table, table, t);
+			return efi_table_attr(t, table);
 
 		tables += efi_is_native() ? sizeof(efi_config_table_t)
 					  : sizeof(efi_config_table_32_t);
@@ -967,7 +965,6 @@ void *get_efi_config_table(efi_guid_t guid)
 
 void efi_char16_printk(efi_char16_t *str)
 {
-	efi_call_proto(efi_table_attr(efi_system_table, con_out,
-				      efi_system_table()),
+	efi_call_proto(efi_table_attr(efi_system_table(), con_out),
 		       output_string, str);
 }
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index c3afe8d4a688..8f746282c219 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -85,9 +85,6 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-#define efi_gop_attr(table, attr, instance) \
-	(efi_table_attr(efi_graphics_output_protocol##table, attr, instance))
-
 static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 			      unsigned long size, void **handles)
 {
@@ -123,9 +120,9 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		mode = (void *)(unsigned long)efi_gop_attr(, mode, gop);
-		info = (void *)(unsigned long)efi_gop_attr(_mode, info, mode);
-		current_fb_base = efi_gop_attr(_mode, frame_buffer_base, mode);
+		mode = efi_table_attr(gop, mode);
+		info = efi_table_attr(mode, info);
+		current_fb_base = efi_table_attr(mode, frame_buffer_base);
 
 		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
-- 
2.17.1

