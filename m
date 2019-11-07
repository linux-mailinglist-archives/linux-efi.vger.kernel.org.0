Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38491F24C5
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 02:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfKGB6C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 20:58:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:34054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733032AbfKGB6C (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 Nov 2019 20:58:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:58:01 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="403939193"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:58:00 -0800
Subject: [PATCH v8 10/12] device-dax: Add a driver for "hmem" devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, ard.biesheuvel@linaro.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org
Date:   Wed, 06 Nov 2019 17:43:43 -0800
Message-ID: <157309102333.1579826.2467083752280656791.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Platform firmware like EFI/ACPI may publish "hmem" platform devices.
Such a device is a performance differentiated memory range likely
reserved for an application specific use case. The driver gives access
to 100% of the capacity via a device-dax mmap instance by default.

However, if over-subscription and other kernel memory management is
desired the resulting dax device can be assigned to the core-mm via the
kmem driver.

This consumes "hmem" devices the producer of "hmem" devices is saved for
a follow-on patch so that it can reference the new CONFIG_DEV_DAX_HMEM
symbol to gate performing the enumeration work.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig       |   27 ++++++++++++++++++----
 drivers/dax/Makefile      |    2 ++
 drivers/dax/hmem.c        |   56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/memregion.h |    4 +++
 4 files changed, 84 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dax/hmem.c

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index f33c73e4af41..3b6c06f07326 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -32,19 +32,36 @@ config DEV_DAX_PMEM
 
 	  Say M if unsure
 
+config DEV_DAX_HMEM
+	tristate "HMEM DAX: direct access to 'specific purpose' memory"
+	depends on EFI_SOFT_RESERVE
+	default DEV_DAX
+	help
+	  EFI 2.8 platforms, and others, may advertise 'specific purpose'
+	  memory. For example, a high bandwidth memory pool. The
+	  indication from platform firmware is meant to reserve the
+	  memory from typical usage by default. This driver creates
+	  device-dax instances for these memory ranges, and that also
+	  enables the possibility to assign them to the DEV_DAX_KMEM
+	  driver to override the reservation and add them to kernel
+	  "System RAM" pool.
+
+	  Say M if unsure.
+
 config DEV_DAX_KMEM
 	tristate "KMEM DAX: volatile-use of persistent memory"
 	default DEV_DAX
 	depends on DEV_DAX
 	depends on MEMORY_HOTPLUG # for add_memory() and friends
 	help
-	  Support access to persistent memory as if it were RAM.  This
-	  allows easier use of persistent memory by unmodified
-	  applications.
+	  Support access to persistent, or other performance
+	  differentiated memory as if it were System RAM. This allows
+	  easier use of persistent memory by unmodified applications, or
+	  adds core kernel memory services to heterogeneous memory types
+	  (HMEM) marked "reserved" by platform firmware.
 
 	  To use this feature, a DAX device must be unbound from the
-	  device_dax driver (PMEM DAX) and bound to this kmem driver
-	  on each boot.
+	  device_dax driver and bound to this kmem driver on each boot.
 
 	  Say N if unsure.
 
diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 81f7d54dadfb..80065b38b3c4 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -2,9 +2,11 @@
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
+obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
 
 dax-y := super.o
 dax-y += bus.o
 device_dax-y := device.o
+dax_hmem-y := hmem.o
 
 obj-y += pmem/
diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem.c
new file mode 100644
index 000000000000..fe7214daf62e
--- /dev/null
+++ b/drivers/dax/hmem.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/platform_device.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/pfn_t.h>
+#include "bus.h"
+
+static int dax_hmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dev_pagemap pgmap = { };
+	struct dax_region *dax_region;
+	struct memregion_info *mri;
+	struct dev_dax *dev_dax;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	mri = dev->platform_data;
+	memcpy(&pgmap.res, res, sizeof(*res));
+
+	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
+			PMD_SIZE, PFN_DEV|PFN_MAP);
+	if (!dax_region)
+		return -ENOMEM;
+
+	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
+	if (IS_ERR(dev_dax))
+		return PTR_ERR(dev_dax);
+
+	/* child dev_dax instances now own the lifetime of the dax_region */
+	dax_region_put(dax_region);
+	return 0;
+}
+
+static int dax_hmem_remove(struct platform_device *pdev)
+{
+	/* devm handles teardown */
+	return 0;
+}
+
+static struct platform_driver dax_hmem_driver = {
+	.probe = dax_hmem_probe,
+	.remove = dax_hmem_remove,
+	.driver = {
+		.name = "hmem",
+	},
+};
+
+module_platform_driver(dax_hmem_driver);
+
+MODULE_ALIAS("platform:hmem*");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index 7de7c0a1444e..e11595256cac 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -4,6 +4,10 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 
+struct memregion_info {
+	int target_node;
+};
+
 #ifdef CONFIG_MEMREGION
 int memregion_alloc(gfp_t gfp);
 void memregion_free(int id);

