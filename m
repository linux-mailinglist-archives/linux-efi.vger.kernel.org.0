Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBD11874A
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLJLwD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 06:52:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbfLJLwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 06:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575978722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3ClPDQhnQdEhbyOWefyMTALJbpKz/GsjGzDJ6+49Gg=;
        b=VpFRsHWic/nE8+jHVGbtzDl6Gru8dFoci9tRSZ2BfkWXvWeQJb6gtE8ImU7KGeq0I21ayG
        D+LT0IVgzTM9vfKFDUMfXyFiaw+875z/JppIdPL17D/bw/Rgo696x28ViSgnc14C/Y0rBk
        dKIyi/8li8ZfXV0ZvIYw7Fbg399OOjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-PVqCuArlMQCLX06x_hqeiQ-1; Tue, 10 Dec 2019 06:51:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6653C804533;
        Tue, 10 Dec 2019 11:51:56 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7B5F5DA60;
        Tue, 10 Dec 2019 11:51:52 +0000 (UTC)
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
Subject: [PATCH v10 08/10] Input: icn8505 - Switch to firmware_request_platform for retreiving the fw
Date:   Tue, 10 Dec 2019 12:51:15 +0100
Message-Id: <20191210115117.303935-9-hdegoede@redhat.com>
In-Reply-To: <20191210115117.303935-1-hdegoede@redhat.com>
References: <20191210115117.303935-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: PVqCuArlMQCLX06x_hqeiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

This commit makes the icn8505 driver use the new firmware_request_platform
function, which will fallback to looking for such an embedded copy when
direct filesystem lookup fails. This will make the touchscreen work OOTB
on devices where there is a fw copy embedded in the UEFI code.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/chipone_icn8505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/to=
uchscreen/chipone_icn8505.c
index c768186ce856..f9ca5502ac8c 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -288,7 +288,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn85=
05)
 =09 * we may need it at resume. Having loaded it once will make the
 =09 * firmware class code cache it at suspend/resume.
 =09 */
-=09error =3D request_firmware(&fw, icn8505->firmware_name, dev);
+=09error =3D firmware_request_platform(&fw, icn8505->firmware_name, dev);
 =09if (error) {
 =09=09dev_err(dev, "Firmware request error %d\n", error);
 =09=09return error;
--=20
2.23.0

