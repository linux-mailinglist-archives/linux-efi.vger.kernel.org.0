Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B8131E9F
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 05:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgAGEYo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 23:24:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33415 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgAGEYo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 23:24:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so52852858otp.0
        for <linux-efi@vger.kernel.org>; Mon, 06 Jan 2020 20:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpRVgkQrP+H8glvNMQeoSS2IHkaJmEZmOMYgHcv4/Sk=;
        b=hMwCZTFotL92VhgJnQOx+5zKXeoHFoSDwxyQeDkGA7LL1xJ/5I1qifpHD05tGEJ/k1
         D81lbVKvMM5wqPFXLh61rQyjbKeBSH5Fvnn0a/5n9Yj/TpAk3Pj0GP1I+sfNM0VmwXVH
         T9SVgNr3TPjwmBBxcbMTev/tuMSNk+LWI0YsAS4v1EPSUGxuxQo/3h+UYuZlAUBRmir+
         cilRI/wWpV+b0C/e78M1pw8nlm8AZ/iKLvy3lHo3u1ZPcZLcPhj36PonE0fXHE5FebIw
         1H04+KlDDlAkwaMukRX/ufRxoF1bmBJoRoWyjdZAxuB28KEJGfld5brUc0sgJ20yz7fV
         NLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpRVgkQrP+H8glvNMQeoSS2IHkaJmEZmOMYgHcv4/Sk=;
        b=iMgDna71500W3vrkES/Bk8XSPzoExmY+GHxbqsCeo8Kg1LHilnwKQzQCTV3e8Q0yDM
         IIRu8vQDSpYUoSQtpB8AzkStNZX2camBIKI0SQwE4m15eZPgpiwv6HY+EhcoNYmdEcFL
         m0TKupiCIwE8wXSfMDgBemabye16vPvYRkNA5AoJBUoGML8NyiMDZjZP4rZhEWm9C836
         pZVJvJ01R1lTxocmQFBmwVcEyInxVi4vHB2LPchix//1xj3piTgwEJIx7Rpz6SQFq4s9
         MKIk/BtQjxl9+p/37qOhj4UBwqidL3ZG1iyfupiAorwdWkgWqrY8dhxsu0wrVl3/Jm1Y
         ojQw==
X-Gm-Message-State: APjAAAXz1KkfEaFNNAUG+mC7AVxleXItFVLdRns0uSrYhM5iLF9G3mxS
        BFd7cDLApeohE8DG/HjuvcYlaDd77gjiNpARwxGNTg==
X-Google-Smtp-Source: APXvYqzf1d2T/uMauIo2ZeG7AJCoT0+lduA5vctbRQQqcUAxoautUmiDkuGdp3E5eiwrTJn7bTCIku50x+CJ+lwCShE=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr123180121otk.363.1578371083582;
 Mon, 06 Jan 2020 20:24:43 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835763783.1456824.4013634516855823659.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107035824.GA19080@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200107035824.GA19080@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jan 2020 20:24:32 -0800
Message-ID: <CAPcyv4jbf2WR2ZU55564fORxKLf8tGH1XbYBpRfTvPouGWk2mg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] efi: Fix efi_memmap_alloc() leaks
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 6, 2020 at 7:58 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/06/20 at 04:40pm, Dan Williams wrote:
> > With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> > updated and replaced multiple times. When that happens a previous
> > dynamically allocated efi memory map can be garbage collected. Use the
> > new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> > allocated memory map is being replaced.
> >
> > Debug statements in efi_memmap_free() reveal:
> >
> >  efi: __efi_memmap_free:37: phys: 0x23ffdd580 size: 2688 flags: 0x2
> >  efi: __efi_memmap_free:37: phys: 0x9db00 size: 2640 flags: 0x2
> >  efi: __efi_memmap_free:37: phys: 0x9e580 size: 2640 flags: 0x2
> >
> > ...a savings of 7968 bytes on a qemu boot with 2 entries specified to
> > efi_fake_mem=.
> >
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> > index 04dfa56b994b..bffa320d2f9a 100644
> > --- a/drivers/firmware/efi/memmap.c
> > +++ b/drivers/firmware/efi/memmap.c
> > @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> >       return PFN_PHYS(page_to_pfn(p));
> >  }
> >
> > +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > +{
> > +     if (flags & EFI_MEMMAP_MEMBLOCK) {
> > +             if (slab_is_available())
> > +                     memblock_free_late(phys, size);
> > +             else
> > +                     memblock_free(phys, size);
> > +     } else if (flags & EFI_MEMMAP_SLAB) {
> > +             struct page *p = pfn_to_page(PHYS_PFN(phys));
> > +             unsigned int order = get_order(size);
> > +
> > +             free_pages((unsigned long) page_address(p), order);
> > +     }
> > +}
> > +
> > +static void __init efi_memmap_free(void)
> > +{
> > +     __efi_memmap_free(efi.memmap.phys_map,
> > +                     efi.memmap.desc_size * efi.memmap.nr_map,
> > +                     efi.memmap.flags);
> > +}
> > +
> >  /**
> >   * efi_memmap_alloc - Allocate memory for the EFI memory map
> >   * @num_entries: Number of entries in the allocated map.
> > @@ -100,6 +122,8 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
> >               return -ENOMEM;
> >       }
> >
> > +     efi_memmap_free();
> > +
>
> This seems still not safe,  see below function:
> arch/x86/platform/efi/efi.c:
> static void __init efi_clean_memmap(void)
> It use same memmap for both old and new, and filter out those invalid
> ranges in place, if the memory is freed then ..

In the efi_clean_memmap() case flags are 0, so efi_memmap_free() is a nop.

Would you feel better with an explicit?

WARN_ON(efi.memmap.phys_map == data->phys_map && (data->flags &
(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK))

...not sure it's worth it.

>
> >       map.phys_map = data->phys_map;
> >       map.nr_map = data->size / data->desc_size;
> >       map.map_end = map.map + data->size;
> >
