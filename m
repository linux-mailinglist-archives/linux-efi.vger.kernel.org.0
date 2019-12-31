Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602BE12DBEE
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLaVLj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 16:11:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43153 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfLaVLj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 16:11:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so15161992oth.10
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DULmnZUv/wwq/JWTQ2cMiTK1ZQVc05pKFRewQMycx+E=;
        b=OG/CBXUqMiCu0gjjf16lUHv1JUbH7PqMt+VGFOehA1m2rEWnPsu+kHaE9mrwWefMLE
         dKyZ5ml+SuxXZgwqHEo9/2kU1zXkMf14UIZDKe1ZThqn0wxZpIqfP3pS3k+qbSaqsSBJ
         valN/SisyXFXwZYND9W7duC2Ke0WyUvIWJmPUbl6IcoaUo0INmb3iCcKEHZavynVGGN+
         ZQfW6tD6sWK77yEBTANnD6YzweT/GHdw+u06x63tuogQQuUE5a1o2zZJn+E3fZeteS6v
         K8NqDNdZCjrIxzaUoMq9O2+jsz6QX1lg/wg36Ty9MG3kaD5+FobIUn0H4ufztsBejYBr
         Y0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DULmnZUv/wwq/JWTQ2cMiTK1ZQVc05pKFRewQMycx+E=;
        b=ea8aT6nWd6LUeq/YyKRrd52y4mHVmZ2UqBYqdA4GOIUB4ir4LcawWTLghQXcbbhNe3
         s86aamC4wplhUx776vww+v/361ISqokcZ13OJs2SP5r9DrPNWUvMDh3ReCYFMf9V0PO7
         Yfo6+EH/J/9y/Xqrg4IdsYcPIBa6Xs8E4H7Cd4ZEiJOwnKcJh6wlE2TbxKB+sSVIOpJD
         JAMU9dhgNkiM0+NWT1zQAKHfAofvvHobxDsefU9SEwTW09JcibSxBGfEMjSHGrfyo8pS
         K7Qu+KxH/Pzec31aZuv8bz7GLxfY0NXwLGeItlPaE0T5J6HMhcHCZxQAW+cCvldY4pcy
         iScw==
X-Gm-Message-State: APjAAAVry2HWsi00R4QWnfE/ZZiOlUNvazht/dqZ6z4EL2oA9ypAUwyz
        w083tc8so0310P+lNovJ4q/4FqlcSN+0RleifEt9aQ==
X-Google-Smtp-Source: APXvYqypFj1zF1kbnx/R5KfJArwLqUoFJSTxPfD+vcOvnU0v+aVIQWU2emX3uDqZOmc8+3nGXJFKRcjMBIYIHSQA7Zw=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr45346891oto.207.1577826697852;
 Tue, 31 Dec 2019 13:11:37 -0800 (PST)
MIME-Version: 1.0
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191231014630.GA24942@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20191231014630.GA24942@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Dec 2019 13:11:27 -0800
Message-ID: <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 30, 2019 at 5:46 PM Dave Young <dyoung@redhat.com> wrote:
>
> Hi Dan,
> On 12/30/19 at 11:58am, Dan Williams wrote:
> > A recent test of efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000 crashed with
> > a signature of:
> >
> >     BUG: unable to handle page fault for address: ffffffffff281000
> >     [..]
> >     RIP: 0010:efi_memmap_insert+0x11d/0x191
> >     [..]
> >     Call Trace:
> >      ? bgrt_init+0xbe/0xbe
> >      ? efi_arch_mem_reserve+0x1cb/0x228
> >      ? acpi_parse_bgrt+0xa/0xd
> >      ? acpi_table_parse+0x86/0xb8
> >      ? acpi_boot_init+0x494/0x4e3
> >      ? acpi_parse_x2apic+0x87/0x87
> >      ? setup_acpi_sci+0xa2/0xa2
> >      ? setup_arch+0x8db/0x9e1
> >      ? start_kernel+0x6a/0x547
> >      ? secondary_startup_64+0xb6/0xc0
> >
> > efi_memmap_insert() is attempting to insert entries past the end of the
> > new map. This condition is setup by efi_fake_mem() leaking empty entries
> > to the end of memory map, and then efi_arch_mem_reserve() trips over the
> > bad entry when attempting an additional efi_memmap_insert(). The empty
> > entry causes efi_memmap_insert() to attempt more memmap splits / copies
> > than efi_memmap_split_count() accounted for when sizing the new map.
> >
> > Update efi_fake_memmap() to cleanup lagging empty entries.
> >
> > This change is related to commit af1648984828 "x86/efi: Update e820 with
> > reserved EFI boot services data to fix kexec breakage" since that
> > introduces more occurrences where efi_memmap_insert() is invoked after
> > an efi_fake_mem= configuration has been parsed. Previously the side
> > effects of vestigial empty entries were benign, but with commit
> > af1648984828 that follow-on efi_memmap_insert() invocation triggers the
> > above crash signature.
> >
> > Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> > Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Michael Weiser <michael@weiser.dinsnail.net>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/firmware/efi/fake_mem.c |   22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> > index bb9fc70d0cfa..6df51ba93ae8 100644
> > --- a/drivers/firmware/efi/fake_mem.c
> > +++ b/drivers/firmware/efi/fake_mem.c
> > @@ -67,13 +67,33 @@ void __init efi_fake_memmap(void)
> >               return;
> >       }
> >
> > +     memset(new_memmap, 0, efi.memmap.desc_size * new_nr_map);
> >       for (i = 0; i < nr_fake_mem; i++)
> >               efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
> >
> > +     /*
> > +      * efi_memmap_split_count() may over count the number of
> > +      * required splits in the case when contiguous fake entries are
> > +      * specified. Check that all new_nr_map entries were consumed.
> > +      */
> > +     for (i = new_nr_map; i > 0; i--) {
> > +             efi_memory_desc_t *md;
> > +             u64 start, end;
> > +
> > +             md = new_memmap + efi.memmap.desc_size * (new_nr_map - i - 1);
> > +             end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
> > +             start = md->phys_addr;
> > +
> > +             if (start == 0 && end + 1 == 0)
> > +                     continue;
> > +             break;
> > +     }
> > +
> >       /* swap into new EFI memmap */
> >       early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
> >
> > -     efi_memmap_install(new_memmap_phy, new_nr_map);
> > +     /* install only the valid entries */
> > +     efi_memmap_install(new_memmap_phy, i);
> >
> >       /* print new EFI memmap */
> >       efi_print_memmap();
> >
>
> Although kernel bootup works with this patch, it still does not fix the
> issue I noticed, you can see:
> [root@localhost ~]# cat /proc/cmdline
> BOOT_IMAGE=/bzImage root=/dev/vda3 ro audit=0 selinux=0 crashkernel=160M efi=debug console=ttyS0 console=tty0 3 efi_fake_mem=200M@5G:0x40000,300M@5600M:0x40000 earlyprintk=serial
> [root@localhost ~]# dmesg|grep fake_mem
> [    0.000000] Command line: BOOT_IMAGE=/bzImage root=/dev/vda3 ro audit=0 selinux=0 crashkernel=160M efi=debug console=ttyS0 console=tty0 3 efi_fake_mem=200M@5G:0x40000,300M@5600M:0x40000 earlyprintk=serial
> [    0.000000] efi_fake_mem: add attr=0x0000000000040000 to [mem 0x0000000140000000-0x000000014c7fffff]
> [    0.000000] efi_fake_mem: add attr=0x0000000000040000 to [mem 0x000000015e000000-0x0000000170bfffff]
> [root@localhost ~]# dmesg|grep SP
> [    0.085762] efi: mem48: [Conventional Memory|   |  |SP|  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000015e000000-0x0000000170bfffff] (300MB)
>
>
> With this patch applied, there is still only one md set "SP" attr.  That
> means only the last insert worked.
>
> void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                               struct efi_mem_range *mem)
>
> The above function will use the old_memmap as the base for each
> inserting.  the old_memmap == &efi.memmap, so when you do below:
>         for (i = 0; i < nr_fake_mem; i++)
>                 efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
>
> Only the last inserting will take effect.  Below debug patch worked for
> me, but I thought you have found same bug so I did not add it in the
> reply, here it is, only for debugging purpose, not graceful:

Good find! I missed this because my test case was checking /proc/iomem
after booting and efi_fake_memmap_early() updates the e820 table.

>
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index bb9fc70d0cfa..097eaf7deb6a 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -36,44 +36,48 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
>
>  void __init efi_fake_memmap(void)
>  {
> -       int new_nr_map = efi.memmap.nr_map;
> -       efi_memory_desc_t *md;
> -       phys_addr_t new_memmap_phy;
> -       void *new_memmap;
>         int i;
>
> +       pr_info("nr fake mem %d\n", nr_fake_mem);
>         if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
>                 return;
>
>         /* count up the number of EFI memory descriptor */
>         for (i = 0; i < nr_fake_mem; i++) {
> -               for_each_efi_memory_desc(md) {
> -                       struct range *r = &efi_fake_mems[i].range;
> -
> -                       new_nr_map += efi_memmap_split_count(md, r);
> +               int new_nr_map = efi.memmap.nr_map;
> +               efi_memory_desc_t md0;
> +               efi_memory_desc_t *md = &md0;
> +               phys_addr_t new_memmap_phy;
> +               void *new_memmap;
> +
> +               if (efi_mem_desc_lookup(efi_fake_mems[i].range.start, md)) {
> +                       pr_err("Failed to lookup EFI memory descriptor for %pa\n", &efi_fake_mems[i].range.start);
> +                       return;
> +               }
> +
> +               new_nr_map += efi_memmap_split_count(md, &efi_fake_mems[i].range);
> +
> +               pr_info("new nr %d\n", new_nr_map);
> +               /* allocate memory for new EFI memmap */
> +               new_memmap_phy = efi_memmap_alloc(new_nr_map);
> +               if (!new_memmap_phy){
> +                       pr_info("alloc new map failed\n");
> +                       return;}
> +
> +               /* create new EFI memmap */
> +               new_memmap = early_memremap(new_memmap_phy,
> +                                   efi.memmap.desc_size * new_nr_map);
> +               if (!new_memmap) {
> +                       pr_info("map new map failed\n");
> +                       memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
> +                       return;
>                 }
> -       }
> -
> -       /* allocate memory for new EFI memmap */
> -       new_memmap_phy = efi_memmap_alloc(new_nr_map);
> -       if (!new_memmap_phy)
> -               return;
> -
> -       /* create new EFI memmap */
> -       new_memmap = early_memremap(new_memmap_phy,
> -                                   efi.memmap.desc_size * new_nr_map);
> -       if (!new_memmap) {
> -               memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
> -               return;
> -       }
> -
> -       for (i = 0; i < nr_fake_mem; i++)
>                 efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
> -
> -       /* swap into new EFI memmap */
> -       early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
> -
> -       efi_memmap_install(new_memmap_phy, new_nr_map);
> +               /* swap into new EFI memmap */
> +               early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
> +               efi_memmap_install(new_memmap_phy, new_nr_map);
> +               pr_info("inserted new map\n");
> +       }

Perhaps a prettier way to do this is to push the handling of each
efi_fake_mem entry into a subroutine. However, I notice when a memmap
allocated by efi_memmap_alloc() is replaced by another dynamically
allocated memmap the previous one isn't released. I have a series that
fixes that up as well.
