Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124D0A2CA6
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2019 04:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfH3CHb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Aug 2019 22:07:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:38371 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfH3CHa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Aug 2019 22:07:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:30 -0700
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="380977928"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:29 -0700
Subject: [PATCH v5 10/10] acpi/numa/hmat: Register "soft reserved" memory as
 an "hmem" device
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, rafael.j.wysocki@intel.com
Cc:     Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org
Date:   Thu, 29 Aug 2019 18:53:12 -0700
Message-ID: <156712999201.1616117.5589642966130091242.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Memory that has been tagged EFI_MEMORY_SP, and has performance
properties described by the ACPI HMAT is expected to have an application
specific consumer.

Those consumers may want 100% of the memory capacity to be reserved from
any usage by the kernel. By default, with this enabling, a platform
device is created to represent this differentiated resource.

The device-dax "hmem" driver claims these devices by default and
provides an mmap interface for the target application.  If the
administrator prefers, the hmem resource range can be made available to
the core-mm via the device-dax hotplug facility, kmem, to online the
memory with its own numa node.

This was tested with an emulated HMAT produced by qemu (with the pending
HMAT enabling patches), and "efi_fake_mem=8G@9G:0x40000" on the kernel
command line to mark the memory ranges associated with node2 and node3
as EFI_MEMORY_SP.

qemu numa configuration options:

-numa node,mem=4G,cpus=0-19,nodeid=0
-numa node,mem=4G,cpus=20-39,nodeid=1
-numa node,mem=4G,nodeid=2
-numa node,mem=4G,nodeid=3
-numa dist,src=0,dst=0,val=10
-numa dist,src=0,dst=1,val=21
-numa dist,src=0,dst=2,val=21
-numa dist,src=0,dst=3,val=21
-numa dist,src=1,dst=0,val=21
-numa dist,src=1,dst=1,val=10
-numa dist,src=1,dst=2,val=21
-numa dist,src=1,dst=3,val=21
-numa dist,src=2,dst=0,val=21
-numa dist,src=2,dst=1,val=21
-numa dist,src=2,dst=2,val=10
-numa dist,src=2,dst=3,val=21
-numa dist,src=3,dst=0,val=21
-numa dist,src=3,dst=1,val=21
-numa dist,src=3,dst=2,val=21
-numa dist,src=3,dst=3,val=10
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
-numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
-numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
-numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
-numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
-numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
-numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
-numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
-numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
-numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
-numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
-numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
-numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20

Result:

# daxctl list -RDu
[
  {
    "path":"\/platform\/hmem.1",
    "id":1,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax1.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  },
  {
    "path":"\/platform\/hmem.0",
    "id":0,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax0.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  }
]

# cat /proc/iomem
[..]
240000000-43fffffff : Soft Reserved
  240000000-33fffffff : hmem.0
    240000000-33fffffff : dax0.0
  340000000-43fffffff : hmem.1
    340000000-43fffffff : dax1.0

Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/Kconfig |    1 
 drivers/acpi/numa/hmat.c  |  136 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index d14582387ed0..c1be746e111a 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -8,6 +8,7 @@ config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
 	depends on ACPI_NUMA
 	select HMEM_REPORTING
+	select MEMREGION
 	help
 	 If set, this option has the kernel parse and report the
 	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4707eb9dd07b..eaa5a0f93dec 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -8,12 +8,18 @@
  * the applicable attributes with the node's interfaces.
  */
 
+#define pr_fmt(fmt) "acpi/hmat: " fmt
+#define dev_fmt(fmt) "acpi/hmat: " fmt
+
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <linux/list_sort.h>
+#include <linux/memregion.h>
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <linux/node.h>
@@ -49,6 +55,7 @@ struct memory_target {
 	struct list_head node;
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
+	struct resource memregions;
 	struct node_hmem_attrs hmem_attrs;
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
@@ -104,22 +111,36 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 	list_add_tail(&initiator->node, &initiators);
 }
 
-static __init void alloc_memory_target(unsigned int mem_pxm)
+static __init void alloc_memory_target(unsigned int mem_pxm,
+		resource_size_t start, resource_size_t len)
 {
 	struct memory_target *target;
 
 	target = find_mem_target(mem_pxm);
-	if (target)
-		return;
-
-	target = kzalloc(sizeof(*target), GFP_KERNEL);
-	if (!target)
-		return;
+	if (!target) {
+		target = kzalloc(sizeof(*target), GFP_KERNEL);
+		if (!target)
+			return;
+		target->memory_pxm = mem_pxm;
+		target->processor_pxm = PXM_INVAL;
+		target->memregions = (struct resource) {
+			.name	= "ACPI mem",
+			.start	= 0,
+			.end	= -1,
+			.flags	= IORESOURCE_MEM,
+		};
+		list_add_tail(&target->node, &targets);
+		INIT_LIST_HEAD(&target->caches);
+	}
 
-	target->memory_pxm = mem_pxm;
-	target->processor_pxm = PXM_INVAL;
-	list_add_tail(&target->node, &targets);
-	INIT_LIST_HEAD(&target->caches);
+	/*
+	 * There are potentially multiple ranges per PXM, so record each
+	 * in the per-target memregions resource tree.
+	 */
+	if (!__request_region(&target->memregions, start, len, "memory target",
+				IORESOURCE_MEM))
+		pr_warn("failed to reserve %#llx - %#llx in pxm: %d\n",
+				start, start + len, mem_pxm);
 }
 
 static __init const char *hmat_data_type(u8 type)
@@ -452,7 +473,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 		return -EINVAL;
 	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
 		return 0;
-	alloc_memory_target(ma->proximity_domain);
+	alloc_memory_target(ma->proximity_domain, ma->base_address, ma->length);
 	return 0;
 }
 
@@ -613,10 +634,91 @@ static void hmat_register_target_perf(struct memory_target *target)
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
+static void hmat_register_target_device(struct memory_target *target,
+		struct resource *r)
+{
+	/* define a clean / non-busy resource for the platform device */
+	struct resource res = {
+		.start = r->start,
+		.end = r->end,
+		.flags = IORESOURCE_MEM,
+	};
+	struct platform_device *pdev;
+	struct memregion_info info;
+	int rc, id;
+
+	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
+			IORES_DESC_SOFT_RESERVED);
+	if (rc != REGION_INTERSECTS)
+		return;
+
+	id = memregion_alloc(GFP_KERNEL);
+	if (id < 0) {
+		pr_err("memregion allocation failure for %pr\n", &res);
+		return;
+	}
+
+	pdev = platform_device_alloc("hmem", id);
+	if (!pdev) {
+		pr_err("hmem device allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
+	info = (struct memregion_info) {
+		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
+	};
+	rc = platform_device_add_data(pdev, &info, sizeof(info));
+	if (rc < 0) {
+		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	rc = platform_device_add_resources(pdev, &res, 1);
+	if (rc < 0) {
+		pr_err("hmem resource allocation failure for %pr\n", &res);
+		goto out_resource;
+	}
+
+	rc = platform_device_add(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
+		goto out_resource;
+	}
+
+	return;
+
+out_resource:
+	put_device(&pdev->dev);
+out_pdev:
+	memregion_free(id);
+}
+
+static __init void hmat_register_target_devices(struct memory_target *target)
+{
+	struct resource *res;
+
+	/*
+	 * Do not bother creating devices if no driver is available to
+	 * consume them.
+	 */
+	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
+		return;
+
+	for (res = target->memregions.child; res; res = res->sibling)
+		hmat_register_target_device(target, res);
+}
+
 static void hmat_register_target(struct memory_target *target)
 {
 	int nid = pxm_to_node(target->memory_pxm);
 
+	/*
+	 * Devices may belong to either an offline or online
+	 * node, so unconditionally add them.
+	 */
+	hmat_register_target_devices(target);
+
 	/*
 	 * Skip offline nodes. This can happen when memory
 	 * marked EFI_MEMORY_SP, "specific purpose", is applied
@@ -677,11 +779,21 @@ static __init void hmat_free_structures(void)
 	struct target_cache *tcache, *cnext;
 
 	list_for_each_entry_safe(target, tnext, &targets, node) {
+		struct resource *res, *res_next;
+
 		list_for_each_entry_safe(tcache, cnext, &target->caches, node) {
 			list_del(&tcache->node);
 			kfree(tcache);
 		}
+
 		list_del(&target->node);
+		res = target->memregions.child;
+		while (res) {
+			res_next = res->sibling;
+			__release_region(&target->memregions, res->start,
+					resource_size(res));
+			res = res_next;
+		}
 		kfree(target);
 	}
 

