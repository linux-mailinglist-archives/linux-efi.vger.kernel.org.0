Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4213C989
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAOQgR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:36:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41498 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729037AbgAOQgR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579106176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lb0NDxMEx0ddgTbHUh0qQbJhrjsgTsDPRcVNGdh2q24=;
        b=CSjTlGm4QCRPHvWkei3DbeNI0HL775jk1H2iTd32oJYwZm03snmcTyR3rnojBn9nlNLiba
        Qh9sw01fk+QglL++r3MCCaI5oXUyZNQV3jgiMDCJqqYM0xQySTojpX2A3LMk+4NKid+nvd
        aXihJn/IEwtmDCysSUNEIl2nd/eIsaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-qaQDJskDPCOS_wPla5GI2g-1; Wed, 15 Jan 2020 11:36:15 -0500
X-MC-Unique: qaQDJskDPCOS_wPla5GI2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C88100550E;
        Wed, 15 Jan 2020 16:36:12 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com [10.36.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6318C5DA76;
        Wed, 15 Jan 2020 16:36:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
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
        linux-input@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v12 02/10] efi: Add embedded peripheral firmware support
Date:   Wed, 15 Jan 2020 17:35:46 +0100
Message-Id: <20200115163554.101315-3-hdegoede@redhat.com>
In-Reply-To: <20200115163554.101315-1-hdegoede@redhat.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Just like with PCI options ROMs, which we save in the setup_efi_pci*
functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itsel=
f
sometimes may contain data which is useful/necessary for peripheral drive=
rs
to have access to.

Specifically the EFI code may contain an embedded copy of firmware which
needs to be (re)loaded into the peripheral. Normally such firmware would =
be
part of linux-firmware, but in some cases this is not feasible, for 2
reasons:

1) The firmware is customized for a specific use-case of the chipset / us=
e
with a specific hardware model, so we cannot have a single firmware file
for the chipset. E.g. touchscreen controller firmwares are compiled
specifically for the hardware model they are used with, as they are
calibrated for a specific model digitizer.

2) Despite repeated attempts we have failed to get permission to
redistribute the firmware. This is especially a problem with customized
firmwares, these get created by the chip vendor for a specific ODM and th=
e
copyright may partially belong with the ODM, so the chip vendor cannot
give a blanket permission to distribute these.

This commit adds support for finding peripheral firmware embedded in the
EFI code and makes the found firmware available through the new
efi_get_embedded_fw() function.

Support for loading these firmwares through the standard firmware loading
mechanism is added in a follow-up commit in this patch-series.

Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the e=
nd
of start_kernel(), just before calling rest_init(), this is on purpose
because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large fo=
r
early_memremap(), so the check must be done after mm_init(). This relies
on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services(=
)
is called, which means that this will only work on x86 for now.

Reported-by: Dave Olsthoorn <dave@bewaar.me>
Suggested-by: Peter Jones <pjones@redhat.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v12:
- Use memcmp instead of type-punned pointer casting to compare the prefix
- Make efi_get_embedded_fw() return a const u8 * pointer to the
  efi_embedded_fw copy of the firmware instead of doing a vmemdup and
  and returning that

Changes in v9:
- At least touchscreen_dmi.c uses the same dmi_table for its own private
  data and the fw_desc structs, putting the fw_desc struct first in the
  data driver_data points to so that the dmi_table can be shared with
  efi_check_for_embedded_firmwares(). But not all entries there have
  embedded-fw so in some cases the fw_desc is empty (zero-ed out).
  This can lead to a possible crash because fw_desc->length now is
  less then 8, so if the segment size is close enough to a multiple of th=
e
  page_size, then the memcmp to check the prefix my segfault. Crashing th=
e
  machine. v9 checks for and skips these empty fw_desc entries avoiding t=
his.
- Rename found_fw_list to efi_embedded_fw_list and export it for use by
  lib/test_firmware.c

Changes in v8:
- Properly deal with the (theoretical?) case of an EFI segment being
  smaller then the fw we are looking for
- Log a warning when efi_get_embedded_fw get called while we did not (yet=
)
  check for embedded firmwares

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes int=
o
  2 patches
- Use new, standalone, lib/crypto/sha256.c code

Changes in v6:
- Rework code to remove casts from if (prefix =3D=3D mem) comparison
- Use SHA256 hashes instead of crc32 sums
- Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
- Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
  to check if this is allowed before looking at EFI embedded fw
- Document why we are not using the UEFI PI Firmware Volume protocol

Changes in v5:
- Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
- Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
  UEFI proper, so the EFI maintainers don't want us referring people to i=
t
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
- Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedde=
d
  fw support if this is set. This is an invisible option which should be
  selected by drivers which need this
- Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
  from the efi-embedded-fw code, instead drivers using this are expected =
to
  export a dmi_system_id array, with each entries' driver_data pointing t=
o a
  efi_embedded_fw_desc struct and register this with the efi-embedded-fw =
code
- Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmwar=
e,
  this avoids us messing with the EFI memmap and avoids the need to make
  changes to efi_mem_desc_lookup()
- Make the firmware-loader code only fallback to efi_get_embedded_fw() if=
 the
  passed in device has the "efi-embedded-firmware" device-property bool s=
et
- Skip usermodehelper fallback when "efi-embedded-firmware" device-proper=
ty
  is set
---
 arch/x86/platform/efi/efi.c              |   1 +
 drivers/firmware/efi/Kconfig             |   5 +
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/embedded-firmware.c | 147 +++++++++++++++++++++++
 include/linux/efi.h                      |   6 +
 include/linux/efi_embedded_fw.h          |  41 +++++++
 6 files changed, 201 insertions(+)
 create mode 100644 drivers/firmware/efi/embedded-firmware.c
 create mode 100644 include/linux/efi_embedded_fw.h

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 51ee2e2a18d6..cc10a925d9e7 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -944,6 +944,7 @@ static void __init __efi_enter_virtual_mode(void)
 		goto err;
 	}
=20
+	efi_check_for_embedded_firmwares();
 	efi_free_boot_services();
=20
 	/*
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index ecc83e2f032c..613828d3f106 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -239,6 +239,11 @@ config EFI_DISABLE_PCI_DMA
=20
 endmenu
=20
+config EFI_EMBEDDED_FIRMWARE
+	bool
+	depends on EFI
+	select CRYPTO_LIB_SHA256
+
 config UEFI_CPER
 	bool
=20
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefil=
e
index 554d795270d9..256d6121b2b3 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_TEST)			+=3D test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+=3D dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+=3D apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+=3D rci2-table.o
+obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+=3D embedded-firmware.o
=20
 fake_map-y				+=3D fake_mem.o
 fake_map-$(CONFIG_X86)			+=3D x86_fake_mem.o
diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/=
efi/embedded-firmware.c
new file mode 100644
index 000000000000..1bc9cdae2eed
--- /dev/null
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for extracting embedded firmware for peripherals from EFI cod=
e,
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
+/* Exported for use by lib/test_firmware.c only */
+LIST_HEAD(efi_embedded_fw_list);
+EXPORT_SYMBOL_GPL(efi_embedded_fw_list);
+
+static bool checked_for_fw;
+
+static const struct dmi_system_id * const embedded_fw_table[] =3D {
+	NULL
+};
+
+/*
+ * Note the efi_check_for_embedded_firmwares() code currently makes the
+ * following 2 assumptions. This may needs to be revisited if embedded f=
irmware
+ * is found where this is not true:
+ * 1) The firmware is only found in EFI_BOOT_SERVICES_CODE memory segmen=
ts
+ * 2) The firmware always starts at an offset which is a multiple of 8 b=
ytes
+ */
+static int __init efi_check_md_for_embedded_firmware(
+	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
+{
+	struct sha256_state sctx;
+	struct efi_embedded_fw *fw;
+	u8 sha256[32];
+	u64 i, size;
+	u8 *map;
+
+	size =3D md->num_pages << EFI_PAGE_SHIFT;
+	map =3D memremap(md->phys_addr, size, MEMREMAP_WB);
+	if (!map) {
+		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
+		return -ENOMEM;
+	}
+
+	for (i =3D 0; (i + desc->length) <=3D size; i +=3D 8) {
+		if (memcmp(map + i, desc->prefix, EFI_EMBEDDED_FW_PREFIX_LEN))
+			continue;
+
+		sha256_init(&sctx);
+		sha256_update(&sctx, map + i, desc->length);
+		sha256_final(&sctx, sha256);
+		if (memcmp(sha256, desc->sha256, 32) =3D=3D 0)
+			break;
+	}
+	if ((i + desc->length) > size) {
+		memunmap(map);
+		return -ENOENT;
+	}
+
+	pr_info("Found EFI embedded fw '%s'\n", desc->name);
+
+	fw =3D kmalloc(sizeof(*fw), GFP_KERNEL);
+	if (!fw) {
+		memunmap(map);
+		return -ENOMEM;
+	}
+
+	fw->data =3D kmemdup(map + i, desc->length, GFP_KERNEL);
+	memunmap(map);
+	if (!fw->data) {
+		kfree(fw);
+		return -ENOMEM;
+	}
+
+	fw->name =3D desc->name;
+	fw->length =3D desc->length;
+	list_add(&fw->list, &efi_embedded_fw_list);
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
+	for (i =3D 0; embedded_fw_table[i]; i++) {
+		dmi_id =3D dmi_first_match(embedded_fw_table[i]);
+		if (!dmi_id)
+			continue;
+
+		fw_desc =3D dmi_id->driver_data;
+
+		/*
+		 * In some drivers the struct driver_data contains may contain
+		 * other driver specific data after the fw_desc struct; and
+		 * the fw_desc struct itself may be empty, skip these.
+		 */
+		if (!fw_desc->name)
+			continue;
+
+		for_each_efi_memory_desc(md) {
+			if (md->type !=3D EFI_BOOT_SERVICES_CODE)
+				continue;
+
+			r =3D efi_check_md_for_embedded_firmware(md, fw_desc);
+			if (r =3D=3D 0)
+				break;
+		}
+	}
+
+	checked_for_fw =3D true;
+}
+
+int efi_get_embedded_fw(const char *name, const u8 **data, size_t *size)
+{
+	struct efi_embedded_fw *iter, *fw =3D NULL;
+
+	if (!checked_for_fw) {
+		pr_warn("Warning %s called while we did not check for embedded fw\n",
+			__func__);
+		return -ENOENT;
+	}
+
+	list_for_each_entry(iter, &efi_embedded_fw_list, list) {
+		if (strcmp(name, iter->name) =3D=3D 0) {
+			fw =3D iter;
+			break;
+		}
+	}
+
+	if (!fw)
+		return -ENOENT;
+
+	*data =3D fw->data;
+	*size =3D fw->length;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(efi_get_embedded_fw);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a6e1a2d8511e..23392b88bcc0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1554,6 +1554,12 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
=20
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+void efi_check_for_embedded_firmwares(void);
+#else
+static inline void efi_check_for_embedded_firmwares(void) { }
+#endif
+
 efi_status_t efi_random_get_seed(void);
=20
 void efi_retrieve_tpm2_eventlog(void);
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded=
_fw.h
new file mode 100644
index 000000000000..3d066c6370c6
--- /dev/null
+++ b/include/linux/efi_embedded_fw.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EFI_EMBEDDED_FW_H
+#define _LINUX_EFI_EMBEDDED_FW_H
+
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+
+#define EFI_EMBEDDED_FW_PREFIX_LEN		8
+
+/*
+ * This struct and efi_embedded_fw_list are private to the efi-embedded =
fw
+ * implementation they are in this header for use by lib/test_firmware.c=
 only!
+ */
+struct efi_embedded_fw {
+	struct list_head list;
+	const char *name;
+	const u8 *data;
+	size_t length;
+};
+
+extern struct list_head efi_embedded_fw_list;
+
+/**
+ * struct efi_embedded_fw_desc - This struct is used by the EFI embedded=
-fw
+ *                               code to search for embedded firmwares.
+ *
+ * @name:   Name to register the firmware with if found
+ * @prefix: First 8 bytes of the firmware
+ * @length: Length of the firmware in bytes including prefix
+ * @sha256: SHA256 of the firmware
+ */
+struct efi_embedded_fw_desc {
+	const char *name;
+	u8 prefix[EFI_EMBEDDED_FW_PREFIX_LEN];
+	u32 length;
+	u8 sha256[32];
+};
+
+int efi_get_embedded_fw(const char *name, const u8 **dat, size_t *sz);
+
+#endif
--=20
2.24.1

