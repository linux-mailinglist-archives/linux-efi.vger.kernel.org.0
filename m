Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE47B1381D5
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 15:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgAKO5x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 09:57:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730276AbgAKO5x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 09:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IIyl7nwLzkMIjP69KzWLUXNNYREWPo9znJtU/sIj/o=;
        b=duAIfecSUhygFuQdn3GTZXSqBW4t4q4HeKOdMcumT2eGhPniI2QNgsJQhvHIW1zchaJBWL
        G6sUROPTaQ12r/dJt8ljCS8Id9u/nV1x5ZqSc3+1h9HVZ856HgcPeaAHaOm+BLwt5WQsOI
        Te5zQMSnUDxXPrI3rdztQxKovLFuaAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-A5kjaX56M6GbHvBdLqSCmQ-1; Sat, 11 Jan 2020 09:57:50 -0500
X-MC-Unique: A5kjaX56M6GbHvBdLqSCmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FE49107ACC4;
        Sat, 11 Jan 2020 14:57:48 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C21487EC6;
        Sat, 11 Jan 2020 14:57:44 +0000 (UTC)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v11 10/10] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date:   Sat, 11 Jan 2020 15:57:03 +0100
Message-Id: <20200111145703.533809-11-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-1-hdegoede@redhat.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x8=
6/touchscreen_dmi.c
index 4449e4c0b26b..4a09b479cda5 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -132,6 +132,18 @@ static const struct ts_dmi_data chuwi_vi8_data =3D {
 	.properties     =3D chuwi_vi8_props,
 };
=20
+static const struct ts_dmi_data chuwi_vi8_plus_data =3D {
+	.embedded_fw =3D {
+		.name	=3D "chipone/icn8505-HAMP0002.fw",
+		.prefix =3D { 0xb0, 0x07, 0x00, 0x00, 0xe4, 0x07, 0x00, 0x00 },
+		.length	=3D 35012,
+		.sha256	=3D { 0x93, 0xe5, 0x49, 0xe0, 0xb6, 0xa2, 0xb4, 0xb3,
+			    0x88, 0x96, 0x34, 0x97, 0x5e, 0xa8, 0x13, 0x78,
+			    0x72, 0x98, 0xb8, 0x29, 0xeb, 0x5c, 0xa7, 0xf1,
+			    0x25, 0x13, 0x43, 0xf4, 0x30, 0x7c, 0xfc, 0x7c },
+	},
+};
+
 static const struct property_entry chuwi_vi10_props[] =3D {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 0),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 4),
@@ -743,6 +755,15 @@ const struct dmi_system_id touchscreen_dmi_table[] =3D=
 {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 Plus (CWI519) */
+		.driver_data =3D (void *)&chuwi_vi8_plus_data,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.driver_data =3D (void *)&chuwi_vi10_data,
@@ -1137,6 +1158,9 @@ static int __init ts_dmi_init(void)
 		return 0; /* Not an error */
=20
 	ts_data =3D dmi_id->driver_data;
+	/* Some dmi table entries only provide an efi_embedded_fw_desc */
+	if (!ts_data->properties)
+		return 0;
=20
 	error =3D bus_register_notifier(&i2c_bus_type, &ts_dmi_notifier);
 	if (error)
--=20
2.24.1

