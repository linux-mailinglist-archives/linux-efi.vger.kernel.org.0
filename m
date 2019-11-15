Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0CBFE185
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfKOPgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 10:36:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727879AbfKOPgQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 10:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573832175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+ceyNOAgwOHGOedPh8jjnXDmvLZ/5D9KblQB5Ic6zg=;
        b=VPjlRGllygMfSWAWQ+IM/KYP1LdN8oQ2oMMjZW3aqVBn7ZOOff20Uo2Y4cBDTwiK+NKSsz
        bOtNeLKHUwjjxLperHEolcGRYkLVnfHLhuqGrd/rmTee+nxVvXt/5T+FRHo/iU/Kw3G3AV
        QI1S3dXlpu4p4Caze5xlxbCP2ZRcvJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-9G6vf67KOMymBhSKmwPLHw-1; Fri, 15 Nov 2019 10:36:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B5C8A20E2;
        Fri, 15 Nov 2019 15:36:08 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E40F6117E;
        Fri, 15 Nov 2019 15:36:04 +0000 (UTC)
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
Subject: [PATCH v8 8/8] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date:   Fri, 15 Nov 2019 16:35:29 +0100
Message-Id: <20191115153529.215244-9-hdegoede@redhat.com>
In-Reply-To: <20191115153529.215244-1-hdegoede@redhat.com>
References: <20191115153529.215244-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9G6vf67KOMymBhSKmwPLHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
Chipone ICN8505 touchscreen controller, with the firmware used by the
touchscreen embedded in the EFI firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Remove PROPERTY_ENTRY_BOOL("efi-embedded-firmware") properties entry,
  as this is no longer necessary

Changes in v6:
- Switch from crc sums to SHA256 hashes for the firmware hash
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index 4449e4c0b26b..4a09b479cda5 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -132,6 +132,18 @@ static const struct ts_dmi_data chuwi_vi8_data =3D {
 =09.properties     =3D chuwi_vi8_props,
 };
=20
+static const struct ts_dmi_data chuwi_vi8_plus_data =3D {
+=09.embedded_fw =3D {
+=09=09.name=09=3D "chipone/icn8505-HAMP0002.fw",
+=09=09.prefix =3D { 0xb0, 0x07, 0x00, 0x00, 0xe4, 0x07, 0x00, 0x00 },
+=09=09.length=09=3D 35012,
+=09=09.sha256=09=3D { 0x93, 0xe5, 0x49, 0xe0, 0xb6, 0xa2, 0xb4, 0xb3,
+=09=09=09    0x88, 0x96, 0x34, 0x97, 0x5e, 0xa8, 0x13, 0x78,
+=09=09=09    0x72, 0x98, 0xb8, 0x29, 0xeb, 0x5c, 0xa7, 0xf1,
+=09=09=09    0x25, 0x13, 0x43, 0xf4, 0x30, 0x7c, 0xfc, 0x7c },
+=09},
+};
+
 static const struct property_entry chuwi_vi10_props[] =3D {
 =09PROPERTY_ENTRY_U32("touchscreen-min-x", 0),
 =09PROPERTY_ENTRY_U32("touchscreen-min-y", 4),
@@ -743,6 +755,15 @@ const struct dmi_system_id touchscreen_dmi_table[] =3D=
 {
 =09=09=09DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 =09=09},
 =09},
+=09{
+=09=09/* Chuwi Vi8 Plus (CWI519) */
+=09=09.driver_data =3D (void *)&chuwi_vi8_plus_data,
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+=09=09=09DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+=09=09},
+=09},
 =09{
 =09=09/* Chuwi Vi10 (CWI505) */
 =09=09.driver_data =3D (void *)&chuwi_vi10_data,
@@ -1137,6 +1158,9 @@ static int __init ts_dmi_init(void)
 =09=09return 0; /* Not an error */
=20
 =09ts_data =3D dmi_id->driver_data;
+=09/* Some dmi table entries only provide an efi_embedded_fw_desc */
+=09if (!ts_data->properties)
+=09=09return 0;
=20
 =09error =3D bus_register_notifier(&i2c_bus_type, &ts_dmi_notifier);
 =09if (error)
--=20
2.23.0

