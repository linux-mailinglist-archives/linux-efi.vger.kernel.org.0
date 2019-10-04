Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA95CBDF9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbfJDOva (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOva (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB6E818C8937;
        Fri,  4 Oct 2019 14:51:29 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 177995C222;
        Fri,  4 Oct 2019 14:51:22 +0000 (UTC)
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
Subject: [PATCH v7 3/8] firmware: Rename FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS
Date:   Fri,  4 Oct 2019 16:50:51 +0200
Message-Id: <20191004145056.43267-4-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 04 Oct 2019 14:51:29 +0000 (UTC)
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

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 62ee90b4db56..665b350419cb 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 		return false;
 	}
 
-	if ((opt_flags & FW_OPT_NOFALLBACK))
+	if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
 		return false;
 
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
@@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
  * interface. Userspace is in charge of loading the firmware through the sysfs
  * loading interface. This sysfs fallback mechanism may be disabled completely
  * on a system by setting the proc sysctl value ignore_sysfs_fallback to true.
- * If this false we check if the internal API caller set the @FW_OPT_NOFALLBACK
- * flag, if so it would also disable the fallback mechanism. A system may want
- * to enfoce the sysfs fallback mechanism at all times, it can do this by
- * setting ignore_sysfs_fallback to false and force_sysfs_fallback to true.
+ * If this false we check if the internal API caller set the
+ * @FW_OPT_NOFALLBACK_SYSFS flag, if so it would also disable the fallback
+ * mechanism. A system may want to enforce the sysfs fallback mechanism at all
+ * times, it can do this by setting ignore_sysfs_fallback to false and
+ * force_sysfs_fallback to true.
  * Enabling force_sysfs_fallback is functionally equivalent to build a kernel
  * with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
  **/
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 7ecd590e67fe..8656e5239a80 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -27,16 +27,16 @@
  *	firmware file lookup on storage is avoided. Used for calls where the
  *	file may be too big, or where the driver takes charge of its own
  *	firmware caching mechanism.
- * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence over
- *	&FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
+ *	precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
  */
 enum fw_opt {
-	FW_OPT_UEVENT =         BIT(0),
-	FW_OPT_NOWAIT =         BIT(1),
-	FW_OPT_USERHELPER =     BIT(2),
-	FW_OPT_NO_WARN =        BIT(3),
-	FW_OPT_NOCACHE =        BIT(4),
-	FW_OPT_NOFALLBACK =     BIT(5),
+	FW_OPT_UEVENT			= BIT(0),
+	FW_OPT_NOWAIT			= BIT(1),
+	FW_OPT_USERHELPER		= BIT(2),
+	FW_OPT_NO_WARN			= BIT(3),
+	FW_OPT_NOCACHE			= BIT(4),
+	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
 };
 
 enum fw_status {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..08f8995a530a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -876,7 +876,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK);
+				FW_OPT_NOFALLBACK_SYSFS);
 	module_put(THIS_MODULE);
 	return ret;
 }
-- 
2.23.0

