Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1526131843
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2020 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFTFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 14:05:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40402 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFTFg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 14:05:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so16181484oib.7
        for <linux-efi@vger.kernel.org>; Mon, 06 Jan 2020 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alX9B07HokhP3ECivMm8pGprXZuv/KIuu13Y0Jtq3rg=;
        b=BLpK3J9bEkd6Wg2RItLkAFU/N5U4jsc764hHw3yBcw3+usDirwaNCn/42kqfH64cV+
         oKl6ogYaLW4hZg2GMAIQY0ho7+sKRVlxpCnOWd1sfmjIQDCC//p1wTsMNI01AdG3w0xU
         SyowTtxuWicITn6hSIbggt9P5IFTn59TBd546vxUCqVjqcNCGSOAmZc30Q/KzmimdxjZ
         wGae8x99zXO3rnxaXWswDTOYTWFvuwsMAgFJ/HGB1gy5RLdic16ylAV8tyxK3WaFz8l2
         oBor7VmJvgBEg4hKcfLxI8gGUqp4cpQcVFxeLFLoRfWqHyWAj3JKgU57vYi0ksVjST35
         rJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alX9B07HokhP3ECivMm8pGprXZuv/KIuu13Y0Jtq3rg=;
        b=NR6Dzox89Q2AXdQy7TSv92M5qiFG85R2JdSYb+B27G5lqp024CJNxNQaj4uOH4DoWd
         Fu8mP8E1AzDqhPPVhDsHj+G8XM7BlmUtaEDxggU3pzINJGvbAlNR+bzpu4f9Z1UizdFh
         gR7MI2H4oDI0e4HsB0EXi7xvM0gh8coLHQyTnk3VOXGog34OZD1lj+WKp4eDNd/nTOVd
         P9ZwHkoabu3eyyl+nbN/V2C+WAb0odNNqqX/HW05Te1E7tz0CGInQR2AwS4NGI4gFBbJ
         fSgsp+OlAcI3g8yMxBESGtXkN9WzgWeu6rUjAB6xwiuzEC2JFHxqGWgMoeb7B5pv0sEA
         IMXw==
X-Gm-Message-State: APjAAAWwNbzl5wLaFxcyvOhrfoCZNhNumhRDlfkP80gMzIEGUttbV3Y+
        Q1U5v8qfrCzl0eFa95zqdT+YqylRyxxqu/7XTSkKtg==
X-Google-Smtp-Source: APXvYqwq2F38iwC/q1v5HcOMi4czC/1PUV5A5pBl22QCQ8iuB1wjy6FX5YvmNx5+uzxdNN5E951SvkRKr6IFVGHaryg=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr5940073oia.73.1578337535501;
 Mon, 06 Jan 2020 11:05:35 -0800 (PST)
MIME-Version: 1.0
References: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157793840865.977550.1385745645244916944.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8JTha-Os6uzg_ghxodEKgjnkgLwJYFkXZiTbqqdKU6_Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu8JTha-Os6uzg_ghxodEKgjnkgLwJYFkXZiTbqqdKU6_Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jan 2020 11:05:24 -0800
Message-ID: <CAPcyv4jqqJwxk8-dZxhZQX0PqNpdsAUVJBG+QufsJx+fhPzmug@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] efi: Add tracking for dynamically allocated memmaps
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Thu, Jan 2, 2020 at 1:02 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Hi Dan,
>
> Thanks for taking the time to really fix this properly.
>
> Comments/questions below.
>
> On Thu, 2 Jan 2020 at 05:29, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > In preparation for fixing efi_memmap_alloc() leaks, add support for
> > recording whether the memmap was dynamically allocated from slab,
> > memblock, or is the original physical memmap provided by the platform.
> >
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/platform/efi/efi.c     |    2 +-
> >  arch/x86/platform/efi/quirks.c  |   11 ++++++-----
> >  drivers/firmware/efi/fake_mem.c |    5 +++--
> >  drivers/firmware/efi/memmap.c   |   16 ++++++++++------
> >  include/linux/efi.h             |    8 ++++++--
> >  5 files changed, 26 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 38d44f36d5ed..7086afbb84fd 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -333,7 +333,7 @@ static void __init efi_clean_memmap(void)
> >                 u64 size = efi.memmap.nr_map - n_removal;
> >
> >                 pr_warn("Removing %d invalid memory map entries.\n", n_removal);
> > -               efi_memmap_install(efi.memmap.phys_map, size);
> > +               efi_memmap_install(efi.memmap.phys_map, size, 0);
> >         }
> >  }
> >
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index f8f0220b6a66..4a71c790f9c3 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -244,6 +244,7 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
> >  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> >  {
> >         phys_addr_t new_phys, new_size;
> > +       unsigned long flags = 0;
> >         struct efi_mem_range mr;
> >         efi_memory_desc_t md;
> >         int num_entries;
> > @@ -272,8 +273,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> >         num_entries += efi.memmap.nr_map;
> >
> >         new_size = efi.memmap.desc_size * num_entries;
> > -
> > -       new_phys = efi_memmap_alloc(num_entries);
> > +       new_phys = efi_memmap_alloc(num_entries, &flags);
> >         if (!new_phys) {
> >                 pr_err("Could not allocate boot services memmap\n");
> >                 return;
> > @@ -288,7 +288,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> >         efi_memmap_insert(&efi.memmap, new, &mr);
> >         early_memunmap(new, new_size);
> >
> > -       efi_memmap_install(new_phys, num_entries);
> > +       efi_memmap_install(new_phys, num_entries, flags);
> >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >         e820__update_table(e820_table);
> >  }
> > @@ -408,6 +408,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
> >  void __init efi_free_boot_services(void)
> >  {
> >         phys_addr_t new_phys, new_size;
> > +       unsigned long flags = 0;
> >         efi_memory_desc_t *md;
> >         int num_entries = 0;
> >         void *new, *new_md;
> > @@ -463,7 +464,7 @@ void __init efi_free_boot_services(void)
> >                 return;
> >
> >         new_size = efi.memmap.desc_size * num_entries;
> > -       new_phys = efi_memmap_alloc(num_entries);
> > +       new_phys = efi_memmap_alloc(num_entries, &flags);
> >         if (!new_phys) {
> >                 pr_err("Failed to allocate new EFI memmap\n");
> >                 return;
> > @@ -493,7 +494,7 @@ void __init efi_free_boot_services(void)
> >
> >         memunmap(new);
> >
> > -       if (efi_memmap_install(new_phys, num_entries)) {
> > +       if (efi_memmap_install(new_phys, num_entries, flags)) {
> >                 pr_err("Could not install new EFI memmap\n");
> >                 return;
> >         }
> > diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> > index bb9fc70d0cfa..7e53e5520548 100644
> > --- a/drivers/firmware/efi/fake_mem.c
> > +++ b/drivers/firmware/efi/fake_mem.c
> > @@ -39,6 +39,7 @@ void __init efi_fake_memmap(void)
> >         int new_nr_map = efi.memmap.nr_map;
> >         efi_memory_desc_t *md;
> >         phys_addr_t new_memmap_phy;
> > +       unsigned long flags = 0;
> >         void *new_memmap;
> >         int i;
> >
> > @@ -55,7 +56,7 @@ void __init efi_fake_memmap(void)
> >         }
> >
> >         /* allocate memory for new EFI memmap */
> > -       new_memmap_phy = efi_memmap_alloc(new_nr_map);
> > +       new_memmap_phy = efi_memmap_alloc(new_nr_map, &flags);
> >         if (!new_memmap_phy)
> >                 return;
> >
> > @@ -73,7 +74,7 @@ void __init efi_fake_memmap(void)
> >         /* swap into new EFI memmap */
> >         early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
> >
> > -       efi_memmap_install(new_memmap_phy, new_nr_map);
> > +       efi_memmap_install(new_memmap_phy, new_nr_map, flags);
> >
>
> So it is the caller's responsibility to record the flags returned by
> efi_memmap_alloc() and pass them into efi_memmap_install(), right?
> Given that we are now passing three pieces of info that need to be in
> sync between the two, could we use a dedicated data structure instead,
> a reference to which is taken by both?

Sounds good, looks like I can mostly reuse 'struct
efi_memory_map_data' for this purpose.

>
>
> >         /* print new EFI memmap */
> >         efi_print_memmap();
> > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> > index 813674ef9000..2b81ee6858a9 100644
> > --- a/drivers/firmware/efi/memmap.c
> > +++ b/drivers/firmware/efi/memmap.c
> > @@ -32,6 +32,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> >  /**
> >   * efi_memmap_alloc - Allocate memory for the EFI memory map
> >   * @num_entries: Number of entries in the allocated map.
> > + * @flags: Late map, memblock alloc, slab alloc flags
> >   *
> >   * Depending on whether mm_init() has already been invoked or not,
> >   * either memblock or "normal" page allocation is used.
> > @@ -39,20 +40,23 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> >   * Returns the physical address of the allocated memory map on
> >   * success, zero on failure.
> >   */
> > -phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
> > +phys_addr_t __init efi_memmap_alloc(unsigned int num_entries, unsigned long *flags)
> >  {
> >         unsigned long size = num_entries * efi.memmap.desc_size;
> >
> > -       if (slab_is_available())
> > +       if (slab_is_available()) {
> > +               *flags |= EFI_MEMMAP_SLAB;
> >                 return __efi_memmap_alloc_late(size);
> > +       }
> >
> > +       *flags |= EFI_MEMMAP_MEMBLOCK;
>
> This assumes flags has neither bit set, but perhaps we should at least
> clear the memblock one if we set the slab one?

Ok.
