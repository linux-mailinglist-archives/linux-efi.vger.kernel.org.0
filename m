Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E011873E
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 12:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLJLvz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 06:51:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727680AbfLJLvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 06:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575978709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtBsTm3fRFjIyMa+EFTgFbazzMWS0kDI+hTGx1+0S64=;
        b=bEwTdC7ISOHKVuUqveUyYMydUpXwlZeRKrd/zutZZ1023pLKRxXOVL7JZwaOFj+MPXRVbm
        7PIdwmPeKSdbkp77mWNG7Q82SxTm9B9/m2k9eNs7ktYd8G+CC5xLL9jyAndBU2bDcGLT9w
        +DBa13FCu0jTlOoDU74sKHoe692mWy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-drcrFZeKPci8uI6H4xR-Aw-1; Tue, 10 Dec 2019 06:51:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E19618036B1;
        Tue, 10 Dec 2019 11:51:41 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E2EC5DA60;
        Tue, 10 Dec 2019 11:51:37 +0000 (UTC)
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
Subject: [PATCH v10 04/10] firmware: Add new platform fallback mechanism and firmware_request_platform()
Date:   Tue, 10 Dec 2019 12:51:11 +0100
Message-Id: <20191210115117.303935-5-hdegoede@redhat.com>
In-Reply-To: <20191210115117.303935-1-hdegoede@redhat.com>
References: <20191210115117.303935-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: drcrFZeKPci8uI6H4xR-Aw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In some cases the platform's main firmware (e.g. the UEFI fw) may contain
an embedded copy of device firmware which needs to be (re)loaded into the
peripheral. Normally such firmware would be part of linux-firmware, but in
some cases this is not feasible, for 2 reasons:

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

This commit adds a new platform fallback mechanism to the firmware loader
which will try to lookup a device fw copy embedded in the platform's main
firmware if direct filesystem lookup fails.

Drivers which need such embedded fw copies can enable this fallback
mechanism by using the new firmware_request_platform() function.

Note that for now this is only supported on EFI platforms and even on
these platforms firmware_fallback_platform() only works if
CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
which need this), in all other cases firmware_fallback_platform() simply
always returns -ENOENT.

Reported-by: Dave Olsthoorn <dave@bewaar.me>
Suggested-by: Peter Jones <pjones@redhat.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v9:
- Add static inline wrapper for firmware_request_platform() to firmware.h,
  for when CONFIG_FW_LOADER is not set

Changes in v8:
- Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defined=
,
  otherwise make firmware_fallback_platform() a static inline stub
- Add documentation to Documentation/driver-api/firmware/fallback-mechanism=
s.rst
  on how the boot_service_code? files exported by EFI debugfs can be used t=
o
  check if there is an embedded firmware and to get the embedded firmware
  length and sha256sum

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
  2 patches
- Address kdoc comments from Randy Dunlap
- Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
  _request_firmware() wrapper, as requested by Luis R. Rodriguez
- Stop using "efi-embedded-firmware" device-property, now that drivers need=
 to
  use the new firmware_request_platform() to enable fallback to a device fw
  copy embedded in the platform's main firmware, we no longer need a proper=
ty
  on the device to trigger this behavior
- Use security_kernel_load_data instead of calling
  security_kernel_read_file with a NULL file pointer argument
- Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rs=
t
- Document the new firmware_request_platform() function in
  Documentation/driver-api/firmware/request_firmware.rst

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
 .../firmware/fallback-mechanisms.rst          | 103 ++++++++++++++++++
 .../driver-api/firmware/lookup-order.rst      |   2 +
 .../driver-api/firmware/request_firmware.rst  |   5 +
 drivers/base/firmware_loader/Makefile         |   1 +
 drivers/base/firmware_loader/fallback.h       |  10 ++
 .../base/firmware_loader/fallback_platform.c  |  29 +++++
 drivers/base/firmware_loader/firmware.h       |   4 +
 drivers/base/firmware_loader/main.c           |  27 +++++
 include/linux/firmware.h                      |   9 ++
 include/linux/fs.h                            |   1 +
 10 files changed, 191 insertions(+)
 create mode 100644 drivers/base/firmware_loader/fallback_platform.c

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Do=
cumentation/driver-api/firmware/fallback-mechanisms.rst
index 8b041d0ab426..036383dad6d6 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -202,3 +202,106 @@ the following file:
=20
 If you echo 0 into it means MAX_JIFFY_OFFSET will be used. The data type
 for the timeout is an int.
+
+EFI embedded firmware fallback mechanism
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+On some devices the system's EFI code / ROM may contain an embedded copy
+of firmware for some of the system's integrated peripheral devices and
+the peripheral's Linux device-driver needs to access this firmware.
+
+Device drivers which need such firmware can use the
+firmware_request_platform() function for this, note that this is a
+separate fallback mechanism from the other fallback mechanisms and
+this does not use the sysfs interface.
+
+A device driver which needs this can describe the firmware it needs
+using an efi_embedded_fw_desc struct:
+
+.. kernel-doc:: include/linux/efi_embedded_fw.h
+   :functions: efi_embedded_fw_desc
+
+The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE memo=
ry
+segments for an eight byte sequence matching prefix; if the prefix is foun=
d it
+then does a sha256 over length bytes and if that matches makes a copy of l=
ength
+bytes and adds that to its list with found firmwares.
+
+To avoid doing this somewhat expensive scan on all systems, dmi matching i=
s
+used. Drivers are expected to export a dmi_system_id array, with each entr=
ies'
+driver_data pointing to an efi_embedded_fw_desc.
+
+To register this array with the efi-embedded-fw code, a driver needs to:
+
+1. Always be builtin to the kernel or store the dmi_system_id array in a
+   separate object file which always gets builtin.
+
+2. Add an extern declaration for the dmi_system_id array to
+   include/linux/efi_embedded_fw.h.
+
+3. Add the dmi_system_id array to the embedded_fw_table in
+   drivers/firmware/efi/embedded-firmware.c wrapped in a #ifdef testing th=
at
+   the driver is being builtin.
+
+4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
+
+The firmware_request_platform() function will always first try to load fir=
mware
+with the specified name directly from the disk, so the EFI embedded-fw can
+always be overridden by placing a file under /lib/firmware.
+
+Note that:
+
+1. The code scanning for EFI embedded-firmware runs near the end
+   of start_kernel(), just before calling rest_init(). For normal drivers =
and
+   subsystems using subsys_initcall() to register themselves this does not
+   matter. This means that code running earlier cannot use EFI
+   embedded-firmware.
+
+2. At the moment the EFI embedded-fw code assumes that firmwares always st=
art at
+   an offset which is a multiple of 8 bytes, if this is not true for your =
case
+   send in a patch to fix this.
+
+3. At the moment the EFI embedded-fw code only works on x86 because other =
archs
+   free EFI_BOOT_SERVICES_CODE before the EFI embedded-fw code gets a chan=
ce to
+   scan it.
+
+4. The current brute-force scanning of EFI_BOOT_SERVICES_CODE is an ad-hoc
+   brute-force solution. There has been discussion to use the UEFI Platfor=
m
+   Initialization (PI) spec's Firmware Volume protocol. This has been reje=
cted
+   because the FV Protocol relies on *internal* interfaces of the PI spec,=
 and:
+   1. The PI spec does not define peripheral firmware at all
+   2. The internal interfaces of the PI spec do not guarantee any backward
+   compatibility. Any implementation details in FV may be subject to chang=
e,
+   and may vary system to system. Supporting the FV Protocol would be
+   difficult as it is purposely ambiguous.
+
+Example how to check for and extract embedded firmware
+------------------------------------------------------
+
+To check for, for example Silead touchscreen controller embedded firmware,
+do the following:
+
+1. Boot the system with efi=3Ddebug on the kernel commandline
+
+2. cp /sys/kernel/debug/efi/boot_services_code? to your home dir
+
+3. Open the boot_services_code? files in a hex-editor, search for the
+   magic prefix for Silead firmware: F0 00 00 00 02 00 00 00, this gives y=
ou
+   the beginning address of the firmware inside the boot_services_code? fi=
le.
+
+4. The firmware has a specific pattern, it starts with a 8 byte page-addre=
ss,
+   typically F0 00 00 00 02 00 00 00 for the first page followed by 32-bit
+   word-address + 32-bit value pairs. With the word-address incrementing 4
+   bytes (1 word) for each pair until a page is complete. A complete page =
is
+   followed by a new page-address, followed by more word + value pairs. Th=
is
+   leads to a very distinct pattern. Scroll down until this pattern stops,
+   this gives you the end of the firmware inside the boot_services_code? f=
ile.
+
+5. "dd if=3Dboot_services_code? of=3Dfirmware bs=3D1 skip=3D<begin-addr> c=
ount=3D<len>"
+   will extract the firmware for you. Inspect the firmware file in a
+   hexeditor to make sure you got the dd parameters correct.
+
+6. Copy it to /lib/firmware under the expected name to test it.
+
+7. If the extracted firmware works, you can use the found info to fill an
+   efi_embedded_fw_desc struct to describe it, run "sha256sum firmware"
+   to get the sha256sum to put in the sha256 field.
diff --git a/Documentation/driver-api/firmware/lookup-order.rst b/Documenta=
tion/driver-api/firmware/lookup-order.rst
index 88c81739683c..6064672a782e 100644
--- a/Documentation/driver-api/firmware/lookup-order.rst
+++ b/Documentation/driver-api/firmware/lookup-order.rst
@@ -12,6 +12,8 @@ a driver issues a firmware API call.
   return it immediately
 * The ''Direct filesystem lookup'' is performed next, if found we
   return it immediately
+* The ''Platform firmware fallback'' is performed next, but only when
+  firmware_request_platform() is used, if found we return it immediately
 * If no firmware has been found and the fallback mechanism was enabled
   the sysfs interface is created. After this either a kobject uevent
   is issued or the custom firmware loading is relied upon for firmware
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Docum=
entation/driver-api/firmware/request_firmware.rst
index f62bdcbfed5b..cd076462d235 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -25,6 +25,11 @@ firmware_request_nowarn
 .. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_nowarn
=20
+firmware_request_platform
+-------------------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
+   :functions: firmware_request_platform
+
 request_firmware_direct
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_=
loader/Makefile
index 0b2dfa6259c9..e87843408fe6 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback_table.o
 obj-$(CONFIG_FW_LOADER)=09+=3D firmware_class.o
 firmware_class-objs :=3D main.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback.o
+firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) +=3D fallback_platform.o
=20
 obj-y +=3D builtin/
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmwar=
e_loader/fallback.h
index 21063503e4ea..06f4577733a8 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -66,4 +66,14 @@ static inline void unregister_sysfs_loader(void)
 }
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
=20
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_fl=
ags);
+#else
+static inline int firmware_fallback_platform(struct fw_priv *fw_priv,
+=09=09=09=09=09     enum fw_opt opt_flags)
+{
+=09return -ENOENT;
+}
+#endif
+
 #endif /* __FIRMWARE_FALLBACK_H */
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/bas=
e/firmware_loader/fallback_platform.c
new file mode 100644
index 000000000000..37746efaf8e3
--- /dev/null
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi_embedded_fw.h>
+#include <linux/property.h>
+#include <linux/security.h>
+#include <linux/vmalloc.h>
+
+#include "fallback.h"
+#include "firmware.h"
+
+int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_fl=
ags)
+{
+=09int rc;
+
+=09if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
+=09=09return -ENOENT;
+
+=09rc =3D security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+=09if (rc)
+=09=09return rc;
+
+=09rc =3D efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data,
+=09=09=09=09 &fw_priv->size);
+=09if (rc)
+=09=09return rc; /* rc =3D=3D -ENOENT when the fw was not found */
+
+=09fw_state_done(fw_priv);
+=09return 0;
+}
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmwar=
e_loader/firmware.h
index 8656e5239a80..25836a6afc9f 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -29,6 +29,9 @@
  *=09firmware caching mechanism.
  * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
  *=09precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded i=
n
+ *=09the platform's main firmware. If both this fallback and the sysfs
+ *      fallback are enabled, then this fallback will be tried first.
  */
 enum fw_opt {
 =09FW_OPT_UEVENT=09=09=09=3D BIT(0),
@@ -37,6 +40,7 @@ enum fw_opt {
 =09FW_OPT_NO_WARN=09=09=09=3D BIT(3),
 =09FW_OPT_NOCACHE=09=09=09=3D BIT(4),
 =09FW_OPT_NOFALLBACK_SYSFS=09=09=3D BIT(5),
+=09FW_OPT_FALLBACK_PLATFORM=09=3D BIT(6),
 };
=20
 enum fw_status {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 57133a9dad09..cfdbf0010545 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -776,6 +776,9 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 =09=09=09=09=09=09 fw_decompress_xz);
 #endif
=20
+=09if (ret =3D=3D -ENOENT)
+=09=09ret =3D firmware_fallback_platform(fw->priv, opt_flags);
+
 =09if (ret) {
 =09=09if (!(opt_flags & FW_OPT_NO_WARN))
 =09=09=09dev_warn(device,
@@ -883,6 +886,30 @@ int request_firmware_direct(const struct firmware **fi=
rmware_p,
 }
 EXPORT_SYMBOL_GPL(request_firmware_direct);
=20
+/**
+ * firmware_request_platform() - request firmware with platform-fw fallbac=
k
+ * @firmware: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ *
+ * This function is similar in behaviour to request_firmware, except that =
if
+ * direct filesystem lookup fails, it will fallback to looking for a copy =
of the
+ * requested firmware embedded in the platform's main (e.g. UEFI) firmware=
.
+ **/
+int firmware_request_platform(const struct firmware **firmware,
+=09=09=09      const char *name, struct device *device)
+{
+=09int ret;
+
+=09/* Need to pin this module until return */
+=09__module_get(THIS_MODULE);
+=09ret =3D _request_firmware(firmware, name, device, NULL, 0,
+=09=09=09=09FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
+=09module_put(THIS_MODULE);
+=09return ret;
+}
+EXPORT_SYMBOL_GPL(firmware_request_platform);
+
 /**
  * firmware_request_cache() - cache firmware for suspend so resume can use=
 it
  * @name: name of firmware file
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2dd566c91d44..4bbd0afd91b7 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -44,6 +44,8 @@ int request_firmware(const struct firmware **fw, const ch=
ar *name,
 =09=09     struct device *device);
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
 =09=09=09    struct device *device);
+int firmware_request_platform(const struct firmware **fw, const char *name=
,
+=09=09=09      struct device *device);
 int request_firmware_nowait(
 =09struct module *module, bool uevent,
 =09const char *name, struct device *device, gfp_t gfp, void *context,
@@ -69,6 +71,13 @@ static inline int firmware_request_nowarn(const struct f=
irmware **fw,
 =09return -EINVAL;
 }
=20
+static inline int firmware_request_platform(const struct firmware **fw,
+=09=09=09=09=09    const char *name,
+=09=09=09=09=09    struct device *device)
+{
+=09return -EINVAL;
+}
+
 static inline int request_firmware_nowait(
 =09struct module *module, bool uevent,
 =09const char *name, struct device *device, gfp_t gfp, void *context,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..4b4f11a80a2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2964,6 +2964,7 @@ extern int do_pipe_flags(int *, int);
 =09id(UNKNOWN, unknown)=09=09\
 =09id(FIRMWARE, firmware)=09=09\
 =09id(FIRMWARE_PREALLOC_BUFFER, firmware)=09\
+=09id(FIRMWARE_EFI_EMBEDDED, firmware)=09\
 =09id(MODULE, kernel-module)=09=09\
 =09id(KEXEC_IMAGE, kexec-image)=09=09\
 =09id(KEXEC_INITRAMFS, kexec-initramfs)=09\
--=20
2.23.0

