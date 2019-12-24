Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981AE12A2C2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLXPLY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfLXPLV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:21 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8F920706;
        Tue, 24 Dec 2019 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200280;
        bh=lU3wbNRnxJSjaN1Fj0CStvzmViQE35LF9RQXbonPEj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xq3gx+uqRCmMw5+yPB9TykVfqAuHZcdHsQogmkCG0YVl3g9p2VNkPJ+utJrDD8OmX
         sIv1f1VdOxRFL/Z7W7Cksi6pBigIeJCzPybcJE/Qt3xAtcU2xYu7LYjG5ioLgmf7W9
         +d3vwVkeBdxpFhhHjo8n0XlQp6CMY/DB09I4tbwU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 22/25] efi/libstub: drop 'table' argument from efi_table_attr() macro
Date:   Tue, 24 Dec 2019 16:10:22 +0100
Message-Id: <20191224151025.32482-23-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

None of the definitions of the efi_table_attr() still refer to
their 'table' argument so let's get rid of it entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                    |  3 +--
 arch/arm64/include/asm/efi.h                  |  3 +--
 arch/x86/boot/compressed/eboot.c              |  8 +++---
 arch/x86/include/asm/efi.h                    | 25 +++++++------------
 .../firmware/efi/libstub/efi-stub-helper.c    | 11 +++-----
 drivers/firmware/efi/libstub/gop.c            |  9 +++----
 6 files changed, 22 insertions(+), 37 deletions(-)

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
index 751fd5fc3367..cccd9e16b329 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -47,8 +47,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	 * large romsize. The UEFI spec limits the size of option ROMs to 16
 	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
 	 */
-	romimage = efi_table_attr(efi_pci_io_protocol, romimage, pci);
-	romsize = efi_table_attr(efi_pci_io_protocol, romsize, pci);
+	romimage = efi_table_attr(pci, romimage);
+	romsize = efi_table_attr(pci, romsize);
 	if (!romimage || !romsize || romsize > SZ_16M)
 		return EFI_INVALID_PARAMETER;
 
@@ -183,7 +183,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	if (status != EFI_SUCCESS)
 		return;
 
-	if (efi_table_attr(apple_properties_protocol, version, p) != 0x10000) {
+	if (efi_table_attr(p, version) != 0x10000) {
 		efi_printk("Unsupported properties proto version\n");
 		return;
 	}
@@ -226,7 +226,7 @@ static const efi_char16_t apple[] = L"Apple";
 static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor, sys_table);
+		efi_table_attr(efi_system_table(), fw_vendor);
 
 	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b7cd14e3a634..39814a0a92f7 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -216,16 +216,11 @@ static inline bool efi_is_native(void)
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
@@ -235,16 +230,14 @@ static inline bool efi_is_native(void)
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
index 48eab7b9d066..8754ec04788b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -933,17 +933,15 @@ efi_status_t efi_exit_boot_services(void *handle,
 
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
@@ -953,7 +951,6 @@ void *get_efi_config_table(efi_guid_t guid)
 
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
2.20.1

