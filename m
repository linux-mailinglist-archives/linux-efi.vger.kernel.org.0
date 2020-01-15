Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69AA13C9AC
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAOQgp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:36:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729219AbgAOQgo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579106203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzKr3IrS0x45CiJWcfOwfaEV1+BQ8JkmqIzHDuO+5WE=;
        b=f/rwf1DbRARfufbGU5ygVyAqIF7mQz3+NeEZYslgAlR/OK2u1nmSLM/+KE52R0qhl3LnLy
        ANqCOCDU+9B4RySjDxnb9qjh/qJClqreB5DD+rAwLsJry3wPpKrJ0AIYyyG5pAsvYHUrEr
        kTY0OWJgnKswV2SaGqPT0TLfMDg92kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-XTEfaRJTPKeuIRdrwgE5bg-1; Wed, 15 Jan 2020 11:36:40 -0500
X-MC-Unique: XTEfaRJTPKeuIRdrwgE5bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A9F18557C2;
        Wed, 15 Jan 2020 16:36:37 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com [10.36.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 379D75DA76;
        Wed, 15 Jan 2020 16:36:34 +0000 (UTC)
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
Subject: [PATCH v12 08/10] Input: icn8505 - Switch to firmware_request_platform for retreiving the fw
Date:   Wed, 15 Jan 2020 17:35:52 +0100
Message-Id: <20200115163554.101315-9-hdegoede@redhat.com>
In-Reply-To: <20200115163554.101315-1-hdegoede@redhat.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Unfortunately sofar we have been unable to get permission to redistribute
icn8505 touchscreen firmwares in linux-firmware. This means that people
need to find and install the firmware themselves before the touchscreen
will work

Some UEFI/x86 tablets with an icn8505 touchscreen have a copy of the fw
embedded in their UEFI boot-services code.

This commit makes the icn8505 driver use the new firmware_request_platfor=
m
function, which will fallback to looking for such an embedded copy when
direct filesystem lookup fails. This will make the touchscreen work OOTB
on devices where there is a fw copy embedded in the UEFI code.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/chipone_icn8505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/=
touchscreen/chipone_icn8505.c
index c768186ce856..f9ca5502ac8c 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -288,7 +288,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn=
8505)
 	 * we may need it at resume. Having loaded it once will make the
 	 * firmware class code cache it at suspend/resume.
 	 */
-	error =3D request_firmware(&fw, icn8505->firmware_name, dev);
+	error =3D firmware_request_platform(&fw, icn8505->firmware_name, dev);
 	if (error) {
 		dev_err(dev, "Firmware request error %d\n", error);
 		return error;
--=20
2.24.1

