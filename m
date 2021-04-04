Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEA35395A
	for <lists+linux-efi@lfdr.de>; Sun,  4 Apr 2021 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhDDSM3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 4 Apr 2021 14:12:29 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:53554 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhDDSM2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 4 Apr 2021 14:12:28 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 4baa567f-9571-11eb-ba24-005056bd6ce9;
        Sun, 04 Apr 2021 21:12:20 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 1/1] efi/dev-path-parser: Switch to use for_each_acpi_dev_match()
Date:   Sun,  4 Apr 2021 21:12:16 +0300
Message-Id: <20210404181216.1450776-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Switch to use for_each_acpi_dev_match() instead of home grown analogue.
No functional change intended.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: fixed refcounting
    (example from which I took the v1 approach has been broken, fix is sent :-)
 drivers/firmware/efi/dev-path-parser.c | 49 ++++++++++----------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 5c9625e552f4..10d4457417a4 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -12,52 +12,39 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 
-struct acpi_hid_uid {
-	struct acpi_device_id hid[2];
-	char uid[11]; /* UINT_MAX + null byte */
-};
-
-static int __init match_acpi_dev(struct device *dev, const void *data)
-{
-	struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
-	struct acpi_device *adev = to_acpi_device(dev);
-
-	if (acpi_match_device_ids(adev, hid_uid.hid))
-		return 0;
-
-	if (adev->pnp.unique_id)
-		return !strcmp(adev->pnp.unique_id, hid_uid.uid);
-	else
-		return !strcmp("0", hid_uid.uid);
-}
-
 static long __init parse_acpi_path(const struct efi_dev_path *node,
 				   struct device *parent, struct device **child)
 {
-	struct acpi_hid_uid hid_uid = {};
+	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
+	struct acpi_device *adev;
 	struct device *phys_dev;
 
 	if (node->header.length != 12)
 		return -EINVAL;
 
-	sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
+	sprintf(hid, "%c%c%c%04X",
 		'A' + ((node->acpi.hid >> 10) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
 			node->acpi.hid >> 16);
-	sprintf(hid_uid.uid, "%u", node->acpi.uid);
-
-	*child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
-				 match_acpi_dev);
-	if (!*child)
+	sprintf(uid, "%u", node->acpi.uid);
+
+	for_each_acpi_dev_match(adev, hid, NULL, -1) {
+		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
+			break;
+		if (!adev->pnp.unique_id && node->acpi.uid == 0)
+			break;
+		acpi_dev_put(adev);
+	}
+	if (!adev)
 		return -ENODEV;
 
-	phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
+	phys_dev = acpi_get_first_physical_node(adev);
 	if (phys_dev) {
-		get_device(phys_dev);
-		put_device(*child);
-		*child = phys_dev;
-	}
+		*child = get_device(phys_dev);
+		acpi_dev_put(adev);
+	} else
+		*child = &adev->dev;
 
 	return 0;
 }
-- 
2.31.1

