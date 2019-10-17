Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D3DB956
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2019 23:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfJQVyq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Oct 2019 17:54:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44857 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391375AbfJQVyq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Oct 2019 17:54:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so3481480oie.11;
        Thu, 17 Oct 2019 14:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQCZKf9ailcF03pnXlPkAwqQ3rLsx9yMvh7O6ph+QSs=;
        b=tTuRUGtZdQ/eZRAfouRNQTYj+FBQoANJeC4zldP/kRcyRDlwd9X9djv5/26VAf62Hd
         ypp+XMt/xpdux7CrG06aQpm9CrbC84uTjTZ+ll9FbffLYZ0JzCvNXnCaxsGNNiXqQn2+
         dOyQSR2t5oJ/aHbrhTLvx2O3JtkLO8JnKpr0FGljigeK7ugn33o8q82h9vFGvxUB87zF
         ZSrPgmoEmrjaw8qPj4ud66hqB4pOTgoxY0InQo2G5T26EI8xRflDClgspiVXlr0lAmhG
         qj7cqir+48Q1A8O7DAFnu75S7izuuvidTyv1FSkbEmnlkoYfQiTxfoyTtCWc1SThdj9Q
         Xa7w==
X-Gm-Message-State: APjAAAWmt8crBCU7oR9ZB0Va/tn63fRFU/jgWqH9glqLjZ9+w8kDtI/p
        F+4lQGZEHvn+J++sFW5hFopqkeoq9pk/z2ylSm4=
X-Google-Smtp-Source: APXvYqzcf2Bhi5Rwm096VgkVTaWUch/12FDSjn1LdbwkGkNyTmsUIsd1MWObcH0TsbcTpOdGeaLdErFzsPvMmS7W+ts=
X-Received: by 2002:aca:d706:: with SMTP id o6mr5254329oig.57.1571349284653;
 Thu, 17 Oct 2019 14:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157118763172.2063440.5191864450230023329.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118763172.2063440.5191864450230023329.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 23:54:33 +0200
Message-ID: <CAJZ5v0gAypDeb3VEVb-n_gAbXO+enQ64Q5biZidc7Xb-ohPozA@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] acpi/numa/hmat: Register "soft reserved" memory
 as an "hmem" device
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 16, 2019 at 3:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Memory that has been tagged EFI_MEMORY_SP, and has performance
> properties described by the ACPI HMAT is expected to have an application
> specific consumer.
>
> Those consumers may want 100% of the memory capacity to be reserved from
> any usage by the kernel. By default, with this enabling, a platform
> device is created to represent this differentiated resource.
>
> The device-dax "hmem" driver claims these devices by default and
> provides an mmap interface for the target application.  If the
> administrator prefers, the hmem resource range can be made available to
> the core-mm via the device-dax hotplug facility, kmem, to online the
> memory with its own numa node.
>
> This was tested with an emulated HMAT produced by qemu (with the pending
> HMAT enabling patches), and "efi_fake_mem=8G@9G:0x40000" on the kernel
> command line to mark the memory ranges associated with node2 and node3
> as EFI_MEMORY_SP.
>
> qemu numa configuration options:
>
> -numa node,mem=4G,cpus=0-19,nodeid=0
> -numa node,mem=4G,cpus=20-39,nodeid=1
> -numa node,mem=4G,nodeid=2
> -numa node,mem=4G,nodeid=3
> -numa dist,src=0,dst=0,val=10
> -numa dist,src=0,dst=1,val=21
> -numa dist,src=0,dst=2,val=21
> -numa dist,src=0,dst=3,val=21
> -numa dist,src=1,dst=0,val=21
> -numa dist,src=1,dst=1,val=10
> -numa dist,src=1,dst=2,val=21
> -numa dist,src=1,dst=3,val=21
> -numa dist,src=2,dst=0,val=21
> -numa dist,src=2,dst=1,val=21
> -numa dist,src=2,dst=2,val=10
> -numa dist,src=2,dst=3,val=21
> -numa dist,src=3,dst=0,val=21
> -numa dist,src=3,dst=1,val=21
> -numa dist,src=3,dst=2,val=21
> -numa dist,src=3,dst=3,val=10
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
>
> Result:
>
> # daxctl list -RDu
> [
>   {
>     "path":"\/platform\/hmem.1",
>     "id":1,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax1.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   },
>   {
>     "path":"\/platform\/hmem.0",
>     "id":0,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   }
> ]
>
> # cat /proc/iomem
> [..]
> 240000000-43fffffff : Soft Reserved
>   240000000-33fffffff : hmem.0
>     240000000-33fffffff : dax0.0
>   340000000-43fffffff : hmem.1
>     340000000-43fffffff : dax1.0
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/Kconfig |    1
>  drivers/acpi/numa/hmat.c  |  136 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 125 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index acbd5aa76e40..fcf2e556d69d 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -9,6 +9,7 @@ config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
>         select HMEM_REPORTING
> +       select MEMREGION
>         help
>          If set, this option has the kernel parse and report the
>          platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 4707eb9dd07b..eaa5a0f93dec 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -8,12 +8,18 @@
>   * the applicable attributes with the node's interfaces.
>   */
>
> +#define pr_fmt(fmt) "acpi/hmat: " fmt
> +#define dev_fmt(fmt) "acpi/hmat: " fmt
> +
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <linux/list_sort.h>
> +#include <linux/memregion.h>
>  #include <linux/memory.h>
>  #include <linux/mutex.h>
>  #include <linux/node.h>
> @@ -49,6 +55,7 @@ struct memory_target {
>         struct list_head node;
>         unsigned int memory_pxm;
>         unsigned int processor_pxm;
> +       struct resource memregions;
>         struct node_hmem_attrs hmem_attrs;
>         struct list_head caches;
>         struct node_cache_attrs cache_attrs;
> @@ -104,22 +111,36 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>         list_add_tail(&initiator->node, &initiators);
>  }
>
> -static __init void alloc_memory_target(unsigned int mem_pxm)
> +static __init void alloc_memory_target(unsigned int mem_pxm,
> +               resource_size_t start, resource_size_t len)
>  {
>         struct memory_target *target;
>
>         target = find_mem_target(mem_pxm);
> -       if (target)
> -               return;
> -
> -       target = kzalloc(sizeof(*target), GFP_KERNEL);
> -       if (!target)
> -               return;
> +       if (!target) {
> +               target = kzalloc(sizeof(*target), GFP_KERNEL);
> +               if (!target)
> +                       return;
> +               target->memory_pxm = mem_pxm;
> +               target->processor_pxm = PXM_INVAL;
> +               target->memregions = (struct resource) {
> +                       .name   = "ACPI mem",
> +                       .start  = 0,
> +                       .end    = -1,
> +                       .flags  = IORESOURCE_MEM,
> +               };
> +               list_add_tail(&target->node, &targets);
> +               INIT_LIST_HEAD(&target->caches);
> +       }
>
> -       target->memory_pxm = mem_pxm;
> -       target->processor_pxm = PXM_INVAL;
> -       list_add_tail(&target->node, &targets);
> -       INIT_LIST_HEAD(&target->caches);
> +       /*
> +        * There are potentially multiple ranges per PXM, so record each
> +        * in the per-target memregions resource tree.
> +        */
> +       if (!__request_region(&target->memregions, start, len, "memory target",
> +                               IORESOURCE_MEM))
> +               pr_warn("failed to reserve %#llx - %#llx in pxm: %d\n",
> +                               start, start + len, mem_pxm);
>  }
>
>  static __init const char *hmat_data_type(u8 type)
> @@ -452,7 +473,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>                 return -EINVAL;
>         if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
>                 return 0;
> -       alloc_memory_target(ma->proximity_domain);
> +       alloc_memory_target(ma->proximity_domain, ma->base_address, ma->length);
>         return 0;
>  }
>
> @@ -613,10 +634,91 @@ static void hmat_register_target_perf(struct memory_target *target)
>         node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>
> +static void hmat_register_target_device(struct memory_target *target,
> +               struct resource *r)
> +{
> +       /* define a clean / non-busy resource for the platform device */
> +       struct resource res = {
> +               .start = r->start,
> +               .end = r->end,
> +               .flags = IORESOURCE_MEM,
> +       };
> +       struct platform_device *pdev;
> +       struct memregion_info info;
> +       int rc, id;
> +
> +       rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> +                       IORES_DESC_SOFT_RESERVED);
> +       if (rc != REGION_INTERSECTS)
> +               return;
> +
> +       id = memregion_alloc(GFP_KERNEL);
> +       if (id < 0) {
> +               pr_err("memregion allocation failure for %pr\n", &res);
> +               return;
> +       }
> +
> +       pdev = platform_device_alloc("hmem", id);
> +       if (!pdev) {
> +               pr_err("hmem device allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> +       info = (struct memregion_info) {
> +               .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> +       };
> +       rc = platform_device_add_data(pdev, &info, sizeof(info));
> +       if (rc < 0) {
> +               pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       rc = platform_device_add_resources(pdev, &res, 1);
> +       if (rc < 0) {
> +               pr_err("hmem resource allocation failure for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       rc = platform_device_add(pdev);
> +       if (rc < 0) {
> +               dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       return;
> +
> +out_resource:
> +       put_device(&pdev->dev);
> +out_pdev:
> +       memregion_free(id);
> +}
> +
> +static __init void hmat_register_target_devices(struct memory_target *target)
> +{
> +       struct resource *res;
> +
> +       /*
> +        * Do not bother creating devices if no driver is available to
> +        * consume them.
> +        */
> +       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> +               return;
> +
> +       for (res = target->memregions.child; res; res = res->sibling)
> +               hmat_register_target_device(target, res);
> +}
> +
>  static void hmat_register_target(struct memory_target *target)
>  {
>         int nid = pxm_to_node(target->memory_pxm);
>
> +       /*
> +        * Devices may belong to either an offline or online
> +        * node, so unconditionally add them.
> +        */
> +       hmat_register_target_devices(target);
> +
>         /*
>          * Skip offline nodes. This can happen when memory
>          * marked EFI_MEMORY_SP, "specific purpose", is applied
> @@ -677,11 +779,21 @@ static __init void hmat_free_structures(void)
>         struct target_cache *tcache, *cnext;
>
>         list_for_each_entry_safe(target, tnext, &targets, node) {
> +               struct resource *res, *res_next;
> +
>                 list_for_each_entry_safe(tcache, cnext, &target->caches, node) {
>                         list_del(&tcache->node);
>                         kfree(tcache);
>                 }
> +
>                 list_del(&target->node);
> +               res = target->memregions.child;
> +               while (res) {
> +                       res_next = res->sibling;
> +                       __release_region(&target->memregions, res->start,
> +                                       resource_size(res));
> +                       res = res_next;
> +               }
>                 kfree(target);
>         }
>
>
