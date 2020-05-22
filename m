Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C651DE897
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgEVORa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 10:17:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:47002 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVORa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 10:17:30 -0400
IronPort-SDR: fftnBjM3HBNVop9PZptjTrSdaNZu9BuFUjbhLLU4dAIsbMQEY2XIWyV8ykEKNK4hxYw4APDRp0
 OiAQ6/lwOG0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 07:17:29 -0700
IronPort-SDR: I3IWAVXqSF/Y1SRotKs329Un1O0JX3fwFJrio3U+unACtVZHZwjnyNAr4WnVaIJmPt0lSyJgKy
 J0WCl6Auhw7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="254289484"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 07:17:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3179A449; Fri, 22 May 2020 17:17:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] efi/dev-path-parser: Switch to acpi_dev_get_first_match_dev()
Date:   Fri, 22 May 2020 17:17:26 +0300
Message-Id: <20200522141726.19220-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The acpi_dev_get_first_match_dev() helper will find and return
an ACPI device pointer of the first registered device in the system
by its HID and UID (if present). Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/efi/dev-path-parser.c | 41 ++++++++------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 5c9625e552f4..9edd56f8d01c 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -12,51 +12,34 @@
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
+	char hid[3 + 4 + 1];	/* 3 characters + 4 hex digits + null byte */
+	char uid[10 + 1];	/* UINT_MAX + null byte */
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
+	sprintf(uid, "%u", node->acpi.uid);
 
-	*child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
-				 match_acpi_dev);
-	if (!*child)
+	adev = acpi_dev_get_first_match_dev(hid, node->acpi.uid ? uid : NULL, -1);
+	if (!adev)
 		return -ENODEV;
 
-	phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
+	phys_dev = acpi_get_first_physical_node(adev);
 	if (phys_dev) {
-		get_device(phys_dev);
-		put_device(*child);
-		*child = phys_dev;
+		*child = get_device(phys_dev);
+		acpi_dev_put(adev);
+	} else {
+		*child = &adev->dev;
 	}
 
 	return 0;
-- 
2.26.2

