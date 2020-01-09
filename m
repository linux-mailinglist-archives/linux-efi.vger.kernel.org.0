Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D2E1355E1
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2020 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgAIJgG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jan 2020 04:36:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgAIJgG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jan 2020 04:36:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so6628806wru.3
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIc6Iu6FY3kQRSrHRSdV1kpKIbP+jBfUPikfJIi636g=;
        b=GSTyUgzlPbACkH+mluJA7fEz/H2vqhWQOda9lk2E6T6LqFWlNiqdJHilTmH0IiOzT8
         VOrbwmlUPY1ZUNoaqfxjtoHV5sAeY4bmZU6fqYRoo4/VRPA7xJTRhYltzYYHCIYyE9j/
         JzQ/8hnHIWlyr7ApQ1mEVijYpa0nY76wkm3B0dfPtJAELcNkqVAQI2bMPu9wV5d6iKVA
         jZQdh5a4Wtm2YH1Eft1s3/uhDJVZBbjNQUlhxSP1KrSMS4JokKwJMMzNUV7W79FaKnjc
         kVftJ/dhYV8pwGX8SplEYRrxsB/CDfPKNIm/V/Z2zsKQw9mT+YgyEvzWXONmtwmf1nyJ
         negA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIc6Iu6FY3kQRSrHRSdV1kpKIbP+jBfUPikfJIi636g=;
        b=TU+BjJYbpRSTNemgLxkE/AgZtVnEcy5idNs/SWXlt+LY+eZQ0JT/MvEvz37AjfEgrs
         XmUw3y3JwB8iNBBvDwRlls/m1b/x8vYawYp+u3PDjSGSnUhmvbsxuOULbT25wkH2coJQ
         gQNSSLeSuV0st09fZ53lGGcI65+k++tu0T7splzA6LERcOHgSP/LXG0UZluIIvi4sDno
         +jVwYZOjKRIbVdrK97ua/C+SJzM/U/wGwzdSLhAvl9JuIj6Ua92z7anxJg/C9QrYwnWH
         oiHDQ3AqjYXUlKGIzG8qjq6rwthu+pjYSeCjaUHwx52D8Btzh2WbbMFQkTBD3+prZcW1
         EyOA==
X-Gm-Message-State: APjAAAW3Jvo2gy6KoyVl9nCJa/VdtEOAqFejLdd12Nf0pjXQZCvCMFzv
        LlJQjHLm2epkKZ+dbnjuUi+W4c6X2xKkQQqbpC20UA==
X-Google-Smtp-Source: APXvYqwzpmoVz3XcxijGfOaz1ACHmsnjXCEqLojhNnSJC/ywgDelLfgn8bjgYuyLRffW+lo9jFhu41/Zy27UzteA8ZA=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr9631274wrs.200.1578562563449;
 Thu, 09 Jan 2020 01:36:03 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com> <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
 <20200107051919.GC19080@dhcp-128-65.nay.redhat.com> <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
 <CAPcyv4ixPchDOet=ztRQxLMgnJf9DauSFgBs3+TEoaua7R1s_Q@mail.gmail.com>
In-Reply-To: <CAPcyv4ixPchDOet=ztRQxLMgnJf9DauSFgBs3+TEoaua7R1s_Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 9 Jan 2020 10:35:52 +0100
Message-ID: <CAKv+Gu8W_EyMNAtDG6zK+dKRcaUEzeJ3fmPAiASdqatD3ewQJQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
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

On Wed, 8 Jan 2020 at 22:53, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jan 7, 2020 at 9:52 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 7 Jan 2020 at 06:19, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 01/06/20 at 08:16pm, Dan Williams wrote:
> > > > On Mon, Jan 6, 2020 at 8:04 PM Dave Young <dyoung@redhat.com> wrote:
> > > > >
> > > > > On 01/06/20 at 04:40pm, Dan Williams wrote:
> > > > > > Dave noticed that when specifying multiple efi_fake_mem= entries only
> > > > > > the last entry was successfully being reflected in the efi memory map.
> > > > > > This is due to the fact that the efi_memmap_insert() is being called
> > > > > > multiple times, but on successive invocations the insertion should be
> > > > > > applied to the last new memmap rather than the original map at
> > > > > > efi_fake_memmap() entry.
> > > > > >
> > > > > > Rework efi_fake_memmap() to install the new memory map after each
> > > > > > efi_fake_mem= entry is parsed.
> > > > > >
> > > > > > This also fixes an issue in efi_fake_memmap() that caused it to litter
> > > > > > emtpy entries into the end of the efi memory map. An empty entry causes
> > > > > > efi_memmap_insert() to attempt more memmap splits / copies than
> > > > > > efi_memmap_split_count() accounted for when sizing the new map. When
> > > > > > that happens efi_memmap_insert() may overrun its allocation, and if you
> > > > > > are lucky will spill over to an unmapped page leading to crash
> > > > > > signature like the following rather than silent corruption:
> > > > > >
> > > > > >     BUG: unable to handle page fault for address: ffffffffff281000
> > > > > >     [..]
> > > > > >     RIP: 0010:efi_memmap_insert+0x11d/0x191
> > > > > >     [..]
> > > > > >     Call Trace:
> > > > > >      ? bgrt_init+0xbe/0xbe
> > > > > >      ? efi_arch_mem_reserve+0x1cb/0x228
> > > > > >      ? acpi_parse_bgrt+0xa/0xd
> > > > > >      ? acpi_table_parse+0x86/0xb8
> > > > > >      ? acpi_boot_init+0x494/0x4e3
> > > > > >      ? acpi_parse_x2apic+0x87/0x87
> > > > > >      ? setup_acpi_sci+0xa2/0xa2
> > > > > >      ? setup_arch+0x8db/0x9e1
> > > > > >      ? start_kernel+0x6a/0x547
> > > > > >      ? secondary_startup_64+0xb6/0xc0
> > > > > >
> > > > > > Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
> > > > > > services data to fix kexec breakage" is listed in Fixes: since it
> > > > > > introduces more occurrences where efi_memmap_insert() is invoked after
> > > > > > an efi_fake_mem= configuration has been parsed. Previously the side
> > > > > > effects of vestigial empty entries were benign, but with commit
> > > > > > af1648984828 that follow-on efi_memmap_insert() invocation triggers
> > > > > > efi_memmap_insert() overruns.
> > > > > >
> > > > > > Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> > > > > > Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> > > > >
> > > > > A nitpick for the Fixes flags, as I replied in the thread below:
> > > > > https://lore.kernel.org/linux-efi/CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com/T/#m2bb2dd00f7715c9c19ccc48efef0fcd5fdb626e7
> > > > >
> > > > > I reproduced two other panics without the patches applied, so this issue
> > > > > is not caused by either of the commits, maybe just drop the Fixes.
> > > >
> > > > Just the "Fixes: af1648984828", right? No objection from me. I'll let
> > > > Ingo say if he needs a resend for that.
> > > >
> > > > The "Fixes: 0f96a99dab36" is valid because the original implementation
> > > > failed to handle the multiple argument case from the beginning.
> > >
> > > Agreed, thanks!
> > >
> >
> > I'll queue this but without the fixes tags. The -stable maintainers
> > are far too trigger happy IMHO, and this really needs careful review
> > before being backported. efi_fake_mem is a debug feature anyway, so I
> > don't see an urgent need to get this fixed retroactively in older
> > kernels.
>
> I'm fine to drop the fixes tags.
>
> However, I do want to point out my driving motive for digging in on
> efi_fake_mem=nn@ss:0x40000, is that it is a better interface for
> diverting memory ranges to device-dax than the current standard bearer
> memmap=nn!ss. The main benefit is that the kernel only considers the
> attribute when it is applied to EFI_CONVENTIONAL_MEMORY. This fixes a
> long standing unsolvable issue of people picking busted memmap=nn!ss
> settings that clobber platform memory ranges, or vector off into
> nothing.
>
> So yes, efi_fake_mem is a debug feature, but if the popularity of
> memmap=nn!ss is any clue I expect efi_fake_mem=nn@ss:0x40000 will be a
> useful tool going forward for late enabling, or repairing platform
> "soft reservation" declarations.
>

OK, good to know.

> I'll respin the series with those tags dropped and add the comment you
> recommended about the cases when efi_memmap_free() is expected to be a
> nop. Holler if there's anything else, but that's all I had on my list
> to fix up.

If it's just for the comment, I can just slap that on, as I already
queued the patches with the fixes tags dropped. Or respin, whichever
you prefer (efi/next branch is not stable anyway)
