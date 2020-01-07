Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DD132D91
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGRv6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 12:51:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46847 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgAGRv6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 12:51:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so342365wrl.13
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbVULJcO0KoQ8UyAq3sKxvpp33IhKJl+pej7FZpNELY=;
        b=rYlDokC29xG14NYShebx3kVbcGhDwOlg8dhocTJWxexmpjVOsu48vUbua8LU//f6bV
         QXKcYKVtch0w36pWBBi5KBYZZhJqSBzBUnX6BZ50N/lqAxIW+rJClvHC/g0EszY77baN
         9vyhAz9tU3V6EUBabm8d72cCJQh0LTFFUR5ipoacezcauI0W0hYKreE4PZR4Lvk4KtkC
         bWW1LeWwABAbufmTvqQrJUiLvwkAQZAzPx85cF5qbX5MJyi1xT63YBL5emVNEBHqPz1I
         TlzNY++WnMMyNtmQIdHUo6HG7wprzOx+xT2Yy3ZM7SY36t35VZJfHpofJfD9mGsoPmQG
         Qb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbVULJcO0KoQ8UyAq3sKxvpp33IhKJl+pej7FZpNELY=;
        b=OgxnXuELB0je1HNoR1012M+8mfbamVuvXmg5CcNj7HM+HixpLI0ndmWteouCcsbx2P
         iJ5o0orSxa14NdZ6R2qq2pokuA6+7n+PTxRuEmH1QYsQsykQ8/m+ZnmWV8tPRIkaE7vc
         RC6Xhx/tLkxhHYEpDKlkSlFvVzl942DQ9lA4Ak8kMX2cDzLnoJThHD1Yc14It9wbqNTj
         1qh3jQ27dL67vJJeo4DRwXZGccRSKyXB9vHyE23oqmSDt0YLQtjJ3uxOfgSmI6hJdOHy
         tzUkCl9zGiqyT3aX1Q0JrRSeV/FqtXMUA3ZbJxqi7AWdQXX5OB0LuANHssYV+ILXfFHO
         3J5Q==
X-Gm-Message-State: APjAAAWg2XUdA8A5NKSesm5nyxQS1sBZkfDxd9K0GA05lNmpe6ELV/kK
        uByTBxNIuZPu7cECK2yPPgl69c7N47gE7NU76HHX+A==
X-Google-Smtp-Source: APXvYqyinGaD1+tRHAZo3zO3lRNIj8tetBCntRk3w2SI4OyoJYlkbvt4iiW3d7o8AhLEu7VBnd+o+XPv153tzuASdWQ=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr276481wrs.200.1578419516354;
 Tue, 07 Jan 2020 09:51:56 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com> <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
 <20200107051919.GC19080@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200107051919.GC19080@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 18:51:45 +0100
Message-ID: <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
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

On Tue, 7 Jan 2020 at 06:19, Dave Young <dyoung@redhat.com> wrote:
>
> On 01/06/20 at 08:16pm, Dan Williams wrote:
> > On Mon, Jan 6, 2020 at 8:04 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 01/06/20 at 04:40pm, Dan Williams wrote:
> > > > Dave noticed that when specifying multiple efi_fake_mem= entries only
> > > > the last entry was successfully being reflected in the efi memory map.
> > > > This is due to the fact that the efi_memmap_insert() is being called
> > > > multiple times, but on successive invocations the insertion should be
> > > > applied to the last new memmap rather than the original map at
> > > > efi_fake_memmap() entry.
> > > >
> > > > Rework efi_fake_memmap() to install the new memory map after each
> > > > efi_fake_mem= entry is parsed.
> > > >
> > > > This also fixes an issue in efi_fake_memmap() that caused it to litter
> > > > emtpy entries into the end of the efi memory map. An empty entry causes
> > > > efi_memmap_insert() to attempt more memmap splits / copies than
> > > > efi_memmap_split_count() accounted for when sizing the new map. When
> > > > that happens efi_memmap_insert() may overrun its allocation, and if you
> > > > are lucky will spill over to an unmapped page leading to crash
> > > > signature like the following rather than silent corruption:
> > > >
> > > >     BUG: unable to handle page fault for address: ffffffffff281000
> > > >     [..]
> > > >     RIP: 0010:efi_memmap_insert+0x11d/0x191
> > > >     [..]
> > > >     Call Trace:
> > > >      ? bgrt_init+0xbe/0xbe
> > > >      ? efi_arch_mem_reserve+0x1cb/0x228
> > > >      ? acpi_parse_bgrt+0xa/0xd
> > > >      ? acpi_table_parse+0x86/0xb8
> > > >      ? acpi_boot_init+0x494/0x4e3
> > > >      ? acpi_parse_x2apic+0x87/0x87
> > > >      ? setup_acpi_sci+0xa2/0xa2
> > > >      ? setup_arch+0x8db/0x9e1
> > > >      ? start_kernel+0x6a/0x547
> > > >      ? secondary_startup_64+0xb6/0xc0
> > > >
> > > > Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
> > > > services data to fix kexec breakage" is listed in Fixes: since it
> > > > introduces more occurrences where efi_memmap_insert() is invoked after
> > > > an efi_fake_mem= configuration has been parsed. Previously the side
> > > > effects of vestigial empty entries were benign, but with commit
> > > > af1648984828 that follow-on efi_memmap_insert() invocation triggers
> > > > efi_memmap_insert() overruns.
> > > >
> > > > Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> > > > Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> > >
> > > A nitpick for the Fixes flags, as I replied in the thread below:
> > > https://lore.kernel.org/linux-efi/CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com/T/#m2bb2dd00f7715c9c19ccc48efef0fcd5fdb626e7
> > >
> > > I reproduced two other panics without the patches applied, so this issue
> > > is not caused by either of the commits, maybe just drop the Fixes.
> >
> > Just the "Fixes: af1648984828", right? No objection from me. I'll let
> > Ingo say if he needs a resend for that.
> >
> > The "Fixes: 0f96a99dab36" is valid because the original implementation
> > failed to handle the multiple argument case from the beginning.
>
> Agreed, thanks!
>

I'll queue this but without the fixes tags. The -stable maintainers
are far too trigger happy IMHO, and this really needs careful review
before being backported. efi_fake_mem is a debug feature anyway, so I
don't see an urgent need to get this fixed retroactively in older
kernels.
