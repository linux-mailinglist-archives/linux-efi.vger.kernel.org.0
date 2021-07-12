Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5115E3C6288
	for <lists+linux-efi@lfdr.de>; Mon, 12 Jul 2021 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhGLSYo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Jul 2021 14:24:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:17337 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhGLSYo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:24:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190413164"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="190413164"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:21:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="569602150"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:21:45 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m30Yl-00CK2l-Lr; Mon, 12 Jul 2021 21:21:39 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 1/1] ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
Date:   Mon, 12 Jul 2021 21:21:21 +0300
Message-Id: <20210712182121.2936794-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently it's possible to iterate over the dangling pointer in case the device
suddenly disappears. This may happen becase callers put it at the end of a loop.

Instead, let's move that call inside acpi_dev_get_next_match_dev().

Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
Fixes: edbd1bc4951e ("efi/dev-path-parser: Switch to use for_each_acpi_dev_match()")
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2:
- rebased on top of v5.14-rc1 and hence added fix for EFI code
- added kernel documentation update to point out that
  acpi_dev_get_next_match_dev() drops a reference on the given
  ACPI device (Rafael)

 drivers/acpi/utils.c                       | 7 +++----
 drivers/firmware/efi/dev-path-parser.c     | 1 -
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++----
 include/acpi/acpi_bus.h                    | 5 -----
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index e7ddd281afff..d5cedffeeff9 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -860,11 +860,9 @@ EXPORT_SYMBOL(acpi_dev_present);
  * Return the next match of ACPI device if another matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
- * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
- * in the case of a hotplug event. That said, the caller should ensure that
- * this will never happen.
- *
  * The caller is responsible for invoking acpi_dev_put() on the returned device.
+ * On the other hand the function invokes  acpi_dev_put() on the given @adev
+ * assuming that its reference counter had been increased beforehand.
  *
  * See additional information in acpi_dev_present() as well.
  */
@@ -880,6 +878,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
 	match.hrv = hrv;
 
 	dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
+	acpi_dev_put(adev);
 	return dev ? to_acpi_device(dev) : NULL;
 }
 EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 10d4457417a4..eb9c65f97841 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -34,7 +34,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 			break;
 		if (!adev->pnp.unique_id && node->acpi.uid == 0)
 			break;
-		acpi_dev_put(adev);
 	}
 	if (!adev)
 		return -ENODEV;
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index 4657e99df033..59a36f922675 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -173,10 +173,8 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 	int ret;
 
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-		if (!adev->status.enabled) {
-			acpi_dev_put(adev);
+		if (!adev->status.enabled)
 			continue;
-		}
 
 		if (bridge->n_sensors >= CIO2_NUM_PORTS) {
 			acpi_dev_put(adev);
@@ -185,7 +183,6 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
-		sensor->adev = adev;
 		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
@@ -215,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 			goto err_free_swnodes;
 		}
 
+		sensor->adev = acpi_dev_get(adev);
 		adev->fwnode.secondary = fwnode;
 
 		dev_info(&cio2->dev, "Found supported sensor %s\n",
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1ae993fee4a5..b9d434a93632 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -707,11 +707,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
  * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
  *
  * The caller is responsible for invoking acpi_dev_put() on the returned device.
- *
- * FIXME: Due to above requirement there is a window that may invalidate @adev
- * and next iteration will use a dangling pointer, e.g. in the case of a
- * hotplug event. That said, the caller should ensure that this will never
- * happen.
  */
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
-- 
2.32.0

