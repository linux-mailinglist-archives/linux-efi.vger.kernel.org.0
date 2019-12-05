Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801F711471B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfLESom (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 13:44:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730003AbfLESol (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 13:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575571480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ejgk46oYyV5w3UxPTBpAptJ9uHtvKxYMvImxmxlscU=;
        b=ZoQpwbIEimfEaoAl1DBSvvUyXLSGCYp1fcyqJvpKQYypa7Jrjt4wejwTThy8wqKlHaf5CQ
        c0oPwfA0XS0SRJLxnev5uvZujBVsyHtpmQkcKAKK3WgL16naKnntWpvkJ06Y01ein1o0mA
        2VV9K/TjSyWaN0KhpQ5aB6hNsgZAnQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-IggSSWLgMfOZLiifkH_2DA-1; Thu, 05 Dec 2019 13:44:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98157800EB8;
        Thu,  5 Dec 2019 18:44:36 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-55.ams2.redhat.com [10.36.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1398A600D1;
        Thu,  5 Dec 2019 18:44:32 +0000 (UTC)
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
Subject: [PATCH v9 02/10] efi: Add embedded peripheral firmware support
Date:   Thu,  5 Dec 2019 19:44:14 +0100
Message-Id: <20191205184422.7316-3-hdegoede@redhat.com>
In-Reply-To: <20191205184422.7316-1-hdegoede@redhat.com>
References: <20191205184422.7316-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IggSSWLgMfOZLiifkH_2DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Changes in v9:
- At least touchscreen_dmi.c uses the same dmi_table for its own private
  data and the fw_desc structs, putting the fw_desc struct first in the
  data driver_data points to so that the dmi_table can be shared with
  efi_check_for_embedded_firmwares(). But not all entries there have
  embedded-fw so in some cases the fw_desc is empty (zero-ed out).
  This can lead to a possible crash because fw_desc->length now is
  less then 8, so if the segment size is close enough to a multiple of the
  page_size, then the memcmp to check the prefix my segfault. Crashing the
  machine. v9 checks for and skips these empty fw_desc entries avoiding thi=
s.
- Rename found_fw_list to efi_embedded_fw_list and export it for use by
  lib/test_firmware.c

Changes in v8:
- Properly deal with the (theoretical?) case of an EFI segment being
  smaller then the fw we are looking for
- Log a warning when efi_get_embedded_fw get called while we did not (yet)
  check for embedded firmwares

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
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
  export a dmi_system_id array, with each entries' driver_data pointing to =
a
  efi_embedded_fw_desc struct and register this with the efi-embedded-fw co=
de
- Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
  this avoids us messing with the EFI memmap and avoids the need to make
  changes to efi_mem_desc_lookup()
- Make the firmware-loader code only fallback to efi_get_embedded_fw() if t=
he
  passed in device has the "efi-embedded-firmware" device-property bool set
- Skip usermodehelper fallback when "efi-embedded-firmware" device-property
  is set
---
 arch/x86/platform/efi/efi.c              |   1 +
 drivers/firmware/efi/Kconfig             |   4 +
 drivers/firmware/efi/Makefile            |   1 +
 drivers/firmware/efi/embedded-firmware.c | 156 +++++++++++++++++++++++
 include/linux/efi.h                      |   6 +
 include/linux/efi_embedded_fw.h          |  39 ++++++
 6 files changed, 207 insertions(+)
 create mode 100644 drivers/firmware/efi/embedded-firmware.c
 create mode 100644 include/linux/efi_embedded_fw.h

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f8a9f5230aaf..4e4b5ac3ce65 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -1016,6 +1016,7 @@ static void __init __efi_enter_virtual_mode(void)
 =09=09panic("EFI call to SetVirtualAddressMap() failed!");
 =09}
=20
+=09efi_check_for_embedded_firmwares();
 =09efi_free_boot_services();
=20
 =09/*
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b248870a9806..657f958365ee 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -194,6 +194,10 @@ config EFI_RCI2_TABLE
=20
 =09  Say Y here for Dell EMC PowerEdge systems.
=20
+config EFI_EMBEDDED_FIRMWARE
+=09bool
+=09select CRYPTO_LIB_SHA256
+
 endmenu
=20
 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 4ac2de4dfa72..42bd310657f4 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_TEST)=09=09=09+=3D test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)=09+=3D dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)=09=09+=3D apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)=09=09+=3D rci2-table.o
+obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)=09+=3D embedded-firmware.o
=20
 arm-obj-$(CONFIG_EFI)=09=09=09:=3D arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)=09=09=09+=3D $(arm-obj-y)
diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/ef=
i/embedded-firmware.c
new file mode 100644
index 000000000000..6668ad48133f
--- /dev/null
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -0,0 +1,156 @@
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
+/* Exported for use by lib/test_firmware.c only */
+LIST_HEAD(efi_embedded_fw_list);
+EXPORT_SYMBOL_GPL(efi_embedded_fw_list);
+
+static bool checked_for_fw;
+
+static const struct dmi_system_id * const embedded_fw_table[] =3D {
+=09NULL
+};
+
+/*
+ * Note the efi_check_for_embedded_firmwares() code currently makes the
+ * following 2 assumptions. This may needs to be revisited if embedded fir=
mware
+ * is found where this is not true:
+ * 1) The firmware is only found in EFI_BOOT_SERVICES_CODE memory segments
+ * 2) The firmware always starts at an offset which is a multiple of 8 byt=
es
+ */
+static int __init efi_check_md_for_embedded_firmware(
+=09efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
+{
+=09const u64 prefix =3D *((u64 *)desc->prefix);
+=09struct sha256_state sctx;
+=09struct efi_embedded_fw *fw;
+=09u8 sha256[32];
+=09u64 i, size;
+=09void *map;
+
+=09size =3D md->num_pages << EFI_PAGE_SHIFT;
+=09map =3D memremap(md->phys_addr, size, MEMREMAP_WB);
+=09if (!map) {
+=09=09pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
+=09=09return -ENOMEM;
+=09}
+
+=09for (i =3D 0; (i + desc->length) <=3D size; i +=3D 8) {
+=09=09u64 *mem =3D map + i;
+
+=09=09if (*mem !=3D prefix)
+=09=09=09continue;
+
+=09=09sha256_init(&sctx);
+=09=09sha256_update(&sctx, map + i, desc->length);
+=09=09sha256_final(&sctx, sha256);
+=09=09if (memcmp(sha256, desc->sha256, 32) =3D=3D 0)
+=09=09=09break;
+=09}
+=09if ((i + desc->length) > size) {
+=09=09memunmap(map);
+=09=09return -ENOENT;
+=09}
+
+=09pr_info("Found EFI embedded fw '%s'\n", desc->name);
+
+=09fw =3D kmalloc(sizeof(*fw), GFP_KERNEL);
+=09if (!fw) {
+=09=09memunmap(map);
+=09=09return -ENOMEM;
+=09}
+
+=09fw->data =3D kmemdup(map + i, desc->length, GFP_KERNEL);
+=09memunmap(map);
+=09if (!fw->data) {
+=09=09kfree(fw);
+=09=09return -ENOMEM;
+=09}
+
+=09fw->name =3D desc->name;
+=09fw->length =3D desc->length;
+=09list_add(&fw->list, &efi_embedded_fw_list);
+
+=09return 0;
+}
+
+void __init efi_check_for_embedded_firmwares(void)
+{
+=09const struct efi_embedded_fw_desc *fw_desc;
+=09const struct dmi_system_id *dmi_id;
+=09efi_memory_desc_t *md;
+=09int i, r;
+
+=09for (i =3D 0; embedded_fw_table[i]; i++) {
+=09=09dmi_id =3D dmi_first_match(embedded_fw_table[i]);
+=09=09if (!dmi_id)
+=09=09=09continue;
+
+=09=09fw_desc =3D dmi_id->driver_data;
+
+=09=09/*
+=09=09 * In some drivers the struct driver_data contains may contain
+=09=09 * other driver specific data after the fw_desc struct; and
+=09=09 * the fw_desc struct itself may be empty, skip these.
+=09=09 */
+=09=09if (!fw_desc->name)
+=09=09=09continue;
+
+=09=09for_each_efi_memory_desc(md) {
+=09=09=09if (md->type !=3D EFI_BOOT_SERVICES_CODE)
+=09=09=09=09continue;
+
+=09=09=09r =3D efi_check_md_for_embedded_firmware(md, fw_desc);
+=09=09=09if (r =3D=3D 0)
+=09=09=09=09break;
+=09=09}
+=09}
+
+=09checked_for_fw =3D true;
+}
+
+int efi_get_embedded_fw(const char *name, void **data, size_t *size)
+{
+=09struct efi_embedded_fw *iter, *fw =3D NULL;
+=09void *buf =3D *data;
+
+=09if (!checked_for_fw) {
+=09=09pr_warn("Warning %s called while we did not check for embedded fw\n"=
,
+=09=09=09__func__);
+=09=09return -ENOENT;
+=09}
+
+=09list_for_each_entry(iter, &efi_embedded_fw_list, list) {
+=09=09if (strcmp(name, iter->name) =3D=3D 0) {
+=09=09=09fw =3D iter;
+=09=09=09break;
+=09=09}
+=09}
+
+=09if (!fw)
+=09=09return -ENOENT;
+
+=09buf =3D vmalloc(fw->length);
+=09if (!buf)
+=09=09return -ENOMEM;
+
+=09memcpy(buf, fw->data, fw->length);
+=09*size =3D fw->length;
+=09*data =3D buf;
+
+=09return 0;
+}
+EXPORT_SYMBOL_GPL(efi_get_embedded_fw);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2929abb1e3c0..d5d4caf44f2a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1646,6 +1646,12 @@ static inline void
 efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 #endif
=20
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+void efi_check_for_embedded_firmwares(void);
+#else
+static inline void efi_check_for_embedded_firmwares(void) { }
+#endif
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
=20
 /*
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_f=
w.h
new file mode 100644
index 000000000000..5a8ae662911b
--- /dev/null
+++ b/include/linux/efi_embedded_fw.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EFI_EMBEDDED_FW_H
+#define _LINUX_EFI_EMBEDDED_FW_H
+
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+
+/*
+ * This struct and efi_embedded_fw_list are private to the efi-embedded fw
+ * implementation they are in this header for use by lib/test_firmware.c o=
nly!
+ */
+struct efi_embedded_fw {
+=09struct list_head list;
+=09const char *name;
+=09void *data;
+=09size_t length;
+};
+
+extern struct list_head efi_embedded_fw_list;
+
+/**
+ * struct efi_embedded_fw_desc - This struct is used by the EFI embedded-f=
w
+ *                               code to search for embedded firmwares.
+ *
+ * @name:   Name to register the firmware with if found
+ * @prefix: First 8 bytes of the firmware
+ * @length: Length of the firmware in bytes including prefix
+ * @sha256: SHA256 of the firmware
+ */
+struct efi_embedded_fw_desc {
+=09const char *name;
+=09u8 prefix[8];
+=09u32 length;
+=09u8 sha256[32];
+};
+
+int efi_get_embedded_fw(const char *name, void **dat, size_t *sz);
+
+#endif
--=20
2.23.0

