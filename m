Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3DCBE04
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJDOvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389043AbfJDOvu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46A6E91760;
        Fri,  4 Oct 2019 14:51:50 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85075C1D8;
        Fri,  4 Oct 2019 14:51:38 +0000 (UTC)
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
Subject: [PATCH v7 5/8] Input: silead - Switch to firmware_request_platform for retreiving the fw
Date:   Fri,  4 Oct 2019 16:50:53 +0200
Message-Id: <20191004145056.43267-6-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 04 Oct 2019 14:51:50 +0000 (UTC)
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index ad8b6a2bfd36..8fa2f3b7cfd8 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -288,7 +288,7 @@ static int silead_ts_load_fw(struct i2c_client *client)
 
 	dev_dbg(dev, "Firmware file name: %s", data->fw_name);
 
-	error = request_firmware(&fw, data->fw_name, dev);
+	error = firmware_request_platform(&fw, data->fw_name, dev);
 	if (error) {
 		dev_err(dev, "Firmware request error %d\n", error);
 		return error;
-- 
2.23.0

