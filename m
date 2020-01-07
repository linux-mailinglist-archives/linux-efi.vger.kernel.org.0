Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBF131F01
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 06:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgAGFSg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 00:18:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24120 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgAGFSf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 00:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578374314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+pMdW3YlNEjXyRDuZ2IYPHP1swSW2oY5Q3WONSeYK4=;
        b=EoOGQWVC8ehdBW6pr9d9vbdetnikhy3qtuf5XsDkjk+HStpOKSDym4XzOLCo7DvUesiJsC
        uZnmpKuGvWqNzrosSkkStqs+CCDbKJHHfrf/H9NWNdB5IpTwgSXsYJOxhNTWGSsw+SqUhv
        GqmMT6LlOBi+xIMPANZh9qOXttavfTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-FJfdGUOEPeCfwn242bSx9A-1; Tue, 07 Jan 2020 00:18:31 -0500
X-MC-Unique: FJfdGUOEPeCfwn242bSx9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF4A1800D4E;
        Tue,  7 Jan 2020 05:18:30 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7F541036D1B;
        Tue,  7 Jan 2020 05:18:26 +0000 (UTC)
Date:   Tue, 7 Jan 2020 13:18:22 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH v4 3/4] efi: Fix efi_memmap_alloc() leaks
Message-ID: <20200107051822.GB19080@dhcp-128-65.nay.redhat.com>
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835763783.1456824.4013634516855823659.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107035824.GA19080@dhcp-128-65.nay.redhat.com>
 <CAPcyv4jbf2WR2ZU55564fORxKLf8tGH1XbYBpRfTvPouGWk2mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jbf2WR2ZU55564fORxKLf8tGH1XbYBpRfTvPouGWk2mg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01/06/20 at 08:24pm, Dan Williams wrote:
> On Mon, Jan 6, 2020 at 7:58 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 01/06/20 at 04:40pm, Dan Williams wrote:
> > > With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> > > updated and replaced multiple times. When that happens a previous
> > > dynamically allocated efi memory map can be garbage collected. Use the
> > > new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> > > allocated memory map is being replaced.
> > >
> > > Debug statements in efi_memmap_free() reveal:
> > >
> > >  efi: __efi_memmap_free:37: phys: 0x23ffdd580 size: 2688 flags: 0x2
> > >  efi: __efi_memmap_free:37: phys: 0x9db00 size: 2640 flags: 0x2
> > >  efi: __efi_memmap_free:37: phys: 0x9e580 size: 2640 flags: 0x2
> > >
> > > ...a savings of 7968 bytes on a qemu boot with 2 entries specified to
> > > efi_fake_mem=.
> > >
> > > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> > > index 04dfa56b994b..bffa320d2f9a 100644
> > > --- a/drivers/firmware/efi/memmap.c
> > > +++ b/drivers/firmware/efi/memmap.c
> > > @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> > >       return PFN_PHYS(page_to_pfn(p));
> > >  }
> > >
> > > +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > > +{
> > > +     if (flags & EFI_MEMMAP_MEMBLOCK) {
> > > +             if (slab_is_available())
> > > +                     memblock_free_late(phys, size);
> > > +             else
> > > +                     memblock_free(phys, size);
> > > +     } else if (flags & EFI_MEMMAP_SLAB) {
> > > +             struct page *p = pfn_to_page(PHYS_PFN(phys));
> > > +             unsigned int order = get_order(size);
> > > +
> > > +             free_pages((unsigned long) page_address(p), order);
> > > +     }
> > > +}
> > > +
> > > +static void __init efi_memmap_free(void)
> > > +{
> > > +     __efi_memmap_free(efi.memmap.phys_map,
> > > +                     efi.memmap.desc_size * efi.memmap.nr_map,
> > > +                     efi.memmap.flags);
> > > +}
> > > +
> > >  /**
> > >   * efi_memmap_alloc - Allocate memory for the EFI memory map
> > >   * @num_entries: Number of entries in the allocated map.
> > > @@ -100,6 +122,8 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
> > >               return -ENOMEM;
> > >       }
> > >
> > > +     efi_memmap_free();
> > > +
> >
> > This seems still not safe,  see below function:
> > arch/x86/platform/efi/efi.c:
> > static void __init efi_clean_memmap(void)
> > It use same memmap for both old and new, and filter out those invalid
> > ranges in place, if the memory is freed then ..
> 
> In the efi_clean_memmap() case flags are 0, so efi_memmap_free() is a nop.
> 
> Would you feel better with an explicit?
> 
> WARN_ON(efi.memmap.phys_map == data->phys_map && (data->flags &
> (EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK))
> 
> ...not sure it's worth it.

Ah, yes, sorry I did not see the flags, although it is not very obvious.
Maybe add some code comment for efi_mem_alloc and efi_mem_init.

Let's defer the suggestion to Ard.

Thanks
Dave

