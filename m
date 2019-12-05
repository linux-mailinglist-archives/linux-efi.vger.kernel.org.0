Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8F114743
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfLESpe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 13:45:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730273AbfLESpa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 13:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575571529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+ceyNOAgwOHGOedPh8jjnXDmvLZ/5D9KblQB5Ic6zg=;
        b=id6bY7NrHUwmTCF7ouSvsf6LSNWL9PTYJ6iSB02ysTu6P+lkbzAHRwRbhqw+/HdWUBI6Ja
        y3sptHYl77NzInYxhrxJ49Ar/qFB54xAIz30kOywgrQMEq/7qkEeTZesjlfuupbXaDmlIX
        4yVqspl9P6HXUP5st1lYJRPi1U3xW5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-wjmLsy-_NiCvkUvbpkiP0g-1; Thu, 05 Dec 2019 13:45:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61250100550E;
        Thu,  5 Dec 2019 18:45:25 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-55.ams2.redhat.com [10.36.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1955600D1;
        Thu,  5 Dec 2019 18:45:21 +0000 (UTC)
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
Subject: [PATCH v9 10/10] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date:   Thu,  5 Dec 2019 19:44:22 +0100
Message-Id: <20191205184422.7316-11-hdegoede@redhat.com>
In-Reply-To: <20191205184422.7316-1-hdegoede@redhat.com>
References: <20191205184422.7316-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wjmLsy-_NiCvkUvbpkiP0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

