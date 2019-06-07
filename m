Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86EC39605
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfFGTmH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 15:42:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:59470 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbfFGTmH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 15:42:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 12:42:06 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2019 12:42:07 -0700
Subject: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to a
 global allocator
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org,
        x86@kernel.org, linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 12:27:50 -0700
Message-ID: <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for handling platform differentiated memory types beyond
persistent memory, uplevel the "region" identifier to a global number
space. This enables a device-dax instance to be registered to any memory
type with guaranteed unique names.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/Kconfig       |    1 +
 drivers/nvdimm/core.c        |    1 -
 drivers/nvdimm/nd-core.h     |    1 -
 drivers/nvdimm/region_devs.c |   13 ++++---------
 include/linux/memregion.h    |    8 ++++++++
 lib/Kconfig                  |    7 +++++++
 lib/Makefile                 |    1 +
 lib/memregion.c              |   15 +++++++++++++++
 8 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 54500798f23a..4b3e66fe61c1 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -4,6 +4,7 @@ menuconfig LIBNVDIMM
 	depends on PHYS_ADDR_T_64BIT
 	depends on HAS_IOMEM
 	depends on BLK_DEV
+	select MEMREGION
 	help
 	  Generic support for non-volatile memory devices including
 	  ACPI-6-NFIT defined resources.  On platforms that define an
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index acce050856a8..75fe651d327d 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -463,7 +463,6 @@ static __exit void libnvdimm_exit(void)
 	nd_region_exit();
 	nvdimm_exit();
 	nvdimm_bus_exit();
-	nd_region_devs_exit();
 	nvdimm_devs_exit();
 }
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index e5ffd5733540..17561302dfec 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -133,7 +133,6 @@ struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
 void nvdimm_devs_exit(void);
-void nd_region_devs_exit(void);
 void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 struct nd_region;
 void nd_region_create_ns_seed(struct nd_region *nd_region);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b4ef7d9ff22e..9e070363ff70 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -11,6 +11,7 @@
  * General Public License for more details.
  */
 #include <linux/scatterlist.h>
+#include <linux/memregion.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -27,7 +28,6 @@
  */
 #include <linux/io-64-nonatomic-hi-lo.h>
 
-static DEFINE_IDA(region_ida);
 static DEFINE_PER_CPU(int, flush_idx);
 
 static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
@@ -141,7 +141,7 @@ static void nd_region_release(struct device *dev)
 		put_device(&nvdimm->dev);
 	}
 	free_percpu(nd_region->lane);
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
 	if (is_nd_blk(dev))
 		kfree(to_nd_blk_region(dev));
 	else
@@ -1036,7 +1036,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	if (!region_buf)
 		return NULL;
-	nd_region->id = ida_simple_get(&region_ida, 0, 0, GFP_KERNEL);
+	nd_region->id = memregion_alloc(GFP_KERNEL);
 	if (nd_region->id < 0)
 		goto err_id;
 
@@ -1090,7 +1090,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	return nd_region;
 
  err_percpu:
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
  err_id:
 	kfree(region_buf);
 	return NULL;
@@ -1237,8 +1237,3 @@ int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
 
 	return device_for_each_child(&nvdimm_bus->dev, &ctx, region_conflict);
 }
-
-void __exit nd_region_devs_exit(void)
-{
-	ida_destroy(&region_ida);
-}
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
new file mode 100644
index 000000000000..ba03c70f98d2
--- /dev/null
+++ b/include/linux/memregion.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _MEMREGION_H_
+#define _MEMREGION_H_
+#include <linux/types.h>
+
+int memregion_alloc(gfp_t gfp);
+void memregion_free(int id);
+#endif /* _MEMREGION_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 90623a0e1942..68621a0505a6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -335,6 +335,13 @@ config DECOMPRESS_LZ4
 config GENERIC_ALLOCATOR
 	bool
 
+#
+# Memory Region ID allocation for persistent memory and "specific
+# purpose" / performance differentiated memory ranges.
+#
+config MEMREGION
+	bool
+
 #
 # reed solomon support is select'ed if needed
 #
diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..58cf99f68f36 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_CRC8)	+= crc8.o
 obj-$(CONFIG_XXHASH)	+= xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
+obj-$(CONFIG_MEMREGION) += memregion.o
 
 obj-$(CONFIG_842_COMPRESS) += 842/
 obj-$(CONFIG_842_DECOMPRESS) += 842/
diff --git a/lib/memregion.c b/lib/memregion.c
new file mode 100644
index 000000000000..f6c6a94c7921
--- /dev/null
+++ b/lib/memregion.c
@@ -0,0 +1,15 @@
+#include <linux/idr.h>
+
+static DEFINE_IDA(region_ids);
+
+int memregion_alloc(gfp_t gfp)
+{
+	return ida_alloc(&region_ids, gfp);
+}
+EXPORT_SYMBOL(memregion_alloc);
+
+void memregion_free(int id)
+{
+	ida_free(&region_ids, id);
+}
+EXPORT_SYMBOL(memregion_free);

