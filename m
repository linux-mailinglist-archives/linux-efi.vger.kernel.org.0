Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27552131E9A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 05:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgAGEQw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 23:16:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38683 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgAGEQu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 23:16:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id d7so70184227otf.5
        for <linux-efi@vger.kernel.org>; Mon, 06 Jan 2020 20:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JwBnNcErx/Tqbos3sgmzuiRKwnTayVGEEUrwwVO9+Q=;
        b=kTfmCJhh1mbBCxqWkk2jJzl/J1kOXKq7lFQJCLEwwH1rEYWJoqgEISnsXnof7DsGKp
         r22nVFIxpGIaZUR7b8mcJMJxVKZAx1EOQZ8kr7V+DqBj11Lsa7c2bT5Bl5wLx++3CO8M
         PLsS96c92EcNKS1U47BedxbdFQo3DiJyad6/jcZXUufOff+1OCkXWUnQIlqc0iSB6pIO
         pliKONMzLNlNdrsXD/hyqtbTjE3AGJxs6w8V1q5W50mTzVUyOGGtrX1j5Yul63jwsK+x
         1EANxaD3gSNMM00ePgz+477b4uJ8VGdtRBPKtnNPQAQgCZS4s7GocmWFW6evH+CIEOvR
         qDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JwBnNcErx/Tqbos3sgmzuiRKwnTayVGEEUrwwVO9+Q=;
        b=HrFOvxQvBH3dazxaaUbzjDcd1hstBlCCivDhcr4b1IBQTVhelE9y3YzlstE92kGzYW
         KARw0kafgfRbXccIUxBpn61tEvdJZ1HJs4CZurIa4V4Rf3GV+IC5bOUW3R95GNVKC7u5
         xr73Xl3zZVSliQfm83fmc9ROqYh3SAQslhxNp2zmN3QbAYv4Uxez6ahwrQkdjyovUPtu
         qWzrV69p0g0mzTgq2V5KNCeIBeEwUlpDVvt//2V9F+fwdLm7PtCvTKK+QHImxezAejvw
         nVnZXheyccPvKqQHYPRBQSa+4Df38GMcdSIuwHkcwxPviKqyW1HjD434/War2ijSSTuW
         surA==
X-Gm-Message-State: APjAAAVLT9xkx40vRDKUV3rghRrhX4c9ZG65F+3lKYMv2Fgr3AYcHUsp
        Wkmq7AdZOvQj6rGOmpMzRqFDa3vHrw4wGrvKEvthYg==
X-Google-Smtp-Source: APXvYqwO1M8i45m+WC0eLF0xEzFwSmcFi2OVQfpuah9yioKi3aW2qWHzUJL5QsZGJUUrM6dz9UNyEWn7Zsge6Qw+T84=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr61571357oto.71.1578370608986;
 Mon, 06 Jan 2020 20:16:48 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200107040415.GA19309@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jan 2020 20:16:37 -0800
Message-ID: <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 6, 2020 at 8:04 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/06/20 at 04:40pm, Dan Williams wrote:
> > Dave noticed that when specifying multiple efi_fake_mem= entries only
> > the last entry was successfully being reflected in the efi memory map.
> > This is due to the fact that the efi_memmap_insert() is being called
> > multiple times, but on successive invocations the insertion should be
> > applied to the last new memmap rather than the original map at
> > efi_fake_memmap() entry.
> >
> > Rework efi_fake_memmap() to install the new memory map after each
> > efi_fake_mem= entry is parsed.
> >
> > This also fixes an issue in efi_fake_memmap() that caused it to litter
> > emtpy entries into the end of the efi memory map. An empty entry causes
> > efi_memmap_insert() to attempt more memmap splits / copies than
> > efi_memmap_split_count() accounted for when sizing the new map. When
> > that happens efi_memmap_insert() may overrun its allocation, and if you
> > are lucky will spill over to an unmapped page leading to crash
> > signature like the following rather than silent corruption:
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
> > Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
> > services data to fix kexec breakage" is listed in Fixes: since it
> > introduces more occurrences where efi_memmap_insert() is invoked after
> > an efi_fake_mem= configuration has been parsed. Previously the side
> > effects of vestigial empty entries were benign, but with commit
> > af1648984828 that follow-on efi_memmap_insert() invocation triggers
> > efi_memmap_insert() overruns.
> >
> > Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> > Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
>
> A nitpick for the Fixes flags, as I replied in the thread below:
> https://lore.kernel.org/linux-efi/CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com/T/#m2bb2dd00f7715c9c19ccc48efef0fcd5fdb626e7
>
> I reproduced two other panics without the patches applied, so this issue
> is not caused by either of the commits, maybe just drop the Fixes.

Just the "Fixes: af1648984828", right? No objection from me. I'll let
Ingo say if he needs a resend for that.

The "Fixes: 0f96a99dab36" is valid because the original implementation
failed to handle the multiple argument case from the beginning.

>
> > Link: https://lore.kernel.org/r/20191231014630.GA24942@dhcp-128-65.nay.redhat.com
> > Reported-by: Dave Young <dyoung@redhat.com>
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Michael Weiser <michael@weiser.dinsnail.net>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/firmware/efi/fake_mem.c |   31 ++++++++++++++++---------------
> >  drivers/firmware/efi/memmap.c   |    2 +-
> >  include/linux/efi.h             |    2 ++
> >  3 files changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> > index a8d20568d532..6e0f34a38171 100644
> > --- a/drivers/firmware/efi/fake_mem.c
> > +++ b/drivers/firmware/efi/fake_mem.c
> > @@ -34,25 +34,16 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
> >       return 0;
> >  }
> >
> > -void __init efi_fake_memmap(void)
> > +static void __init efi_fake_range(struct efi_mem_range *efi_range)
> >  {
> >       struct efi_memory_map_data data = { 0 };
> >       int new_nr_map = efi.memmap.nr_map;
> >       efi_memory_desc_t *md;
> >       void *new_memmap;
> > -     int i;
> > -
> > -     if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
> > -             return;
> >
> >       /* count up the number of EFI memory descriptor */
> > -     for (i = 0; i < nr_fake_mem; i++) {
> > -             for_each_efi_memory_desc(md) {
> > -                     struct range *r = &efi_fake_mems[i].range;
> > -
> > -                     new_nr_map += efi_memmap_split_count(md, r);
> > -             }
> > -     }
> > +     for_each_efi_memory_desc(md)
> > +             new_nr_map += efi_memmap_split_count(md, &efi_range->range);
>
> For this part, although I still have some concerns, but since I'm not
> 100% clear about it, maybe just leave it as you do, and see if it is
> good to Ard.

Absent a specific failure case I didn't see anything to change here.
