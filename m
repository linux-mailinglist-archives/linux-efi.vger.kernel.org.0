Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE0FE191
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKOPgL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 10:36:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727849AbfKOPgK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 10:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573832169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rnguKU3KlivycYc4B/QV5PqLPF2l7YoJQ9PXaNPcHU=;
        b=YEyip/XSA7kKRr3wfS88lRoswVdfm/8N9vlajJ8l858TSGkQbVLAiVO1N7zwV3FkdsYsuA
        +BZ2E7f1zMSsV9lI4Y0FftEhHDYRtsxTyo6dvP7K9SUboKlrIg7AM/e7AQ2zk69slHlXxI
        pkS/160Ps0+YX8dZffT2zJHsKO++mn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-t2MayEAFP3ypAS0Em798uQ-1; Fri, 15 Nov 2019 10:36:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08BDC14BE96C;
        Fri, 15 Nov 2019 15:36:04 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1016117E;
        Fri, 15 Nov 2019 15:35:59 +0000 (UTC)
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
        linux-input@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v8 7/8] platform/x86: touchscreen_dmi: Add EFI embedded firmware info support
Date:   Fri, 15 Nov 2019 16:35:28 +0100
Message-Id: <20191115153529.215244-8-hdegoede@redhat.com>
In-Reply-To: <20191115153529.215244-1-hdegoede@redhat.com>
References: <20191115153529.215244-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: t2MayEAFP3ypAS0Em798uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sofar we have been unable to get permission from the vendors to put the
firmware for touchscreens listed in touchscreen_dmi in linux-firmware.

Some of the tablets with such a touchscreen have a touchscreen driver, and
thus a copy of the firmware, as part of their EFI code.

This commit adds the necessary info for the new EFI embedded-firmware code
to extract these firmwares, making the touchscreen work OOTB without the
user needing to manually add the firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Remove adding of PROPERTY_ENTRY_BOOL("efi-embedded-firmware"), to touchsc=
reen
  props, as this is no longer necessary

Changes in v6:
- Switch from crc sums to SHA256 hashes for the firmware hashes
---
 drivers/firmware/efi/embedded-firmware.c |  3 ++
 drivers/platform/x86/Kconfig             |  1 +
 drivers/platform/x86/touchscreen_dmi.c   | 41 +++++++++++++++++++++++-
 include/linux/efi_embedded_fw.h          |  2 ++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/ef=
i/embedded-firmware.c
index 7fa18b6bf354..24487c34c879 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -25,6 +25,9 @@ static bool checked_for_fw;
 static LIST_HEAD(found_fw_list);
=20
 static const struct dmi_system_id * const embedded_fw_table[] =3D {
+#ifdef CONFIG_TOUCHSCREEN_DMI
+=09touchscreen_dmi_table,
+#endif
 =09NULL
 };
=20
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1cab99320514..3891fd8af886 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1250,6 +1250,7 @@ config INTEL_TURBO_MAX_3
 config TOUCHSCREEN_DMI
 =09bool "DMI based touchscreen configuration info"
 =09depends on ACPI && DMI && I2C=3Dy && TOUCHSCREEN_SILEAD
+=09select EFI_EMBEDDED_FIRMWARE if EFI
 =09---help---
 =09  Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
 =09  do not have enough data in ACPI tables for the touchscreen driver to
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index 72205771d03d..4449e4c0b26b 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -11,12 +11,15 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/efi_embedded_fw.h>
 #include <linux/i2c.h>
 #include <linux/notifier.h>
 #include <linux/property.h>
 #include <linux/string.h>
=20
 struct ts_dmi_data {
+=09/* The EFI embedded-fw code expects this to be the first member! */
+=09struct efi_embedded_fw_desc embedded_fw;
 =09const char *acpi_name;
 =09const struct property_entry *properties;
 };
@@ -64,6 +67,15 @@ static const struct property_entry chuwi_hi8_pro_props[]=
 =3D {
 };
=20
 static const struct ts_dmi_data chuwi_hi8_pro_data =3D {
+=09.embedded_fw =3D {
+=09=09.name=09=3D "silead/gsl3680-chuwi-hi8-pro.fw",
+=09=09.prefix =3D { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+=09=09.length=09=3D 39864,
+=09=09.sha256=09=3D { 0xc0, 0x88, 0xc5, 0xef, 0xd1, 0x70, 0x77, 0x59,
+=09=09=09    0x4e, 0xe9, 0xc4, 0xd8, 0x2e, 0xcd, 0xbf, 0x95,
+=09=09=09    0x32, 0xd9, 0x03, 0x28, 0x0d, 0x48, 0x9f, 0x92,
+=09=09=09    0x35, 0x37, 0xf6, 0x8b, 0x2a, 0xe4, 0x73, 0xff },
+=09},
 =09.acpi_name=09=3D "MSSL1680:00",
 =09.properties=09=3D chuwi_hi8_pro_props,
 };
@@ -181,6 +193,15 @@ static const struct property_entry cube_iwork8_air_pro=
ps[] =3D {
 };
=20
 static const struct ts_dmi_data cube_iwork8_air_data =3D {
+=09.embedded_fw =3D {
+=09=09.name=09=3D "silead/gsl3670-cube-iwork8-air.fw",
+=09=09.prefix =3D { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+=09=09.length=09=3D 38808,
+=09=09.sha256=09=3D { 0xff, 0x62, 0x2d, 0xd1, 0x8a, 0x78, 0x04, 0x7b,
+=09=09=09    0x33, 0x06, 0xb0, 0x4f, 0x7f, 0x02, 0x08, 0x9c,
+=09=09=09    0x96, 0xd4, 0x9f, 0x04, 0xe1, 0x47, 0x25, 0x25,
+=09=09=09    0x60, 0x77, 0x41, 0x33, 0xeb, 0x12, 0x82, 0xfc },
+=09},
 =09.acpi_name=09=3D "MSSL1680:00",
 =09.properties=09=3D cube_iwork8_air_props,
 };
@@ -390,6 +411,15 @@ static const struct property_entry onda_v80_plus_v3_pr=
ops[] =3D {
 };
=20
 static const struct ts_dmi_data onda_v80_plus_v3_data =3D {
+=09.embedded_fw =3D {
+=09=09.name=09=3D "silead/gsl3676-onda-v80-plus-v3.fw",
+=09=09.prefix =3D { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+=09=09.length=09=3D 37224,
+=09=09.sha256=09=3D { 0x8f, 0xbd, 0x8f, 0x0c, 0x6b, 0xba, 0x5b, 0xf5,
+=09=09=09    0xa3, 0xc7, 0xa3, 0xc0, 0x4f, 0xcd, 0xdf, 0x32,
+=09=09=09    0xcc, 0xe4, 0x70, 0xd6, 0x46, 0x9c, 0xd7, 0xa7,
+=09=09=09    0x4b, 0x82, 0x3f, 0xab, 0xc7, 0x90, 0xea, 0x23 },
+=09},
 =09.acpi_name=09=3D "MSSL1680:00",
 =09.properties=09=3D onda_v80_plus_v3_props,
 };
@@ -456,6 +486,15 @@ static const struct property_entry pipo_w2s_props[] =
=3D {
 };
=20
 static const struct ts_dmi_data pipo_w2s_data =3D {
+=09.embedded_fw =3D {
+=09=09.name=09=3D "silead/gsl1680-pipo-w2s.fw",
+=09=09.prefix =3D { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+=09=09.length=09=3D 39072,
+=09=09.sha256=09=3D { 0xd0, 0x58, 0xc4, 0x7d, 0x55, 0x2d, 0x62, 0x18,
+=09=09=09    0xd1, 0x6a, 0x71, 0x73, 0x0b, 0x3f, 0xbe, 0x60,
+=09=09=09    0xbb, 0x45, 0x8c, 0x52, 0x27, 0xb7, 0x18, 0xf4,
+=09=09=09    0x31, 0x00, 0x6a, 0x49, 0x76, 0xd8, 0x7c, 0xd3 },
+=09},
 =09.acpi_name=09=3D "MSSL1680:00",
 =09.properties=09=3D pipo_w2s_props,
 };
@@ -642,7 +681,7 @@ static const struct ts_dmi_data trekstor_surftab_wintro=
n70_data =3D {
 };
=20
 /* NOTE: Please keep this table sorted alphabetically */
-static const struct dmi_system_id touchscreen_dmi_table[] =3D {
+const struct dmi_system_id touchscreen_dmi_table[] =3D {
 =09{
 =09=09/* Chuwi Hi8 */
 =09=09.driver_data =3D (void *)&chuwi_hi8_data,
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_f=
w.h
index ac70ff146d58..1ca4206ee006 100644
--- a/include/linux/efi_embedded_fw.h
+++ b/include/linux/efi_embedded_fw.h
@@ -20,6 +20,8 @@ struct efi_embedded_fw_desc {
 =09u8 sha256[32];
 };
=20
+extern const struct dmi_system_id touchscreen_dmi_table[];
+
 int efi_get_embedded_fw(const char *name, void **dat, size_t *sz);
=20
 #endif
--=20
2.23.0

