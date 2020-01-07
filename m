Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BEB132D87
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgAGRth (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 12:49:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41874 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRth (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 12:49:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so378383wrw.8
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyvuS2G9MB9Tvq9pni2gKNsuJduIchYAcY94iemGDHk=;
        b=C3P65o55D+SQxxN6mGKZo2HFJ4tjidCXpgNJDyVr+teyCUgHLA/oplEcHIvlFBb7Se
         GJYJOEPFDLCZpCThR12FScKuecIuQ5bHwfgVDwdIZsF2pB/TLPpqFCH3gm1hJ+Dt3u4Z
         rNOH1aRZvB+2wrLM/4TuQzAS8xfGkkRDqWOQ305+FYFU8ckBrQt5jRV8s+var7Bh6e+n
         0LCwOZYmzj7QNEJw7wyGJSeyXrz7sh0qABAGVmyFDUjkuPkJOocS78vu+NVHD32dRRbO
         kiVYDdRYm68fFOAehcFimn9Ia23jgmYcV51F7qCCdVuW99cjr3OQd0hEyc5WdRpmw1/r
         /L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyvuS2G9MB9Tvq9pni2gKNsuJduIchYAcY94iemGDHk=;
        b=pUwJOio047uPavhbIOT/ymieAYGUlbCrWuFL1Esdt7P2uNO1Bf3wo5jHGUN4iqQXwd
         c7yV2dCeSQpH0QOay2ATktWb6lGQSg9jd6GoDhXdqVWx34vfnwvDI+h/OAPcdQ/1M4Jp
         ZsqjCSNhl6r8U+ud26hcujW5uQgtp+MzH03i2UR7Zx7//46kt3pI3+/DxmkZdPn58F05
         er74xTwoqBSRhaebz7WFITvghZQNNv9BYnR+hzOkD0Qaj1oj8KWJsWRH4MFcyhf3GsCy
         Mk8AeyS0xqpigy30fG6PJ50tQallPgnv80uWOhA+xm14wYroOPbo6od4r5P5rv4tWd1X
         XhGA==
X-Gm-Message-State: APjAAAVMRB14fX71dq3yyeyNIHrD/Rby2NpIyLbL3E2v9Knn5Wu1BXkR
        jvFI0qTBqrnlDrEIePgRxPtDiasyLq0OJ8xQPrzGGFOyLGg=
X-Google-Smtp-Source: APXvYqzEg4Y9DhPujMpKhGLLLqlbDKR8EPZU2K7/XBHana0VXM+EZ4387AqIUMuB3nsMMom8jmSfjK00QqU5fLyPh4w=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr275382wrw.246.1578419375184;
 Tue, 07 Jan 2020 09:49:35 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835763783.1456824.4013634516855823659.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107035824.GA19080@dhcp-128-65.nay.redhat.com> <CAPcyv4jbf2WR2ZU55564fORxKLf8tGH1XbYBpRfTvPouGWk2mg@mail.gmail.com>
 <20200107051822.GB19080@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200107051822.GB19080@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 18:49:24 +0100
Message-ID: <CAKv+Gu8hO5mTbFaqwh9OZOEm9r_e1_ob-pfq4yhH4wJG7yV8MQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] efi: Fix efi_memmap_alloc() leaks
To:     Dave Young <dyoung@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 06:18, Dave Young <dyoung@redhat.com> wrote:
>
> On 01/06/20 at 08:24pm, Dan Williams wrote:
> > On Mon, Jan 6, 2020 at 7:58 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 01/06/20 at 04:40pm, Dan Williams wrote:
> > > > With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> > > > updated and replaced multiple times. When that happens a previous
> > > > dynamically allocated efi memory map can be garbage collected. Use the
> > > > new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> > > > allocated memory map is being replaced.
> > > >
> > > > Debug statements in efi_memmap_free() reveal:
> > > >
> > > >  efi: __efi_memmap_free:37: phys: 0x23ffdd580 size: 2688 flags: 0x2
> > > >  efi: __efi_memmap_free:37: phys: 0x9db00 size: 2640 flags: 0x2
> > > >  efi: __efi_memmap_free:37: phys: 0x9e580 size: 2640 flags: 0x2
> > > >
> > > > ...a savings of 7968 bytes on a qemu boot with 2 entries specified to
> > > > efi_fake_mem=.
> > > >
> > > > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> > > > index 04dfa56b994b..bffa320d2f9a 100644
> > > > --- a/drivers/firmware/efi/memmap.c
> > > > +++ b/drivers/firmware/efi/memmap.c
> > > > @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> > > >       return PFN_PHYS(page_to_pfn(p));
> > > >  }
> > > >
> > > > +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > > > +{
> > > > +     if (flags & EFI_MEMMAP_MEMBLOCK) {
> > > > +             if (slab_is_available())
> > > > +                     memblock_free_late(phys, size);
> > > > +             else
> > > > +                     memblock_free(phys, size);
> > > > +     } else if (flags & EFI_MEMMAP_SLAB) {
> > > > +             struct page *p = pfn_to_page(PHYS_PFN(phys));
> > > > +             unsigned int order = get_order(size);
> > > > +
> > > > +             free_pages((unsigned long) page_address(p), order);
> > > > +     }
> > > > +}
> > > > +
> > > > +static void __init efi_memmap_free(void)
> > > > +{
> > > > +     __efi_memmap_free(efi.memmap.phys_map,
> > > > +                     efi.memmap.desc_size * efi.memmap.nr_map,
> > > > +                     efi.memmap.flags);
> > > > +}
> > > > +
> > > >  /**
> > > >   * efi_memmap_alloc - Allocate memory for the EFI memory map
> > > >   * @num_entries: Number of entries in the allocated map.
> > > > @@ -100,6 +122,8 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
> > > >               return -ENOMEM;
> > > >       }
> > > >
> > > > +     efi_memmap_free();
> > > > +
> > >
> > > This seems still not safe,  see below function:
> > > arch/x86/platform/efi/efi.c:
> > > static void __init efi_clean_memmap(void)
> > > It use same memmap for both old and new, and filter out those invalid
> > > ranges in place, if the memory is freed then ..
> >
> > In the efi_clean_memmap() case flags are 0, so efi_memmap_free() is a nop.
> >
> > Would you feel better with an explicit?
> >
> > WARN_ON(efi.memmap.phys_map == data->phys_map && (data->flags &
> > (EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK))
> >
> > ...not sure it's worth it.
>
> Ah, yes, sorry I did not see the flags, although it is not very obvious.
> Maybe add some code comment for efi_mem_alloc and efi_mem_init.
>
> Let's defer the suggestion to Ard.
>

A one line comment to remind our future selves of this discussion
would probably be helpful, but beyond that, I don't think we need to
do much here.
