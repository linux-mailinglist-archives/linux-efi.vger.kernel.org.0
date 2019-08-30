Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F14A2C9E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2019 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfH3CHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Aug 2019 22:07:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:43889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3CHH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Aug 2019 22:07:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="265174910"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:06 -0700
Subject: [PATCH v5 06/10] lib: Uplevel the pmem "region" ida to a global
 allocator
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, rafael.j.wysocki@intel.com
Cc:     Keith Busch <keith.busch@intel.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org
Date:   Thu, 29 Aug 2019 18:52:49 -0700
Message-ID: <156712996924.1616117.4731685780753506682.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/Kconfig       |    1 +
 drivers/nvdimm/core.c        |    1 -
 drivers/nvdimm/nd-core.h     |    1 -
 drivers/nvdimm/region_devs.c |   13 ++++---------
 include/linux/memregion.h    |   19 +++++++++++++++++++
 lib/Kconfig                  |    3 +++
 lib/Makefile                 |    1 +
 lib/memregion.c              |   18 ++++++++++++++++++
 8 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index a5fde15e91d3..f6e7bcb3f9a5 100644
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
index 9204f1e9fd14..e592c4964674 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -455,7 +455,6 @@ static __exit void libnvdimm_exit(void)
 	nd_region_exit();
 	nvdimm_exit();
 	nvdimm_bus_exit();
-	nd_region_devs_exit();
 	nvdimm_devs_exit();
 }
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 0ac52b6eb00e..8408412fba1b 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -127,7 +127,6 @@ struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
 void nvdimm_devs_exit(void);
-void nd_region_devs_exit(void);
 void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 struct nd_region;
 void nd_region_create_ns_seed(struct nd_region *nd_region);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index af30cbe7a8ea..5a152a897c94 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
 #include <linux/scatterlist.h>
+#include <linux/memregion.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -19,7 +20,6 @@
  */
 #include <linux/io-64-nonatomic-hi-lo.h>
 
-static DEFINE_IDA(region_ida);
 static DEFINE_PER_CPU(int, flush_idx);
 
 static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
@@ -133,7 +133,7 @@ static void nd_region_release(struct device *dev)
 		put_device(&nvdimm->dev);
 	}
 	free_percpu(nd_region->lane);
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
 	if (is_nd_blk(dev))
 		kfree(to_nd_blk_region(dev));
 	else
@@ -1034,7 +1034,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	if (!region_buf)
 		return NULL;
-	nd_region->id = ida_simple_get(&region_ida, 0, 0, GFP_KERNEL);
+	nd_region->id = memregion_alloc(GFP_KERNEL);
 	if (nd_region->id < 0)
 		goto err_id;
 
@@ -1093,7 +1093,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	return nd_region;
 
  err_percpu:
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
  err_id:
 	kfree(region_buf);
 	return NULL;
@@ -1262,8 +1262,3 @@ int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
 
 	return device_for_each_child(&nvdimm_bus->dev, &ctx, region_conflict);
 }
-
-void __exit nd_region_devs_exit(void)
-{
-	ida_destroy(&region_ida);
-}
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
new file mode 100644
index 000000000000..07ecde0bd136
--- /dev/null
+++ b/include/linux/memregion.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _MEMREGION_H_
+#define _MEMREGION_H_
+#include <linux/types.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_MEMREGION
+int memregion_alloc(gfp_t gfp);
+void memregion_free(int id);
+#else
+static inline int memregion_alloc(gfp_t gfp)
+{
+	return -ENOMEM;
+}
+void memregion_free(int id)
+{
+}
+#endif
+#endif /* _MEMREGION_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index f33d66fc0e86..9fce7e15716a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -607,6 +607,9 @@ config ARCH_NO_SG_CHAIN
 config ARCH_HAS_PMEM_API
 	bool
 
+config MEMREGION
+	bool
+
 # use memcpy to implement user copies for nommu architectures
 config UACCESS_MEMCPY
 	bool
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..2fb7b47018f1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -212,6 +212,7 @@ obj-$(CONFIG_GENERIC_NET_UTILS) += net_utils.o
 
 obj-$(CONFIG_SG_SPLIT) += sg_split.o
 obj-$(CONFIG_SG_POOL) += sg_pool.o
+obj-$(CONFIG_MEMREGION) += memregion.o
 obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 
diff --git a/lib/memregion.c b/lib/memregion.c
new file mode 100644
index 000000000000..77c85b5251da
--- /dev/null
+++ b/lib/memregion.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* identifiers for device / performance-differentiated memory regions */
+#include <linux/idr.h>
+#include <linux/types.h>
+
+static DEFINE_IDA(memregion_ids);
+
+int memregion_alloc(gfp_t gfp)
+{
+	return ida_alloc(&memregion_ids, gfp);
+}
+EXPORT_SYMBOL(memregion_alloc);
+
+void memregion_free(int id)
+{
+	ida_free(&memregion_ids, id);
+}
+EXPORT_SYMBOL(memregion_free);

