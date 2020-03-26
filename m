Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04B193E0D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Mar 2020 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZLjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Mar 2020 07:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCZLjj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Mar 2020 07:39:39 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E6A2076A
        for <linux-efi@vger.kernel.org>; Thu, 26 Mar 2020 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585222778;
        bh=w2OH23GJ4xyAAuYUNiHrqNIZ/xfO1pfCL7KIJiu5yzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NoeTlyv7qtbpbOaHa9fToxF+C+PIWrlsBKobvyg7+GTqij/0EDehG7JG/FcVi6xvI
         /kJGmhCdl4Px1X+wlK8HkC93BhejR7vZLxqhV/KTIWVuLe/AJRqoxB+98LV8Da0q/z
         nIY02ueOR1LfqrICLYpC6eNUTLrHbfJshbkDoSt4=
Received: by mail-wm1-f51.google.com with SMTP id d198so6125846wmd.0
        for <linux-efi@vger.kernel.org>; Thu, 26 Mar 2020 04:39:37 -0700 (PDT)
X-Gm-Message-State: ANhLgQ38LZ26aRTSrpiyon81Kh8hMSkISGJtTU6N82HpI1I8whgDUwAg
        70X4tfKfL5yBjrhM4KYqKOT7Fu8L5ioD2hNalP5pvg==
X-Google-Smtp-Source: ADFU+vtPZeVKdKf6+PJmTAnCYjEuE5zR9oXp/L+8YbMPwmdnUFf7rfRgDOrx1wItYQapzthgSoBi2ao8wwHuPALPofg=
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr2628829wme.62.1585222776056;
 Thu, 26 Mar 2020 04:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200312011335.70750-1-qiuxu.zhuo@intel.com> <CAKv+Gu_FSMM77WyNPKQDsA3wa6xLFUYe9kXpLEeR72t6q7t4jw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_FSMM77WyNPKQDsA3wa6xLFUYe9kXpLEeR72t6q7t4jw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Mar 2020 12:39:24 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_4J7ebMuj9xJ31BOCvxahU_mkLa9RTr8d2DXRC8tFTnQ@mail.gmail.com>
Message-ID: <CAKv+Gu_4J7ebMuj9xJ31BOCvxahU_mkLa9RTr8d2DXRC8tFTnQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Mar 2020 at 18:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 12 Mar 2020 at 02:12, Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
> >
> > The EFI capsule mechanism allows data blobs to be passed to the EFI
> > firmware. By setting the EFI_CAPSULE_POPULATE_SYSTEM_TABLE and the
> > EFI_CAPSULE_PERSIST_ACROSS_REBOOT flags, the firmware will place a
> > pointer to the data blob in the EFI System Table on the next boot.
> > We can utilise this facility to save crash dumps, call traces, etc
> > and pick them up to aid in debugging after reboot.
> >
> > Test:
> >   Test environment:
> >   Intel Kaby Lake client platform + Intel KBL BIOS(10/24/2016) or
> >   Intel Ice Lake client platform + Intel ICL BIOS(09/12/2019)
> >
> >   Test steps:
> >   modprobe capsule-pstore
> >   echo "Test pmsg on capsule-pstore" > /dev/pmsg0
> >   echo 1 > /sys/module/kernel/parameters/panic
> >   echo c > /proc/sysrq-trigger
> >   system reboot...
> >
> >   Output files(pmsg log and console/dmesg logs) in the path
> >   /sys/fs/pstore/ look like:
> >   console-capsule-pstore-0
> >   dmesg-capsule-pstore-6433226157407076353
> >   dmesg-capsule-pstore-6433226157407076354
> >   dmesg-capsule-pstore-6433226157407076355
> >   dmesg-capsule-pstore-6433226157407076356
> >   dmesg-capsule-pstore-6433226157407076357
> >   dmesg-capsule-pstore-6433226157407076358
> >   pmsg-capsule-pstore-0
> >
> > This patch is based on earlier code by Matt Fleming:
> >   https://git.kernel.org/cgit/linux/kernel/git/mfleming/efi.git/commit/?h=capsule-pstore&id=99c5f047133555aa0442f64064e85b7da2d4a45f
> >   https://git.kernel.org/cgit/linux/kernel/git/mfleming/efi.git/commit/?h=capsule-pstore&id=8625c776c9b8bbed7fa4aa023e36542615165240
> > Extensive cleanup, refactoring, bug fix, and verification by Qiuxu Zhuo
> >
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> Thanks for taking the time to work on this. This is a very useful feature.
>

OK, so I see one complication with this. The EFI UpdateCapsule()
runtime service expects the OS to use the EFI ResetSystem() runtime
service to perform the reboot. pstore is designed to record whatever
it can while the system is crashing, and so it this would need
reboot_on_panic at the very least, but even then, it is not very
likely that you would be able to do a clean soft reboot from that
state in the general case.

So unless there is a way to perform the test steps /without/ relying
on magic SysRq to do a soft reboot after the system has panicked, I'm
not convinced this is worthwhile.




> > ---
> >  drivers/firmware/efi/Kconfig          |  21 +
> >  drivers/firmware/efi/Makefile         |   1 +
> >  drivers/firmware/efi/capsule-pstore.c | 692 ++++++++++++++++++++++++++
> >  3 files changed, 714 insertions(+)
> >  create mode 100644 drivers/firmware/efi/capsule-pstore.c
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index ecc83e2f032c..bebfedbc3bd2 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -237,6 +237,27 @@ config EFI_DISABLE_PCI_DMA
> >           options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
> >           may be used to override this option.
> >
> > +config EFI_CAPSULE_PSTORE
> > +       tristate "EFI capsule pstore backend"
> > +       depends on EFI && PSTORE
> > +       help
> > +         Saying Y here enable the EFI capsule mechanism to store crash dumps,
> > +         console log, and function tracing data.
> > +
> > +         To compile this driver as a module, choose M here.
> > +
> > +         Not many firmware implementations fully support EFI capsules.
> > +         If you plan to rely on this you should test whether yours works by
> > +         forcing a crash. Most people should not enable this.
> > +
> > +config EFI_CAPSULE_PSTORE_DEFAULT_DISABLE
> > +       bool "Disable using efi capsule as a pstore backend by default"
> > +       depends on EFI_CAPSULE_PSTORE
> > +       help
> > +         Saying Y here will disable the use of efi capsule as a storage
> > +         backend for pstore by default. This setting can be overridden
> > +         using the capsule-pstore module's pstore_disable parameter.
> > +
> >  endmenu
> >
>
> Is this 'default disable' a pstore specific pattern?
>
> >  config UEFI_CPER
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index 554d795270d9..5913df6a0af6 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_EFI)                     += capsule.o memmap.o
> >  obj-$(CONFIG_EFI_VARS)                 += efivars.o
> >  obj-$(CONFIG_EFI_ESRT)                 += esrt.o
> >  obj-$(CONFIG_EFI_VARS_PSTORE)          += efi-pstore.o
> > +obj-$(CONFIG_EFI_CAPSULE_PSTORE)               += capsule-pstore.o
> >  obj-$(CONFIG_UEFI_CPER)                        += cper.o
> >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> > diff --git a/drivers/firmware/efi/capsule-pstore.c b/drivers/firmware/efi/capsule-pstore.c
> > new file mode 100644
> > index 000000000000..38fedee63766
> > --- /dev/null
> > +++ b/drivers/firmware/efi/capsule-pstore.c
> > @@ -0,0 +1,692 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * EFI capsule pstore backend support.
> > + *
> > + * Copyright (c) 2020, Intel Corporation.
> > + *
> > + * The EFI capsule mechanism allows data blobs to be passed to the EFI
> > + * firmware. By setting the EFI_CAPSULE_POPULATE_SYSTEM_TABLE and the
> > + * EFI_CAPSULE_PERSIST_ACROSS_REBOOT flags, the firmware will place a
> > + * pointer to the data blob in the EFI System Table on the next boot.
> > + * We can utilise this facility to save crash dumps, call traces, etc
> > + * and pick them up to aid in debugging after reboot.
> > + */
> > +
> > +#define pr_fmt(fmt) "capsule-pstore: " fmt
> > +#include <linux/slab.h>
> > +#include <linux/io.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/highmem.h>
> > +#include <linux/efi.h>
> > +#include <linux/module.h>
> > +#include <linux/pstore.h>
> > +
> > +#define CAPSULE_SIZE (16 * 1024)
> > +#define CRASH_SIZE 4096
> > +#define CAPSULE_MAGIC 0x63617073 /* 'caps' */
> > +
> > +static bool efi_capsule_pstore_disable __ro_after_init =
> > +       IS_ENABLED(CONFIG_CAPSULE_PSTORE_DEFAULT_DISABLE);
> > +
> > +static int efi_reset_type = -1;
> > +
> > +struct efi_capsule_ctx {
> > +       struct page **pages;
> > +       phys_addr_t *phys_addrs;
> > +       unsigned int nr_pages;
> > +       efi_capsule_header_t *capsule;
> > +       size_t capsule_size;
> > +       void *data;
> > +       size_t data_size;
> > +};
> > +
> > +struct efi_capsule_pstore_buf {
> > +       void *buf;
> > +       size_t size;
> > +       atomic_long_t offset;
> > +};
> > +
> > +struct efi_capsule_pstore {
> > +       /* Old records */
> > +       efi_capsule_header_t **hdrs;
> > +       u32 hdrs_num;
> > +       off_t hdr_offset;
> > +
> > +       /* New records */
> > +       struct efi_capsule_pstore_buf console;
> > +       struct efi_capsule_pstore_buf ftrace;
> > +       struct efi_capsule_pstore_buf dmesg;
> > +       struct efi_capsule_pstore_buf pmsg;
> > +};
> > +
> > +struct efi_capsule_pstore_record {
> > +       u64 timestamp;
> > +       u64 id;
> > +       enum pstore_type_id type;
> > +       size_t size;
> > +       bool compressed;
> > +       u32 magic;
> > +       char data[];
> > +} __packed;
> > +
> > +struct efi_capsule_table {
> > +       u32 capsule_array_number;
> > +       void *capsule_addr[];
> > +} __packed;
> > +
> > +static struct efi_capsule_table *efi_capsule_table_get(efi_guid_t guid)
> > +{
> > +       unsigned long table = EFI_INVALID_TABLE_ADDR;
> > +       void *p, *tablep = NULL, *tablec = NULL;
> > +       int i, sz;
> > +       u32 n;
> > +
> > +       if (efi.config_table == EFI_INVALID_TABLE_ADDR ||
> > +           efi.nr_config_table == 0)
> > +               return NULL;
> > +
> > +       if (efi_enabled(EFI_64BIT))
> > +               sz = sizeof(efi_config_table_64_t);
> > +       else
> > +               sz = sizeof(efi_config_table_32_t);
> > +
> > +       tablep = memremap(efi.config_table, efi.nr_config_table * sz,
> > +                         MEMREMAP_WB);
> > +       if (!tablep)
> > +               return NULL;
> > +
> > +       p = tablep;
> > +       for (i = 0; i < efi.nr_config_table; i++) {
> > +               efi_guid_t id;
> > +
> > +               if (efi_enabled(EFI_64BIT)) {
> > +                       id = ((efi_config_table_64_t *)p)->guid;
> > +                       if (!efi_guidcmp(id, guid)) {
> > +                               table = ((efi_config_table_64_t *)p)->table;
> > +                               break;
> > +                       }
> > +               } else {
> > +                       id = ((efi_config_table_32_t *)p)->guid;
> > +                       if (!efi_guidcmp(id, guid)) {
> > +                               table = ((efi_config_table_32_t *)p)->table;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               p += sz;
> > +       }
> > +
> > +       if (table == EFI_INVALID_TABLE_ADDR)
> > +               goto out;
> > +
> > +       sz = sizeof(u32);
> > +       tablec = memremap(table, sz, MEMREMAP_WB);
> > +       if (!tablec)
> > +               goto out;
> > +
> > +       /*
> > +        * The array of capsules is prefixed with the number of
> > +        * capsule entries in the array.
> > +        */
> > +       n = *(u32 *)tablec;
> > +       memunmap(tablec);
> > +       if (!n) {
> > +               pr_info("No capsules on extraction\n");
> > +               goto out;
> > +       }
> > +
> > +       sz += n * sizeof(*tablec);
> > +       tablec = memremap(table, sz, MEMREMAP_WB);
> > +
> > +out:
> > +       memunmap(tablep);
> > +       return (struct efi_capsule_table *)tablec;
> > +}
> > +
>
> As indicated in response to your cover letter, please replace this
> with an entry in common_tables[] in drivers/firmware/efi/efi.c.
>
> > +/**
> > + * efi_capsule_lookup - search capsule array for entries.
> > + * @guid: the guid to search for.
> > + * @nr_caps: the number of entries found.
> > + *
> > + * Map each capsule header into the kernel's virtual address space and
> > + * inspect the guid. Build an array of capsule headers with every
> > + * capsule that is found with @guid. If a match is found the capsule
> > + * remains mapped, otherwise it is unmapped.
> > + *
> > + * Returns an array of capsule headers, each element of which has the
> > + * guid @guid. The number of elements in the array is stored in
> > + * @nr_caps. Returns %NULL if no capsules were found and stores zero
> > + * in @nr_caps.
> > + */
> > +static efi_capsule_header_t **efi_capsule_lookup(efi_guid_t guid, u32 *nr_caps)
> > +{
> > +       efi_capsule_header_t **capsules = NULL, **tmp;
> > +       struct efi_capsule_table *tablec;
> > +       int i, sz = 0;
> > +
> > +       tablec = efi_capsule_table_get(guid);
> > +       if (!tablec)
> > +               return NULL;
> > +
> > +       *nr_caps = 0;
> > +       for (i = 0; i < tablec->capsule_array_number; i++) {
> > +               efi_capsule_header_t *c;
> > +               size_t size;
> > +
> > +               c = memremap((resource_size_t)tablec->capsule_addr[i],
> > +                            sizeof(*c), MEMREMAP_WB);
> > +               if (!c) {
> > +                       pr_err("Fail to memremap capsule header\n");
> > +                       continue;
> > +               }
> > +
> > +               size = c->imagesize;
> > +               memunmap(c);
> > +
> > +               c = memremap((resource_size_t)tablec->capsule_addr[i],
> > +                            size, MEMREMAP_WB);
> > +               if (!c) {
> > +                       pr_err("Fail to memremap capsule header + data\n");
> > +                       continue;
> > +               }
> > +
> > +               sz += sizeof(*capsules);
> > +               tmp = krealloc(capsules, sz, GFP_KERNEL);
> > +               if (!tmp) {
> > +                       for (i = 0; i < *nr_caps; i++)
> > +                               memunmap(capsules[i]);
> > +
> > +                       kfree(capsules);
> > +                       memunmap(tablec);
> > +
> > +                       return NULL;
> > +               }
> > +
> > +               capsules = tmp;
> > +               capsules[(*nr_caps)++] = c;
> > +       }
> > +
> > +       memunmap(tablec);
> > +
> > +       return capsules;
> > +}
> > +
> > +static __init void efi_capsule_destroy(struct efi_capsule_ctx *ctx)
> > +{
> > +       if (IS_ERR_OR_NULL(ctx))
> > +               return;
> > +
> > +       vunmap(ctx->capsule);
> > +
> > +       while (ctx->nr_pages--)
> > +               __free_page(ctx->pages[ctx->nr_pages]);
> > +
> > +       kfree(ctx->pages);
> > +       kfree(ctx->phys_addrs);
> > +       kfree(ctx);
> > +}
> > +
> > +/**
> > + * efi_capsule_build - alloc data buffer and fill out the header
> > + * @guid: vendor's guid
> > + * @data_size: size in bytes of the capsule data
> > + *
> > + * This is a helper function for allocating enough room for user data
> > + * + the size of an EFI capsule header.
> > + *
> > + * Returns a pointer to an allocated capsule on success, an ERR_PTR()
> > + * value on error.
> > + */
> > +static __init struct efi_capsule_ctx *
> > +efi_capsule_build(efi_guid_t guid, size_t data_size)
> > +{
> > +       size_t capsule_size, needed_pages;
> > +       struct efi_capsule_ctx *ctx;
> > +       u32 flags;
> > +       int rv;
> > +
> > +       flags = EFI_CAPSULE_PERSIST_ACROSS_RESET |
> > +               EFI_CAPSULE_POPULATE_SYSTEM_TABLE;
> > +       needed_pages = ALIGN(data_size + sizeof(efi_capsule_header_t),
> > +                            PAGE_SIZE) >> PAGE_SHIFT;
> > +       capsule_size = needed_pages * PAGE_SIZE;
> > +       data_size = capsule_size - sizeof(efi_capsule_header_t);
> > +
> > +       rv = efi_capsule_supported(LINUX_EFI_CRASH_GUID, flags,
> > +                                  capsule_size, &efi_reset_type);
> > +       if (rv)
> > +               return ERR_PTR(rv);
> > +
> > +       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +       if (!ctx)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       ctx->pages = kcalloc(needed_pages, sizeof(*ctx->pages), GFP_KERNEL);
> > +       if (!ctx->pages)
> > +               goto fail;
> > +
> > +       ctx->phys_addrs = kcalloc(needed_pages, sizeof(*ctx->phys_addrs),
> > +                                 GFP_KERNEL);
> > +       if (!ctx->phys_addrs)
> > +               goto fail;
> > +
> > +       while (needed_pages--) {
> > +               struct page *page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
> > +
> > +               if (!page)
> > +                       goto fail;
> > +
> > +               ctx->pages[ctx->nr_pages] = page;
> > +               ctx->phys_addrs[ctx->nr_pages++] = page_to_phys(page);
> > +       }
> > +
> > +       ctx->capsule = vmap(ctx->pages, ctx->nr_pages, 0, PAGE_KERNEL);
> > +       if (!ctx->capsule)
> > +               goto fail;
> > +
> > +       ctx->capsule_size = capsule_size;
> > +       ctx->data = (void *)ctx->capsule + sizeof(efi_capsule_header_t);
> > +       ctx->data_size = data_size;
> > +
> > +       /* Setup the EFI capsule header */
> > +       memcpy(&ctx->capsule->guid, &guid, sizeof(guid));
> > +       ctx->capsule->flags = flags;
> > +       ctx->capsule->headersize = sizeof(*ctx->capsule);
> > +       ctx->capsule->imagesize = capsule_size;
> > +
> > +       return ctx;
> > +
> > +fail:
> > +       efi_capsule_destroy(ctx);
> > +       return ERR_PTR(-ENOMEM);
> > +}
> > +
> > +/**
> > + * Return the next pstore record that was passed to us across a reboot
> > + * in an EFI capsule.
> > + *
> > + * This is expected to be called under the pstore
> > + * read_mutex. Therefore, no serialisation is done here.
> > + */
> > +static struct efi_capsule_pstore_record *
> > +get_pstore_read_record(struct efi_capsule_pstore *pctx)
> > +{
> > +       struct efi_capsule_pstore_record *rec;
> > +       efi_capsule_header_t *hdr;
> > +       off_t remaining;
> > +
> > +next:
> > +       if (!pctx->hdrs_num)
> > +               return NULL;
> > +
> > +       hdr = pctx->hdrs[pctx->hdrs_num - 1];
> > +       rec = (void *)hdr + hdr->headersize + pctx->hdr_offset;
> > +
> > +       /*
> > +        * A single EFI capsule may contain multiple pstore
> > +        * records. It may also only be partially filled with pstore
> > +        * records, which we can detect by checking for a record with
> > +        * zero size.
> > +        *
> > +        * If there are no more records or invalid records in this
> > +        * capsule try the next.
> > +        */
> > +       if (!rec->size || rec->size > CAPSULE_SIZE -
> > +           sizeof(efi_capsule_header_t) - offsetof(typeof(*rec), data)) {
> > +               pctx->hdrs_num--;
> > +               pctx->hdr_offset = 0;
> > +               goto next;
> > +       }
> > +
> > +       remaining = hdr->imagesize - hdr->headersize - pctx->hdr_offset -
> > +                   offsetof(typeof(*rec), data);
> > +
> > +       /*
> > +        * If we've finished parsing all records in this capsule, move
> > +        * onto the next. Otherwise, increment the offset into the
> > +        * current capsule (pctx->hdr_offset).
> > +        */
> > +       if (rec->size == remaining) {
> > +               pctx->hdrs_num--;
> > +               pctx->hdr_offset = 0;
> > +       } else {
> > +               pctx->hdr_offset += rec->size + offsetof(typeof(*rec), data);
> > +       }
> > +
> > +       return rec;
> > +}
> > +
> > +static ssize_t efi_capsule_pstore_read(struct pstore_record *record)
> > +{
> > +       struct efi_capsule_pstore *pctx = record->psi->data;
> > +       struct efi_capsule_pstore_record *rec;
> > +       ssize_t size;
> > +
> > +       rec = get_pstore_read_record(pctx);
> > +       if (!rec)
> > +               return 0;
> > +
> > +       if (rec->magic != CAPSULE_MAGIC) {
> > +               pr_info("Invalid capsule record!\n");
> > +               return 0;
> > +       }
> > +
> > +       record->type = rec->type;
> > +       record->time.tv_sec = rec->timestamp;
> > +       record->time.tv_nsec = 0;
> > +       size = rec->size;
> > +       record->id = rec->id;
> > +       record->compressed = rec->compressed;
> > +       record->ecc_notice_size = 0;
> > +       record->buf = kmalloc(size, GFP_KERNEL);
> > +
> > +       if (!record->buf)
> > +               return -ENOMEM;
> > +
> > +       memcpy(record->buf, rec->data, size);
> > +
> > +       return size;
> > +}
> > +
> > +/*
> > + * We expect to be called with ->buf_lock held, and so don't perform
> > + * any serialisation.
> > + */
> > +static struct notrace efi_capsule_pstore_record *
> > +get_pstore_write_record(struct efi_capsule_pstore_buf *pbuf, size_t *size)
> > +{
> > +       struct efi_capsule_pstore_record *rec;
> > +       long offset = atomic_long_read(&pbuf->offset);
> > +
> > +       if (offset + offsetof(typeof(*rec), data) >= pbuf->size)
> > +               return NULL;
> > +
> > +       /* Trim 'size' if there isn't enough remaining space */
> > +       if (offset + *size + offsetof(typeof(*rec), data) > pbuf->size)
> > +               *size = pbuf->size - offset - offsetof(typeof(*rec), data);
> > +
> > +       rec = pbuf->buf + offset;
> > +       atomic_long_add(offsetof(typeof(*rec), data) + *size, &pbuf->offset);
> > +
> > +       return rec;
> > +}
> > +
> > +static notrace void *
> > +get_pstore_write_ring_buf(struct efi_capsule_pstore_buf *pbuf, size_t size)
> > +{
> > +       struct efi_capsule_pstore_record *rec = pbuf->buf;
> > +       size_t ring_size = pbuf->size - offsetof(typeof(*rec), data);
> > +       void *ring_buf = pbuf->buf + offsetof(typeof(*rec), data);
> > +       atomic_long_t *ring_offset = &pbuf->offset;
> > +       long next, curr;
> > +
> > +       if (size > ring_size)
> > +               return NULL;
> > +
> > +       if (rec->size + size > ring_size)
> > +               rec->size = ring_size;
> > +       else
> > +               rec->size += size;
> > +
> > +       do {
> > +               curr = atomic_long_read(ring_offset);
> > +               next = curr + size;
> > +
> > +               if (next > ring_size) {
> > +                       next = size;
> > +                       if (atomic_long_cmpxchg(ring_offset, curr, next)) {
> > +                               curr = 0;
> > +                               break;
> > +                       }
> > +                       continue;
> > +               }
> > +
> > +       } while (atomic_long_cmpxchg(ring_offset, curr, next) != curr);
> > +
> > +       return ring_buf + curr;
> > +}
> > +
> > +static int notrace efi_capsule_pstore_write(struct pstore_record *record)
> > +{
> > +       struct efi_capsule_pstore *pctx = record->psi->data;
> > +       struct efi_capsule_pstore_record *rec;
> > +       static atomic64_t seq;
> > +       void *dst;
> > +
> > +       /*
> > +        * A zero size record would break our detection of
> > +        * partially-filled capsules.
> > +        */
> > +       if (!record->size)
> > +               return -EINVAL;
> > +
> > +       if (record->type == PSTORE_TYPE_CONSOLE) {
> > +               dst = get_pstore_write_ring_buf(&pctx->console, record->size);
> > +       } else if (record->type == PSTORE_TYPE_FTRACE) {
> > +               dst = get_pstore_write_ring_buf(&pctx->ftrace, record->size);
> > +       } else if (record->type == PSTORE_TYPE_DMESG) {
> > +               size_t size = record->size;
> > +
> > +               rec = get_pstore_write_record(&pctx->dmesg, &record->size);
> > +               if (!rec || (record->compressed && record->size < size))
> > +                       return -ENOSPC;
> > +
> > +               rec->type = record->type;
> > +               rec->timestamp = record->time.tv_sec;
> > +               rec->size = record->size;
> > +               if (!atomic64_read(&seq))
> > +                       atomic64_set(&seq, rec->timestamp << 32);
> > +               record->id = atomic64_inc_return(&seq);
> > +               rec->id = record->id;
> > +               rec->compressed = record->compressed;
> > +               rec->magic = CAPSULE_MAGIC;
> > +
> > +               dst = rec->data;
> > +       } else if (record->type == PSTORE_TYPE_PMSG) {
> > +               pr_warn_ratelimited("PMSG should not call %s\n", __func__);
> > +               return -EINVAL;
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!dst)
> > +               return -ENOSPC;
> > +
> > +       memcpy(dst, record->buf, record->size);
> > +
> > +       return 0;
> > +}
> > +
> > +static int notrace
> > +efi_capsule_pstore_write_user(struct pstore_record *record,
> > +                             const char __user *buf)
> > +{
> > +       struct efi_capsule_pstore *pctx = record->psi->data;
> > +       void *dst;
> > +
> > +       if (record->type == PSTORE_TYPE_PMSG) {
> > +               dst = get_pstore_write_ring_buf(&pctx->pmsg, record->size);
> > +               if (!dst)
> > +                       return -ENOSPC;
> > +
> > +               if (unlikely(__copy_from_user(dst, buf, record->size)))
> > +                       return -EFAULT;
> > +
> > +               return 0;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static struct pstore_info efi_capsule_pstore_info = {
> > +       .owner      = THIS_MODULE,
> > +       .name       = "capsule-pstore",
> > +       .bufsize    = CRASH_SIZE,
> > +       .flags      = PSTORE_FLAGS_DMESG | PSTORE_FLAGS_CONSOLE |
> > +                     PSTORE_FLAGS_FTRACE | PSTORE_FLAGS_PMSG,
> > +       .read       = efi_capsule_pstore_read,
> > +       .write      = efi_capsule_pstore_write,
> > +       .write_user = efi_capsule_pstore_write_user,
> > +};
> > +
> > +static __init int check_capsule_support(void)
> > +{
> > +       int rv;
> > +
> > +       efi_guid_t guid = LINUX_EFI_CRASH_GUID;
> > +       u32 flags = EFI_CAPSULE_PERSIST_ACROSS_RESET |
> > +                   EFI_CAPSULE_POPULATE_SYSTEM_TABLE;
> > +
> > +       rv = efi_capsule_supported(guid, flags, CAPSULE_SIZE, &efi_reset_type);
> > +       if (rv)
> > +               return rv;
> > +
> > +       return 0;
> > +}
> > +
> > +#define BUILD_UPDATE_CAPSULE(name) \
> > +       do { \
> > +               name##_ctx = efi_capsule_build(LINUX_EFI_CRASH_GUID,\
> > +                                              CAPSULE_SIZE); \
> > +               if (IS_ERR(name##_ctx)) { \
> > +                       rv = PTR_ERR(name##_ctx); \
> > +                       name##_ctx = NULL; \
> > +                       pr_info("Fail to build %s capsule\n", #name); \
> > +                       goto fail_##name; \
> > +               } \
> > +               rv = efi_capsule_update(name##_ctx->capsule,\
> > +                                       name##_ctx->phys_addrs); \
> > +               if (rv) { \
> > +                       pr_info("Fail to register %s with firmware\n", #name); \
> > +                       goto fail_##name; \
> > +               } \
> > +       } while (0)
> > +
> > +#define INIT_PSTORE_RECORD(name, type_id) \
> > +       do { \
> > +               memset(name##_ctx->data, 0, name##_ctx->data_size); \
> > +               pctx->name.size = name##_ctx->data_size; \
> > +               pctx->name.buf = name##_ctx->data; \
> > +               rec = pctx->name.buf; \
> > +               rec->type = type_id; \
> > +               rec->magic = CAPSULE_MAGIC; \
> > +               atomic_long_set(&pctx->name.offset, 0); \
> > +       } while (0)
> > +
> > +/**
> > + * We may not be in a position to allocate memory at the time of a
> > + * crash, so pre-allocate some space now and register it with the
> > + * firmware via efi_capsule_update().
> > + *
> > + * Also, iterate through the array of capsules pointed to from the EFI
> > + * system table and take note of any LINUX_EFI_CRASH_GUID
> > + * capsules. They will be parsed by efi_capsule_pstore_read().
> > + */
> > +static __init int efi_capsule_pstore_setup(void)
> > +{
> > +       struct efi_capsule_ctx *console_ctx = NULL;
> > +       struct efi_capsule_ctx *ftrace_ctx = NULL;
> > +       struct efi_capsule_ctx *dmesg_ctx = NULL;
> > +       struct efi_capsule_ctx *pmsg_ctx = NULL;
> > +       struct efi_capsule_pstore *pctx = NULL;
> > +       struct efi_capsule_pstore_record *rec;
> > +       efi_capsule_header_t **hdrs;
> > +       void *crash_buf = NULL;
> > +       u32 hdrs_num = 0;
> > +       int rv;
> > +
> > +       pctx = kzalloc(sizeof(*pctx), GFP_KERNEL);
> > +       if (!pctx)
> > +               return -ENOMEM;
> > +
> > +       crash_buf = kmalloc(CRASH_SIZE, GFP_KERNEL);
> > +       if (!crash_buf) {
> > +               rv = -ENOMEM;
> > +               goto fail;
> > +       }
> > +
> > +       /* Allocate and pass capsules to firmware upfront. */
> > +       BUILD_UPDATE_CAPSULE(console);
> > +       BUILD_UPDATE_CAPSULE(ftrace);
> > +       BUILD_UPDATE_CAPSULE(dmesg);
> > +       BUILD_UPDATE_CAPSULE(pmsg);
> > +
> > +       /* Initialize the pstore records. */
> > +       INIT_PSTORE_RECORD(console, PSTORE_TYPE_CONSOLE);
> > +       INIT_PSTORE_RECORD(ftrace, PSTORE_TYPE_FTRACE);
> > +       INIT_PSTORE_RECORD(dmesg, PSTORE_TYPE_DMESG);
> > +       INIT_PSTORE_RECORD(pmsg, PSTORE_TYPE_PMSG);
> > +
> > +       /* Read any pstore entries that were passed across a reboot. */
> > +       hdrs = efi_capsule_lookup(LINUX_EFI_CRASH_GUID, &hdrs_num);
> > +       pctx->hdrs_num = hdrs_num;
> > +       pctx->hdrs = hdrs;
> > +
> > +       /* Register the capsule backend with pstore. */
> > +       efi_capsule_pstore_info.buf = crash_buf;
> > +       efi_capsule_pstore_info.data = pctx;
> > +       rv = pstore_register(&efi_capsule_pstore_info);
> > +
> > +       if (!rv)
> > +               return 0;
> > +
> > +       pr_err("Fail to register capsule support for pstore: %d\n", rv);
> > +
>
> I'm not a big fan of the 'success handling' pattern. Could you please
> just add another label to jump to, and invert the conditional?
>
> > +       efi_capsule_destroy(pmsg_ctx);
> > +fail_pmsg:
> > +       efi_capsule_destroy(dmesg_ctx);
> > +fail_dmesg:
> > +       efi_capsule_destroy(ftrace_ctx);
> > +fail_ftrace:
> > +       efi_capsule_destroy(console_ctx);
> > +fail_console:
> > +       kfree(crash_buf);
> > +fail:
> > +       kfree(pctx);
> > +
> > +       return rv;
> > +}
> > +
> > +static __init int efi_capsule_pstore_init(void)
> > +{
> > +       int rv = 0;
> > +
> > +       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> > +               return -ENODEV;
> > +
>
> Please use the new API to check for EFI_RT_UPDATE_CAPSULE availability.
>
> > +       if (efi_capsule_pstore_disable) {
> > +               pr_info("Capsule-pstore is disabled\n ");
> > +               return 0;
> > +       }
> > +
> > +       rv = check_capsule_support();
> > +       if (rv) {
> > +               pr_info("Capsule-pstore is not supported: %d\n ", rv);
> > +               return rv;
> > +       }
> > +
> > +       rv = efi_capsule_pstore_setup();
> > +       if (rv) {
> > +               pr_err("Fail to setup capsule-pstore: %d\n", rv);
> > +               return rv;
> > +       }
> > +
> > +       /*
> > +        * Once the memory reserved for capsules passed to the firmware
> > +        * by EFI UpdateCapsule(), there's no way to let firmware give up
> > +        * the capsules. So this module cannot be unloaded once loaded.
> > +        */
> > +       __module_get(THIS_MODULE);
> > +
> > +       return 0;
> > +}
> > +
> > +static __exit void efi_capsule_pstore_exit(void) {}
> > +
> > +module_init(efi_capsule_pstore_init);
> > +module_exit(efi_capsule_pstore_exit);
> > +
> > +module_param_named(pstore_disable, efi_capsule_pstore_disable, bool, 0644);
> > +
> > +MODULE_DESCRIPTION("EFI capsule backend for pstore");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
