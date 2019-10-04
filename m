Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51598CBDF0
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfJDOvY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:51:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOvX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5A4A3CA06;
        Fri,  4 Oct 2019 14:51:22 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D625C3F8;
        Fri,  4 Oct 2019 14:51:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
Date:   Fri,  4 Oct 2019 16:50:50 +0200
Message-Id: <20191004145056.43267-3-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 04 Oct 2019 14:51:23 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Just like with PCI options ROMs, which we save in the setup_efi_pci*
functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itself
sometimes may contain data which is useful/necessary for peripheral drivers
to have access to.

Specifically the EFI code may contain an embedded copy of firmware which
needs to be (re)loaded into the peripheral. Normally such firmware would be
part of linux-firmware, but in some cases this is not feasible, for 2
reasons:

1) The firmware is customized for a specific use-case of the chipset / use
with a specific hardware model, so we cannot have a single firmware file
for the chipset. E.g. touchscreen controller firmwares are compiled
specifically for the hardware model they are used with, as they are
calibrated for a specific model digitizer.

2) Despite repeated attempts we have failed to get permission to
redistribute the firmware. This is especially a problem with customized
firmwares, these get created by the chip vendor for a specific ODM and the
copyright may partially belong with the ODM, so the chip vendor cannot
give a blanket permission to distribute these.

This commit adds support for finding peripheral firmware embedded in the
EFI code and makes the found firmware available through the new
efi_get_embedded_fw() function.

Support for loading these firmwares through the standard firmware loading
mechanism is added in a follow-up commit in this patch-series.

Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the end
of start_kernel(), just before calling rest_init(), this is on purpose
because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large for
early_memremap(), so the check must be done after mm_init(). This relies
on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services()
is called, which means that this will only work on x86 for now.

Reported-by: Dave Olsthoorn <dave@bewaar.me>
Suggested-by: Peter Jones <pjones@redhat.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
  2 patches
- Use new, standalone, lib/crypto/sha256.c code

Changes in v6:
- Rework code to remove casts from if (prefix == mem) comparison
- Use SHA256 hashes instead of crc32 sums
- Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
- Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
  to check if this is allowed before looking at EFI embedded fw
- Document why we are not using the UEFI PI Firmware Volume protocol

Changes in v5:
- Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
- Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
  UEFI proper, so the EFI maintainers don't want us referring people to it
- Use new EFI_BOOT_SERVICES flag
- Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
  file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
- Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
  EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
  in firmware_loader/main.c
- Properly call security_kernel_post_read_file() on the firmware returned
  by efi_get_embedded_fw() to make sure that we are allowed to use it

Changes in v3:
- Fix the docs using "efi-embedded-fw" as property name instead of
  "efi-embedded-firmware"

Changes in v2:
- Rebased on driver-core/driver-core-next
- Add documentation describing the EFI embedded firmware mechanism to:
  Documentation/driver-api/firmware/request_firmware.rst
- Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
  fw support if this is set. This is an invisible option which should be
  selected by drivers which need this
- Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
  from the efi-embedded-fw code, instead drivers using this are expected to
  export a dmi_system_id array, with each entries' driver_data pointing to a
  efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
- Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
  this avoids us messing with the EFI memmap and avoids the need to make
  changes to efi_mem_desc_lookup()
- Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
  passed in device has the "efi-embedded-firmware" device-property bool set
- Skip usermodehelper fallback when "efi-embedded-firmware" device-property
  is set
---
 arch/x86/platform/efi/efi.c              |   1 +
 drivers/firmware/efi/Kconfig             |   4 +
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/embedded-firmware.c | 143 +++++++++++++++++++++++
 include/linux/efi.h                      |   6 +
 include/linux/efi_embedded_fw.h          |  25 ++++
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/firmware/efi/embedded-firmware.c
 create mode 100644 include/linux/efi_embedded_fw.h

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 847730f7e74b..5db2cc011dc1 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -1019,6 +1019,7 @@ static void __init __efi_enter_virtual_mode(void)
 		panic("EFI call to SetVirtualAddressMap() failed!");
 	}
 
+	efi_check_for_embedded_firmwares();
 	efi_free_boot_services();
 
 	/*
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..c2c003326265 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -193,6 +193,10 @@ config EFI_RCI2_TABLE
 
 	  Say Y here for Dell EMC PowerEdge systems.
 
+config EFI_EMBEDDED_FIRMWARE
+	bool
+	select CRYPTO_LIB_SHA256
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 4ac2de4dfa72..42bd310657f4 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
+obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 
 arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
new file mode 100644
index 000000000000..75d652f3148b
--- /dev/null
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for extracting embedded firmware for peripherals from EFI code,
+ *
+ * Copyright (c) 2018 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/efi_embedded_fw.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <crypto/sha.h>
+
+struct embedded_fw {
+	struct list_head list;
+	const char *name;
+	void *data;
+	size_t length;
+};
+
+static LIST_HEAD(found_fw_list);
+
+static const struct dmi_system_id * const embedded_fw_table[] = {
+	NULL
+};
+
+/*
+ * Note the efi_check_for_embedded_firmwares() code currently makes the
+ * following 2 assumptions. This may needs to be revisited if embedded firmware
+ * is found where this is not true:
+ * 1) The firmware is only found in EFI_BOOT_SERVICES_CODE memory segments
+ * 2) The firmware always starts at an offset which is a multiple of 8 bytes
+ */
+static int __init efi_check_md_for_embedded_firmware(
+	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
+{
+	const u64 prefix = *((u64 *)desc->prefix);
+	struct sha256_state sctx;
+	struct embedded_fw *fw;
+	u8 sha256[32];
+	u64 i, size;
+	void *map;
+
+	size = md->num_pages << EFI_PAGE_SHIFT;
+	map = memremap(md->phys_addr, size, MEMREMAP_WB);
+	if (!map) {
+		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
+		return -ENOMEM;
+	}
+
+	size -= desc->length;
+	for (i = 0; i < size; i += 8) {
+		u64 *mem = map + i;
+
+		if (*mem != prefix)
+			continue;
+
+		sha256_init(&sctx);
+		sha256_update(&sctx, map + i, desc->length);
+		sha256_final(&sctx, sha256);
+		if (memcmp(sha256, desc->sha256, 32) == 0)
+			break;
+	}
+	if (i >= size) {
+		memunmap(map);
+		return -ENOENT;
+	}
+
+	pr_info("Found EFI embedded fw '%s'\n", desc->name);
+
+	fw = kmalloc(sizeof(*fw), GFP_KERNEL);
+	if (!fw) {
+		memunmap(map);
+		return -ENOMEM;
+	}
+
+	fw->data = kmemdup(map + i, desc->length, GFP_KERNEL);
+	memunmap(map);
+	if (!fw->data) {
+		kfree(fw);
+		return -ENOMEM;
+	}
+
+	fw->name = desc->name;
+	fw->length = desc->length;
+	list_add(&fw->list, &found_fw_list);
+
+	return 0;
+}
+
+void __init efi_check_for_embedded_firmwares(void)
+{
+	const struct efi_embedded_fw_desc *fw_desc;
+	const struct dmi_system_id *dmi_id;
+	efi_memory_desc_t *md;
+	int i, r;
+
+	for (i = 0; embedded_fw_table[i]; i++) {
+		dmi_id = dmi_first_match(embedded_fw_table[i]);
+		if (!dmi_id)
+			continue;
+
+		fw_desc = dmi_id->driver_data;
+		for_each_efi_memory_desc(md) {
+			if (md->type != EFI_BOOT_SERVICES_CODE)
+				continue;
+
+			r = efi_check_md_for_embedded_firmware(md, fw_desc);
+			if (r == 0)
+				break;
+		}
+	}
+}
+
+int efi_get_embedded_fw(const char *name, void **data, size_t *size)
+{
+	struct embedded_fw *iter, *fw = NULL;
+	void *buf = *data;
+
+	list_for_each_entry(iter, &found_fw_list, list) {
+		if (strcmp(name, iter->name) == 0) {
+			fw = iter;
+			break;
+		}
+	}
+
+	if (!fw)
+		return -ENOENT;
+
+	buf = vmalloc(fw->length);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, fw->data, fw->length);
+	*size = fw->length;
+	*data = buf;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(efi_get_embedded_fw);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2a30a1bd8bdf..429634be3ecf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1632,6 +1632,12 @@ static inline void
 efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 #endif
 
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+void efi_check_for_embedded_firmwares(void);
+#else
+static inline void efi_check_for_embedded_firmwares(void) { }
+#endif
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
 /*
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
new file mode 100644
index 000000000000..ac70ff146d58
--- /dev/null
+++ b/include/linux/efi_embedded_fw.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EFI_EMBEDDED_FW_H
+#define _LINUX_EFI_EMBEDDED_FW_H
+
+#include <linux/mod_devicetable.h>
+
+/**
+ * struct efi_embedded_fw_desc - This struct is used by the EFI embedded-fw
+ *                               code to search for embedded firmwares.
+ *
+ * @name:   Name to register the firmware with if found
+ * @prefix: First 8 bytes of the firmware
+ * @length: Length of the firmware in bytes including prefix
+ * @sha256: SHA256 of the firmware
+ */
+struct efi_embedded_fw_desc {
+	const char *name;
+	u8 prefix[8];
+	u32 length;
+	u8 sha256[32];
+};
+
+int efi_get_embedded_fw(const char *name, void **dat, size_t *sz);
+
+#endif
-- 
2.23.0

