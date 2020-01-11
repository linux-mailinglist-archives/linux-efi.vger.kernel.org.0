Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52F71381CD
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgAKO5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 09:57:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730179AbgAKO5k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 09:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqDSi00IIiR4MKfM9kfHuXfjy0CMBtCyRpTjZC9pBlY=;
        b=cD9hNje/1pnu/L/lYgztbuW+l0Fo4JFdbfh0kkn1d5yg9t/31ka8rqSCe/ujLNgxzEsX1B
        8lHxKeFSYtx7exdTPWGSCygxP4p+l3SD8KU/bTpqorBR6XaV9cJRomr317tiQnuCjT5ptG
        76ofGoY5zW85oGZ/tXP9Q5HrMLaccb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-liXS2q7rN66OQCelGks7UA-1; Sat, 11 Jan 2020 09:57:38 -0500
X-MC-Unique: liXS2q7rN66OQCelGks7UA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB0810054E3;
        Sat, 11 Jan 2020 14:57:36 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9E987EC6;
        Sat, 11 Jan 2020 14:57:32 +0000 (UTC)
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
        linux-input@vger.kernel.org
Subject: [PATCH v11 07/10] Input: silead - Switch to firmware_request_platform for retreiving the fw
Date:   Sat, 11 Jan 2020 15:57:00 +0100
Message-Id: <20200111145703.533809-8-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-1-hdegoede@redhat.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Unfortunately sofar we have been unable to get permission to redistribute
Silead touchscreen firmwares in linux-firmware. This means that people
need to find and install the firmware themselves before the touchscreen
will work

Some UEFI/x86 tablets with a Silead touchscreen have a copy of the fw
embedded in their UEFI boot-services code.

This commit makes the silead driver use the new firmware_request_platform
function, which will fallback to looking for such an embedded copy when
direct filesystem lookup fails. This will make the touchscreen work OOTB
on devices where there is a fw copy embedded in the UEFI code.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscre=
en/silead.c
index ad8b6a2bfd36..8fa2f3b7cfd8 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -288,7 +288,7 @@ static int silead_ts_load_fw(struct i2c_client *clien=
t)
=20
 	dev_dbg(dev, "Firmware file name: %s", data->fw_name);
=20
-	error =3D request_firmware(&fw, data->fw_name, dev);
+	error =3D firmware_request_platform(&fw, data->fw_name, dev);
 	if (error) {
 		dev_err(dev, "Firmware request error %d\n", error);
 		return error;
--=20
2.24.1

