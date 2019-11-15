Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91986FE173
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfKOPf6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 10:35:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727761AbfKOPfy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 10:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573832152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhTYzxlKq1TRodram0injMqqf17YnVnhHRImUmBga/g=;
        b=N5uE2oI4nbJuuQKchh5AUSGtu9r5tI7mv/PRcfpRNlhdk8SMAfHDtFChehs1Xv1iSrkW0o
        2TKS6Vhc1X8UiNRZYW6Nsf6Pbwmfttfx4MdWEtw8LkPb3G4i6vKaUUVXoOj7x4hHkbZsPh
        mjzwMqG3lXsVv7k+r4XxZN1UEOslnS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-VYYjpS0BMGe5162JbiyvCw-1; Fri, 15 Nov 2019 10:35:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC8DDB88;
        Fri, 15 Nov 2019 15:35:47 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0526117E;
        Fri, 15 Nov 2019 15:35:43 +0000 (UTC)
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
Subject: [PATCH v8 3/8] firmware: Rename FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS
Date:   Fri, 15 Nov 2019 16:35:24 +0100
Message-Id: <20191115153529.215244-4-hdegoede@redhat.com>
In-Reply-To: <20191115153529.215244-1-hdegoede@redhat.com>
References: <20191115153529.215244-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VYYjpS0BMGe5162JbiyvCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a preparation patch for adding a new platform fallback mechanism,
which will have its own enable/disable FW_OPT_xxx option.

Note this also fixes a typo in one of the re-wordwrapped comments:
enfoce -> enforce.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/firmware_loader/fallback.c | 11 ++++++-----
 drivers/base/firmware_loader/firmware.h | 16 ++++++++--------
 drivers/base/firmware_loader/main.c     |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmwar=
e_loader/fallback.c
index 62ee90b4db56..8704e1bae175 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags=
)
 =09=09return false;
 =09}
=20
-=09if ((opt_flags & FW_OPT_NOFALLBACK))
+=09if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
 =09=09return false;
=20
 =09/* Also permit LSMs and IMA to fail firmware sysfs fallback */
@@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_fla=
gs)
  * interface. Userspace is in charge of loading the firmware through the s=
ysfs
  * loading interface. This sysfs fallback mechanism may be disabled comple=
tely
  * on a system by setting the proc sysctl value ignore_sysfs_fallback to t=
rue.
- * If this false we check if the internal API caller set the @FW_OPT_NOFAL=
LBACK
- * flag, if so it would also disable the fallback mechanism. A system may =
want
- * to enfoce the sysfs fallback mechanism at all times, it can do this by
- * setting ignore_sysfs_fallback to false and force_sysfs_fallback to true=
.
+ * If this is false we check if the internal API caller set the
+ * @FW_OPT_NOFALLBACK_SYSFS flag, if so it would also disable the fallback
+ * mechanism. A system may want to enforce the sysfs fallback mechanism at=
 all
+ * times, it can do this by setting ignore_sysfs_fallback to false and
+ * force_sysfs_fallback to true.
  * Enabling force_sysfs_fallback is functionally equivalent to build a ker=
nel
  * with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
  **/
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmwar=
e_loader/firmware.h
index 7ecd590e67fe..8656e5239a80 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -27,16 +27,16 @@
  *=09firmware file lookup on storage is avoided. Used for calls where the
  *=09file may be too big, or where the driver takes charge of its own
  *=09firmware caching mechanism.
- * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence ov=
er
- *=09&FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
+ *=09precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
  */
 enum fw_opt {
-=09FW_OPT_UEVENT =3D         BIT(0),
-=09FW_OPT_NOWAIT =3D         BIT(1),
-=09FW_OPT_USERHELPER =3D     BIT(2),
-=09FW_OPT_NO_WARN =3D        BIT(3),
-=09FW_OPT_NOCACHE =3D        BIT(4),
-=09FW_OPT_NOFALLBACK =3D     BIT(5),
+=09FW_OPT_UEVENT=09=09=09=3D BIT(0),
+=09FW_OPT_NOWAIT=09=09=09=3D BIT(1),
+=09FW_OPT_USERHELPER=09=09=3D BIT(2),
+=09FW_OPT_NO_WARN=09=09=09=3D BIT(3),
+=09FW_OPT_NOCACHE=09=09=09=3D BIT(4),
+=09FW_OPT_NOFALLBACK_SYSFS=09=09=3D BIT(5),
 };
=20
 enum fw_status {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index bf44c79beae9..08f8995a530a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -876,7 +876,7 @@ int request_firmware_direct(const struct firmware **fir=
mware_p,
 =09__module_get(THIS_MODULE);
 =09ret =3D _request_firmware(firmware_p, name, device, NULL, 0,
 =09=09=09=09FW_OPT_UEVENT | FW_OPT_NO_WARN |
-=09=09=09=09FW_OPT_NOFALLBACK);
+=09=09=09=09FW_OPT_NOFALLBACK_SYSFS);
 =09module_put(THIS_MODULE);
 =09return ret;
 }
--=20
2.23.0

