Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5612E426
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 10:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgABJCQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 04:02:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54444 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgABJCQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 04:02:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so4964704wmj.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cd3TpXBK+IawPjaw7aXD6zwvAgQhDNn6DDpmTH/NmA=;
        b=KNP/vimFNK5FMj+XsgC3HDeHP790Mksx5nUjTP9WpHmZqugxqPcgVorw120zkCiCsS
         W/vXqj8psAeKIzqQN9itoqKzpaCxtJu8DzBl9Gd2aQfHmnmeINQvVk+vWdbKlvcWV+Kz
         Sa6X6Pd5BxM2ialVGM8Y4ZeiSalVOZ0V8M6N4b1hcFt8OZe5DCP/tvYQmM1Bmt2qG/jF
         XbBoqje6MpbCno2d/jGlbsH0Mo5JRBwGRq+pzetLOFMBqfQJWQT/b/BsA9OvPLzVHU89
         +29zre4T7h4FMv7rizfaWgAwT7Uua+28L4fLUBBFTlPNJO7t+aqBbAp7rQrqyEkjzefC
         v4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cd3TpXBK+IawPjaw7aXD6zwvAgQhDNn6DDpmTH/NmA=;
        b=Luq7Dxf2BdEVQYOTR5kQ5UaRkwIDfDUWlbpUcyzydRvDolw3H+QxKtEGaA8mh6Fwax
         WqE+bdaz7LVELVD2ZjdkLdhPinuZVw6JFzyBuEm7dy6HDPTlQgG/aDQ9+8Tw3EMCLJb3
         pLVHVnOCJFv/p9vroHzty1Ye5t6kKKBFDHfsIxv90b9N/sK/+gtwNnrVJrQ27Fb5Mb8S
         PxWDnAMy6XUfROPeASoiWaRYlLm7JlTlD+el3N/gwrh7wYT2QGMDA3dOsM8TzxN8Uy08
         gucpkA+gOJ5TU40CUbqKfL5v1eBnO5giFlVkagjLMKijMtOcjEeUtkvIk5m1Cywu3yGt
         UDmQ==
X-Gm-Message-State: APjAAAVBtvTODxN+LXpyzQuY4XPRL6a+yJzvFwd6BdDN16UbvpYsb7vY
        kN4cIN3sxCLCwhrDRzrLQODVi/ylDsaszAxPPu0LWrvkvFQ=
X-Google-Smtp-Source: APXvYqzzB/zIGsvariBu5SIfw++3sUzS0igh4Mc8RsB9yOaotLjMsfSJvh1WK64gidIIQBjNl6FqKpqbYz3OkQY/AiA=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr13795383wmc.9.1577955732121;
 Thu, 02 Jan 2020 01:02:12 -0800 (PST)
MIME-Version: 1.0
References: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157793840865.977550.1385745645244916944.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157793840865.977550.1385745645244916944.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 10:02:00 +0100
Message-ID: <CAKv+Gu8JTha-Os6uzg_ghxodEKgjnkgLwJYFkXZiTbqqdKU6_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] efi: Add tracking for dynamically allocated memmaps
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,

Thanks for taking the time to really fix this properly.

Comments/questions below.

On Thu, 2 Jan 2020 at 05:29, Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for fixing efi_memmap_alloc() leaks, add support for
> recording whether the memmap was dynamically allocated from slab,
> memblock, or is the original physical memmap provided by the platform.
>
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/platform/efi/efi.c     |    2 +-
>  arch/x86/platform/efi/quirks.c  |   11 ++++++-----
>  drivers/firmware/efi/fake_mem.c |    5 +++--
>  drivers/firmware/efi/memmap.c   |   16 ++++++++++------
>  include/linux/efi.h             |    8 ++++++--
>  5 files changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 38d44f36d5ed..7086afbb84fd 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -333,7 +333,7 @@ static void __init efi_clean_memmap(void)
>                 u64 size = efi.memmap.nr_map - n_removal;
>
>                 pr_warn("Removing %d invalid memory map entries.\n", n_removal);
> -               efi_memmap_install(efi.memmap.phys_map, size);
> +               efi_memmap_install(efi.memmap.phys_map, size, 0);
>         }
>  }
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f8f0220b6a66..4a71c790f9c3 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -244,6 +244,7 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
>  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  {
>         phys_addr_t new_phys, new_size;
> +       unsigned long flags = 0;
>         struct efi_mem_range mr;
>         efi_memory_desc_t md;
>         int num_entries;
> @@ -272,8 +273,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>         num_entries += efi.memmap.nr_map;
>
>         new_size = efi.memmap.desc_size * num_entries;
> -
> -       new_phys = efi_memmap_alloc(num_entries);
> +       new_phys = efi_memmap_alloc(num_entries, &flags);
>         if (!new_phys) {
>                 pr_err("Could not allocate boot services memmap\n");
>                 return;
> @@ -288,7 +288,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>         efi_memmap_insert(&efi.memmap, new, &mr);
>         early_memunmap(new, new_size);
>
> -       efi_memmap_install(new_phys, num_entries);
> +       efi_memmap_install(new_phys, num_entries, flags);
>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>         e820__update_table(e820_table);
>  }
> @@ -408,6 +408,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
>  void __init efi_free_boot_services(void)
>  {
>         phys_addr_t new_phys, new_size;
> +       unsigned long flags = 0;
>         efi_memory_desc_t *md;
>         int num_entries = 0;
>         void *new, *new_md;
> @@ -463,7 +464,7 @@ void __init efi_free_boot_services(void)
>                 return;
>
>         new_size = efi.memmap.desc_size * num_entries;
> -       new_phys = efi_memmap_alloc(num_entries);
> +       new_phys = efi_memmap_alloc(num_entries, &flags);
>         if (!new_phys) {
>                 pr_err("Failed to allocate new EFI memmap\n");
>                 return;
> @@ -493,7 +494,7 @@ void __init efi_free_boot_services(void)
>
>         memunmap(new);
>
> -       if (efi_memmap_install(new_phys, num_entries)) {
> +       if (efi_memmap_install(new_phys, num_entries, flags)) {
>                 pr_err("Could not install new EFI memmap\n");
>                 return;
>         }
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index bb9fc70d0cfa..7e53e5520548 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -39,6 +39,7 @@ void __init efi_fake_memmap(void)
>         int new_nr_map = efi.memmap.nr_map;
>         efi_memory_desc_t *md;
>         phys_addr_t new_memmap_phy;
> +       unsigned long flags = 0;
>         void *new_memmap;
>         int i;
>
> @@ -55,7 +56,7 @@ void __init efi_fake_memmap(void)
>         }
>
>         /* allocate memory for new EFI memmap */
> -       new_memmap_phy = efi_memmap_alloc(new_nr_map);
> +       new_memmap_phy = efi_memmap_alloc(new_nr_map, &flags);
>         if (!new_memmap_phy)
>                 return;
>
> @@ -73,7 +74,7 @@ void __init efi_fake_memmap(void)
>         /* swap into new EFI memmap */
>         early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
>
> -       efi_memmap_install(new_memmap_phy, new_nr_map);
> +       efi_memmap_install(new_memmap_phy, new_nr_map, flags);
>

So it is the caller's responsibility to record the flags returned by
efi_memmap_alloc() and pass them into efi_memmap_install(), right?
Given that we are now passing three pieces of info that need to be in
sync between the two, could we use a dedicated data structure instead,
a reference to which is taken by both?


>         /* print new EFI memmap */
>         efi_print_memmap();
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 813674ef9000..2b81ee6858a9 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -32,6 +32,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>  /**
>   * efi_memmap_alloc - Allocate memory for the EFI memory map
>   * @num_entries: Number of entries in the allocated map.
> + * @flags: Late map, memblock alloc, slab alloc flags
>   *
>   * Depending on whether mm_init() has already been invoked or not,
>   * either memblock or "normal" page allocation is used.
> @@ -39,20 +40,23 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>   * Returns the physical address of the allocated memory map on
>   * success, zero on failure.
>   */
> -phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
> +phys_addr_t __init efi_memmap_alloc(unsigned int num_entries, unsigned long *flags)
>  {
>         unsigned long size = num_entries * efi.memmap.desc_size;
>
> -       if (slab_is_available())
> +       if (slab_is_available()) {
> +               *flags |= EFI_MEMMAP_SLAB;
>                 return __efi_memmap_alloc_late(size);
> +       }
>
> +       *flags |= EFI_MEMMAP_MEMBLOCK;

This assumes flags has neither bit set, but perhaps we should at least
clear the memblock one if we set the slab one?

>         return __efi_memmap_alloc_early(size);
>  }
>
>  /**
>   * __efi_memmap_init - Common code for mapping the EFI memory map
>   * @data: EFI memory map data
> - * @flags: Use early or late mapping function?
> + * @flags: Use early or late mapping function, and allocator
>   *
>   * This function takes care of figuring out which function to use to
>   * map the EFI memory map in efi.memmap based on how far into the boot
> @@ -192,10 +196,10 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
>   *
>   * Returns zero on success, a negative error code on failure.
>   */
> -int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
> +int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
> +               unsigned long flags)
>  {
>         struct efi_memory_map_data data;
> -       unsigned long flags;
>
>         efi_memmap_unmap();
>
> @@ -203,7 +207,7 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
>         data.size = efi.memmap.desc_size * nr_map;
>         data.desc_version = efi.memmap.desc_version;
>         data.desc_size = efi.memmap.desc_size;
> -       flags = efi.memmap.flags & EFI_MEMMAP_LATE;
> +       flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
>
>         return __efi_memmap_init(&data, flags);
>  }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index b8e930f5ff77..fa2668a992ae 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -796,6 +796,8 @@ struct efi_memory_map {
>         unsigned long desc_version;
>         unsigned long desc_size;
>  #define EFI_MEMMAP_LATE (1UL << 0)
> +#define EFI_MEMMAP_MEMBLOCK (1UL << 1)
> +#define EFI_MEMMAP_SLAB (1UL << 2)
>         unsigned long flags;
>  };
>
> @@ -1057,11 +1059,13 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
>  #endif
>  extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
>
> -extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
> +extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries,
> +               unsigned long *flags);
>  extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
>  extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
>  extern void __init efi_memmap_unmap(void);
> -extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map);
> +extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
> +               unsigned long flags);
>  extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
>                                          struct range *range);
>  extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
>
